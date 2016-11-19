From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH 8/9] mfd: wm97xx-core: core support for wm97xx Codec
Date: Sat, 19 Nov 2016 12:39:47 +0100
Message-ID: <87twb3r94s.fsf@belgarion.home>
References: <1477510907-23495-1-git-send-email-robert.jarzmik@free.fr>
        <1477510907-23495-9-git-send-email-robert.jarzmik@free.fr>
        <20161118165040.GB19884@dell.home>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sebastian Reichel <sre@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, patches@opensource.wolfsonmicro.com, linux-pm@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

Lee Jones <lee.jones@linaro.org> writes:

> On Wed, 26 Oct 2016, Robert Jarzmik wrote:
>> +config MFD_WM97xx
>> +	tristate "Wolfson Microelectronics WM97xx"
>> +	select MFD_CORE
>> +	select REGMAP_AC97
>> +	select AC97_BUS_COMPAT if AC97_BUS_NEW
>> +	help
>> +
>
> Surplus '\n' here.
Right, for v2.

>> +	  The WM9705, WM9712 and WM9713 is a highly integrated hi-fi CODEC
>> +	  designed for smartphone applications.  As well as audio functionality
>> +	  it has on board GPIO and a touchscreen functionality which is
>> +	  supported via the relevant subsystems.  This driver provides core
>> +	  support for the WM97xx, in order to use the actual functionaltiy of
>
> Always spell check your work.
For v2.

>> + * Copyright (C) 2016 Robert Jarzmik
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License, or
>> + * (at your option) any later version.
>> + *
>> + * Features:
>> + *  - an AC97 audio codec
>> + *  - a touchscreen driver
>> + *  - a GPIO block
>
> Place this above the Copyright.
Right, for v2.

>> + */
>> +
>> +#include <linux/module.h>
>
> Why is this seperted?
No specific reason, I will remove the blank line, for v2.
>> +#include <linux/device.h>
>> +#include <linux/mfd/core.h>
>> +#include <linux/mfd/wm97xx.h>
>> +#include <linux/wm97xx.h>
>> +#include <linux/regmap.h>
>> +#include <linux/slab.h>
>> +#include <sound/ac97/codec.h>
>> +#include <sound/ac97/compat.h>
>
> Alphabetical.
Ah yeah, the linux/wm97xx.h ... for v2.

>> +#define WM9705_VENDOR_ID 0x574d4c05
>> +#define WM9712_VENDOR_ID 0x574d4c12
>> +#define WM9713_VENDOR_ID 0x574d4c13
>> +#define WM97xx_VENDOR_ID_MASK 0xffffffff
>
> Use tabs, not spaces.
Right, for v2.

> These are probably better represented as enums.
These are ids, just as devicetree ids, or PCI ids, I don't think an enum will
fit.

>> +struct wm97xx_priv {
>> +	struct regmap *regmap;
>> +	struct snd_ac97 *ac97;
>> +	struct device *dev;
>> +};
>
> Replace _priv with _ddata.
Ok, will do, would you care to explain if this is something specific to your mfd
tree, or is it a kernel overall recommendation ?

