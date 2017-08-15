command to convert png images to mp4 using ffmpeg:

ffmpeg -r 60 -f image2 -s 300x300 -i tmp/hyperv1-2_%04d.png -crf 25 -pix_fmt yuv420p hyper_v1-2.mp4
