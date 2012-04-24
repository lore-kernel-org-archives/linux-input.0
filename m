From: Oliver Neukum <oneukum@suse.de>
Subject: Re: [PATCH] hid: usbhid: fix possible deadlock in __usbhid_submit_report
Date: Tue, 24 Apr 2012 16:22:08 +0200
Message-ID: <201204241622.08411.oneukum@suse.de>
References: <CACVXFVNAZHC2uQCwRak6pRgT1VEgRJt5UTuwAtZM6r_Xdg0dHA@mail.gmail.com> <Pine.LNX.4.44L0.1204231121200.1612-100000@iolanthe.rowland.org> <CACVXFVNhPKbFZN5AjT3BNdNP+3bZP7miJZrBEER97scMR5nNAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:38862 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754381Ab2DXO0L (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 24 Apr 2012 10:26:11 -0400
In-Reply-To: <CACVXFVNhPKbFZN5AjT3BNdNP+3bZP7miJZrBEER97scMR5nNAQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ming Lei <ming.lei@canonical.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Kosina <jkosina@suse.cz>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, stable@vger.kernel.org

Am Dienstag, 24. April 2012, 06:19:00 schrieb Ming Lei:

> @@ -486,11 +494,15 @@ static void hid_ctrl(struct urb *urb)
> 
>  	if (usbhid->ctrlhead != usbhid->ctrltail && !hid_submit_ctrl(hid)) {
>  		/* Successfully submitted next urb in queue */
> +		if (status != -ECONNRESET)
> +			spin_unlock(&usbhid->unlink_lock);
>  		spin_unlock(&usbhid->lock);
>  		return;
>  	}
> 
>  	clear_bit(HID_CTRL_RUNNING, &usbhid->iofl);
> +	if (status != -ECONNRESET)
> +		spin_unlock(&usbhid->unlink_lock);
>  	spin_unlock(&usbhid->lock);
>  	usb_autopm_put_interface_async(usbhid->intf);
>  	wake_up(&usbhid->wait);

Now you race against a double time out

CPU A								CPU B

__usbhid_submit_report()
time_after()
usb_unlink_urb()
-- this has to go to the hardware -->
									hid_irq_out()
									if (status != -ECONNRESET)
									--> no lock
									hid_submit_out()
__usbhid_submit_report()
time_after()
									usb_submit_urb()
usb_unlink_urb()


> @@ -546,8 +558,13 @@ static void __usbhid_submit_report(struct
> hid_device *hid, struct hid_report *re
>  			 * no race because this is called under
>  			 * spinlock
>  			 */
> -			if (time_after(jiffies, usbhid->last_out + HZ * 5))
> +			spin_lock(&usbhid->unlink_lock);
> +			if (time_after(jiffies, usbhid->last_out + HZ * 5)) {
> +				spin_unlock(&usbhid->lock);
>  				usb_unlink_urb(usbhid->urbout);
> +				spin_lock(&usbhid->lock);
> +			}
> +			spin_unlock(&usbhid->unlink_lock);

AB-BA deadlock

	Regards
		Oliver
