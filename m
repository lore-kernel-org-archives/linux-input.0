From: Elias Vanderstuyft <elias.vds@gmail.com>
Subject: Re: hid-lg2ff handling of zero/low magnitude rumble effects
Date: Sat, 5 Apr 2014 09:31:08 +0200
Message-ID: <CADbOyBSO3WAyZf+u+8Lfdqi7PrBuMW36ZJ7mN84U5RPXAVmtiA@mail.gmail.com>
References: <CADbOyBRGha3+X8RSjvOU=ftTGuDGYAyuFW_b7==0HeF1uBLV-g@mail.gmail.com>
	<CADbOyBQkSGkDYcfpRUZR-h=gz-3S-NGLg4meuFYAP4zZQ7d2fQ@mail.gmail.com>
	<533F39F5.3020909@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vc0-f178.google.com ([209.85.220.178]:55533 "EHLO
	mail-vc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753894AbaDEHbJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 5 Apr 2014 03:31:09 -0400
Received: by mail-vc0-f178.google.com with SMTP id im17so3906332vcb.9
        for <linux-input@vger.kernel.org>; Sat, 05 Apr 2014 00:31:08 -0700 (PDT)
In-Reply-To: <533F39F5.3020909@web.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hendrik Iben <Hendrik_Iben@web.de>
Cc: Edgar Simo-Serra <bobbens@gmail.com>, Anssi Hannula <anssi.hannula@iki.fi>, linux-input@vger.kernel.org, Simon Wood <simon@mungewell.org>, =?ISO-8859-1?Q?Michal_Mal=FD?= <madcatxster@prifuk.cz>

On Sat, Apr 5, 2014 at 1:02 AM, Hendrik Iben <Hendrik_Iben@web.de> wrote:
> Hi Elias,
>
> First of all - thanks for caring about compatibility with old devices.
> It would be really annoying if something that worked once stopped
> working on an update.
>
> I just dug out my old Wingman Rumblepad (VID 046d PID c20a) and did the
> test cases (thanks for the tool by the way - might come in handy for
> other things). The first motor for this device controls a weak/smooth
> rumble effect and the second one a strong/coarse one. For both motors,
> values from 00 to 03 have no effect on the haptic side. You can hear the
> motors spinning a bit higher if you hold the pad to your ear... :-) -
> but it sounds like a  linear increase. It similar for the high values.
> FC-FF produce the same high amount of rumble. There might be a small
> increase but not really any difference.
> From these observations I would say that clamping is fine for the
> Rumblepad although not needed. But a special case handling would have no
> positive effect.

OK, thanks for testing! I agree that a special case handling would
have no positive effect.
I tried to contact Edgar earlier past month, but until now I can't
seem to get in touch with him.
If there is no reply in a reasonable amount of time, I'll release the
patch, it won't hurt anyone ;)

Again thanks,
Elias
