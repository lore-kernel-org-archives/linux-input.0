From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: driver for microcontroller keys on the iPaq h3xxx
Date: Wed, 4 Feb 2015 11:09:02 -0800
Message-ID: <20150204190902.GB7818@dtor-ws>
References: <1423044764-11265-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:65122 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161186AbbBDTJH (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 4 Feb 2015 14:09:07 -0500
Received: by mail-ie0-f171.google.com with SMTP id tr6so4495007ieb.2
        for <linux-input@vger.kernel.org>; Wed, 04 Feb 2015 11:09:06 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1423044764-11265-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-input@vger.kernel.org, Dmitry Artamonow <mad_soft@inbox.ru>, Alessandro GARDICH <gremlin@gremlin.it>

Hi Linus,

On Wed, Feb 04, 2015 at 11:12:44AM +0100, Linus Walleij wrote:
> From: Dmitry Artamonow <mad_soft@inbox.ru>
> 
> This adds a key input driver for the keys found on the h3xxx
> iPAQ series.
> 
> Based on a driver from handhelds.org 2.6.21 kernel, written
> by Alessandro GARDICH.
> 
> Signed-off-by: Alessandro GARDICH <gremlin@gremlin.it>
> Signed-off-by: Dmitry Artamonow <mad_soft@inbox.ru>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Hi Dmitry (Torokhov), I have a vague memory of having sent
> this patch before but can't find it in my mail archives.
> So I'm guessing I never sent it properly :P
> ---
>  drivers/input/keyboard/Kconfig           |   7 ++
>  drivers/input/keyboard/Makefile          |   1 +
>  drivers/input/keyboard/ipaq-micro-keys.c | 148 +++++++++++++++++++++++++++++++
>  3 files changed, 156 insertions(+)
>  create mode 100644 drivers/input/keyboard/ipaq-micro-keys.c
> 
> diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
> index a5d9b3f3c871..043b720b500d 100644
> --- a/drivers/input/keyboard/Kconfig
> +++ b/drivers/input/keyboard/Kconfig
> @@ -578,6 +578,13 @@ config KEYBOARD_DAVINCI
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called davinci_keyscan.
>  
> +config KEYBOARD_IPAQ_MICRO
> +	tristate "Buttons on Micro SoC (iPaq h3100,h3600,h3700)"
> +	depends on MFD_IPAQ_MICRO
> +	help
> +	  This enables support for the buttons attached to
> +	  Micro peripheral controller on iPAQ h3100/h3600/h3700
> +

To compile this driver as a module ...

>  config KEYBOARD_OMAP
>  	tristate "TI OMAP keypad support"
>  	depends on ARCH_OMAP1
> diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/Makefile
> index febafa527eb6..c59e73bdd260 100644
> --- a/drivers/input/keyboard/Makefile
> +++ b/drivers/input/keyboard/Makefile
> @@ -23,6 +23,7 @@ obj-$(CONFIG_KEYBOARD_TCA6416)		+= tca6416-keypad.o
>  obj-$(CONFIG_KEYBOARD_TCA8418)		+= tca8418_keypad.o
>  obj-$(CONFIG_KEYBOARD_HIL)		+= hil_kbd.o
>  obj-$(CONFIG_KEYBOARD_HIL_OLD)		+= hilkbd.o
> +obj-$(CONFIG_KEYBOARD_IPAQ_MICRO)	+= ipaq-micro-keys.o
>  obj-$(CONFIG_KEYBOARD_IMX)		+= imx_keypad.o
>  obj-$(CONFIG_KEYBOARD_HP6XX)		+= jornada680_kbd.o
>  obj-$(CONFIG_KEYBOARD_HP7XX)		+= jornada720_kbd.o
> diff --git a/drivers/input/keyboard/ipaq-micro-keys.c b/drivers/input/keyboard/ipaq-micro-keys.c
> new file mode 100644
> index 000000000000..7ca8b738cc73
> --- /dev/null
> +++ b/drivers/input/keyboard/ipaq-micro-keys.c
> @@ -0,0 +1,148 @@
> +/*
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * h3600 atmel micro companion support, key subdevice
> + * based on previous kernel 2.4 version
> + * Author : Alessandro Gardich <gremlin@gremlin.it>
> + * Author : Linus Walleij <linus.walleij@linaro.org>
> + *
> + */
> +
> +
> +#include <linux/module.h>
> +#include <linux/version.h>

I do not think you need this.

> +
> +#include <linux/init.h>
> +#include <linux/fs.h>
> +#include <linux/interrupt.h>
> +#include <linux/sched.h>
> +#include <linux/pm.h>
> +#include <linux/sysctl.h>
> +#include <linux/proc_fs.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/input.h>
> +#include <linux/platform_device.h>
> +#include <linux/mfd/ipaq-micro.h>
> +
> +struct ipaq_micro_keys {
> +	struct ipaq_micro *micro;
> +	struct input_dev *input;
> +};
> +
> +static int keycodes[] = {

const.

> +	KEY_RECORD,		/* 1:  Record button			*/
> +	KEY_CALENDAR,		/* 2:  Calendar				*/
> +	KEY_ADDRESSBOOK,	/* 3:  Contacts (looks like Outlook)	*/
> +	KEY_MAIL,		/* 4:  Envelope (Q on older iPAQs)	*/
> +	KEY_HOMEPAGE,		/* 5:  Start (looks like swoopy arrow)	*/
> +	KEY_UP,			/* 6:  Up				*/
> +	KEY_RIGHT,		/* 7:  Right				*/
> +	KEY_LEFT,		/* 8:  Left				*/
> +	KEY_DOWN,		/* 9:  Down				*/
> +};
> +
> +static void micro_key_receive(void *data, int len, unsigned char *msg)
> +{
> +	struct ipaq_micro_keys *keys = data;
> +	int key, down;
> +
> +	down = (0x80 & msg[0]) ? 1 : 0;

input_report_key also converts to bool so just use "msg[0] & 0x80"
directly.

> +	key  = 0x7f & msg[0];
> +
> +	if (key < ARRAY_SIZE(keycodes)) {
> +		input_report_key(keys->input, keycodes[key], down);

Please copy keycodes into ipaq_micro_keys structurei (make it u16 BTW),
set up input_dev->keycode, keycodemax and keycodesize.

> +		input_sync(keys->input);
> +	}
> +}
> +
> +static int micro_key_probe(struct platform_device *pdev)
> +{
> +	struct ipaq_micro_keys *keys;
> +	int ret;
> +	int i;
> +
> +	keys = devm_kzalloc(&pdev->dev, sizeof(*keys), GFP_KERNEL);
> +	if (!keys)
> +		return -ENOMEM;
> +	keys->input = input_allocate_device();
> +	if (!keys->input)
> +		return -ENOMEM;
> +	keys->micro = dev_get_drvdata(pdev->dev.parent);
> +	keys->input->evbit[0] = BIT(EV_KEY);
> +	set_bit(EV_KEY, keys->input->evbit);
> +	for (i = 0; i < ARRAY_SIZE(keycodes); i++)
> +		set_bit(keycodes[i], keys->input->keybit);
> +
> +	keys->input->name = "h3600 micro keys";
> +
> +	ret = input_register_device(keys->input);
> +	if (ret)
> +		return ret;

Since you are not using devm_input_allocate_device() you are leaking
input device here.

> +
> +	platform_set_drvdata(pdev, keys);
> +	spin_lock(&keys->micro->lock);
> +	keys->micro->key = micro_key_receive;
> +	keys->micro->key_data = keys;
> +	spin_unlock(&keys->micro->lock);

Please split it off, you seem to be using it in a few places. BTW maybe
put in into input_dev->open()?

> +
> +	return 0;
> +}
> +
> +static int micro_key_remove(struct platform_device *pdev)
> +{
> +	struct ipaq_micro_keys *keys = platform_get_drvdata(pdev);
> +
> +	input_unregister_device(keys->input);

Nope, if key->input disappears and a keypress arrives you'll crash here. 

> +
> +	spin_lock(&keys->micro->lock);
> +	keys->micro->key = NULL;
> +	keys->micro->key_data = NULL;
> +	spin_unlock(&keys->micro->lock);

Best place for this would be in input_dev->close().

> +
> +	return 0;
> +}
> +
> +static int micro_key_suspend(struct device *dev)

__maybe_unused

> +{
> +	struct ipaq_micro_keys *keys = dev_get_drvdata(dev);
> +
> +	spin_lock(&keys->micro->lock);
> +	keys->micro->key = NULL;
> +	keys->micro->key_data = NULL;
> +	spin_unlock(&keys->micro->lock);
> +
> +	return 0;
> +}
> +
> +static int micro_key_resume(struct device *dev)

__maybe_unused

> +{
> +	struct ipaq_micro_keys *keys = dev_get_drvdata(dev);
> +
> +	spin_lock(&keys->micro->lock);
> +	keys->micro->key = micro_key_receive;
> +	keys->micro->key_data = keys;
> +	spin_unlock(&keys->micro->lock);
> +
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops micro_key_dev_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(micro_key_suspend, micro_key_resume)
> +};

SIMPLE_DEV_PM_OPS().

> +
> +struct platform_driver micro_key_device_driver = {
> +	.driver = {
> +		.name    = "ipaq-micro-keys",
> +		.pm	= &micro_key_dev_pm_ops,
> +	},
> +	.probe   = micro_key_probe,
> +	.remove  = micro_key_remove,
> +};
> +module_platform_driver(micro_key_device_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("driver for iPAQ Atmel micro keys");
> +MODULE_ALIAS("platform:ipaq-micro-keys");
> -- 
> 1.9.3
> 

Thanks.

-- 
Dmitry
