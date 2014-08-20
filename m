From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/2] SOUND: kill gameport bits
Date: Wed, 20 Aug 2014 14:53:19 +0200
Message-ID: <CAMuHMdU7t=O=ZOy-ufiCYbG9PfFoPmi2TcesssPpZc=W+mJ+sQ@mail.gmail.com>
References: <20140820024638.GA25240@rhlx01.hs-esslingen.de>
	<20140820051815.GA1109@core.coreip.homeip.net>
	<s5hwqa3hetu.wl-tiwai@suse.de>
	<20140820063130.GA11226@core.coreip.homeip.net>
	<s5htx57hc89.wl-tiwai@suse.de>
	<20140820132902.7eed767f@alan.etchedpixels.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f181.google.com ([209.85.217.181]:51934 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752127AbaHTMxV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 20 Aug 2014 08:53:21 -0400
In-Reply-To: <20140820132902.7eed767f@alan.etchedpixels.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: Takashi Iwai <tiwai@suse.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andreas Mohr <andi@lisas.de>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Vojtech Pavlik <vojtech@suse.cz>, Jiri Kosina <jkosina@suse.cz>

On Wed, Aug 20, 2014 at 2:29 PM, One Thousand Gnomes
<gnomes@lxorguk.ukuu.org.uk> wrote:
>> It's the gameport core code that is currently broken under some
>> situation, right?  If so, marking it as broken is the first step, and
>> we don't need to touch else.  We may fix it later, or we may not.  If
>> the thing isn't improved, then we can drop the whole stuff.
>
> It's only broken on x86 with frequency changing. x86 is not the only
> platform with ISA or PCI bus or gameports.
>
> It really ought to go via staging, and the other arch maintainers be
> asked. The m68k and mips world does include a department of relics and
> retro-computing 8)

It seems there are no m68k-specific drivers with gameport support...

Good, let's kill all joystick ports that are newer than ports with 2600-style
connectors ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
