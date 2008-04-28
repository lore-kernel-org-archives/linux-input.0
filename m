From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [HP6xx/Patch] - update touchscreen driver
Date: Mon, 28 Apr 2008 12:00:27 -0400
Message-ID: <20080428114945.ZZRA012@mailhub.coreip.homeip.net>
References: <20080427164944.dd3ce43e.Kristoffer.Ericson@Gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20080427164944.dd3ce43e.Kristoffer.Ericson@Gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Cc: linux-input <linux-input@atrey.karlin.mff.cuni.cz>, linux-sh <linux-sh@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi Kristoffer,

On Sun, Apr 27, 2008 at 04:49:44PM +0200, Kristoffer Ericson wrote:
> -
> -static struct input_dev *hp680_ts_dev;
> +struct input_dev *dev;

Why does it need to be global? dev a a name is ratehr non-descriptive
too given that we are dealing with input devices, platform devices and
other kinds of devices.

> +static void do_softint(struct delayed_work *work);
>  static DECLARE_DELAYED_WORK(work, do_softint);
>  
> -static void do_softint(struct work_struct *work)
> +static void do_softint(struct delayed_work *work)
>  {
>  	int absx = 0, absy = 0;
>  	u8 scpdr;
> @@ -53,77 +56,104 @@ static void do_softint(struct work_struct *work)
>  		touched = ctrl_inb(PHDR) & PHDR_TS_PEN_DOWN;
>  	}
>  
> +
> +	/* note, tslib currently expects ABS_PRESSURE also */

But that will change in the future... I dont see the need for such
comment.

