% Load HRTF data
ARIDataset = load('ReferenceHRTF.mat');
sampleRate = 48000; % this is the sampling rate of the HRTFs

% Reformat HRTF data
hrtfData = double(ARIDataset.hrtfData);
hrtfData = permute(hrtfData,[2,3,1]);

% Get list of positions (az, el)
sourcePosition = ARIDataset.sourcePosition(:,[1,2]);
sourcePosition(:,1) = sourcePosition(:,1) - 180;

% Desired azimuth angles, starting from -180 with a step of 22.5 degrees
azimuthAngles = [-180,-160,-135,-115,-90,-70,-45,-25,0,25,45,70,90,115,135,160];

% Define the desired elevation angle
el = 0;

for demo_num = 1:16
    % Load a sound and make it mono
    audio_filename = sprintf('Demo%d.wav', demo_num);
    [heli,originalSampleRate] = audioread(audio_filename);
    heli = 12*heli(:,1); % keep only one channel

    % Resample sound file to match HRTF
    heli = resample(heli,sampleRate,originalSampleRate);

    for az = azimuthAngles
        % Find the index for the specified azimuth angle and elevation
        index = find(sourcePosition(:,1) == az & sourcePosition(:,2) == el);

        % Get HRTFs
        myhrir = squeeze(hrtfData(index,:,:));

        % Make HRIR filtered sound
        leftsound = filter(myhrir(1,:),1,heli);
        rightsound = filter(myhrir(2,:),1,heli);

        % Save left and right audio channels as separate audio files
        output_left = sprintf('%dL%d.wav', demo_num, int32(az));
        output_right = sprintf('%dR%d.wav', demo_num, int32(az));
        audiowrite(output_left, leftsound, sampleRate);
        audiowrite(output_right, rightsound, sampleRate);
    end
end
