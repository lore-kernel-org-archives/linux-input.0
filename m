From: Ben Dooks <ben-linux@fluff.org>
Subject: Re: [PATCH v2 5/5] input: samsung-keypad - Add samsung keypad driver
Date: Thu, 3 Jun 2010 02:00:25 +0100
Message-ID: <20100603010025.GA14272@trinity.fluff.org>
References: <1275188784-23395-1-git-send-email-jy0922.shim@samsung.com> <1275188784-23395-5-git-send-email-jy0922.shim@samsung.com> <20100530034250.GK7248@trinity.fluff.org> <4C01EB2E.4020600@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4C01EB2E.4020600@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: Ben Dooks <ben-linux@fluff.org>, kyungmin.park@samsung.com, linux-samsung-soc@vger.kernel.org, dmitry.torokhov@gmail.com, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sun, May 30, 2010 at 01:35:58PM +0900, Joonyoung Shim wrote:

> >> +static void samsung_kp_timer(unsigned long data)
> >> +{
> >> +	struct samsung_kp *keypad = (struct samsung_kp *)data;
> >> +
> >> +	schedule_work(&keypad->work);

would schedule_delayed_work() avoid the need for a timer here?


> >> +	keypad = kzalloc(sizeof(*keypad), GFP_KERNEL);
> >> +	keycodes = kzalloc((pdata->rows << row_shift) * sizeof(*keycodes),
> >> +			GFP_KERNEL);
> > 
> > you could allocate this in one go.
> > 
> 
> Hmm, how i do it? Do you mean to allocate keypad and keycodes together?

There's a couple of ways to do this, they may of course be not the nicest
ways.

make the last entry of the first (know size) structure a unsized array.
as so:

   struct a {
   	  ...
	  struct b t[];
   }

then do
     struct a *my_a;
     my_a = kzalloc(sizeof(struct a ) + sizeof(struct b) * nr_b);

or by incrementing the pointer:
	struct a *my_a;
	struct b *my_b;

	my_a = kzalloc(sizeof(struct a ) + sizeof(struct b) * nr_b);
	my_b = (struct b *)(my_a + 1);
     
> >> +	keypad->clk = clk_get(&pdev->dev, "keypad");

I'm going to get rid of this practice, it should be clk_get(&pdev->dev, NULL),
see up-comming clock changes.


> >> +	ret = request_irq(keypad->irq, samsung_kp_interrupt, 0,
> >> +			dev_name(&pdev->dev), keypad);
> >> +
> >> +	if (ret)
NO PRINT HERE?

> >> +		goto err_disable_clk;
> >> +
> >> +	input_dev->name = pdev->name;
> >> +	input_dev->id.bustype = BUS_HOST;
> >> +	input_dev->dev.parent = &pdev->dev;
> >> +
> >> +	input_dev->evbit[0] = BIT_MASK(EV_KEY);
> >> +	if (pdata->rep)
> >> +		input_dev->evbit[0] |= BIT_MASK(EV_REP);
> >> +
> >> +	input_dev->keycode = keycodes;
> >> +	input_dev->keycodesize = sizeof(*keycodes);
> >> +	input_dev->keycodemax = pdata->rows << row_shift;
> >> +
> >> +	matrix_keypad_build_keymap(keymap_data, row_shift,
> >> +			input_dev->keycode, input_dev->keybit);
> >> +
> >> +	ret = input_register_device(keypad->input_dev);
> >> +	if (ret)
> >> +		goto err_free_irq;
> >> +
> >> +	platform_set_drvdata(pdev, keypad);
> >> +	clk_disable(keypad->clk);
> >> +
> >> +	return 0;
> >> +
> >> +err_free_irq:
> >> +	free_irq(keypad->irq, keypad);
> >> +err_disable_clk:
> >> +	clk_disable(keypad->clk);
> >> +	clk_put(keypad->clk);
> >> +err_unmap_base:
> >> +	iounmap(keypad->base);
> >> +err_free_mem:
> >> +	input_free_device(input_dev);
> >> +	kfree(keycodes);
> >> +	kfree(keypad);
> >> +
> >> +	return ret;
> >> +}
> >> +
> >> +static int __devexit samsung_kp_remove(struct platform_device *pdev)
> >> +{
> >> +	struct samsung_kp *keypad = platform_get_drvdata(pdev);
> >> +
> >> +	free_irq(keypad->irq, keypad);
> >> +	cancel_work_sync(&keypad->work);
> >> +	del_timer_sync(&keypad->timer);
> >> +
> >> +	platform_set_drvdata(pdev, NULL);
> >> +	input_unregister_device(keypad->input_dev);
> >> +
> >> +	clk_disable(keypad->clk);
> >> +	clk_put(keypad->clk);
> >> +
> >> +	iounmap(keypad->base);
> >> +	kfree(keypad->keycodes);
> >> +	kfree(keypad);
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +#ifdef CONFIG_PM
> >> +static int samsung_kp_suspend(struct device *dev)
> >> +{
> >> +	struct platform_device *pdev = to_platform_device(dev);
> >> +	struct samsung_kp *keypad = platform_get_drvdata(pdev);
> >> +
> >> +	disable_irq(keypad->irq);
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static int samsung_kp_resume(struct device pdev)
> >> +{
> >> +	struct platform_device *pdev = to_platform_device(dev);
> >> +	struct samsung_kp *keypad = platform_get_drvdata(pdev);
> >> +	unsigned int val;
> >> +
> >> +	clk_enable(keypad->clk);
> >> +
> >> +	/* enable interrupt and wakeup bit */
> >> +	val = SAMSUNG_INT_F_EN | SAMSUNG_INT_R_EN | SAMSUNG_WAKEUPEN;
> >> +	writel(val, keypad->base + SAMSUNG_KEYIFCON);
> >> +
> >> +	/* KEYIFCOL reg clear */
> >> +	writel(0, keypad->base + SAMSUNG_KEYIFCOL);
> >> +
> >> +	enable_irq(keypad->irq);
> >> +	clk_disable(keypad->clk);
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static const struct dev_pm_ops samsung_kp_pm_ops = {
> >> +	.suspend	= samsung_kp_suspend,
> >> +	.resume		= samsung_kp_resume,
> >> +};
> >> +#endif
> >> +
> >> +static struct platform_driver samsung_kp_driver = {
> >> +	.probe		= samsung_kp_probe,
> >> +	.remove		= __devexit_p(samsung_kp_remove),
> >> +	.driver		= {
> >> +		.name	= "samsung-keypad",
> >> +		.owner	= THIS_MODULE,
> >> +#ifdef CONFIG_PM
> >> +		.pm	= &samsung_kp_pm_ops,
> >> +#endif
> >> +	},
> >> +};
> >> +
> >> +static int __init samsung_kp_init(void)
> >> +{
> >> +	return platform_driver_register(&samsung_kp_driver);
> >> +}
> >> +
> >> +static void __exit samsung_kp_exit(void)
> >> +{
> >> +	platform_driver_unregister(&samsung_kp_driver);
> >> +}
> >> +
> >> +module_init(samsung_kp_init);
> >> +module_exit(samsung_kp_exit);
> >> +
> >> +MODULE_DESCRIPTION("Samsung keypad driver");
> >> +MODULE_AUTHOR("Joonyoung Shim <jy0922.shim@samsung.com>");
> >> +MODULE_AUTHOR("Donghwa Lee <dh09.lee@samsung.com>");
> >> +MODULE_LICENSE("GPL");

You missed MODULE_ALIAS() for your platform device name

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
