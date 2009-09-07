From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: Re: [PATCH 03/03] [INPUT][KEYBOARD] Add new keypad driver for s3c
 series SoCs
Date: Mon, 07 Sep 2009 17:40:44 +0900
Message-ID: <4AA4C70C.8040505@samsung.com>
References: <00b101ca2e30$84135d90$8c3a18b0$%yang@samsung.com>
 <4AA49C53.3030400@samsung.com>
 <20090907082157.36C90526EC9@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:48677 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752106AbZIGIlA (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 7 Sep 2009 04:41:00 -0400
Received: from epmmp2 (mailout2.samsung.com [203.254.224.25])
 by mailout1.samsung.com
 (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTP id <0KPL003WVERWHR@mailout1.samsung.com> for
 linux-input@vger.kernel.org; Mon, 07 Sep 2009 17:40:45 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0KPL00FMUERW7D@mmp2.samsung.com> for
 linux-input@vger.kernel.org; Mon, 07 Sep 2009 17:40:44 +0900 (KST)
In-reply-to: <20090907082157.36C90526EC9@mailhub.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: =?UTF-8?B?7JaR7KeE7ISx?= <jsgood.yang@samsung.com>, linux-input@vger.kernel.org, laforge@gnumonks.org, ben-linux@fluff.org, =?UTF-8?B?Iuq5gOqyveydvC9BUOqwnOuwnO2MgChTWVMuTFNJKS9FMyjsgqzsm5ApL+yCvOyEsQ==?= =?UTF-8?B?7KCE7J6QIg==?= <ki0351.kim@samsung.com>, =?UTF-8?B?IifquYDqta3sp4Q=?= =?UTF-8?B?L0FQ6rCc67Cc7YyAKFNZUy5MU0kpL0U1KOyxheyehCkv7IK87ISx7KCE7J6QJyI=?= <kgene.kim@samsung.com>, kyungmin.park@samsung.com, jh80.chung@samsung.com

Hi,

On 9/7/2009 4:48 PM, Dmitry Torokhov wrote:
> Hi Joonyoung,
> 
> On Mon, Sep 07, 2009 at 02:38:27PM +0900, Joonyoung Shim wrote:
>> +
>> +static irqreturn_t samsung_kp_interrupt(int irq, void *dev_id)
>> +{
>> +	struct samsung_keypad *keypad = dev_id;
>> +
>> +	if (!work_pending(&keypad->work.work)) {
>> +		disable_irq_nosync(keypad->irq);
>> +		atomic_inc(&keypad->irq_disable);
>> +		schedule_delayed_work(&keypad->work, msecs_to_jiffies(10));
> 
> Why do you need to have the delayed work? Can't we query the touchpad
> state immediately? Or are you trying to implement debounce logic?

Yes, debounce logic. Actually this is enough only the schedule_work. I'm 
not sure about the debounce yet. If use the debounce logic, i think the
delay time should be moved into platform data.

> Also, the driver seems to be using the edge-triggered interrupts;
> do you really need to disable IRQ until you scan the keypad?
> 

Yes, if the interrupt isn't disabled, when press keypad, many interrupt
occur.

> 
>> +	}
>> +
>> +	return IRQ_HANDLED;
>> +}
>> +
>> +static int __devinit samsung_kp_probe(struct platform_device *pdev)
>> +{
>> +	const struct samsung_keypad_platdata *pdata;
>> +	struct samsung_keypad *keypad;
>> +	struct resource *res;
>> +	struct input_dev *input_dev;
>> +	unsigned short *keycodes;
>> +	unsigned int max_keymap_size;
>> +	unsigned int val;
>> +	int i;
>> +	int ret;
>> +
>> +	pdata = pdev->dev.platform_data;
>> +	if (!pdata) {
>> +		dev_err(&pdev->dev, "no platform data defined\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	if ((pdata->num_rows <= 0) || (pdata->num_rows > SAMSUNG_MAX_ROWS))
>> +		return -EINVAL;
>> +
>> +	if ((pdata->num_cols <= 0) || (pdata->num_cols > SAMSUNG_MAX_COLS))
>> +		return -EINVAL;
>> +
>> +	/* initialize the gpio */
>> +	if (pdata->cfg_gpio)
>> +		pdata->cfg_gpio(pdata->num_rows, pdata->num_cols);
>> +
>> +	max_keymap_size = pdata->num_rows * pdata->num_cols;
>> +	keypad = devm_kzalloc(&pdev->dev, sizeof(*keypad), GFP_KERNEL);
>> +	keycodes = devm_kzalloc(&pdev->dev,
>> +			max_keymap_size * sizeof(*keycodes), GFP_KERNEL);
>> +	input_dev = input_allocate_device();
>> +	if (!keypad || !keycodes || !input_dev)
>> +		return -ENOMEM;
>> +
>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	if (!res) {
>> +		ret = -ENODEV;
>> +		goto err_free_mem;
>> +	}
>> +
>> +	keypad->base = devm_ioremap(&pdev->dev, res->start, resource_size(res));
>> +	if (!keypad->base) {
>> +		ret = -EBUSY;
>> +		goto err_free_mem;
>> +	}
>> +
>> +	if (pdata->clock) {
>> +		keypad->clk = clk_get(&pdev->dev, pdata->clock);
>> +		if (IS_ERR(keypad->clk)) {
>> +			dev_err(&pdev->dev, "failed to get keypad clk\n");
>> +			ret = PTR_ERR(keypad->clk);
>> +			goto err_unmap_base;
>> +		}
>> +		clk_enable(keypad->clk);
>> +	}
>> +
>> +	keypad->input_dev = input_dev;
>> +	keypad->keycodes = keycodes;
>> +	keypad->num_cols = pdata->num_cols;
>> +	INIT_DELAYED_WORK(&keypad->work, samsung_kp_scan);
>> +
>> +	/* enable interrupt and debouncing filter and wakeup bit */
>> +	val = SAMSUNG_INT_F_EN | SAMSUNG_INT_R_EN | SAMSUNG_DF_EN |
>> +		SAMSUNG_WAKEUPEN;
>> +	writel(val, keypad->base + SAMSUNG_KEYIFCON);
>> +
>> +	keypad->irq = platform_get_irq(pdev, 0);
>> +	if (keypad->irq < 0) {
>> +		ret = keypad->irq;
>> +		goto err_disable_clk;
>> +	}
>> +
>> +	ret = devm_request_irq(&pdev->dev, keypad->irq,
>> +			samsung_kp_interrupt,
>> +			IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
>> +			dev_name(&pdev->dev), keypad);
>> +
>> +	if (ret)
>> +		goto err_disable_clk;
>> +
>> +	input_dev->name		= pdev->name;
>> +	input_dev->id.bustype	= BUS_HOST;
>> +	input_dev->dev.parent	= &pdev->dev;
>> +	input_dev->evbit[0]	= BIT_MASK(EV_KEY) | BIT_MASK(EV_REP);
>> +
>> +	input_dev->keycode	= keycodes;
>> +	input_dev->keycodesize	= sizeof(*keycodes);
>> +	input_dev->keycodemax	= max_keymap_size;
>> +
>> +	for (i = 0; i < pdata->keymap_size; i++) {
>> +		unsigned int key = pdata->keymap[i];
>> +		unsigned int row = KEY_ROW(key);
>> +		unsigned int col = KEY_COL(key);
>> +		unsigned short code = KEY_VAL(key);
>> +		unsigned int index = row * keypad->num_cols + col;
>> +
>> +		keycodes[index] = code;
>> +		set_bit(code, input_dev->keybit);
>> +	}
>> +
>> +	ret = input_register_device(keypad->input_dev);
>> +	if (ret)
>> +		goto err_free_irq;
>> +
>> +	device_init_wakeup(&pdev->dev, 1);
>> +
>> +	platform_set_drvdata(pdev, keypad);
>> +
>> +	return 0;
>> +
>> +err_free_irq:
>> +	devm_free_irq(&pdev->dev, keypad->irq, keypad);
> 
> 
> If you are using devres why do you release resources manually?
> 

I wonder the irq is released automatically if we don't use devm_free_irq
here.

>> +err_disable_clk:
>> +	if (keypad->clk) {
>> +		clk_disable(keypad->clk);
>> +		clk_put(keypad->clk);
>> +	}
>> +err_unmap_base:
>> +	devm_iounmap(&pdev->dev, keypad->base);
>> +err_free_mem:
>> +	input_free_device(input_dev);
>> +	devm_kfree(&pdev->dev, keycodes);
>> +	devm_kfree(&pdev->dev, keypad);
>> +
>> +	return ret;
>> +}
>> +
>> +static int __devexit samsung_kp_remove(struct platform_device *pdev)
>> +{
>> +	struct samsung_keypad *keypad = platform_get_drvdata(pdev);
>> +
>> +	devm_free_irq(&pdev->dev, keypad->irq, keypad);
>> +	cancel_delayed_work_sync(&keypad->work);
> 
> Since you need tight control of the ordering between freeing IRQ and
> canceling the work you probably should not be using devres for IRQ
> allocation.
> 

Hmm, i'm not sure about this, but i can change it not to use devres for
IRQ allocation.

>> +
>> +	/*
>> +	 * If work indeed has been cancelled, disable_irq() will have been left
>> +	 * unbalanced from samsung_kp_interrupt().
>> +	 */
>> +	while (atomic_dec_return(&keypad->irq_disable) >= 0)
>> +		enable_irq(keypad->irq);
>> +
>> +	platform_set_drvdata(pdev, NULL);
>> +	input_unregister_device(keypad->input_dev);
>> +
>> +	if (keypad->clk) {
>> +		clk_disable(keypad->clk);
>> +		clk_put(keypad->clk);
>> +	}
>> +
>> +	devm_iounmap(&pdev->dev, keypad->base);
>> +	devm_kfree(&pdev->dev, keypad->keycodes);
>> +	devm_kfree(&pdev->dev, keypad);
>> +
>> +	return 0;
>> +}
>> +
>> +#ifdef CONFIG_PM
>> +static int samsung_kp_suspend(struct platform_device *pdev, pm_message_t state)
>> +{
>> +	struct samsung_keypad *keypad = platform_get_drvdata(pdev);
>> +
>> +	disable_irq(keypad->irq);
>> +	enable_irq_wake(keypad->irq);
>> +
>> +	if (keypad->clk)
>> +		clk_disable(keypad->clk);
> 
> This should probaly gop into ->close() method.
> 

This driver doesn't use open() and close method. Why should move into
->close()?

>> +
>> +	return 0;
>> +}
>> +
>> +static int samsung_kp_resume(struct platform_device *pdev)
>> +{
>> +	struct samsung_keypad *keypad = platform_get_drvdata(pdev);
>> +	unsigned int val;
>> +
>> +	if (keypad->clk)
>> +		clk_enable(keypad->clk);
>> +
>> +	/* enable interrupt and debouncing filter and wakeup bit */
>> +	val = SAMSUNG_INT_F_EN | SAMSUNG_INT_R_EN | SAMSUNG_DF_EN |
>> +		SAMSUNG_WAKEUPEN;
>> +	writel(val, keypad->base + SAMSUNG_KEYIFCON);
>> +
>> +	disable_irq_wake(keypad->irq);
>> +	enable_irq(keypad->irq);
>> +
>> +	return 0;
>> +}
>> +#else
>> +#define samsung_kp_suspend	NULL
>> +#define samsung_kp_resume	NULL
>> +#endif
>> +
>> +static struct platform_driver samsung_kp_driver = {
>> +	.probe		= samsung_kp_probe,
>> +	.remove		= __devexit_p(samsung_kp_remove),
>> +	.suspend	= samsung_kp_suspend,
>> +	.resume		= samsung_kp_resume,
> 
> Please switch to dev_pm_ops.
> 

OK.

>> +	.driver		= {
>> +		.name	= "samsung-keypad",
>> +		.owner	= THIS_MODULE,
>> +	},
>> +};
>> +
>> +static int __init samsung_kp_init(void)
>> +{
>> +	return platform_driver_register(&samsung_kp_driver);
>> +}
>> +
>> +static void __exit samsung_kp_exit(void)
>> +{
>> +	platform_driver_unregister(&samsung_kp_driver);
>> +}
>> +
>> +module_init(samsung_kp_init);
>> +module_exit(samsung_kp_exit);
>> +
>> +MODULE_DESCRIPTION("Samsung keypad driver");
>> +MODULE_AUTHOR("Joonyoung Shim <jy0922.shim@samsung.com>");
>> +MODULE_AUTHOR("Jaehoon Chung <jh80.chung@samsung.com>");
>> +MODULE_LICENSE("GPL");
>> -- 
>> 1.6.0.4
> 

Thanks for review.