>  	if (touched) {
> -		input_report_key(hp680_ts_dev, BTN_TOUCH, 1);
> -		input_report_abs(hp680_ts_dev, ABS_X, absx);
> -		input_report_abs(hp680_ts_dev, ABS_Y, absy);
> +		input_report_abs(dev, ABS_X, absx);
> +		input_report_abs(dev, ABS_Y, absy);
> +		input_report_key(dev, BTN_TOUCH, 1);
>  	} else {
> -		input_report_key(hp680_ts_dev, BTN_TOUCH, 0);
> +		input_report_key(dev, BTN_TOUCH, 0);
>  	}
> -
> -	input_sync(hp680_ts_dev);
> +	input_sync(dev);
>  	enable_irq(HP680_TS_IRQ);
>  }
>  
> -static irqreturn_t hp680_ts_interrupt(int irq, void *dev)
> +static irqreturn_t hp680_ts_interrupt(int irq, void *pdev)
>  {
>  	disable_irq_nosync(irq);
>  	schedule_delayed_work(&work, HZ / 20);
> -
>  	return IRQ_HANDLED;
>  }
>  
> -static int __init hp680_ts_init(void)
> +static int __devinit jornada680_ts_probe(struct platform_device *pdev)
>  {
> -	int err;
> +	int error;
>  
> -	hp680_ts_dev = input_allocate_device();
> -	if (!hp680_ts_dev)
> -		return -ENOMEM;
> +	dev = input_allocate_device();
>  
> -	hp680_ts_dev->evbit[0] = BIT_MASK(EV_ABS) | BIT_MASK(EV_KEY);
> -	hp680_ts_dev->keybit[BIT_WORD(BTN_TOUCH)] = BIT_MASK(BTN_TOUCH);
> +	if (!dev) {
> +		printk(KERN_INFO "ts: failed to allocate device\n");

Just "ts:"? "<driver name>: " is usually more informative.

> +		error = -ENODEV;

-ENOMEM

> +		return error;
> +	}
>  
> -	input_set_abs_params(hp680_ts_dev, ABS_X,
> -		HP680_TS_ABS_X_MIN, HP680_TS_ABS_X_MAX, 0, 0);
> -	input_set_abs_params(hp680_ts_dev, ABS_Y,
> -		HP680_TS_ABS_Y_MIN, HP680_TS_ABS_Y_MAX, 0, 0);
> +	dev->name = "HP Jornada 6xx Touchscreen";
> +	dev->phys = "jornadats/input0";

"jornada_ts/input0"

> +	dev->id.bustype = BUS_HOST;
> +	dev->dev.parent = &pdev->dev;
> +	dev->evbit[0] = BIT_MASK(EV_ABS) | BIT_MASK(EV_KEY);
> +	dev->absbit[0] = BIT_MASK(ABS_X) | BIT_MASK(ABS_Y);
> +	dev->keybit[BIT_WORD(BTN_TOUCH)] = BIT_MASK(BTN_TOUCH);
> +	input_set_abs_params(dev, ABS_X, 40, 950, 0, 0);
> +	input_set_abs_params(dev, ABS_Y, 80, 910, 0, 0);
> +
> +	error = input_register_device(dev);
> +	if (error) {
> +		printk(KERN_ERR "ts: failed to register device\n");
> +		goto fail2;
> +	}
>  
> -	hp680_ts_dev->name = "HP Jornada touchscreen";
> -	hp680_ts_dev->phys = "hp680_ts/input0";
> +	error = request_irq(HP680_TS_IRQ, hp680_ts_interrupt,
> +			IRQF_DISABLED, "HP6xx Touchscreen driver", NULL);
>  
> -	if (request_irq(HP680_TS_IRQ, hp680_ts_interrupt,
> -			IRQF_DISABLED, MODNAME, 0) < 0) {
> -		printk(KERN_ERR "hp680_touchscreen.c: Can't allocate irq %d\n",
> -		       HP680_TS_IRQ);
> -		err = -EBUSY;
> -		goto fail1;
> +	if (error) {
> +		printk(KERN_INFO "ts: unable to aquire irq\n");

acquire.

> +		goto fail3;
>  	}
>  
> -	err = input_register_device(hp680_ts_dev);
> -	if (err)
> -		goto fail2;
> -
>  	return 0;
>  
> - fail2:	free_irq(HP680_TS_IRQ, NULL);
> -	cancel_delayed_work(&work);
> -	flush_scheduled_work();
> - fail1:	input_free_device(hp680_ts_dev);
> -	return err;
> +fail3:
> +		input_unregister_device(dev);
> +fail2:
> +		input_free_device(dev);

Dont ever call input_free_device() after calling
input_unregister_device(). The old flow was correct.

> +	return error;
>  }
>  
> -static void __exit hp680_ts_exit(void)
> +static int __devexit jornada680_ts_remove(struct platform_device *pdev)
>  {
> -	free_irq(HP680_TS_IRQ, NULL);
>  	cancel_delayed_work(&work);
>  	flush_scheduled_work();
> -	input_unregister_device(hp680_ts_dev);
> +	free_irq(HP680_TS_IRQ, pdev);

You have to free IRQ first. Or disable it. Otherwise you may get
another work scheduled after you flush it.

> +	input_unregister_device(dev);
> +	return 0;
> +}
> +
> +/* work with hotplug and coldplug */
> +MODULE_ALIAS("platform:jornada_ts");
> +
> +static struct platform_driver jornada680_ts_driver = {
> +	.probe	= jornada680_ts_probe,
> +	.remove	= jornada680_ts_remove,
> +	.driver = {
> +		.name = "jornada_ts",
> +		.owner= THIS_MODULE,
> +	},
> +};
> +
> +static int __init hp680_ts_init(void)
> +{
> +	return platform_driver_register(&jornada680_ts_driver);
>  }
>  
> +static void __exit hp680_ts_exit(void)
> +{
> +	platform_driver_unregister(&jornada680_ts_driver);
> +}
>  module_init(hp680_ts_init);
>  module_exit(hp680_ts_exit);
>  
> -MODULE_AUTHOR("Andriy Skulysh, askulysh@image.kiev.ua");
> -MODULE_DESCRIPTION("HP Jornada 680 touchscreen driver");
> +MODULE_AUTHOR("Andriy Skulysh <askulysh@image.kiev.ua>, Kristoffer Ericson <Kristoffer.Ericson@gmail.com>");
> +MODULE_DESCRIPTION("HP Jornada 6xx touchscreen driver");
>  MODULE_LICENSE("GPL");

-- 
Dmitry
