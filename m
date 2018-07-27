From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: misc: powermate: Replace GFP_ATOMIC with
 GFP_KERNEL in powermate_alloc_buffers()
Date: Fri, 27 Jul 2018 11:33:37 -0700
Message-ID: <20180727183337.GC72640@dtor-ws>
References: <20180727021723.709-1-baijiaju1990@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180727021723.709-1-baijiaju1990@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jia-Ju Bai <baijiaju1990@gmail.com>
Cc: arvind.yadav.cs@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, Jul 27, 2018 at 10:17:23AM +0800, Jia-Ju Bai wrote:
> powermate_alloc_buffers() is never called in atomic context.
> It calls usb_alloc_coherent() with GFP_ATOMIC, which is not necessary.
> GFP_ATOMIC can be replaced with GFP_KERNEL.
> 
> This is found by a static analysis tool named DCNS written by myself.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>

Applied, thank you.

> ---
>  drivers/input/misc/powermate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/misc/powermate.c b/drivers/input/misc/powermate.c
> index 5c8c79623c87..e8de3aaf9f63 100644
> --- a/drivers/input/misc/powermate.c
> +++ b/drivers/input/misc/powermate.c
> @@ -277,7 +277,7 @@ static int powermate_input_event(struct input_dev *dev, unsigned int type, unsig
>  static int powermate_alloc_buffers(struct usb_device *udev, struct powermate_device *pm)
>  {
>  	pm->data = usb_alloc_coherent(udev, POWERMATE_PAYLOAD_SIZE_MAX,
> -				      GFP_ATOMIC, &pm->data_dma);
> +				      GFP_KERNEL, &pm->data_dma);
>  	if (!pm->data)
>  		return -1;
>  
> -- 
> 2.17.0
> 

-- 
Dmitry
