library(Biobase)
library(genefilter)
library(GSEABase)
library(Category)
library(e1071)
library(pROC)


mpcsv <- function (dset = "gse", chip = "hgu133a"){
	
	load(paste("/home/keqin/R/data/",dset,".RData",sep=""))
	load("/home/keqin/R/data/megs.RData")
	load("/home/keqin/R/data/c2gs.RData")
	load("/home/keqin/R/data/c2sgs.RData")
#	load("/home/keqin/R/data/ppint.RData")
	load(paste("/home/keqin/R/data/",dset,"/pat.RData",sep=""))
	
	pid <- featureNames(fpset)
	expdata <- exprs(fpset)
	zsdata<- expdata
	label = factor(la)

	las=la
	las[la==0]=1
	slabel<-factor(las)
	eenid<-mget(pid,eval(as.name(paste(chip,"ENTREZID",sep=""))))
	gzdata<-zsdata
	rownames(gzdata)=eenid
	gzdata=gzdata[!is.na(eenid),]
	mzdata=gzdata
	pid=pid[!is.na(eenid)]
	eenid<- rownames(gzdata)
	
	wtpa=which(sprg<0.01)
	tpa=names(sprg[wtpa])
	lps=abs(sgt[tpa])

calauc <- function(edata,dlabel,f=5){
	meanauc=c()
	tmauc=c()
	for(t in 1:100){
		cled=t(edata)
		dind=which(dlabel==-1)
		nind=which(dlabel==1)
		sanu=floor(table(dlabel)/f)
		teind=list()
		for( m in 1:(f-1)){
			sdind=sample(1:length(dind),sanu[1])
			snind=sample(1:length(nind),sanu[2])
			teind[[m]]=c(dind[sdind],nind[snind])
			dind=dind[-sdind]
			nind=nind[-snind]}
		teind[[f]]=c(dind,nind)
		auc=c()				
		for(n in 1:f){
			tind=teind[[n]]
			teset=cled[tind,]
			trset=cled[-tind,]
			trla = dlabel[-tind]
			tela = dlabel[tind]
			pmodel <- svm(trset, trla,cost = 100,gamma = 0.01,probability=TRUE)
			pred <- predict(pmodel, teset, probability=TRUE)
			auc[n]<-auc(tela,attr(pred,"probabilities")[,2])}				
		tmauc[t]=mean(auc)
		}
		meanauc=mean(tmauc)
	return(meanauc)
	}	

	cgm<-incidence(cgs)
	msub <- na.omit(match(eenid,colnames(cgm)))
	cgm1 <- cgm[,msub]
	msub <- na.omit(match(eenid,colnames(im)))
	msub=unique(msub)
	im1 <- im[,msub]
	dsub <- na.omit(match(colnames(im1),eenid))
	msdata = mzdata[dsub,]
	selectedRows = (rowSums(im1)>4)
	im2 = im1[selectedRows, ]
	ueid=unique(c(colnames(cgm1),colnames(im1)))
	dcgs=cgs[tpa]

	mclu<-list()
	fcmg<-list()
	fcms<-list()
	mscore<-c()
	mhts<-c()
	mfps<-c()
	for (i in 1:nrow(im2)){
		wh=which(im2[i,]==1)
		#rttsd=rtts[wh]
		da=t(msdata[wh,])
		cord=cor(da)
		cord[cord<0]=0
		clust.cor <- hclust(as.dist(1 - cord), method = "single")
		clt<-cutree(clust.cor,h=0.3)
		whc=which(c(table(clt))>2)
		clu=list()
		cl=length(whc)
		while(cl>0){
			for(j in 1:cl){
			clu[[j]]<-attr(clt[clt==whc[j]],"names")}
			cl=0}		
		while(length(clu)>0){
			mauc=c()
			for(k in 1:length(clu)){
				cgdata=mzdata[clu[[k]],]
				mauc[k]=calauc(cgdata,slabel)}			
			wcl=which(mauc>0.8)
			while(length(wcl)>0){
			clu=clu[wcl]
			mclu[[i]]=unlist(clu)
			shg<-list()
			shs<-list()
			sps<-list()			
			for (m in 1:length(wcl)){
				gn=clu[[m]]
				fparams <- GSEAKEGGHyperGParams(name="MGS",geneSetCollection=dcgs,geneIds = gn,universeGeneIds=ueid, pvalueCutoff=0.05, testDirection="over")		
				hyt=hyperGTest(fparams)									
				sre=summary(hyt)
				if(nrow(sre)>0){
					shg[[m]]=sre[,1]
					shs[[m]]=-log10(sre[,2])
					sps[[m]]=lps[shg[[m]]]}
					else{
					shg[[m]]=NA
					shs[[m]]=NA
					sps[[m]]=NA
					m=m+1}
			}
			hgs=na.omit(unlist(shg))			
			while(length(hgs)>0){
				hss=na.omit(unlist(shs))
				names(hss)=hgs
				fcms[[i]]=tapply(hss,hgs,max)
				fcmg[[i]]=names(fcms[[i]])
				fps=lps[fcmg[[i]]]
				mscore[i]= crossprod(fps,fcms[[i]])/length(fps)
				mhts[i]=mean(fcms[[i]])
				mfps[i]=mean(fps)
				hgs=c()
				}
			wcl=c()}
		clu=list()
		}			
	}	
	nl=length(mhts)
	nnul=sapply(fcmg,is.null)
#	save(i,lps,mscore,fcms,fcmg,file=paste("/home/keqin/R/data/",dset,"/mpcsv.RData",sep=""))
	mname=rownames(im2)
	names(mclu)=mname[1:length(mclu)]
	names(mscore)=names(mhts)=names(mfps)=names(fcmg) = names(fcms) = rownames(im2)[1:nl]
	mfcg=fcmg[!nnul]
	mfcs=fcms[!nnul]
	mscore=mscore[!nnul]
	mhts=mhts[!nnul]
	mfps=mfps[!nnul]

	save(lps,mclu,mscore,mhts,mfps,mfcg,mname,file=paste("/home/keqin/R/data/",dset,"/tgpcsv8.RData",sep=""))
	return(mscore)
}