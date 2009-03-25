From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [patch]fix lockup of hid on reset
Date: Wed, 25 Mar 2009 11:32:07 +0100 (CET)
Message-ID: <alpine.LNX.2.00.0903251131420.14346@wotan.suse.de>
References: <200903221801.49658.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:58667 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752242AbZCYKcK (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 25 Mar 2009 06:32:10 -0400
In-Reply-To: <200903221801.49658.oliver@neukum.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-usb@vger.kernel.org, linux-input@vger.kernel.org, Valdis Kletniks <Valdis.Kletnieks@vt.edu>

On Sun, 22 Mar 2009, Oliver Neukum wrote:

> This fixes a use of flush_scheduled_work() in USB HID's  reset logic that can 
> deadlock. It's against the next tree.
> 
> Signed-off-by: Oliver Neukum <oliver@neukum.name>
> Tested-by: Valdis Kletniks <Valdis.Kletnieks@vt.edu>
> 	Regards
> 		Oliver
> diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
> index bc017cd..4306cb1 100644
> --- a/drivers/hid/usbhid/hid-core.c
> +++ b/drivers/hid/usbhid/hid-core.c
> @@ -1210,7 +1210,6 @@ static void hid_cease_io(struct usbhid_device *usbhid)
>  	usb_kill_urb(usbhid->urbin);
>  	usb_kill_urb(usbhid->urbctrl);
>  	usb_kill_urb(usbhid->urbout);
> -	flush_scheduled_work();
>  }
>  
>  /* Treat USB reset pretty much the same as suspend/resume */
> @@ -1222,6 +1221,7 @@ static int hid_pre_reset(struct usb_interface *intf)
>  	spin_lock_irq(&usbhid->lock);
>  	set_bit(HID_RESET_PENDING, &usbhid->iofl);
>  	spin_unlock_irq(&usbhid->lock);
> +	cancel_work_sync(&usbhid->restart_work);
>  	hid_cease_io(usbhid);
>  
>  	return 0;

Applied to autosuspend branch, thanks a lot Oliver.

-- 
Jiri Kosina
SUSE Labs
