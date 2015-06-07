function [originalimg, compressedimg] = svdcompression(imgmatrix, rank)

% Since we are dealing with RGB images
% SVD for each channel
[U1, S1, V1] = svd(imgmatrix(:, :, 1));
[U2, S2, V2] = svd(imgmatrix(:, :, 2));
[U3, S3, V3] = svd(imgmatrix(:, :, 3));

% Compression of each channel
C1 = U1(:, 1:rank) * S1(1:rank, 1:rank) * V1(:, 1:rank)';
C2 = U2(:, 1:rank) * S2(1:rank, 1:rank) * V2(:, 1:rank)';
C3 = U3(:, 1:rank) * S3(1:rank, 1:rank) * V3(:, 1:rank)';

% Assemble the channels together
compressedimg(:, :, 1) = C1;
compressedimg(:, :, 2) = C2;
compressedimg(:, :, 3) = C3;

% Scale image's pixels
originalimg = scaleimg(imgmatrix);
compressedimg = scaleimg(compressedimg);

% Convert it back to uint8
originalimg = im2uint8(originalimg);
compressedimg = im2uint8(compressedimg);
end

function scaledimg = scaleimg(imgmatrix)

% Scale the pixels' values to [0, 1]
maxvalue = max(max(max(imgmatrix)));
scaledimg = imgmatrix / maxvalue;
end