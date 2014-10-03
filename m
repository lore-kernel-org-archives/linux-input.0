From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] Input: add i2c/smbus driver for elan touchpad
Date: Fri, 3 Oct 2014 14:03:57 -0700
Message-ID: <20141003210357.GB4987@dtor-ws>
References: <1389064083-11018-1-git-send-email-dusonlin@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:33963 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750750AbaJCVED (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 3 Oct 2014 17:04:03 -0400
Content-Disposition: inline
In-Reply-To: <1389064083-11018-1-git-send-email-dusonlin@emc.com.tw>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Duson Lin <dusonlin@emc.com.tw>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, bleung@chromium.org, agnescheng@chromium.org, phoenix@emc.com.tw, jeff.chuang@emc.com.tw

Hi Duson,

On Tue, Jan 07, 2014 at 11:08:03AM +0800, Duson Lin wrote:
> This driver adds support for elan i2c/smbus touchpad found on some
> laptops PC
>

I was looking at your original patch together with varous other patchs
for the device in ChromeOS trees and I ended up with the following
version. Please take a look and shout if you see something wrong.

The SMbus portion is untested as I do not have hardware; I2C does work
on actual hardware.

Thanks.

--
Dmitry

Input: driver for Elan I2C/SMbus touchpad

=46rom: Duson Lin <dusonlin@emc.com.tw>

This driver supports Elan I2C/SMbous touchpads found in some laptops an=
d
also in many Chromebooks.

Signed-off-by: Duson Lin <dusonlin@emc.com.tw>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 .../devicetree/bindings/input/elan_i2c.txt         |   34 +
 .../devicetree/bindings/vendor-prefixes.txt        |    1=20
 drivers/input/mouse/Kconfig                        |   30 +
 drivers/input/mouse/Makefile                       |    5=20
 drivers/input/mouse/elan_i2c.h                     |   86 ++
 drivers/input/mouse/elan_i2c_core.c                | 1129 ++++++++++++=
++++++++
 drivers/input/mouse/elan_i2c_i2c.c                 |  612 +++++++++++
 drivers/input/mouse/elan_i2c_smbus.c               |  514 +++++++++
 8 files changed, 2411 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/elan_i2c.tx=
t
 create mode 100644 drivers/input/mouse/elan_i2c.h
 create mode 100644 drivers/input/mouse/elan_i2c_core.c
 create mode 100644 drivers/input/mouse/elan_i2c_i2c.c
 create mode 100644 drivers/input/mouse/elan_i2c_smbus.c

diff --git a/Documentation/devicetree/bindings/input/elan_i2c.txt b/Doc=
umentation/devicetree/bindings/input/elan_i2c.txt
new file mode 100644
index 0000000..0a6ee7d
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/elan_i2c.txt
@@ -0,0 +1,34 @@
+Elantech I2C Touchpad
+
+Required properties:
+- compatible: must be "elan,i2c_touchpad".
+- reg: I2C address of the chip.
+- interrupt-parent: a phandle for the gpio controller (see interrupt
+  binding[0]).
+- interrupts: (gpio) interrupt to which the chip is connected (see int=
errupt
+  binding[0]).
+
+Optional properties:
+- wakeup-source: touchpad should be configured as a wakeup source.
+- pinctrl-names: should be "default" (see pinctrl binding [1]).
+- pinctrl-0: a phandle pointing to the pin settings for the device (se=
e
+  pinctrl binding [1]).
+- vcc-supply: a phandle for the regulator supplying 3.3V power.
+
+[0]: Documentation/devicetree/bindings/interrupt-controller/interrupts=
=2Etxt
+[1]: Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
+
+Example:
+	&i2c1 {
+		/* ... */
+
+		touchpad@15 {
+			compatible =3D "elan,i2c_touchpad";
+			reg =3D <0x15>;
+			interrupt-parent =3D <&gpio4>;
+			interrupts =3D <0x0 IRQ_TYPE_EDGE_FALLING>;
+			wakeup-source;
+		};
+
+		/* ... */
+	};
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Do=
cumentation/devicetree/bindings/vendor-prefixes.txt
index ac7269f..e6469ec 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -42,6 +42,7 @@ dlink	D-Link Corporation
 dmo	Data Modul AG
 ebv	EBV Elektronik
 edt	Emerging Display Technologies
+elan	Elan Microelectronic Corp.
 emmicro	EM Microelectronic
 epcos	EPCOS AG
 epfl	Ecole Polytechnique F=C3=A9d=C3=A9rale de Lausanne
diff --git a/drivers/input/mouse/Kconfig b/drivers/input/mouse/Kconfig
index 366fc7a..d8b46b0 100644
--- a/drivers/input/mouse/Kconfig
+++ b/drivers/input/mouse/Kconfig
@@ -215,6 +215,36 @@ config MOUSE_CYAPA
 	  To compile this driver as a module, choose M here: the module will =
be
 	  called cyapa.
=20
+config MOUSE_ELAN_I2C
+	tristate "ELAN I2C Touchpad support"
+	depends on I2C
+	help
+	  This driver adds support for Elan I2C/SMbus Trackpads.
+
+	  Say Y here if you have a ELAN I2C/SMbus Touchpad.
+
+	  To compile this driver as a module, choose M here: the module will =
be
+	  called elan_i2c.
+
+config MOUSE_ELAN_I2C_I2C
+	bool "Enable I2C support"
+	depends on MOUSE_ELAN_I2C
+	default y
+	help
+	   Say Y here if Elan Touchpad in your system is connected to
+	   a standard I2C controller.
+
+	   If unsure, say Y.
+
+config MOUSE_ELAN_I2C_SMBUS
+	bool "Enable SMbus support"
+	depends on MOUSE_ELAN_I2C
+	help
+	   Say Y here if Elan Touchpad in your system is connected to
+	   a SMbus adapter.
+
+	   If unsure, say Y.
+
 config MOUSE_INPORT
 	tristate "InPort/MS/ATIXL busmouse"
 	depends on ISA
diff --git a/drivers/input/mouse/Makefile b/drivers/input/mouse/Makefil=
e
index dda507f..560003d 100644
--- a/drivers/input/mouse/Makefile
+++ b/drivers/input/mouse/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_MOUSE_APPLETOUCH)		+=3D appletouch.o
 obj-$(CONFIG_MOUSE_ATARI)		+=3D atarimouse.o
 obj-$(CONFIG_MOUSE_BCM5974)		+=3D bcm5974.o
 obj-$(CONFIG_MOUSE_CYAPA)		+=3D cyapa.o
+obj-$(CONFIG_MOUSE_ELAN_I2C)		+=3D elan_i2c.o
 obj-$(CONFIG_MOUSE_GPIO)		+=3D gpio_mouse.o
 obj-$(CONFIG_MOUSE_INPORT)		+=3D inport.o
 obj-$(CONFIG_MOUSE_LOGIBM)		+=3D logibm.o
@@ -34,3 +35,7 @@ psmouse-$(CONFIG_MOUSE_PS2_SENTELIC)	+=3D sentelic.o
 psmouse-$(CONFIG_MOUSE_PS2_TRACKPOINT)	+=3D trackpoint.o
 psmouse-$(CONFIG_MOUSE_PS2_TOUCHKIT)	+=3D touchkit_ps2.o
 psmouse-$(CONFIG_MOUSE_PS2_CYPRESS)	+=3D cypress_ps2.o
