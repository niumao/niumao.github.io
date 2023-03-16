---
title: FFMPEG Tech
date: 2023-03-17 00:43:49
categories:
tags:
description: media tools ffmpeg brief note
---
使用:
author：Fabrice Bellard（QEMU）法布里 贝拉
compile：git clone https://gitffmpeg.org/ffmpeg.git &; config --help & make && make install
pipeline：输入文件->demuxer->编码数据包->decoder->解码后数据帧[filter]->encoder->编码数据报->muxer->输出文件
collect：ffmpeg -f avfoundation -i :0 out.wav && ffplay out.wav 
AAC：ffpmeg -i xxx.mp4 -vn -c:a libfdk _aac -ar 44100 -channels 2 -profile:a aac_he_v2 out.aac
screencast：ffmpeg -f alsa -i 1 -r 30 out.yuv
record：ffmpeg -f alsa -i :1 out.wav
分解复用：媒体文件转换，音视频分开合并。输入文件->demuxer->编码数据包->muxer->输出文件
cmd：ffmpeg -i in.mp4 -vcodec copy[-vn] -acodec copy[-an] out.flv[.h264|.aac] 
yuv：ffmpeg -i input.mp4 -an -c:v rawvideo -pix_fmt yuv420p out.yuv & ffplay -s xx*yy out.yuv
pcm：ffmpeg -i input.mp4 -vn -ar 44100 -ac 2 -f s16le out.pcm & ffplay -ar 44100 -ac 2 -f s16le out.pcm
filter：ffmpeg -i input.mov -vf crop=in_w-200:in_h-200 -c:v libx264 -c:a copy out.mp4
cut：ffmpeg -i input.mp4 -ss 00:00:10 -t 10 out.ts
combine：ffmpeg -f concat -i inputs.txt out.flv
picture：ffmpeg -i input.flv -r 1 -f image2 image-%3d.jpeg | ffmpeg -i image-%3d.jpeg out.mp4


开发：
log：<libavutil/log.h>    av_log_set_level(AV_LOG_DEBUG)  av_log(NULL, AV_LOG_INFO, "", op)
文件操作：avpriv_io_delete() avpriv_io_move()
文件内容操作：avio_open_dir()/av_read_dir()/avio_free_directory_entry/avio_close_dir()  AVIODirContext AVIODirEntry 
多媒体文件：含有很多由不同编码器编码的流（Stream/Track）的容器
包：流中的数据，一般包含一个或多个帧。
结构体：AVFormatContext AVStream AVPacket
操作：解复用->获取流->读取数据包->释放资源
多媒体操作：av_register_all() + avformat_open_input()/avformat_close_input()
注册:avdevice_register_all() 
打开：alsa/avfoundation/dshow(linux/mac/windows)   av_find_input_format() avformat_open_input() /avformat_close_input() av_strerror() 
读取：av_read_frame()/av_packet_unref   av_packet_alloc/av_packet_free 
保存：av_samples_alloc_array_and_samples()(输入输出) 
重采样：swr_alloc_set_opts() srw_init swr_convert() swr_free() 
相关结构体：AVformatContext   AVPacket（data，size） 
SwrConte编码过程：avcodec_find_encoder/avcodec_find_decoder_by_name创建编码器->avcodec_alloc-context3创建上下文->avcodec_open2打开编辑器->av_frame_get_buffer/avcodec_send_frame/avcodec_receive_packet传输数据给编码器->编码->释放资源 
meta信息：av_dump_format()
音频信息：av_init_packet()+av_find_best_stream()+av_read_frame()/av_packet_unref() 
格式转换：avformat_alloc_output_context2()/avformat_free_context() + avformat_new_stream() + avcodec_parameters_copy()
avformat_write_header() + av_write_frame()/av_interleaved_write_frame() + av_write_trailers()
截取：av_seek_frame()
H264,AAC编解码
头文件：libavcodec/avcodec.h
结构体：AVCodec AVCodecContext(avcodec_alloc_context3()/avcodec_free_context()) AVFrame(av_frame_alloc()/av_frame_free())
解码：avcodec_find_decoder() + avcodec_open2() + avcodec_decode_video2()
编码：avcodec_find_encoder_by_name() + avcodec_open2() + avcodec_encode_video2()
编码：avcodec_encodec_audio2()
常用库：libfdk-aac,libaac,libx264,libx265,libvpx(VP8,VP9),libaom(AV1)
