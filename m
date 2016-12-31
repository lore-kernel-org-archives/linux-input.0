From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 2/4] Input: silead_gsl1680: gpiod_get returning -EBUSY is
 not an error
Date: Sat, 31 Dec 2016 17:45:06 +0100
Message-ID: <77a85e17-b47f-8d01-1fe3-53ed07002768@redhat.com>
References: <20161209103522.3833-1-hdegoede@redhat.com>
 <20161209103522.3833-2-hdegoede@redhat.com> <20161227221457.GC28140@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50548 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754633AbcLaQpJ (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sat, 31 Dec 2016 11:45:09 -0500
In-Reply-To: <20161227221457.GC28140@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, Gregor Riepl <onitake@gmail.com>, linux-input@vger.kernel.org

Hi,

On 27-12-16 23:14, Dmitry Torokhov wrote:
> On Fri, Dec 09, 2016 at 11:35:20AM +0100, Hans de Goede wrote:
>> ACPI gpios may return -EBUSY this means that the gpio is owned by the
>> ACPI code, and will be set / cleared as needed by the ACPI code.
>>
>> Treat gpiod_get returning -EBUSY as not having a gpio, fixing the
>> driver not loading on tablets where this happens.
>
> Hmm, I'd say ACPI should not be exposing existence of GPIO to the
> drivers if it decides to manage it itself. Can we hide this in gpiolib
> ACPI code?

I don't think we really can, the -EBUSY comes from the chipset driver,
where there is a special bit in the gpio-cfg reg signalling whether
the gpio is owned by the host or by the firmware. So only the chipset
specific implementation knows about this.

And for other drivers not being able to access the gpio is not acceptable.

We could simply make the gpio completely optional by doing:

	data->gpio_power = devm_gpiod_get(dev, "power", GPIOD_OUT_LOW);
	if (IS_ERR(data->gpio_power)) {
		error = PTR_ERR(data->gpio_power);
		if (error == -EPROBE_DEFER)
			return error;
		dev_info(dev, "Not using power gpio: %d\n", error);
		data->gpio_power = NULL;
	}

Then we don't end up ugly-fying the silead.c code...

Regards,

Hans



>
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>  drivers/input/touchscreen/silead.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/input/touchscreen/silead.c b/drivers/input/touchscreen/silead.c
>> index f502c84..4387cd8 100644
>> --- a/drivers/input/touchscreen/silead.c
>> +++ b/drivers/input/touchscreen/silead.c
>> @@ -467,6 +467,14 @@ static int silead_ts_probe(struct i2c_client *client,
>>
>>  	/* Power GPIO pin */
>>  	data->gpio_power = devm_gpiod_get_optional(dev, "power", GPIOD_OUT_LOW);
>> +#ifdef CONFIG_ACPI
>> +	/*
>> +	 * ACPI gpios may return -EBUSY this means that the gpio is owned by
>> +	 * the ACPI code, and will be set / cleared by the ACPI code.
>> +	 */
>> +	if (IS_ERR(data->gpio_power) && PTR_ERR(data->gpio_power) == -EBUSY)
>> +		data->gpio_power = NULL;
>> +#endif
>>  	if (IS_ERR(data->gpio_power)) {
>>  		if (PTR_ERR(data->gpio_power) != -EPROBE_DEFER)
>>  			dev_err(dev, "Shutdown GPIO request failed\n");
>> --
>> 2.9.3
>>
>
> Thanks.
>
