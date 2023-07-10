function waveforms=load_waveforms(directory,wlen)
%here we work with raw waveforms
%For each daily waveform in the listed directory the process is
% 01. read the sac file - 02. Return structure with raw waveforms

%% 01. List all filenames in raw directory   
listing=dir(directory);
listing(ismember( {listing.name}, {'.', '..'})) = [];  %remove . and ..
%--------------------------------------------------------------------------
%                Preallocate memory                                       %
waveforms=struct('WAVEFORM',{},'DELTA',{},'NZYEAR',{}, ...
                    'NZJDAY',{}, 'NZHOUR', {}, 'NZMIN', {}, ...
                    'NZSEC', {}, 'NZMSEC',{},'KZDATE',{}, ...
                    'KZTIME',{}, 'KSTNM', {}, 'KCMPNM',{},...
                    'KNETWK', {});
%--------------------------------------------------------------------------
%% 02.  Save as structures
% Load each waveform and do preprocessing on the fly 
j=1;
for i=1:length(listing) %change to parfor
filename=sprintf('%s/%s',directory,listing(i).name);
[y,~,header]=rdsac(filename);    

%Here we check if the waveforms are 0ne day long
%If there are not wll not be saved and a message will be displayed
if length(y)<round(wlen/header.DELTA)
fprintf('Problem with station: %s.%s.%s. Cause: Data <1 day\n', header.KNETWK,header.KSTNM,header.KCMPNM);

else

%--------------------------------------------------------------------------
% Start preprocessing for waveforms

% Save as structure
waveforms(j)=struct('WAVEFORM',y(1:round(wlen/header.DELTA),1),'DELTA',header.DELTA,'NZYEAR',header.NZYEAR, ...
                    'NZJDAY',header.NZJDAY, 'NZHOUR', header.NZHOUR, 'NZMIN', header.NZMIN, ...
                    'NZSEC', header.NZSEC, 'NZMSEC',header.NZMSEC,'KZDATE',header.KZDATE, ...
                    'KZTIME',header.KZTIME, 'KSTNM', header.KSTNM, 'KCMPNM',header.KCMPNM,...
                    'KNETWK', header.KNETWK);
                j=j+1;
end
end


end