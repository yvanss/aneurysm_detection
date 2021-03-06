%%
%Initialize variables
clear all
clc
diary off
filename{1}='CA1';NoOfAneurysm{1}=2;scale{1}=0.6;
filename{2}='CA2';NoOfAneurysm{2}=2;scale{2}=0.4;
filename{3}='CA3';NoOfAneurysm{3}=2;scale{3}=0.6;
filename{4}='CA4';NoOfAneurysm{4}=3;scale{4}=0.3;
filename{5}='CA5';NoOfAneurysm{5}=1;scale{5}=0.6;

HierarchyHieght=15;
NeighbourhoodDepth=1;
peakDepth=3;
k=3;
C=0.55;
%%
% diary on
% diary('.\htmlR\log.txt')

% CA file number
ca=str2num(input('Enter CA file number [1,2,3,4,5] : ','s'));
    
    
    f=filename{ca};
    
    f2=[f '.dcm']
    
    disp('Executing Autothresholding......');
    tic
    [pt pic ]=AutoThreshold(f2); %threshold pic & original pic
    toc
    imshow(pt)
    title([filename{ca},': Auto-Threshold Image']);
    %         imwrite(pic,['.\htmlR\CA' num2str(ca) 'Original.png']);
    %         imwrite(pt,['.\htmlR\CA' num2str(ca) 'Threshold.png'])
    
    h=HierarchyHieght;
    
    
    disp('Generating Circle Hierarchy.....');
    tic
    ph=genCircleHierarchy(pt,h); %pic of circle hierarchy
    toc
    
    neighbour=NeighbourhoodDepth;
    peak=peakDepth;
    
    disp('Treking the mountain range......');
    tic
    [b barr nReg]=treking(ph,neighbour,peak);
    toc
    handle=createmeshfigure(ph);
    title([filename{ca},': Hough Hierarchy']);
%     saveas(handle,['./htmlR/CA' num2str(ca) 'Hierarchy'],'png')
%     snapnow;close;
    %  para_comp{ca}=0;
    %  for para=1:1:100
    %     if(rem(para,10)==0)
    %        para
    %     end
    %     C=para/100;
    
    disp(['Scaling Factor : ' num2str(scale{ca})]);

    [selReg,data,s]=Detect(barr,nReg,k,C,scale{ca},0);
    nos=round((data*100))/100;
    disp(s);disp(num2str(nos));
    
% Detected regions
    ps1=superimpose(pic,barr,nReg);
%     imwrite(ps1,['./htmlR/CA' num2str(ca) 'MultiDetect.png'])
    figure;imshow(ps1)
    title([filename{ca},': Detected Regions']);
    %         snapnow;
    %             close

% Aneurysm regions
    [ps2 im_reg]=superimpose(pic,barr,selReg);
%     imwrite(ps2,['./htmlR/CA' num2str(ca) 'FullDetect.png'])
    figure;imshow(ps2)
    title([filename{ca},': Aneurysm Regions']);
    %         snapnow;
    %             close
    
%   sensitivity, specificity & Accuracy evaluation
    [match_percentage sensitivity specificity]=Accuracy(f,im_reg,barr,selReg,nReg,NoOfAneurysm{ca})
    %         para_comp{ca}(para,1)=sensitivity;
    %         para_comp{ca}(para,2)=specificity;
    %         para_comp{ca}(para,3)=match_percentage;
    %
    %     end
    %     matrix2Latex(round(data*100)/100,['.\htmlR\CA' num2str(ca) 'table.txt'])

% diary off
beep

%%
