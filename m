From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] hid: Complete support for the new unibody macbooks
Date: Wed, 19 Nov 2008 18:06:10 +0100 (CET)
Message-ID: <alpine.LNX.1.10.0811191803320.19853@jikos.suse.cz>
References: <49109C91.6090207@euromail.se> <alpine.LNX.1.10.0811111835540.24889@jikos.suse.cz> <4919C979.3000501@euromail.se> <alpine.LNX.1.10.0811112347260.24889@jikos.suse.cz> <20081119113753.ZZRA012@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:50887 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752243AbYKSRGL (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 19 Nov 2008 12:06:11 -0500
In-Reply-To: <20081119113753.ZZRA012@mailhub.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 19 Nov 2008, Dmitry Torokhov wrote:

> > Yes, I am aware of bcm5974 being dependent in HID driver not claiming 
> > the mouse interface on this hardware.
> > Dmitry, what are your plans with this bcm5974 patch? 2.6.28 or 2.6.29?
> 2.6.29 - the driver is in use so I did nto want to touch it after .28 
> merge window closed. 

I see. I have already pushed the bits that ignore the mouse interface on 
the hardware in question in HID code. But that should be perfectly fine, 
as as the HID driver can't do anything with that mouse anyway.

> Also I am moving to the west coast so swamped anyways but I hope I will 
> be somewhat settled after December 8th.
> Btw, if you see something that you think needs to go into .28 for
> input could please merge it for me? I also going to ask Linus to pull
> from my for-linus branch in the next couple of days.

Sure, no problem, I will keep an eye on incoming input patches before you 
are fully settled again, and if anything new urgent comes, I will merge it 
for .28.

-- 
Jiri Kosina
SUSE Labs
