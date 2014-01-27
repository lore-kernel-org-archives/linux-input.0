From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] USB: input: gtco.c: fix usb_dev leak
Date: Mon, 27 Jan 2014 12:24:47 -0800
Message-ID: <20140127202447.GA18489@core.coreip.homeip.net>
References: <1390853454-31749-1-git-send-email-khoroshilov@ispras.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:41729 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753763AbaA0UYv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 27 Jan 2014 15:24:51 -0500
Content-Disposition: inline
In-Reply-To: <1390853454-31749-1-git-send-email-khoroshilov@ispras.ru>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org

On Tue, Jan 28, 2014 at 12:10:54AM +0400, Alexey Khoroshilov wrote:
> There is usb_get_dev() in gtco_probe(), but there is no usb_put_dev()
> anywhere in the driver.
> 
> As pointed out by Dmitry Torokhov:
> The lifetime of gtco structure is already directly tied to lifetime of
> usb_dev: when destroying usb_dev driver core will call remove() function
> of currently bound driver (in our case gtco) which will destroy gtco
> memory. Taking additional reference is not needed here.
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>

Applied, thank you.

> ---
>  drivers/input/tablet/gtco.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/tablet/gtco.c b/drivers/input/tablet/gtco.c
> index caecffe8caff..858045694e9d 100644
> --- a/drivers/input/tablet/gtco.c
> +++ b/drivers/input/tablet/gtco.c
> @@ -848,7 +848,7 @@ static int gtco_probe(struct usb_interface *usbinterface,
>  	gtco->inputdevice = input_dev;
>  
>  	/* Save interface information */
> -	gtco->usbdev = usb_get_dev(interface_to_usbdev(usbinterface));
> +	gtco->usbdev = interface_to_usbdev(usbinterface);
>  	gtco->intf = usbinterface;
>  
>  	/* Allocate some data for incoming reports */
> -- 
> 1.8.3.2
> 

-- 
Dmitry
