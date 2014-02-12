From: Christopher Heiny <cheiny@synaptics.com>
Subject: Re: [PATCH] input synaptics-rmi4: rmi_f01.c storage fix
Date: Wed, 12 Feb 2014 15:08:16 -0800
Message-ID: <52FBFEE0.10809@synaptics.com>
References: <1392160380-8221-1-git-send-email-cheiny@synaptics.com> <20140212064049.GA15855@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:12415 "EHLO
	us-mx2.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754561AbaBLXIS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 12 Feb 2014 18:08:18 -0500
In-Reply-To: <20140212064049.GA15855@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Jean Delvare <khali@linux-fr.org>, Joerie de Gram <j.de.gram@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, David Herrmann <dh.herrmann@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Courtney Cavin <courtney.cavin@sonymobile.com>

On 02/11/2014 10:40 PM, Dmitry Torokhov wrote:
> Hi Chris,
>
> On Tue, Feb 11, 2014 at 03:13:00PM -0800, Christopher Heiny wrote:
>> >Correctly free driver related data when initialization fails.
>> >
>> >Trivial: Clarify a diagnostic message.
>> >
>> >Signed-off-by: Christopher Heiny<cheiny@synaptics.com>
>> >Cc: Dmitry Torokhov<dmitry.torokhov@gmail.com>
>> >Cc: Benjamin Tissoires<benjamin.tissoires@redhat.com>
>> >Cc: Linux Walleij<linus.walleij@linaro.org>
>> >Cc: David Herrmann<dh.herrmann@gmail.com>
>> >Cc: Jiri Kosina<jkosina@suse.cz>
>> >
>> >---
>> >
>> >  drivers/input/rmi4/rmi_f01.c | 6 ++++--
>> >  1 file changed, 4 insertions(+), 2 deletions(-)
>> >
>> >diff --git a/drivers/input/rmi4/rmi_f01.c b/drivers/input/rmi4/rmi_f01.c
>> >index 381ad60..e4a6df9 100644
>> >--- a/drivers/input/rmi4/rmi_f01.c
>> >+++ b/drivers/input/rmi4/rmi_f01.c
>> >@@ -149,7 +149,7 @@ static int rmi_f01_alloc_memory(struct rmi_function *fn,
>> >
>> >  	f01 = devm_kzalloc(&fn->dev, sizeof(struct f01_data), GFP_KERNEL);
>> >  	if (!f01) {
>> >-		dev_err(&fn->dev, "Failed to allocate fn_01_data.\n");
>> >+		dev_err(&fn->dev, "Failed to allocate f01_data.\n");
>> >  		return -ENOMEM;
>> >  	}
>> >
>> >@@ -158,6 +158,7 @@ static int rmi_f01_alloc_memory(struct rmi_function *fn,
>> >  			GFP_KERNEL);
>> >  	if (!f01->device_control.interrupt_enable) {
>> >  		dev_err(&fn->dev, "Failed to allocate interrupt enable.\n");
>> >+		devm_kfree(&fn->dev, f01);
> As Courtney mentioned if you are calling devm_kfree() you are most
> likely doing something wrong.
>
> How about the patch below? Please check the XXX comment, I have some
> concerns about lts vs doze_holdoff check mismatch in probe() and
> config().

Thanks for calling attention to the has_lts vs doze_holdoff check. 
There was actually a bug in two places relating to that.  It looks like 
a case of cut/paste dyslexia (or something like that).  Anyway, here's a 
version of your patch with those two bugs fixed.  I've tested this on 
Nexus 4.

					Chris


Input: synaptics-rmi4 - F01 initialization cleanup

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

- rename data to f01 where appropriate;
- switch to using rmi_read()/rmi_write() for single-byte data;
- allocate interrupt mask together with the main structure;
- do not kfree() memory allocated with devm;
- do not write config data in probe(), we have config() for that;
- drop unneeded rmi_f01_remove().
- correctly calculate control register address based on has_lts
- correctly write adjustable doze control registers

Reported-by: Courtney Cavin <courtney.cavin@sonymobile.com>
Reported-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Christopher Heiny <cheiny@synaptics.com>

---

  drivers/input/rmi4/rmi_f01.c | 400 
+++++++++++++++++++------------------------
  1 file changed, 173 insertions(+), 227 deletions(-)

diff --git a/drivers/input/rmi4/rmi_f01.c b/drivers/input/rmi4/rmi_f01.c
index 381ad60..9932548 100644
--- a/drivers/input/rmi4/rmi_f01.c
+++ b/drivers/input/rmi4/rmi_f01.c
@@ -123,47 +123,21 @@ struct f01_device_control {

  struct f01_data {
  	struct f01_basic_properties properties;
-
  	struct f01_device_control device_control;
-	struct mutex control_mutex;
-
-	u8 device_status;

  	u16 interrupt_enable_addr;
  	u16 doze_interval_addr;
  	u16 wakeup_threshold_addr;
  	u16 doze_holdoff_addr;
-	int irq_count;
-	int num_of_irq_regs;

  #ifdef CONFIG_PM_SLEEP
  	bool suspended;
  	bool old_nosleep;
  #endif
-};
-
-static int rmi_f01_alloc_memory(struct rmi_function *fn,
-				int num_of_irq_regs)
-{
-	struct f01_data *f01;
-
-	f01 = devm_kzalloc(&fn->dev, sizeof(struct f01_data), GFP_KERNEL);
-	if (!f01) {
-		dev_err(&fn->dev, "Failed to allocate fn_01_data.\n");
-		return -ENOMEM;
-	}
-
-	f01->device_control.interrupt_enable = devm_kzalloc(&fn->dev,
-			sizeof(u8) * (num_of_irq_regs),
-			GFP_KERNEL);
-	if (!f01->device_control.interrupt_enable) {
-		dev_err(&fn->dev, "Failed to allocate interrupt enable.\n");
-		return -ENOMEM;
-	}
-	fn->data = f01;

-	return 0;
-}
+	unsigned int num_of_irq_regs;
+	u8 interrupt_enable[];
+};

  static int rmi_f01_read_properties(struct rmi_device *rmi_dev,
  				   u16 query_base_addr,
@@ -174,8 +148,9 @@ static int rmi_f01_read_properties(struct rmi_device 
*rmi_dev,

  	error = rmi_read_block(rmi_dev, query_base_addr,
  			       basic_query, sizeof(basic_query));
-	if (error < 0) {
-		dev_err(&rmi_dev->dev, "Failed to read device query registers.\n");
+	if (error) {
+		dev_err(&rmi_dev->dev,
+			"Failed to read device query registers: %d\n", error);
  		return error;
  	}

@@ -204,38 +179,51 @@ static int rmi_f01_read_properties(struct 
rmi_device *rmi_dev,
  	return 0;
  }

-static int rmi_f01_initialize(struct rmi_function *fn)
+static int rmi_f01_probe(struct rmi_function *fn)
  {
-	u8 temp;
-	int error;
-	u16 ctrl_base_addr;
  	struct rmi_device *rmi_dev = fn->rmi_dev;
  	struct rmi_driver_data *driver_data = dev_get_drvdata(&rmi_dev->dev);
-	struct f01_data *data = fn->data;
-	struct rmi_device_platform_data *pdata = to_rmi_platform_data(rmi_dev);
+	const struct rmi_device_platform_data *pdata =
+				to_rmi_platform_data(rmi_dev);
+	struct f01_data *f01;
+	size_t f01_size;
+	int error;
+	u16 ctrl_base_addr;
+	u8 device_status;
+	u8 temp;

-	mutex_init(&data->control_mutex);
+	f01_size = sizeof(struct f01_data) +
+				sizeof(u8) * driver_data->num_of_irq_regs;
+	f01 = devm_kzalloc(&fn->dev, f01_size, GFP_KERNEL);
+	if (!f01) {
+		dev_err(&fn->dev, "Failed to allocate fn01_data.\n");
+		return -ENOMEM;
+	}
+
+	f01->num_of_irq_regs = driver_data->num_of_irq_regs;
+	f01->device_control.interrupt_enable = f01->interrupt_enable;

  	/*
  	 * Set the configured bit and (optionally) other important stuff
  	 * in the device control register.
  	 */
  	ctrl_base_addr = fn->fd.control_base_addr;
-	error = rmi_read_block(rmi_dev, fn->fd.control_base_addr,
-			&data->device_control.ctrl0,
-			sizeof(data->device_control.ctrl0));
-	if (error < 0) {
-		dev_err(&fn->dev, "Failed to read F01 control.\n");
+
+	error = rmi_read(rmi_dev, fn->fd.control_base_addr,
+			 &f01->device_control.ctrl0);
+	if (error) {
+		dev_err(&fn->dev, "Failed to read F01 control: %d\n", error);
  		return error;
  	}
+
  	switch (pdata->power_management.nosleep) {
  	case RMI_F01_NOSLEEP_DEFAULT:
  		break;
  	case RMI_F01_NOSLEEP_OFF:
-		data->device_control.ctrl0 &= ~RMI_F01_CRTL0_NOSLEEP_BIT;
+		f01->device_control.ctrl0 &= ~RMI_F01_CRTL0_NOSLEEP_BIT;
  		break;
  	case RMI_F01_NOSLEEP_ON:
-		data->device_control.ctrl0 |= RMI_F01_CRTL0_NOSLEEP_BIT;
+		f01->device_control.ctrl0 |= RMI_F01_CRTL0_NOSLEEP_BIT;
  		break;
  	}

@@ -244,250 +232,212 @@ static int rmi_f01_initialize(struct 
rmi_function *fn)
  	 * reboot without power cycle.  If so, clear it so the sensor
  	 * is certain to function.
  	 */
-	if ((data->device_control.ctrl0 & RMI_F01_CTRL0_SLEEP_MODE_MASK) !=
+	if ((f01->device_control.ctrl0 & RMI_F01_CTRL0_SLEEP_MODE_MASK) !=
  			RMI_SLEEP_MODE_NORMAL) {
  		dev_warn(&fn->dev,
  			 "WARNING: Non-zero sleep mode found. Clearing...\n");
-		data->device_control.ctrl0 &= ~RMI_F01_CTRL0_SLEEP_MODE_MASK;
+		f01->device_control.ctrl0 &= ~RMI_F01_CTRL0_SLEEP_MODE_MASK;
  	}

-	data->device_control.ctrl0 |= RMI_F01_CRTL0_CONFIGURED_BIT;
+	f01->device_control.ctrl0 |= RMI_F01_CRTL0_CONFIGURED_BIT;

-	error = rmi_write_block(rmi_dev, fn->fd.control_base_addr,
-				&data->device_control.ctrl0,
-				sizeof(data->device_control.ctrl0));
-	if (error < 0) {
-		dev_err(&fn->dev, "Failed to write F01 control.\n");
+	error = rmi_write(rmi_dev, fn->fd.control_base_addr,
+			  f01->device_control.ctrl0);
+	if (error) {
+		dev_err(&fn->dev, "Failed to write F01 control: %d\n", error);
  		return error;
  	}

-	data->irq_count = driver_data->irq_count;
-	data->num_of_irq_regs = driver_data->num_of_irq_regs;
-	ctrl_base_addr += sizeof(u8);
+	f01->num_of_irq_regs = driver_data->num_of_irq_regs;
+	ctrl_base_addr += sizeof(f01->device_control.ctrl0);

-	data->interrupt_enable_addr = ctrl_base_addr;
+	f01->interrupt_enable_addr = ctrl_base_addr;
  	error = rmi_read_block(rmi_dev, ctrl_base_addr,
-				data->device_control.interrupt_enable,
-				sizeof(u8) * (data->num_of_irq_regs));
-	if (error < 0) {
+				f01->device_control.interrupt_enable,
+				sizeof(u8) * (f01->num_of_irq_regs));
+	if (error) {
  		dev_err(&fn->dev,
-			"Failed to read F01 control interrupt enable register.\n");
-		goto error_exit;
+			"Failed to read F01 control interrupt enable register: %d\n",
+			error);
+		return error;
  	}

-	ctrl_base_addr += data->num_of_irq_regs;
+	ctrl_base_addr += f01->num_of_irq_regs;

  	/* dummy read in order to clear irqs */
  	error = rmi_read(rmi_dev, fn->fd.data_base_addr + 1, &temp);
-	if (error < 0) {
+	if (error) {
  		dev_err(&fn->dev, "Failed to read Interrupt Status.\n");
  		return error;
  	}

  	error = rmi_f01_read_properties(rmi_dev, fn->fd.query_base_addr,
-					&data->properties);
-	if (error < 0) {
+					&f01->properties);
+	if (error) {
  		dev_err(&fn->dev, "Failed to read F01 properties.\n");
  		return error;
  	}
+
  	dev_info(&fn->dev, "found RMI device, manufacturer: %s, product: %s\n",
-		 data->properties.manufacturer_id == 1 ?
-							"Synaptics" : "unknown",
-		 data->properties.product_id);
+		 f01->properties.manufacturer_id == 1 ? "Synaptics" : "unknown",
+		 f01->properties.product_id);

  	/* read control register */
-	if (data->properties.has_adjustable_doze) {
-		data->doze_interval_addr = ctrl_base_addr;
+	if (f01->properties.has_adjustable_doze) {
+		f01->doze_interval_addr = ctrl_base_addr;
  		ctrl_base_addr++;

  		if (pdata->power_management.doze_interval) {
-			data->device_control.doze_interval =
+			f01->device_control.doze_interval =
  				pdata->power_management.doze_interval;
-			error = rmi_write(rmi_dev, data->doze_interval_addr,
-					data->device_control.doze_interval);
-			if (error < 0) {
-				dev_err(&fn->dev, "Failed to configure F01 doze interval register.\n");
-				goto error_exit;
-			}
  		} else {
-			error = rmi_read(rmi_dev, data->doze_interval_addr,
-					&data->device_control.doze_interval);
-			if (error < 0) {
-				dev_err(&fn->dev, "Failed to read F01 doze interval register.\n");
-				goto error_exit;
+			error = rmi_read(rmi_dev, f01->doze_interval_addr,
+					&f01->device_control.doze_interval);
+			if (error) {
+				dev_err(&fn->dev,
+					"Failed to read F01 doze interval register: %d\n",
+					error);
+				return error;
  			}
  		}

-		data->wakeup_threshold_addr = ctrl_base_addr;
+		f01->wakeup_threshold_addr = ctrl_base_addr;
  		ctrl_base_addr++;

  		if (pdata->power_management.wakeup_threshold) {
-			data->device_control.wakeup_threshold =
+			f01->device_control.wakeup_threshold =
  				pdata->power_management.wakeup_threshold;
-			error = rmi_write(rmi_dev, data->wakeup_threshold_addr,
-					data->device_control.wakeup_threshold);
-			if (error < 0) {
-				dev_err(&fn->dev, "Failed to configure F01 wakeup threshold 
register.\n");
-				goto error_exit;
-			}
  		} else {
-			error = rmi_read(rmi_dev, data->wakeup_threshold_addr,
-					&data->device_control.wakeup_threshold);
-			if (error < 0) {
-				dev_err(&fn->dev, "Failed to read F01 wakeup threshold register.\n");
-				goto error_exit;
+			error = rmi_read(rmi_dev, f01->wakeup_threshold_addr,
+					 &f01->device_control.wakeup_threshold);
+			if (error) {
+				dev_err(&fn->dev,
+					"Failed to read F01 wakeup threshold register: %d\n",
+					error);
+				return error;
  			}
  		}
  	}

-	if (data->properties.has_adjustable_doze_holdoff) {
-		data->doze_holdoff_addr = ctrl_base_addr;
+	if (f01->properties.has_lts)
+		ctrl_base_addr++;
+
+	if (f01->properties.has_adjustable_doze_holdoff) {
+		f01->doze_holdoff_addr = ctrl_base_addr;
  		ctrl_base_addr++;

  		if (pdata->power_management.doze_holdoff) {
-			data->device_control.doze_holdoff =
+			f01->device_control.doze_holdoff =
  				pdata->power_management.doze_holdoff;
-			error = rmi_write(rmi_dev, data->doze_holdoff_addr,
-					data->device_control.doze_holdoff);
-			if (error < 0) {
-				dev_err(&fn->dev, "Failed to configure F01 doze holdoff register.\n");
-				goto error_exit;
-			}
  		} else {
-			error = rmi_read(rmi_dev, data->doze_holdoff_addr,
-					&data->device_control.doze_holdoff);
-			if (error < 0) {
-				dev_err(&fn->dev, "Failed to read F01 doze holdoff register.\n");
-				goto error_exit;
+			error = rmi_read(rmi_dev, f01->doze_holdoff_addr,
+					 &f01->device_control.doze_holdoff);
+			if (error) {
+				dev_err(&fn->dev,
+					"Failed to read F01 doze holdoff register: %d\n",
+					error);
+				return error;
  			}
  		}
  	}

-	error = rmi_read_block(rmi_dev, fn->fd.data_base_addr,
-		&data->device_status, sizeof(data->device_status));
-	if (error < 0) {
-		dev_err(&fn->dev, "Failed to read device status.\n");
-		goto error_exit;
+	error = rmi_read(rmi_dev, fn->fd.data_base_addr, &device_status);
+	if (error) {
+		dev_err(&fn->dev,
+			"Failed to read device status: %d\n", error);
+		return error;
  	}

-	if (RMI_F01_STATUS_UNCONFIGURED(data->device_status)) {
+	if (RMI_F01_STATUS_UNCONFIGURED(device_status)) {
  		dev_err(&fn->dev,
  			"Device was reset during configuration process, status: %#02x!\n",
-			RMI_F01_STATUS_CODE(data->device_status));
-		error = -EINVAL;
-		goto error_exit;
+			RMI_F01_STATUS_CODE(device_status));
+		return -EINVAL;
  	}

-	return 0;
+	fn->data = f01;

- error_exit:
-	kfree(data);
-	return error;
+	return 0;
  }

  static int rmi_f01_config(struct rmi_function *fn)
  {
-	struct f01_data *data = fn->data;
-	int retval;
-
-	retval = rmi_write_block(fn->rmi_dev, fn->fd.control_base_addr,
-				 &data->device_control.ctrl0,
-				 sizeof(data->device_control.ctrl0));
-	if (retval < 0) {
-		dev_err(&fn->dev, "Failed to write device_control.reg.\n");
-		return retval;
-	}
-
-	retval = rmi_write_block(fn->rmi_dev, data->interrupt_enable_addr,
-				 data->device_control.interrupt_enable,
-				 sizeof(u8) * data->num_of_irq_regs);
+	struct f01_data *f01 = fn->data;
+	int error;

-	if (retval < 0) {
-		dev_err(&fn->dev, "Failed to write interrupt enable.\n");
-		return retval;
+	error = rmi_write(fn->rmi_dev, fn->fd.control_base_addr,
+			  f01->device_control.ctrl0);
+	if (error) {
+		dev_err(&fn->dev,
+			"Failed to write device_control reg: %d\n", error);
+		return error;
  	}
-	if (data->properties.has_lts) {
-		retval = rmi_write_block(fn->rmi_dev, data->doze_interval_addr,
-					 &data->device_control.doze_interval,
-					 sizeof(u8));
-		if (retval < 0) {
-			dev_err(&fn->dev, "Failed to write doze interval.\n");
-			return retval;
-		}
+
+	error = rmi_write_block(fn->rmi_dev, f01->interrupt_enable_addr,
+				f01->interrupt_enable,
+				sizeof(u8) * f01->num_of_irq_regs);
+	if (error) {
+		dev_err(&fn->dev,
+			"Failed to write interrupt enable: %d\n", error);
+		return error;
  	}

-	if (data->properties.has_adjustable_doze) {
-		retval = rmi_write_block(fn->rmi_dev,
-					 data->wakeup_threshold_addr,
-					 &data->device_control.wakeup_threshold,
-					 sizeof(u8));
-		if (retval < 0) {
-			dev_err(&fn->dev, "Failed to write wakeup threshold.\n");
-			return retval;
+	if (f01->properties.has_adjustable_doze) {
+		error = rmi_write(fn->rmi_dev, f01->doze_interval_addr,
+				  f01->device_control.doze_interval);
+		if (error) {
+			dev_err(&fn->dev,
+				"Failed to write doze interval: %d\n", error);
+			return error;
+		}
+		error = rmi_write(fn->rmi_dev, f01->wakeup_threshold_addr,
+				  f01->device_control.wakeup_threshold);
+		if (error) {
+			dev_err(&fn->dev,
+				"Failed to write wakeup threshold: %d\n",
+				error);
+			return error;
  		}
  	}

-	if (data->properties.has_adjustable_doze_holdoff) {
-		retval = rmi_write_block(fn->rmi_dev, data->doze_holdoff_addr,
-					 &data->device_control.doze_holdoff,
-					 sizeof(u8));
-		if (retval < 0) {
-			dev_err(&fn->dev, "Failed to write doze holdoff.\n");
-			return retval;
+	if (f01->properties.has_adjustable_doze_holdoff) {
+		error = rmi_write(fn->rmi_dev, f01->doze_holdoff_addr,
+				  f01->device_control.doze_holdoff);
+		if (error) {
+			dev_err(&fn->dev,
+				"Failed to write doze holdoff: %d\n", error);
+			return error;
  		}
  	}
-	return 0;
-}
-
-static int rmi_f01_probe(struct rmi_function *fn)
-{
-	struct rmi_driver_data *driver_data =
-			dev_get_drvdata(&fn->rmi_dev->dev);
-	int error;
-
-	error = rmi_f01_alloc_memory(fn, driver_data->num_of_irq_regs);
-	if (error)
-		return error;
-
-	error = rmi_f01_initialize(fn);
-	if (error)
-		return error;

  	return 0;
  }

-static void rmi_f01_remove(struct rmi_function *fn)
-{
-	/* Placeholder for now. */
-}
-
  #ifdef CONFIG_PM_SLEEP
  static int rmi_f01_suspend(struct device *dev)
  {
  	struct rmi_function *fn = to_rmi_function(dev);
  	struct rmi_device *rmi_dev = fn->rmi_dev;
-	struct f01_data *data = fn->data;
+	struct f01_data *f01 = fn->data;
  	int error;

-	data->old_nosleep = data->device_control.ctrl0 &
-					RMI_F01_CRTL0_NOSLEEP_BIT;
-	data->device_control.ctrl0 &= ~RMI_F01_CRTL0_NOSLEEP_BIT;
+	f01->old_nosleep =
+		f01->device_control.ctrl0 & RMI_F01_CRTL0_NOSLEEP_BIT;

-	data->device_control.ctrl0 &= ~RMI_F01_CTRL0_SLEEP_MODE_MASK;
-	data->device_control.ctrl0 |= RMI_SLEEP_MODE_SENSOR_SLEEP;
+	f01->device_control.ctrl0 &= ~RMI_F01_CRTL0_NOSLEEP_BIT;

-	error = rmi_write_block(rmi_dev,
-				fn->fd.control_base_addr,
-				&data->device_control.ctrl0,
-				sizeof(data->device_control.ctrl0));
-	if (error < 0) {
-		dev_err(&fn->dev, "Failed to write sleep mode. Code: %d.\n",
-			error);
-		if (data->old_nosleep)
-			data->device_control.ctrl0 |=
-					RMI_F01_CRTL0_NOSLEEP_BIT;
-		data->device_control.ctrl0 &= ~RMI_F01_CTRL0_SLEEP_MODE_MASK;
-		data->device_control.ctrl0 |= RMI_SLEEP_MODE_NORMAL;
+	f01->device_control.ctrl0 &= ~RMI_F01_CTRL0_SLEEP_MODE_MASK;
+	f01->device_control.ctrl0 |= RMI_SLEEP_MODE_SENSOR_SLEEP;
+
+	error = rmi_write(rmi_dev, fn->fd.control_base_addr,
+			  f01->device_control.ctrl0);
+	if (error) {
+		dev_err(&fn->dev,
+			"Failed to write sleep mode: %d.\n", error);
+		if (f01->old_nosleep)
+			f01->device_control.ctrl0 |= RMI_F01_CRTL0_NOSLEEP_BIT;
+		f01->device_control.ctrl0 &= ~RMI_F01_CTRL0_SLEEP_MODE_MASK;
+		f01->device_control.ctrl0 |= RMI_SLEEP_MODE_NORMAL;
  		return error;
  	}

@@ -498,22 +448,20 @@ static int rmi_f01_resume(struct device *dev)
  {
  	struct rmi_function *fn = to_rmi_function(dev);
  	struct rmi_device *rmi_dev = fn->rmi_dev;
-	struct f01_data *data = fn->data;
+	struct f01_data *f01 = fn->data;
  	int error;

-	if (data->old_nosleep)
-		data->device_control.ctrl0 |= RMI_F01_CRTL0_NOSLEEP_BIT;
+	if (f01->old_nosleep)
+		f01->device_control.ctrl0 |= RMI_F01_CRTL0_NOSLEEP_BIT;

-	data->device_control.ctrl0 &= ~RMI_F01_CTRL0_SLEEP_MODE_MASK;
-	data->device_control.ctrl0 |= RMI_SLEEP_MODE_NORMAL;
+	f01->device_control.ctrl0 &= ~RMI_F01_CTRL0_SLEEP_MODE_MASK;
+	f01->device_control.ctrl0 |= RMI_SLEEP_MODE_NORMAL;

-	error = rmi_write_block(rmi_dev, fn->fd.control_base_addr,
-				&data->device_control.ctrl0,
-				sizeof(data->device_control.ctrl0));
-	if (error < 0) {
+	error = rmi_write(rmi_dev, fn->fd.control_base_addr,
+			  f01->device_control.ctrl0);
+	if (error) {
  		dev_err(&fn->dev,
-			"Failed to restore normal operation. Code: %d.\n",
-			error);
+			"Failed to restore normal operation: %d.\n", error);
  		return error;
  	}

@@ -527,22 +475,21 @@ static int rmi_f01_attention(struct rmi_function *fn,
  			     unsigned long *irq_bits)
  {
  	struct rmi_device *rmi_dev = fn->rmi_dev;
-	struct f01_data *data = fn->data;
-	int retval;
-
-	retval = rmi_read_block(rmi_dev, fn->fd.data_base_addr,
-		&data->device_status, sizeof(data->device_status));
-	if (retval < 0) {
-		dev_err(&fn->dev, "Failed to read device status, code: %d.\n",
-			retval);
-		return retval;
+	int error;
+	u8 device_status;
+
+	error = rmi_read(rmi_dev, fn->fd.data_base_addr, &device_status);
+	if (error) {
+		dev_err(&fn->dev,
+			"Failed to read device status: %d.\n", error);
+		return error;
  	}

-	if (RMI_F01_STATUS_UNCONFIGURED(data->device_status)) {
+	if (RMI_F01_STATUS_UNCONFIGURED(device_status)) {
  		dev_warn(&fn->dev, "Device reset detected.\n");
-		retval = rmi_dev->driver->reset_handler(rmi_dev);
-		if (retval < 0)
-			return retval;
+		error = rmi_dev->driver->reset_handler(rmi_dev);
+		if (error < 0)
+			return error;
  	}
  	return 0;
  }
@@ -559,7 +506,6 @@ static struct rmi_function_handler rmi_f01_handler = {
  	},
  	.func		= 0x01,
  	.probe		= rmi_f01_probe,
-	.remove		= rmi_f01_remove,
  	.config		= rmi_f01_config,
  	.attention	= rmi_f01_attention,
  };

