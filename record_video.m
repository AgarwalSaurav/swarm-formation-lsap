
file_name = 'rec2UNCC_Line.avi';
uncompressedVideo = VideoWriter(file_name, 'Uncompressed AVI');
uncompressedVideo.FrameRate = 50;
open(uncompressedVideo);
writeVideo(uncompressedVideo, F);
close(uncompressedVideo);

file_name = 'UNCC2ICRA_Line.avi';
uncompressedVideo = VideoWriter(file_name, 'Uncompressed AVI');
uncompressedVideo.FrameRate = 50;
open(uncompressedVideo);
writeVideo(uncompressedVideo, G);
close(uncompressedVideo);
