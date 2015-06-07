clear
% Enter image file name
filename = input('Enter the file name: ', 's');

% Read the image
cd Images;
imgmatrix = imread(filename);
imgmatrix = im2double(imgmatrix, 'indexed');
cd ..;

[dim1, ~, ~] = size(imgmatrix);
% Read the desired rank
rank = input('Enter the desired rank: ');
while (rank > dim1 || rank <= 0)
    fprintf('Rank must be between 1 and %d (inclusive)\n', dim1)
    rank = input('Enter the desired rank: ');
end

% Apply the standard SVD compression to the image
[originalimg, svdcompressedimg] = svdcompression(imgmatrix, rank);

% Apply the SSVD compression to the image
[~, ssvdcompressedimg] = ssvdcompression(imgmatrix, rank);

% Plot original image
figure('Name', strcat(filename, ' - Original'),'NumberTitle','off')
imagesc(originalimg)

% Plot svd compressed image
figure('Name', strcat(filename, ' - Standard SVD Compression -', sprintf(' Rank = %d', rank)),'NumberTitle','off')
imagesc(svdcompressedimg)

% Plot ssvd compressed image
figure('Name', strcat(filename, ' - SSVD Compression -', sprintf(' Rank = %d', rank)),'NumberTitle','off')
imagesc(ssvdcompressedimg)