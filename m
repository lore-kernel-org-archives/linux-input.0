From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] GPIO driven matrix keypad driver
Date: Mon, 18 Aug 2008 13:17:54 -0400
Message-ID: <20080818115209.ZZRA012@mailhub.coreip.homeip.net>
References: <200808161922.36021.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.26]:32614 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752950AbYHRRSA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 18 Aug 2008 13:18:00 -0400
Received: by qw-out-2122.google.com with SMTP id 3so133989qwe.37
        for <linux-input@vger.kernel.org>; Mon, 18 Aug 2008 10:17:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200808161922.36021.marek.vasut@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marek Vasut <marek.vasut@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Marek,

On Sat, Aug 16, 2008 at 07:22:35PM +0200, Marek Vasut wrote:
> Hi,
> the following patch adds the generic GPIO driven matrix keypad driver. I 
> tested this on two devices I had available - palmtc and palmt3. It should be 
> able to replace corgikbd.c later as well, but I dont have that device. And 
> since this is platform independent driver, any chip that makes it's GPIOs 
> available through gpiolib should be OK with this driver as well. Please 
> consider applying.
> 

Thank you for your patch, I have a couple of comments:

> +
> +struct matrix_keypad {
> +	struct matrix_keypad_platform_data *pdata;
> +	struct input_dev *input_dev;
> +
> +	struct task_struct *kthread;
> +	unsigned char irqs;
> +
> +	/* on, off, alt flags */
> +	unsigned char *flags;
> +};

It would be great if the driver supported per-device keymaps that
coudl be altered from userspace via setkeycode/getkeycode.

