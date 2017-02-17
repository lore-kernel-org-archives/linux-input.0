From: Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH v3] xen,input: try to read screen resolution for
 xen-kbdfront
Date: Fri, 17 Feb 2017 10:08:58 +0100
Message-ID: <d5de4a65-2085-47e3-e57a-2b7a239ed8dd@suse.com>
References: <20170130151052.20296-1-jgross@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:37727 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755123AbdBQJJC (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 17 Feb 2017 04:09:02 -0500
In-Reply-To: <20170130151052.20296-1-jgross@suse.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, xen-devel@lists.xenproject.org, dmitry.torokhov@gmail.com

On 30/01/17 16:10, Juergen Gross wrote:
> Instead of using the default resolution of 800*600 for the pointing
> device of xen-kbdfront try to read the resolution of the (virtual)
> framebuffer device. Use the default as fallback only.
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>

Dmitry, any comment from you?

In case you don't object I can carry this patch through the Xen tree.


Juergen

> ---
> V3: add case of late framebuffer registration (Oleksandr Andrushchenko)
> V2: get framebuffer resolution only if CONFIG_FB (Dmitry Torokhov)
> ---
>  drivers/input/misc/xen-kbdfront.c | 46 ++++++++++++++++++++++++++++++++++++---
>  1 file changed, 43 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/input/misc/xen-kbdfront.c b/drivers/input/misc/xen-kbdfront.c
> index 3900875..9a20800 100644
> --- a/drivers/input/misc/xen-kbdfront.c
> +++ b/drivers/input/misc/xen-kbdfront.c
> @@ -16,6 +16,7 @@
>  #include <linux/kernel.h>
>  #include <linux/errno.h>
>  #include <linux/module.h>
> +#include <linux/fb.h>
>  #include <linux/input.h>
>  #include <linux/slab.h>
>  
> @@ -39,6 +40,9 @@ struct xenkbd_info {
>  	int irq;
>  	struct xenbus_device *xbdev;
>  	char phys[32];
> +#ifdef CONFIG_FB_NOTIFY
> +	struct notifier_block nb;
> +#endif
>  };
>  
>  static int xenkbd_remove(struct xenbus_device *);
> @@ -105,10 +109,29 @@ static irqreturn_t input_handler(int rq, void *dev_id)
>  	return IRQ_HANDLED;
>  }
>  
> +#ifdef CONFIG_FB
> +#ifdef CONFIG_FB_NOTIFY
> +static int xenkbd_fb_event(struct notifier_block *self,
> +			   unsigned long action, void *data)
> +{
> +	struct xenkbd_info *info = container_of(self, struct xenkbd_info, nb);
> +	struct fb_info *fb = registered_fb[0];
> +
> +	if (action != FB_EVENT_FB_REGISTERED || !fb)
> +		return 0;
> +
> +	input_set_abs_params(info->ptr, ABS_X, 0, fb->var.xres_virtual, 0, 0);
> +	input_set_abs_params(info->ptr, ABS_Y, 0, fb->var.yres_virtual, 0, 0);
> +
> +	return 0;
> +}
> +#endif
> +#endif
> +
>  static int xenkbd_probe(struct xenbus_device *dev,
>  				  const struct xenbus_device_id *id)
>  {
> -	int ret, i;
> +	int ret, i, width, height;
>  	unsigned int abs;
>  	struct xenkbd_info *info;
>  	struct input_dev *kbd, *ptr;
> @@ -173,9 +196,22 @@ static int xenkbd_probe(struct xenbus_device *dev,
>  	ptr->id.product = 0xfffe;
>  
>  	if (abs) {
> +		width = XENFB_WIDTH;
> +		height = XENFB_HEIGHT;
> +#ifdef CONFIG_FB
> +		if (registered_fb[0]) {
> +			width = registered_fb[0]->var.xres_virtual;
> +			height = registered_fb[0]->var.yres_virtual;
> +		} else {
> +#ifdef CONFIG_FB_NOTIFY
> +			info->nb.notifier_call = xenkbd_fb_event;
> +			fb_register_client(&info->nb);
> +#endif
> +		}
> +#endif
>  		__set_bit(EV_ABS, ptr->evbit);
> -		input_set_abs_params(ptr, ABS_X, 0, XENFB_WIDTH, 0, 0);
> -		input_set_abs_params(ptr, ABS_Y, 0, XENFB_HEIGHT, 0, 0);
> +		input_set_abs_params(ptr, ABS_X, 0, width, 0, 0);
> +		input_set_abs_params(ptr, ABS_Y, 0, height, 0, 0);
>  	} else {
>  		input_set_capability(ptr, EV_REL, REL_X);
>  		input_set_capability(ptr, EV_REL, REL_Y);
> @@ -222,6 +258,10 @@ static int xenkbd_remove(struct xenbus_device *dev)
>  	struct xenkbd_info *info = dev_get_drvdata(&dev->dev);
>  
>  	xenkbd_disconnect_backend(info);
> +#ifdef CONFIG_FB_NOTIFY
> +	if (info->nb.notifier_call)
> +		fb_unregister_client(&info->nb);
> +#endif
>  	if (info->kbd)
>  		input_unregister_device(info->kbd);
>  	if (info->ptr)
> 

