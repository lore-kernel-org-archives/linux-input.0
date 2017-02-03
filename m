From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH 8/9] mfd: wm97xx-core: core support for wm97xx Codec
Date: Fri, 03 Feb 2017 09:37:03 +0100
Message-ID: <87y3xn1xhs.fsf@belgarion.home>
References: <1477510907-23495-1-git-send-email-robert.jarzmik@free.fr>
        <1477510907-23495-9-git-send-email-robert.jarzmik@free.fr>
        <20161118165040.GB19884@dell.home> <87twb3r94s.fsf@belgarion.home>
        <20161121101219.GB32509@dell> <87y406ppjl.fsf@belgarion.home>
        <20161206111353.fq5445yuzsy7li4i@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp05.smtpout.orange.fr ([80.12.242.127]:21345 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752122AbdBCIhO (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 3 Feb 2017 03:37:14 -0500
In-Reply-To: <20161206111353.fq5445yuzsy7li4i@sirena.org.uk> (Mark Brown's
        message of "Tue, 6 Dec 2016 11:13:53 +0000")
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Lee Jones <lee.jones@linaro.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sebastian Reichel <sre@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, patches@opensource.wolfsonmicro.com, linux-pm@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org

Mark Brown <broonie@kernel.org> writes:
>> >> As for the "sound specific part", it's because AC97 bus is mainly used in sound
>> >> oriented drivers, but still the codec IPs provide more than just sound, as the
>> >> Wolfson codecs for instance.
>
>> > I'd like to get Mark Brown's opinion on this.
>
> I'm not sure what the question is, sorry.

Ok, I've been busy lately and didn't pay attention to this. As I can't answer to
Mark in Lee's place, and there is a good chance that almost everybody forgot
what this was about, I'll respin the serie.

Then Lee can ask again his question to Mark so that you guys can talk directly
one to the other.

Cheers.

--
Robert
