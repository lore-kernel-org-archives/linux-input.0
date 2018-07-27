From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: misc: yealink: Replace GFP_ATOMIC with GFP_KERNEL
 in usb_probe()
Date: Fri, 27 Jul 2018 11:35:55 -0700
Message-ID: <20180727183555.GE72640@dtor-ws>
References: <20180727022007.883-1-baijiaju1990@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180727022007.883-1-baijiaju1990@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jia-Ju Bai <baijiaju1990@gmail.com>
Cc: Henk.Vergonet@gmail.com, usbb2k-api-dev@nongnu.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, Jul 27, 2018 at 10:20:07AM +0800, Jia-Ju Bai wrote:
> usb_probe() is never called in atomic context.
> It calls usb_alloc_coherent() with GFP_ATOMIC, which is not necessary.
> GFP_ATOMIC can be replaced with GFP_KERNEL.
> 
> This is found by a static analysis tool named DCNS written by myself.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>

Applied, thank you.

> ---
>  drivers/input/misc/yealink.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/misc/yealink.c b/drivers/input/misc/yealink.c
> index f0c9bf87b4e3..1365cd94ed9b 100644
> --- a/drivers/input/misc/yealink.c
> +++ b/drivers/input/misc/yealink.c
> @@ -894,12 +894,12 @@ static int usb_probe(struct usb_interface *intf, const struct usb_device_id *id)
>  
>  	/* allocate usb buffers */
>  	yld->irq_data = usb_alloc_coherent(udev, USB_PKT_LEN,
> -					   GFP_ATOMIC, &yld->irq_dma);
> +					   GFP_KERNEL, &yld->irq_dma);
>  	if (yld->irq_data == NULL)
>  		return usb_cleanup(yld, -ENOMEM);
>  
>  	yld->ctl_data = usb_alloc_coherent(udev, USB_PKT_LEN,
> -					   GFP_ATOMIC, &yld->ctl_dma);
> +					   GFP_KERNEL, &yld->ctl_dma);
>  	if (!yld->ctl_data)
>  		return usb_cleanup(yld, -ENOMEM);
>  
> -- 
> 2.17.0
> 

-- 
Dmitry