> Also document using kerneldoc.
Right, for v2.
>
>> +static bool wm97xx_readable_reg(struct device *dev, unsigned int reg)
>> +{
>> +	switch (reg) {
>> +	case AC97_RESET ... AC97_PCM_SURR_DAC_RATE:
>> +	case AC97_PCM_LR_ADC_RATE:
>> +	case AC97_CENTER_LFE_MASTER:
>> +	case AC97_SPDIF ... AC97_LINE1_LEVEL:
>> +	case AC97_GPIO_CFG ... 0x5c:
>
> Please define.
>> +	case AC97_CODEC_CLASS_REV ... AC97_PCI_SID:
>> +	case 0x74 ... AC97_VENDOR_ID2:
>
> As above.
Right, for v2.

>> +static bool wm97xx_writeable_reg(struct device *dev, unsigned int reg)
>> +{
>> +	switch (reg) {
>> +	case AC97_VENDOR_ID1:
>> +	case AC97_VENDOR_ID2:
>> +		return false;
>> +	default:
>> +		return wm97xx_readable_reg(dev, reg);
>> +	}
>> +}
>> +
>> +static const struct reg_default wm97xx_reg_defaults[] = {
>> +};
>
> What's the point in this?
Ah, that's a reminder I have still more work on this patch ... Either I remove
support for wm9705 and wm9712 in the first version, or I complete it and add the
tables :
 - wm9705_reg_defaults
 - wm9712_reg_defaults

>> +static int wm9705_register(struct wm97xx_priv *wm97xx)
>> +{
>> +	return 0;
>> +}
>> +
>> +static int wm9712_register(struct wm97xx_priv *wm97xx)
>> +{
>> +	return 0;
>> +}
>
> I don't get it?
>
> Either populate or don't provide.
Same story as above, either I complete wm9705 and wm9712 support or I remove it.

>> +static int wm9713_register(struct wm97xx_priv *wm97xx,
>> +			   struct wm97xx_pdata *pdata)
>> +{
>
> What are you lining this up with?
Emacs ... I don't see your point though, seeing it not aligned in the diff chunk
doesn't mean it's not properly aligned.

>> +	struct wm97xx_platform_data codec_pdata;
>> +	const struct mfd_cell cells[] = {
>> +		{
>> +			.name = "wm9713-codec",
>> +			.platform_data = &codec_pdata,
>> +			.pdata_size = sizeof(codec_pdata),
>> +		},
>> +		{
>> +			.name = "wm97xx-ts",
>> +			.platform_data = &codec_pdata,
>> +			.pdata_size = sizeof(codec_pdata),
>> +		},
>> +	};
>> +
>> +	codec_pdata.ac97 = wm97xx->ac97;
>> +	codec_pdata.regmap = devm_regmap_init_ac97(wm97xx->ac97,
>> +						   &wm9713_regmap_config);
>> +	codec_pdata.batt_pdata = pdata->batt_pdata;
>> +	if (IS_ERR(codec_pdata.regmap))
>> +		return PTR_ERR(codec_pdata.regmap);
>
> This doesn't look like pdata.  You can get rid of all of this hoop
> jumping if you add it to ddata and set it as such.
You mean I should pass ddata to mfd sub-cells, right ?

>> +	return devm_mfd_add_devices(wm97xx->dev, -1, cells,
>
> Use the defines.
Ok.

>
>> +				    ARRAY_SIZE(cells), NULL, 0, NULL);
>> +}
>> +
>> +static int wm97xx_ac97_probe(struct ac97_codec_device *adev)
>
> This looks sound specific.
>
> Why isn't this a plane platform driver?
That's the whole purpose of the patch serie.

This serie transforms the wm97xx drivers from a platform driver model to an ac97
model, where the ac97 devices are automatically discovered. The long explanation
is in patch 0/9, on how it started and what is the global purpose.

The short story is : switch to the new AC97 bus driver model.

As for the "sound specific part", it's because AC97 bus is mainly used in sound
oriented drivers, but still the codec IPs provide more than just sound, as the
Wolfson codecs for instance.

>> +{
>> +	struct wm97xx_priv *wm97xx;
>> +	int ret;
>> +	void *pdata = snd_ac97_codec_get_platdata(adev);
>> +
>> +	wm97xx = devm_kzalloc(ac97_codec_dev2dev(adev),
>> +			      sizeof(*wm97xx), GFP_KERNEL);
>> +	if (!wm97xx)
>> +		return -ENOMEM;
>> +
>> +	wm97xx->dev = ac97_codec_dev2dev(adev);
>> +	wm97xx->ac97 = snd_ac97_compat_alloc(adev);
>> +	if (IS_ERR(wm97xx->ac97))
>> +		return PTR_ERR(wm97xx->ac97);
>> +
>> +
>> +	ac97_set_drvdata(adev, wm97xx);
>> +	dev_info(wm97xx->dev, "wm97xx core found, id=0x%x\n",
>> +		 adev->vendor_id);
>
> All of this ac97/sound stuff should be done in the ac97/sound driver.

Nope, it's not sound adherence you're seeing here, it's ac97 bus and driver
model adherence you're seeing. Would the bus be in drivers/ac97 instead of
sound/ac97, the code would remain the same, would be bus be i2c you would see
the same kind of calls but with i2c_xxx and not ac97_xxx.

The wm97xx needs an ac97 bus to interact with the hardware, to provide sound,
gpio, adc, etc ... functions. That's what is expressed here, and the fact that
this ac97 access has to shared amongst the mfd sub-cells, and that these cells
require :
 - wm97xx->ac97 : this one is for drivers/input/touchscreen/wm97xx-core.c

So the requirement in this case is not for ac97/sound but input/touchscreen.

>> diff --git a/include/linux/mfd/wm97xx.h b/include/linux/mfd/wm97xx.h
>> new file mode 100644
>> index 000000000000..627322f14d48
>> --- /dev/null
>> +++ b/include/linux/mfd/wm97xx.h
>> @@ -0,0 +1,31 @@
>> +/*
>> + * wm97xx client interface
>> + *
>> + * Copyright (C) 2016 Robert Jarzmik
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License, or
>> + * (at your option) any later version.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + */
>> +
>> +#ifndef __LINUX_MFD_WM97XX_H
>> +#define __LINUX_MFD_WM97XX_H
>> +
>> +struct regmap;
>> +struct wm97xx_batt_pdata;
>> +struct snd_ac97;
>
> Why can't you just add the include files?
I could, but I don't need to, do I ?
Moreover, if a mfd sub-cell doesn't use regmap for example, I won't include a
useless define.

Thanks for the review, Lee. This will iterate, I'll split out mfd patch(es) to
follow up the review with you and Mark to lessen the burden on your mailbox.

Cheers.

-- 
Robert
