From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] HID: TWL4030: add HID Force Feedback vibra
Date: Sun, 21 Feb 2010 22:40:04 -0800
Message-ID: <20100222064004.GB2095@core.coreip.homeip.net>
References: <1266409336-24146-1-git-send-email-ext-jari.vanhala@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:46314 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754569Ab0BVGkL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 22 Feb 2010 01:40:11 -0500
Received: by vws11 with SMTP id 11so919195vws.19
        for <linux-input@vger.kernel.org>; Sun, 21 Feb 2010 22:40:10 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1266409336-24146-1-git-send-email-ext-jari.vanhala@nokia.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jari Vanhala <ext-jari.vanhala@nokia.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org

Hi Jari,

On Wed, Feb 17, 2010 at 02:22:16PM +0200, Jari Vanhala wrote:
> TWL4030 Vibrator implemented via HID Force Feedback
> interface. This uses MFD TWL4030 codec and own workqueue.
> 
> Signed-off-by: Jari Vanhala <ext-jari.vanhala@nokia.com>
> ---
>  drivers/hid/Kconfig             |    8 +
>  drivers/hid/Makefile            |    1 +
>  drivers/hid/hid-twl4030-vibra.c |  292 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 301 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/hid/hid-twl4030-vibra.c
> 
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index 71d4c07..9bb4e0a 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -372,6 +372,14 @@ config ZEROPLUS_FF
>  	  Say Y here if you have a Zeroplus based game controller and want
>  	  to have force feedback support for it.
>  
> +config HID_TWL4030_VIBRA
> +	tristate "HID Support for TWL4030 Vibrator"
> +	depends on TWL4030_CORE
> +	select TWL4030_CODEC
> +	select INPUT_FF_MEMLESS
> +	---help---
> +	  This option enables support for TWL4030 Vibrator Driver.
> +

To compile this driver as a module...

