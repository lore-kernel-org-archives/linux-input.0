From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] Input: HID-multitouch: Add egalax ID for Acer Iconia
 W500
Date: Tue, 20 Sep 2011 15:06:34 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1109201506110.13109@pobox.suse.cz>
References: <1315970147-11735-1-git-send-email-marek.vasut@gmail.com> <201109161507.44989.marek.vasut@gmail.com> <20110916144700.GA5768@polaris.bitmath.org> <201109161723.56701.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:45596 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750696Ab1ITNGg (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 20 Sep 2011 09:06:36 -0400
In-Reply-To: <201109161723.56701.marek.vasut@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marek Vasut <marek.vasut@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, =?ISO-8859-15?Q?St=E9phane_Chatty?= <chatty@enac.fr>

On Fri, 16 Sep 2011, Marek Vasut wrote:

> > > > > Globally, the patch is clean. I don't really like it because a
> > > > > cleaner way would be to just remove the field .maxcontacts in
> > > > > MT_CLS_EGALAX. This would require tests from all the different
> > > > > eGalax owners, and personally, I don't have the time to lead them.
> > > > 
> > > > It is not too late to start now, though; testing this new device
> > > > without maxcontacts would help when/if the ten-finger version comes
> > > > along. Marek, would you care to try that?
> > > 
> > > Well I own only this one particular device, not the other ones.
> > 
> > I meant removing .maxcontacts from _your_ patch, and testing on your
> > particular device.
> 
> Ah all right, yes, I can try it. But only _after_ my exam on wednesday (or 
> before in case I start being tired of learning).
> 
> You're welcome!

So I will wait before merging this patch to see the results of Marek's 
testing.

-- 
Jiri Kosina
SUSE Labs
