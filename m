From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] Add support for the MacBook Pro 10,2 keyboard /
 touchpad
Date: Wed, 31 Oct 2012 08:41:37 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1210310841210.25394@pobox.suse.cz>
References: <20121030222211.GA20026@polaris.bitmath.org> <13ab3c9f72c.2202.2747.dirk@hohndel.org> <20121031054854.GA31983@core.coreip.homeip.net> <20121030230228.356490.FMU5080@air.gr8dns.org> <20121031063425.GA32539@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:60551 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932447Ab2JaHlm (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 31 Oct 2012 03:41:42 -0400
In-Reply-To: <20121031063425.GA32539@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Dirk Hohndel <dirk@hohndel.org>, Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

On Tue, 30 Oct 2012, Dmitry Torokhov wrote:

> > > Pure luck I think as entries for bcm5974 get sorted before entries for
> > > HID. To be safe and make sure it works if hid is built-in we need to add
> > > the new devices to hid_mouse_ignore_list.
> > 
> > Erm - what makes you think I tested this as a module? Actually, come to
> > think of, I ONLY tested this built in.
> > 
> > > That for devices driven by hid-multitouch, so not applicable to this
> > > case.
> > 
> > Ok, thanks
> > 
> > >> The keyboard definitely needs it, though.
> > >> 
> > >> Let me phrase it this way: the patch, as submitted, happily works on my rMBP 13
> > >
> > > By pure luck.
> > 
> > I'll take your word for it. Here's an updated patch
> 
> Thanks!
> 
> Jiri, do you want me to take it through my tree or yours?

Thanks everybody. I have now applied it.

-- 
Jiri Kosina
SUSE Labs
