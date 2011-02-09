From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/1] Fix error path in wacom_probe
Date: Wed, 9 Feb 2011 00:50:07 -0800
Message-ID: <20110209085007.GC7256@core.coreip.homeip.net>
References: <1297237048-32714-1-git-send-email-strakh@ispras.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:64463 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753111Ab1BIIuO (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 9 Feb 2011 03:50:14 -0500
Content-Disposition: inline
In-Reply-To: <1297237048-32714-1-git-send-email-strakh@ispras.ru>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alexander Strakh <cromlehg@gmail.com>
Cc: rydberg@euromail.se, oneukum@suse.de, oblivian@users.sourceforge.net, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Alexander Strakh <strakh@ispras.ru>

On Wed, Feb 09, 2011 at 10:37:28AM +0300, Alexander Strakh wrote:
> From: Alexander Strakh <cromlehg@gmail.com>
> 
>   In file drivers/input/tablet/wacom_sys.c in
> wacom_probe after error we can goto label2. In
>  this case function usb_free was not called. 
>  It will be right goto for the label tail3.
> 
>         wacom->irq = usb_alloc_urb(0, GFP_KERNEL);
> 
> 	...
> 
>         /* Retrieve the physical and logical size for OEM devices */
>         error = wacom_retrieve_hid_descriptor(intf, features);
>         if (error)
>                 goto fail2;
> 	...
> 	 fail3: usb_free_urb(wacom->irq);
> 	 fail2: usb_free_coherent(dev, WACOM_PKGLEN_MAX, wacom_wac->data, wacom->data_dma);
> 
> Replaced wrong transition.
> 
> Signed-off-by: Alexander Strakh <strakh@ispras.ru>

Will apply, thank you.

> ---
>  drivers/input/tablet/wacom_sys.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/input/tablet/wacom_sys.c b/drivers/input/tablet/wacom_sys.c
> index fc38149..cf8fb9f 100644
> --- a/drivers/input/tablet/wacom_sys.c
> +++ b/drivers/input/tablet/wacom_sys.c
> @@ -519,7 +519,7 @@ static int wacom_probe(struct usb_interface *intf, const struct usb_device_id *i
>  	/* Retrieve the physical and logical size for OEM devices */
>  	error = wacom_retrieve_hid_descriptor(intf, features);
>  	if (error)
> -		goto fail2;
> +		goto fail3;
>  
>  	wacom_setup_device_quirks(features);
>  
> -- 
> 1.7.1
> 

-- 
Dmitry
