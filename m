From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH 5/9] ASoC: pxa: switch to new ac97 bus support
Date: Tue, 01 Nov 2016 20:55:10 +0100
Message-ID: <8737jb0ych.fsf@belgarion.home>
References: <1477510907-23495-1-git-send-email-robert.jarzmik@free.fr>
        <1477510907-23495-6-git-send-email-robert.jarzmik@free.fr>
        <87bmy029tu.fsf@belgarion.home>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87bmy029tu.fsf@belgarion.home> (Robert Jarzmik's message of
        "Mon, 31 Oct 2016 09:37:17 +0100")
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, patches@opensource.wolfsonmicro.com, linux-pm@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

Robert Jarzmik <robert.jarzmik@free.fr> writes:

> Robert Jarzmik <robert.jarzmik@free.fr> writes:
>
>> Switch to the new ac97 bus support in sound/ac97 instead of the legacy
>> snd_ac97 one.
>>
>> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> I realized this one impacts sound/arm/pxa2xx-ac97.c.
> This deserves a v2, with this patch being split into 2 pieces :
>  - one for pxa2xx-ac97-lib.*
>  - one which will be the true switch to the new ac97 bus.

And as another consequence, all pxa ac97 based codecs should be converted. So
far, machine drivers in sound/soc/pxa/*.c using ac97 all use either wm9705,
wm9712 or wm9713.

Therefore for this patch to be usable, I must also convert wm9705 and wm9712.

Cheers.

-- 
Robert