>  endmenu
>  
>  endif # HID_SUPPORT
> diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
> index 0b2618f..192cde6 100644
> --- a/drivers/hid/Makefile
> +++ b/drivers/hid/Makefile
> @@ -55,6 +55,7 @@ obj-$(CONFIG_HID_TOPSEED)	+= hid-topseed.o
>  obj-$(CONFIG_HID_TWINHAN)	+= hid-twinhan.o
>  obj-$(CONFIG_HID_ZEROPLUS)	+= hid-zpff.o
>  obj-$(CONFIG_HID_WACOM)		+= hid-wacom.o
> +obj-$(CONFIG_HID_TWL4030_VIBRA)	+= hid-twl4030-vibra.o
>  
>  obj-$(CONFIG_USB_HID)		+= usbhid/
>  obj-$(CONFIG_USB_MOUSE)		+= usbhid/
> diff --git a/drivers/hid/hid-twl4030-vibra.c b/drivers/hid/hid-twl4030-vibra.c
> new file mode 100644
> index 0000000..1009dfb
> --- /dev/null
> +++ b/drivers/hid/hid-twl4030-vibra.c
> @@ -0,0 +1,292 @@
> +/*
> + * hid-twl4030-vibra.c - TWL4030 Vibrator driver
> + *
> + * Copyright (C) 2008-2010 Nokia Corporation
> + *
> + * Written by Henrik Saari <henrik.saari@nokia.com>
> + * Updates by Felipe Balbi <felipe.balbi@nokia.com>
> + * HID by Jari Vanhala <ext-jari.vanhala@nokia.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
> + * 02110-1301 USA
> + *
> + */
> +
> +#include <linux/module.h>
> +#include <linux/jiffies.h>
> +#include <linux/platform_device.h>
> +#include <linux/workqueue.h>
> +#include <linux/i2c/twl.h>
> +#include <linux/mfd/twl4030-codec.h>
> +
> +#include <linux/hid.h>
> +#include <linux/input.h>
> +
> +/* MODULE ID2 */
> +#define LEDEN		0x00
> +
> +/* ForceFeedback */
> +#define EFFECT_DIR_180_DEG	0x8000 /* range is 0 - 0xFFFF */
> +
> +struct vibra_info {
> +	struct device		*dev;
> +	struct input_dev	*input_dev;
> +
> +	struct workqueue_struct *workqueue;

Why do we need a separate workqueue? Can't keventd serve us?

> +	struct work_struct	play_work;
> +
> +	int			enabled;

Use bool?

> +	int			speed;
> +	int			direction;
> +
> +	int			coexist;

Here as well?

> +};
> +
> +static void vibra_disable_leds(void)
> +{
> +	u8 reg;
> +
> +	/* Disable LEDA & LEDB, cannot be used with vibra (PWM) */
> +	twl_i2c_read_u8(TWL4030_MODULE_LED, &reg, LEDEN);
> +	reg &= ~0x03;
> +	twl_i2c_write_u8(TWL4030_MODULE_LED, LEDEN, reg);
> +}
> +
> +/* Powers H-Bridge and enables audio clk */
> +static void vibra_enable(struct vibra_info *info)
> +{
> +	u8 reg;
> +
> +	twl4030_codec_enable_resource(TWL4030_CODEC_RES_POWER);
> +
> +	/* turn H-Bridge on */
> +	twl_i2c_read_u8(TWL4030_MODULE_AUDIO_VOICE,
> +			&reg, TWL4030_REG_VIBRA_CTL);
> +	twl_i2c_write_u8(TWL4030_MODULE_AUDIO_VOICE,
> +			 (reg | TWL4030_VIBRA_EN), TWL4030_REG_VIBRA_CTL);
> +
> +	twl4030_codec_enable_resource(TWL4030_CODEC_RES_APLL);
> +
> +	info->enabled = 1;
> +}
> +
> +static void vibra_disable(struct vibra_info *info)
> +{
> +	u8 reg;
> +
> +	/* Power down H-Bridge */
> +	twl_i2c_read_u8(TWL4030_MODULE_AUDIO_VOICE,
> +			&reg, TWL4030_REG_VIBRA_CTL);
> +	twl_i2c_write_u8(TWL4030_MODULE_AUDIO_VOICE,
> +			 (reg & ~TWL4030_VIBRA_EN), TWL4030_REG_VIBRA_CTL);
> +
> +	twl4030_codec_disable_resource(TWL4030_CODEC_RES_POWER);
> +	twl4030_codec_disable_resource(TWL4030_CODEC_RES_APLL);
> +
> +	info->enabled = 0;
> +}
> +
> +static void vibra_play_work(struct work_struct *work)
> +{
> +	struct vibra_info *info = container_of(work,
> +			struct vibra_info, play_work);
> +	int dir;
> +	int pwm;
> +	u8 reg;
> +
> +	dir = info->direction;
> +	pwm = info->speed;
> +
> +	twl_i2c_read_u8(TWL4030_MODULE_AUDIO_VOICE,
> +			&reg, TWL4030_REG_VIBRA_CTL);
> +	if (pwm && (!info->coexist || !(reg & TWL4030_VIBRA_SEL))) {
> +
> +		if (!info->enabled)
> +			vibra_enable(info);
> +
> +		/* set vibra rotation direction */
> +		twl_i2c_read_u8(TWL4030_MODULE_AUDIO_VOICE,
> +				&reg, TWL4030_REG_VIBRA_CTL);
> +		reg = (dir) ? (reg | TWL4030_VIBRA_DIR) :
> +			(reg & ~TWL4030_VIBRA_DIR);
> +		twl_i2c_write_u8(TWL4030_MODULE_AUDIO_VOICE,
> +				 reg, TWL4030_REG_VIBRA_CTL);
> +
> +		/* set PWM, 1 = max, 255 = min */
> +		twl_i2c_write_u8(TWL4030_MODULE_AUDIO_VOICE,
> +				 256 - pwm, TWL4030_REG_VIBRA_SET);
> +	} else {
> +		if (info->enabled)
> +			vibra_disable(info);
> +	}
> +}
> +
> +/*** ForceFeedback ***/
> +
> +static int vibra_play(struct input_dev *dev, void *data,
> +		      struct ff_effect *effect)
> +{
> +	struct vibra_info *info = data;
> +
> +	if (!info->workqueue)
> +		return 0;

How can workqueue be missig here?

> +
> +	info->speed = effect->u.rumble.strong_magnitude >> 8;
> +	if (!info->speed)
> +		info->speed = effect->u.rumble.weak_magnitude >> 9;
> +	info->direction = effect->direction < EFFECT_DIR_180_DEG ? 0 : 1;
> +	queue_work(info->workqueue, &info->play_work);
> +
> +	return 0;
> +}
> +
> +/*** Module ***/
> +#if CONFIG_PM
> +static int twl4030_vibra_suspend(struct platform_device *pdev,
> +				 pm_message_t state)
> +{
> +	struct vibra_info *info = platform_get_drvdata(pdev);
> +
> +	if (info->enabled)
> +		vibra_disable(info);
> +
> +	return 0;
> +}
> +
> +static void twl4030_vibra_shutdown(struct platform_device *pdev)
> +{
> +	struct vibra_info *info = platform_get_drvdata(pdev);
> +
> +	if (info->enabled)
> +		vibra_disable(info);
> +}
> +
> +static int twl4030_vibra_resume(struct platform_device *pdev)
> +{
> +	vibra_disable_leds();
> +	return 0;
> +}


