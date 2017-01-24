From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] xen,input: try to read screen resolution for xen-kbdfront
Date: Tue, 24 Jan 2017 10:47:50 -0800
Message-ID: <20170124184750.GG27969@dtor-ws>
References: <20170124120955.24898-1-jgross@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170124120955.24898-1-jgross@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Juergen Gross <jgross@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, xen-devel@lists.xenproject.org, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, Jan 24, 2017 at 01:09:55PM +0100, Juergen Gross wrote:
> Instead of using the default resolution of 800*600 for the pointing
> device of xen-kbdfront try to read the resolution of the (virtual)
> framebuffer device. Use the default as fallback only.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
>  drivers/input/misc/xen-kbdfront.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/input/misc/xen-kbdfront.c b/drivers/input/misc/xen-kbdfront.c
> index 3900875..0032c81 100644
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
> @@ -108,10 +109,11 @@ static irqreturn_t input_handler(int rq, void *dev_id)
>  static int xenkbd_probe(struct xenbus_device *dev,
>  				  const struct xenbus_device_id *id)
>  {
> -	int ret, i;
> +	int ret, i, width, height;
>  	unsigned int abs;
>  	struct xenkbd_info *info;
>  	struct input_dev *kbd, *ptr;
> +	struct fb_info *fb0;
>  
>  	info = kzalloc(sizeof(*info), GFP_KERNEL);
>  	if (!info) {
> @@ -173,9 +175,16 @@ static int xenkbd_probe(struct xenbus_device *dev,
>  	ptr->id.product = 0xfffe;
>  
>  	if (abs) {
> +		width = XENFB_WIDTH;
> +		height = XENFB_HEIGHT;
> +		fb0 = registered_fb[0];

This will break if !CONFIG_FBi I think. While i see that xen.config has
it on I wonder if it is still possible to turn it off (either randconfig
or intentionally).

Thanks.

-- 
Dmitry
