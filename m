From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v5] input: MXC: add mxc-keypad driver to support the
 Keypad Port present in the mxc application processors family.
Date: Fri, 29 Jan 2010 13:50:15 -0800
Message-ID: <20100129215015.GA26720@core.coreip.homeip.net>
References: <1264799926.2975.3.camel@realization>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f190.google.com ([209.85.222.190]:44707 "EHLO
	mail-pz0-f190.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751600Ab0A2Vun (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 29 Jan 2010 16:50:43 -0500
Received: by pzk28 with SMTP id 28so1900553pzk.4
        for <linux-input@vger.kernel.org>; Fri, 29 Jan 2010 13:50:42 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1264799926.2975.3.camel@realization>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alberto Panizzo <maramaopercheseimorto@gmail.com>
Cc: Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>, H Hartley Sweeten <hartleys@visionengravers.com>, Sascha linux-arm <s.hauer@pengutronix.de>, linux-input <linux-input@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

Hi Alberto,

On Fri, Jan 29, 2010 at 10:18:46PM +0100, Alberto Panizzo wrote:
> +
> +/* mxc_keypad_check_for_events is the timer handler.
> + * It is executed in a non interruptible area of the kernel (Soft interrupt) */
> +static void mxc_keypad_check_for_events(unsigned long data)
> +{
> +	struct mxc_keypad *keypad = (struct mxc_keypad *) data;
> +	struct input_dev *input_dev = keypad->input_dev;
> +	unsigned short matrix_volatile_state[MAX_MATRIX_KEY_COLS];
> +	unsigned short reg_val;
> +	bool state_changed, is_zero_matrix;
> +	int i;
> +
> +	memset(matrix_volatile_state, 0, sizeof(matrix_volatile_state));
> +
> +	/* Before exit fire key release events. */
> +	if (keypad->exit_flag) {
> +		dev_dbg(&input_dev->dev, "%s: exiting.\n", __func__);
> +		mxc_keypad_fire_events(keypad, matrix_volatile_state);

Input core already does it no device disconnect, no need to do this
here I think.

> +		return;
> +	}
> +
> +	mxc_keypad_scan_matrix(keypad, matrix_volatile_state);
> +
> +	state_changed = false;
> +	for (i = 0; (i < MAX_MATRIX_KEY_COLS) && !state_changed; i++) {
> +		if ((keypad->cols_en_mask & (1 << i)) == 0)
> +			continue;
> +
> +		if (keypad->matrix_unstable_state[i] ^
> +						matrix_volatile_state[i])
> +			state_changed = true;
> +	}
> +
> +	/* If the matrix state is changed from the previous scan
> +	 *   (Re)Begin the debouncing process, saving the new state in
> +	 *    keypad->matrix_unstable_state.
> +	 * else
> +	 *   Increase the count of number of scans with a stable state.*/
> +	if (state_changed) {
> +		memcpy(keypad->matrix_unstable_state, matrix_volatile_state,
> +						sizeof(matrix_volatile_state));
> +		keypad->stable_count = 0;
> +	} else
> +		keypad->stable_count++;
> +
> +	/* If the matrix is not as stable as we want reschedule a matrix scan
> +	 * near in the future. */
> +	if (keypad->stable_count < MXC_KEYPAD_SCANS_FOR_STABILITY) {
> +		mod_timer(&keypad->check_matrix_timer,
> +			  jiffies + msecs_to_jiffies(2));

2ms is too fast IMO; 10 ms is more realistic.

> +		return;
> +	}
> +
> +	/* If the matrix is stable as we need, fire the events and save the new
> +	 * stable state.
> +	 * Note, if the matrix is more stable (keypad->stable_count >
> +	 * MXC_KEYPAD_SCANS_FOR_STABILITY)all events are already fired.We are in
> +	 * the loop of multiple key pressure detection waiting for a change. */
> +	if (keypad->stable_count == MXC_KEYPAD_SCANS_FOR_STABILITY) {
> +		mxc_keypad_fire_events(keypad, matrix_volatile_state);
> +
> +		memcpy(keypad->matrix_stable_state, matrix_volatile_state,
> +						sizeof(matrix_volatile_state));
> +	}
> +
> +	is_zero_matrix = true;
> +	for (i = 0; (i < MAX_MATRIX_KEY_COLS) && is_zero_matrix; i++)
> +		if (matrix_volatile_state[i] != 0)
> +			is_zero_matrix = false;
> +
> +
> +	if (is_zero_matrix) {
> +		/* No keys are still pressed.
> +		 * Enable only the KDI interrupt for future key pressures.
> +		 * (clear the KDI status bit and his sync chain before) */
> +		reg_val = readw(keypad->mmio_base + KPSR);
> +		reg_val |= KBD_STAT_KPKD | KBD_STAT_KDSC;
> +		writew(reg_val, keypad->mmio_base + KPSR);
> +
> +		reg_val = readw(keypad->mmio_base + KPSR);
> +		reg_val |= KBD_STAT_KDIE;
> +		reg_val &= ~KBD_STAT_KRIE;
> +		writew(reg_val, keypad->mmio_base + KPSR);
> +	} else {
> +		/* Still there are keys pressed. Schedule a rescan for multiple
> +		 * key pressure detection and enable the KRI interrupt for fast
> +		 * reaction to an all key release event. */
> +		mod_timer(&keypad->check_matrix_timer,
> +						jiffies + msecs_to_jiffies(60));
> +
> +		reg_val = readw(keypad->mmio_base + KPSR);
> +		reg_val |= KBD_STAT_KPKR | KBD_STAT_KRSS;
> +		writew(reg_val, keypad->mmio_base + KPSR);
> +
> +		reg_val = readw(keypad->mmio_base + KPSR);
> +		reg_val |= KBD_STAT_KRIE;
> +		reg_val &= ~KBD_STAT_KDIE;
> +		writew(reg_val, keypad->mmio_base + KPSR);
> +	}
> +}
> +
> +static irqreturn_t mxc_keypad_irq_handler(int irq, void *dev_id)
> +{
> +	struct mxc_keypad *keypad = dev_id;
> +	unsigned short reg_val;
> +
> +	reg_val = readw(keypad->mmio_base + KPSR);
> +
> +	/* Disable every keypad interrupt */
> +	reg_val &= ~(KBD_STAT_KRIE | KBD_STAT_KDIE);
> +	/* Clear interrupts status bits */
> +	reg_val |= KBD_STAT_KPKR | KBD_STAT_KPKD;
> +	writew(reg_val, keypad->mmio_base + KPSR);
> +
> +	/* The matrix is supposed to be changed */
> +	keypad->stable_count = 0;
> +
> +	/* Schedule the scanning procedure near in the future */
> +	mod_timer(&keypad->check_matrix_timer, jiffies + msecs_to_jiffies(2));
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static void mxc_keypad_config(struct mxc_keypad *keypad)
> +{
> +	unsigned short reg_val;
> +
> +	/* Include enabled rows in interrupt generation (KPCR[7:0])
> +	 * Configure keypad columns as open-drain (KPCR[15:8]) */
> +	reg_val = readw(keypad->mmio_base + KPCR);
> +	reg_val |= keypad->rows_en_mask & 0xff;		/* rows */
> +	reg_val |= (keypad->cols_en_mask & 0xff) << 8;	/* cols */
> +	writew(reg_val, keypad->mmio_base + KPCR);
> +
> +	/* Write 0's to KPDR[15:8] (Colums)*/
> +	reg_val = readw(keypad->mmio_base + KPDR);
> +	reg_val &= 0x00ff;
> +	writew(reg_val, keypad->mmio_base + KPDR);
> +
> +	/* Configure columns as output, rows as input (KDDR[15:0]) */
> +	writew(0xff00, keypad->mmio_base + KDDR);
> +
> +	/* Clear Key Depress and Key Release status bit.
> +	 * Clear both synchronizer chain. */
> +	reg_val = readw(keypad->mmio_base + KPSR);
> +	reg_val |= KBD_STAT_KPKR | KBD_STAT_KPKD |
> +		   KBD_STAT_KDSC | KBD_STAT_KRSS;
> +	writew(reg_val, keypad->mmio_base + KPSR);
> +
> +	/* Enable KDI and disable KRI (avoid false release events). */
> +	reg_val |= KBD_STAT_KDIE;
> +	reg_val &= ~KBD_STAT_KRIE;
> +	writew(reg_val, keypad->mmio_base + KPSR);
> +}
> +
> +static void mxc_keypad_inhibit(struct mxc_keypad *keypad)
> +{
> +	unsigned short reg_val;
> +
> +	/* Inhibit KDI and KRI interrupts. */
> +	reg_val = readw(keypad->mmio_base + KPSR);
> +	reg_val &= ~(KBD_STAT_KRIE | KBD_STAT_KDIE);
> +	writew(reg_val, keypad->mmio_base + KPSR);
> +
> +	/* Colums as open drain and disable all rows */
> +	writew(0xff00, keypad->mmio_base + KPCR);
> +}
> +
> +static int mxc_keypad_open(struct input_dev *dev)
> +{
> +	struct mxc_keypad *keypad = input_get_drvdata(dev);
> +
> +	dev_dbg(&dev->dev, ">%s\n", __func__);
> +
> +	/* Init Keypad timer */
> +	init_timer(&keypad->check_matrix_timer);
> +	keypad->check_matrix_timer.function = mxc_keypad_check_for_events;
> +	keypad->check_matrix_timer.data = (unsigned long) keypad;


setup_timer(). You also need to do "keypad->exit_flag = false;" here,
otherwise you will not be able to open the device again.

> +
> +	/* Enable the kpp clock */
> +	clk_enable(keypad->clk);
> +	mxc_keypad_config(keypad);
> +
> +	/* Sanity control, not all the rows must be actived now. */
> +	if ((readw(keypad->mmio_base + KPDR) & keypad->rows_en_mask) == 0) {
> +		dev_err(&dev->dev,
> +		"too much keys pressed for now, control pins initialisation\n");
> +		goto open_err;
> +	}
> +
> +	return 0;
> +
> +open_err:
> +	keypad->exit_flag = true;
> +	del_timer_sync(&keypad->check_matrix_timer);
> +	mxc_keypad_inhibit(keypad);
> +	return -EIO;
> +}
> +
> +static void mxc_keypad_close(struct input_dev *dev)
> +{
> +	struct mxc_keypad *keypad = input_get_drvdata(dev);
> +
> +	dev_dbg(&dev->dev, ">%s\n", __func__);
> +
> +	/* Make sure no checks are pending and release any events.*/
> +	keypad->exit_flag = true;
> +	del_timer_sync(&keypad->check_matrix_timer);
> +	mxc_keypad_check_for_events((unsigned long) keypad);

Why bother with checking for events? The device is being closed - nobody
is in terested in the events since nobody is listening.

> +
> +	mxc_keypad_inhibit(keypad);
> +
> +	/* Disable clock unit */
> +	clk_disable(keypad->clk);
> +}
> +
> +static int __devinit mxc_keypad_probe(struct platform_device *pdev)
> +{
> +	const struct matrix_keymap_data *keymap_data = pdev->dev.platform_data;
> +	struct mxc_keypad *keypad;
> +	struct input_dev *input_dev;
> +	struct resource *res;
> +	int irq, error, i;
> +
> +	if (keymap_data == NULL) {
> +		dev_err(&pdev->dev, "no keymap defined\n");
> +		return -EINVAL;
> +	}
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0) {
> +		dev_err(&pdev->dev, "no irq defined in platform data\n");
> +		return -EINVAL;
> +	}
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (res == NULL) {
> +		dev_err(&pdev->dev, "no I/O memory defined in platform data\n");
> +		return -EINVAL;
> +	}
> +
> +	res = request_mem_region(res->start, resource_size(res), pdev->name);
> +	if (res == NULL) {
> +		dev_err(&pdev->dev, "failed to request I/O memory\n");
> +		return -EBUSY;
> +	}
> +
> +	input_dev = input_allocate_device();
> +	if (!input_dev) {
> +		dev_err(&pdev->dev, "failed to allocate the input device\n");
> +		error = -ENOMEM;
> +		goto failed_rel_mem;
> +	}
> +
> +	keypad = kzalloc(sizeof(struct mxc_keypad), GFP_KERNEL);
> +	if (!keypad) {
> +		dev_err(&pdev->dev, "not enough memory for driver data\n");
> +		error = -ENOMEM;
> +		goto failed_free_input;
> +	}
> +
> +	keypad->input_dev = input_dev;
> +	keypad->irq = irq;
> +	keypad->stable_count = 0;
> +	keypad->exit_flag = false;
> +
> +	keypad->mmio_base = ioremap(res->start, resource_size(res));
> +	if (keypad->mmio_base == NULL) {
> +		dev_err(&pdev->dev, "failed to remap I/O memory\n");
> +		error = -ENOMEM;
> +		goto failed_free_priv;
> +	}
> +
> +	keypad->clk = clk_get(&pdev->dev, "kpp");
> +	if (IS_ERR(keypad->clk)) {
> +		dev_err(&pdev->dev, "failed to get keypad clock\n");
> +		error = PTR_ERR(keypad->clk);
> +		goto failed_unmap;
> +	}
> +
> +	/* Search for rows and cols enabled */
> +	for (i = 0; i < keymap_data->keymap_size; i++) {
> +		keypad->rows_en_mask |= 1 << KEY_ROW(keymap_data->keymap[i]);
> +		keypad->cols_en_mask |= 1 << KEY_COL(keymap_data->keymap[i]);
> +	}
> +
> +	if (keypad->rows_en_mask > ((1 << MAX_MATRIX_KEY_ROWS) - 1) ||
> +	   keypad->cols_en_mask > ((1 << MAX_MATRIX_KEY_COLS) - 1)) {
> +		dev_err(&pdev->dev, "invalid key data (too rows or colums)\n");
> +		error = -EINVAL;
> +		goto failed_clock_put;
> +	}
> +	dev_dbg(&pdev->dev, "enabled rows mask: %x\n", keypad->rows_en_mask);
> +	dev_dbg(&pdev->dev, "enabled cols mask: %x\n", keypad->cols_en_mask);
> +
> +	/* Init the Input device */
> +	input_dev->name = pdev->name;
> +	input_dev->id.bustype = BUS_HOST;
> +	input_dev->dev.parent = &pdev->dev;
> +	input_dev->open = mxc_keypad_open;
> +	input_dev->close = mxc_keypad_close;
> +	input_dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_REP);
> +	input_dev->keycode = keypad->keycodes;
> +	input_dev->keycodesize = sizeof(keypad->keycodes[0]);
> +	input_dev->keycodemax = ARRAY_SIZE(keypad->keycodes);
> +
> +	matrix_keypad_build_keymap(keymap_data, MATRIX_ROW_SHIFT,
> +				keypad->keycodes, input_dev->keybit);
> +
> +	input_set_capability(input_dev, EV_MSC, MSC_SCAN);
> +	input_set_drvdata(input_dev, keypad);
> +

I would feell more safe if we also called inhibit here. I there any
chance that matrix can gerenrate interrupts at this point? If it can and
we never call open/close then in remove there is a chace of freeing
input device before freeing IRQ.

> +	error = request_irq(irq, mxc_keypad_irq_handler, IRQF_DISABLED,
> +			pdev->name, keypad);
> +	if (error) {
> +		dev_err(&pdev->dev, "failed to request IRQ\n");
> +		goto failed_clock_put;
> +	}
> +
> +	/* Register the input device */
> +	error = input_register_device(input_dev);
> +	if (error) {
> +		dev_err(&pdev->dev, "failed to register input device\n");
> +		goto failed_free_irq;
> +	}
> +
> +	platform_set_drvdata(pdev, keypad);
> +	device_init_wakeup(&pdev->dev, 1);
> +
> +	dev_info(&pdev->dev, "device probed\n");
> +
> +	return 0;
> +
> +failed_free_irq:
> +	free_irq(irq, pdev);
> +failed_clock_put:
> +	clk_put(keypad->clk);
> +failed_unmap:
> +	iounmap(keypad->mmio_base);
> +failed_free_priv:
> +	kfree(keypad);
> +failed_free_input:
> +	input_free_device(input_dev);
> +failed_rel_mem:
> +	release_mem_region(res->start, resource_size(res));
> +	return error;
> +}
> +
> +static int __devexit mxc_keypad_remove(struct platform_device *pdev)
> +{
> +	struct mxc_keypad *keypad = platform_get_drvdata(pdev);
> +	struct resource *res;
> +
> +	dev_dbg(&pdev->dev, ">%s\n", __func__);
> +
> +	platform_set_drvdata(pdev, NULL);
> +
> +	input_unregister_device(keypad->input_dev);
> +
> +	free_irq(keypad->irq, keypad);
> +	clk_put(keypad->clk);
> +
> +	iounmap(keypad->mmio_base);
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	release_mem_region(res->start, resource_size(res));
> +
> +	kfree(keypad);
> +
> +	dev_info(&pdev->dev, "device removed\n");
> +
> +	return 0;
> +}
> +
> +static struct platform_driver mxc_keypad_driver = {
> +	.driver		= {
> +		.name	= "mxc-keypad",
> +		.owner	= THIS_MODULE,
> +	},
> +	.probe		= mxc_keypad_probe,
> +	.remove		= __devexit_p(mxc_keypad_remove),
> +};
> +
> +static int __init mxc_keypad_init(void)
> +{
> +	return platform_driver_register(&mxc_keypad_driver);
> +}
> +
> +static void __exit mxc_keypad_exit(void)
> +{
> +	platform_driver_unregister(&mxc_keypad_driver);
> +}
> +
> +module_init(mxc_keypad_init);
> +module_exit(mxc_keypad_exit);
> +
> +MODULE_AUTHOR("Alberto Panizzo <maramaopercheseimorto@gmail.com>");
> +MODULE_DESCRIPTION("MXC Keypad Port Driver");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform:mxc-keypad");
> -- 
> 1.6.3.3
> 
> 
> 

-- 
Dmitry