Please convert ot dev_pm_ops.

> +#else
> +#define twl4030_vibra_suspend NULL
> +#define twl4030_vibra_shutdown NULL
> +#define twl4030_vibra_resume NULL
> +#endif
> +
> +static int __devinit twl4030_vibra_probe(struct platform_device *pdev)
> +{
> +	struct twl4030_codec_vibra_data *pdata = pdev->dev.platform_data;
> +	struct vibra_info *info;
> +	int ret;
> +
> +	if (!pdata) {
> +		dev_dbg(&pdev->dev, "platform_data not available\n");
> +		return -EINVAL;
> +	}
> +
> +	info = kzalloc(sizeof(*info), GFP_KERNEL);
> +	if (!info)
> +		return -ENOMEM;
> +
> +	info->dev = &pdev->dev;
> +	info->enabled = 0;
> +	info->coexist = pdata->coexist;
> +
> +	platform_set_drvdata(pdev, info);
> +
> +	info->workqueue = create_singlethread_workqueue("vibra");
> +	if (info->workqueue == NULL) {
> +		dev_err(&pdev->dev, "couldn't create workqueue\n");
> +		kfree(info);
> +		return -ENOMEM;
> +	}
> +	INIT_WORK(&info->play_work, vibra_play_work);
> +
> +	info->input_dev = input_allocate_device();
> +	if (info->input_dev == NULL) {
> +		dev_err(&pdev->dev, "couldn't allocate input device\n");
> +		kfree(info);

Leaking workqueue.

> +		return -ENOMEM;
> +	}
> +	input_set_drvdata(info->input_dev, info);
> +
> +	info->input_dev->name = "twl4030:vibrator";
> +	info->input_dev->id.version = 1;
> +	info->input_dev->dev.parent = pdev->dev.parent;
> +	set_bit(FF_RUMBLE, info->input_dev->ffbit);
> +
> +	ret = input_register_device(info->input_dev);
> +	if (ret < 0) {
> +		dev_dbg(&pdev->dev, "couldn't register input device\n");

Here as well... Can we switch to standard "goto into error path" error
handling?

> +		input_free_device(info->input_dev);
> +		kfree(info);
> +		return ret;
> +	}
> +
> +	ret = input_ff_create_memless(info->input_dev, info, vibra_play);
> +	if (ret < 0) {
> +		dev_dbg(&pdev->dev, "couldn't register vibrator to FF\n");
> +		input_unregister_device(info->input_dev);
> +		kfree(info);
> +		return ret;
> +	}
> +
> +	vibra_disable_leds();
> +
> +	return 0;
> +}
> +
> +static int __devexit twl4030_vibra_remove(struct platform_device *pdev)
> +{
> +	struct vibra_info *info = platform_get_drvdata(pdev);
> +
> +	cancel_work_sync(&info->play_work);
> +	destroy_workqueue(info->workqueue);
> +	info->workqueue = NULL;
> +	if (info->enabled)
> +		vibra_disable(info);
> +	/* this also free ff-memless which (in turn) kfree info */
> +	input_unregister_device(info->input_dev);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver twl4030_vibra_driver = {
> +	.probe		= twl4030_vibra_probe,
> +	.remove		= __devexit_p(twl4030_vibra_remove),
> +	.suspend	= twl4030_vibra_suspend,
> +	.resume		= twl4030_vibra_resume,
> +	.shutdown	= twl4030_vibra_shutdown,
> +	.driver		= {
> +		.name	= "twl4030_codec_vibra",
> +		.owner	= THIS_MODULE,
> +	},
> +};
> +
> +static int __init twl4030_vibra_init(void)
> +{
> +	return platform_driver_register(&twl4030_vibra_driver);
> +}
> +module_init(twl4030_vibra_init);
> +
> +static void __exit twl4030_vibra_exit(void)
> +{
> +	platform_driver_unregister(&twl4030_vibra_driver);
> +}
> +module_exit(twl4030_vibra_exit);
> +
> +MODULE_ALIAS("platform:twl4030_codec_vibra");
> +
> +MODULE_DESCRIPTION("HID TWL4030 Vibra driver");
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Nokia Corporation");

Thanks.

-- 
Dmitry
