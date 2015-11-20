From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [linux-sunxi] Re: [PATCH 4/7] touchscreen: pixcir_i2c: Add
 support for wake and enable gpios
Date: Fri, 20 Nov 2015 19:22:43 +0100
Message-ID: <564F64F3.6070405@redhat.com>
References: <1448018233-27824-1-git-send-email-hdegoede@redhat.com>
 <1448018233-27824-5-git-send-email-hdegoede@redhat.com>
 <20151120172725.GA26895@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56329 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751312AbbKTSWv (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 20 Nov 2015 13:22:51 -0500
In-Reply-To: <20151120172725.GA26895@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>, Sander Vermin <sander@vermin.nl>, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree <devicetree@vger.kernel.org>, linux-sunxi@googlegroups.com

Hi,

On 20-11-15 18:27, Dmitry Torokhov wrote:
> On Fri, Nov 20, 2015 at 12:17:10PM +0100, Hans de Goede wrote:
>> From: Sander Vermin <sander@vermin.nl>
>>
>> On some devices the wake and enable pins of the pixcir touchscreen
>> controller are connected to gpios and these must be controlled by the
>> driver for the device to operate properly.
>>
>> Signed-off-by: Sander Vermin <sander@vermin.nl>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>> Changes in v2 (Hans de Goede):
>> -Split the changes for dealing with inverted / swapped axis out into a
>>   separate patch
>> -Remove a bunch of dev_info calls to make the driver less chatty
>> -Use devm_gpiod_get_optional as these new gpios are optional
>> -Only msleep after setting enable high if we have an enable pin
>> ---
>>   .../bindings/input/touchscreen/pixcir_i2c_ts.txt   |  2 +
>>   drivers/input/touchscreen/pixcir_i2c_ts.c          | 46 ++++++++++++++++++++++
>>   2 files changed, 48 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/input/touchscreen/pixcir_i2c_ts.txt b/Documentation/devicetree/bindings/input/touchscreen/pixcir_i2c_ts.txt
>> index 8eb240a..72ca5ec 100644
>> --- a/Documentation/devicetree/bindings/input/touchscreen/pixcir_i2c_ts.txt
>> +++ b/Documentation/devicetree/bindings/input/touchscreen/pixcir_i2c_ts.txt
>> @@ -10,6 +10,8 @@ Required properties:
>>
>>   Optional properties:
>>   - reset-gpio: GPIO connected to the RESET line of the chip
>> +- enable-gpios: GPIO connected to the ENABLE line of the chip
>> +- wake-gpios: GPIO connected to the WAKE line of the chip
>>
>>   Example:
>>
>> diff --git a/drivers/input/touchscreen/pixcir_i2c_ts.c b/drivers/input/touchscreen/pixcir_i2c_ts.c
>> index 211408c..b75ef65 100644
>> --- a/drivers/input/touchscreen/pixcir_i2c_ts.c
>> +++ b/drivers/input/touchscreen/pixcir_i2c_ts.c
>> @@ -38,6 +38,8 @@ struct pixcir_i2c_ts_data {
>>   	struct input_dev *input;
>>   	struct gpio_desc *gpio_attb;
>>   	struct gpio_desc *gpio_reset;
>> +	struct gpio_desc *gpio_enable;
>> +	struct gpio_desc *gpio_wake;
>>   	const struct pixcir_i2c_chip_data *chip;
>>   	int max_fingers;	/* Max fingers supported in this instance */
>>   	bool running;
>> @@ -208,6 +210,11 @@ static int pixcir_set_power_mode(struct pixcir_i2c_ts_data *ts,
>>   	struct device *dev = &ts->client->dev;
>>   	int ret;
>>
>> +	if (mode == PIXCIR_POWER_ACTIVE || mode == PIXCIR_POWER_IDLE) {
>> +		if (!IS_ERR_OR_NULL(ts->gpio_wake))
>> +			gpiod_set_value_cansleep(ts->gpio_wake, 1);
>
> I believe you error out in case when IS_ERR(ts->gpio_wake) is true, so I
> wonder if we should simply use
>
> 		if (ts->gpio_wake)
> 			gpiod_set_value_cansleep(ts->gpio_wake, 1);
>
> here and elsewhere.

Yes that will work fine, I believe Sander went with his version because that
is what the existing gpio code (for the also optional reset pin) already does.

So from a consistency pov it is better to keep this patch as is.

> No need to resubmit, just let me know.

Ok, either way is fine with me.

Regards,

Hans
