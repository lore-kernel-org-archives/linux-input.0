From: Hans Verkuil <hverkuil@xs4all.nl>
Subject: Re: [PATCH v4] add raw video stream support for Samsung SUR40
Date: Mon, 16 Mar 2015 09:59:45 +0100
Message-ID: <55069B81.9050300@xs4all.nl>
References: <1426490162-10646-1-git-send-email-floe@butterbrot.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <1426490162-10646-1-git-send-email-floe@butterbrot.org>
Sender: linux-media-owner@vger.kernel.org
To: Florian Echtler <floe@butterbrot.org>, m.chehab@samsung.com
Cc: laurent.pinchart@ideasonboard.com, linux-input@vger.kernel.org, linux-media@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 03/16/2015 08:16 AM, Florian Echtler wrote:
> This patch adds raw video support for the Samsung SUR40 using vbuf2-dma-sg.
> All tests from v4l2-compliance pass. Support for VB2_USERPTR is currently
> disabled due to unexpected interference with dma-sg buffer sizes.
> 
> Signed-off-by: Florian Echtler <floe@butterbrot.org>
> ---
>  drivers/input/touchscreen/Kconfig |   2 +
>  drivers/input/touchscreen/sur40.c | 429 ++++++++++++++++++++++++++++++++++++--
>  2 files changed, 419 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
> index 5891752..f8d16f1 100644
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
> @@ -953,7 +953,9 @@ config TOUCHSCREEN_SUN4I
>  config TOUCHSCREEN_SUR40
>  	tristate "Samsung SUR40 (Surface 2.0/PixelSense) touchscreen"
>  	depends on USB
> +	depends on MEDIA_USB_SUPPORT
>  	select INPUT_POLLDEV
> +	select VIDEOBUF2_DMA_SG
>  	help
>  	  Say Y here if you want support for the Samsung SUR40 touchscreen
>  	  (also known as Microsoft Surface 2.0 or Microsoft PixelSense).
> diff --git a/drivers/input/touchscreen/sur40.c b/drivers/input/touchscreen/sur40.c
> index f1cb051..d5f054b 100644
> --- a/drivers/input/touchscreen/sur40.c
> +++ b/drivers/input/touchscreen/sur40.c

....

> +
> +static const struct vb2_queue sur40_queue = {
> +	.type = V4L2_BUF_TYPE_VIDEO_CAPTURE,
> +	/*
> +	 * VB2_USERPTR is currently not enabled: dma-sg doesn't provide
> +	 * segment sizes of multiples of 512 bytes, which is required by
> +	 * the host controller for working USERPTR support.
> +	*/

I would rephrase this slightly:

VB2_USERPTR in currently not enabled: passing a user pointer to
dma-sg will result in segment sizes that are not a multiple of
512 bytes, which is required by the host controller.

If you post a v5 with that final change I'll make a pull request for you.

Thanks for this patch, it was an interesting learning experience trying
to figure out why USERPTR didn't work.

Regards,

	Hans
