% Scan CK+ database and Generate SIGNATURES
PATH = 'C:\DB\CK+\Emotion\';
FILES = dir([PATH,'**\*.txt']);

%lmrk = [18,20,22,23,25,27,37,38,41,40,43,44,47,46,32,34,36,49,55,52,58];
%lmrk = 1:2:68;   
leyebrow = 18:22;
reyebrow = 23:27;
leye = 37:42;
reye = 43:48;
nose = 31:36;
mouth = 49:68;
overall = [18,20,22,23,25,27,37,38,41,40,43,44,47,46,32,34,36,49,55,52,58];
%lmrk = {leyebrow,reyebrow,leye,reye,nose,mouth,overall};

% Fuzzy Tringel Sinature
%FTS = zeros(length(FILES),lenT,5);
% Centroid Distance Signature
%CDS = zeros(length(FILES),lenT,6);
% Angel Signature
TSS_leyebrow = zeros(length(FILES),nchoosek(length(leyebrow),3),11);
TSS_reyebrow = zeros(length(FILES),nchoosek(length(reyebrow),3),11);
TSS_leye = zeros(length(FILES),nchoosek(length(leye),3),11);
TSS_reye = zeros(length(FILES),nchoosek(length(reye),3),11);
TSS_nose = zeros(length(FILES),nchoosek(length(nose),3),11);
TSS_mouth = zeros(length(FILES),nchoosek(length(mouth),3),11);
TSS_overall = zeros(length(FILES),nchoosek(length(overall),3),11);

% no of images --> length(FILES)
% no of tringels --> lenT
% no of fuzzy measures --> 5

EMO = zeros(length(FILES),1);

h = waitbar(0,'Please wait computing Signatures ...');

for i = 1:length(FILES)
    disp(i)
    
    name = FILES(i).name;
    folder = FILES(i).folder;
    foldername = [folder,'\',name];
    EMO(i) = dlmread(foldername);
    
    endpath = strrep(name(1:8),'_','\');
    fullpath = strrep([PATH,endpath,'\'],'Emotion',...
                      'Landmarks');
    
    files = dir([fullpath,'*.txt']);
    
    name = files(end).name;
    folder = files(end).folder;
    foldername = [folder,'\',name];
    
    points = dlmread(foldername);
    
    TSS_leyebrow(i,:,:) = triangle_side_signature(points(leyebrow,:));
    TSS_reyebrow(i,:,:) = triangle_side_signature(points(reyebrow,:));
    TSS_leye(i,:,:) = triangle_side_signature(points(leye,:));
    TSS_reye(i,:,:) = triangle_side_signature(points(reye,:));
    TSS_nose(i,:,:) = triangle_side_signature(points(nose,:));
    TSS_mouth(i,:,:) = triangle_side_signature(points(mouth,:));
    TSS_overall(i,:,:) = triangle_side_signature(points(overall,:));
    
    
    waitbar(i / length(FILES))
    
end

close(h)

TSS = {TSS_leyebrow,TSS_reyebrow,TSS_leye,...
    TSS_reye,TSS_nose,TSS_mouth,TSS_overall};

%STAT2 = cell2mat(STAT);
TSS2 = cell2mat(TSS);
%TSS3 = [TSS2,STAT2];
    


I = eye(7);
EMO2 = I(EMO,:); 

%TSS = real(TSS);
        
        