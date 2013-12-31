From: Christopher Heiny <cheiny@synaptics.com>
Subject: Re: [PATCH V4] input synaptics-rmi4: Bug fixes to ATTN GPIO handling.
Date: Mon, 30 Dec 2013 17:25:09 -0800
Message-ID: <52C21CF5.70006@synaptics.com>
References: <1388194004-32253-1-git-send-email-cheiny@synaptics.com> <20131228023612.GE14188@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:1551 "EHLO
	us-mx2.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932365Ab3LaBZK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 30 Dec 2013 20:25:10 -0500
In-Reply-To: <20131228023612.GE14188@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Jean Delvare <khali@linux-fr.org>, Joerie de Gram <j.de.gram@gmail.com>, Linus Walleij <linus.walleij@stericsson.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>

On 12/27/2013 06:36 PM, Dmitry Torokhov wrote:
> On Fri, Dec 27, 2013 at 05:26:44PM -0800, Christopher Heiny wrote:
>> This patch fixes some bugs in handling of the RMI4 attention line GP=
IO.
>>
>> 1) in enable_sensor(), eliminate the complicated check on ATTN and j=
ust
>> call process_interrupt_requests().  This will have minimal overhead =
if ATTN
>> is not asserted, and clears the state of the RMI4 device in any case=
=2E
>>
>> 2) Correctly free the GPIO in rmi_driver_remove().
>>
>> 3) in rmi_driver_probe()
>>      - declare the name of the attention gpio (GPIO_LABEL)
>>      - use gpio_request_one() to get the gpio and export it.
>>      - simplify (somewhat) conditional gpio acquisition logic and co=
mbine
>>        with interrupt setup
>>
>> 4) use gpio_is_valid() instead of comparing to 0.
>>
>> Signed-off-by: Christopher Heiny <cheiny@synaptics.com>
>> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>> Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
>
> drivers/input/rmi4/rmi_driver.c: In function =E2=80=98rmi_driver_prob=
e=E2=80=99:
> drivers/input/rmi4/rmi_driver.c:920:8: error: =E2=80=98struct rmi_dri=
ver_data=E2=80=99
> has no member named =E2=80=98gpio_held=E2=80=99
>      data->gpio_held =3D true;
>
> You forgot to include header file changes...


Oh, $%^&*(!


>
>>
>> ---
>>
>>   drivers/input/rmi4/rmi_driver.c | 64 ++++++++++++++++++++++++-----=
------------
>>   1 file changed, 38 insertions(+), 26 deletions(-)
>>
>> diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rm=
i_driver.c
>> index 2ae9af9..766954f 100644
>> --- a/drivers/input/rmi4/rmi_driver.c
>> +++ b/drivers/input/rmi4/rmi_driver.c
>> @@ -140,7 +140,6 @@ static int enable_sensor(struct rmi_device *rmi_=
dev)
>>   	struct rmi_driver_data *data =3D dev_get_drvdata(&rmi_dev->dev);
>>   	struct rmi_transport_dev *xport;
>>   	int retval =3D 0;
>> -	struct rmi_device_platform_data *pdata =3D to_rmi_platform_data(rm=
i_dev);
>>
>>   	if (data->enabled)
>>   		return 0;
>> @@ -169,11 +168,7 @@ static int enable_sensor(struct rmi_device *rmi=
_dev)
>>
>>   	data->enabled =3D true;
>>
>> -	if (!pdata->level_triggered &&
>> -		    gpio_get_value(pdata->attn_gpio) =3D=3D pdata->attn_polarity)
>> -		retval =3D process_interrupt_requests(rmi_dev);
>> -
>> -	return retval;
>> +	return process_interrupt_requests(rmi_dev);
>>   }
>>
>>   static void rmi_free_function_list(struct rmi_device *rmi_dev)
>> @@ -800,13 +795,21 @@ static SIMPLE_DEV_PM_OPS(rmi_driver_pm, rmi_dr=
iver_suspend, rmi_driver_resume);
>>   static int rmi_driver_remove(struct device *dev)
>>   {
>>   	struct rmi_device *rmi_dev =3D to_rmi_device(dev);
>> +	const struct rmi_device_platform_data *pdata =3D
>> +					to_rmi_platform_data(rmi_dev);
>> +	const struct rmi_driver_data *data =3D dev_get_drvdata(&rmi_dev->d=
ev);
>>
>>   	disable_sensor(rmi_dev);
>>   	rmi_free_function_list(rmi_dev);
>>
>> +	if (gpio_is_valid(pdata->attn_gpio) && data->gpio_held)
>> +		gpio_free(pdata->attn_gpio);
>
> You only need to check data->gpio_held here...

Good point.

>
>> +
>>   	return 0;
>>   }
>>
>> +static const char GPIO_LABEL[] =3D "attn";
>> +
>
> While you are updating paatch could you move it in rmi_driver_probe()
> under if (gpio_is_valid()).

