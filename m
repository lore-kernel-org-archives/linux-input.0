From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] input: add support for generic GPIO-based matrix keypad
Date: Sun, 31 May 2009 15:20:27 +0100
Message-ID: <20090531142027.GA22540@n2100.arm.linux.org.uk>
References: <f17812d70905070100u406614cag1ea1ea913577bbd8@mail.gmail.com> <200905271526.59064.u.luckas@road.de> <f17812d70905310712n4aa12acfm6c8d5c9cab4c3179@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:49893 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753472AbZEaOUl (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 31 May 2009 10:20:41 -0400
Content-Disposition: inline
In-Reply-To: <f17812d70905310712n4aa12acfm6c8d5c9cab4c3179@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Eric Miao <eric.y.miao@gmail.com>
Cc: Uli Luckas <u.luckas@road.de>, linux-arm-kernel@lists.arm.linux.org.uk, Marek Vasut <marek.vasut@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Sun, May 31, 2009 at 10:12:25PM +0800, Eric Miao wrote:
> +static void __devinit build_keycodes(struct matrix_keypad *keypad)
> +{
> +	struct matrix_keypad_platform_data *pdata = keypad->pdata;
> +	struct input_dev *input_dev = keypad->input_dev;
> +	uint32_t *key;
> +	int i;
> +
> +	keypad->keycodes = kzalloc(MATRIX_MAX_KEYS * sizeof(int), GFP_KERNEL);

This doesn't check for failure...

> +static int __devinit matrix_keypad_probe(struct platform_device *pdev)
> +{
> +	struct matrix_keypad_platform_data *pdata;
> +	struct matrix_keypad *keypad;
> +	struct input_dev *input_dev;
> +	int err = -ENOMEM;
> +
> +	if ((pdata = pdev->dev.platform_data) == NULL) {
> +		dev_err(&pdev->dev, "no platform data defined\n");
> +		return -EINVAL;
> +	}
> +
> +	keypad = kzalloc(sizeof(struct matrix_keypad), GFP_KERNEL);
> +	if (keypad == NULL)
> +		return -ENOMEM;
> +
> +	input_dev = input_allocate_device();
> +	if (!input_dev)
> +		goto err_free_keypad;
> +
> +	platform_set_drvdata(pdev, keypad);
> +
> +	keypad->input_dev = input_dev;
> +	keypad->pdata = pdata;
> +	INIT_DELAYED_WORK(&keypad->work, matrix_keypad_scan);
> +
> +	input_dev->name		= pdev->name;
> +	input_dev->id.bustype	= BUS_HOST;
> +	input_dev->dev.parent	= &pdev->dev;
> +	input_dev->evbit[0]	= BIT_MASK(EV_KEY) | BIT_MASK(EV_REP);
> +
> +	build_keycodes(keypad);
> +
> +	err = input_register_device(keypad->input_dev);
> +	if (err)
> +		goto err_free_input;
> +
> +	err = init_matrix_gpio(keypad);
> +	if (err)
> +		goto err_unregister;
> +
> +	return 0;
> +
> +err_unregister:
> +	input_unregister_device(input_dev);

I don't see keypad->keycodes being kfree'd

> +err_free_input:
> +	input_free_device(input_dev);
> +err_free_keypad:
> +	kfree(keypad);
> +	return err;
> +}
> +
> +static int __devexit matrix_keypad_remove(struct platform_device *pdev)
> +{
> +	struct matrix_keypad *keypad = platform_get_drvdata(pdev);
> +	int i;
> +
> +	for (i = 0; i < keypad->pdata->num_row_gpios; i++) {
> +		free_irq(gpio_to_irq(keypad->pdata->row_gpios[i]), keypad);
> +		gpio_free(keypad->pdata->row_gpios[i]);
> +	}
> +
> +	for (i = 0; i < keypad->pdata->num_col_gpios; i++)
> +		gpio_free(keypad->pdata->col_gpios[i]);
> +
> +	input_unregister_device(keypad->input_dev);

Nor here.
