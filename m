From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH 5/9] ASoC: pxa: switch to new ac97 bus support
Date: Mon, 31 Oct 2016 09:37:17 +0100
Message-ID: <87bmy029tu.fsf@belgarion.home>
References: <1477510907-23495-1-git-send-email-robert.jarzmik@free.fr>
        <1477510907-23495-6-git-send-email-robert.jarzmik@free.fr>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1477510907-23495-6-git-send-email-robert.jarzmik@free.fr>
        (Robert Jarzmik's message of "Wed, 26 Oct 2016 21:41:43 +0200")
Sender: linux-pm-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, patches@opensource.wolfsonmicro.com, linux-pm@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

Robert Jarzmik <robert.jarzmik@free.fr> writes:

> Switch to the new ac97 bus support in sound/ac97 instead of the legacy
> snd_ac97 one.
>
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
I realized this one impacts sound/arm/pxa2xx-ac97.c.
This deserves a v2, with this patch being split into 2 pieces :
 - one for pxa2xx-ac97-lib.*
 - one which will be the true switch to the new ac97 bus.

Cheers.

--
Robert
