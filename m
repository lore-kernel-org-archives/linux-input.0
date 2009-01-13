From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: new modular hid?
Date: Tue, 13 Jan 2009 10:00:52 +0100 (CET)
Message-ID: <alpine.LNX.1.10.0901130958230.5377@jikos.suse.cz>
References: <496BA275.1080504@msgid.tls.msk.ru> <alpine.LRH.1.10.0901130052180.24105@twin.jikos.cz> <20090112213924.ZZRA012@mailhub.coreip.homeip.net> <alpine.LNX.1.10.0901130939290.5377@jikos.suse.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:55871 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756141AbZAMJAy (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 13 Jan 2009 04:00:54 -0500
In-Reply-To: <alpine.LNX.1.10.0901130939290.5377@jikos.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>, linux-input <linux-input@vger.kernel.org>, Jiri Slaby <jslaby@suse.cz>

On Tue, 13 Jan 2009, Jiri Kosina wrote:

> > I would agree with Michael here, it looks like we went a bit overboard 
> > with HID quirks. I think sensible solution would be to merge quirks into 
> > 3-4 files (one per device type) and maybe even compile keyboard quirks 
> > into hid core.
> It might seem a too bit too much fine-grained right now, but my 
> longer-term plan was to have more sophisticated drivers also register 
> themselves to the HID bus, make use of the common parser, etc (Wacom comes 
> to mind, for example). 
> Having the quirks grouped together rather than nicely separate would then 
> bring us close to the previous total mess, when unrelated quirks were 
> glued together randomly in the spaghetti-code-way, which I really would 
> like to avoid as much as possible, it started to become unmaintainable.

That being said, we of course need to think about the initrd issue brought 
up by Michael.

Compiling everything into single driver back again in the end would of 
course be a solution, but I am afraid that it'd be quite difficult with 
the bus infrastructure in place.

-- 
Jiri Kosina
SUSE Labs
