From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: pxrc - do not store USB device in private struct
Date: Tue, 24 Jul 2018 02:38:04 +0000
Message-ID: <20180724023804.6mnbstzdrcp74rev@penguin>
References: <20180716144014.6331-1-marcus.folkesson@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180716144014.6331-1-marcus.folkesson@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Alexey Khoroshilov <khoroshilov@ispras.ru>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Marcus,

On Mon, Jul 16, 2018 at 04:40:14PM +0200, Marcus Folkesson wrote:
> The USB device is only needed during setup, so put it back after
> initialization and do not store it in our private struct.
> 
> Also, the USB device is a parent of USB interface so our driver
> model rules ensure that USB device should not disappear while
> interface device is still there.
> So not keep a refcount on the device is safe.
> 
> Reported-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> ---
>  drivers/input/joystick/pxrc.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/input/joystick/pxrc.c b/drivers/input/joystick/pxrc.c
> index 07a0dbd3ced2..46a7acb747bf 100644
> --- a/drivers/input/joystick/pxrc.c
> +++ b/drivers/input/joystick/pxrc.c
...

> @@ -204,23 +204,25 @@ static int pxrc_probe(struct usb_interface *intf,
>  		return -ENOMEM;
>  
>  	mutex_init(&pxrc->pm_mutex);
> -	pxrc->udev = usb_get_dev(interface_to_usbdev(intf));
> +	udev = usb_get_dev(interface_to_usbdev(intf));

There is really no need to "get" device for the probe duration, or in
general, when you are not storing the reference to it.

I posted series with an updated version of this patch plus couple more
cleanups/fixes, and would appreciate if you could give it a spin.

Thanks.

-- 
Dmitry
