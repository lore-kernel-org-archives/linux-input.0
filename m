From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: possible race between reset and error handling in usbhid
Date: Thu, 13 Oct 2011 18:20:52 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1110131819500.14768@pobox.suse.cz>
References: <201110121614.23410.oneukum@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:36382 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756018Ab1JMQUx (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 13 Oct 2011 12:20:53 -0400
In-Reply-To: <201110121614.23410.oneukum@suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oneukum@suse.de>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org

On Wed, 12 Oct 2011, Oliver Neukum wrote:

> looking at the usbhid code it seems to me that there is no protection
> between the error handling code and pre_reset() racing.
> 
> In particular there seems to be no protection from hid_retry_timeout() calling
> hid_start_in() which would start IO after hid_pre_reset() has already called
> hid_cease_io() because that uses del_timer(), not del_timer_sync()
> 
> What do you think about this patch?

Looks like you made a good catch, thanks. Out of curiosity -- did you 
encounter this happening for real, or have you find out by code reading?

> 
> 	Regards
> 		Oliver
> 
> From d13b3b42669cfbed3716d040cc8ce489fecd6963 Mon Sep 17 00:00:00 2001
> From: Oliver Neukum <oliver@neukum.org>
> Date: Wed, 12 Oct 2011 10:54:54 +0200
> Subject: [PATCH] USB: usbhid: cancel timer for retry synchronously
> 
> This makes sure IO is never restarted while a reset is going on
> 
> Signed-off-by: Oliver Neukum <oneukum@suse.de>
> ---
>  drivers/hid/usbhid/hid-core.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
> index ad978f5..77e705c 100644
> --- a/drivers/hid/usbhid/hid-core.c
> +++ b/drivers/hid/usbhid/hid-core.c
> @@ -1270,7 +1270,7 @@ static void hid_cancel_delayed_stuff(struct usbhid_device *usbhid)
>  
>  static void hid_cease_io(struct usbhid_device *usbhid)
>  {
> -	del_timer(&usbhid->io_retry);
> +	del_timer_sync(&usbhid->io_retry);
>  	usb_kill_urb(usbhid->urbin);
>  	usb_kill_urb(usbhid->urbctrl);
>  	usb_kill_urb(usbhid->urbout);

Will queue this up. Thanks again,

-- 
Jiri Kosina
SUSE Labs