Can do.

>
> By the way, maybe we should have platform supply gpio name or, in its
> absence, generate unique gpio name, so that we could have several RMI
> devices be present in a box?
>
> That can be a followup patch at a later time.

Hmmm.  I think it'd be better to name it as attn0, attn1, and so on.=20
But as you say, we can address that at a later time.


>>   static int rmi_driver_probe(struct device *dev)
>>   {
>>   	struct rmi_driver *rmi_driver;
>> @@ -937,7 +940,9 @@ static int rmi_driver_probe(struct device *dev)
>>   		mutex_init(&data->suspend_mutex);
>>   	}
>>
>> -	if (pdata->attn_gpio) {
>> +	if (gpio_is_valid(pdata->attn_gpio)) {
>> +		ulong gpio_flags =3D GPIOF_DIR_IN;
>> +
>>   		data->irq =3D gpio_to_irq(pdata->attn_gpio);
>>   		if (pdata->level_triggered) {
>>   			data->irq_flags =3D IRQF_ONESHOT |
>> @@ -948,6 +953,32 @@ static int rmi_driver_probe(struct device *dev)
>>   				(pdata->attn_polarity =3D=3D RMI_ATTN_ACTIVE_HIGH)
>>   				? IRQF_TRIGGER_RISING : IRQF_TRIGGER_FALLING;
>>   		}
>> +
>> +		if (IS_ENABLED(CONFIG_RMI4_DEV))
>> +			gpio_flags |=3D GPIOF_EXPORT;
>> +		retval =3D gpio_request_one(pdata->attn_gpio, gpio_flags,
>> +					  GPIO_LABEL);
>> +		if (retval) {
>> +			dev_warn(dev, "WARNING: Failed to request ATTN gpio %d, code=3D%=
d.\n",
>> +				 pdata->attn_gpio, retval);
>> +			retval =3D 0;
>> +		} else {
>> +			dev_info(dev, "Obtained ATTN gpio %d.\n",
>> +					pdata->attn_gpio);
>> +			data->gpio_held =3D true;
>> +			if (IS_ENABLED(CONFIG_RMI4_DEV)) {
>> +				retval =3D gpio_export_link(dev,
>> +							GPIO_LABEL, pdata->attn_gpio);
>> +				if (retval) {
>> +					dev_warn(dev,
>> +						"WARNING: Failed to symlink ATTN gpio!\n");
>> +					retval =3D 0;
>> +				} else {
>> +					dev_info(dev, "Exported ATTN gpio %d.",
>> +						pdata->attn_gpio);
>> +				}
>> +			}
>> +		}
>>   	} else
>
> 	} else {
>
>>   		data->poll_interval =3D ktime_set(0,
>>   			(pdata->poll_interval_ms ? pdata->poll_interval_ms :
>
>
> Another thing I was wondering - polling support is really unusable fo=
r
> device in production (battery gets killed) so maybe it should be remo=
ved
> altogether?

You're right that polling is not good in shipping kernels, but the=20
polling capability is extensively used when bringing up new hardware or=
=20
initially porting the driver onto existing hardware.  I suppose we coul=
d=20
make the polling capability contingent on CONFIG_RMI4_DEBUG.

>
>> @@ -958,25 +989,6 @@ static int rmi_driver_probe(struct device *dev)
>>   		enable_sensor(rmi_dev);
>>   	}
>>
>> -	if (IS_ENABLED(CONFIG_RMI4_DEV) && pdata->attn_gpio) {
>> -		retval =3D gpio_export(pdata->attn_gpio, false);
>> -		if (retval) {
>> -			dev_warn(dev, "WARNING: Failed to export ATTN gpio!\n");
>> -			retval =3D 0;
>> -		} else {
>> -			retval =3D gpio_export_link(dev,
>> -						  "attn", pdata->attn_gpio);
>> -			if (retval) {
>> -				dev_warn(dev,
>> -					"WARNING: Failed to symlink ATTN gpio!\n");
>> -				retval =3D 0;
>> -			} else {
>> -				dev_info(dev, "Exported ATTN GPIO %d.",
>> -					pdata->attn_gpio);
>> -			}
>> -		}
>> -	}
>> -
>>   	return 0;
>>
>>    err_free_data:
>
> Thanks!
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
