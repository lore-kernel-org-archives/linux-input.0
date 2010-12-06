From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v1] input/tc3589x: add tc3589x keypad support
Date: Mon, 6 Dec 2010 09:45:15 -0800
Message-ID: <20101206174515.GA16471@core.coreip.homeip.net>
References: <1291648208-16611-1-git-send-email-sundar.iyer@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:64925 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752049Ab0LFRp0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 6 Dec 2010 12:45:26 -0500
Received: by pwj3 with SMTP id 3so1940706pwj.19
        for <linux-input@vger.kernel.org>; Mon, 06 Dec 2010 09:45:25 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1291648208-16611-1-git-send-email-sundar.iyer@stericsson.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sundar Iyer <sundar.iyer@stericsson.com>
Cc: tsoni@codeaurora.org, linux-input@vger.kernel.org

Hi Sundar,

On Mon, Dec 06, 2010 at 08:40:08PM +0530, Sundar Iyer wrote:
> Add support for the keypad controller module found on the
> TC3589X devices. This driver default adds the support for
> TC35893 device.
> 
> Signed-off-by: Sundar Iyer <sundar.iyer@stericsson.com>
> ---
> Changes:
>  -v1: review comments from Trilok to include open/close and
>       using read/write mfd APIs instead of abusing set_bits

I have a few comments but these are minor, more like nitpicks. Once they
are fixed you may add:

	Acked-by: Dmitry Torokhov <dtor@mail.ru>

Since this patch depends on your other tc3589x changes I'd expect it to
be merged through MFD tree.

> +config KEYBOARD_TC3589X
> +	tristate "TC3589X Keypad support"
> +	depends on MFD_TC3589X
> +	help
> +	  Say Y here if you want to use the keypad controller on
> +	  TC35892/3 I/O expander

Sentences should end with a period.

> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called tc3589x-keypad

Same here.

