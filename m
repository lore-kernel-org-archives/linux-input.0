From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: mouse: appletouch: Replace GFP_ATOMIC with
 GFP_KERNEL
Date: Fri, 27 Jul 2018 11:36:03 -0700
Message-ID: <20180727183603.GF72640@dtor-ws>
References: <20180727022618.1007-1-baijiaju1990@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180727022618.1007-1-baijiaju1990@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jia-Ju Bai <baijiaju1990@gmail.com>
Cc: gustavo@embeddedor.com, arvind.yadav.cs@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, Jul 27, 2018 at 10:26:18AM +0800, Jia-Ju Bai wrote:
> atp_open(), atp_recover() and atp_resume() are never 
> called in atomic context.
> They call usb_submit_urb() with GFP_ATOMIC, which is not necessary.
> GFP_ATOMIC can be replaced with GFP_KERNEL.
> 
> This is found by a static analysis tool named DCNS written by myself.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>

Applied, thank you.

> ---
>  drivers/input/mouse/appletouch.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/input/mouse/appletouch.c b/drivers/input/mouse/appletouch.c
> index 032d27983b6c..f593ec96c95f 100644
> --- a/drivers/input/mouse/appletouch.c
> +++ b/drivers/input/mouse/appletouch.c
> @@ -810,7 +810,7 @@ static int atp_open(struct input_dev *input)
>  {
>  	struct atp *dev = input_get_drvdata(input);
>  
> -	if (usb_submit_urb(dev->urb, GFP_ATOMIC))
> +	if (usb_submit_urb(dev->urb, GFP_KERNEL))
>  		return -EIO;
>  
>  	dev->open = true;
> @@ -976,7 +976,7 @@ static int atp_recover(struct atp *dev)
>  	if (error)
>  		return error;
>  
> -	if (dev->open && usb_submit_urb(dev->urb, GFP_ATOMIC))
> +	if (dev->open && usb_submit_urb(dev->urb, GFP_KERNEL))
>  		return -EIO;
>  
>  	return 0;
> @@ -994,7 +994,7 @@ static int atp_resume(struct usb_interface *iface)
>  {
>  	struct atp *dev = usb_get_intfdata(iface);
>  
> -	if (dev->open && usb_submit_urb(dev->urb, GFP_ATOMIC))
> +	if (dev->open && usb_submit_urb(dev->urb, GFP_KERNEL))
>  		return -EIO;
>  
>  	return 0;
> -- 
> 2.17.0
> 

-- 
Dmitry
