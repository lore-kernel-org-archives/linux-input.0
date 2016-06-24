From: Nick Dyer <nick.dyer@itdev.co.uk>
Subject: Re: [PATCH v5 1/9] [media] v4l2-core: Add support for touch devices
Date: Fri, 24 Jun 2016 14:48:14 +0100
Message-ID: <1c9fda7b-441b-0110-bd10-b1b654e016de@itdev.co.uk>
References: <1466633313-15339-1-git-send-email-nick.dyer@itdev.co.uk>
 <1466633313-15339-2-git-send-email-nick.dyer@itdev.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1466633313-15339-2-git-send-email-nick.dyer@itdev.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hans Verkuil <hverkuil@xs4all.nl>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Benson Leung <bleung@chromium.org>, Alan Bowens <Alan.Bowens@atmel.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Chris Healy <cphealy@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, Andrew Duggan <aduggan@synaptics.com>, James Chen <james.chen@emc.com.tw>, Dudley Du <dudl@cypress.com>, Andrew de los Reyes <adlr@chromium.org>, sheckylin@chromium.org, Peter Hutterer <peter.hutterer@who-t.net>, Florian Echtler <floe@butterbrot.org>, mchehab@osg.samsung.com
List-Id: linux-input@vger.kernel.org



On 22/06/2016 23:08, Nick Dyer wrote:
> Some touch controllers send out touch data in a similar way to a
> greyscale frame grabber.
> 
> Use a new device prefix v4l-touch for these devices, to stop generic
> capture software from treating them as webcams.
> 
> Add formats:
> - V4L2_TCH_FMT_DELTA_TD16 for signed 16-bit touch deltas
> - V4L2_TCH_FMT_DELTA_TD08 for signed 16-bit touch deltas
> - V4L2_TCH_FMT_TU16 for unsigned 16-bit touch data
> - V4L2_TCH_FMT_TU08 for unsigned 8-bit touch data
> 
> This support will be used by:
> * Atmel maXTouch (atmel_mxt_ts)
> * Synaptics RMI4.
> * sur40
> 
> Signed-off-by: Nick Dyer <nick.dyer@itdev.co.uk>
> ---
[...]
> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
> index 8f95191..7e19782 100644
> --- a/include/uapi/linux/videodev2.h
> +++ b/include/uapi/linux/videodev2.h
> @@ -143,6 +143,7 @@ enum v4l2_buf_type {
>  	V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE  = 10,
>  	V4L2_BUF_TYPE_SDR_CAPTURE          = 11,
>  	V4L2_BUF_TYPE_SDR_OUTPUT           = 12,
> +	V4L2_BUF_TYPE_TOUCH_CAPTURE        = 13,
>  	/* Deprecated, do not use */
>  	V4L2_BUF_TYPE_PRIVATE              = 0x80,
>  };
> @@ -440,6 +441,8 @@ struct v4l2_capability {
>  #define V4L2_CAP_ASYNCIO                0x02000000  /* async I/O */
>  #define V4L2_CAP_STREAMING              0x04000000  /* streaming I/O ioctls */
>  
> +#define V4L2_CAP_TOUCH			0x00100000  /* Is a touch device */

Apologies, this should have been
#define V4L2_CAP_TOUCH                 0x10000000

You will find my changes to v4l2-compliance to support these changes here:
https://github.com/ndyer/v4l-utils

I've tested the atmel_mxt_ts version of this with v4l2-compliance on Pixel 2.
