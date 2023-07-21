angles = [0, 25, 45, 70, 90, 115, 135, 160, -180, -160, -135, -115, -90, -70, -45, -25];
samplesR = cell(1, length(angles));
samplesL = cell(1, length(angles));
for i = 1:length(angles)
    [samplesR{i}, FS] = audioread(sprintf('%dR%d.wav', i, angles(i)));
end
for j = 1:length(angles)
    [samplesL{j}, FS] = audioread(sprintf('%dL%d.wav', j, angles(j)));
end
% Initialize a vector with the same size as the first sample
right = zeros(size(samplesR{1}));
left = zeros(size(samplesL{1}));
% Add the samples one by one
for i = 1:length(samplesR)
    right = right + samplesR{i};
end
for j = 1:length(samplesL)
    left = left + samplesL{j};
end
outputR = 'R1.wav';
outputL = 'L1.wav';
audiowrite(outputR, right, FS);
audiowrite(outputL, left, FS);
