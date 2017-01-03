From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: [PATCH 2/4] input: tm2-touchkey: Add touchkey driver support for
 TM2
Date: Tue, 3 Jan 2017 10:11:39 -0300
Message-ID: <7794c9b2-48e6-1451-9a3e-fe24410a145d@osg.samsung.com>
References: <1483430237-26823-1-git-send-email-jcsing.lee@samsung.com>
 <CGME20170103075733epcas5p4a065198d4abf35081024af95055c67d2@epcas5p4.samsung.com>
 <1483430237-26823-3-git-send-email-jcsing.lee@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1483430237-26823-3-git-send-email-jcsing.lee@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jaechul Lee <jcsing.lee@samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>
Cc: devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Shyti <andi.shyti@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, beomho.seo@samsung.com, linux-input@vger.kernel.org, galaxyra@gmail.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

Hello Jaechul,

On 01/03/2017 04:57 AM, Jaechul Lee wrote:
> This patch adds support for the TM2 touch key and led
> functionlity.
> 

s/functionlity/functionality

> The driver interfaces with userspace through an input device and
> reports KEY_PHONE and KEY_BACK event types. LED brightness can be
> controlled by "/sys/class/leds/tm2-touchkey/brightness".
> 
> Signed-off-by: Jaechul Lee <jcsing.lee@samsung.com>
> Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
> ---
>  drivers/input/keyboard/Kconfig        |  11 ++
>  drivers/input/keyboard/Makefile       |   1 +
>  drivers/input/keyboard/tm2-touchkey.c | 326 ++++++++++++++++++++++++++++++++++
>  3 files changed, 338 insertions(+)
>  create mode 100644 drivers/input/keyboard/tm2-touchkey.c
> 
> diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
> index cbd75cf..72c0ba1 100644
> --- a/drivers/input/keyboard/Kconfig
> +++ b/drivers/input/keyboard/Kconfig
> @@ -666,6 +666,17 @@ config KEYBOARD_TC3589X
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called tc3589x-keypad.
>  
> +config KEYBOARD_TM2_TOUCHKEY
> +	tristate "tm2-touchkey support"
> +	depends on I2C
> +	help
> +	  Say Y here to enable the tm2-touchkey.
> +	  touchkey driver for tm2. This driver can enable
> +	  the interrupt and make input events and control led brightness.
> +
> +	  To compile this driver as a module, choose M here.
> +	  module will be called tm2-touchkey
> +
>  config KEYBOARD_TWL4030
>  	tristate "TI TWL4030/TWL5030/TPS659x0 keypad support"
>  	depends on TWL4030_CORE
> diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/Makefile
> index d9f4cfc..7d9acff 100644
> --- a/drivers/input/keyboard/Makefile
> +++ b/drivers/input/keyboard/Makefile
> @@ -61,6 +61,7 @@ obj-$(CONFIG_KEYBOARD_SUN4I_LRADC)	+= sun4i-lradc-keys.o
>  obj-$(CONFIG_KEYBOARD_SUNKBD)		+= sunkbd.o
>  obj-$(CONFIG_KEYBOARD_TC3589X)		+= tc3589x-keypad.o
>  obj-$(CONFIG_KEYBOARD_TEGRA)		+= tegra-kbc.o
> +obj-$(CONFIG_KEYBOARD_TM2_TOUCHKEY)	+= tm2-touchkey.o
>  obj-$(CONFIG_KEYBOARD_TWL4030)		+= twl4030_keypad.o
>  obj-$(CONFIG_KEYBOARD_XTKBD)		+= xtkbd.o
>  obj-$(CONFIG_KEYBOARD_W90P910)		+= w90p910_keypad.o
> diff --git a/drivers/input/keyboard/tm2-touchkey.c b/drivers/input/keyboard/tm2-touchkey.c
> new file mode 100644
> index 0000000..d9575d8
> --- /dev/null
> +++ b/drivers/input/keyboard/tm2-touchkey.c
> @@ -0,0 +1,326 @@
> +/*
> + * Driver for keys on GPIO lines capable of generating interrupts.
> + *
> + * Copyright 2005 Phil Blundell
> + * Copyright 2016 Samsung Electronics Co., Ltd.
> + *
> + * Author: Beomho Seo <beomho.seo@samsung.com>
> + * Author: Jaechul Lee <jcsing.lee@samsung.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/i2c.h>
> +#include <linux/input.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/leds.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/pm.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/workqueue.h>
> +
> +#define TM2_TOUCHKEY_DEV_NAME			"tm2-touchkey"
> +#define TM2_TOUCHKEY_KEYCODE_REG			0x03
> +#define TM2_TOUCHKEY_BASE_REG			0x00
> +#define TM2_TOUCHKEY_CMD_LED_ON			0x10
> +#define TM2_TOUCHKEY_CMD_LED_OFF			0x20
> +#define TM2_TOUCHKEY_BIT_PRESS_EV			BIT(3)
> +#define TM2_TOUCHKEY_BIT_KEYCODE			GENMASK(2, 0)
> +#define TM2_TOUCHKEY_LED_VOLTAGE_MIN			2500000
> +#define TM2_TOUCHKEY_LED_VOLTAGE_MAX			3300000
> +
> +enum {
> +	TM2_TOUCHKEY_KEY_MENU = 0x1,
> +	TM2_TOUCHKEY_KEY_BACK,
> +};
> +
> +#define tm2_touchkey_power_enable(x) __tm2_touchkey_power_onoff(x, 1)
> +#define tm2_touchkey_power_disable(x) __tm2_touchkey_power_onoff(x, 0)
> +
> +struct tm2_touchkey_data {
> +	struct i2c_client *client;
> +	struct input_dev *input_dev;
> +	struct led_classdev led_dev;
> +
> +	u8 keycode_type;
> +	u8 pressed;
> +	struct work_struct irq_work;
> +
> +	bool power_onoff;
> +	struct regulator *regulator_vcc;	/* 1.8V */
> +	struct regulator *regulator_vdd;	/* 3.3V */
> +};
> +
> +static void tm2_touchkey_led_brightness_set(struct led_classdev *led_dev,
> +						enum led_brightness brightness)
> +{
> +	struct tm2_touchkey_data *samsung_touchkey =
> +	    container_of(led_dev, struct tm2_touchkey_data, led_dev);
> +	u32 volt;
> +	u8 data;
> +
> +	if (brightness == LED_OFF) {
> +		volt = TM2_TOUCHKEY_LED_VOLTAGE_MIN;
> +		data = TM2_TOUCHKEY_CMD_LED_OFF;
> +	} else {
> +		volt = TM2_TOUCHKEY_LED_VOLTAGE_MAX;
> +		data = TM2_TOUCHKEY_CMD_LED_ON;
> +	}
> +
> +	regulator_set_voltage(samsung_touchkey->regulator_vdd, volt, volt);
> +	i2c_smbus_write_byte_data(samsung_touchkey->client,
> +				  TM2_TOUCHKEY_BASE_REG, data);
> +}
> +
> +static int __tm2_touchkey_power_onoff(struct tm2_touchkey_data
> +					  *samsung_touchkey, bool onoff)
> +{
> +	int ret = 0;
> +
> +	if (samsung_touchkey->power_onoff == onoff)
> +		return ret;
> +
> +	if (onoff) {
> +		ret = regulator_enable(samsung_touchkey->regulator_vcc);
> +		if (ret)
> +			return ret;
> +
> +		ret = regulator_enable(samsung_touchkey->regulator_vdd);
> +		if (ret) {
> +			regulator_disable(samsung_touchkey->regulator_vcc);
> +			return ret;
> +		}

I would add a comment about the sleep here.

> +		msleep(150);
> +	} else {
> +		int err;
> +
> +		err = regulator_disable(samsung_touchkey->regulator_vcc);
> +		if (err)
> +			ret = err;
> +
> +		err = regulator_disable(samsung_touchkey->regulator_vdd);
> +		if (err && !ret)
> +			ret = err;
> +	}
> +	samsung_touchkey->power_onoff = onoff;
> +
> +	return ret;
> +}
> +
> +static void tm2_touchkey_irq_work(struct work_struct *irq_work)
> +{
> +	struct tm2_touchkey_data *samsung_touchkey =
> +	    container_of(irq_work, struct tm2_touchkey_data, irq_work);
> +
> +	if (!samsung_touchkey->pressed) {
> +		input_report_key(samsung_touchkey->input_dev, KEY_PHONE, 0);
> +		input_report_key(samsung_touchkey->input_dev, KEY_BACK, 0);
> +	} else {
> +		if (samsung_touchkey->keycode_type == TM2_TOUCHKEY_KEY_MENU)
> +			input_report_key(samsung_touchkey->input_dev,
> +					 KEY_PHONE, 1);
> +		else
> +			input_report_key(samsung_touchkey->input_dev,
> +					 KEY_BACK, 1);
> +	}
> +	input_sync(samsung_touchkey->input_dev);
> +}
> +
> +static irqreturn_t tm2_touchkey_irq_handler(int irq, void *devid)
> +{
> +	struct tm2_touchkey_data *samsung_touchkey = devid;
> +	u32 data;
> +
> +	data = i2c_smbus_read_byte_data(samsung_touchkey->client,
> +					TM2_TOUCHKEY_KEYCODE_REG);
> +
> +	if (data < 0) {
> +		dev_err(&samsung_touchkey->client->dev, "Failed to read i2c data\n");
> +		return IRQ_HANDLED;
> +	}
> +
> +	samsung_touchkey->keycode_type = data & TM2_TOUCHKEY_BIT_KEYCODE;
> +	samsung_touchkey->pressed = !(data & TM2_TOUCHKEY_BIT_PRESS_EV);
> +
> +	if (samsung_touchkey->keycode_type != TM2_TOUCHKEY_KEY_MENU &&
> +	    samsung_touchkey->keycode_type != TM2_TOUCHKEY_KEY_BACK)

Shouldn't at least a debug message be printed here so the user can
know that an error occurred and a correct keycode was not received?

> +		return IRQ_HANDLED;
> +
> +	schedule_work(&samsung_touchkey->irq_work);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int tm2_touchkey_probe(struct i2c_client *client,
> +				  const struct i2c_device_id *id)
> +{
> +	struct tm2_touchkey_data *samsung_touchkey;
> +	int ret;
> +
> +	ret = i2c_check_functionality(client->adapter,
> +				      I2C_FUNC_SMBUS_BYTE |
> +				      I2C_FUNC_SMBUS_BYTE_DATA);
> +	if (!ret) {
> +		dev_err(&client->dev, "No I2C functionality found\n");
> +		return -ENODEV;
> +	}
> +
> +	samsung_touchkey = devm_kzalloc(&client->dev,
> +			sizeof(struct tm2_touchkey_data), GFP_KERNEL);
> +
> +	if (!samsung_touchkey) {
> +		dev_err(&client->dev, "Failed to allocate memory.\n");
> +		return -ENOMEM;
> +	}
> +
> +	samsung_touchkey->client = client;
> +	i2c_set_clientdata(client, samsung_touchkey);
> +	INIT_WORK(&samsung_touchkey->irq_work, tm2_touchkey_irq_work);
> +
> +	/* regulator */
> +	samsung_touchkey->regulator_vcc =
> +				devm_regulator_get(&client->dev, "vcc");
> +	if (IS_ERR(samsung_touchkey->regulator_vcc)) {
> +		dev_err(&client->dev, "Failed to get vcc regulator\n");
> +		return PTR_ERR(samsung_touchkey->regulator_vcc);
> +	}
> +
> +	samsung_touchkey->regulator_vdd =
> +				devm_regulator_get(&client->dev, "vdd");
> +	if (IS_ERR(samsung_touchkey->regulator_vdd)) {
> +		dev_err(&client->dev, "Failed to get vdd regulator\n");
> +		return PTR_ERR(samsung_touchkey->regulator_vcc);
> +	}
> +
> +	/* power */
> +	ret = tm2_touchkey_power_enable(samsung_touchkey);
> +	if (ret) {
> +		dev_err(&client->dev, "Failed to enable power\n");
> +		return ret;
> +	}
> +
> +	/* irq */
> +	ret = devm_request_threaded_irq(&client->dev,
> +					client->irq, NULL,
> +					tm2_touchkey_irq_handler,
> +					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> +					TM2_TOUCHKEY_DEV_NAME,
> +					samsung_touchkey);
> +	if (ret) {
> +		dev_err(&client->dev, "Failed to request threaded irq\n");
> +		return ret;
> +	}
> +
> +	/* input device */
> +	samsung_touchkey->input_dev = devm_input_allocate_device(&client->dev);
> +	if (!samsung_touchkey->input_dev) {
> +		dev_err(&client->dev, "Failed to alloc input device.\n");
> +		return -ENOMEM;
> +	}
> +	samsung_touchkey->input_dev->name = TM2_TOUCHKEY_DEV_NAME;
> +	samsung_touchkey->input_dev->id.bustype = BUS_I2C;
> +	samsung_touchkey->input_dev->dev.parent = &client->dev;
> +
> +	set_bit(EV_KEY, samsung_touchkey->input_dev->evbit);
> +	set_bit(KEY_PHONE, samsung_touchkey->input_dev->keybit);
> +	set_bit(KEY_BACK, samsung_touchkey->input_dev->keybit);
> +	input_set_drvdata(samsung_touchkey->input_dev, samsung_touchkey);
> +
> +	ret = input_register_device(samsung_touchkey->input_dev);
> +	if (ret) {
> +		dev_err(&client->dev, "Failed to register input device.\n");
> +		return ret;
> +	}
> +
> +	/* led device */
> +	samsung_touchkey->led_dev.name = TM2_TOUCHKEY_DEV_NAME;
> +	samsung_touchkey->led_dev.brightness = LED_FULL;
> +	samsung_touchkey->led_dev.max_brightness = LED_FULL;
> +	samsung_touchkey->led_dev.brightness_set =
> +						tm2_touchkey_led_brightness_set;
> +
> +	ret = devm_led_classdev_register(&client->dev,
> +					 &samsung_touchkey->led_dev);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "Failed to register touchkey led\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static void tm2_touchkey_shutdown(struct i2c_client *client)
> +{
> +	struct tm2_touchkey_data *samsung_touchkey =
> +						i2c_get_clientdata(client);
> +	int ret;
> +
> +	disable_irq(client->irq);
> +	ret = tm2_touchkey_power_disable(samsung_touchkey);
> +	if (ret)
> +		dev_err(&client->dev, "Failed to disable power\n");
> +}
> +
> +static int tm2_touchkey_suspend(struct device *dev)
> +{
> +	struct tm2_touchkey_data *samsung_touchkey = dev_get_drvdata(dev);
> +	int ret;
> +
> +	disable_irq(samsung_touchkey->client->irq);
> +	ret = tm2_touchkey_power_disable(samsung_touchkey);
> +	if (ret)
> +		dev_err(dev, "Failed to disable power\n");
> +
> +	return ret;
> +}

These two functions are basically the same, can you factor it out?

> +
> +static int tm2_touchkey_resume(struct device *dev)
> +{
> +	struct tm2_touchkey_data *samsung_touchkey = dev_get_drvdata(dev);
> +	int ret;
> +
> +	enable_irq(samsung_touchkey->client->irq);
> +	ret = tm2_touchkey_power_enable(samsung_touchkey);
> +	if (ret)
> +		dev_err(dev, "Failed to enable power\n");
> +
> +	return ret;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(tm2_touchkey_pm_ops, tm2_touchkey_suspend,
> +							tm2_touchkey_resume);
> +
> +static const struct i2c_device_id tm2_touchkey_id_table[] = {
> +	{TM2_TOUCHKEY_DEV_NAME, 0},
> +	{},
> +};
> +

You need a MODULE_DEVICE_TABLE(i2c, tm2_touchkey_id_table) here so the
module can be autoloaded when the device is registered.

> +static const struct of_device_id tm2_touchkey_of_match[] = {
> +	{.compatible = "samsung,tm2-touchkey",},
> +	{},
> +};
> +

Here a MODULE_DEVICE_TABLE(of, tm2_touchkey_of_match) is not strictly
needed since the I2C core always reports MODALIAS of the form i2c:<dev>
but still is good to have so the I2C core can be fixed at some point.

> +static struct i2c_driver tm2_touchkey_driver = {
> +	.driver = {
> +		.name = TM2_TOUCHKEY_DEV_NAME,
> +		.pm = &tm2_touchkey_pm_ops,
> +		.of_match_table = of_match_ptr(tm2_touchkey_of_match),
> +	},
> +	.probe = tm2_touchkey_probe,
> +	.shutdown = tm2_touchkey_shutdown,
> +	.id_table = tm2_touchkey_id_table,
> +};
> +
> +module_i2c_driver(tm2_touchkey_driver);
> +
> +MODULE_AUTHOR("Beomho Seo <beomho.seo@samsung.com>");
> +MODULE_AUTHOR("Jaechul Lee <jcsing.lee@samsung.com>");
> +MODULE_DESCRIPTION("Samsung touchkey driver");
> +MODULE_LICENSE("GPL v2");
> 

The rest looks good to me, so after the changes I suggested:

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
