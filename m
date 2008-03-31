From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [patch]race between open and disconnect in usbhid
Date: Mon, 31 Mar 2008 15:23:50 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0803311522110.5541@jikos.suse.cz>
References: <200803311535.10067.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:49294 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754387AbYCaNXv (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 31 Mar 2008 09:23:51 -0400
In-Reply-To: <200803311535.10067.oliver@neukum.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-usb@vger.kernel.org, linux-input@vger.kernel.org

On Mon, 31 Mar 2008, Oliver Neukum wrote:

> There is a window:
> task A					task B
> spin_lock_irq(&usbhid->inlock);	/* Sync with error handler */
> usb_set_intfdata(intf, NULL);
> spin_unlock_irq(&usbhid->inlock);
> usb_kill_urb(usbhid->urbin);
> usb_kill_urb(usbhid->urbout);
> usb_kill_urb(usbhid->urbctrl);
> 
> del_timer_sync(&usbhid->io_retry);
> cancel_work_sync(&usbhid->reset_work);
> 
> 						if (!hid->open++) {
> 							res = usb_autopm_get_interface(usbhid->intf);
> 							if (res < 0) {
> 								hid->open--;
> 								return -EIO;
> 							}
> 						}
> 						if (hid_start_in(hid))
> 
> if (hid->claimed & HID_CLAIMED_INPUT)
> 	hidinput_disconnect(hid);
> in which an open() to an already disconnected device will submit an URB 
> to an undead device. In case disconnect() was called by an ioctl, 
> this'll oops. Fix by introducing a reliable flag an checking it in 
> hid_start_in().

Hi Oliver,

thanks for checking this, good catch.

> +	char disconnected:1;						/* indicates undead device - no use */

Wouldn't introduction of new flag (HID_DISCONNECTED) to 
usbhid_device->iofl be cleaner?

Thanks,

-- 
Jiri Kosina
SUSE Labs
