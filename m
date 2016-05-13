From: Hans Verkuil <hverkuil@xs4all.nl>
Subject: Re: [PATCH 1/3] properly report a single frame rate of 60 FPS
Date: Fri, 13 May 2016 20:53:24 +0200
Message-ID: <573622A4.3020602@xs4all.nl>
References: <1463164906-6273-1-git-send-email-floe@butterbrot.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from lb3-smtp-cloud6.xs4all.net ([194.109.24.31]:51171 "EHLO
	lb3-smtp-cloud6.xs4all.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753060AbcEMSxb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 13 May 2016 14:53:31 -0400
In-Reply-To: <1463164906-6273-1-git-send-email-floe@butterbrot.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Florian Echtler <floe@butterbrot.org>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Cc: Martin Kaltenbrunner <modin@yuri.at>

On 05/13/2016 08:41 PM, Florian Echtler wrote:
> The device hardware is always running at 60 FPS, so report this both via
> PARM_IOCTL and ENUM_FRAMEINTERVALS.

Florian, can you post these three patches to linux-media as well? These are all V4L2 related
so they should be reviewed there.

By posting to linux-media these pathes will automatically turn up in patchwork, that way
they won't be forgotten.

Regards,

	Hans

> 
> Signed-off-by: Martin Kaltenbrunner <modin@yuri.at>
> Signed-off-by: Florian Echtler <floe@butterbrot.org>
> ---
>  drivers/input/touchscreen/sur40.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/sur40.c b/drivers/input/touchscreen/sur40.c
> index 880c40b..fcc5934 100644
> --- a/drivers/input/touchscreen/sur40.c
> +++ b/drivers/input/touchscreen/sur40.c
> @@ -788,6 +788,16 @@ static int sur40_vidioc_fmt(struct file *file, void *priv,
>  	return 0;
>  }
>  
> +static int sur40_ioctl_parm(struct file *file, void *priv,
> +			    struct v4l2_streamparm *p)
> +{
> +	if (p->type == V4L2_BUF_TYPE_VIDEO_CAPTURE) {
> +		p->parm.capture.timeperframe.numerator = 1;
> +		p->parm.capture.timeperframe.denominator = 60;
> +	}
> +	return 0;
> +}
> +
>  static int sur40_vidioc_enum_fmt(struct file *file, void *priv,
>  				 struct v4l2_fmtdesc *f)
>  {
> @@ -814,13 +824,13 @@ static int sur40_vidioc_enum_framesizes(struct file *file, void *priv,
>  static int sur40_vidioc_enum_frameintervals(struct file *file, void *priv,
>  					    struct v4l2_frmivalenum *f)
>  {
> -	if ((f->index > 1) || (f->pixel_format != V4L2_PIX_FMT_GREY)
> +	if ((f->index > 0) || (f->pixel_format != V4L2_PIX_FMT_GREY)
>  		|| (f->width  != sur40_video_format.width)
>  		|| (f->height != sur40_video_format.height))
>  			return -EINVAL;
>  
>  	f->type = V4L2_FRMIVAL_TYPE_DISCRETE;
> -	f->discrete.denominator  = 60/(f->index+1);
> +	f->discrete.denominator  = 60;
>  	f->discrete.numerator = 1;
>  	return 0;
>  }
> @@ -880,6 +890,9 @@ static const struct v4l2_ioctl_ops sur40_video_ioctl_ops = {
>  	.vidioc_enum_framesizes = sur40_vidioc_enum_framesizes,
>  	.vidioc_enum_frameintervals = sur40_vidioc_enum_frameintervals,
>  
> +	.vidioc_g_parm = sur40_ioctl_parm,
> +	.vidioc_s_parm = sur40_ioctl_parm,
> +
>  	.vidioc_enum_input	= sur40_vidioc_enum_input,
>  	.vidioc_g_input		= sur40_vidioc_g_input,
>  	.vidioc_s_input		= sur40_vidioc_s_input,
> 