> +
> +/*
> + * Lookup the key in our keymap
> + */
> +static unsigned int matrix_keypad_lookup(int row, int col,
> +				struct matrix_keypad *keypad)
> +{
> +	int i;
> +	struct matrix_keypad_platform_data *pdata = keypad->pdata;
> +
> +	for (i = 0; i < pdata->map_size; i++)
> +		if ((row == ((pdata->map[i]>>28) & 0xf)) &&
> +		     (col == ((pdata->map[i]>>24) & 0xf)))
> +			return pdata->map[i] & 0xfff;
> +	return 0xfff;
> +}
> +
> +/*
> + * This analyzes the key and reports it to the input subsystem
> + */
> +static unsigned int matrix_keypad_process(struct matrix_keypad *keypad,
> +					int i, int j)
> +{
> +	struct matrix_keypad_platform_data *pdata = keypad->pdata;
> +	int pressed = 0, key = 0, gpio;
> +
> +	gpio = gpio_get_value(pdata->col_gpio[j]);
> +	if (pdata->col_polarity)
> +		gpio = !gpio;
> +	if (gpio)
> +		pressed++;
> +	key = matrix_keypad_lookup(i, j, keypad);
> +	if (key == 0xfff)
> +		return pressed;
> +	if (key & KEY_SFT)
> +		input_report_key(keypad->input_dev, KEY_LEFTSHIFT, 1);
> +	if (gpio) {
> +		input_report_key(keypad->input_dev, key & 0x7ff, 1);
> +		keypad->flags[key / 8] |= 1 << (key % 8);
> +	} else if ((keypad->flags[key / 8] & (1 << (key % 8))) && !gpio) {
> +		input_report_key(keypad->input_dev, key & 0x7ff, 0);
> +		keypad->flags[key / 8] &= ~(1 << (key % 8));
> +	}
> +	if (key & KEY_SFT)
> +		input_report_key(keypad->input_dev, KEY_LEFTSHIFT, 0);
> +

This is extremely fragile and will not work on certain keymaps that
have upper and lower register switched around.

> +	return pressed;
> +}
> +
> +/*
> + * This gets the keys from keyboard
> + */
> +static int matrix_keypad_thread(void *arg)
> +{
> +	int i, j, pressed;
> +	struct matrix_keypad *keypad = arg;
> +	struct matrix_keypad_platform_data *pdata = keypad->pdata;
> +
> +	set_freezable();
> +	while (!kthread_should_stop()) {
> +		if (try_to_freeze())
> +			continue;
> +

Hmm, a thread per device seems a bit wasteful, I wonder if we could
make input-polldev framefork work here...

> +		pressed = 0;
> +
> +		/* set all unreadable */
> +		for (i = 0; i < pdata->row_gpio_size; i++)
> +			gpio_set_value(pdata->row_gpio[i], pdata->row_polarity);
> +
> +		/* read the keypad matrix */
> +		for (i = 0; i < pdata->row_gpio_size; i++) {
> +			gpio_set_value(pdata->row_gpio[i],
> +					!pdata->row_polarity);
> +			udelay(pdata->gpio_delay);
> +
> +			for (j = 0; j < pdata->col_gpio_size; j++)
> +				pressed += matrix_keypad_process(keypad, i, j);
> +
> +			gpio_set_value(pdata->row_gpio[i], pdata->row_polarity);
> +			udelay(pdata->gpio_delay);
> +		}
> +
> +		/* set all readable */
> +		for (i = 0; i < pdata->row_gpio_size; i++)
> +			gpio_set_value(pdata->row_gpio[i],
> +					!pdata->row_polarity);
> +
> +
> +		/* report to input subsystem */
> +		input_sync(keypad->input_dev);
> +
> +		if (pressed)
> +			msleep(pdata->scan_delay);
> +		else {
> +			/* reenable interrupts */
> +			if (!keypad->irqs) {
> +				for (i = 0; i < pdata->col_gpio_size; i++)
> +					enable_irq(gpio_to_irq(
> +							pdata->col_gpio[i]));
> +				keypad->irqs = 1;
> +			}
> +			schedule();
> +		}
> +	}
> +	return 0;
> +}
> +
> +/*
> + * Interrupt handler
> + */
> +static irqreturn_t matrix_keypad_interrupt(int irq, void *id)
> +{
> +	struct matrix_keypad *keypad = id;
> +	unsigned long flags;
> +	int i;
> +
> +	/* disable interrupts as soon as possible */
> +	local_irq_save(flags);
> +	if (keypad->irqs) {
> +		for (i = 0; i < keypad->pdata->col_gpio_size; i++)
> +			disable_irq(gpio_to_irq(keypad->pdata->col_gpio[i]));
> +		keypad->irqs = 0;
> +		wake_up_process(keypad->kthread);
> +	}
> +	local_irq_restore(flags);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +#ifdef CONFIG_PM
> +static int matrix_keypad_suspend(struct platform_device *dev,
> +				pm_message_t state)
> +{
> +	struct matrix_keypad *keypad = platform_get_drvdata(dev);
> +
> +	return keypad->pdata->suspend ?
> +		keypad->pdata->suspend(dev, state) : 0;
> +}
> +
> +static int matrix_keypad_resume(struct platform_device *dev)
> +{
> +	struct matrix_keypad *keypad = platform_get_drvdata(dev);
> +
> +	return keypad->pdata->resume ? keypad->pdata->resume(dev) : 0;
> +}
> +#else
> +#define matrix_keypad_suspend	NULL
> +#define matrix_keypad_resume	NULL
> +#endif
> +
> +/*
> + * Everything starts here
> + */
> +static int __init matrix_keypad_probe(struct platform_device *pdev)

__devinit, not __init.

> +{
> +	struct matrix_keypad *keypad;
> +	struct input_dev *input_dev;
> +	int i, err = -ENOMEM;
> +
> +	keypad = kzalloc(sizeof(struct matrix_keypad), GFP_KERNEL);
> +	input_dev = input_allocate_device();
> +	if (!keypad || !input_dev)
> +		goto fail;
> +
> +	platform_set_drvdata(pdev, keypad);
> +
> +	keypad->input_dev = input_dev;
> +	keypad->pdata = pdev->dev.platform_data;
> +	keypad->flags = kzalloc(4 * KEY_CNT, GFP_KERNEL);
> +	if (!keypad->flags)
> +		goto fail;
> +
> +	input_dev->name = pdev->name;
> +	input_dev->id.bustype = BUS_HOST;
> +	input_dev->dev.parent = &pdev->dev;
> +
> +	input_dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_REP) |
> +		BIT_MASK(EV_PWR) | BIT_MASK(EV_SW);

I don't see where use setting dev->swbit and it does not send/receive
EV_PVR either so why do you set these bits?

> +	input_dev->keycodesize = sizeof(unsigned int);
> +
> +	for (i = 0; i < keypad->pdata->map_size; i++) {
> +		if ((keypad->pdata->map[i] & 0xfff) != 0xfff)
> +			set_bit((keypad->pdata->map[i] & 0xfff),
> +				input_dev->keybit);
> +		if (((keypad->pdata->map[i] >> 12) & 0xfff) != 0xfff)
> +			set_bit((keypad->pdata->map[i] >> 12) & 0xfff,
> +				input_dev->keybit);
> +	}
> +
> +	err = input_register_device(keypad->input_dev);
> +	if (err)
> +		goto fail;
> +
> +	for (i = 0; i < keypad->pdata->col_gpio_size; i++) {
> +		err = gpio_request(keypad->pdata->col_gpio[i], "KBD_IRQ");
> +		if (err)
> +			goto gpio_err;
> +		err = gpio_direction_input(keypad->pdata->col_gpio[i]);
> +		if (err) {
> +			gpio_free(keypad->pdata->col_gpio[i]);
> +			goto gpio_err;
> +		}
> +		if (request_irq(gpio_to_irq(keypad->pdata->col_gpio[i]),
> +				matrix_keypad_interrupt, IRQF_DISABLED |
> +				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING |
> +				IRQF_SAMPLE_RANDOM,
> +				"matrix-keypad", keypad)) {
> +			printk(KERN_ERR "Unable to acquire interrupt"
> +				" for GPIO line %i\n",
> +				keypad->pdata->col_gpio[i]);
> +			gpio_free(keypad->pdata->col_gpio[i]);
> +			goto gpio_err;
> +		}
> +	}
> +
> +	/* Set strobe lines as outputs, low */
> +	for (i = 0; i < keypad->pdata->row_gpio_size; i++) {
> +		err = gpio_request(keypad->pdata->row_gpio[i], "KBD_LINE");
> +		if (err)
> +			goto gpio_err2;
> +		err = gpio_direction_output(keypad->pdata->row_gpio[i],
> +				    !keypad->pdata->row_polarity);
> +		if (err) {
> +			gpio_free(keypad->pdata->row_gpio[i]);
> +			goto gpio_err2;
> +		}
> +	}
> +	keypad->irqs = 1;
> +	keypad->kthread = kthread_run(matrix_keypad_thread, keypad, "matrix");
> +	if (IS_ERR(keypad->kthread))
> +		goto thread_err;
> +
> +	return 0;
> +
> +thread_err:
> +	i = keypad->pdata->row_gpio_size;
> +gpio_err2:
> +	for (i = i-1; i >= 0; i--)
> +		gpio_free(keypad->pdata->row_gpio[i]);
> +	for (i = 0; i < keypad->pdata->col_gpio_size; i++) {
> +		free_irq(gpio_to_irq(keypad->pdata->col_gpio[i]), keypad);
> +		gpio_free(keypad->pdata->col_gpio[i]);
> +	}
> +	goto fail;
> +gpio_err:
> +	for (i = i-1; i >= 0; i--) {
> +		free_irq(gpio_to_irq(keypad->pdata->col_gpio[i]), keypad);
> +		gpio_free(keypad->pdata->col_gpio[i]);
> +	}
> +fail:	input_free_device(input_dev);

Error handling is incomplete.. After device was registered it needs to
be unregistered (without calling input_free_device).

> +	kfree(keypad);
> +	return err;
> +}
> +
> +/*
> + * Everything ends here
> + */
> +static int matrix_keypad_remove(struct platform_device *pdev)
> +{

This one can be marked __devexit.

> +	int i;
> +	struct matrix_keypad *keypad = platform_get_drvdata(pdev);
> +
> +	kthread_stop(keypad->kthread);
> +
> +	for (i = 0; i < keypad->pdata->col_gpio_size; i++) {
> +		free_irq(gpio_to_irq(keypad->pdata->col_gpio[i]),
> +				    keypad);
> +		gpio_free(keypad->pdata->col_gpio[i]);
> +	}
> +
> +	for (i = 0; i < keypad->pdata->row_gpio_size; i++)
> +		gpio_free(keypad->pdata->row_gpio[i]);
> +
> +	input_unregister_device(keypad->input_dev);
> +
> +	kfree(keypad->flags);
> +	kfree(keypad);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver matrix_keypad_driver = {
> +	.probe		= matrix_keypad_probe,
> +	.remove		= matrix_keypad_remove,

__devexit_p().

> +	.suspend	= matrix_keypad_suspend,
> +	.resume		= matrix_keypad_resume,
> +	.driver		= {
> +		.name	= "matrix-keypad",
> +		.owner	= THIS_MODULE,
> +	},
> +};
> +
> +static int __devinit matrix_keypad_init(void)
> +{
> +	return platform_driver_register(&matrix_keypad_driver);
> +}
> +
> +static void __exit matrix_keypad_exit(void)
> +{
> +	platform_driver_unregister(&matrix_keypad_driver);
> +}
> +
> +module_init(matrix_keypad_init);
> +module_exit(matrix_keypad_exit);
> +
> +MODULE_AUTHOR("Marek Vasut <marek.vasut@gmail.com>");
> +MODULE_DESCRIPTION("GPIO Driven Matrix Keypad Driver");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform:matrix-keypad");
> diff --git a/include/linux/matrix_keypad.h b/include/linux/matrix_keypad.h
> new file mode 100644
> index 0000000..653b33c
> --- /dev/null
> +++ b/include/linux/matrix_keypad.h
> @@ -0,0 +1,39 @@
> +#ifndef _MATRIX_KEYPAD_H
> +#define _MATRIX_KEYPAD_H
> +
> +#include <linux/input.h>
> +
> +struct matrix_keypad_platform_data {
> +
> +	/* code map for the matrix keys */
> +	unsigned int	*map;
> +	int		map_size;
> +
> +	unsigned int	*col_gpio;
> +	int		col_gpio_size;
> +	unsigned int	*row_gpio;
> +	int		row_gpio_size;
> +
> +	/* line polarities */
> +	unsigned int	col_polarity;
> +	unsigned int	row_polarity;
> +
> +	/* key debounce interval */
> +	unsigned int	scan_delay;
> +
> +	/* GPIO level change delay */
> +	unsigned int	gpio_delay;
> +
> +	/* Callbacks */
> +	int (*suspend)(struct platform_device *dev, pm_message_t state);
> +	int (*resume)(struct platform_device *dev);
> +};
> +
> +#define KEY(row, col, val)	(((row) << 28) | ((col) << 24) | (val & 0xfff))
> +
> +/* key not connected */
> +#define KEY_NC	0xfff
> +/* key to be pressed with shift */
> +#define KEY_SFT	0x800
> +
> +#endif /* _MATRIX_KEYPAD_H */
> -- 
> 1.5.6
> 


-- 
Dmitry
