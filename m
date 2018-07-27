From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: misc: keyspan_remote: Replace GFP_ATOMIC with
 GFP_KERNEL in keyspan_probe()
Date: Fri, 27 Jul 2018 11:33:17 -0700
Message-ID: <20180727183317.GB72640@dtor-ws>
References: <20180727021258.29675-1-baijiaju1990@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180727021258.29675-1-baijiaju1990@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jia-Ju Bai <baijiaju1990@gmail.com>
Cc: arvind.yadav.cs@gmail.com, gregkh@linuxfoundation.org, pombredanne@nexb.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, Jul 27, 2018 at 10:12:58AM +0800, Jia-Ju Bai wrote:
> keyspan_probe() is never called in atomic context.
> It calls usb_alloc_coherent() with GFP_ATOMIC, which is not necessary.
> GFP_ATOMIC can be replace with GFP_KERNEL.
> 
> This is found by a static analysis tool named DCNS written by myself.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>

Applied, thank you.

> ---
>  drivers/input/misc/keyspan_remote.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/misc/keyspan_remote.c b/drivers/input/misc/keyspan_remote.c
> index 67482b248b2d..a8937ceac66a 100644
> --- a/drivers/input/misc/keyspan_remote.c
> +++ b/drivers/input/misc/keyspan_remote.c
> @@ -466,7 +466,7 @@ static int keyspan_probe(struct usb_interface *interface, const struct usb_devic
>  	remote->in_endpoint = endpoint;
>  	remote->toggle = -1;	/* Set to -1 so we will always not match the toggle from the first remote message. */
>  
> -	remote->in_buffer = usb_alloc_coherent(udev, RECV_SIZE, GFP_ATOMIC, &remote->in_dma);
> +	remote->in_buffer = usb_alloc_coherent(udev, RECV_SIZE, GFP_KERNEL, &remote->in_dma);
>  	if (!remote->in_buffer) {
>  		error = -ENOMEM;
>  		goto fail1;
> -- 
> 2.17.0
> 

-- 
Dmitry
