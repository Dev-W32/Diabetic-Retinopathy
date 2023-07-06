%EVALDIARETDB0 Evaluates the diabetic retinopathy images
%   EVALDIARETDB0 compares the ouput text files produced by the algorithm 
%   to the groundtruth files
%   
%   EVALDIARETDB0(evalFilePath, groundtruthPath)
%
%Parameters:
%
%  evalFilePath                     A string to result text files
%      				     >> evalFilePath ='../example_evalresults/';
%
%  groundtruthPath                   A string to groundtruth files
%			             >> groundtruthPath = '../images/diaretdb0_groundtruths/'
%
%
%Author(s):
%   Tomi Kauppi <tomi.kauppi@lut.fi>
%
%Copyright:
%
%   This function is Copyright (C) 2006 by Tomi Kauppi, Lappeenranta
%   University of Technology, Finland.
%
function [result data] = EVALDIARETDB0(evalFilePath, groundtruthPath)

filestruct = dir([evalFilePath '*.res']);
evalfiles = char(filestruct.name);

filestruct = dir([groundtruthPath '*.dot']);
groundfiles = char(filestruct.name);

redSmallDot_tp = 0;
redSmallDot_tn = 0;
redSmallDot_fn = 0;
redSmallDot_fp = 0;

haemorrhage_tp = 0;
haemorrhage_tn = 0;
haemorrhage_fn = 0;
haemorrhage_fp = 0;

hardexudate_tp = 0;
hardexudate_tn = 0;
hardexudate_fn = 0;
hardexudate_fp = 0;

softexudate_tp = 0;
softexudate_tn = 0;
softexudate_fn = 0;
softexudate_fp = 0;

exudate_tp = 0;
exudate_tn = 0;
exudate_fn = 0;
exudate_fp = 0;

neovascularization_tp = 0;
neovascularization_tn = 0;
neovascularization_fn = 0;
neovascularization_fp = 0;


for i = 1:size(groundfiles,1)
	evalfiles(i,:);
	groundfiles(i,:);
	fid1 = fopen([groundtruthPath groundfiles(i,:)]);
	groundinfo = textscan(fid1, '%s %s %s %s %s');
	fid2 = fopen([deblank(evalFilePath) deblank(evalfiles(i,:))]);
	evalinfo = textscan(fid2, '%s %s %s %s %s');
	fclose(fid1);
	fclose(fid2);
%%REDSMALLDOTS
 	if strcmp(groundinfo{1}, 'redsmalldots') == 1 && strcmp(evalinfo{1}, 'redsmalldots') == 1
		redSmallDot_tp = redSmallDot_tp +1;
		data.r_tp(i) = 1;
	else
		data.t_tp(i) = 0;
	end
	if strcmp(groundinfo{1}, 'redsmalldots') == 1 && strcmp(evalinfo{1}, 'n/a') == 1
		redSmallDot_fn = redSmallDot_fn +1;
		data.r_fn(i) = 1;
	else
		data.t_fn(i) = 0;
	end
	if strcmp(groundinfo{1}, 'n/a') == 1 && strcmp(evalinfo{1}, 'redsmalldots') == 1
		redSmallDot_fp = redSmallDot_fp +1;
		data.r_fp(i) = 1;
	else
		data.t_fp(i) = 0;
	end
	if strcmp(groundinfo{1}, 'n/a') == 1 && strcmp(evalinfo{1}, 'n/a') == 1
		redSmallDot_tn = redSmallDot_tn +1;
		data.r_tn(i) = 1;
	else
		data.t_tn(i) = 0;

	end
%%HAEMORRHAGES

 	if strcmp(groundinfo{2}, 'hemorrhages') == 1 && strcmp(evalinfo{2}, 'hemorrhages') == 1
		haemorrhage_tp = haemorrhage_tp +1;
		data.he_tp(i) = 1;
	else
		data.he_tp(i) = 0;
	end
	if strcmp(groundinfo{2}, 'hemorrhages') == 1 && strcmp(evalinfo{2}, 'n/a') == 1
		haemorrhage_fn = haemorrhage_fn +1;
		data.he_fn(i) = 1;
	else
		data.he_fn(i) = 0;
	end
	if strcmp(groundinfo{2}, 'n/a') == 1 && strcmp(evalinfo{2}, 'hemorrhages') == 1
		haemorrhage_fp = haemorrhage_fp +1;
		data.he_fp(i) = 1;
	else
		data.he_fp(i) = 0;
	end
	if strcmp(groundinfo{2}, 'n/a') == 1 && strcmp(evalinfo{2}, 'n/a') == 1
		haemorrhage_tn = haemorrhage_tn +1;
		data.he_tn(i) = 1;
	else
		data.he_tn(i) = 0;
	end
%%HARDEXUDATES

 	if strcmp(groundinfo{3}, 'hardexudates') == 1 && strcmp(evalinfo{3}, 'hardexudates') == 1
		hardexudate_tp = hardexudate_tp +1;
		data.ha_tp(i) = 1;
	else
		data.ha_tp(i) = 0;
	end
	if strcmp(groundinfo{3}, 'hardexudates') == 1 && strcmp(evalinfo{3}, 'n/a') == 1
		hardexudate_fn = hardexudate_fn +1;
		data.ha_fn(i) = 1;
	else
		data.ha_fn(i) = 0;
	end
	if strcmp(groundinfo{3}, 'n/a') == 1 && strcmp(evalinfo{3}, 'hardexudates') == 1
		hardexudate_fp = hardexudate_fp +1;
		data.ha_fp(i) = 1;
	else
		data.ha_fp(i) = 0;
	end
	if strcmp(groundinfo{3}, 'n/a') == 1 && strcmp(evalinfo{3}, 'n/a') == 1
		hardexudate_tn = hardexudate_tn +1;
		data.ha_tn(i) = 1;
	else
		data.ha_tn(i) = 0;
	end

