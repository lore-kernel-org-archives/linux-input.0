From: Marcus Folkesson <marcus.folkesson@gmail.com>
Subject: Re: [PATCH] Input: pxrc - fix leak of usb_device
Date: Sat, 14 Jul 2018 10:09:20 +0200
Message-ID: <20180714080920.GA15123@gmail.com>
References: <1531512477-31981-1-git-send-email-khoroshilov@ispras.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1531512477-31981-1-git-send-email-khoroshilov@ispras.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
List-Id: linux-input@vger.kernel.org

Hi Alexey,

Good catch!

On Fri, Jul 13, 2018 at 11:07:57PM +0300, Alexey Khoroshilov wrote:
> pxrc_probe() calls usb_get_dev(), but there is no usb_put_dev()
> anywhere in the driver.
> 
> The patch adds one to error handling code and to pxrc_disconnect().
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>

Reviewed-by: Marcus Folkesson <marcus.folkesson@gmail.com>

> ---
>  drivers/input/joystick/pxrc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/input/joystick/pxrc.c b/drivers/input/joystick/pxrc.c
> index 07a0dbd3ced2..0a31de63ac8e 100644
> --- a/drivers/input/joystick/pxrc.c
> +++ b/drivers/input/joystick/pxrc.c
> @@ -221,6 +221,7 @@ static int pxrc_probe(struct usb_interface *intf,
>  	usb_free_urb(pxrc->urb);
>  
>  error:
> +	usb_put_dev(pxrc->udev);
>  	return retval;
>  }
>  
> @@ -229,6 +230,7 @@ static void pxrc_disconnect(struct usb_interface *intf)
>  	struct pxrc *pxrc = usb_get_intfdata(intf);
>  
>  	usb_free_urb(pxrc->urb);
> +	usb_put_dev(pxrc->udev);
>  	usb_set_intfdata(intf, NULL);
>  }
>  
> -- 
> 2.7.4
> 
