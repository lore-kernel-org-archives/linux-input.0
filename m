From: Qiao Zhou <zhouqiao@marvell.com>
Subject: Re: [PATCH V8] input: add onkey support to 88PM80X PMIC
Date: Fri, 13 Jul 2012 15:39:35 +0800
Message-ID: <4FFFD0B7.5010805@marvell.com>
References: <1341997504-23522-1-git-send-email-zhouqiao@marvell.com> <1341997504-23522-2-git-send-email-zhouqiao@marvell.com> <20120713073447.GC2223@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:38503 "HELO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754495Ab2GMHkV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 13 Jul 2012 03:40:21 -0400
In-Reply-To: <20120713073447.GC2223@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "sameo@linux.intel.com" <sameo@linux.intel.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On 07/13/2012 03:34 PM, Dmitry Torokhov wrote:
> Hi Qiao,
>
> On Wed, Jul 11, 2012 at 05:05:04PM +0800, Qiao Zhou wrote:
>> +
>> +static int __devinit pm80x_onkey_probe(struct platform_device *pdev)
>> +{
>> +
>> +	struct pm80x_chip *chip = dev_get_drvdata(pdev->dev.parent);
>> +	struct pm80x_onkey_info *info;
>> +	int err;
>> +
>> +	info =
>> +	    devm_kzalloc(&pdev->dev, sizeof(struct pm80x_onkey_info),
>> +			 GFP_KERNEL);
>
> Please switch to normal kzalloc/kfree, because:
>
> 1. You are not using devm_* API correctly - it was designed so that you
> do not need to explicitly call devm_free as resources will be freed when
> device is unbound from the driver (or if binf fails). But since you are
> explicitly calling devm_free() in error paths and in
> pm80x_onkey_remove() there is no point in even using this API.
>
> 2. At this time I prefer not use devm_ API in input drivers are it
> causes mixed resource tracking strategy (automatic vs manual) which is
> confusing.
thanks for advise. would update.
>
>> +	if (!info)
>> +		return -ENOMEM;
>> +
>> +	info->pm80x = chip;
>> +
>> +	info->irq = platform_get_irq(pdev, 0);
>> +	if (info->irq < 0) {
>> +		dev_err(&pdev->dev, "No IRQ resource!\n");
>> +		err = -EINVAL;
>> +		goto out;
>> +	}
>> +
>> +	info->map = info->pm80x->regmap;
>> +	if (!info->map) {
>> +		dev_err(&pdev->dev, "no regmap!\n");
>> +		err = -EINVAL;
>> +		goto out;
>> +	}
>> +
>> +	err = pm80x_request_irq(info->pm80x, info->irq, pm80x_onkey_handler,
>> +					    IRQF_ONESHOT, "onkey", info);
>> +	if (err < 0) {
>> +		dev_err(&pdev->dev, "Failed to request IRQ: #%d: %d\n",
>> +			info->irq, err);
>> +		goto out;
>> +	}
>>
>
> If we get IRQ here we'll OOPS. Please allocate input device before
> requesting IRQ (but register like you do now, as the last action, after
> requesting IRQ).
would fix it.
>
> +
>> +	info->idev = input_allocate_device();
>> +	if (!info->idev) {
>> +		dev_err(&pdev->dev, "Failed to allocate input dev\n");
>> +		err = -ENOMEM;
>> +		goto out_irq;
>> +	}
>> +
>> +	info->idev->name = "88pm80x_on";
>> +	info->idev->phys = "88pm80x_on/input0";
>> +	info->idev->id.bustype = BUS_I2C;
>> +	info->idev->dev.parent = &pdev->dev;
>> +	info->idev->evbit[0] = BIT_MASK(EV_KEY);
>> +	info->idev->keybit[BIT_WORD(KEY_POWER)] = BIT_MASK(KEY_POWER);
>
> 	__set_bit(KEY_POWER, info->idev->keybit);
would update.
>
>> +
>> +	err = input_register_device(info->idev);
>> +	if (err) {
>> +		dev_err(&pdev->dev, "Can't register input device: %d\n", err);
>> +		goto out_reg;
>> +	}
>> +
>> +	platform_set_drvdata(pdev, info);
>> +
>> +	/* Enable long onkey detection */
>> +	regmap_update_bits(info->map, PM800_RTC_MISC4, PM800_LONG_ONKEY_EN,
>> +			   PM800_LONG_ONKEY_EN);
>> +	/* Set 8-second interval */
>> +	regmap_update_bits(info->map, PM800_RTC_MISC3,
>> +			   PM800_LONKEY_PRESS_TIME_MASK,
>> +			   PM800_LONKEY_PRESS_TIME);
>> +
>> +	device_init_wakeup(&pdev->dev, 1);
>> +	return 0;
>> +
>> +out_reg:
>> +	input_free_device(info->idev);
>> +out_irq:
>> +	pm80x_free_irq(info->pm80x, info->irq, info);
>> +out:
>> +	devm_kfree(&pdev->dev, info);
>
> 	kfree(info);
>
would update.
>> +	return err;
>> +}
>> +
>> +static int __devexit pm80x_onkey_remove(struct platform_device *pdev)
>> +{
>> +	struct pm80x_onkey_info *info = platform_get_drvdata(pdev);
>> +
>> +	input_unregister_device(info->idev);
>
> If interrupt comes here we'll OOPS. You need to free IRQ first.
would update.
>
>> +	pm80x_free_irq(info->pm80x, info->irq, info);
>> +	devm_kfree(&pdev->dev, info);
> 	kfree(info);
would update.
>> +	return 0;
>> +}
>> +
>> +static struct platform_driver pm80x_onkey_driver = {
>> +	.driver = {
>> +		   .name = "88pm80x-onkey",
>> +		   .owner = THIS_MODULE,
>> +		   .pm = &pm80x_onkey_pm_ops,
>> +		   },
>> +	.probe = pm80x_onkey_probe,
>> +	.remove = __devexit_p(pm80x_onkey_remove),
>> +};
>> +
>> +module_platform_driver(pm80x_onkey_driver);
>> +
>> +MODULE_LICENSE("GPL");
>> +MODULE_DESCRIPTION("Marvell 88PM80x ONKEY driver");
>> +MODULE_AUTHOR("Qiao Zhou <zhouqiao@marvell.com>");
>> +MODULE_ALIAS("platform:88pm80x-onkey");
>> diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
>> index 7faf4a7..7c0f1ec 100644
>> --- a/drivers/input/misc/Kconfig
>> +++ b/drivers/input/misc/Kconfig
>> @@ -22,6 +22,16 @@ config INPUT_88PM860X_ONKEY
>>   	  To compile this driver as a module, choose M here: the module
>>   	  will be called 88pm860x_onkey.
>>
>> +config INPUT_88PM80X_ONKEY
>> +	tristate "88PM80x ONKEY support"
>> +	depends on MFD_88PM800
>> +	help
>> +	  Support the ONKEY of Marvell 88PM80x PMICs as an input device
>> +	  reporting power button status.
>> +
>> +	  To compile this driver as a module, choose M here: the module
>> +	  will be called 88pm80x_onkey.
>> +
>>   config INPUT_AB8500_PONKEY
>>   	tristate "AB8500 Pon (PowerOn) Key"
>>   	depends on AB8500_CORE
>> diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
>> index f55cdf4..83fe6f5 100644
>> --- a/drivers/input/misc/Makefile
>> +++ b/drivers/input/misc/Makefile
>> @@ -5,6 +5,7 @@
>>   # Each configuration option enables a list of files.
>>
>>   obj-$(CONFIG_INPUT_88PM860X_ONKEY)	+= 88pm860x_onkey.o
>> +obj-$(CONFIG_INPUT_88PM80X_ONKEY)	+= 88pm80x_onkey.o
>>   obj-$(CONFIG_INPUT_AB8500_PONKEY)	+= ab8500-ponkey.o
>>   obj-$(CONFIG_INPUT_AD714X)		+= ad714x.o
>>   obj-$(CONFIG_INPUT_AD714X_I2C)		+= ad714x-i2c.o
>> --
>> 1.7.0.4
>>
>
> Thanks!
>
Dmitry,

thanks a lot for the correction.

-- 

Best Regards
Qiao


