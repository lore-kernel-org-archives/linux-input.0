From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 1/3] Input: split hid-drff into general and ff parts
Date: Mon, 24 Jan 2011 16:28:51 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1101241628210.5725@pobox.suse.cz>
References: <1295602215-6056-1-git-send-email-spbnick@gmail.com> <1295602215-6056-2-git-send-email-spbnick@gmail.com> <20110121095243.GD21842@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:35109 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753281Ab1AXP2x (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 24 Jan 2011 10:28:53 -0500
In-Reply-To: <20110121095243.GD21842@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Nikolai Kondrashov <spbnick@gmail.com>, linux-input <linux-input@vger.kernel.org>, Vladislav Naumov <vnaum@vnaum.com>

On Fri, 21 Jan 2011, Dmitry Torokhov wrote:

> > Split DragonRise Inc. HID gamepad driver (hid-drff.c) into a general
> > (hid-dr.[hc]) and a force feedback part (hid-drff.c).
> > 
> > Signed-off-by: Nikolai Kondrashov <spbnick@gmail.com>
> > ---
> >  drivers/hid/Makefile   |    7 ++++-
> >  drivers/hid/hid-dr.c   |   71 ++++++++++++++++++++++++++++++++++++++++++++++++
> >  drivers/hid/hid-dr.h   |   13 +++++++++
> >  drivers/hid/hid-drff.c |   63 +-----------------------------------------
> >  4 files changed, 92 insertions(+), 62 deletions(-)
> >  create mode 100644 drivers/hid/hid-dr.c
> >  create mode 100644 drivers/hid/hid-dr.h
> > 
> > diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
> > index 6efc2a0..ea58795 100644
> > --- a/drivers/hid/Makefile
> > +++ b/drivers/hid/Makefile
> > @@ -25,6 +25,11 @@ ifdef CONFIG_LOGIWII_FF
> >  	hid-logitech-y	+= hid-lg4ff.o
> >  endif
> >  
> > +hid-dragonrise-objs		:= hid-dr.o
> > +ifdef CONFIG_DRAGONRISE_FF
> > +	hid-dragonrise-objs	+= hid-drff.o
> > +endif
> 
> If you want to keep the 2 source files then I think you should write this as:
> 
> hid-dragonrise-y			:= hid-dr.o
> hid-dragonrise-$(CONFIG_DRAGONRISE_FF)	+= hid-drff.o
> 
> Or maybe fold them into one?

Yeah, folding into one looks sane to me.

Nikolai, could you please respin the patches and resend? Otherwise I have 
no objections.

Thanks,

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