+
+elan_i2c-objs :=3D elan_i2c_core.o
+elan_i2c-$(CONFIG_MOUSE_ELAN_I2C_I2C)	+=3D elan_i2c_i2c.o
+elan_i2c-$(CONFIG_MOUSE_ELAN_I2C_SMBUS)	+=3D elan_i2c_smbus.o
diff --git a/drivers/input/mouse/elan_i2c.h b/drivers/input/mouse/elan_=
i2c.h
new file mode 100644
index 0000000..2e83862
--- /dev/null
+++ b/drivers/input/mouse/elan_i2c.h
@@ -0,0 +1,86 @@
+/*
+ * Elan I2C/SMBus Touchpad driver
+ *
+ * Copyright (c) 2013 ELAN Microelectronics Corp.
+ *
+ * Author: =E6=9E=97=E6=94=BF=E7=B6=AD (Duson Lin) <dusonlin@emc.com.t=
w>
+ * Version: 1.5.5
+ *
+ * Based on cyapa driver:
+ * copyright (c) 2011-2012 Cypress Semiconductor, Inc.
+ * copyright (c) 2011-2012 Google, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modif=
y it
+ * under the terms of the GNU General Public License version 2 as publ=
ished
+ * by the Free Software Foundation.
+ *
+ * Trademarks are the property of their respective owners.
+ */
+
+#ifndef _ELAN_I2C_H
+#define _ELAN_i2C_H
+
+#include <linux/types.h>
+
+#define ETP_ENABLE_ABS		0x0001
+#define ETP_ENABLE_CALIBRATE	0x0002
+#define ETP_DISABLE_CALIBRATE	0x0000
+#define ETP_DISABLE_POWER	0x0001
+
+/* IAP Firmware handling */
+#define ETP_FW_NAME		"elan_i2c.bin"
+#define ETP_IAP_START_ADDR	0x0083
+#define ETP_FW_IAP_PAGE_ERR	(1 << 5)
+#define ETP_FW_IAP_INTF_ERR	(1 << 4)
+#define ETP_FW_PAGE_SIZE	64
+#define ETP_FW_PAGE_COUNT	768
+#define ETP_FW_SIZE		(ETP_FW_PAGE_SIZE * ETP_FW_PAGE_COUNT)
+
+struct i2c_client;
+struct completion;
+
+enum tp_mode {
+	IAP_MODE =3D 1,
+	MAIN_MODE
+};
+
+struct elan_transport_ops {
+	int (*initialize)(struct i2c_client *client);
+	int (*sleep_control)(struct i2c_client *, bool sleep);
+	int (*power_control)(struct i2c_client *, bool enable);
+	int (*set_mode)(struct i2c_client *client, u8 mode);
+
+	int (*calibrate)(struct i2c_client *client);
+	int (*calibrate_result)(struct i2c_client *client, u8 *val);
+
+	int (*get_baseline_data)(struct i2c_client *client,
+				 bool max_baseliune, u8 *value);
+
+	int (*get_version)(struct i2c_client *client, bool iap, u8 *version);
+	int (*get_sm_version)(struct i2c_client *client, u8 *version);
+	int (*get_checksum)(struct i2c_client *client, bool iap, u16 *csum);
+	int (*get_product_id)(struct i2c_client *client, u8 *id);
+
+	int (*get_max)(struct i2c_client *client,
+		       unsigned int *max_x, unsigned int *max_y);
+	int (*get_resolution)(struct i2c_client *client,
+			      u8 *hw_res_x, u8 *hw_res_y);
+	int (*get_num_traces)(struct i2c_client *client,
+			      unsigned int *x_tracenum,
+			      unsigned int *y_tracenum);
+
+	int (*iap_get_mode)(struct i2c_client *client, enum tp_mode *mode);
+	int (*iap_reset)(struct i2c_client *client);
+
+	int (*prepare_fw_update)(struct i2c_client *client);
+	int (*write_fw_block)(struct i2c_client *client,
+			      const u8 *page, u16 checksum, int idx);
+	int (*finish_fw_update)(struct i2c_client *client,
+				struct completion *reset_done);
+
+	int (*get_report)(struct i2c_client *client, u8 *report);
+};
+
+extern const struct elan_transport_ops elan_smbus_ops, elan_i2c_ops;
+
+#endif /* _ELAN_I2C_H */
diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/=
elan_i2c_core.c
new file mode 100644
index 0000000..f1e5e30
--- /dev/null
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -0,0 +1,1129 @@
+/*
+ * Elan I2C/SMBus Touchpad driver
+ *
+ * Copyright (c) 2013 ELAN Microelectronics Corp.
+ *
+ * Author: =E6=9E=97=E6=94=BF=E7=B6=AD (Duson Lin) <dusonlin@emc.com.t=
w>
+ * Version: 1.5.5
+ *
+ * Based on cyapa driver:
+ * copyright (c) 2011-2012 Cypress Semiconductor, Inc.
+ * copyright (c) 2011-2012 Google, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modif=
y it
+ * under the terms of the GNU General Public License version 2 as publ=
ished
+ * by the Free Software Foundation.
+ *
+ * Trademarks are the property of their respective owners.
+ */
+
+#include <linux/acpi.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/firmware.h>
+#include <linux/i2c.h>
+#include <linux/init.h>
+#include <linux/input/mt.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/input.h>
+#include <linux/uaccess.h>
+#include <linux/jiffies.h>
+#include <linux/completion.h>
+#include <linux/of.h>
+#include <linux/regulator/consumer.h>
+#include <asm/unaligned.h>
+
+#include "elan_i2c.h"
+
+#define DRIVER_NAME		"elan_i2c"
+#define ELAN_DRIVER_VERSION	"1.5.5"
+#define ETP_PRESSURE_OFFSET	25
+#define ETP_MAX_PRESSURE	255
+#define ETP_FWIDTH_REDUCE	90
+#define ETP_FINGER_WIDTH	15
+#define ETP_RETRY_COUNT		3
+
+#define ETP_MAX_FINGERS		5
+#define ETP_FINGER_DATA_LEN	5
+#define ETP_REPORT_ID		0x5D
+#define ETP_REPORT_ID_OFFSET	2
+#define ETP_TOUCH_INFO_OFFSET	3
+#define ETP_FINGER_DATA_OFFSET	4
+#define ETP_MAX_REPORT_LEN	34
+
+/* The main device structure */
+struct elan_tp_data {
+	struct i2c_client	*client;
+	struct input_dev	*input;
+	struct regulator	*vcc;
+
+	const struct elan_transport_ops *ops;
+
+	/* for fw update */
+	struct completion	fw_completion;
+	bool			in_fw_update;
+
+	struct mutex		sysfs_mutex;
+
+	unsigned int		max_x;
+	unsigned int		max_y;
+	unsigned int		width_x;
+	unsigned int		width_y;
+	unsigned int		x_res;
+	unsigned int		y_res;
+
+	u8			product_id;
+	u8			fw_version;
+	u8			sm_version;
+	u8			iap_version;
+	u16			fw_checksum;
+
+	u8			mode;
+
+	bool			irq_wake;
+
+	u8			min_baseline;
+	u8			max_baseline;
+	bool			baseline_ready;
+};
+
+static int elan_enable_power(struct elan_tp_data *data)
+{
+	int repeat =3D ETP_RETRY_COUNT;
+	int error;
+
+	error =3D regulator_enable(data->vcc);
+	if (error) {
+		dev_err(&data->client->dev,
+			"Failed to enable regulator: %d\n", error);
+		return error;
+	}
+
+	do {
+		error =3D data->ops->power_control(data->client, true);
+		if (error >=3D 0)
+			return 0;
+
+		msleep(30);
+	} while (--repeat > 0);
+
+	return error;
+}
+
+static int elan_disable_power(struct elan_tp_data *data)
+{
+	int repeat =3D ETP_RETRY_COUNT;
+	int error;
+
+	do {
+		error =3D data->ops->power_control(data->client, false);
+		if (!error) {
+			error =3D regulator_disable(data->vcc);
+			if (error) {
+				dev_err(&data->client->dev,
+					"Failed to disable regulator: %d\n",
+					error);
+				/* Attempt to power the chip back up */
+				data->ops->power_control(data->client, true);
+				break;
+			}
+
+			return 0;
+		}
+
+		msleep(30);
+	} while (--repeat > 0);
+
+	return error;
+}
+
+static int elan_sleep(struct elan_tp_data *data)
+{
+	int repeat =3D ETP_RETRY_COUNT;
+	int error;
+
+	do {
+		error =3D data->ops->sleep_control(data->client, true);
+		if (!error)
+			return 0;
+
+		msleep(30);
+	} while (--repeat > 0);
+
+	return error;
+}
+
+static int __elan_initialize(struct elan_tp_data *data)
+{
+	struct i2c_client *client =3D data->client;
+	int error;
+
+	error =3D data->ops->initialize(client);
+	if (error) {
+		dev_err(&client->dev, "device initialize failed: %d\n", error);
+		return error;
+	}
+
+	data->mode |=3D ETP_ENABLE_ABS;
+	error =3D data->ops->set_mode(client, data->mode);
+	if (error) {
+		dev_err(&client->dev,
+			"failed to switch to absolute mode: %d\n", error);
+		return error;
+	}
+
+	error =3D data->ops->sleep_control(client, false);
+	if (error) {
+		dev_err(&client->dev,
+			"failed to wake device up: %d\n", error);
+		return error;
+	}
+
+	return 0;
+}
+
+static int elan_initialize(struct elan_tp_data *data)
+{
+	int repeat =3D ETP_RETRY_COUNT;
+	int error;
+
+	do {
+		error =3D __elan_initialize(data);
+		if (!error)
+			return 0;
+
+		repeat--;
+		msleep(30);
+	} while (--repeat > 0);
+
+	return error;
+}
+
+static int elan_query_device_info(struct elan_tp_data *data)
+{
+	int error;
+
+	error =3D data->ops->get_product_id(data->client, &data->product_id);
+	if (error)
+		return error;
+
+	error =3D data->ops->get_version(data->client, false, &data->fw_versi=
on);
+	if (error)
+		return error;
+
+	error =3D data->ops->get_checksum(data->client, false,
+					&data->fw_checksum);
+	if (error)
+		return error;
+
+	error =3D data->ops->get_sm_version(data->client, &data->sm_version);
+	if (error)
+		return error;
+
+	error =3D data->ops->get_version(data->client, true, &data->iap_versi=
on);
+	if (error)
+		return error;
+
+	return 0;
+}
+
+static unsigned int elan_convert_resolution(u8 val)
+{
+	/*
+	 * (value from firmware) * 10 + 790 =3D dpi
+	 *
+	 * We also have to convert dpi to dots/mm (*10/254 to avoid floating
+	 * point).
+	 */
+
+	return ((int)(char)val * 10 + 790) * 10 / 254;
+}
+
+static int elan_query_device_parameters(struct elan_tp_data *data)
+{
+	unsigned int x_traces, y_traces;
+	u8 hw_x_res, hw_y_res;
+	int error;
+
+	error =3D data->ops->get_max(data->client, &data->max_x, &data->max_y=
);
+	if (error)
+		return error;
+
+	error =3D data->ops->get_num_traces(data->client, &x_traces, &y_trace=
s);
+	if (error)
+		return error;
+
+	data->width_x =3D data->max_x / x_traces;
+	data->width_y =3D data->max_y / y_traces;
+
+	error =3D data->ops->get_resolution(data->client, &hw_x_res, &hw_y_re=
s);
+	if (error)
+		return error;
+
+	data->x_res =3D elan_convert_resolution(hw_x_res);
+	data->y_res =3D elan_convert_resolution(hw_y_res);
+
+	return 0;
+}
+
+/*
+ **********************************************************
+ * IAP firmware updater related routines
+ **********************************************************
+ */
+static int elan_write_fw_block(struct elan_tp_data *data,
+			       const u8 *page, u16 checksum, int idx)
+{
+	int retry =3D ETP_RETRY_COUNT;
+	int error;
+
+	do {
+		error =3D data->ops->write_fw_block(data->client,
+						  page, checksum, idx);
+		if (!error)
+			return 0;
+
+		dev_dbg(&data->client->dev,
+			"IAP retrying page %d (error: %d)\n", idx, error);
+	} while (--retry > 0);
+
+	return error;
+}
+
+static int __elan_update_firmware(struct elan_tp_data *data,
+				  const struct firmware *fw)
+{
+	struct i2c_client *client =3D data->client;
+	struct device *dev =3D &client->dev;
+	int i, j;
+	int error;
+	u16 iap_start_addr;
+	u16 boot_page_count;
+	u16 sw_checksum =3D 0, fw_checksum =3D 0;
+
+	error =3D data->ops->prepare_fw_update(client);
+	if (error)
+		return error;
+
+	iap_start_addr =3D get_unaligned_le16(&fw->data[ETP_IAP_START_ADDR * =
2]);
+
+	boot_page_count =3D (iap_start_addr * 2) / ETP_FW_PAGE_SIZE;
+	for (i =3D boot_page_count; i < ETP_FW_PAGE_COUNT; i++) {
+		u16 checksum =3D 0;
+		const u8 *page =3D &fw->data[i * ETP_FW_PAGE_SIZE];
+
+		for (j =3D 0; j < ETP_FW_PAGE_SIZE; j +=3D 2)
+			checksum +=3D ((page[j + 1] << 8) | page[j]);
+
+		error =3D elan_write_fw_block(data, page, checksum, i);
+		if (error) {
+			dev_err(dev, "write page %d fail: %d\n", i, error);
+			return error;
+		}
+
+		sw_checksum +=3D checksum;
+	}
+
+	/* Wait WDT reset and power on reset */
+	msleep(600);
+
+	error =3D data->ops->finish_fw_update(client, &data->fw_completion);
+	if (error)
+		return error;
+
+	error =3D data->ops->get_checksum(client, true, &fw_checksum);
+	if (error)
+		return error;
+
+	if (sw_checksum !=3D fw_checksum) {
+		dev_err(dev, "checksum diff sw=3D[%04X], fw=3D[%04X]\n",
+			sw_checksum, fw_checksum);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int elan_update_firmware(struct elan_tp_data *data,
+				const struct firmware *fw)
+{
+	struct i2c_client *client =3D data->client;
+	int retval;
+
+	dev_dbg(&client->dev, "Starting firmware update....\n");
+
+	disable_irq(client->irq);
+	data->in_fw_update =3D true;
+
+	retval =3D __elan_update_firmware(data, fw);
+	if (retval) {
+		dev_err(&client->dev, "firmware update failed: %d\n", retval);
+		data->ops->iap_reset(client);
+	} else {
+		/* Reinitialize TP after fw is updated */
+		elan_initialize(data);
+		elan_query_device_info(data);
+	}
+
+	data->in_fw_update =3D false;
+	enable_irq(client->irq);
+
+	return retval;
+}
+
+
+/*
+ *******************************************************************
+ * SYSFS attributes
+ *******************************************************************
+ */
+static ssize_t elan_sysfs_read_fw_checksum(struct device *dev,
+					   struct device_attribute *attr,
+					   char *buf)
+{
+	struct elan_tp_data *data =3D dev_get_drvdata(dev);
+
+	return sprintf(buf, "0x%04x\n", data->fw_checksum);
+}
+
+static ssize_t elan_sysfs_read_product_id(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	struct elan_tp_data *data =3D dev_get_drvdata(dev);
+
+	return sprintf(buf, "%d.0\n", data->product_id);
+}
+
+static ssize_t elan_sysfs_read_fw_ver(struct device *dev,
+				      struct device_attribute *attr,
+				      char *buf)
+{
+	struct elan_tp_data *data =3D dev_get_drvdata(dev);
+
+	return sprintf(buf, "%d.0\n", data->fw_version);
+}
+
+static ssize_t elan_sysfs_read_sm_ver(struct device *dev,
+				      struct device_attribute *attr,
+				      char *buf)
+{
+	struct elan_tp_data *data =3D dev_get_drvdata(dev);
+
+	return sprintf(buf, "%d.0\n", data->sm_version);
+}
+
+static ssize_t elan_sysfs_read_iap_ver(struct device *dev,
+				       struct device_attribute *attr,
+				       char *buf)
+{
+	struct elan_tp_data *data =3D dev_get_drvdata(dev);
+
+	return sprintf(buf, "%d.0\n", data->iap_version);
+}
+
+static ssize_t elan_sysfs_update_fw(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t count)
+{
+	struct elan_tp_data *data =3D dev_get_drvdata(dev);
+	const struct firmware *fw;
+	int error;
+
+	error =3D request_firmware(&fw, ETP_FW_NAME, dev);
+	if (error) {
+		dev_err(dev, "cannot load firmware %s: %d\n",
+			ETP_FW_NAME, error);
+		return error;
+	}
+
+	/* Firmware must be exactly PAGE_NUM * PAGE_SIZE bytes */
+	if (fw->size !=3D ETP_FW_SIZE) {
+		dev_err(dev, "invalid firmware size =3D %zu, expected %d.\n",
+			fw->size, ETP_FW_SIZE);
+		error =3D -EBADF;
+		goto out_release_fw;
+	}
+
+	error =3D mutex_lock_interruptible(&data->sysfs_mutex);
+	if (error)
+		goto out_release_fw;
+
+	error =3D elan_update_firmware(data, fw);
+
+	mutex_unlock(&data->sysfs_mutex);
+
+out_release_fw:
+	release_firmware(fw);
+	return error ?: count;
+}
+
+static ssize_t calibrate_store(struct device *dev,
+			       struct device_attribute *attr,
+			       const char *buf, size_t count)
+{
+	struct i2c_client *client =3D to_i2c_client(dev);
+	struct elan_tp_data *data =3D i2c_get_clientdata(client);
+	int tries =3D 20;
+	int retval;
+	int error;
+	u8 val[3];
+
+	retval =3D mutex_lock_interruptible(&data->sysfs_mutex);
+	if (retval)
+		return retval;
+
+	disable_irq(client->irq);
+
+	data->mode |=3D ETP_ENABLE_CALIBRATE;
+	retval =3D data->ops->set_mode(client, data->mode);
+	if (retval) {
+		dev_err(dev, "failed to enable calibration mode: %d\n",
+			retval);
+		goto out;
+	}
+
+	retval =3D data->ops->calibrate(client);
+	if (retval) {
+		dev_err(dev, "failed to start calibration: %d\n",
+			retval);
+		goto out_disable_calibrate;
+	}
+
+	val[0] =3D 0xff;
+	do {
+		/* Wait 250ms before checking if calibration has completed. */
+		msleep(250);
+
+		retval =3D data->ops->calibrate_result(client, val);
+		if (retval)
+			dev_err(dev, "failed to check calibration result: %d\n",
+				retval);
+		else if (val[0] =3D=3D 0)
+			break; /* calibration done */
+
+	} while (--tries);
+
+	if (tries =3D=3D 0) {
+		dev_err(dev, "failed to calibrate. Timeout.\n");
+		retval =3D -ETIMEDOUT;
+	}
+
+out_disable_calibrate:
+	data->mode &=3D ~ETP_ENABLE_CALIBRATE;
+	error =3D data->ops->set_mode(data->client, data->mode);
+	if (error) {
+		dev_err(dev, "failed to disable calibration mode: %d\n",
+			error);
+		if (!retval)
+			retval =3D error;
+	}
+out:
+	enable_irq(client->irq);
+	mutex_unlock(&data->sysfs_mutex);
+	return retval ?: count;
+}
+
+static ssize_t elan_sysfs_read_mode(struct device *dev,
+				    struct device_attribute *attr,
+				    char *buf)
+{
+	struct elan_tp_data *data =3D dev_get_drvdata(dev);
+	int error;
+	enum tp_mode mode;
+
+	error =3D mutex_lock_interruptible(&data->sysfs_mutex);
+	if (error)
+		return error;
+
+	error =3D data->ops->iap_get_mode(data->client, &mode);
+
+	mutex_unlock(&data->sysfs_mutex);
+
+	if (error)
+		return error;
+
+	return sprintf(buf, "%d\n", (int)mode);
+}
+
+static DEVICE_ATTR(product_id, S_IRUGO, elan_sysfs_read_product_id, NU=
LL);
+static DEVICE_ATTR(firmware_version, S_IRUGO, elan_sysfs_read_fw_ver, =
NULL);
+static DEVICE_ATTR(sample_version, S_IRUGO, elan_sysfs_read_sm_ver, NU=
LL);
+static DEVICE_ATTR(iap_version, S_IRUGO, elan_sysfs_read_iap_ver, NULL=
);
+static DEVICE_ATTR(fw_checksum, S_IRUGO, elan_sysfs_read_fw_checksum, =
NULL);
+static DEVICE_ATTR(mode, S_IRUGO, elan_sysfs_read_mode, NULL);
+static DEVICE_ATTR(update_fw, S_IWUSR, NULL, elan_sysfs_update_fw);
+
+static DEVICE_ATTR_WO(calibrate);
+
+static struct attribute *elan_sysfs_entries[] =3D {
+	&dev_attr_product_id.attr,
+	&dev_attr_firmware_version.attr,
+	&dev_attr_sample_version.attr,
+	&dev_attr_iap_version.attr,
+	&dev_attr_fw_checksum.attr,
+	&dev_attr_calibrate.attr,
+	&dev_attr_mode.attr,
+	&dev_attr_update_fw.attr,
+	NULL,
+};
+
+static const struct attribute_group elan_sysfs_group =3D {
+	.attrs =3D elan_sysfs_entries,
+};
+
+static ssize_t acquire_store(struct device *dev, struct device_attribu=
te *attr,
+			     const char *buf, size_t count)
+{
+	struct i2c_client *client =3D to_i2c_client(dev);
+	struct elan_tp_data *data =3D i2c_get_clientdata(client);
+	int error;
+	int retval;
+
+	retval =3D mutex_lock_interruptible(&data->sysfs_mutex);
+	if (retval)
+		return retval;
+
+	disable_irq(client->irq);
+
+	data->baseline_ready =3D false;
+
+	data->mode |=3D ETP_ENABLE_CALIBRATE;
+	retval =3D data->ops->set_mode(data->client, data->mode);
+	if (retval) {
+		dev_err(dev, "Failed to enable calibration mode to get baseline: %d\=
n",
+			retval);
+		goto out;
+	}
+
+	msleep(250);
+
+	retval =3D data->ops->get_baseline_data(data->client, true,
+					      &data->max_baseline);
+	if (retval) {
+		dev_err(dev, "Failed to read max baseline form device: %d\n",
+			retval);
+		goto out_disable_calibrate;
+	}
+
+	retval =3D data->ops->get_baseline_data(data->client, false,
+					      &data->min_baseline);
+	if (retval) {
+		dev_err(dev, "Failed to read min baseline form device: %d\n",
+			retval);
+		goto out_disable_calibrate;
+	}
+
+	data->baseline_ready =3D true;
+
+out_disable_calibrate:
+	data->mode &=3D ~ETP_ENABLE_CALIBRATE;
+	error =3D data->ops->set_mode(data->client, data->mode);
+	if (error) {
+		dev_err(dev, "Failed to disable calibration mode after acquiring bas=
eline: %d\n",
+			error);
+		if (!retval)
+			retval =3D error;
+	}
+out:
+	enable_irq(client->irq);
+	mutex_unlock(&data->sysfs_mutex);
+	return retval ?: count;
+}
+
+static ssize_t min_show(struct device *dev,
+			struct device_attribute *attr, char *buf)
+{
+	struct elan_tp_data *data =3D dev_get_drvdata(dev);
+	int retval;
+
+	retval =3D mutex_lock_interruptible(&data->sysfs_mutex);
+	if (retval)
+		return retval;
+
+	if (!data->baseline_ready) {
+		retval =3D -ENODATA;
+		goto out;
+	}
+
+	retval =3D snprintf(buf, PAGE_SIZE, "%d", data->min_baseline);
+
+out:
+	mutex_unlock(&data->sysfs_mutex);
+	return retval;
+}
+
+static ssize_t max_show(struct device *dev,
+			struct device_attribute *attr, char *buf)
+{
+	struct elan_tp_data *data =3D dev_get_drvdata(dev);
+	int retval;
+
+	retval =3D mutex_lock_interruptible(&data->sysfs_mutex);
+	if (retval)
+		return retval;
+
+	if (!data->baseline_ready) {
+		retval =3D -ENODATA;
+		goto out;
+	}
+
+	retval =3D snprintf(buf, PAGE_SIZE, "%d", data->max_baseline);
+
+out:
+	mutex_unlock(&data->sysfs_mutex);
+	return retval;
+}
+
+
+static DEVICE_ATTR_WO(acquire);
+static DEVICE_ATTR_RO(min);
+static DEVICE_ATTR_RO(max);
+
+static struct attribute *elan_baseline_sysfs_entries[] =3D {
+	&dev_attr_acquire.attr,
+	&dev_attr_min.attr,
+	&dev_attr_max.attr,
+	NULL,
+};
+
+static const struct attribute_group elan_baseline_sysfs_group =3D {
+	.name =3D "baseline",
+	.attrs =3D elan_baseline_sysfs_entries,
+};
+
+static const struct attribute_group *elan_sysfs_groups[] =3D {
+	&elan_sysfs_group,
+	&elan_baseline_sysfs_group,
+	NULL
+};
+
+/*
+ ******************************************************************
+ * Elan isr functions
+ ******************************************************************
+ */
+static void elan_report_contact(struct elan_tp_data *data,
+				int contact_num, bool contact_valid,
+				u8 *finger_data)
+{
+	struct input_dev *input =3D data->input;
+	unsigned int pos_x, pos_y;
+	unsigned int pressure, mk_x, mk_y;
+	unsigned int area_x, area_y, major, minor, new_pressure;
+
+
+	if (contact_valid) {
+		pos_x =3D ((finger_data[0] & 0xf0) << 4) |
+						finger_data[1];
+		pos_y =3D ((finger_data[0] & 0x0f) << 8) |
+						finger_data[2];
+		mk_x =3D (finger_data[3] & 0x0f);
+		mk_y =3D (finger_data[3] >> 4);
+		pressure =3D finger_data[4];
+
+		if (pos_x > data->max_x || pos_y > data->max_y) {
+			dev_dbg(input->dev.parent,
+				"[%d] x=3D%d y=3D%d over max (%d, %d)",
+				contact_num, pos_x, pos_y,
+				data->max_x, data->max_y);
+			return;
+		}
+
+		/*
+		 * To avoid treating large finger as palm, let's reduce the
+		 * width x and y per trace.
+		 */
+		area_x =3D mk_x * (data->width_x - ETP_FWIDTH_REDUCE);
+		area_y =3D mk_y * (data->width_y - ETP_FWIDTH_REDUCE);
+
+		major =3D max(area_x, area_y);
+		minor =3D min(area_x, area_y);
+
+		new_pressure =3D pressure + ETP_PRESSURE_OFFSET;
+		if (new_pressure > ETP_MAX_PRESSURE)
+			new_pressure =3D ETP_MAX_PRESSURE;
+
+		input_mt_slot(input, contact_num);
+		input_mt_report_slot_state(input, MT_TOOL_FINGER, true);
+		input_report_abs(input, ABS_MT_POSITION_X, pos_x);
+		input_report_abs(input, ABS_MT_POSITION_Y, data->max_y - pos_y);
+		input_report_abs(input, ABS_MT_PRESSURE, new_pressure);
+		input_report_abs(input, ABS_TOOL_WIDTH, mk_x);
+		input_report_abs(input, ABS_MT_TOUCH_MAJOR, major);
+		input_report_abs(input, ABS_MT_TOUCH_MINOR, minor);
+	} else {
+		input_mt_slot(input, contact_num);
+		input_mt_report_slot_state(input, MT_TOOL_FINGER, false);
+	}
+}
+
+static void elan_report_absolute(struct elan_tp_data *data, u8 *packet=
)
+{
+	struct input_dev *input =3D data->input;
+	u8 *finger_data =3D &packet[ETP_FINGER_DATA_OFFSET];
+	int i;
+	u8 tp_info =3D packet[ETP_TOUCH_INFO_OFFSET];
+	bool contact_valid;
+
+	for (i =3D 0; i < ETP_MAX_FINGERS; i++) {
+		contact_valid =3D tp_info & (1U << (3 + i));
+		elan_report_contact(data, i, contact_valid, finger_data);
+
+		if (contact_valid)
+			finger_data +=3D ETP_FINGER_DATA_LEN;
+	}
+
+	input_report_key(input, BTN_LEFT, tp_info & 0x01);
+	input_mt_report_pointer_emulation(input, true);
+	input_sync(input);
+}
+
+static irqreturn_t elan_isr(int irq, void *dev_id)
+{
+	struct elan_tp_data *data =3D dev_id;
+	struct device *dev =3D &data->client->dev;
+	int error;
+	u8 report[ETP_MAX_REPORT_LEN];
+
+	/*
+	 * When device is connected to i2c bus, when all IAP page writes
+	 * complete, the driver will receive interrupt and must read
+	 * 0000 to confirm that IAP is finished.
+	*/
+	if (data->in_fw_update) {
+		complete(&data->fw_completion);
+		goto out;
+	}
+
+	error =3D data->ops->get_report(data->client, report);
+	if (error)
+		goto out;
+
+	if (report[ETP_REPORT_ID_OFFSET] !=3D ETP_REPORT_ID)
+		dev_err(dev, "invalid report id data (%x)\n",
+			report[ETP_REPORT_ID_OFFSET]);
+	else
+		elan_report_absolute(data, report);
+
+out:
+	return IRQ_HANDLED;
+}
+
+/*
+ ******************************************************************
+ * Elan initialization functions
+ ******************************************************************
+ */
+static int elan_setup_input_device(struct elan_tp_data *data)
+{
+	struct device *dev =3D &data->client->dev;
+	struct input_dev *input;
+	unsigned int max_width =3D max(data->width_x, data->width_y);
+	unsigned int min_width =3D min(data->width_x, data->width_y);
+	int error;
+
+	input =3D devm_input_allocate_device(dev);
+	if (!input)
+		return -ENOMEM;
+
+	input->name =3D "Elan Touchpad";
+	input->id.bustype =3D BUS_I2C;
+	input_set_drvdata(input, data);
+
+	error =3D input_mt_init_slots(input, ETP_MAX_FINGERS,
+				    INPUT_MT_POINTER | INPUT_MT_DROP_UNUSED);
+	if (error) {
+		dev_err(dev, "failed to initialize MT slots: %d\n", error);
+		return error;
+	}
+
+	__set_bit(EV_ABS, input->evbit);
+	__set_bit(INPUT_PROP_POINTER, input->propbit);
+	__set_bit(INPUT_PROP_BUTTONPAD, input->propbit);
+	__set_bit(BTN_LEFT, input->keybit);
+
+	/* Set up ST parameters */
+	input_set_abs_params(input, ABS_X, 0, data->max_x, 0, 0);
+	input_set_abs_params(input, ABS_Y, 0, data->max_y, 0, 0);
+	input_abs_set_res(input, ABS_X, data->x_res);
+	input_abs_set_res(input, ABS_Y, data->y_res);
+	input_set_abs_params(input, ABS_PRESSURE, 0, ETP_MAX_PRESSURE, 0, 0);
+	input_set_abs_params(input, ABS_TOOL_WIDTH, 0, ETP_FINGER_WIDTH, 0, 0=
);
+
+	/* And MT parameters */
+	input_set_abs_params(input, ABS_MT_POSITION_X, 0, data->max_x, 0, 0);
+	input_set_abs_params(input, ABS_MT_POSITION_Y, 0, data->max_y, 0, 0);
+	input_abs_set_res(input, ABS_MT_POSITION_X, data->x_res);
+	input_abs_set_res(input, ABS_MT_POSITION_Y, data->y_res);
+	input_set_abs_params(input, ABS_MT_PRESSURE, 0,
+			     ETP_MAX_PRESSURE, 0, 0);
+	input_set_abs_params(input, ABS_MT_TOUCH_MAJOR, 0,
+			     ETP_FINGER_WIDTH * max_width, 0, 0);
+	input_set_abs_params(input, ABS_MT_TOUCH_MINOR, 0,
+			     ETP_FINGER_WIDTH * min_width, 0, 0);
+
+	data->input =3D input;
+
+	return 0;
+}
+
+static void elan_disable_regulator(void *_data)
+{
+	struct elan_tp_data *data =3D _data;
+
+	regulator_disable(data->vcc);
+}
+
+static void elan_remove_sysfs_groups(void *_data)
+{
+	struct elan_tp_data *data =3D _data;
+
+	sysfs_remove_groups(&data->client->dev.kobj, elan_sysfs_groups);
+}
+
+static int elan_probe(struct i2c_client *client,
+		      const struct i2c_device_id *dev_id)
+{
+	const struct elan_transport_ops *transport_ops;
+	struct device *dev =3D &client->dev;
+	struct elan_tp_data *data;
+	unsigned long irqflags;
+	int error;
+
+	if (IS_ENABLED(CONFIG_MOUSE_ELAN_I2C_I2C) &&
+	    i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
+		transport_ops =3D &elan_i2c_ops;
+	} else if (IS_ENABLED(CONFIG_MOUSE_ELAN_I2C_SMBUS) &&
+		   i2c_check_functionality(client->adapter,
+					   I2C_FUNC_SMBUS_BYTE_DATA |
+						I2C_FUNC_SMBUS_BLOCK_DATA |
+						I2C_FUNC_SMBUS_I2C_BLOCK)) {
+		transport_ops =3D &elan_smbus_ops;
+	} else {
+		dev_err(dev, "not a supported I2C/SMBus adapter\n");
+		return -EIO;
+	}
+
+	data =3D devm_kzalloc(&client->dev, sizeof(struct elan_tp_data),
+			    GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->ops =3D transport_ops;
+	data->client =3D client;
+	init_completion(&data->fw_completion);
+	mutex_init(&data->sysfs_mutex);
+
+	data->vcc =3D devm_regulator_get(&client->dev, "vcc");
+	if (IS_ERR(data->vcc)) {
+		error =3D PTR_ERR(data->vcc);
+		if (error !=3D -EPROBE_DEFER)
+			dev_err(&client->dev,
+				"Failed to get 'vcc' regulator: %d\n",
+				error);
+		return error;
+	}
+
+	error =3D regulator_enable(data->vcc);
+	if (error) {
+		dev_err(&client->dev,
+			"Failed to enable regulator: %d\n", error);
+		return error;
+	}
+
+	error =3D devm_add_action(&client->dev,
+				elan_disable_regulator, data);
+	if (error) {
+		regulator_disable(data->vcc);
+		dev_err(&client->dev,
+			"Failed to add disable regulator action: %d\n",
+			error);
+		return error;
+	}
+
+	/* Initialize the touchpad. */
+	error =3D elan_initialize(data);
+	if (error)
+		return error;
+
+	error =3D elan_query_device_info(data);
+	if (error)
+		return error;
+
+	error =3D elan_query_device_parameters(data);
+	if (error)
+		return error;
+
+	dev_dbg(&client->dev,
+		"Elan Touchpad Information:\n"
+		"    Module product ID:  0x%04x\n"
+		"    Firmware Version:  0x%04x\n"
+		"    Sample Version:  0x%04x\n"
+		"    IAP Version:  0x%04x\n"
+		"    Max ABS X,Y:   %d,%d\n"
+		"    Width X,Y:   %d,%d\n"
+		"    Resolution X,Y:   %d,%d (dots/mm)\n",
+		data->product_id,
+		data->fw_version,
+		data->sm_version,
+		data->iap_version,
+		data->max_x, data->max_y,
+		data->width_x, data->width_y,
+		data->x_res, data->y_res);
+
+	/* Set up input device properties based on queried parameters. */
+	error =3D elan_setup_input_device(data);
+	if (error)
+		return error;
+
+	/*
+	 * Systems using device tree should set up interrupt via DTS,
+	 * the rest will use the default falling edge interrupts.
+	 */
+	irqflags =3D client->dev.of_node ? 0 : IRQF_TRIGGER_FALLING;
+
+	error =3D devm_request_threaded_irq(&client->dev, client->irq,
+					  NULL, elan_isr,
+					  irqflags | IRQF_ONESHOT,
+					  client->name, data);
+	if (error) {
+		dev_err(&client->dev, "cannot register irq=3D%d\n", client->irq);
+		return error;
+	}
+
+	error =3D sysfs_create_groups(&client->dev.kobj, elan_sysfs_groups);
+	if (error) {
+		dev_err(&client->dev, "failed to create sysfs attributes: %d\n",
+			error);
+		return error;
+	}
+
+	error =3D devm_add_action(&client->dev,
+				elan_remove_sysfs_groups, data);
+	if (error) {
+		elan_remove_sysfs_groups(data);
+		dev_err(&client->dev,
+			"Failed to add sysfs cleanup action: %d\n",
+			error);
+		return error;
+	}
+
+	error =3D input_register_device(data->input);
+	if (error) {
+		dev_err(&client->dev, "failed to register input device: %d\n",
+			error);
+		return error;
+	}
+
+	/*
+	 * Systems using device tree should set up wakeup via DTS,
+	 * the rest will configure device as wakeup source by default.
+	 */
+	if (!client->dev.of_node)
+		device_init_wakeup(&client->dev, true);
+
+	i2c_set_clientdata(client, data);
+
+	return 0;
+}
+
+static int __maybe_unused elan_suspend(struct device *dev)
+{
+	struct i2c_client *client =3D to_i2c_client(dev);
+	struct elan_tp_data *data =3D i2c_get_clientdata(client);
+	int ret;
+
+	/*
+	 * We are taking the mutex to make sure sysfs operations are
+	 * complete before we attempt to bring the device into low[er]
+	 * power mode.
+	 */
+	ret =3D mutex_lock_interruptible(&data->sysfs_mutex);
+	if (ret)
+		return ret;
+
+	disable_irq(client->irq);
+
+	if (device_may_wakeup(dev)) {
+		ret =3D elan_sleep(data);
+		/* Enable wake from IRQ */
+		data->irq_wake =3D (enable_irq_wake(client->irq) =3D=3D 0);
+	} else {
+		ret =3D elan_disable_power(data);
+	}
+
+	mutex_unlock(&data->sysfs_mutex);
+	return ret;
+}
+
+static int __maybe_unused elan_resume(struct device *dev)
+{
+	struct i2c_client *client =3D to_i2c_client(dev);
+	struct elan_tp_data *data =3D i2c_get_clientdata(client);
+	int error;
+
+	if (device_may_wakeup(dev) && data->irq_wake) {
+		disable_irq_wake(client->irq);
+		data->irq_wake =3D false;
+	}
+
+	error =3D elan_enable_power(data);
+	if (error)
+		dev_err(dev, "power up when resuming failed: %d\n", error);
+
+	error =3D elan_initialize(data);
+	if (error)
+		dev_err(dev, "initialize when resuming failed: %d\n", error);
+
+	enable_irq(data->client->irq);
+
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(elan_pm_ops, elan_suspend, elan_resume);
+
+static const struct i2c_device_id elan_id[] =3D {
+	{ DRIVER_NAME, 0 },
+	{ },
+};
+MODULE_DEVICE_TABLE(i2c, elan_id);
+
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id elan_acpi_id[] =3D {
+	{ "ELAN0000", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, elan_acpi_id);
+#endif
+
+#ifdef CONFIG_OF
+static const struct of_device_id elan_of_match[] =3D {
+	{ .compatible =3D "elan,i2c_touchpad" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, elan_of_match);
+#endif
+
+static struct i2c_driver elan_driver =3D {
+	.driver =3D {
+		.name	=3D DRIVER_NAME,
+		.owner	=3D THIS_MODULE,
+		.pm	=3D &elan_pm_ops,
+		.acpi_match_table =3D ACPI_PTR(elan_acpi_id),
+		.of_match_table =3D of_match_ptr(elan_of_match),
+	},
+	.probe		=3D elan_probe,
+	.id_table	=3D elan_id,
+};
+
+module_i2c_driver(elan_driver);
+
+MODULE_AUTHOR("Duson Lin <dusonlin@emc.com.tw>");
+MODULE_DESCRIPTION("Elan I2C/SMBus Touchpad driver");
+MODULE_LICENSE("GPL");
+MODULE_VERSION(ELAN_DRIVER_VERSION);
diff --git a/drivers/input/mouse/elan_i2c_i2c.c b/drivers/input/mouse/e=
lan_i2c_i2c.c
new file mode 100644
index 0000000..047b257
--- /dev/null
+++ b/drivers/input/mouse/elan_i2c_i2c.c
@@ -0,0 +1,612 @@
+/*
+ * Elan I2C/SMBus Touchpad driver - I2C interface
+ *
+ * Copyright (c) 2013 ELAN Microelectronics Corp.
+ *
+ * Author: =E6=9E=97=E6=94=BF=E7=B6=AD (Duson Lin) <dusonlin@emc.com.t=
w>
+ * Version: 1.5.5
+ *
+ * Based on cyapa driver:
+ * copyright (c) 2011-2012 Cypress Semiconductor, Inc.
+ * copyright (c) 2011-2012 Google, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modif=
y it
+ * under the terms of the GNU General Public License version 2 as publ=
ished
+ * by the Free Software Foundation.
+ *
+ * Trademarks are the property of their respective owners.
+ */
+
+#include <linux/completion.h>
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/jiffies.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <asm/unaligned.h>
+
+#include "elan_i2c.h"
+
+/* Elan i2c commands */
+#define ETP_I2C_RESET			0x0100
+#define ETP_I2C_WAKE_UP			0x0800
+#define ETP_I2C_SLEEP			0x0801
+#define ETP_I2C_DESC_CMD		0x0001
+#define ETP_I2C_REPORT_DESC_CMD		0x0002
+#define ETP_I2C_STAND_CMD		0x0005
+#define ETP_I2C_UNIQUEID_CMD		0x0101
+#define ETP_I2C_FW_VERSION_CMD		0x0102
+#define ETP_I2C_SM_VERSION_CMD		0x0103
+#define ETP_I2C_XY_TRACENUM_CMD		0x0105
+#define ETP_I2C_MAX_X_AXIS_CMD		0x0106
+#define ETP_I2C_MAX_Y_AXIS_CMD		0x0107
+#define ETP_I2C_RESOLUTION_CMD		0x0108
+#define ETP_I2C_IAP_VERSION_CMD		0x0110
+#define ETP_I2C_SET_CMD			0x0300
+#define ETP_I2C_POWER_CMD		0x0307
+#define ETP_I2C_FW_CHECKSUM_CMD		0x030F
+#define ETP_I2C_IAP_CTRL_CMD		0x0310
+#define ETP_I2C_IAP_CMD			0x0311
+#define ETP_I2C_IAP_RESET_CMD		0x0314
+#define ETP_I2C_IAP_CHECKSUM_CMD	0x0315
+#define ETP_I2C_CALIBRATE_CMD		0x0316
+#define ETP_I2C_MAX_BASELINE_CMD	0x0317
+#define ETP_I2C_MIN_BASELINE_CMD	0x0318
+
+#define ETP_I2C_REPORT_LEN		34
+#define ETP_I2C_DESC_LENGTH		30
+#define ETP_I2C_REPORT_DESC_LENGTH	158
+#define ETP_I2C_INF_LENGTH		2
+#define ETP_I2C_IAP_PASSWORD		0x1EA5
+#define ETP_I2C_IAP_RESET		0xF0F0
+#define ETP_I2C_MAIN_MODE_ON		(1 << 9)
+#define ETP_I2C_IAP_REG_L		0x01
+#define ETP_I2C_IAP_REG_H		0x06
+
+static int elan_i2c_read_block(struct i2c_client *client,
+			       u16 reg, u8 *val, u16 len)
+{
+	__le16 buf[] =3D {
+		cpu_to_le16(reg),
+	};
+	struct i2c_msg msgs[] =3D {
+		{
+			.addr =3D client->addr,
+			.flags =3D client->flags & I2C_M_TEN,
+			.len =3D sizeof(buf),
+			.buf =3D (u8 *)buf,
+		},
+		{
+			.addr =3D client->addr,
+			.flags =3D (client->flags & I2C_M_TEN) | I2C_M_RD,
+			.len =3D len,
+			.buf =3D val,
+		}
+	};
+	int ret;
+
+	ret =3D i2c_transfer(client->adapter, msgs, ARRAY_SIZE(msgs));
+	return ret =3D=3D ARRAY_SIZE(msgs) ? 0 : (ret < 0 ? ret : -EIO);
+}
+
+static int elan_i2c_read_cmd(struct i2c_client *client, u16 reg, u8 *v=
al)
+{
+	int retval;
+
+	retval =3D elan_i2c_read_block(client, reg, val, ETP_I2C_INF_LENGTH);
+	if (retval < 0) {
+		dev_err(&client->dev, "reading cmd (0x%04x) fail.\n", reg);
+		return retval;
+	}
+
+	return 0;
+}
+
+static int elan_i2c_write_cmd(struct i2c_client *client, u16 reg, u16 =
cmd)
+{
+	__le16 buf[] =3D {
+		cpu_to_le16(reg),
+		cpu_to_le16(cmd),
+	};
+	struct i2c_msg msg =3D {
+		.addr =3D client->addr,
+		.flags =3D client->flags & I2C_M_TEN,
+		.len =3D sizeof(buf),
+		.buf =3D (u8 *)buf,
+	};
+	int ret;
+
+	ret =3D i2c_transfer(client->adapter, &msg, 1);
+	return ret =3D=3D 1 ? 0 : (ret < 0 ? ret : -EIO);
+}
+
+static int elan_i2c_initialize(struct i2c_client *client)
+{
+	struct device *dev =3D &client->dev;
+	int error;
+	u8 val[256];
+
+	error =3D elan_i2c_write_cmd(client, ETP_I2C_STAND_CMD, ETP_I2C_RESET=
);
+	if (error) {
+		dev_err(dev, "device reset failed: %d\n", error);
+		return error;
+	}
+
+	/* Wait for the device to reset */
+	msleep(100);
+
+	/* get reset acknowledgement 0000 */
+	error =3D i2c_master_recv(client, val, ETP_I2C_INF_LENGTH);
+	if (error < 0) {
+		dev_err(dev, "failed to read reset response: %d\n", error);
+		return error;
+	}
+
+	error =3D elan_i2c_read_block(client, ETP_I2C_DESC_CMD,
+				    val, ETP_I2C_DESC_LENGTH);
+	if (error) {
+		dev_err(dev, "cannot get device descriptor: %d\n", error);
+		return error;
+	}
+
+	error =3D elan_i2c_read_block(client, ETP_I2C_REPORT_DESC_CMD,
+				    val, ETP_I2C_REPORT_DESC_LENGTH);
+	if (error) {
+		dev_err(dev, "fetching report descriptor failed.: %d\n", error);
+		return error;
+	}
+
+	return 0;
+}
+
+static int elan_i2c_sleep_control(struct i2c_client *client, bool slee=
p)
+{
+	return elan_i2c_write_cmd(client, ETP_I2C_STAND_CMD,
+				  sleep ? ETP_I2C_SLEEP : ETP_I2C_WAKE_UP);
+}
+
+static int elan_i2c_power_control(struct i2c_client *client, bool enab=
le)
+{
+	u8 val[2];
+	u16 reg;
+	int error;
+
+	error =3D elan_i2c_read_cmd(client, ETP_I2C_POWER_CMD, val);
+	if (error) {
+		dev_err(&client->dev,
+			"failed to read current power state: %d\n",
+			error);
+		return error;
+	}
+
+	reg =3D le16_to_cpup((__le16 *)val);
+	if (enable)
+		reg &=3D ~ETP_DISABLE_POWER;
+	else
+		reg |=3D ETP_DISABLE_POWER;
+
+	error =3D elan_i2c_write_cmd(client, ETP_I2C_POWER_CMD,
+				   cpu_to_le16(reg));
+	if (error) {
+		dev_err(&client->dev,
+			"failed to write current power state: %d\n",
+			error);
+		return error;
+	}
+
+	return 0;
+}
+
+static int elan_i2c_set_mode(struct i2c_client *client, u8 mode)
+{
+	return elan_i2c_write_cmd(client, ETP_I2C_SET_CMD, mode);
+}
+
+
+static int elan_i2c_calibrate(struct i2c_client *client)
+{
+	return elan_i2c_write_cmd(client, ETP_I2C_CALIBRATE_CMD, 1);
+}
+
+static int elan_i2c_calibrate_result(struct i2c_client *client, u8 *va=
l)
+{
+	return elan_i2c_read_block(client, ETP_I2C_CALIBRATE_CMD, val, 1);
+}
+
+static int elan_i2c_get_baseline_data(struct i2c_client *client,
+				      bool max_baseline, u8 *value)
+{
+	int error;
+	u8 val[3];
+
+	error =3D elan_i2c_read_cmd(client,
+				  max_baseline ? ETP_I2C_MAX_BASELINE_CMD :
+						 ETP_I2C_MIN_BASELINE_CMD,
+				  val);
+	if (error)
+		return error;
+
+	*value =3D le16_to_cpup((__le16 *)val);
+
+	return 0;
+}
+
+static int elan_i2c_get_version(struct i2c_client *client,
+				bool iap, u8 *version)
+{
+	int error;
+	u8 val[3];
+
+	error =3D elan_i2c_read_cmd(client,
+				  iap ? ETP_I2C_IAP_VERSION_CMD :
+					ETP_I2C_FW_VERSION_CMD,
+				  val);
+	if (error) {
+		dev_err(&client->dev, "failed to get %s version: %d\n",
+			iap ? "IAP" : "FW", error);
+		return error;
+	}
+
+	*version =3D val[0];
+	return 0;
+}
+
+static int elan_i2c_get_sm_version(struct i2c_client *client, u8 *vers=
ion)
+{
+	int error;
+	u8 val[3];
+
+	error =3D elan_i2c_read_cmd(client, ETP_I2C_SM_VERSION_CMD, val);
+	if (error) {
+		dev_err(&client->dev, "failed to get SM version: %d\n", error);
+		return error;
+	}
+
+	*version =3D val[0];
+	return 0;
+}
+
+static int elan_i2c_get_product_id(struct i2c_client *client, u8 *id)
+{
+	int error;
+	u8 val[3];
+
+	error =3D elan_i2c_read_cmd(client, ETP_I2C_UNIQUEID_CMD, val);
+	if (error) {
+		dev_err(&client->dev, "failed to get product ID: %d\n", error);
+		return error;
+	}
+
+	*id =3D val[0];
+	return 0;
+}
+
+static int elan_i2c_get_checksum(struct i2c_client *client,
+				 bool iap, u16 *csum)
+{
+	int error;
+	u8 val[3];
+
+	error =3D elan_i2c_read_cmd(client,
+				  iap ? ETP_I2C_IAP_CHECKSUM_CMD :
+					ETP_I2C_FW_CHECKSUM_CMD,
+				  val);
+	if (error) {
+		dev_err(&client->dev, "failed to get %s checksum: %d\n",
+			iap ? "IAP" : "FW", error);
+		return error;
+	}
+
+	*csum =3D le16_to_cpup((__le16 *)val);
+	return 0;
+}
+
+static int elan_i2c_get_max(struct i2c_client *client,
+			    unsigned int *max_x, unsigned int *max_y)
+{
+	int error;
+	u8 val[3];
+
+	error =3D elan_i2c_read_cmd(client, ETP_I2C_MAX_X_AXIS_CMD, val);
+	if (error) {
+		dev_err(&client->dev, "failed to get X dimension: %d\n", error);
+		return error;
+	}
+
+	*max_x =3D le16_to_cpup((__le16 *)val) & 0x0fff;
+
+	error =3D elan_i2c_read_cmd(client, ETP_I2C_MAX_Y_AXIS_CMD, val);
+	if (error) {
+		dev_err(&client->dev, "failed to get Y dimension: %d\n", error);
+		return error;
+	}
+
+	*max_y =3D le16_to_cpup((__le16 *)val) & 0x0fff;
+
+	return 0;
+}
+
+static int elan_i2c_get_resolution(struct i2c_client *client,
+				   u8 *hw_res_x, u8 *hw_res_y)
+{
+	int error;
+	u8 val[3];
+
+	error =3D elan_i2c_read_cmd(client, ETP_I2C_RESOLUTION_CMD, val);
+	if (error) {
+		dev_err(&client->dev, "failed to get resolution: %d\n", error);
+		return error;
+	}
+
+	*hw_res_x =3D val[0];
+	*hw_res_y =3D val[1];
+
+	return 0;
+}
+
+static int elan_i2c_get_num_traces(struct i2c_client *client,
+				   unsigned int *x_traces,
+				   unsigned int *y_traces)
+{
+	int error;
+	u8 val[3];
+
+	error =3D elan_i2c_read_cmd(client, ETP_I2C_XY_TRACENUM_CMD, val);
+	if (error) {
+		dev_err(&client->dev, "failed to get trace info: %d\n", error);
+		return error;
+	}
+
+	*x_traces =3D val[0] - 1;
+	*y_traces =3D val[1] - 1;
+
+	return 0;
+}
+
+static int elan_i2c_iap_get_mode(struct i2c_client *client, enum tp_mo=
de *mode)
+{
+	int error;
+	u16 constant;
+	u8 val[3];
+
+	error =3D elan_i2c_read_cmd(client, ETP_I2C_IAP_CTRL_CMD, val);
+	if (error) {
+		dev_err(&client->dev,
+			"failed to read iap control register: %d\n",
+			error);
+		return error;
+	}
+
+	constant =3D le16_to_cpup((__le16 *)val);
+	dev_dbg(&client->dev, "iap control reg: 0x%04x.\n", constant);
+
+	*mode =3D (constant & ETP_I2C_MAIN_MODE_ON) ? MAIN_MODE : IAP_MODE;
+
+	return 0;
+}
+
+static int elan_i2c_iap_reset(struct i2c_client *client)
+{
+	int error;
+
+	error =3D elan_i2c_write_cmd(client, ETP_I2C_IAP_RESET_CMD,
+				   ETP_I2C_IAP_RESET);
+	if (error) {
+		dev_err(&client->dev, "cannot reset IC: %d\n", error);
+		return error;
+	}
+
+	return 0;
+}
+
+static int elan_i2c_set_flash_key(struct i2c_client *client)
+{
+	int error;
+
+	error =3D elan_i2c_write_cmd(client, ETP_I2C_IAP_CMD,
+				   ETP_I2C_IAP_PASSWORD);
+	if (error) {
+		dev_err(&client->dev, "cannot set flash key: %d\n", error);
+		return error;
+	}
+
+	return 0;
+}
+
+static int elan_i2c_prepare_fw_update(struct i2c_client *client)
+{
+	struct device *dev =3D &client->dev;
+	int error;
+	enum tp_mode mode;
+	u8 val[3];
+	u16 password;
+
+	/* Get FW in which mode	(IAP_MODE/MAIN_MODE)  */
+	error =3D elan_i2c_iap_get_mode(client, &mode);
+	if (error)
+		return error;
+
+	if (mode =3D=3D IAP_MODE) {
+		/* Reset IC */
+		error =3D elan_i2c_iap_reset(client);
+		if (error)
+			return error;
+
+		msleep(30);
+	}
+
+	/* Set flash key*/
+	error =3D elan_i2c_set_flash_key(client);
+	if (error)
+		return error;
+
+	/* Wait for F/W IAP initialization */
+	msleep(mode =3D=3D MAIN_MODE ? 100 : 30);
+
+	/* Check if we are in IAP mode or not */
+	error =3D elan_i2c_iap_get_mode(client, &mode);
+	if (error)
+		return error;
+
+	if (mode =3D=3D MAIN_MODE) {
+		dev_err(dev, "wrong mode: %d\n", mode);
+		return -EIO;
+	}
+
+	/* Set flash key again */
+	error =3D elan_i2c_set_flash_key(client);
+	if (error)
+		return error;
+
+	/* Wait for F/W IAP initialization */
+	msleep(30);
+
+	/* read back to check we actually enabled successfully. */
+	error =3D elan_i2c_read_cmd(client, ETP_I2C_IAP_CMD, val);
+	if (error) {
+		dev_err(dev, "cannot read iap password: %d\n",
+			error);
+		return error;
+	}
+
+	password =3D le16_to_cpup((__le16 *)val);
+	if (password !=3D ETP_I2C_IAP_PASSWORD) {
+		dev_err(dev, "wrong iap password: 0x%X\n", password);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int elan_i2c_write_fw_block(struct i2c_client *client,
+				   const u8 *page, u16 checksum, int idx)
+{
+	struct device *dev =3D &client->dev;
+	u8 page_store[ETP_FW_PAGE_SIZE + 4];
+	u8 val[3];
+	u16 result;
+	int ret, error;
+
+	page_store[0] =3D ETP_I2C_IAP_REG_L;
+	page_store[1] =3D ETP_I2C_IAP_REG_H;
+	memcpy(&page_store[2], page, ETP_FW_PAGE_SIZE);
+	/* recode checksum at last two bytes */
+	put_unaligned_le16(checksum, &page_store[ETP_FW_PAGE_SIZE + 2]);
+
+	ret =3D i2c_master_send(client, page_store, sizeof(page_store));
+	if (ret !=3D sizeof(page_store)) {
+		error =3D ret < 0 ? ret : -EIO;
+		dev_err(dev, "Failed to write page %d: %d\n", idx, error);
+		return error;
+	}
+
+	/* Wait for F/W to update one page ROM data. */
+	msleep(20);
+
+	error =3D elan_i2c_read_cmd(client, ETP_I2C_IAP_CTRL_CMD, val);
+	if (error) {
+		dev_err(dev, "Failed to read IAP write result: %d\n", error);
+		return error;
+	}
+
+	result =3D le16_to_cpup((__le16 *)val);
+	if (result & (ETP_FW_IAP_PAGE_ERR | ETP_FW_IAP_INTF_ERR)) {
+		dev_err(dev, "IAP reports failed write: %04hx\n",
+			result);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int elan_i2c_finish_fw_update(struct i2c_client *client,
+				     struct completion *completion)
+{
+	struct device *dev =3D &client->dev;
+	long ret;
+	int error;
+	int len;
+	u8 buffer[ETP_I2C_INF_LENGTH];
+
+	reinit_completion(completion);
+	enable_irq(client->irq);
+
+	error =3D elan_i2c_write_cmd(client, ETP_I2C_STAND_CMD, ETP_I2C_RESET=
);
+	if (!error)
+		ret =3D wait_for_completion_interruptible_timeout(completion,
+							msecs_to_jiffies(300));
+	disable_irq(client->irq);
+
+	if (error) {
+		dev_err(dev, "device reset failed: %d\n", error);
+		return error;
+	} else if (ret =3D=3D 0) {
+		dev_err(dev, "timeout waiting for device reset\n");
+		return -ETIMEDOUT;
+	} else if (ret < 0) {
+		error =3D ret;
+		dev_err(dev, "error waiting for device reset: %d\n", error);
+		return error;
+	}
+
+	len =3D i2c_master_recv(client, buffer, ETP_I2C_INF_LENGTH);
+	if (len !=3D ETP_I2C_INF_LENGTH) {
+		error =3D len < 0 ? len : -EIO;
+		dev_err(dev, "failed to read INT signal: %d (%d)\n",
+			error, len);
+		return error;
+	}
+
+	return 0;
+}
+
+static int elan_i2c_get_report(struct i2c_client *client, u8 *report)
+{
+	int len;
+
+	len =3D i2c_master_recv(client, report, ETP_I2C_REPORT_LEN);
+	if (len < 0) {
+		dev_err(&client->dev, "failed to read report data: %d\n", len);
+		return len;
+	}
+
+	if (len !=3D ETP_I2C_REPORT_LEN) {
+		dev_err(&client->dev,
+			"wrong report length (%d vs %d expected)\n",
+			len, ETP_I2C_REPORT_LEN);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+const struct elan_transport_ops elan_i2c_ops =3D {
+	.initialize		=3D elan_i2c_initialize,
+	.sleep_control		=3D elan_i2c_sleep_control,
+	.power_control		=3D elan_i2c_power_control,
+	.set_mode		=3D elan_i2c_set_mode,
+
+	.calibrate		=3D elan_i2c_calibrate,
+	.calibrate_result	=3D elan_i2c_calibrate_result,
+
+	.get_baseline_data	=3D elan_i2c_get_baseline_data,
+
+	.get_version		=3D elan_i2c_get_version,
+	.get_sm_version		=3D elan_i2c_get_sm_version,
+	.get_product_id		=3D elan_i2c_get_product_id,
+	.get_checksum		=3D elan_i2c_get_checksum,
+
+	.get_max		=3D elan_i2c_get_max,
+	.get_resolution		=3D elan_i2c_get_resolution,
+	.get_num_traces		=3D elan_i2c_get_num_traces,
+
+	.iap_get_mode		=3D elan_i2c_iap_get_mode,
+	.iap_reset		=3D elan_i2c_iap_reset,
+
+	.prepare_fw_update	=3D elan_i2c_prepare_fw_update,
+	.write_fw_block		=3D elan_i2c_write_fw_block,
+	.finish_fw_update	=3D elan_i2c_finish_fw_update,
+
+	.get_report		=3D elan_i2c_get_report,
+};
diff --git a/drivers/input/mouse/elan_i2c_smbus.c b/drivers/input/mouse=
/elan_i2c_smbus.c
new file mode 100644
index 0000000..e58d82b
--- /dev/null
+++ b/drivers/input/mouse/elan_i2c_smbus.c
@@ -0,0 +1,514 @@
+/*
+ * Elan I2C/SMBus Touchpad driver - SMBus interface
+ *
+ * Copyright (c) 2013 ELAN Microelectronics Corp.
+ *
+ * Author: =E6=9E=97=E6=94=BF=E7=B6=AD (Duson Lin) <dusonlin@emc.com.t=
w>
+ * Version: 1.5.5
+ *
+ * Based on cyapa driver:
+ * copyright (c) 2011-2012 Cypress Semiconductor, Inc.
+ * copyright (c) 2011-2012 Google, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modif=
y it
+ * under the terms of the GNU General Public License version 2 as publ=
ished
+ * by the Free Software Foundation.
+ *
+ * Trademarks are the property of their respective owners.
+ */
+
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+
+#include "elan_i2c.h"
+
+/* Elan SMbus commands */
+#define ETP_SMBUS_IAP_CMD		0x00
+#define ETP_SMBUS_ENABLE_TP		0x20
+#define ETP_SMBUS_SLEEP_CMD		0x21
+#define ETP_SMBUS_IAP_PASSWORD_WRITE	0x29
+#define ETP_SMBUS_IAP_PASSWORD_READ	0x80
+#define ETP_SMBUS_WRITE_FW_BLOCK	0x2A
+#define ETP_SMBUS_IAP_RESET_CMD		0x2B
+#define ETP_SMBUS_RANGE_CMD		0xA0
+#define ETP_SMBUS_FW_VERSION_CMD	0xA1
+#define ETP_SMBUS_XY_TRACENUM_CMD	0xA2
+#define ETP_SMBUS_SM_VERSION_CMD	0xA3
+#define ETP_SMBUS_UNIQUEID_CMD		0xA3
+#define ETP_SMBUS_RESOLUTION_CMD	0xA4
+#define ETP_SMBUS_HELLOPACKET_CMD	0xA7
+#define ETP_SMBUS_PACKET_QUERY		0xA8
+#define ETP_SMBUS_IAP_VERSION_CMD	0xAC
+#define ETP_SMBUS_IAP_CTRL_CMD		0xAD
+#define ETP_SMBUS_IAP_CHECKSUM_CMD	0xAE
+#define ETP_SMBUS_FW_CHECKSUM_CMD	0xAF
+#define ETP_SMBUS_MAX_BASELINE_CMD	0xC3
+#define ETP_SMBUS_MIN_BASELINE_CMD	0xC4
+#define ETP_SMBUS_CALIBRATE_QUERY	0xC5
+
+#define ETP_SMBUS_REPORT_LEN		32
+#define ETP_SMBUS_REPORT_OFFSET		2
+#define ETP_SMBUS_HELLOPACKET_LEN	5
+#define ETP_SMBUS_IAP_PASSWORD		0x1234
+#define ETP_SMBUS_IAP_MODE_ON		(1 << 6)
+
+static int elan_smbus_initialize(struct i2c_client *client)
+{
+	u8 check[ETP_SMBUS_HELLOPACKET_LEN] =3D { 0x55, 0x55, 0x55, 0x55, 0x5=
5 };
+	u8 values[ETP_SMBUS_HELLOPACKET_LEN] =3D { 0, 0, 0, 0, 0 };
+	int len, error;
+
+	/* Get hello packet */
+	len =3D i2c_smbus_read_block_data(client,
+					ETP_SMBUS_HELLOPACKET_CMD, values);
+	if (len !=3D ETP_SMBUS_HELLOPACKET_LEN) {
+		dev_err(&client->dev, "hello packet length fail: %d\n", len);
+		error =3D len < 0 ? len : -EIO;
+		return error;
+	}
+
+	/* compare hello packet */
+	if (memcmp(values, check, ETP_SMBUS_HELLOPACKET_LEN)) {
+		dev_err(&client->dev, "hello packet fail [%*px]\n",
+			ETP_SMBUS_HELLOPACKET_LEN, values);
+		return -ENXIO;
+	}
+
+	/* enable tp */
+	error =3D i2c_smbus_write_byte(client, ETP_SMBUS_ENABLE_TP);
+	if (error) {
+		dev_err(&client->dev, "failed to enable touchpad: %d\n", error);
+		return error;
+	}
+
+	return 0;
+}
+
+static int elan_smbus_set_mode(struct i2c_client *client, u8 mode)
+{
+	u8 cmd[4] =3D { 0x00, 0x07, 0x00, mode };
+
+	return i2c_smbus_write_block_data(client, ETP_SMBUS_IAP_CMD,
+					  sizeof(cmd), cmd);
+}
+
+static int elan_smbus_sleep_control(struct i2c_client *client, bool sl=
eep)
+{
+	if (sleep)
+		return i2c_smbus_write_byte(client, ETP_SMBUS_SLEEP_CMD);
+	else
+		return 0; /* XXX should we send ETP_SMBUS_ENABLE_TP here? */
+}
+
+static int elan_smbus_power_control(struct i2c_client *client, bool en=
able)
+{
+	return 0; /* A no-op */
+}
+
+static int elan_smbus_calibrate(struct i2c_client *client)
+{
+	u8 cmd[4] =3D { 0x00, 0x08, 0x00, 0x01 };
+
+	return i2c_smbus_write_block_data(client, ETP_SMBUS_IAP_CMD,
+					  sizeof(cmd), cmd);
+}
+
+static int elan_smbus_calibrate_result(struct i2c_client *client, u8 *=
val)
+{
+	int error;
+
+	error =3D i2c_smbus_read_block_data(client,
+					  ETP_SMBUS_CALIBRATE_QUERY, val);
+	if (error < 0)
+		return error;
+
+	return 0;
+}
+
+static int elan_smbus_get_baseline_data(struct i2c_client *client,
+					bool max_baseline, u8 *value)
+{
+	int error;
+	u8 val[3];
+
+	error =3D i2c_smbus_read_block_data(client,
+					  max_baseline ?
+						ETP_SMBUS_MAX_BASELINE_CMD :
+						ETP_SMBUS_MIN_BASELINE_CMD,
+					  val);
+	if (error < 0)
+		return error;
+
+	*value =3D be16_to_cpup((__be16 *)val);
+
+	return 0;
+}
+
+static int elan_smbus_get_version(struct i2c_client *client,
+				  bool iap, u8 *version)
+{
+	int error;
+	u8 val[3];
+
+	error =3D i2c_smbus_read_block_data(client,
+					  iap ? ETP_SMBUS_IAP_VERSION_CMD :
+						ETP_SMBUS_FW_VERSION_CMD,
+					  val);
+	if (error < 0) {
+		dev_err(&client->dev, "failed to get %s version: %d\n",
+			iap ? "IAP" : "FW", error);
+		return error;
+	}
+
+	*version =3D val[2];
+	return 0;
+}
+
+static int elan_smbus_get_sm_version(struct i2c_client *client, u8 *ve=
rsion)
+{
+	int error;
+	u8 val[3];
+
+	error =3D i2c_smbus_read_block_data(client,
+					  ETP_SMBUS_SM_VERSION_CMD, val);
+	if (error < 0) {
+		dev_err(&client->dev, "failed to get SM version: %d\n", error);
+		return error;
+	}
+
+	*version =3D val[0]; /* XXX Why 0 and not 2 as in IAP/FW versions? */
+	return 0;
+}
+
+static int elan_smbus_get_product_id(struct i2c_client *client, u8 *id=
)
+{
+	int error;
+	u8 val[3];
+
+	error =3D i2c_smbus_read_block_data(client,
+					  ETP_SMBUS_UNIQUEID_CMD, val);
+	if (error < 0) {
+		dev_err(&client->dev, "failed to get product ID: %d\n", error);
+		return error;
+	}
+
+	*id =3D val[1];
+	return 0;
+}
+
+static int elan_smbus_get_checksum(struct i2c_client *client,
+				   bool iap, u16 *csum)
+{
+	int error;
+	u8 val[3];
+
+	error =3D i2c_smbus_read_block_data(client,
+					  iap ? ETP_SMBUS_FW_CHECKSUM_CMD :
+						ETP_SMBUS_IAP_CHECKSUM_CMD,
+					  val);
+	if (error < 0) {
+		dev_err(&client->dev, "failed to get %s checksum: %d\n",
+			iap ? "IAP" : "FW", error);
+		return error;
+	}
+
+	*csum =3D be16_to_cpup((__be16 *)val);
+	return 0;
+}
+
+static int elan_smbus_get_max(struct i2c_client *client,
+			      unsigned int *max_x, unsigned int *max_y)
+{
+	int error;
+	u8 val[3];
+
+	error =3D i2c_smbus_read_block_data(client, ETP_SMBUS_RANGE_CMD, val)=
;
+	if (error) {
+		dev_err(&client->dev, "failed to get dimensions: %d\n", error);
+		return error;
+	}
+
+	*max_x =3D (0x0f & val[0]) << 8 | val[1];
+	*max_y =3D (0xf0 & val[0]) << 4 | val[2];
+
+	return 0;
+}
+
+static int elan_smbus_get_resolution(struct i2c_client *client,
+				     u8 *hw_res_x, u8 *hw_res_y)
+{
+	int error;
+	u8 val[3];
+
+	error =3D i2c_smbus_read_block_data(client,
+					  ETP_SMBUS_RESOLUTION_CMD, val);
+	if (error) {
+		dev_err(&client->dev, "failed to get resolution: %d\n", error);
+		return error;
+	}
+
+	*hw_res_x =3D val[1] & 0x0F;
+	*hw_res_y =3D (val[1] & 0xF0) >> 4;
+
+	return 0;
+}
+
+static int elan_smbus_get_num_traces(struct i2c_client *client,
+				     unsigned int *x_traces,
+				     unsigned int *y_traces)
+{
+	int error;
+	u8 val[3];
+
+	error =3D i2c_smbus_read_block_data(client,
+					  ETP_SMBUS_XY_TRACENUM_CMD, val);
+	if (error) {
+		dev_err(&client->dev, "failed to get trace info: %d\n", error);
+		return error;
+	}
+
+	*x_traces =3D val[1] - 1;
+	*y_traces =3D val[2] - 1;
+
+	return 0;
+}
+
+static int elan_smbus_iap_get_mode(struct i2c_client *client,
+				   enum tp_mode *mode)
+{
+	int error;
+	u16 constant;
+	u8 val[3];
+
+	error =3D i2c_smbus_read_block_data(client, ETP_SMBUS_IAP_CTRL_CMD, v=
al);
+	if (error < 0) {
+		dev_err(&client->dev, "failed to read iap ctrol register: %d\n",
+			error);
+		return error;
+	}
+
+	constant =3D be16_to_cpup((__be16 *)val);
+	dev_dbg(&client->dev, "iap control reg: 0x%04x.\n", constant);
+
+	*mode =3D (constant & ETP_SMBUS_IAP_MODE_ON) ? IAP_MODE : MAIN_MODE;
+
+	return 0;
+}
+
+static int elan_smbus_iap_reset(struct i2c_client *client)
+{
+	int error;
+
+	error =3D i2c_smbus_write_byte(client, ETP_SMBUS_IAP_RESET_CMD);
+	if (error) {
+		dev_err(&client->dev, "cannot reset IC: %d\n", error);
+		return error;
+	}
+
+	return 0;
+}
+
+static int elan_smbus_set_flash_key(struct i2c_client *client)
+{
+	int error;
+	u8 cmd[4] =3D { 0x00, 0x0B, 0x00, 0x5A };
+
+	error =3D i2c_smbus_write_block_data(client, ETP_SMBUS_IAP_CMD,
+					   sizeof(cmd), cmd);
+	if (error) {
+		dev_err(&client->dev, "cannot set flash key: %d\n", error);
+		return error;
+	}
+
+	return 0;
+}
+
+static int elan_smbus_prepare_fw_update(struct i2c_client *client)
+{
+	struct device *dev =3D &client->dev;
+	int len;
+	int error;
+	enum tp_mode mode;
+	u8 val[3];
+	u8 cmd[4] =3D {0x0F, 0x78, 0x00, 0x06};
+	u16 password;
+
+	/* Get FW in which mode	(IAP_MODE/MAIN_MODE)  */
+	error =3D elan_smbus_iap_get_mode(client, &mode);
+	if (error)
+		return error;
+
+	if (mode =3D=3D MAIN_MODE) {
+
+		/* set flash key */
+		error =3D elan_smbus_set_flash_key(client);
+		if (error)
+			return error;
+
+		/* write iap password */
+		if (i2c_smbus_write_byte(client,
+					 ETP_SMBUS_IAP_PASSWORD_WRITE) < 0) {
+			dev_err(dev, "cannot write iap password\n");
+			return -EIO;
+		}
+
+		error =3D i2c_smbus_write_block_data(client, ETP_SMBUS_IAP_CMD,
+						   sizeof(cmd), cmd);
+		if (error) {
+			dev_err(dev, "failed to write iap password: %d\n",
+				error);
+			return error;
+		}
+
+		/*
+		 * Read back password to make sure we enabled flash
+		 * successfully.
+		 */
+		len =3D i2c_smbus_read_block_data(client,
+						ETP_SMBUS_IAP_PASSWORD_READ,
+						val);
+		if (len !=3D sizeof(ETP_SMBUS_IAP_PASSWORD)) {
+			error =3D len < 0 ? len : -EIO;
+			dev_err(dev, "failed to read iap password: %d\n",
+				error);
+			return error;
+		}
+
+		password =3D be16_to_cpup((__be16 *)val);
+		if (password !=3D ETP_SMBUS_IAP_PASSWORD) {
+			dev_err(dev, "wrong iap password =3D 0x%X\n", password);
+			return -EIO;
+		}
+
+		/* Wait 30ms for MAIN_MODE change to IAP_MODE */
+		msleep(30);
+	}
+
+	error =3D elan_smbus_set_flash_key(client);
+	if (error)
+		return error;
+
+	/* Reset IC */
+	error =3D elan_smbus_iap_reset(client);
+	if (error)
+		return error;
+
+	return 0;
+}
+
+
+static int elan_smbus_write_fw_block(struct i2c_client *client,
+				     const u8 *page, u16 checksum, int idx)
+{
+	struct device *dev =3D &client->dev;
+	int error;
+	u16 result;
+	u8 val[3];
+
+	/*
+	 * Due to the limitation of smbus protocol limiting
+	 * transfer to 32 bytes at a time, we must split block
+	 * in 2 transfers.
+	 */
+	error =3D i2c_smbus_write_block_data(client,
+					   ETP_SMBUS_WRITE_FW_BLOCK,
+					   ETP_FW_PAGE_SIZE / 2,
+					   page);
+	if (error) {
+		dev_err(dev, "Failed to write page %d (part %d): %d\n",
+			idx, 1, error);
+		return error;
+	}
+
+	error =3D i2c_smbus_write_block_data(client,
+					   ETP_SMBUS_WRITE_FW_BLOCK,
+					   ETP_FW_PAGE_SIZE / 2,
+					   page + ETP_FW_PAGE_SIZE / 2);
+	if (error) {
+		dev_err(dev, "Failed to write page %d (part %d): %d\n",
+			idx, 2, error);
+		return error;
+	}
+
+
+	/* Wait for F/W to update one page ROM data. */
+	usleep_range(8000, 10000);
+
+	error =3D i2c_smbus_read_block_data(client,
+					  ETP_SMBUS_IAP_CTRL_CMD, val);
+	if (error < 0) {
+		dev_err(dev, "Failed to read IAP write result: %d\n",
+			error);
+		return error;
+	}
+
+	result =3D be16_to_cpup((__be16 *)val);
+	if (result & (ETP_FW_IAP_PAGE_ERR | ETP_FW_IAP_INTF_ERR)) {
+		dev_err(dev, "IAP reports failed write: %04hx\n",
+			result);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int elan_smbus_get_report(struct i2c_client *client, u8 *report=
)
+{
+	int len;
+
+	len =3D i2c_smbus_read_block_data(client,
+					ETP_SMBUS_PACKET_QUERY,
+					&report[ETP_SMBUS_REPORT_OFFSET]);
+	if (len < 0) {
+		dev_err(&client->dev, "failed to read report data: %d\n", len);
+		return len;
+	}
+
+	if (len !=3D ETP_SMBUS_REPORT_LEN) {
+		dev_err(&client->dev,
+			"wrong report length (%d vs %d expected)\n",
+			len, ETP_SMBUS_REPORT_LEN);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int elan_smbus_finish_fw_update(struct i2c_client *client,
+				       struct completion *fw_completion)
+{
+	/* No special handling unlike I2C transport */
+	return 0;
+}
+
+const struct elan_transport_ops elan_smbus_ops =3D {
+	.initialize		=3D elan_smbus_initialize,
+	.sleep_control		=3D elan_smbus_sleep_control,
+	.power_control		=3D elan_smbus_power_control,
+	.set_mode		=3D elan_smbus_set_mode,
+
+	.calibrate		=3D elan_smbus_calibrate,
+	.calibrate_result	=3D elan_smbus_calibrate_result,
+
+	.get_baseline_data	=3D elan_smbus_get_baseline_data,
+
+	.get_version		=3D elan_smbus_get_version,
+	.get_sm_version		=3D elan_smbus_get_sm_version,
+	.get_product_id		=3D elan_smbus_get_product_id,
+	.get_checksum		=3D elan_smbus_get_checksum,
+
+	.get_max		=3D elan_smbus_get_max,
+	.get_resolution		=3D elan_smbus_get_resolution,
+	.get_num_traces		=3D elan_smbus_get_num_traces,
+
+	.iap_get_mode		=3D elan_smbus_iap_get_mode,
+	.iap_reset		=3D elan_smbus_iap_reset,
+
+	.prepare_fw_update	=3D elan_smbus_prepare_fw_update,
+	.write_fw_block		=3D elan_smbus_write_fw_block,
+	.finish_fw_update	=3D elan_smbus_finish_fw_update,
+
+	.get_report		=3D elan_smbus_get_report,
+};
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
