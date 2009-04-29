From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [patch]fix possible deadlock in usbhid_close()
Date: Wed, 29 Apr 2009 17:25:51 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0904291725350.5012@wotan.suse.de>
References: <200904291712.13729.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:51305 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752503AbZD2PZw (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 29 Apr 2009 11:25:52 -0400
In-Reply-To: <200904291712.13729.oliver@neukum.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org

On Wed, 29 Apr 2009, Oliver Neukum wrote:

> This patch switches usbhid_close() from flush_scheduled_work() to canceling
> the outstanding work. This fixes a possible deadlock due to work taking
> the mutex usbhid_close() holds. Lockdep reported the problem.
> 
> Signed-off-by: Oliver Neukum <oliver@neukum.org>
> 
> --
> 
> --- a/drivers/hid/usbhid/hid-core.c
> +++ b/drivers/hid/usbhid/hid-core.c
> @@ -662,8 +662,8 @@ void usbhid_close(struct hid_device *hid)
>  	spin_lock_irq(&usbhid->lock);
>  	if (!--hid->open) {
>  		spin_unlock_irq(&usbhid->lock);
> +		hid_cancel_delayed_stuff(usbhid);
>  		usb_kill_urb(usbhid->urbin);
> -		flush_scheduled_work();
>  		usbhid->intf->needs_remote_wakeup = 0;
>  	} else {
>  		spin_unlock_irq(&usbhid->lock);

Applied, thanks Oliver.

-- 
Jiri Kosina
SUSE Labs
