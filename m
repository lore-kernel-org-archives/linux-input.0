From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 3/5] [ARM] pxa: lx: add keyboard driver
Date: Sat, 18 Apr 2009 16:10:28 -0700
Message-ID: <20090418231018.GA32346@dtor-d630.eng.vmware.com>
References: <20090418141932.GA1236@n2100.arm.linux.org.uk> <1240064452-14691-3-git-send-email-linux@arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.176]:61412 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753105AbZDRXKh (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 18 Apr 2009 19:10:37 -0400
Received: by wa-out-1112.google.com with SMTP id j5so785349wah.21
        for <linux-input@vger.kernel.org>; Sat, 18 Apr 2009 16:10:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1240064452-14691-3-git-send-email-linux@arm.linux.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-input@vger.kernel.org

Hi Russell,

On Sat, Apr 18, 2009 at 03:20:50PM +0100, Russell King wrote:
> This adds support for the keyboard support on the LX platform.
> We aren't directly connected to the keyboard itself, but the
> keyboard is managed by PCON via the system I2C bus.
> 

Very nice driver. I prefer input devices having a private copy of keymap
but I suppose there is just such device in the system anyways...

>  
> +config KEYBOARD_LX
> +	tristate "LX Keyboard support"
> +	depends on MACH_NETBOOKPRO && INPUT && INPUT_KEYBOARD

Dependancy on INPUT_KEYBOARD is not needed, strictly speaking.
INPUT_KEYBOARD is only [menu]config syntactic sugar, there is no meat
behind the option.

> +
> +	/*
> +	 * Some keys have additional operations after we have
> +	 * decoded them.  We don't report these "special" keys
> +	 * to the input layer.
> +	 */
> +	switch (key) {
> +	case KEY_BRIGHTNESSUP:
> +	case KEY_BRIGHTNESSDOWN:
> +		input_event(kbd, EV_PWR, key, !up);

Umm... some userspace apps might still want to get these. Strictly
speaking KEY_* codes belong to EV_KEY namespace.

> +		break;
> +
> +	case KEY_SUSPEND:
> +		input_event(kbd, EV_PWR, key, !up);
> +#if defined(CONFIG_APM_EMULATION) && !defined(CONFIG_INPUT_APMPOWER)
> +		if (!up)
> +			apm_queue_event(APM_SYS_SUSPEND);
> +#endif
> +		break;
> +
> +	default:
> +		input_report_key(kbd, key, !up);
> +		break;
> +	}
> +}
> +
> +static void lx_keyb_reset(struct input_dev *kbd)
> +{
> +	unsigned char *map;
> +	int key;
> +
> +	for (key = 0; key < LX_NUMKEYCODES; key++)
> +		if (keystate[key] & KP_DOWN) {
> +			map = normal_map;
> +			if (keystate[key] & KP_FN)
> +				map = fn_map;
> +			else if (keystate[key] & KP_NUMLCK)
> +				map = numlck_map;
> +			keystate[key] = KP_NONE;
> +			input_report_key(kbd, map[key], 0);
> +		}

Why don't you just send 'up' event for all known keys? Input core will
filter out the ones that have not been 'down'ed... Better yet, don't do
anything here, I should finish adding forced release at suspend/resume
to the input core shortly.

> +
> +	num_lck = 0;
> +}
> +
> +static void lx_keyb_write(void *data, unsigned int addr, unsigned char val)
> +{
> +	struct input_dev *kbd = data;

Blank line between variables and the code is always appreciated ;)

> +	pcon_kbd_ack();
> +	lx_keyb_process_key(kbd, val);
> +}
> +
> +static struct lx_i2cslave_watcher lx_keyb_watcher = {
> +	.start	= PHST_KEYBOARD_START,
> +	.size	= PHST_KEYBOARD_SIZE,
> +	.write	= lx_keyb_write,
> +};
> +
> +static int lx_keyb_probe(struct platform_device *dev)
> +{
> +	struct input_dev *kbd;
> +	int i, ret;
> +
> +	kbd = input_allocate_device();
> +	if (!kbd)
> +		return -ENOMEM;
> +
> +	kbd->name        = "LX Keyboard";
> +	kbd->phys        = "pcon/input0";
> +	kbd->dev.parent  = &dev->dev;
> +	kbd->evbit[0]    = BIT_MASK(EV_KEY) | BIT_MASK(EV_REP) |
> +			   BIT_MASK(EV_PWR);
> +	kbd->keycode     = normal_map;
> +	kbd->keycodesize = sizeof(unsigned char);
> +	kbd->keycodemax  = ARRAY_SIZE(normal_map);
> +

So we have 3 keymaps but only one can be changed form userspace... I
suppose it is OK given how special the other 2 keymaps are. Or we could
provide an alternative {get,set}keycode methods.

> +	for (i = 0; i < ARRAY_SIZE(normal_map); i++) {
> +		if (normal_map[i])
> +			__set_bit(normal_map[i], kbd->keybit);
> +	}
> +	for (i = 0; i < ARRAY_SIZE(numlck_map); i++) {
> +		if (numlck_map[i])
> +			__set_bit(numlck_map[i], kbd->keybit);
> +	}
> +	for (i = 0; i < ARRAY_SIZE(fn_map); i++) {
> +		if (fn_map[i])
> +			__set_bit(fn_map[i], kbd->keybit);
> +	}
> +
> +	ret = input_register_device(kbd);
> +	if (ret == 0) {
> +		platform_set_drvdata(dev, kbd);
> +		lx_i2cslave_addwatcher(&lx_keyb_watcher, kbd);
> +	} else {
> +		input_free_device(kbd);
> +	}
> +	return ret;
> +}
> +
> +static int __devexit lx_keyb_remove(struct platform_device *dev)
> +{
> +	struct input_dev *kbd = platform_get_drvdata(dev);
> +	platform_set_drvdata(dev, NULL);
> +	lx_i2cslave_delwatcher(&lx_keyb_watcher, kbd);
> +	input_unregister_device(kbd);
> +	return 0;
> +}
> +
> +static int lx_keyb_resume(struct platform_device *dev)
> +{
> +	struct input_dev *kbd = platform_get_drvdata(dev);
> +	lx_keyb_reset(kbd);
> +	return 0;
> +}
> +
> +static struct platform_driver lx_kbd = {
> +	.driver = {
> +		.name	= "lx-kbd",
> +		.owner	= THIS_MODULE,
> +	},
> +	.probe	= lx_keyb_probe,
> +	.remove	= __devexit_p(lx_keyb_remove),
> +	.resume	= lx_keyb_resume,
> +};
> +
> +static int __init lx_keyb_init(void)
> +{
> +	printk(KERN_INFO "LX Keyboard Driver, (c) 2004 Simtec Electronics\n");

Is this needed? Input core will already add printk when input device is
added and our boot is already chatty enough...

Thanks!

-- 
Dmitry
