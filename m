From: Jiri Kosina <jiri.kosina@novell.com>
Subject: Re: [PATCH] Input: usbtouchscreen - add support for ET&T TC5UH
 touchscreen controller
Date: Wed, 9 Dec 2009 11:20:23 +0100 (CET)
Message-ID: <alpine.LNX.2.00.0912091119520.3755@pobox.suse.cz>
References: <1259405677-9416-1-git-send-email-ynezz@true.cz> <20091129053020.GT6936@core.coreip.homeip.net> <20091129113659.GB31105@ibawizard.net> <20091130081011.GB10295@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <20091130081011.GB10295@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: =?ISO-8859-15?Q?Petr_=A6tetiar?= <ynezz@true.cz>, linux-input@vger.kernel.org

On Mon, 30 Nov 2009, Dmitry Torokhov wrote:

> > > The link abouve mentions HID compliance? Does it not wok properly with
> > > HID driver? Do we need to blacklist it in HID?
> > 
> > Thinking about it again, we maybe need to blacklist it in HID, because it
> > can be picked up by hidraw driver.
> > 
> 
> OK, I applied th epatch to the 'next' branch, please send the blacklist
> patch to Jiri.

Petr, are you planning to send the blacklist entry patch?

Thanks,

-- 
Jiri Kosina
SUSE Labs, Novell Inc.


