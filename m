From: Frieder Schrempf <frieder.schrempf@exceet.de>
Subject: Re: [PATCH v3 3/3] input: pwm-beeper: add devicetree bindings to set
 volume levels
Date: Thu, 16 Feb 2017 21:40:05 +0100
Message-ID: <4b9aeb6f-185c-5661-62d0-1466d8c9a24c@exceet.de>
References: <cover.1484838551.git.frieder.schrempf@exceet.de>
 <2e483f697e1cd37b56c596b3979ccf1484c8be42.1484838551.git.frieder.schrempf@exceet.de>
 <20170119213049.GB13542@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.exceet.ch ([77.245.33.226]:53472 "EHLO smtp.exceet.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933086AbdBPUkI (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 16 Feb 2017 15:40:08 -0500
In-Reply-To: <20170119213049.GB13542@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: robh@kernel.org, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, luis@debethencourt.com, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

On 19.01.2017 22:30, Dmitry Torokhov wrote:
> On Thu, Jan 19, 2017 at 04:24:10PM +0100, Frieder Schrempf wrote:
>> This patch adds the devicetree bindings to set the volume levels
>> and the default volume level.
>>
>> Signed-off-by: Frieder Schrempf <frieder.schrempf@exceet.de>
>> ---
>> Changes in v3:
>>  - none
>>
>>  drivers/input/misc/pwm-beeper.c | 49 ++++++++++++++++++++++++++++++++++++++---
>>  1 file changed, 46 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/input/misc/pwm-beeper.c b/drivers/input/misc/pwm-beeper.c
>> index 3ed21da..a7f9d70 100644
>> --- a/drivers/input/misc/pwm-beeper.c
>> +++ b/drivers/input/misc/pwm-beeper.c
>> @@ -32,7 +32,7 @@ struct pwm_beeper {
>>  	struct work_struct work;
>>  	unsigned long period;
>>  	unsigned int volume;
>> -	unsigned int volume_levels[] = {0, 8, 20, 40, 500};
>> +	unsigned int *volume_levels;
>>  	unsigned int max_volume_level;
>>  };
>>
>> @@ -161,8 +161,11 @@ static void pwm_beeper_close(struct input_dev *input)
>>  static int pwm_beeper_probe(struct platform_device *pdev)
>>  {
>>  	unsigned long pwm_id = (unsigned long)dev_get_platdata(&pdev->dev);
>> +	struct device_node *np = pdev->dev.of_node;
>>  	struct pwm_beeper *beeper;
>> -	int error;
>> +	struct property *prop;
>> +	int error, length;
>> +	u32 value;
>>
>>  	beeper = kzalloc(sizeof(*beeper), GFP_KERNEL);
>>  	if (!beeper)
>> @@ -188,7 +191,47 @@ static int pwm_beeper_probe(struct platform_device *pdev)
>>
>>  	INIT_WORK(&beeper->work, pwm_beeper_work);
>>
>> -	beeper->max_volume_level = ARRAY_SIZE(beeper->volume_levels) - 1;
>> +	/* determine the number of volume levels */
>> +	prop = of_find_property(np, "volume-levels", &length);
>
> Please use generic device properties, not OF-specific ones.

Ok, I will change this in v4.
>
>> +	if (!prop) {
>> +		dev_dbg(&pdev->dev, "no volume levels specified, using max volume\n");
>> +		beeper->max_volume_level = 1;
>> +	} else
>> +		beeper->max_volume_level = length / sizeof(u32);
>> +
>> +	/* read volume levels from DT property */
>> +	if (beeper->max_volume_level > 0) {
>> +		size_t size = sizeof(*beeper->volume_levels) *
>> +			beeper->max_volume_level;
>> +
>> +		beeper->volume_levels = devm_kzalloc(&(pdev->dev), size,
>> +			GFP_KERNEL);
>> +		if (!beeper->volume_levels)
>> +			return -ENOMEM;
>> +
>> +		if (prop) {
>> +			error = of_property_read_u32_array(np, "volume-levels",
>> +						beeper->volume_levels,
>> +						beeper->max_volume_level);
>> +
>> +			if (error < 0)
>> +				return error;
>> +
>> +			error = of_property_read_u32(np, "default-volume-level",
>> +						   &value);
>> +
>> +			if (error < 0) {
>> +				dev_dbg(&pdev->dev, "no default volume specified, using max volume\n");
>> +				value = beeper->max_volume_level - 1;
>> +			}
>> +		} else {
>> +			beeper->volume_levels[0] = 500;
>> +			value = 0;
>> +		}
>> +
>> +		beeper->volume = value;
>> +		beeper->max_volume_level--;
>> +	}
>>
>>  	beeper->input = input_allocate_device();
>>  	if (!beeper->input) {
>> --
>> 2.7.4
>>
>
