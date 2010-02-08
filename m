From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH] Input: add appleir USB driver
Date: Mon, 08 Feb 2010 16:32:57 +0000
Message-ID: <1265646777.2383.4621.camel@localhost.localdomain>
References: <1263997077.1735.2942.camel@localhost.localdomain>
	 <alpine.LNX.2.00.1001271631460.30977@pobox.suse.cz>
	 <1265032341.32444.3105.camel@localhost.localdomain>
	 <alpine.LNX.2.00.1002031653320.15395@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:12739 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753574Ab0BHQdJ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 8 Feb 2010 11:33:09 -0500
In-Reply-To: <alpine.LNX.2.00.1002031653320.15395@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Wed, 2010-02-03 at 16:54 +0100, Jiri Kosina wrote:
> On Mon, 1 Feb 2010, Bastien Nocera wrote:
> 
> > > > +With 0x05ac being the vendor ID (Apple, you shouldn't need to change this)
> > > > +With 0x8242 being the product ID (check the output of lsusb for your hardware)
> > > > +And 0x08 being "HID_CONNECT_HIDDEV"
> > > 
> > > I am afraid this is not true, 0x08 is HID_QUIRK_NOGET.
> > > 
> > > We currently don't have dynamic quirk for forcing HIDDEV creation from the 
> > > module parameter.
> > 
> > Right. Any chance to change that?
> 
> This particular one might actually make enough sense to be added (although 
> I am really trying to avoid quirk additions completely), for backwards 
> compatibility reasons.

Should I remove the comments there altogether then? That kind of defeats
my "but you can use lirc with some tweaks" argument, even though I still
think that those people needing more keys would be in the minority...

> > > > +	if (!memcmp(data, keydown, sizeof(keydown))) {
> > > > +		/*If we already have a key down, take it up before marking */
> > > > +		/*this one down */
> > > > +		if (appleir->current_key)
> > > > +			key_up(appleir, appleir->current_key);
> > > > +		appleir->current_key = keymap[(data[4] >> 1) & MAX_KEYS_MASK];
> > > > +
> > > > +		key_down(appleir, appleir->current_key);
> > > > +		/*remote doesn't do key up, either pull them up, in the test */
> > > > +		/*above, or here set a timer which pulls them up after 1/8 s */
> > > 
> > > Could you please place spaces after the comment starters?
> > 
> > I've done that on my local copy. I'm now trying to get in touch with
> > Matthew Garrett so he can help me out with the suspend parts of the
> > patch. I'll resubmit when that's done.
> 
> OK, thanks.

Jarod gave me a hand, and the problem is the same as with the bcm5974
driver, the platform reset_resume will work just fine.

Updated patch coming up.

Cheers

