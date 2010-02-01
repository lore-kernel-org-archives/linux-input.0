From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH] Input: add appleir USB driver
Date: Mon, 01 Feb 2010 13:52:21 +0000
Message-ID: <1265032341.32444.3105.camel@localhost.localdomain>
References: <1263997077.1735.2942.camel@localhost.localdomain>
	 <alpine.LNX.2.00.1001271631460.30977@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57037 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754577Ab0BANw2 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 1 Feb 2010 08:52:28 -0500
In-Reply-To: <alpine.LNX.2.00.1001271631460.30977@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Wed, 2010-01-27 at 16:40 +0100, Jiri Kosina wrote:
> On Wed, 20 Jan 2010, Bastien Nocera wrote:
> 
> > +First, you will need to disable the kernel driver for the receiver.
> > +
> > +This can be achieved by passing quirks to the usbhid driver.
> > +The quirk line would be:
> > +usbhid.quirks=0x05ac:0x8242:0x08
> > +
> > +With 0x05ac being the vendor ID (Apple, you shouldn't need to change this)
> > +With 0x8242 being the product ID (check the output of lsusb for your hardware)
> > +And 0x08 being "HID_CONNECT_HIDDEV"
> 
> I am afraid this is not true, 0x08 is HID_QUIRK_NOGET.
> 
> We currently don't have dynamic quirk for forcing HIDDEV creation from the 
> module parameter.

Right. Any chance to change that?

> > +	if (!memcmp(data, keydown, sizeof(keydown))) {
> > +		/*If we already have a key down, take it up before marking */
> > +		/*this one down */
> > +		if (appleir->current_key)
> > +			key_up(appleir, appleir->current_key);
> > +		appleir->current_key = keymap[(data[4] >> 1) & MAX_KEYS_MASK];
> > +
> > +		key_down(appleir, appleir->current_key);
> > +		/*remote doesn't do key up, either pull them up, in the test */
> > +		/*above, or here set a timer which pulls them up after 1/8 s */
> 
> Could you please place spaces after the comment starters?

I've done that on my local copy. I'm now trying to get in touch with
Matthew Garrett so he can help me out with the suspend parts of the
patch. I'll resubmit when that's done.

Cheers

