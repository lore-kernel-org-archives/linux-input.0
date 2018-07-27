From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: tablet: aiptek: Replace GFP_ATOMIC with
 GFP_KERNEL in aiptek_probe()
Date: Fri, 27 Jul 2018 11:35:37 -0700
Message-ID: <20180727183537.GD72640@dtor-ws>
References: <20180727022920.1233-1-baijiaju1990@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180727022920.1233-1-baijiaju1990@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jia-Ju Bai <baijiaju1990@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, Jul 27, 2018 at 10:29:20AM +0800, Jia-Ju Bai wrote:
> aiptek_probe() is never called in atomic context.
> It calls usb_alloc_coherent() with GFP_ATOMIC, which is not necessary.
> GFP_ATOMIC can be replaced with GFP_KERNEL.
> 
> This is found by a static analysis tool named DCNS written by myself.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>

Applied, thank you.

> ---
>  drivers/input/tablet/aiptek.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/tablet/aiptek.c b/drivers/input/tablet/aiptek.c
> index 545fa6e89035..c82cd5079d0e 100644
> --- a/drivers/input/tablet/aiptek.c
> +++ b/drivers/input/tablet/aiptek.c
> @@ -1712,7 +1712,7 @@ aiptek_probe(struct usb_interface *intf, const struct usb_device_id *id)
>          }
>  
>  	aiptek->data = usb_alloc_coherent(usbdev, AIPTEK_PACKET_LENGTH,
> -					  GFP_ATOMIC, &aiptek->data_dma);
> +					  GFP_KERNEL, &aiptek->data_dma);
>          if (!aiptek->data) {
>  		dev_warn(&intf->dev, "cannot allocate usb buffer\n");
>  		goto fail1;
> -- 
> 2.17.0
> 

-- 
Dmitry
