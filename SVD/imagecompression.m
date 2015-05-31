clear
% Enter image file name
filename = input('Enter the file name: ', 's');

% Read the image
A = imread(filename);
A = im2double(A, 'indexed');

[dim1, ~, ~] = size(A);
% Read the desired rank
rank = input('Enter the desired rank: ');
while (rank > dim1 || rank <= 0)
    fprintf('Rank must be between 1 and %d\n', dim1)
    rank = input('Enter the desired rank: ');
end

% Since we are dealing with RGB images
% SVD for each channel
[U1, S1, V1] = svd(A(:, :, 1));
[U2, S2, V2] = svd(A(:, :, 2));
[U3, S3, V3] = svd(A(:, :, 3));

% Compression of each channel
C1 = U1(:, 1:rank) * S1(1:rank, 1:rank) * V1(:, 1:rank)';
C2 = U2(:, 1:rank) * S2(1:rank, 1:rank) * V2(:, 1:rank)';
C3 = U3(:, 1:rank) * S3(1:rank, 1:rank) * V3(:, 1:rank)';

% Assemble the channels together
C(:, :, 1) = C1;
C(:, :, 2) = C2;
C(:, :, 3) = C3;

% Scale the pixels' values to [0, 1]
Amax = max(max(max(A)));
A = A / Amax;
Cmax = max(max(max(C)));
C = C / Cmax;

% Convert it back to uint8
A = im2uint8(A);
C = im2uint8(C);

% Plot original image
figure(1)
imagesc(A)

% Plot compressed image
figure(2)
imagesc(C)