From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH v5 06/12] mfd: wm97xx-core: core support
	for wm97xx Codec
Date: Fri, 11 Aug 2017 21:08:22 +0200
Message-ID: <87bmnlq5w9.fsf@belgarion.home>
References: <20170806213613.5600-1-robert.jarzmik@free.fr>
 <20170806213613.5600-7-robert.jarzmik@free.fr>
 <20170808110204.dt7bjfwkyfpbfr2w@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lee Jones <lee.jones@linaro.org>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Takashi Iwai <tiwai@suse.com>, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Daniel Mack <daniel@zonque.org>
List-Id: linux-input@vger.kernel.org

Lee Jones <lee.jones@linaro.org> writes:

> On Sun, 06 Aug 2017, Robert Jarzmik wrote:

Hi Lee,

I basically agree with all your comments, so I will only answer to your
questions.
>> +#include <linux/module.h>
>
> Why separate this?
No point, for v6.
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License, or
>> + * (at your option) any later version.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>
> Can you use the short version?
Yeah, sure.

>> +#ifndef __LINUX_MFD_WM97XX_H
>> +#define __LINUX_MFD_WM97XX_H
>> +
>> +struct regmap;
>> +struct wm97xx_batt_pdata;
>> +struct snd_ac97;
>
> What are you using these for?
There are for the structure just below, which doesn't need the implementation
details of these structures, but does need the definition to properly compile.

>> +struct wm97xx_platform_data {
>> +	struct snd_ac97 *ac97;
>> +	struct regmap *regmap;
>> +	struct wm97xx_batt_pdata *batt_pdata;
>> +};
This is the structure "just below" I'm speaking of.

Thanks for the review.

-- 
Robert
