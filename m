From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH resend] input: touchscreen: silead: Add regulator support
Date: Tue, 15 Nov 2016 11:56:16 +0100
Message-ID: <cbd0f3f5-7794-7fa8-d578-d3f0f8759672@redhat.com>
References: <20161114144502.10595-1-hdegoede@redhat.com>
 <20161114144502.10595-2-hdegoede@redhat.com> <20161114185057.GA7694@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161114185057.GA7694@dtor-ws>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hi,

On 14-11-16 19:50, Dmitry Torokhov wrote:
> Hi Hans,
>
> On Mon, Nov 14, 2016 at 03:45:02PM +0100, Hans de Goede wrote:
>> On some tablets the touchscreen controller is powered by seperate
>> regulators, add support for this.
>>
>> Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>> Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>> ---
>>  .../bindings/input/touchscreen/silead_gsl1680.txt  |  2 +
>>  drivers/input/touchscreen/silead.c                 | 51 ++++++++++++++++++++--
>>  2 files changed, 49 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/input/touchscreen/silead_gsl1680.txt b/Documentation/devicetree/bindings/input/touchscreen/silead_gsl1680.txt
>> index e844c3f..b726823 100644
>> --- a/Documentation/devicetree/bindings/input/touchscreen/silead_gsl1680.txt
>> +++ b/Documentation/devicetree/bindings/input/touchscreen/silead_gsl1680.txt
>> @@ -22,6 +22,8 @@ Optional properties:
>>  - touchscreen-inverted-y  : See touchscreen.txt
>>  - touchscreen-swapped-x-y : See touchscreen.txt
>>  - silead,max-fingers	  : maximum number of fingers the touchscreen can detect
>> +- vddio-supply		  : regulator phandle for controller VDDIO
>> +- avdd-supply		  : regulator phandle for controller AVDD
>>
>>  Example:
>>
>> diff --git a/drivers/input/touchscreen/silead.c b/drivers/input/touchscreen/silead.c
>> index f502c84..c6a1ae9 100644
>> --- a/drivers/input/touchscreen/silead.c
>> +++ b/drivers/input/touchscreen/silead.c
>> @@ -29,6 +29,7 @@
>>  #include <linux/input/touchscreen.h>
>>  #include <linux/pm.h>
>>  #include <linux/irq.h>
>> +#include <linux/regulator/consumer.h>
>>
>>  #include <asm/unaligned.h>
>>
>> @@ -72,6 +73,8 @@ enum silead_ts_power {
>>  struct silead_ts_data {
>>  	struct i2c_client *client;
>>  	struct gpio_desc *gpio_power;
>> +	struct regulator *vddio;
>> +	struct regulator *avdd;
>>  	struct input_dev *input;
>>  	char fw_name[64];
>>  	struct touchscreen_properties prop;
>> @@ -465,21 +468,52 @@ static int silead_ts_probe(struct i2c_client *client,
>>  	if (client->irq <= 0)
>>  		return -ENODEV;
>>
>> +	data->vddio = devm_regulator_get_optional(dev, "vddio");
>> +	if (IS_ERR(data->vddio)) {
>> +		if (PTR_ERR(data->vddio) == -EPROBE_DEFER)
>> +			return -EPROBE_DEFER;
>> +		data->vddio = NULL;
>
> Why do we ignore other errors?

Other errors indicate that the regulator is not there
specifically I think regulator_get_optional will return -ENOENT
in that case.


> If there is an issue reported by
> regulator framework we should net be ignoring it.
>
> Unless regulator is truly optional (i.e. chip can work with some
> functionality powered off) and not simply hidden (firmware takes care of
> powering up system),

In most systems the vddio is simply hardwired to the always-on
vcc-3.3V

> we should not be using regulator_get_optional():
> if regulator is absent from ACPI/DT/etc, regulator framework will supply
> dummy regulator that you can enable/disable and not bothering checking
> whether it is NULL or not.

Right, the downside of that is that it prints a msg about this
in dmesg which typically will lead to user questions.

Anyways if you prefer the non _optional variant I can do a v3
with that ...

> Also, please consider using devm_regulator_bulk_get().

Hmm, so I would get:

In struct silead_ts_data:

	struct regulator_bulk_data regulators[2];

And then in probe() do:

	data->regulators[0].supply = "vddio";
	data->regulators[1].supply = "avdd";

	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(data->regulators),
				      data->regulators);
	if (ret)
		return ret;

And modify the enable / disable code to match.

Yes I can see how that is better / cleaner and it also
answers the question whether or not to use get_optional.

Ok, I'll do a v2 switching to regulator_bulk_get.

Regards,

Hans




>
>> +	}
>> +
>> +	data->avdd = devm_regulator_get_optional(dev, "avdd");
>> +	if (IS_ERR(data->avdd)) {
>> +		if (PTR_ERR(data->avdd) == -EPROBE_DEFER)
>> +			return -EPROBE_DEFER;
>> +		data->avdd = NULL;
>> +	}
>> +
>> +	/*
>> +	 * Enable regulators at probe and disable them at remove, we need
>> +	 * to keep the chip powered otherwise it forgets its firmware.
>> +	 */
>> +	if (data->vddio) {
>> +		error = regulator_enable(data->vddio);
>> +		if (error)
>> +			return error;
>> +	}
>> +
>> +	if (data->avdd) {
>> +		error = regulator_enable(data->avdd);
>> +		if (error)
>> +			goto disable_vddio;
>> +	}
>
> Use devm_add_action_or_reset() to work regulator_bulk_disable call into
> devm stream. As it is you are leaving regulators on on unbind/remove.
>
>> +
>>  	/* Power GPIO pin */
>>  	data->gpio_power = devm_gpiod_get_optional(dev, "power", GPIOD_OUT_LOW);
>>  	if (IS_ERR(data->gpio_power)) {
>>  		if (PTR_ERR(data->gpio_power) != -EPROBE_DEFER)
>>  			dev_err(dev, "Shutdown GPIO request failed\n");
>> -		return PTR_ERR(data->gpio_power);
>> +		error = PTR_ERR(data->gpio_power);
>> +		goto disable_avdd;
>>  	}
>>
>>  	error = silead_ts_setup(client);
>>  	if (error)
>> -		return error;
>> +		goto disable_avdd;
>>
>>  	error = silead_ts_request_input_dev(data);
>>  	if (error)
>> -		return error;
>> +		goto disable_avdd;
>>
>>  	error = devm_request_threaded_irq(dev, client->irq,
>>  					  NULL, silead_ts_threaded_irq_handler,
>> @@ -487,10 +521,19 @@ static int silead_ts_probe(struct i2c_client *client,
>>  	if (error) {
>>  		if (error != -EPROBE_DEFER)
>>  			dev_err(dev, "IRQ request failed %d\n", error);
>> -		return error;
>> +		goto disable_avdd;
>>  	}
>>
>>  	return 0;
>> +
>> +disable_avdd:
>> +	if (data->avdd)
>> +		regulator_disable(data->avdd);
>> +disable_vddio:
>> +	if (data->vddio)
>> +		regulator_disable(data->vddio);
>> +
>> +	return error;
>>  }
>>
>>  static int __maybe_unused silead_ts_suspend(struct device *dev)
>> --
>> 2.9.3
>>
>
> Thanks.
>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
