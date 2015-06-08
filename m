From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RESEND PATCH V4 3/3] mfd: da9063: MFD support for OnKey driver
Date: Mon, 8 Jun 2015 16:25:07 -0700
Message-ID: <20150608232507.GB420@dtor-ws>
References: <cover.1432031565.git.stwiss.opensource@diasemi.com>
 <a508f5d715e94fb18e6ef4ce755c2225a17090ea.1432031565.git.stwiss.opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:33970 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932248AbbFHXZM (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 8 Jun 2015 19:25:12 -0400
Content-Disposition: inline
In-Reply-To: <a508f5d715e94fb18e6ef4ce755c2225a17090ea.1432031565.git.stwiss.opensource@diasemi.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: S Twiss <stwiss.opensource@diasemi.com>
Cc: Lee Jones <lee.jones@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, DT <devicetree@vger.kernel.org>, David Dajun Chen <david.chen@diasemi.com>, INPUT <linux-input@vger.kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, LKML <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, Support Opensource <support.opensource@diasemi.com>

On Tue, May 19, 2015 at 11:32:45AM +0100, S Twiss wrote:
> From: Steve Twiss <stwiss.opensource@diasemi.com>
> 
> Add MFD support for the DA9063 OnKey driver
> 
> The function da9063_clear_fault_log() is added to mitigate the case of a
> hardware power-cut after a long-long OnKey press. Although there is no
> software intervention in this case (by definition) such a shutdown would
> cause persistent information within the DA9063 FAULT_LOG that would be
> available during the next device restart.
> 
> Clearance of this persistent register must be completed after such a
> hardware power-cut operation has happened so that the FAULT_LOG does not
> continue with previous values. The clearance function has been added here
> in the kernel driver because wiping the fault-log cannot be counted on
> outside the Linux kernel.
> 
> Acked-by: Lee Jones <lee.jones@linaro.org>
> 
> Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>

...

> diff --git a/include/linux/mfd/da9063/pdata.h b/include/linux/mfd/da9063/pdata.h
> index 95c8742..612383b 100644
> --- a/include/linux/mfd/da9063/pdata.h
> +++ b/include/linux/mfd/da9063/pdata.h
> @@ -103,6 +103,7 @@ struct da9063;
>  struct da9063_pdata {
>  	int				(*init)(struct da9063 *da9063);
>  	int				irq_base;
> +	bool				key_power;
>  	unsigned			flags;
>  	struct da9063_regulators_pdata	*regulators_pdata;
>  	struct led_platform_data	*leds_pdata;

I need this bit of pdata to merge the OnKey driver... Lee, any chance
you could drop it from the patch in your tree?

Alternatively, can you pick the OnKey driver (the latest version is
below)?

Thanks.

-- 
Dmitry

Input: add OnKey driver for DA9063 MFD part

From: Steve Twiss <stwiss.opensource@diasemi.com>

Add OnKey driver support for DA9063

Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/misc/Kconfig        |   10 ++
 drivers/input/misc/Makefile       |    1 
 drivers/input/misc/da9063_onkey.c |  226 +++++++++++++++++++++++++++++++++++++
 3 files changed, 237 insertions(+)
 create mode 100644 drivers/input/misc/da9063_onkey.c

diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index e5c4de2..d4f0a81 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -610,6 +610,16 @@ config INPUT_DA9055_ONKEY
 	  To compile this driver as a module, choose M here: the module
 	  will be called da9055_onkey.
 
+config INPUT_DA9063_ONKEY
+	tristate "Dialog DA9063 OnKey"
+	depends on MFD_DA9063
+	help
+	  Support the ONKEY of Dialog DA9063 Power Management IC as an
+	  input device reporting power button statue.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called da9063_onkey.
+
 config INPUT_DM355EVM
 	tristate "TI DaVinci DM355 EVM Keypad and IR Remote"
 	depends on MFD_DM355EVM_MSP
diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
index d317947..53df07d 100644
--- a/drivers/input/misc/Makefile
+++ b/drivers/input/misc/Makefile
@@ -25,6 +25,7 @@ obj-$(CONFIG_INPUT_CMA3000_I2C)		+= cma3000_d0x_i2c.o
 obj-$(CONFIG_INPUT_COBALT_BTNS)		+= cobalt_btns.o
 obj-$(CONFIG_INPUT_DA9052_ONKEY)	+= da9052_onkey.o
 obj-$(CONFIG_INPUT_DA9055_ONKEY)	+= da9055_onkey.o
+obj-$(CONFIG_INPUT_DA9063_ONKEY)	+= da9063_onkey.o
 obj-$(CONFIG_INPUT_DM355EVM)		+= dm355evm_keys.o
 obj-$(CONFIG_INPUT_E3X0_BUTTON)		+= e3x0-button.o
 obj-$(CONFIG_INPUT_DRV260X_HAPTICS)	+= drv260x.o
diff --git a/drivers/input/misc/da9063_onkey.c b/drivers/input/misc/da9063_onkey.c
new file mode 100644
index 0000000..f577585
--- /dev/null
+++ b/drivers/input/misc/da9063_onkey.c
@@ -0,0 +1,226 @@
+/*
+ * OnKey device driver for DA9063
+ * Copyright (C) 2015  Dialog Semiconductor Ltd.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/module.h>
+#include <linux/errno.h>
+#include <linux/input.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <linux/workqueue.h>
+#include <linux/regmap.h>
+#include <linux/of.h>
+#include <linux/mfd/da9063/core.h>
+#include <linux/mfd/da9063/pdata.h>
+#include <linux/mfd/da9063/registers.h>
+
+struct da9063_onkey {
+	struct da9063 *hw;
+	struct delayed_work work;
+	struct input_dev *input;
+	struct device *dev;
+	bool key_power;
+};
+
+static void da9063_poll_on(struct work_struct *work)
+{
+	struct da9063_onkey *onkey = container_of(work, struct da9063_onkey,
+						  work.work);
+	unsigned int val;
+	int fault_log = 0;
+	bool poll = true;
+	int error;
+
+	/* Poll to see when the pin is released */
+	error = regmap_read(onkey->hw->regmap, DA9063_REG_STATUS_A, &val);
+	if (error) {
+		dev_err(onkey->dev,
+			"Failed to read ON status: %d\n", error);
+		goto err_poll;
+	}
+
+	if (!(val & DA9063_NONKEY)) {
+		error = regmap_update_bits(onkey->hw->regmap,
+					   DA9063_REG_CONTROL_B,
+					   DA9063_NONKEY_LOCK, 0);
+		if (error) {
+			dev_err(onkey->dev,
+				"Failed to reset the Key Delay %d\n", error);
+			goto err_poll;
+		}
+
+		input_report_key(onkey->input, KEY_POWER, 0);
+		input_sync(onkey->input);
+
+		poll = false;
+	}
+
+	/*
+	 * If the fault log KEY_RESET is detected, then clear it
+	 * and shut down the system.
+	 */
+	error = regmap_read(onkey->hw->regmap,
+			    DA9063_REG_FAULT_LOG, &fault_log);
+	if (error) {
+		dev_warn(&onkey->input->dev,
+			 "Cannot read FAULT_LOG: %d\n", error);
+	} else if (fault_log & DA9063_KEY_RESET) {
+		error = regmap_write(onkey->hw->regmap,
+				     DA9063_REG_FAULT_LOG,
+				     DA9063_KEY_RESET);
+		if (error) {
+			dev_warn(&onkey->input->dev,
+				 "Cannot reset KEY_RESET fault log: %d\n",
+				 error);
+		} else {
+			/* at this point we do any S/W housekeeping
+			 * and then send shutdown command
+			 */
+			dev_dbg(&onkey->input->dev,
+				 "Sending SHUTDOWN to DA9063 ...\n");
+			error = regmap_write(onkey->hw->regmap,
+					     DA9063_REG_CONTROL_F,
+					     DA9063_SHUTDOWN);
+			if (error)
+				dev_err(&onkey->input->dev,
+					"Cannot SHUTDOWN DA9063: %d\n",
+					error);
+		}
+	}
+
+err_poll:
+	if (poll)
+		schedule_delayed_work(&onkey->work, msecs_to_jiffies(50));
+}
+
+static irqreturn_t da9063_onkey_irq_handler(int irq, void *data)
+{
+	struct da9063_onkey *onkey = data;
+	unsigned int val;
+	int error;
+
+	error = regmap_read(onkey->hw->regmap, DA9063_REG_STATUS_A, &val);
+	if (onkey->key_power && !error && (val & DA9063_NONKEY)) {
+		input_report_key(onkey->input, KEY_POWER, 1);
+		input_sync(onkey->input);
+		schedule_delayed_work(&onkey->work, 0);
+		dev_dbg(onkey->dev, "KEY_POWER pressed.\n");
+	} else {
+		input_report_key(onkey->input, KEY_SLEEP, 1);
+		input_sync(onkey->input);
+		input_report_key(onkey->input, KEY_SLEEP, 0);
+		input_sync(onkey->input);
+		dev_dbg(onkey->dev, "KEY_SLEEP pressed.\n");
+	}
+
+	return IRQ_HANDLED;
+}
+
+static void da9063_cancel_poll(void *data)
+{
+	struct da9063_onkey *onkey = data;
+
+	cancel_delayed_work_sync(&onkey->work);
+}
+
+static int da9063_onkey_probe(struct platform_device *pdev)
+{
+	struct da9063 *da9063 = dev_get_drvdata(pdev->dev.parent);
+	struct da9063_pdata *pdata = dev_get_platdata(da9063->dev);
+	struct da9063_onkey *onkey;
+	int irq;
+	int error;
+
+	onkey = devm_kzalloc(&pdev->dev, sizeof(struct da9063_onkey),
+			     GFP_KERNEL);
+	if (!onkey) {
+		dev_err(&pdev->dev, "Failed to allocate memory.\n");
+		return -ENOMEM;
+	}
+
+	onkey->dev = &pdev->dev;
+	onkey->hw = da9063;
+
+	if (pdata)
+		onkey->key_power = pdata->key_power;
+	else
+		onkey->key_power =
+			!of_property_read_bool(pdev->dev.of_node,
+					       "dlg,disable-key-power");
+
+	onkey->input = devm_input_allocate_device(&pdev->dev);
+	if (!onkey->input) {
+		dev_err(&pdev->dev, "Failed to allocated input device.\n");
+		return -ENOMEM;
+	}
+
+	onkey->input->name = DA9063_DRVNAME_ONKEY;
+	onkey->input->phys = DA9063_DRVNAME_ONKEY "/input0";
+	onkey->input->dev.parent = &pdev->dev;
+
+	if (onkey->key_power)
+		input_set_capability(onkey->input, EV_KEY, KEY_POWER);
+
+	input_set_capability(onkey->input, EV_KEY, KEY_SLEEP);
+
+	INIT_DELAYED_WORK(&onkey->work, da9063_poll_on);
+
+	error = devm_add_action(&pdev->dev, da9063_cancel_poll, onkey);
+	if (error) {
+		dev_err(&pdev->dev,
+			"Failed to add cancel poll action: %d\n",
+			error);
+		return error;
+	}
+
+	irq = platform_get_irq_byname(pdev, "ONKEY");
+	if (irq < 0) {
+		error = irq;
+		dev_err(&pdev->dev, "Failed to get platform IRQ: %d\n", error);
+		return error;
+	}
+
+	error = devm_request_threaded_irq(&pdev->dev, irq,
+					  NULL, da9063_onkey_irq_handler,
+					  IRQF_TRIGGER_LOW | IRQF_ONESHOT,
+					  "ONKEY", onkey);
+	if (error) {
+		dev_err(&pdev->dev,
+			"Failed to request IRQ %d: %d\n", irq, error);
+		return error;
+	}
+
+	error = input_register_device(onkey->input);
+	if (error) {
+		dev_err(&pdev->dev,
+			"Failed to register input device: %d\n", error);
+		return error;
+	}
+
+	platform_set_drvdata(pdev, onkey);
+	return 0;
+}
+
+static struct platform_driver da9063_onkey_driver = {
+	.probe	= da9063_onkey_probe,
+	.driver	= {
+		.name	= DA9063_DRVNAME_ONKEY,
+	},
+};
+module_platform_driver(da9063_onkey_driver);
+
+MODULE_AUTHOR("S Twiss <stwiss.opensource@diasemi.com>");
+MODULE_DESCRIPTION("Onkey device driver for Dialog DA9063");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:" DA9063_DRVNAME_ONKEY);
