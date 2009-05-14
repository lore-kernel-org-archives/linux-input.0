From: Mike Rapoport <mike@compulab.co.il>
Subject: Re: [PATCH] input: add synaptics_i2c driver
Date: Thu, 14 May 2009 17:20:27 +0300
Message-ID: <4A0C28AB.9030802@compulab.co.il>
References: <1242225003-8049-1-git-send-email-mike@compulab.co.il> <20090514025030.GB9461@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cathcart.site5.com ([74.54.107.137]:53842 "EHLO
	cathcart.site5.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751859AbZENOUc (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 14 May 2009 10:20:32 -0400
In-Reply-To: <20090514025030.GB9461@dtor-d630.eng.vmware.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: grinberg@compulab.co.il, linux-input@vger.kernel.org, Jean Delvare <khali@linux-fr.org>



Dmitry Torokhov wrote:
> Hi,
> 
> On Wed, May 13, 2009 at 05:30:03PM +0300, Mike Rapoport wrote:
>> From: Igor Grinberg <grinberg@compulab.co.il>
>>
>> This patch adds support for Synaptics i2c touchpad controller found on
>> eXeda machine.
>>
> 
> I am CCing Jean Delvare for review of I2C bits.
> 
> 
>> Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
>> Signed-off-by: Mike Rapoport <mike@compulab.co.il>
>> ---
>>  drivers/input/mouse/Kconfig         |    9 +
>>  drivers/input/mouse/Makefile        |    1 +
>>  drivers/input/mouse/synaptics_i2c.c |  775 +++++++++++++++++++++++++++++++++++
>>  3 files changed, 785 insertions(+), 0 deletions(-)
>>  create mode 100644 drivers/input/mouse/synaptics_i2c.c
>>
>> diff --git a/drivers/input/mouse/Kconfig b/drivers/input/mouse/Kconfig
>> index c66cc3d..89192f5 100644
>> --- a/drivers/input/mouse/Kconfig
>> +++ b/drivers/input/mouse/Kconfig
>> @@ -303,4 +303,13 @@ config MOUSE_MAPLE
>>  	  To compile this driver as a module choose M here: the module will be
>>  	  called maplemouse.
>>  
>> +config MOUSE_SYNAPTICS_I2C
>> +	tristate "Synaptics I2C Touchpad support"
>> +	depends on I2C
>> +	help
>> +	  Say y here if you want to use a Synaptics I2C Touchpad.
> 
> Say Y here ...
> 
> Also please add long long explanantion that the driver will _not_ work
> with Synaptics X driver. There is no chance to enable absolute mode, is
> there?

I tried :)

>> +
>> +	  To compile this driver as a module, choose M here: the
>> +	  module will be called synaptics_i2c.
>> +
>>  endif
>> diff --git a/drivers/input/mouse/Makefile b/drivers/input/mouse/Makefile
>> index 4721894..010f265 100644
>> --- a/drivers/input/mouse/Makefile
>> +++ b/drivers/input/mouse/Makefile
>> @@ -18,6 +18,7 @@ obj-$(CONFIG_MOUSE_PS2)			+= psmouse.o
>>  obj-$(CONFIG_MOUSE_PXA930_TRKBALL)	+= pxa930_trkball.o
>>  obj-$(CONFIG_MOUSE_RISCPC)		+= rpcmouse.o
>>  obj-$(CONFIG_MOUSE_SERIAL)		+= sermouse.o
>> +obj-$(CONFIG_MOUSE_SYNAPTICS_I2C)	+= synaptics_i2c.o
>>  obj-$(CONFIG_MOUSE_VSXXXAA)		+= vsxxxaa.o
>>  
>>  psmouse-objs := psmouse-base.o synaptics.o
>> diff --git a/drivers/input/mouse/synaptics_i2c.c b/drivers/input/mouse/synaptics_i2c.c
>> new file mode 100644
>> index 0000000..de2c363
>> --- /dev/null
>> +++ b/drivers/input/mouse/synaptics_i2c.c
>> @@ -0,0 +1,775 @@
>> +/*
>> + * Synaptics touchpad with I2C interface
>> + *

(...)

>> +/* The Acceleration Factor:
>> + * from 0.5 (1) to 4 (8) in dozes of 0.5
>> + * the transformation is done in order to get 0.5 resolution.
>> + * values above 8 will affect poor performance without proper smoothing.
>> + */
>> +#define ACCEL_DIVIDER 10
>> +#define ACCEL_DOZE 2
>> +static int accel = 4;
>> +module_param(accel, int, 0644);
>> +MODULE_PARM_DESC(accel, "Set Acceleration parameter 1..8. Default = 4");
>> +
>> +/* Control touchpad's No Deceleration option */
>> +static int no_decel = 1;
>> +module_param(no_decel, bool, 0644);
>> +MODULE_PARM_DESC(no_decel, "No Deceleration. Default = 1 (on)");
>> +
> 
> Accelkeration and deceleration handling should be done in userspace. X
> already does this, does it not?

AFAIK Xfbdev does not really takes care of it. I think the acceleration and
deceleration comes from xf86-input drivers. Besides, it's quite possible that
the device will be used without X and we still want to be able to control
acceleration and deceleration.

Although the acceleration and deceleration are module_param, they cannot be
changed in the runtime via /sys/module/synaptics_i2c/parameters.

> 
>> +/* Control touchpad's Reduced Reporting option */
>> +static int reduce_report;
>> +module_param(reduce_report, bool, 0644);
>> +MODULE_PARM_DESC(reduce_report, "Reduced Reporting. Default = 0 (off)");
>> +
>> +/* Control touchpad's No Filter option */
>> +static int no_filter;
>> +module_param(no_filter, bool, 0644);
>> +MODULE_PARM_DESC(no_filter, "No Filter. Default = 0 (off)");
>> +
>> +/* According to Synaptics manual the Attention line is Active Low */
>> +/* and Open Drain, therefore should be connected to pulled up line */
>> +/* and the irq configuration should be set to Falling Edge Trigger */
>> +/* Control IRQ / Polling option */
>> +static int polling_req;
>> +module_param(polling_req, bool, 0444);
>> +MODULE_PARM_DESC(polling_req, "Request Polling. Default = 0 (use irq)");
>> +
>> +/* Control Polling Rate */
>> +static int scan_rate = 80;
>> +module_param(scan_rate, int, 0644);
>> +MODULE_PARM_DESC(scan_rate, "Polling rate in times/sec. Default = 80");
>> +
>> +/* Print Device Info */
>> +static int query;
>> +module_param(query, bool, 0444);
>> +MODULE_PARM_DESC(query, "Print Device Query. Default = 0");
> 
> I don't think its an inetersting attribute, just set mode to 0.

I removed the query parameter and the query function completely. It was useful
for debugging but now it does not add anything except the head ache.

>> +
>> +/* The main device structure */
>> +struct synaptics_i2c {
>> +	struct i2c_client	*client;
>> +	struct input_dev	*input;
>> +	struct task_struct	*thread;

(...)

>> +
>> +/* The Thread */
>> +static int synaptics_i2c_touchd(void *_touch)
>> +{
>> +	struct synaptics_i2c *touch = _touch;
>> +	unsigned long sleep_delay;
>> +	int data = 1;
>> +
>> +	sleep_delay = synaptics_i2c_fix_delay(touch, data);
>> +
>> +	daemonize("synaptics_i2cd");
>> +	while (!kthread_should_stop()) {
>> +		if (touch->thread_stop)
>> +			break;
>> +		synaptics_i2c_check_params(touch);
>> +
>> +		wait_for_completion_interruptible_timeout(&touch->touch_completion, sleep_delay);
>> +
>> +		if (touch->thread_stop)
>> +			break;
>> +
>> +		try_to_freeze();
>> +		if (!touch->suspend_link) {
>> +			do {
>> +				data = synaptics_i2c_get_input(touch);
>> +				sleep_delay = synaptics_i2c_fix_delay(touch, data);
>> +			} while (data);
>> +		}
>> +	}
>> +	complete_and_exit(&touch->thread_completion, 0);
> 
> Why don't you just use workqueue (keventd)?

We tried to use workqueue. Probably we did something entirely wrong, but with
workqueue implementation we've got strange artefacts and random delays on
"pen-down" events...

>> +}
>> +
>> +struct synaptics_i2c *synaptics_i2c_touch_create(struct i2c_client *client)
>> +{
>> +	struct synaptics_i2c *touch;
>> +
>> +	touch = kzalloc(sizeof(struct synaptics_i2c), GFP_KERNEL);
>> +	if (!touch)
>> +		return NULL;
>> +
>> +	memset(touch, 0, sizeof(struct synaptics_i2c));
>> +	touch->client = client;
>> +	touch->no_decel_param = no_decel;
>> +	touch->scan_rate_param = scan_rate;
>> +	set_scan_rate(touch, scan_rate);
>> +	touch->accel_param = accel;
>> +	set_acceleration(touch, accel);
>> +	init_completion(&touch->touch_completion);
>> +	init_completion(&touch->thread_completion);
>> +
>> +	return touch;
>> +}
>> +
>> +static int synaptics_i2c_suspend(struct i2c_client *client, pm_message_t mesg)
>> +{
>> +	struct synaptics_i2c *touch = i2c_get_clientdata(client);
>> +
>> +	/* We don't want timeouts on i2c bus */
>> +	touch->suspend_link = 1;
>> +
>> +	return 0;
>> +}
>> +
>> +static int synaptics_i2c_resume(struct i2c_client *client)
>> +{
>> +	int ret;
>> +	struct synaptics_i2c *touch = i2c_get_clientdata(client);
>> +
>> +	ret = synaptics_i2c_reset_config(client);
>> +	touch->suspend_link = 0;
>> +
>> +	return ret;
>> +}
>> +
>> +static int synaptics_i2c_open(struct input_dev *input)
>> +{
>> +	int ret = 0;
>> +	struct synaptics_i2c *touch = input_get_drvdata(input);
>> +
>> +	if (touch->users_count++)
>> +		return 0;
> 
> No need to count, input core will only call you when needed.

Fixed.

>> +
>> +	ret = synaptics_i2c_reset_config(touch->client);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (!polling_req) {
>> +		ret = request_irq(touch->client->irq, synaptics_i2c_irq,
>> +				  IRQF_DISABLED|IRQ_TYPE_EDGE_FALLING,
>> +				  DRIVER_NAME, touch);
>> +		if (ret) {
>> +			dev_warn(&touch->client->dev,
>> +				  "IRQ request failed: %d\n"
>> +				  "Trying to use polling...\n", ret);
>> +			polling_req = 1;
>> +		}
>> +	}
>> +	touch->thread_stop = 0;
>> +	touch->thread = kthread_run(&synaptics_i2c_touchd,
>> +				     touch, "synaptics_i2cd");
>> +	if (IS_ERR(touch->thread)) {
>> +		ret = PTR_ERR(touch->thread);
>> +		touch->thread = NULL;
>> +	}
>> +	/* FIXME: Should we do something with the device here? */
>> +
>> +	return ret;
>> +}
>> +
>> +static void synaptics_i2c_close(struct input_dev *input)
>> +{
>> +	struct synaptics_i2c *touch = input_get_drvdata(input);
>> +
>> +	if (--touch->users_count)
>> +		return;
> 
> Same here.

Fixed.

>> +
>> +	if (!touch->users_count) {
>> +		touch->thread_stop = 1;
>> +		complete(&touch->touch_completion); /* Awake the thread */
>> +		wait_for_completion(&touch->thread_completion);
>> +		touch->thread = NULL;
>> +
>> +		if (!polling_req)
>> +			free_irq(touch->client->irq, touch);
>> +
>> +	/* FIXME: Should we do something with the device here? */
>> +	}
>> +}
>> +
>> +static void synaptics_i2c_set_input_params(struct synaptics_i2c *touch)
>> +{
>> +	struct input_dev *input = touch->input;
>> +
>> +	input->name = touch->client->name;
>> +	input->phys = touch->client->adapter->name;
>> +	input->id.bustype = BUS_I2C;
>> +	input->id.version = synaptics_i2c_word_get(touch->client,
>> +						   INFO_QUERY_REG0);
>> +	input->dev.parent = &touch->client->dev;
>> +	input->open = synaptics_i2c_open;
>> +	input->close = synaptics_i2c_close;
>> +	input_set_drvdata(input, touch);
>> +
>> +	/* Register the device as mouse */
>> +	set_bit(EV_REL, input->evbit);
>> +	set_bit(REL_X, input->relbit);
>> +	set_bit(REL_Y, input->relbit);
>> +
>> +	/* Register device's buttons and keys */
>> +	set_bit(EV_KEY, input->evbit);
>> +	set_bit(BTN_LEFT, input->keybit);
>> +}
>> +
>> +static const struct i2c_device_id synaptics_i2c_id_table[] = {
>> +	{ DRIVER_NAME, 0 },
>> +	{ },
>> +};
>> +MODULE_DEVICE_TABLE(i2c, synaptics_i2c_id_table);
>> +
>> +static int synaptics_i2c_probe(struct i2c_client *client,
>> +			       const struct i2c_device_id *dev_id)
>> +{
>> +	int ret;
>> +	struct synaptics_i2c *touch = NULL;
>> +
>> +	ret = synaptics_i2c_reset_config(client);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (query) {
>> +		ret = synaptics_i2c_query(client);
>> +		if (ret) {
>> +			dev_err(&client->dev, "Query failed: %d\n", ret);
>> +			return ret;
>> +		}
>> +	}
>> +
>> +	touch = synaptics_i2c_touch_create(client);
>> +	if (!touch)
>> +		goto err_mem;
>> +
>> +	i2c_set_clientdata(client, touch);
>> +
>> +	if (client->irq < 1)
>> +		polling_req = 1;
>> +
>> +	touch->input = input_allocate_device();
>> +	if (!touch->input)
>> +		goto err_mem;
>> +
>> +	synaptics_i2c_set_input_params(touch);
>> +
>> +	if (!polling_req)
>> +		dev_info(&touch->client->dev,
>> +			  "IRQ will be used: %d\n", touch->client->irq);
>> +	else
>> +		dev_info(&touch->client->dev,
>> +			  "Using polling at rate: %d times/sec\n", scan_rate);
>> +
>> +	/* Register the device in input subsystem */
>> +	ret = input_register_device(touch->input);
>> +	if (ret) {
>> +		dev_err(&client->dev,
>> +			 "Input device register failed: %d\n", ret);
>> +		goto err_free;
>> +	}
>> +	return 0;
>> +
>> +err_mem:
>> +	dev_err(&client->dev, "Insufficient memory\n");
>> +	ret = -ENOMEM;
>> +
>> +err_free:
>> +	input_free_device(touch->input);
>> +	i2c_set_clientdata(client, NULL);
>> +	kfree(touch);
>> +
>> +	return ret;
>> +}
>> +
>> +static int __devexit synaptics_i2c_remove(struct i2c_client *client)
>> +{
>> +	struct synaptics_i2c *touch = i2c_get_clientdata(client);
>> +
>> +	input_unregister_device(touch->input);
>> +	i2c_set_clientdata(client, NULL);
>> +	kfree(touch);
>> +
>> +	return 0;
>> +}
>> +
>> +static struct i2c_driver synaptics_i2c_driver = {
>> +	.driver = {
>> +		.name	= DRIVER_NAME,
>> +		.owner	= THIS_MODULE,
>> +	},
>> +
>> +	.probe		= synaptics_i2c_probe,
>> +	.remove		= synaptics_i2c_remove,
> 
> __devexit_p()

Fixed.

>> +
>> +	.suspend	= synaptics_i2c_suspend,
>> +	.resume		= synaptics_i2c_resume,
>> +	.id_table	= synaptics_i2c_id_table,
>> +};
>> +
>> +static int __init synaptics_i2c_init(void)
>> +{
>> +	return i2c_add_driver(&synaptics_i2c_driver);
>> +}
>> +
>> +static void __exit synaptics_i2c_exit(void)
>> +{
>> +	i2c_del_driver(&synaptics_i2c_driver);
>> +}
>> +
>> +module_init(synaptics_i2c_init);
>> +module_exit(synaptics_i2c_exit);
>> +
>> +MODULE_DESCRIPTION("Synaptics I2C touchpad driver");
>> +MODULE_AUTHOR("Mike Rapoport, Igor Grinberg, Compulab");
>> +MODULE_LICENSE("GPL");
> 
> Thanks.
> 

I've addressed all the comments Jean had, and I hopefully haven't broke any I2C
bits this time, so I dare to add Jean's Ack.

This driver supports Synaptics I2C touchpad controller on eXeda
mobile device.

Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
Signed-off-by: Mike Rapoport <mike@compulab.co.il>
Acked-by: Jean Delvare <khali@linux-fr.org>

---
 drivers/input/mouse/Kconfig         |   18 +
 drivers/input/mouse/Makefile        |    1 +
 drivers/input/mouse/synaptics_i2c.c |  687 +++++++++++++++++++++++++++++++++++
 3 files changed, 706 insertions(+), 0 deletions(-)
 create mode 100644 drivers/input/mouse/synaptics_i2c.c

diff --git a/drivers/input/mouse/Kconfig b/drivers/input/mouse/Kconfig
index c66cc3d..8a2c5b1 100644
--- a/drivers/input/mouse/Kconfig
+++ b/drivers/input/mouse/Kconfig
@@ -303,4 +303,22 @@ config MOUSE_MAPLE
 	  To compile this driver as a module choose M here: the module will be
 	  called maplemouse.

+config MOUSE_SYNAPTICS_I2C
+	tristate "Synaptics I2C Touchpad support"
+	depends on I2C
+	help
+	  This driver supports Synaptics I2C touchpad controller on eXeda
+	  mobile device.
+	  The device will not work the synaptics X11 driver because
+	  (i) it  reports only relative coordinates and has no capabilities
+	  to report absolute coordinates
+	  (ii) the eXeda device itself uses Xfbdev as X Server and it does
+	  not allow using xf86-input-* drivers.
+
+	  Say y here if you have eXeda device and want to use a Synaptics
+	  I2C Touchpad.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called synaptics_i2c.
+
 endif
diff --git a/drivers/input/mouse/Makefile b/drivers/input/mouse/Makefile
index 4721894..010f265 100644
--- a/drivers/input/mouse/Makefile
+++ b/drivers/input/mouse/Makefile
@@ -18,6 +18,7 @@ obj-$(CONFIG_MOUSE_PS2)			+= psmouse.o
 obj-$(CONFIG_MOUSE_PXA930_TRKBALL)	+= pxa930_trkball.o
 obj-$(CONFIG_MOUSE_RISCPC)		+= rpcmouse.o
 obj-$(CONFIG_MOUSE_SERIAL)		+= sermouse.o
+obj-$(CONFIG_MOUSE_SYNAPTICS_I2C)	+= synaptics_i2c.o
 obj-$(CONFIG_MOUSE_VSXXXAA)		+= vsxxxaa.o

 psmouse-objs := psmouse-base.o synaptics.o
diff --git a/drivers/input/mouse/synaptics_i2c.c
b/drivers/input/mouse/synaptics_i2c.c
new file mode 100644
index 0000000..4717b34
--- /dev/null
+++ b/drivers/input/mouse/synaptics_i2c.c
@@ -0,0 +1,687 @@
+/*
+ * Synaptics touchpad with I2C interface
+ *
+ * Copyright (C) 2009 Compulab, Ltd.
+ * Mike Rapoport <mike@compulab.co.il>
+ * Igor Grinberg <grinberg@compulab.co.il>
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file COPYING in the main directory of this archive for
+ * more details.
+ */
+
+#include <linux/module.h>
+#include <linux/ctype.h>
+#include <linux/uaccess.h>
+#include <linux/i2c.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+#include <linux/input.h>
+#include <linux/delay.h>
+#include <linux/kthread.h>
+#include <linux/completion.h>
+#include <linux/freezer.h>
+
+#define DRIVER_NAME		"synaptics_i2c"
+/* According to RMI manual, maximum product id is 15 characters */
+#define PRODUCT_ID_LENGTH	15
+#define REGISTER_LENGTH		8
+
+/* According to RMI manual, after soft reset, we should */
+/* wait for 1 ms before the device becomes operational */
+#define SOFT_RESET_DELAY_MS	3
+/* and after hard reset, we should wait for max 500ms */
+#define HARD_RESET_DELAY_MS	500
+
+/* Define Registers by SMBus address */
+#define PAGE_SEL_REG		0xff
+#define DEVICE_STATUS_REG	0x09
+
+/* Define Registers by RMI address */
+#define DEV_CONTROL_REG		0x0000
+#define INTERRUPT_EN_REG	0x0001
+#define ERR_STAT_REG		0x0002
+#define INT_REQ_STAT_REG	0x0003
+#define DEV_COMMAND_REG		0x0004
+
+#define RMI_PROT_VER_REG	0x0200
+#define MANUFACT_ID_REG		0x0201
+#define PHYS_INT_VER_REG	0x0202
+#define PROD_PROPERTY_REG	0x0203
+#define INFO_QUERY_REG0		0x0204
+#define INFO_QUERY_REG1		(INFO_QUERY_REG0 + 1)
+#define INFO_QUERY_REG2		(INFO_QUERY_REG0 + 2)
+#define INFO_QUERY_REG3		(INFO_QUERY_REG0 + 3)
+
+#define PRODUCT_ID_REG0		0x0210
+#define PRODUCT_ID_REG1		(PRODUCT_ID_REG0 + 1)
+#define PRODUCT_ID_REG2		(PRODUCT_ID_REG0 + 2)
+#define PRODUCT_ID_REG3		(PRODUCT_ID_REG0 + 3)
+#define PRODUCT_ID_REG4		(PRODUCT_ID_REG0 + 4)
+#define PRODUCT_ID_REG5		(PRODUCT_ID_REG0 + 5)
+#define PRODUCT_ID_REG6		(PRODUCT_ID_REG0 + 6)
+#define PRODUCT_ID_REG7		(PRODUCT_ID_REG0 + 7)
+#define PRODUCT_ID_REG8		(PRODUCT_ID_REG0 + 8)
+#define PRODUCT_ID_REG9		(PRODUCT_ID_REG0 + 9)
+#define PRODUCT_ID_REG10	(PRODUCT_ID_REG0 + 10)
+#define PRODUCT_ID_REG11	(PRODUCT_ID_REG0 + 11)
+#define PRODUCT_ID_REG12	(PRODUCT_ID_REG0 + 12)
+#define PRODUCT_ID_REG13	(PRODUCT_ID_REG0 + 13)
+#define PRODUCT_ID_REG14	(PRODUCT_ID_REG0 + 14)
+#define PRODUCT_ID_REG15	(PRODUCT_ID_REG0 + 15)
+
+#define DATA_REG0		0x0400
+#define ABS_PRESSURE_REG	0x0401
+#define ABS_MSB_X_REG		0x0402
+#define ABS_LSB_X_REG		(ABS_MSB_X_REG + 1)
+#define ABS_MSB_Y_REG		0x0404
+#define ABS_LSB_Y_REG		(ABS_MSB_Y_REG + 1)
+#define REL_X_REG		0x0406
+#define REL_Y_REG		0x0407
+
+#define DEV_QUERY_REG0		0x1000
+#define DEV_QUERY_REG1		(DEV_QUERY_REG0 + 1)
+#define DEV_QUERY_REG2		(DEV_QUERY_REG0 + 2)
+#define DEV_QUERY_REG3		(DEV_QUERY_REG0 + 3)
+#define DEV_QUERY_REG4		(DEV_QUERY_REG0 + 4)
+#define DEV_QUERY_REG5		(DEV_QUERY_REG0 + 5)
+#define DEV_QUERY_REG6		(DEV_QUERY_REG0 + 6)
+#define DEV_QUERY_REG7		(DEV_QUERY_REG0 + 7)
+#define DEV_QUERY_REG8		(DEV_QUERY_REG0 + 8)
+
+#define GENERAL_2D_CONTROL_REG	0x1041
+#define SENSOR_SENSITIVITY_REG	0x1044
+#define SENS_MAX_POS_MSB_REG	0x1046
+#define SENS_MAX_POS_LSB_REG	(SENS_MAX_POS_UPPER_REG + 1)
+
+/* Define Register bits */
+/* Device Control Register Bits */
+#define REPORT_RATE_1ST_BIT	6
+
+/* Interrupt Enable Register Bits (INTERRUPT_EN_REG) */
+#define F10_ABS_INT_ENA		0
+#define F10_REL_INT_ENA		1
+#define F20_INT_ENA		2
+
+/* Interrupt Request Register Bits (INT_REQ_STAT_REG | DEVICE_STATUS_REG) */
+#define F10_ABS_INT_REQ		0
+#define F10_REL_INT_REQ		1
+#define F20_INT_REQ		2
+/* Device Status Register Bits (DEVICE_STATUS_REG) */
+#define STAT_CONFIGURED		6
+#define STAT_ERROR		7
+
+/* Device Command Register Bits (DEV_COMMAND_REG) */
+#define RESET_COMMAND		0x01
+#define REZERO_COMMAND		0x02
+
+/* Data Register 0 Bits (DATA_REG0) */
+#define GESTURE			3
+
+/* Device Query Registers Bits */
+/* DEV_QUERY_REG3 */
+#define HAS_PALM_DETECT		1
+#define HAS_MULTI_FING		2
+#define HAS_SCROLLER		4
+#define HAS_2D_SCROLL		5
+
+/* General 2D Control Register Bits (GENERAL_2D_CONTROL_REG) */
+#define NO_DECELERATION		1
+#define REDUCE_REPORTING	3
+#define NO_FILTER		5
+
+#define GET_BIT(bit, val)	(((val) >> (bit)) & 0x01)
+
+/* Define Function Masks */
+/* Device Control Register Masks (DEV_CONTROL_REG) */
+#define REPORT_RATE_MSK		0xc0
+#define SLEEP_MODE_MSK		0x07
+
+/* Interrupt Register Mask */
+/* (INT_REQ_STAT_REG | DEVICE_STATUS_REG | INTERRUPT_EN_REG) */
+#define INT_ENA_REQ_MSK		0x07
+#define INT_ENA_ABS_MSK		0x01
+#define INT_ENA_REL_MSK		0x02
+#define INT_ENA_F20_MSK		0x04
+
+/* Device Status Register Masks (DEVICE_STATUS_REG) */
+#define CONFIGURED_MSK		0x40
+#define ERROR_MSK		0x80
+
+/* Data Register 0 Masks */
+#define FINGER_WIDTH_MSK	0xf0
+#define GESTURE_MSK		0x08
+#define SENSOR_STATUS_MSK	0x07
+
+/* MSB Position Register Masks */
+/* ABS_MSB_X_REG | ABS_MSB_Y_REG | SENS_MAX_POS_MSB_REG |  */
+/* DEV_QUERY_REG3 | DEV_QUERY_REG5 */
+#define MSB_POSITION_MSK	0x1f
+
+/* Device Query Registers Masks */
+/* DEV_QUERY_REG2 */
+#define NUM_EXTRA_POS_MSK	0x07
+
+/* When in IRQ mode read the device every THREAD_IRQ_SLEEP_SECS */
+#define THREAD_IRQ_SLEEP_SECS	2
+#define THREAD_IRQ_SLEEP_MSECS	(THREAD_IRQ_SLEEP_SECS * MSEC_PER_SEC)
+
+/* When in Polling mode and no data received for NO_DATA_THRES msecs*/
+/* reduce the polling rate to NO_DATA_SLEEP_MSECS */
+#define NO_DATA_THRES		(MSEC_PER_SEC)
+#define NO_DATA_SLEEP_MSECS	(MSEC_PER_SEC / 4)
+
+/* The Acceleration Factor:
+ * from 0.5 (1) to 4 (8) in dozes of 0.5
+ * the transformation is done in order to get 0.5 resolution.
+ * values above 8 will affect poor performance without proper smoothing.
+ */
+#define ACCEL_DIVIDER 10
+#define ACCEL_DOZE 2
+static int accel = 4;
+module_param(accel, int, 0644);
+MODULE_PARM_DESC(accel, "Set Acceleration parameter 1..8. Default = 4");
+
+/* Control touchpad's No Deceleration option */
+static int no_decel = 1;
+module_param(no_decel, bool, 0644);
+MODULE_PARM_DESC(no_decel, "No Deceleration. Default = 1 (on)");
+
+/* Control touchpad's Reduced Reporting option */
+static int reduce_report;
+module_param(reduce_report, bool, 0644);
+MODULE_PARM_DESC(reduce_report, "Reduced Reporting. Default = 0 (off)");
+
+/* Control touchpad's No Filter option */
+static int no_filter;
+module_param(no_filter, bool, 0644);
+MODULE_PARM_DESC(no_filter, "No Filter. Default = 0 (off)");
+
+/* According to Synaptics manual the Attention line is Active Low */
+/* and Open Drain, therefore should be connected to pulled up line */
+/* and the irq configuration should be set to Falling Edge Trigger */
+/* Control IRQ / Polling option */
+static int polling_req;
+module_param(polling_req, bool, 0444);
+MODULE_PARM_DESC(polling_req, "Request Polling. Default = 0 (use irq)");
+
+/* Control Polling Rate */
+static int scan_rate = 80;
+module_param(scan_rate, int, 0644);
+MODULE_PARM_DESC(scan_rate, "Polling rate in times/sec. Default = 80");
+
+/* The main device structure */
+struct synaptics_i2c {
+	struct i2c_client	*client;
+	struct input_dev	*input;
+	struct mutex		mutex;
+	struct task_struct	*thread;
+	struct completion	touch_completion;
+	struct completion	thread_completion;
+	int			thread_stop;
+	int			suspend_link;
+	int			no_data_count;
+	int			no_decel_param;
+	int			reduce_report_param;
+	int			no_filter_param;
+	int			scan_rate_param;
+	int			accel_param;
+	int			accel;	/* Transformed acceleration */
+	int			scan_ms;
+};
+
+static inline void set_acceleration(struct synaptics_i2c *touch, int accel)
+{
+	int acc = (accel < 1) ? 1 : ((accel > 8) ? 8 : accel);
+	touch->accel = (acc * ACCEL_DIVIDER) / ACCEL_DOZE;
+	touch->accel_param = accel;
+}
+
+static inline void set_scan_rate(struct synaptics_i2c *touch, int scan_rate)
+{
+	touch->scan_ms = MSEC_PER_SEC / scan_rate;
+	touch->scan_rate_param = scan_rate;
+}
+
+static s32 synaptics_i2c_reg_get(struct i2c_client *client, u16 reg)
+{
+	struct synaptics_i2c *touch = i2c_get_clientdata(client);
+	int ret;
+
+	mutex_lock(&touch->mutex);
+
+	ret = i2c_smbus_write_byte_data(client, PAGE_SEL_REG, reg >> 8);
+	if (!ret)
+		ret = i2c_smbus_read_byte_data(client, reg & 0xff);
+
+	mutex_unlock(&touch->mutex);
+
+	return ret;
+}
+
+static s32 synaptics_i2c_reg_set(struct i2c_client *client, u16 reg, u8 val)
+{
+	struct synaptics_i2c *touch = i2c_get_clientdata(client);
+	int ret;
+
+	mutex_lock(&touch->mutex);
+
+	ret = i2c_smbus_write_byte_data(client, PAGE_SEL_REG, reg >> 8);
+	if (!ret)
+		ret = i2c_smbus_write_byte_data(client, reg & 0xff, val);
+
+	mutex_unlock(&touch->mutex);
+
+	return ret;
+}
+
+static s32 synaptics_i2c_word_get(struct i2c_client *client, u16 reg)
+{
+	struct synaptics_i2c *touch = i2c_get_clientdata(client);
+	int ret;
+
+	mutex_lock(&touch->mutex);
+
+	ret = i2c_smbus_write_byte_data(client, PAGE_SEL_REG, reg >> 8);
+	if (!ret)
+		ret = i2c_smbus_read_word_data(client, reg & 0xff);
+
+	mutex_unlock(&touch->mutex);
+
+	return ret;
+}
+
+static int synaptics_i2c_config(struct i2c_client *client)
+{
+	int ret, control;
+	u8 int_en;
+
+	/* set Report Rate to 40 and Sleep to normal */
+	ret = synaptics_i2c_reg_set(client, DEV_CONTROL_REG, 0x41);
+	if (ret)
+		return ret;
+
+	/* set Interrupt Disable to Func20 / Enable to Func10) */
+	int_en = (polling_req) ? 0 : INT_ENA_ABS_MSK | INT_ENA_REL_MSK;
+	ret = synaptics_i2c_reg_set(client, INTERRUPT_EN_REG, int_en);
+	if (ret)
+		return ret;
+
+	control = synaptics_i2c_reg_get(client, GENERAL_2D_CONTROL_REG);
+	/* No Deceleration */
+	control |= (no_decel) ? 1 << NO_DECELERATION : 0;
+	/* Reduced Reporting */
+	control |= (reduce_report) ? 1 << REDUCE_REPORTING : 0;
+	/* No Filter */
+	control |= (no_filter) ? 1 << NO_FILTER : 0;
+	ret = synaptics_i2c_reg_set(client, GENERAL_2D_CONTROL_REG, control);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int synaptics_i2c_reset_config(struct i2c_client *client)
+{
+	int ret;
+	/* Reset the Touchpad */
+	ret = synaptics_i2c_reg_set(client, DEV_COMMAND_REG, RESET_COMMAND);
+	if (ret) {
+		dev_err(&client->dev, "Unable to reset device\n");
+	} else {
+		mdelay(SOFT_RESET_DELAY_MS);
+		ret = synaptics_i2c_config(client);
+		if (ret)
+			dev_err(&client->dev, "Unable to config device\n");
+	}
+
+	return ret;
+}
+
+static int synaptics_i2c_check_error(struct i2c_client *client)
+{
+	int status, ret = 0;
+
+	status = i2c_smbus_read_byte_data(client, DEVICE_STATUS_REG) &
+		(CONFIGURED_MSK | ERROR_MSK);
+	if (status != CONFIGURED_MSK)
+		ret = synaptics_i2c_reset_config(client);
+
+	return ret;
+}
+
+static int synaptics_i2c_get_input(struct synaptics_i2c *touch)
+{
+	struct input_dev *input = touch->input;
+	int xy_delta, gesture;
+	s8 x_delta, y_delta;
+
+	/* Deal with spontanious resets and errors */
+	if (synaptics_i2c_check_error(touch->client))
+		return 0;
+
+	/* Get Gesture Bit */
+	gesture = GET_BIT(GESTURE,
+			  synaptics_i2c_reg_get(touch->client, DATA_REG0));
+
+	/* Get Relative axes. According to RMI Manual, we have to get */
+	/* them in one shot, so we get 2 bytes starting from REL_X_REG. */
+	xy_delta = synaptics_i2c_word_get(touch->client, REL_X_REG) & 0xffff;
+
+	/* Separate X from Y */
+	x_delta = xy_delta & 0xff;
+	y_delta = (xy_delta >> REGISTER_LENGTH) & 0xff;
+
+	/* Report the button event */
+	if (gesture)
+		input_report_key(input, BTN_LEFT, 1);
+	else
+		input_report_key(input, BTN_LEFT, 0);
+
+	/* Report the deltas multiplied by acceleration factor */
+	input_report_rel(input, REL_X,
+			 (touch->accel * (s16) x_delta) / ACCEL_DIVIDER);
+	input_report_rel(input, REL_Y,
+			 -((touch->accel * (s16) y_delta) / ACCEL_DIVIDER));
+	input_sync(input);
+
+	return (xy_delta || gesture) ? 1 : 0;
+}
+
+static irqreturn_t synaptics_i2c_irq(int irq, void *dev_id)
+{
+	struct synaptics_i2c *touch = dev_id;
+
+	complete(&touch->touch_completion);
+
+	return IRQ_HANDLED;
+}
+
+static void synaptics_i2c_check_params(struct synaptics_i2c *touch)
+{
+	int reset = 0;
+	if (accel != touch->accel_param)
+		set_acceleration(touch, accel);
+
+	if (scan_rate != touch->scan_rate_param)
+		set_scan_rate(touch, scan_rate);
+
+	if (no_decel != touch->no_decel_param) {
+		touch->no_decel_param = no_decel;
+		reset = 1;
+	}
+	if (no_filter != touch->no_filter_param) {
+		touch->no_filter_param = no_filter;
+		reset = 1;
+	}
+	if (reduce_report != touch->reduce_report_param) {
+		touch->reduce_report_param = reduce_report;
+		reset = 1;
+	}
+	if (reset)
+		synaptics_i2c_reset_config(touch->client);
+}
+
+/* Control the Thread sleep time */
+unsigned long synaptics_i2c_fix_delay(struct synaptics_i2c *touch, int data)
+{
+	int delay, nodata_count_thres;
+
+	if (polling_req) {
+		delay = touch->scan_ms;
+		if (data) {
+			touch->no_data_count = 0;
+		} else {
+			nodata_count_thres = NO_DATA_THRES / touch->scan_ms;
+			if (touch->no_data_count < nodata_count_thres)
+				touch->no_data_count++;
+			else
+				delay = NO_DATA_SLEEP_MSECS;
+		}
+	} else
+		delay = THREAD_IRQ_SLEEP_MSECS;
+
+	return msecs_to_jiffies(delay);
+}
+
+/* The Thread */
+static int synaptics_i2c_touchd(void *_touch)
+{
+	struct synaptics_i2c *touch = _touch;
+	unsigned long sleep_delay;
+	int data = 1;
+
+	sleep_delay = synaptics_i2c_fix_delay(touch, data);
+
+	daemonize("synaptics_i2cd");
+	while (!kthread_should_stop()) {
+		if (touch->thread_stop)
+			break;
+		synaptics_i2c_check_params(touch);
+
+		wait_for_completion_interruptible_timeout(&touch->touch_completion, sleep_delay);
+
+		if (touch->thread_stop)
+			break;
+
+		try_to_freeze();
+		if (!touch->suspend_link) {
+			do {
+				data = synaptics_i2c_get_input(touch);
+				sleep_delay = synaptics_i2c_fix_delay(touch,
+								      data);
+			} while (data);
+		}
+	}
+	complete_and_exit(&touch->thread_completion, 0);
+}
+
+struct synaptics_i2c *synaptics_i2c_touch_create(struct i2c_client *client)
+{
+	struct synaptics_i2c *touch;
+
+	touch = kzalloc(sizeof(struct synaptics_i2c), GFP_KERNEL);
+	if (!touch)
+		return NULL;
+
+	touch->client = client;
+	touch->no_decel_param = no_decel;
+	touch->scan_rate_param = scan_rate;
+	set_scan_rate(touch, scan_rate);
+	touch->accel_param = accel;
+	set_acceleration(touch, accel);
+	init_completion(&touch->touch_completion);
+	init_completion(&touch->thread_completion);
+	mutex_init(&touch->mutex);
+
+	return touch;
+}
+
+static int synaptics_i2c_suspend(struct i2c_client *client, pm_message_t mesg)
+{
+	struct synaptics_i2c *touch = i2c_get_clientdata(client);
+
+	/* We don't want timeouts on i2c bus */
+	touch->suspend_link = 1;
+
+	return 0;
+}
+
+static int synaptics_i2c_resume(struct i2c_client *client)
+{
+	int ret;
+	struct synaptics_i2c *touch = i2c_get_clientdata(client);
+
+	ret = synaptics_i2c_reset_config(client);
+	touch->suspend_link = 0;
+
+	return ret;
+}
+
+static int synaptics_i2c_open(struct input_dev *input)
+{
+	int ret = 0;
+	struct synaptics_i2c *touch = input_get_drvdata(input);
+
+	ret = synaptics_i2c_reset_config(touch->client);
+	if (ret)
+		return ret;
+
+	if (!polling_req) {
+		ret = request_irq(touch->client->irq, synaptics_i2c_irq,
+				  IRQF_DISABLED|IRQ_TYPE_EDGE_FALLING,
+				  DRIVER_NAME, touch);
+		if (ret) {
+			dev_warn(&touch->client->dev,
+				  "IRQ request failed: %d\n"
+				  "Trying to use polling...\n", ret);
+			polling_req = 1;
+		}
+	}
+
+	touch->thread_stop = 0;
+	touch->thread = kthread_run(&synaptics_i2c_touchd,
+				     touch, "synaptics_i2cd");
+	if (IS_ERR(touch->thread)) {
+		ret = PTR_ERR(touch->thread);
+		touch->thread = NULL;
+	}
+	/* FIXME: Should we do something with the device here? */
+
+	return ret;
+}
+
+static void synaptics_i2c_close(struct input_dev *input)
+{
+	struct synaptics_i2c *touch = input_get_drvdata(input);
+
+	touch->thread_stop = 1;
+	complete(&touch->touch_completion); /* Awake the thread */
+	wait_for_completion(&touch->thread_completion);
+	touch->thread = NULL;
+
+	if (!polling_req)
+		free_irq(touch->client->irq, touch);
+}
+
+static void synaptics_i2c_set_input_params(struct synaptics_i2c *touch)
+{
+	struct input_dev *input = touch->input;
+
+	input->name = touch->client->name;
+	input->phys = touch->client->adapter->name;
+	input->id.bustype = BUS_I2C;
+	input->id.version = synaptics_i2c_word_get(touch->client,
+						   INFO_QUERY_REG0);
+	input->dev.parent = &touch->client->dev;
+	input->open = synaptics_i2c_open;
+	input->close = synaptics_i2c_close;
+	input_set_drvdata(input, touch);
+
+	/* Register the device as mouse */
+	set_bit(EV_REL, input->evbit);
+	set_bit(REL_X, input->relbit);
+	set_bit(REL_Y, input->relbit);
+
+	/* Register device's buttons and keys */
+	set_bit(EV_KEY, input->evbit);
+	set_bit(BTN_LEFT, input->keybit);
+}
+
+static const struct i2c_device_id synaptics_i2c_id_table[] = {
+	{ "synaptics_i2c", 0 },
+	{ },
+};
+MODULE_DEVICE_TABLE(i2c, synaptics_i2c_id_table);
+
+static int __devinit synaptics_i2c_probe(struct i2c_client *client,
+			       const struct i2c_device_id *dev_id)
+{
+	int ret;
+	struct synaptics_i2c *touch;
+
+	touch = synaptics_i2c_touch_create(client);
+	if (!touch)
+		return -ENOMEM;
+
+	i2c_set_clientdata(client, touch);
+
+	ret = synaptics_i2c_reset_config(client);
+	if (ret)
+		goto err_mem_free;
+
+	if (client->irq < 1)
+		polling_req = 1;
+
+	touch->input = input_allocate_device();
+	if (!touch->input)
+		goto err_mem_free;
+
+	synaptics_i2c_set_input_params(touch);
+
+	if (!polling_req)
+		dev_info(&touch->client->dev,
+			  "IRQ will be used: %d\n", touch->client->irq);
+	else
+		dev_info(&touch->client->dev,
+			  "Using polling at rate: %d times/sec\n", scan_rate);
+
+	/* Register the device in input subsystem */
+	ret = input_register_device(touch->input);
+	if (ret) {
+		dev_err(&client->dev,
+			 "Input device register failed: %d\n", ret);
+		goto err_input_free;
+	}
+	return 0;
+
+err_input_free:
+	input_free_device(touch->input);
+err_mem_free:
+	i2c_set_clientdata(client, NULL);
+	kfree(touch);
+
+	return ret;
+}
+
+static int __devexit synaptics_i2c_remove(struct i2c_client *client)
+{
+	struct synaptics_i2c *touch = i2c_get_clientdata(client);
+
+	input_unregister_device(touch->input);
+	i2c_set_clientdata(client, NULL);
+	kfree(touch);
+
+	return 0;
+}
+
+static struct i2c_driver synaptics_i2c_driver = {
+	.driver = {
+		.name	= DRIVER_NAME,
+		.owner	= THIS_MODULE,
+	},
+
+	.probe		= synaptics_i2c_probe,
+	.remove		= __devexit_p(synaptics_i2c_remove),
+
+	.suspend	= synaptics_i2c_suspend,
+	.resume		= synaptics_i2c_resume,
+	.id_table	= synaptics_i2c_id_table,
+};
+
+static int __init synaptics_i2c_init(void)
+{
+	return i2c_add_driver(&synaptics_i2c_driver);
+}
+
+static void __exit synaptics_i2c_exit(void)
+{
+	i2c_del_driver(&synaptics_i2c_driver);
+}
+
+module_init(synaptics_i2c_init);
+module_exit(synaptics_i2c_exit);
+
+MODULE_DESCRIPTION("Synaptics I2C touchpad driver");
+MODULE_AUTHOR("Mike Rapoport, Igor Grinberg, Compulab");
+MODULE_LICENSE("GPL");
-- 
1.6.0.6



-- 
Sincerely yours,
Mike.


