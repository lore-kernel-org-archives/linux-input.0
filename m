From: Frieder Schrempf <frieder.schrempf@exceet.de>
Subject: Re: [PATCH v3 1/3] input: pwm-beeper: add feature to set volume via
 sysfs
Date: Thu, 16 Feb 2017 21:37:59 +0100
Message-ID: <cf24a0a4-8c3e-074e-5ae7-48d40cbfc292@exceet.de>
References: <cover.1484838551.git.frieder.schrempf@exceet.de>
 <49b6d7788399142ecd01f4f5dcf263ce96eb13f1.1484838551.git.frieder.schrempf@exceet.de>
 <20170119212923.GA13542@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.exceet.ch ([77.245.33.226]:31874 "EHLO smtp.exceet.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933105AbdBPUiD (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 16 Feb 2017 15:38:03 -0500
In-Reply-To: <20170119212923.GA13542@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: robh@kernel.org, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, luis@debethencourt.com, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Dmitry,

On 19.01.2017 22:29, Dmitry Torokhov wrote:
> Hi Frieder,
>
> On Thu, Jan 19, 2017 at 04:24:08PM +0100, Frieder Schrempf wrote:
>> Make the driver accept switching volume levels via sysfs.
>> This can be helpful if the beep/bell sound intensity needs
>> to be adapted to the environment of the device.
>>
>> The volume adjustment is done by changing the duty cycle of
>> the pwm signal.
>>
>> This patch adds the sysfs interface with 5 default volume
>> levels (0 - mute, 4 - max. volume).
>>
>> Signed-off-by: Frieder Schrempf <frieder.schrempf@exceet.de>
>> ---
>> Changes in v3:
>>  - update date
>>
>>  .../ABI/testing/sysfs-class-input-pwm-beeper       | 17 ++++++
>>  drivers/input/misc/pwm-beeper.c                    | 71 +++++++++++++++++++++-
>>  2 files changed, 87 insertions(+), 1 deletion(-)
>>  create mode 100644 Documentation/ABI/testing/sysfs-class-input-pwm-beeper
>>
>> diff --git a/Documentation/ABI/testing/sysfs-class-input-pwm-beeper b/Documentation/ABI/testing/sysfs-class-input-pwm-beeper
>> new file mode 100644
>> index 0000000..c878a1d
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/sysfs-class-input-pwm-beeper
>> @@ -0,0 +1,17 @@
>> +What:		/sys/class/input/input(x)/volume
>
> Only generic (i.e. applicable to all input devices) attributes can be
> present in /sys/class/input/input(x)/, and volume certainly isn't such
> attribute. Please move them to the pwm-beeper platform device itself.

Ok, I will move this in v4.
>
>> +Date:		January 2017
>> +KernelVersion:
>> +Contact:	Frieder Schrempf <frieder.schrempf@exceet.de>
>> +Description:
>> +		Control the volume of this pwm-beeper. Values
>> +		are between 0 and max_volume_level. This file will also
>> +		show the current volume level stored in the driver.
>> +
>> +What:		/sys/class/input/input(x)/max_volume_level
>> +Date:		January 2017
>> +KernelVersion:
>> +Contact:	Frieder Schrempf <frieder.schrempf@exceet.de>
>> +Description:
>> +		This file shows the maximum volume level that can be
>> +		assigned to volume.
>> +
>> diff --git a/drivers/input/misc/pwm-beeper.c b/drivers/input/misc/pwm-beeper.c
>> index 5f9655d..3ed21da 100644
>> --- a/drivers/input/misc/pwm-beeper.c
>> +++ b/drivers/input/misc/pwm-beeper.c
>> @@ -1,5 +1,9 @@
>>  /*
>>   *  Copyright (C) 2010, Lars-Peter Clausen <lars@metafoo.de>
>> + *
>> + *  Copyright (C) 2016, Frieder Schrempf <frieder.schrempf@exceet.de>
>> + *  (volume support)
>> + *
>>   *  PWM beeper driver
>>   *
>>   *  This program is free software; you can redistribute it and/or modify it
>> @@ -27,16 +31,77 @@ struct pwm_beeper {
>>  	struct pwm_device *pwm;
>>  	struct work_struct work;
>>  	unsigned long period;
>> +	unsigned int volume;
>> +	unsigned int volume_levels[] = {0, 8, 20, 40, 500};
>
> Does this actually work? Anyway, you are not allowing to set differentr
> values in for different beepers, so take the array out of the structure.

You're right, this was not really clever. I moved the array allocation 
to probe in v4 as a preparation for the devicetree implementation in the 
following patch.
>
>> +	unsigned int max_volume_level;
>>  };
>>
>>  #define HZ_TO_NANOSECONDS(x) (1000000000UL/(x))
>>
>> +static ssize_t beeper_show_volume(struct device *dev,
>> +		struct device_attribute *attr, char *buf)
>> +{
>> +	struct pwm_beeper *beeper = dev_get_drvdata(dev);
>> +
>> +	return sprintf(buf, "%d\n", beeper->volume);
>> +}
>> +
>> +static ssize_t beeper_show_max_volume_level(struct device *dev,
>> +		struct device_attribute *attr, char *buf)
>> +{
>> +	struct pwm_beeper *beeper = dev_get_drvdata(dev);
>> +
>> +	return sprintf(buf, "%d\n", beeper->max_volume_level);
>> +}
>> +
>> +static ssize_t beeper_store_volume(struct device *dev,
>> +		struct device_attribute *attr, const char *buf, size_t count)
>> +{
>> +	int rc;
>> +	struct pwm_beeper *beeper = dev_get_drvdata(dev);
>> +	unsigned int volume;
>> +
>> +	rc = kstrtouint(buf, 0, &volume);
>> +	if (rc)
>> +		return rc;
>> +
>> +	rc = -ENXIO;
>
> Why? There are no failures below.

Yes, you're right.
>
>> +	if (volume > beeper->max_volume_level)
>> +		volume = beeper->max_volume_level;
>
> Return -EINVAL maybe?

Yes, probably makes sense.
>
>> +	pr_debug("set volume to %u\n", volume);
>> +	if (beeper->volume != volume)
>> +		beeper->volume = volume;
>
> Why?

I took this implementation from the pwm-backlight driver, but you're 
right, this does not seem to be necessary.
>
>> +	rc = count;
>> +
>> +	return rc;
>> +}
>> +
>> +static DEVICE_ATTR(volume, 0644, beeper_show_volume, beeper_store_volume);
>> +static DEVICE_ATTR(max_volume_level, 0644, beeper_show_max_volume_level, NULL);
>
> Drop "level", it is cleaner.

Ok.
>
>> +
>> +static struct attribute *bp_device_attributes[] = {
>
> pwm_beeper_atttributes

Ok.
>
>> +	&dev_attr_volume.attr,
>> +	&dev_attr_max_volume_level.attr,
>> +	NULL,
>> +};
>> +
>> +static struct attribute_group bp_device_attr_group = {
>
> pwm_beeper_attribute_group

Ok.
>
>> +	.attrs = bp_device_attributes,
>> +};
>> +
>> +static const struct attribute_group *bp_device_attr_groups[] = {
>> +	&bp_device_attr_group,
>> +	NULL,
>> +};
>> +
>>  static void __pwm_beeper_set(struct pwm_beeper *beeper)
>>  {
>>  	unsigned long period = beeper->period;
>>
>>  	if (period) {
>> -		pwm_config(beeper->pwm, period / 2, period);
>> +		pwm_config(beeper->pwm,
>> +			period / 1000 * beeper->volume_levels[beeper->volume],
>> +			period);
>>  		pwm_enable(beeper->pwm);
>>  	} else
>>  		pwm_disable(beeper->pwm);
>> @@ -123,6 +188,8 @@ static int pwm_beeper_probe(struct platform_device *pdev)
>>
>>  	INIT_WORK(&beeper->work, pwm_beeper_work);
>>
>> +	beeper->max_volume_level = ARRAY_SIZE(beeper->volume_levels) - 1;
>> +
>>  	beeper->input = input_allocate_device();
>>  	if (!beeper->input) {
>>  		dev_err(&pdev->dev, "Failed to allocate input device\n");
>> @@ -146,6 +213,8 @@ static int pwm_beeper_probe(struct platform_device *pdev)
>>
>>  	input_set_drvdata(beeper->input, beeper);
>>
>> +	beeper->input->dev.groups = bp_device_attr_groups;
>> +
>>  	error = input_register_device(beeper->input);
>>  	if (error) {
>>  		dev_err(&pdev->dev, "Failed to register input device: %d\n", error);
>> --
>> 2.7.4
>>
>
> Thanks.
>
