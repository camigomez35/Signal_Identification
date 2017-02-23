function porcent = reconocedor(imagen)    
     fnames = dir('señales/*.jpg');
     numfids = length(fnames);
%      for i = 1 : length(fnames)
%         filename = strcat(pwd,'\señales\',fnames(i).name);
%         I = imread(filename);
%         figure, imshow(I);title(filename);
%      end
     pattern = imread(strcat(pwd,'\señales\',fnames(1).name));
     pattern = imresize(pattern, [200,200]);
     
     figure(5);imshow(pattern);
     porcent = matching(imagen, pattern);
 end


% function [a] = reconocedor(imagenes, n)
%     fnames = dir('señales/*.jpg');
%     numfids = length(fnames);
%     for i = 1:n
%         for K = 1:numfids
%             resta = imagenes(:,:,i)
%         end
%     end
%     
% end

