From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/2] SOUND: kill gameport bits
Date: Thu, 21 Aug 2014 09:16:10 +0200
Message-ID: <CAMuHMdXctPvoJGOOVPA+a=ZGqYHsttTw3eGNU1sNGRcidshF3A@mail.gmail.com>
References: <20140820024638.GA25240@rhlx01.hs-esslingen.de>
	<20140820051815.GA1109@core.coreip.homeip.net>
	<s5hwqa3hetu.wl-tiwai@suse.de>
	<20140820063130.GA11226@core.coreip.homeip.net>
	<s5htx57hc89.wl-tiwai@suse.de>
	<s5hfvgrwe59.wl-tiwai@suse.de>
	<20140820144952.GB18099@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f48.google.com ([209.85.215.48]:63037 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751006AbaHUHQM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 21 Aug 2014 03:16:12 -0400
In-Reply-To: <20140820144952.GB18099@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, Andreas Mohr <andi@lisas.de>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Vojtech Pavlik <vojtech@suse.cz>, Jiri Kosina <jkosina@suse.cz>

Hi Dmitry,

On Wed, Aug 20, 2014 at 4:49 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Wed, Aug 20, 2014 at 02:15:30PM +0200, Takashi Iwai wrote:
>> At Wed, 20 Aug 2014 09:05:58 +0200,
>> Takashi Iwai wrote:
>> > Well, it worked on my test machine a year ago or so.  Maybe I had a
>> > good luck.
>>
>> FYI, now I tested again an analog joystick on SB Live put on a Dell
>> IvyBridge desktop with 3.17-rc1 x86-64 kernel, and it worked fine as
>> is.
>>
>> So it's not that broken.
>
> That's probably because in your system TSCs are stable when switching CPU
> frequency. Earlier systems had bunch of issues there IIRC.

>From the success stories above, it seems gameport doesn't work on only
a limited number of systems.

Perhaps the subsystem can fail with a big fat warning at runtime if such
a system is detected?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
