#!/bin/bash
# Demo GStreamer Sample Application for RTSP Streaming to Kinesis Video Streams
# To be run inside the Docker container 

# Start the demo rtsp application to send video streams
./kinesis_video_gstreamer_sample_rtsp_app $RTSP_URL $KINESIS_STREAM_NAME
