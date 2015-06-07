function [originalimg, compressedimg] = ssvdcompression(imgmatrix, rank)

originalimg = imgmatrix;
% imgmatrix needs to have a perfect square size (e.g.: 256x256)
% Shuffle the image matrix
shuffledimg = shuffleimg(imgmatrix);

% Apply the standard SVD compression
[~, compressedimg] = svdcompression(shuffledimg, rank);

% Apply the inverse shuffle to the image matrix
compressedimg = unshuffleimg(compressedimg);

end

function shuffledimg = shuffleimg(imgmatrix)

% Assuming that dim1 == dim2 and this value is a perfect square
% Also assuming that the image is a RGB image
% No error-checking
[dim1, dim2, dim3] = size(imgmatrix);

% Preallocating for performance
shuffledimg = zeros(dim1, dim2, dim3);

% Breaking the image in blocks of blocksize size
blocksize = sqrt(dim1);

for i = 1:blocksize
    for j = 1:blocksize
        for k = 1:dim3
            linearizedblock = imgmatrix((1:blocksize) + (i - 1)*blocksize, (1:blocksize) + (j - 1)*blocksize, k)';
            shuffledimg((i - 1)*blocksize + j, :, k) = reshape(linearizedblock, 1, dim1);
        end
    end
end
end

function unshuffledimg = unshuffleimg(imgmatrix)

% Assuming that dim1 == dim2 and this value is a perfect square
% Also assuming that the image is a RGB image
% No error-checking
[dim1, dim2, dim3] = size(imgmatrix);

% Preallocating for performance
unshuffledimg = im2uint8(zeros(dim1, dim2, dim3));

% Reorganizing the image in blocks of blocksize size
blocksize = sqrt(dim1);

for i = 1:blocksize
    for j = 1:blocksize
        for k = 1:dim3
            block = reshape(imgmatrix((i - 1)*blocksize + j, :, k), blocksize, blocksize);
            block = block';
            unshuffledimg((1:blocksize) + (i - 1)*blocksize, (1:blocksize) + (j - 1)*blocksize, k) = block;
        end
    end
end
end