%%SOFTEXUDATES
 	if strcmp(groundinfo{4}, 'softexudates') == 1 && strcmp(evalinfo{4}, 'softexudates') == 1
		softexudate_tp = softexudate_tp +1;
		data.so_tp(i) = 1;
	else
		data.so_tp(i) = 0;
	end
	if strcmp(groundinfo{4}, 'softexudates') == 1 && strcmp(evalinfo{4}, 'n/a') == 1
		softexudate_fn = softexudate_fn +1;
		data.so_fn(i) = 1;
	else
		data.so_fn(i) = 0;
	end
	if strcmp(groundinfo{4}, 'n/a') == 1 && strcmp(evalinfo{4}, 'softexudates') == 1
		softexudate_fp = softexudate_fp +1;
		data.so_fp(i) = 1;
	else
		data.so_fp(i) = 0;
	end
	if strcmp(groundinfo{4}, 'n/a') == 1 && strcmp(evalinfo{4}, 'n/a') == 1
		softexudate_tn = softexudate_tn +1;
		data.so_tn(i) = 1;
	else
		data.so_tn(i) = 0;
	end

%%Neovascularization
 	if strcmp(groundinfo{5}, 'neovascularisation') == 1 && strcmp(evalinfo{5}, 'neovascularisation') == 1
		neovascularization_tp = neovascularization_tp +1;
	end
	if strcmp(groundinfo{5}, 'neovascularisation') == 1 && strcmp(evalinfo{5}, 'n/a') == 1
		neovascularization_fn = neovascularization_fn +1;
	end
	if strcmp(groundinfo{5}, 'n/a') == 1 && strcmp(evalinfo{5}, 'neovascularisation') == 1
		neovascularization_fp = neovascularization_fp +1;
	end
	if strcmp(groundinfo{5}, 'n/a') == 1 && strcmp(evalinfo{5}, 'n/a') == 1
		neovascularization_tn = neovascularization_tn +1;
	end

%allexudates
 	if ((strcmp(deblank(groundinfo{3}), 'hardexudates') == 1)  || (strcmp(deblank(groundinfo{4}), 'softexudates') == 1))  &&  ((strcmp(deblank(evalinfo{3}), 'hardexudates') == 1)  || (strcmp(deblank(evalinfo{4}), 'softexudates') == 1 ))
		exudate_tp = exudate_tp +1;
		data.e_tp(i) = 1;
	else
		data.e_tp(i) = 0;
	end
	if ((strcmp(deblank(groundinfo{3}), 'hardexudates') == 1) || (strcmp(deblank(groundinfo{4}), 'softexudates') == 1)) && ( strcmp(deblank(evalinfo{3}), 'n/a') == 1 )
		exudate_fn = exudate_fn +1;
		data.e_fn(i) = 1;
	else
		data.e_fn(i) = 0;
	end
	if ((strcmp(deblank(groundinfo{3}), 'n/a') == 1) && (strcmp(deblank(groundinfo{4}), 'n/a') == 1)) && (strcmp(deblank(evalinfo{3}), 'hardexudates') == 1 )
		exudate_fp = exudate_fp +1;
		data.e_fp(i) = 1;
	else
		data.e_fp(i) = 0;
	end
	if ((strcmp(deblank(groundinfo{3}), 'n/a') == 1) && (strcmp(deblank(groundinfo{4}), 'n/a') == 1)) && (strcmp(deblank(evalinfo{3}), 'n/a') == 1 )
		exudate_tn = exudate_tn +1;
		data.e_tn(i) = 1;
	else
		data.e_tn(i) = 0;
	end


end

result.sensitivityExudate = exudate_tp/(exudate_tp+exudate_fn);
result.specificityExudate = exudate_tn/(exudate_tn+exudate_fp);
result.sensitivityhardExudate = hardexudate_tp/(hardexudate_tp+hardexudate_fn);
result.specificityhardExudate = hardexudate_tn/(hardexudate_tn+hardexudate_fp);
result.sensitivitysoftExudate = softexudate_tp/(softexudate_tp+softexudate_fn);
result.specificitysoftExudate = softexudate_tn/(softexudate_tn+softexudate_fp);
result.sensitivityRedSmallDot = redSmallDot_tp/(redSmallDot_tp+redSmallDot_fn);
result.specificityRedSmallDot = redSmallDot_tn/(redSmallDot_tn+redSmallDot_fp);
result.sensitivityHaemorrhage = haemorrhage_tp/(haemorrhage_tp+haemorrhage_fn);
result.specificityHaemorrhage = haemorrhage_tn/(haemorrhage_tn+haemorrhage_fp);
result.sensitivityNeovascularization = neovascularization_tp/(neovascularization_tp+neovascularization_fn);
result.specificityNeovascularization = neovascularization_tn/(neovascularization_tn+neovascularization_fp);
