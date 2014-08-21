From: Johan Hovold <johan@kernel.org>
Subject: Re: USB reset xhci_hcd for ELAN touchscreen
Date: Thu, 21 Aug 2014 12:54:07 +0200
Message-ID: <20140821105407.GF24090@localhost>
References: <874n047rre.fsf@nemi.mork.no>
 <Pine.LNX.4.44L0.1406011203140.16904-100000@netrider.rowland.org>
 <20140601174321.GA29188@kroah.com>
 <20140707092442.GF29098@localhost>
 <20140708053430.GA840@kroah.com>
 <20140709130733.GA10078@localhost>
 <20140714182526.GA12963@localhost>
 <alpine.LNX.2.00.1408200817330.23162@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f41.google.com ([209.85.215.41]:59949 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753646AbaHUKz3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 21 Aug 2014 06:55:29 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1408200817330.23162@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Johan Hovold <johan@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, =?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>, Sarah Sharp <sarah.a.sharp@linux.intel.com>, Drew Von Spreecken <drewvs@gmail.com>, linux-usb@vger.kernel.org, Mathias Nyman <mathias.nyman@intel.com>, linux-input@vger.kernel.org

On Wed, Aug 20, 2014 at 08:20:43AM -0500, Jiri Kosina wrote:
> On Mon, 14 Jul 2014, Johan Hovold wrote:
> 
> > From 8101c0dfd42a232f1d2872de4f412d8d61d5646f Mon Sep 17 00:00:00 2001
> > From: Johan Hovold <johan@kernel.org>
> > Date: Mon, 14 Jul 2014 18:43:31 +0200
> > Subject: [PATCH] HID: usbhid: add HID_QUIRK_IN
> > 
> > Add quirk to submit the interrupt-in urb already at start() rather than
> > at open().
> > 
> > This is needed for devices that disconnects from the bus unless the
> > interrupt endpoint has been polled at least once or when not responding
> > to input events.
> 
> It's not really super-nice, but if no other way around it has been found 
> to be possible in USB core, I am willing to take this.

Agreed, it's not that nice, but I'm not aware of any other way to
prevent the device firmware from disconnecting.

Autosuspend still seems to work, so it would not cause much overhead
for people not actually using the touchscreen (as long as autosuspend
is enabled) either.
 
> > ---
> >  drivers/hid/usbhid/hid-core.c | 26 +++++++++++++++++++++++---
> >  include/linux/hid.h           |  1 +
> >  2 files changed, 24 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
> > index 7b88f4c..4b5d986 100644
> > --- a/drivers/hid/usbhid/hid-core.c
> > +++ b/drivers/hid/usbhid/hid-core.c
> > @@ -82,7 +82,7 @@ static int hid_start_in(struct hid_device *hid)
> >  	struct usbhid_device *usbhid = hid->driver_data;
> >  
> >  	spin_lock_irqsave(&usbhid->lock, flags);
> > -	if (hid->open > 0 &&
> > +	if ((hid->open > 0 || hid->quirks & HID_QUIRK_IN) &&
> >  			!test_bit(HID_DISCONNECTED, &usbhid->iofl) &&
> >  			!test_bit(HID_SUSPENDED, &usbhid->iofl) &&
> >  			!test_and_set_bit(HID_IN_RUNNING, &usbhid->iofl)) {
> > @@ -292,6 +292,8 @@ static void hid_irq_in(struct urb *urb)
> >  	case 0:			/* success */
> >  		usbhid_mark_busy(usbhid);
> >  		usbhid->retry_delay = 0;
> > +		if ((hid->quirks & HID_QUIRK_IN) && !hid->open)
> > +			break;
> >  		hid_input_report(urb->context, HID_INPUT_REPORT,
> >  				 urb->transfer_buffer,
> >  				 urb->actual_length, 1);
> > @@ -734,8 +736,10 @@ void usbhid_close(struct hid_device *hid)
> >  	if (!--hid->open) {
> >  		spin_unlock_irq(&usbhid->lock);
> >  		hid_cancel_delayed_stuff(usbhid);
> > -		usb_kill_urb(usbhid->urbin);
> > -		usbhid->intf->needs_remote_wakeup = 0;
> > +		if (!(hid->quirks & HID_QUIRK_IN)) {
> > +			usb_kill_urb(usbhid->urbin);
> > +			usbhid->intf->needs_remote_wakeup = 0;
> > +		}
> >  	} else {
> >  		spin_unlock_irq(&usbhid->lock);
> >  	}
> > @@ -1133,6 +1137,20 @@ static int usbhid_start(struct hid_device *hid)
> >  
> >  	set_bit(HID_STARTED, &usbhid->iofl);
> >  
> > +	hid->quirks |= HID_QUIRK_IN;	/* FIXME */
> 
> This of course needs to be set on per-device basis :)

Of course.

> > +	if (hid->quirks & HID_QUIRK_IN) {
> > +		ret = usb_autopm_get_interface(usbhid->intf);
> > +		if (ret)
> > +			goto fail;
> > +		usbhid->intf->needs_remote_wakeup = 1;
> > +		ret = hid_start_in(hid);
> > +		if (ret) {
> > +			dev_err(&hid->dev,
> > +				"failed to start in urb: %d\n", ret);
> > +		}
> > +		usb_autopm_put_interface(usbhid->intf);
> > +	}
> > +
> >  	/* Some keyboards don't work until their LEDs have been set.
> >  	 * Since BIOSes do set the LEDs, it must be safe for any device
> >  	 * that supports the keyboard boot protocol.
> > @@ -1165,6 +1183,8 @@ static void usbhid_stop(struct hid_device *hid)
> >  	if (WARN_ON(!usbhid))
> >  		return;
> >  
> > +	usbhid->intf->needs_remote_wakeup = 0;
> > +
> >  	clear_bit(HID_STARTED, &usbhid->iofl);
> >  	spin_lock_irq(&usbhid->lock);	/* Sync with error and led handlers */
> >  	set_bit(HID_DISCONNECTED, &usbhid->iofl);
> > diff --git a/include/linux/hid.h b/include/linux/hid.h
> > index 77632cf..13f81ae 100644
> > --- a/include/linux/hid.h
> > +++ b/include/linux/hid.h
> > @@ -286,6 +286,7 @@ struct hid_item {
> >  #define HID_QUIRK_HIDINPUT_FORCE		0x00000080
> >  #define HID_QUIRK_NO_EMPTY_INPUT		0x00000100
> >  #define HID_QUIRK_NO_INIT_INPUT_REPORTS		0x00000200
> > +#define HID_QUIRK_IN				0x00000400
> 
> 0x00000400 has been removed before dynamic quirks started to be possible, 
> so there is no potential clash, that's fine.
> 
> I'd just propose some more descriptive name for the quirk ... how about 
> something like HID_QUIRK_EARLY_INTERRUPT?

Yeah, IN was just a working name. How about HID_QUIRK_ALWAYS_POLL or
similar as it is not just about disconnect before the device is opened,
but also if there's an event after the device has been closed (e.g.
stopping X)?

Thanks,
Johan
