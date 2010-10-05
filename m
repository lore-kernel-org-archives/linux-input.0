From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RESEND] [PATCH] Input: add appleir USB driver
Date: Mon, 4 Oct 2010 21:45:20 -0700
Message-ID: <20101005044520.GA14707@core.coreip.homeip.net>
References: <1285844276.26405.26.camel@cookie.hadess.net>
 <201010042117.41786.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:65067 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751522Ab0JEEp3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 5 Oct 2010 00:45:29 -0400
Content-Disposition: inline
In-Reply-To: <201010042117.41786.oliver@neukum.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: Bastien Nocera <hadess@hadess.net>, linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, linux-kernel <linux-kernel@vger.kernel.org>

On Mon, Oct 04, 2010 at 09:17:41PM +0200, Oliver Neukum wrote:
> Am Donnerstag, 30. September 2010, 12:57:55 schrieb Bastien Nocera:
> 
> > +static int get_key(int data)
> > +{
> > +	switch (data) {
> > +	case 0x02:
> > +	case 0x03:
> > +		/* menu */
> > +		return 1;
> > +	case 0x04:
> > +	case 0x05:
> > +		/* >" */
> > +		return 2;
> > +	case 0x06:
> > +	case 0x07:
> > +		/* >> */
> > +		return 3;
> > +	case 0x08:
> > +	case 0x09:
> > +		/* << */
> > +		return 4;
> > +	case 0x0a:
> > +	case 0x0b:
> > +		/* + */
> > +		return 5;
> > +	case 0x0c:
> > +	case 0x0d:
> > +		/* - */
> > +		return 6;
> > +	case 0x5c:
> > +		/* Middle button, on newer remotes,
> > +		 * part of a 2 packet-command */
> > +		return -7;
> > +	default:
> > +		return -1;
> > +	}
> 
> Is this really better than a table lookup?
> 

I think this driver should simply be converted to sparse keymap. It will
also make sure that keymap can be changed from userspace.


> > +static void new_data(struct appleir *appleir, u8 *data, int len)
> > +{
> > +	static const u8 keydown[] = { 0x25, 0x87, 0xee };
> > +	static const u8 keyrepeat[] = { 0x26, };
> > +	static const u8 flatbattery[] = { 0x25, 0x87, 0xe0 };
> > +
> > +	if (debug)
> > +		dump_packet(appleir, "received", data, len);
> > +
> > +	if (len != 5)
> > +		return;
> > +
> > +	if (!memcmp(data, keydown, sizeof(keydown))) {
> > +		int index;
> > +
> > +		/* If we already have a key down, take it up before marking
> > +		   this one down */
> > +		if (appleir->current_key)
> > +			key_up(appleir, appleir->current_key);
> 
> This races with the timer. You can end up with a key reported up twice.
> 
> > +		/* Handle dual packet commands */
> > +		if (appleir->prev_key_idx > 0)
> > +			index = appleir->prev_key_idx;
> > +		else
> > +			index = get_key(data[4]);
> > +
> > +		if (index > 0) {
> > +			appleir->current_key = appleir->keymap[index];
> > +
> > +			key_down(appleir, appleir->current_key);
> > +			/* Remote doesn't do key up, either pull them up, in the test
> > +			   above, or here set a timer which pulls them up after 1/8 s */
> > +			mod_timer(&appleir->key_up_timer, jiffies + HZ / 8);
> > +			appleir->prev_key_idx = 0;
> > +			return;
> > +		} else if (index == -7) {
> > +			/* Remember key for next packet */
> > +			appleir->prev_key_idx = 0 - index;

So it alwas sets prev_key_index to 7 which is ">>". What about the
middle button?

> > +			return;
> > +		}
> > +	}
> 
> 
> > +static int appleir_open(struct input_dev *dev)
> > +{
> > +	struct appleir *appleir = input_get_drvdata(dev);
> > +	struct usb_interface *intf = usb_ifnum_to_if(appleir->usbdev, 0);
> > +	int r;
> > +
> > +	r = usb_autopm_get_interface(intf);
> > +	if (r) {
> > +		dev_err(&intf->dev,
> > +			"%s(): usb_autopm_get_interface() = %d\n", __func__, r);
> > +		return r;
> > +	}
> > +
> > +	mutex_lock(&appleir_mutex);
> > +
> > +	if (usb_submit_urb(appleir->urb, GFP_ATOMIC)) {
> 
> No need for ATOMIC
> 
> > +		r = -EIO;
> > +		goto fail;
> > +	}
> > +
> > +	appleir->flags |= APPLEIR_OPENED;
> > +
> > +	mutex_unlock(&appleir_mutex);
> > +
> > +	usb_autopm_put_interface(intf);
> 
> This does not enable remote wakeup. Why? Looks like a bug.
> 
> > +	return 0;
> > +fail:
> > +	mutex_unlock(&appleir_mutex);
> > +	usb_autopm_put_interface(intf);
> > +	return r;
> > +}
> > +
> > +static void appleir_close(struct input_dev *dev)
> > +{
> > +	struct appleir *appleir = input_get_drvdata(dev);
> > +
> > +	mutex_lock(&appleir_mutex);
> > +
> > +	if (!(appleir->flags & APPLEIR_SUSPENDED)) {
> > +		usb_kill_urb(appleir->urb);
> > +		del_timer_sync(&appleir->key_up_timer);
> 
> You can close with a key unreleased.

I think this is handled by input core. We forcibly send release events
when device is disconnected; this takes care of surprise disconnect case.
OTOH if input_dev->close() is called that means that there are no more
listeners for the events so the fact that a key is still pressed is not
interesting to anyone.

> 
> > +	}
> > +
> > +	appleir->flags &= ~APPLEIR_OPENED;
> > +
> > +	mutex_unlock(&appleir_mutex);
> > +}
> > +
> 
> 
> > +static int appleir_suspend(struct usb_interface *interface,
> > +			   pm_message_t message)
> > +{
> > +	struct appleir *appleir = usb_get_intfdata(interface);
> > +
> > +	mutex_lock(&appleir_mutex);
> > +	if (appleir->flags & APPLEIR_OPENED)
> 
> Why bother checking?
> 
> > +		usb_kill_urb(appleir->urb);
> 
> If the system goes to sleep you'd better report a pressed key
> as released here and kill the timer.

Input core sends "release" events upon resume so we should be OK.

Thanks.

-- 
Dmitry
