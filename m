From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH 8/9] mfd: wm97xx-core: core support for wm97xx Codec
Date: Sat, 26 Nov 2016 10:18:38 +0100
Message-ID: <87y406ppjl.fsf@belgarion.home>
References: <1477510907-23495-1-git-send-email-robert.jarzmik@free.fr>
        <1477510907-23495-9-git-send-email-robert.jarzmik@free.fr>
        <20161118165040.GB19884@dell.home> <87twb3r94s.fsf@belgarion.home>
        <20161121101219.GB32509@dell>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20161121101219.GB32509@dell> (Lee Jones's message of "Mon, 21
        Nov 2016 10:12:19 +0000")
Sender: linux-pm-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sebastian Reichel <sre@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, patches@opensource.wolfsonmicro.com, linux-pm@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

Lee Jones <lee.jones@linaro.org> writes:

> Mark, please see below:
You'll get better chances to have an answer if you put Mark in the To: list.

Mark, Lee has question, especially in the part where he wrote "I'd like to get
Mark Brown's opinion on this.". I added the code extract in [1] to spare you
going through the all patch.

I copy-pasted his reply below in [2], which makes it top-posting ... let's say
for this time it's acceptable.

Cheers.

--
Robert

[1] Probe function and your opinion
	+static int wm97xx_ac97_probe(struct ac97_codec_device *adev)
	+{
	+	struct wm97xx_priv *wm97xx;
	+	int ret;
	+	void *pdata = snd_ac97_codec_get_platdata(adev);
	+
	+	wm97xx = devm_kzalloc(ac97_codec_dev2dev(adev),
	+			      sizeof(*wm97xx), GFP_KERNEL);
	+	if (!wm97xx)
	+		return -ENOMEM;
	+
	+	wm97xx->dev = ac97_codec_dev2dev(adev);
	+	wm97xx->ac97 = snd_ac97_compat_alloc(adev);
	+	if (IS_ERR(wm97xx->ac97))
	+		return PTR_ERR(wm97xx->ac97);
	+
	+
	+	ac97_set_drvdata(adev, wm97xx);
	+	dev_info(wm97xx->dev, "wm97xx core found, id=0x%x\n",
	+		 adev->vendor_id);

[2] Lee's previous mail
> On Sat, 19 Nov 2016, Robert Jarzmik wrote:
>> Lee Jones <lee.jones@linaro.org> writes:
>> 
>> >> +#define WM9705_VENDOR_ID 0x574d4c05
>> >> +#define WM9712_VENDOR_ID 0x574d4c12
>> >> +#define WM9713_VENDOR_ID 0x574d4c13
>> >> +#define WM97xx_VENDOR_ID_MASK 0xffffffff
>> >
>> > These are probably better represented as enums.
>> These are ids, just as devicetree ids, or PCI ids, I don't think an enum will
>> fit.
>
> That's fine.  We can use enums to simply group items of a similar
> type.  Representing these as enums would only serve to benefit code
> cleanliness.  What makes you think they won't fit?
>
>> >> +struct wm97xx_priv {
>> >> +	struct regmap *regmap;
>> >> +	struct snd_ac97 *ac97;
>> >> +	struct device *dev;
>> >> +};
>> >
>> > Replace _priv with _ddata.
>> Ok, will do, would you care to explain if this is something specific to your mfd
>> tree, or is it a kernel overall recommendation ?
>
> It's personal preference.  But these aren't necessarily private, so
> priv doesn't really make a great deal of sense.  These types of saved
> pointers are better described as device data (ddata).
>
>
> [...]
>
>> >> +static const struct reg_default wm97xx_reg_defaults[] = {
>> >> +};
>> >
>> > What's the point in this?
>> Ah, that's a reminder I have still more work on this patch ... Either I remove
>> support for wm9705 and wm9712 in the first version, or I complete it and add the
>> tables :
>>  - wm9705_reg_defaults
>>  - wm9712_reg_defaults
>
> Please don't add redundant code.  I suggest you remove it for this
> submission.
>
>> >> +static int wm9705_register(struct wm97xx_priv *wm97xx)
>> >> +{
>> >> +	return 0;
>> >> +}
>> >> +
>> >> +static int wm9712_register(struct wm97xx_priv *wm97xx)
>> >> +{
>> >> +	return 0;
>> >> +}
>> >
>> > I don't get it?
>> >
>> > Either populate or don't provide.
>> Same story as above, either I complete wm9705 and wm9712 support or I remove it.
>
> Remove it please.
>
>> >> +static int wm9713_register(struct wm97xx_priv *wm97xx,
>> >> +			   struct wm97xx_pdata *pdata)
>> >> +{
>> >
>> > What are you lining this up with?
>> Emacs ... I don't see your point though, seeing it not aligned in the diff chunk
>> doesn't mean it's not properly aligned.
>
> That is true.  So the two "scruct"s are line up in the source file,
> right?
>
> [...]
>
>> >> +	codec_pdata.ac97 = wm97xx->ac97;
>> >> +	codec_pdata.regmap = devm_regmap_init_ac97(wm97xx->ac97,
>> >> +						   &wm9713_regmap_config);
>> >> +	codec_pdata.batt_pdata = pdata->batt_pdata;
>> >> +	if (IS_ERR(codec_pdata.regmap))
>> >> +		return PTR_ERR(codec_pdata.regmap);
>> >
>> > This doesn't look like pdata.  You can get rid of all of this hoop
>> > jumping if you add it to ddata and set it as such.
>> You mean I should pass ddata to mfd sub-cells, right ?
>
> Correct.
>
> [...]
>
>> >> +static int wm97xx_ac97_probe(struct ac97_codec_device *adev)
>> >
>> > This looks sound specific.
>> >
>> > Why isn't this a plane platform driver?
>> That's the whole purpose of the patch serie.
>> 
>> This serie transforms the wm97xx drivers from a platform driver model to an ac97
>> model, where the ac97 devices are automatically discovered. The long explanation
>> is in patch 0/9, on how it started and what is the global purpose.
>> 
>> The short story is : switch to the new AC97 bus driver model.
>> 
>> As for the "sound specific part", it's because AC97 bus is mainly used in sound
>> oriented drivers, but still the codec IPs provide more than just sound, as the
>> Wolfson codecs for instance.
>
> I'd like to get Mark Brown's opinion on this.
>
>> >> +{
>> >> +	struct wm97xx_priv *wm97xx;
>> >> +	int ret;
>> >> +	void *pdata = snd_ac97_codec_get_platdata(adev);
>> >> +
>> >> +	wm97xx = devm_kzalloc(ac97_codec_dev2dev(adev),
>> >> +			      sizeof(*wm97xx), GFP_KERNEL);
>> >> +	if (!wm97xx)
>> >> +		return -ENOMEM;
>> >> +
>> >> +	wm97xx->dev = ac97_codec_dev2dev(adev);
>> >> +	wm97xx->ac97 = snd_ac97_compat_alloc(adev);
>> >> +	if (IS_ERR(wm97xx->ac97))
>> >> +		return PTR_ERR(wm97xx->ac97);
>> >> +
>> >> +
>> >> +	ac97_set_drvdata(adev, wm97xx);
>> >> +	dev_info(wm97xx->dev, "wm97xx core found, id=0x%x\n",
>> >> +		 adev->vendor_id);
>> >
>> > All of this ac97/sound stuff should be done in the ac97/sound driver.
>> 
>> Nope, it's not sound adherence you're seeing here, it's ac97 bus and driver
>> model adherence you're seeing. Would the bus be in drivers/ac97 instead of
>> sound/ac97, the code would remain the same, would be bus be i2c you would see
>> the same kind of calls but with i2c_xxx and not ac97_xxx.
>> 
>> The wm97xx needs an ac97 bus to interact with the hardware, to provide sound,
>> gpio, adc, etc ... functions. That's what is expressed here, and the fact that
>> this ac97 access has to shared amongst the mfd sub-cells, and that these cells
>> require :
>>  - wm97xx->ac97 : this one is for drivers/input/touchscreen/wm97xx-core.c
>> 
>> So the requirement in this case is not for ac97/sound but input/touchscreen.
>> 
>> >> diff --git a/include/linux/mfd/wm97xx.h b/include/linux/mfd/wm97xx.h
>> >> new file mode 100644
>> >> index 000000000000..627322f14d48
>> >> --- /dev/null
>> >> +++ b/include/linux/mfd/wm97xx.h
>> >> @@ -0,0 +1,31 @@
>> >> +/*
>> >> + * wm97xx client interface
>> >> + *
>> >> + * Copyright (C) 2016 Robert Jarzmik
>> >> + *
>> >> + * This program is free software; you can redistribute it and/or modify
>> >> + * it under the terms of the GNU General Public License as published by
>> >> + * the Free Software Foundation; either version 2 of the License, or
>> >> + * (at your option) any later version.
>> >> + *
>> >> + * This program is distributed in the hope that it will be useful,
>> >> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> >> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> >> + * GNU General Public License for more details.
>> >> + */
>> >> +
>> >> +#ifndef __LINUX_MFD_WM97XX_H
>> >> +#define __LINUX_MFD_WM97XX_H
>> >> +
>> >> +struct regmap;
>> >> +struct wm97xx_batt_pdata;
>> >> +struct snd_ac97;
>> >
>> > Why can't you just add the include files?
>> I could, but I don't need to, do I ?
>> Moreover, if a mfd sub-cell doesn't use regmap for example, I won't include a
>> useless define.
>> 
>> Thanks for the review, Lee. This will iterate, I'll split out mfd patch(es) to
>> follow up the review with you and Mark to lessen the burden on your mailbox.
>> 
>> Cheers.
>> 
