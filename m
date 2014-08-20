From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/2] SOUND: kill gameport bits
Date: Wed, 20 Aug 2014 13:29:02 +0100
Message-ID: <20140820132902.7eed767f@alan.etchedpixels.co.uk>
References: <20140820024638.GA25240@rhlx01.hs-esslingen.de>
	<20140820051815.GA1109@core.coreip.homeip.net>
	<s5hwqa3hetu.wl-tiwai@suse.de>
	<20140820063130.GA11226@core.coreip.homeip.net>
	<s5htx57hc89.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5htx57hc89.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andreas Mohr <andi@lisas.de>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>, Jiri Kosina <jkosina@suse.cz>
List-Id: linux-input@vger.kernel.org

> It's the gameport core code that is currently broken under some
> situation, right?  If so, marking it as broken is the first step, and
> we don't need to touch else.  We may fix it later, or we may not.  If
> the thing isn't improved, then we can drop the whole stuff.

It's only broken on x86 with frequency changing. x86 is not the only
platform with ISA or PCI bus or gameports.

It really ought to go via staging, and the other arch maintainers be
asked. The m68k and mips world does include a department of relics and
retro-computing 8)

I suspect nobody cares however.

Alan
