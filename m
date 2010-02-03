From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] Input: add appleir USB driver
Date: Wed, 3 Feb 2010 16:54:28 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1002031653320.15395@pobox.suse.cz>
References: <1263997077.1735.2942.camel@localhost.localdomain>  <alpine.LNX.2.00.1001271631460.30977@pobox.suse.cz> <1265032341.32444.3105.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:38544 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757333Ab0BCPya (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 3 Feb 2010 10:54:30 -0500
In-Reply-To: <1265032341.32444.3105.camel@localhost.localdomain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-input <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Mon, 1 Feb 2010, Bastien Nocera wrote:

> > > +With 0x05ac being the vendor ID (Apple, you shouldn't need to change this)
> > > +With 0x8242 being the product ID (check the output of lsusb for your hardware)
> > > +And 0x08 being "HID_CONNECT_HIDDEV"
> > 
> > I am afraid this is not true, 0x08 is HID_QUIRK_NOGET.
> > 
> > We currently don't have dynamic quirk for forcing HIDDEV creation from the 
> > module parameter.
> 
> Right. Any chance to change that?

This particular one might actually make enough sense to be added (although 
I am really trying to avoid quirk additions completely), for backwards 
compatibility reasons.

> > > +	if (!memcmp(data, keydown, sizeof(keydown))) {
> > > +		/*If we already have a key down, take it up before marking */
> > > +		/*this one down */
> > > +		if (appleir->current_key)
> > > +			key_up(appleir, appleir->current_key);
> > > +		appleir->current_key = keymap[(data[4] >> 1) & MAX_KEYS_MASK];
> > > +
> > > +		key_down(appleir, appleir->current_key);
> > > +		/*remote doesn't do key up, either pull them up, in the test */
> > > +		/*above, or here set a timer which pulls them up after 1/8 s */
> > 
> > Could you please place spaces after the comment starters?
> 
> I've done that on my local copy. I'm now trying to get in touch with
> Matthew Garrett so he can help me out with the suspend parts of the
> patch. I'll resubmit when that's done.

OK, thanks.

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
