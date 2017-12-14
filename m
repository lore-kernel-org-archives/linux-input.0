From: Alex Manoussakis <amanou@gnu.org>
Subject: Re: [PATCH] HID: elecom: rewrite report fixup for EX-G and future
 mice
Date: Wed, 13 Dec 2017 20:02:02 -0500
Message-ID: <20171214010202.GA16635@gnu.org>
References: <20171204205550.2621-1-tk@the-tk.com>
 <20171205201307.GA13831@gaia.local>
 <nycvar.YFH.7.76.1712071103120.3572@cbobk.fhfr.pm>
 <20171209172311.GA5570@gaia.local>
 <nycvar.YFH.7.76.1712111128080.3572@cbobk.fhfr.pm>
 <20171211173116.GA9941@gnu.org>
 <20171213214746.GA23615@gaia.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eggs.gnu.org ([208.118.235.92]:56365 "EHLO eggs.gnu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750788AbdLNBCa (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 13 Dec 2017 20:02:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
        (envelope-from <amanou@gnu.org>)
        id 1ePHur-0004qW-5k
        for linux-input@vger.kernel.org; Wed, 13 Dec 2017 20:02:26 -0500
Content-Disposition: inline
In-Reply-To: <20171213214746.GA23615@gaia.local>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Tomasz Kramkowski <tk@the-tk.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Yuxuan Shui <yshuiv7@gmail.com>, Diego Elio =?iso-8859-1?Q?Petten=F2?= <flameeyes@flameeyes.eu>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Dec 13, 2017 at 09:47:46PM +0000, Tomasz Kramkowski wrote:
> On Mon, Dec 11, 2017 at 12:31:16PM -0500, Alex Manoussakis wrote:
> > Tomasz please add the wireless version in your next patch, a web search
> > shows it's called M-XT3DRBK and the USB ID is 0x00fc.
> 
> I'll call this one EX_G_WIRELESS so that it matches the naming style

Sounds fine.

> However, I'm a bit apprehensive about sending in a patch for a device I
> can't test. Even if it's most likely going to work. Do you know of
> anyone who can test this wireless EX-G variant?

No, but I can imagine their disappointment when their device won't work
when it could have :-) Most users aren't developers and won't submit kernel
patches for their device. They'll just assume linux has subpar device support,
so it's up to us to avoid this :-P
It would be a pity to miss the opportunity to add a device variant that will
almost certainly work (and harmless in the extremely remote chance it doesn't).

Even if a Linux user with the wireless device is a developer and decides to fix
it and sends a patch to add the wireless later it's a lot more work for everyone
involved (and delay in getting it in mainline) compared to just making your work
complete now!

I didn't test the wireless HUGE either, but added it anyway. I did see reports
of people successfully using DKMS modules floating around the Internet with
their wireless HUGE/DEFT devices. I even tried one of them meant for the
*wireless* DEFT, and changed the usb ID and saw it worked for my *wired* HUGE.
This shows how Elecom tries to make their different devices work in the same
manner as much as possible (which makes sense as they won't want to complicate
their own software either) making the wireless addition a no-brainer IMO.

Also the EX_G_WIRELESS matches Elecom's convention of incrementing the wired
device ID by 1 for the wireless, so it all looks consistent and predictable.

BTW I did try your patch with my wired HUGE and it works fine, dmesg showed
your revised message after booting, and I verified all 3 Fn buttons work fine.
[    7.444707] elecom 0003:056E:010C.0005: Fixing up ELECOM mouse button count

Thanks!
Alex