> +
> +static int __devinit tc3589x_keypad_init_key_hardware(struct tc_keypad *keypad)
> +{
> +	int ret;
> +	struct tc3589x *tc3589x = keypad->tc3589x;
> +	u8 settle_time = keypad->board->settle_time;
> +	u8 dbounce_period = keypad->board->debounce_period;
> +	u8 rows = keypad->board->krow & 0xf;	/* mask out the nibble */
> +	u8 column = keypad->board->kcol & 0xf;	/* mask out the nibble */
> +
> +	/* validate platform configurations */
> +	if ((keypad->board->kcol > TC3589x_MAX_KPCOL) ||
> +	    (keypad->board->krow > TC3589x_MAX_KPROW) ||
> +	    (keypad->board->debounce_period > TC3589x_MAX_DEBOUNCE_SETTLE) ||
> +	    (keypad->board->settle_time > TC3589x_MAX_DEBOUNCE_SETTLE))
> +		return -EINVAL;

Too many unneeded parens.

> +
> +static irqreturn_t tc3589x_keypad_irq(int irq, void *dev)
> +{
> +	struct tc_keypad *keypad = dev;
> +	struct tc3589x *tc3589x = keypad->tc3589x;
> +	u8 i, row_index, col_index, kbd_code, up;
> +	u8 code;
> +
> +	for (i = 0; i < (TC35893_DATA_REGS * 2); i++) {

Unneeded parens.

> +		kbd_code = tc3589x_reg_read(tc3589x, TC3589x_EVTCODE_FIFO);
> +
> +		/* loop till fifo is empty and no more keys are pressed */
> +		if ((kbd_code == TC35893_KEYCODE_FIFO_EMPTY) ||
> +				(kbd_code == TC35893_KEYCODE_FIFO_CLEAR))
> +			continue;

Same here.

> +
> +static int __devinit tc3589x_keypad_probe(struct platform_device *pdev)
> +{
> +	struct tc3589x *tc3589x = dev_get_drvdata(pdev->dev.parent);
> +	struct tc_keypad *keypad;
> +	struct input_dev *input;
> +	const struct tc3589x_keypad_platform_data *plat;
> +	int error, irq;
> +
> +	plat  = tc3589x->pdata->keypad;

Extra space before assignment.

> +	if (!plat) {
> +		dev_err(&pdev->dev, "invalid keypad platform data\n");
> +		return -EINVAL;
> +	}
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return irq;
> +
> +	keypad = kzalloc(sizeof(struct tc_keypad), GFP_KERNEL);
> +	input = input_allocate_device();
> +	if (!keypad || !input) {
> +		dev_err(&pdev->dev, "failed to allocate keypad memory\n");
> +		error = -ENOMEM;
> +		goto err_free_mem;
> +	}
> +
> +	keypad->board = plat;
> +	keypad->input = input;
> +	keypad->tc3589x = tc3589x;
> +
> +	input->id.bustype = BUS_I2C;
> +	input->name = pdev->name;
> +	input->dev.parent = &pdev->dev;
> +
> +	input->keycode = keypad->keymap;
> +	input->keycodesize = sizeof(keypad->keymap[0]);
> +	input->keycodemax = ARRAY_SIZE(keypad->keymap);
> +
> +	input->open = tc3589x_keypad_open;
> +	input->close = tc3589x_keypad_close;
> +
> +	input_set_drvdata(input, keypad);
> +
> +	input_set_capability(input, EV_MSC, MSC_SCAN);
> +
> +	__set_bit(EV_KEY, input->evbit);
> +	if (!plat->no_autorepeat)
> +		__set_bit(EV_REP, input->evbit);
> +
> +	matrix_keypad_build_keymap(plat->keymap_data, 0x3,
> +			input->keycode, input->keybit);
> +
> +	error = request_threaded_irq(irq, NULL,
> +			tc3589x_keypad_irq, plat->irqtype,
> +			"tc3589x-keypad", keypad);
> +	if (error < 0) {
> +		dev_err(&pdev->dev,
> +				"Could not allocate irq %d,error %d\n",
> +				irq, error);
> +		goto err_free_mem;
> +	}
> +
> +	error = input_register_device(input);
> +	if (error) {
> +		dev_err(&pdev->dev, "Could not register input device\n");
> +		goto err_free_irq;
> +	}

I do not see where you'd enable the keypad. What will happen if you
unbind/unload the driver (which will cause explicit call to disable) and
then try loading the module again?

> +
> +	/* let platform decide if keypad is a wakeup source or not */
> +	device_init_wakeup(&pdev->dev, plat->enable_wakeup);
> +	device_set_wakeup_capable(&pdev->dev, plat->enable_wakeup);
> +
> +	platform_set_drvdata(pdev, keypad);
> +
> +	return 0;
> +
> +err_free_irq:
> +	free_irq(irq, keypad);
> +err_free_mem:
> +	input_free_device(input);
> +	kfree(keypad);
> +	return error;
> +}
> +
> +static int __devexit tc3589x_keypad_remove(struct platform_device *pdev)
> +{
> +	struct tc_keypad *keypad = platform_get_drvdata(pdev);
> +	struct tc3589x *tc3589x = keypad->tc3589x;
> +	int irq = platform_get_irq(pdev, 0);
> +
> +	free_irq(irq, keypad);
> +
> +	input_unregister_device(keypad->input);
> +
> +	tc3589x_keypad_disable(tc3589x);

Should this be done before freeing IRQ?

> +
> +/**
> + * struct tc35893_platform_data - data structure for platform specific data
> + * @keymap_data:        matrix scan code table for keycodes
> + * @krow:               mask for available rows, value is 0xFF
> + * @kcol:               mask for available columns, value is 0xFF
> + * @debounce_period:    platform specific debounce time
> + * @settle_time:        platform specific settle down time
> + * @irqtype:            type of interrupt, falling or rising edge
> + * @enable_wakeup:      specifies if keypad event can wake up system from sleep
> + * @no_autorepeat:      flag for auto repetition
> + */
> +struct tc3589x_keypad_platform_data {
> +	struct matrix_keymap_data *keymap_data;

Const I think.

> +	u8                      krow;
> +	u8                      kcol;
> +	u8                      debounce_period;
> +	u8                      settle_time;
> +	unsigned long           irqtype;
> +	bool                    enable_wakeup;
> +	bool                    no_autorepeat;
> +};
> +
>  /**
>   * struct tc3589x_gpio_platform_data - TC3589x GPIO platform data
>   * @gpio_base: first gpio number assigned to TC3589x.  A maximum of
> @@ -130,11 +180,13 @@ struct tc3589x_gpio_platform_data {
>   * @block: bitmask of blocks to enable (use TC3589x_BLOCK_*)
>   * @irq_base: base IRQ number.  %TC3589x_NR_IRQS irqs will be used.
>   * @gpio: GPIO-specific platform data
> + * @keypad: keypad-specific platform data
>   */
>  struct tc3589x_platform_data {
>  	unsigned int block;
>  	int irq_base;
>  	struct tc3589x_gpio_platform_data *gpio;
> +	struct tc3589x_keypad_platform_data *keypad;

const here too.

Thanks.

-- 
Dmitry
