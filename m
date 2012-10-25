From: Sourav <sourav.poddar@ti.com>
Subject: Re: [RFT/PATCH] Input: omap4-keypad - switch to use managed resources
Date: Thu, 25 Oct 2012 18:19:55 +0530
Message-ID: <50893573.5080804@ti.com>
References: <20121025074559.GA17710@core.coreip.homeip.net> <5088FF76.2020204@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48366 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757054Ab2JYMt3 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 25 Oct 2012 08:49:29 -0400
In-Reply-To: <5088FF76.2020204@ti.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Dmitry,
On Thursday 25 October 2012 02:29 PM, Sourav wrote:
> Hi Dmitry,
> On Thursday 25 October 2012 01:16 PM, Dmitry Torokhov wrote:
>> Now that input core supports devres-managed input devices we can clean
>> up this driver a bit.
>>
>> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>> ---
>>
>> Just compiled, no hardware to test.
> Which branch are yout trying it on?
> I applied this on mainline as well as on your next branch, but getting 
> the following
> build error..
> drivers/input/keyboard/omap4-keypad.c: In function 'omap4_keypad_probe':
> drivers/input/keyboard/omap4-keypad.c:340: error: implicit declaration 
> of function 'devm_input_allocate_device'
> drivers/input/keyboard/omap4-keypad.c:340: warning: assignment makes 
> pointer from integer without a cast
> make[3]: *** [drivers/input/keyboard/omap4-keypad.o] Error 1
>
>
> ~Sourav
>
Got the issue, was missing 1 patch[1] posted in the mailing list 
necessary to use these
managed resource. Now, the kernel is building fine.
[1]: http://www.spinics.net/lists/linux-input/msg23077.html
>>   drivers/input/keyboard/omap4-keypad.c | 182 
>> ++++++++++++++--------------------
>>   1 file changed, 76 insertions(+), 106 deletions(-)
>>
>> diff --git a/drivers/input/keyboard/omap4-keypad.c 
>> b/drivers/input/keyboard/omap4-keypad.c
>> index c05f98c..327388a 100644
>> --- a/drivers/input/keyboard/omap4-keypad.c
>> +++ b/drivers/input/keyboard/omap4-keypad.c
>> @@ -241,17 +241,60 @@ static inline int omap4_keypad_parse_dt(struct 
>> device *dev,
>>   }
>>   #endif
>>   +static int __devinit omap4_keypad_setup_regs(struct device *dev,
>> +                         struct omap4_keypad *keypad_data)
>> +{
>> +    unsigned int rev;
>> +    int retval;
>> +
>> +    /*
>> +     * Enable clocks for the keypad module so that we can read
>> +     * revision register.
>> +     */
>> +    pm_runtime_enable(dev);
>> +
>> +    retval = pm_runtime_get_sync(dev);
>> +    if (retval) {
>> +        dev_err(dev, "%s: pm_runtime_get_sync() failed: %d\n",
>> +            __func__, retval);
>> +        goto out;
>> +    }
>> +
>> +    rev = __raw_readl(keypad_data->base + OMAP4_KBD_REVISION);
>> +    rev &= 0x03 << 30;
>> +    rev >>= 30;
>> +    switch (rev) {
>> +    case KBD_REVISION_OMAP4:
>> +        keypad_data->reg_offset = 0x00;
>> +        keypad_data->irqreg_offset = 0x00;
>> +        break;
>> +    case KBD_REVISION_OMAP5:
>> +        keypad_data->reg_offset = 0x10;
>> +        keypad_data->irqreg_offset = 0x0c;
>> +        break;
>> +    default:
>> +        dev_err(dev, "Keypad reports unsupported revision %d", rev);
>> +        retval = -EINVAL;
>> +        break;
>> +    }
>> +
>> +    pm_runtime_put_sync(dev);
>> +
>> +out:
>> +    pm_runtime_disable(dev);
>> +    return retval;
>> +}
>> +
>>   static int __devinit omap4_keypad_probe(struct platform_device *pdev)
>>   {
>> -    const struct omap4_keypad_platform_data *pdata =
>> -                dev_get_platdata(&pdev->dev);
>> +    struct device *dev = &pdev->dev;
>> +    const struct omap4_keypad_platform_data *pdata = 
>> dev_get_platdata(dev);
>>       const struct matrix_keymap_data *keymap_data =
>>                   pdata ? pdata->keymap_data : NULL;
>>       struct omap4_keypad *keypad_data;
>>       struct input_dev *input_dev;
>>       struct resource *res;
>> -    unsigned int max_keys;
>> -    int rev;
>> +    size_t keymap_size;
>>       int irq;
>>       int error;
>>   @@ -267,9 +310,10 @@ static int __devinit omap4_keypad_probe(struct 
>> platform_device *pdev)
>>           return -EINVAL;
>>       }
>>   -    keypad_data = kzalloc(sizeof(struct omap4_keypad), GFP_KERNEL);
>> +    keypad_data = devm_kzalloc(dev, sizeof(struct omap4_keypad),
>> +                   GFP_KERNEL);
>>       if (!keypad_data) {
>> -        dev_err(&pdev->dev, "keypad_data memory allocation failed\n");
>> +        dev_err(dev, "keypad_data memory allocation failed\n");
>>           return -ENOMEM;
>>       }
>>   @@ -279,64 +323,25 @@ static int __devinit 
>> omap4_keypad_probe(struct platform_device *pdev)
>>           keypad_data->rows = pdata->rows;
>>           keypad_data->cols = pdata->cols;
>>       } else {
>> -        error = omap4_keypad_parse_dt(&pdev->dev, keypad_data);
>> +        error = omap4_keypad_parse_dt(dev, keypad_data);
>>           if (error)
>>               return error;
>>       }
>>   -    res = request_mem_region(res->start, resource_size(res), 
>> pdev->name);
>> -    if (!res) {
>> -        dev_err(&pdev->dev, "can't request mem region\n");
>> -        error = -EBUSY;
>> -        goto err_free_keypad;
>> -    }
>> -
>> -    keypad_data->base = ioremap(res->start, resource_size(res));
>> -    if (!keypad_data->base) {
>> -        dev_err(&pdev->dev, "can't ioremap mem resource\n");
>> -        error = -ENOMEM;
>> -        goto err_release_mem;
>> -    }
>> +    keypad_data->base = devm_request_and_ioremap(dev, res);
>> +    if (!keypad_data->base)
>> +        return -EBUSY;
>>   -
>> -    /*
>> -     * Enable clocks for the keypad module so that we can read
>> -     * revision register.
>> -     */
>> -    pm_runtime_enable(&pdev->dev);
>> -    error = pm_runtime_get_sync(&pdev->dev);
>> -    if (error) {
>> -        dev_err(&pdev->dev, "pm_runtime_get_sync() failed\n");
>> -        goto err_unmap;
>> -    }
>> -    rev = __raw_readl(keypad_data->base + OMAP4_KBD_REVISION);
>> -    rev &= 0x03 << 30;
>> -    rev >>= 30;
>> -    switch (rev) {
>> -    case KBD_REVISION_OMAP4:
>> -        keypad_data->reg_offset = 0x00;
>> -        keypad_data->irqreg_offset = 0x00;
>> -        break;
>> -    case KBD_REVISION_OMAP5:
>> -        keypad_data->reg_offset = 0x10;
>> -        keypad_data->irqreg_offset = 0x0c;
>> -        break;
>> -    default:
>> -        dev_err(&pdev->dev,
>> -            "Keypad reports unsupported revision %d", rev);
>> -        error = -EINVAL;
>> -        goto err_pm_put_sync;
>> -    }
>> +    error = omap4_keypad_setup_regs(dev, keypad_data);
>> +    if (error)
>> +        return error;
>>         /* input device allocation */
>> -    keypad_data->input = input_dev = input_allocate_device();
>> -    if (!input_dev) {
>> -        error = -ENOMEM;
>> -        goto err_pm_put_sync;
>> -    }
>> +    keypad_data->input = input_dev = devm_input_allocate_device(dev);
>> +    if (!input_dev)
>> +        return -ENOMEM;
>>         input_dev->name = pdev->name;
>> -    input_dev->dev.parent = &pdev->dev;
>>       input_dev->id.bustype = BUS_HOST;
>>       input_dev->id.vendor = 0x0001;
>>       input_dev->id.product = 0x0001;
>> @@ -352,81 +357,46 @@ static int __devinit omap4_keypad_probe(struct 
>> platform_device *pdev)
>>       input_set_drvdata(input_dev, keypad_data);
>>         keypad_data->row_shift = get_count_order(keypad_data->cols);
>> -    max_keys = keypad_data->rows << keypad_data->row_shift;
>> -    keypad_data->keymap = kzalloc(max_keys * 
>> sizeof(keypad_data->keymap[0]),
>> -                      GFP_KERNEL);
>> +    keymap_size = (keypad_data->rows << keypad_data->row_shift) *
>> +            sizeof(keypad_data->keymap[0]);
>> +    keypad_data->keymap = devm_kzalloc(dev, keymap_size, GFP_KERNEL);
>>       if (!keypad_data->keymap) {
>> -        dev_err(&pdev->dev, "Not enough memory for keymap\n");
>> -        error = -ENOMEM;
>> -        goto err_free_input;
>> +        dev_err(dev, "Not enough memory for keymap\n");
>> +        return -ENOMEM;
>>       }
>>         error = matrix_keypad_build_keymap(keymap_data, NULL,
>>                          keypad_data->rows, keypad_data->cols,
>>                          keypad_data->keymap, input_dev);
>>       if (error) {
>> -        dev_err(&pdev->dev, "failed to build keymap\n");
>> -        goto err_free_keymap;
>> +        dev_err(dev, "failed to build keymap\n");
>> +        return error;
>>       }
>>   -    error = request_irq(keypad_data->irq, omap4_keypad_interrupt,
>> -                 IRQF_TRIGGER_RISING,
>> -                 "omap4-keypad", keypad_data);
>> +    error = devm_request_irq(dev, keypad_data->irq, 
>> omap4_keypad_interrupt,
>> +                 IRQF_TRIGGER_RISING,
>> +                 "omap4-keypad", keypad_data);
>>       if (error) {
>> -        dev_err(&pdev->dev, "failed to register interrupt\n");
>> -        goto err_free_input;
>> +        dev_err(dev, "failed to register interrupt\n");
>> +        return error;
>>       }
>>   -    pm_runtime_put_sync(&pdev->dev);
>> -
>>       error = input_register_device(keypad_data->input);
>>       if (error < 0) {
>> -        dev_err(&pdev->dev, "failed to register input device\n");
>> -        goto err_pm_disable;
>> +        dev_err(dev, "failed to register input device\n");
>> +        return error;
>>       }
>>         platform_set_drvdata(pdev, keypad_data);
>> -    return 0;
>> +    pm_runtime_enable(dev);
>>   -err_pm_disable:
>> -    pm_runtime_disable(&pdev->dev);
>> -    free_irq(keypad_data->irq, keypad_data);
>> -err_free_keymap:
>> -    kfree(keypad_data->keymap);
>> -err_free_input:
>> -    input_free_device(input_dev);
>> -err_pm_put_sync:
>> -    pm_runtime_put_sync(&pdev->dev);
>> -err_unmap:
>> -    iounmap(keypad_data->base);
>> -err_release_mem:
>> -    release_mem_region(res->start, resource_size(res));
>> -err_free_keypad:
>> -    kfree(keypad_data);
>> -    return error;
>> +    return 0;
>>   }
>>     static int __devexit omap4_keypad_remove(struct platform_device 
>> *pdev)
>>   {
>> -    struct omap4_keypad *keypad_data = platform_get_drvdata(pdev);
>> -    struct resource *res;
>> -
>> -    free_irq(keypad_data->irq, keypad_data);
>> -
>>       pm_runtime_disable(&pdev->dev);
>>   -    input_unregister_device(keypad_data->input);
>> -
>> -    iounmap(keypad_data->base);
>> -
>> -    res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> -    release_mem_region(res->start, resource_size(res));
>> -
>> -    kfree(keypad_data->keymap);
>> -    kfree(keypad_data);
>> -
>> -    platform_set_drvdata(pdev, NULL);
>> -
>>       return 0;
>>   }
>

