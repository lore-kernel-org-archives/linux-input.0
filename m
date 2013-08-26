From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH v1 23/49] hid: usbhid: prepare for enabling irq in
 complete()
Date: Mon, 26 Aug 2013 13:44:32 +0200 (CEST)
Message-ID: <alpine.LRH.2.00.1308261344240.11387@twin.jikos.cz>
References: <1376756714-25479-1-git-send-email-ming.lei@canonical.com> <1376756714-25479-24-git-send-email-ming.lei@canonical.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:48674 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751529Ab3HZLoy (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 26 Aug 2013 07:44:54 -0400
In-Reply-To: <1376756714-25479-24-git-send-email-ming.lei@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ming Lei <ming.lei@canonical.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, Oliver Neukum <oliver@neukum.org>, Alan Stern <stern@rowland.harvard.edu>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org

On Sun, 18 Aug 2013, Ming Lei wrote:

> Complete() will be run with interrupt enabled, so change to
> spin_lock_irqsave().
> 
> Cc: Jiri Kosina <jkosina@suse.cz>
> Cc: linux-input@vger.kernel.org
> Signed-off-by: Ming Lei <ming.lei@canonical.com>

Acked-by: Jiri Kosina <jkosina@suse.cz>

> ---
>  drivers/hid/usbhid/hid-core.c |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
> index bd38cdf..2445fd6 100644
> --- a/drivers/hid/usbhid/hid-core.c
> +++ b/drivers/hid/usbhid/hid-core.c
> @@ -489,8 +489,9 @@ static void hid_ctrl(struct urb *urb)
>  	struct hid_device *hid = urb->context;
>  	struct usbhid_device *usbhid = hid->driver_data;
>  	int unplug = 0, status = urb->status;
> +	unsigned long flags;
>  
> -	spin_lock(&usbhid->lock);
> +	spin_lock_irqsave(&usbhid->lock, flags);
>  
>  	switch (status) {
>  	case 0:			/* success */
> @@ -525,7 +526,7 @@ static void hid_ctrl(struct urb *urb)
>  	}
>  
>  	clear_bit(HID_CTRL_RUNNING, &usbhid->iofl);
> -	spin_unlock(&usbhid->lock);
> +	spin_unlock_irqrestore(&usbhid->lock, flags);
>  	usb_autopm_put_interface_async(usbhid->intf);
>  	wake_up(&usbhid->wait);
>  }
> 

-- 
Jiri Kosina
SUSE Labs

