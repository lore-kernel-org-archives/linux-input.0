From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [RFC v3] iio: input-bridge: optionally bridge iio acceleometers to create a /dev/input interface
Date: Mon, 15 Apr 2019 23:05:13 +0200
Message-ID: <d52cf9ee5944c90c69f6e74a46d844cef51e487e.1555362312.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan Cameron <jic23@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Eric Piel <eric.piel@tremplin-utc.net>, linux-input@vger.kernel.org, letux-kernel@openphoenux.org, kernel@pyra-handheld.com, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, "H. Nikolaus Schaller" <hns@goldelico.com>
List-Id: linux-input@vger.kernel.org

Some user spaces (e.g. some Android devices) use /dev/input/event* for handling
the 3D position of the device with respect to the center of gravity (earth).
This can be used for gaming input, auto-rotation of screens etc.

This interface should be the standard for such use cases because it is an abstraction
of how orientation data is acquired from sensor chips. Sensor chips may be connected
through different interfaces and in different positions. They may also have different
parameters. And, if a chip is replaced by a different one, the values reported by
the device position interface should remain the same, provided the device tree reflects
the changed chip.

This did initially lead to input accelerometer drivers like drivers/input/misc/bma150.c
or drivers/misc/lis3lv02d/

But nowadays, new accelerometer chips mostly get iio drivers and rarely input drivers.

Therefore we need something like a protocol stack which bridges raw data and input devices.
It can be seen as a similar layering like TCP/IP vs. bare Ethernet. Or keyboard
input events vs. raw gpio or raw USB access.

This patch bridges the gap between raw iio data and the input device abstraction
so that accelerometer measurements can additionally be presented as X/Y/Z accelerometer
channels (INPUT_PROP_ACCELEROMETER) through /dev/input/event*.

There are no special requirements or changes needed for an iio driver.

There is no need to define a mapping (e.g. in device tree).

This driver simply collects the first 3 accelerometer channels as X, Y and Z.
If only 1 or 2 channels are available, they are used for X and Y only. Additional
channels are ignored.

Scaling is done automatically so that 1g is represented by value 256 and
range is assumed to be -511 .. +511 which gives a reasonable precision as an
input device.

If a mount-matrix is provided by the iio driver, it is also taken into account
so that the input event automatically gets the correct orientation with respect
to the device.

If this extension is not configured into the kernel it takes no resources (except
source code).

If it is configured, but there is no accelerometer, there is only a tiny penalty
for scanning for accelerometer channels once during probe of each iio device.

If it runs, the driver polls the device(s) once every 100 ms. A mode where the
iio device defines the update rate is not implemented and for further study.

If there is no user-space client, polling is not running.

The driver is capable to handle multiple iio accelerometers and they are
presented by unique /dev/input/event* files. The iio chip name is used to define
the input device name so that it can be identified (e.g. by udev rules or evtest).

Here is some example what you can expect from the driver (device:
arch/arm/boot/dts/omap3-gta04a5.dts):

root@letux:~# dmesg|fgrep iio
[    6.324584] input: iio-bridge: bmc150_accel as /devices/platform/68000000.ocp/48072000.i2c/i2c-1/1-0010/iio:device1/input/input5
[    6.516632] input: iio-bridge: bno055 as /devices/platform/68000000.ocp/48072000.i2c/i2c-1/1-0029/iio:device3/input/input7
root@letux:~# evtest /dev/input/event5 | head -19
Input driver version is 1.0.1
Input device ID: bus 0x0 vendor 0x0 product 0x0 version 0x0
Input device name: "iio-bridge: bmc150_accel"
Supported events:
  Event type 0 (EV_SYN)
  Event type 3 (EV_ABS)
    Event code 0 (ABS_X)
      Value      8
      Min     -511
      Max      511
    Event code 1 (ABS_Y)
      Value    -44
      Min     -511
      Max      511
    Event code 2 (ABS_Z)
      Value   -265
      Min     -511
      Max      511
Properties:
root@letux:~# evtest /dev/input/event7 | head -19
Input driver version is 1.0.1
Input device ID: bus 0x0 vendor 0x0 product 0x0 version 0x0
Input device name: "iio-bridge: bno055"
Supported events:
  Event type 0 (EV_SYN)
  Event type 3 (EV_ABS)
    Event code 0 (ABS_X)
      Value     -6
      Min     -511
      Max      511
    Event code 1 (ABS_Y)
      Value     17
      Min     -511
      Max      511
    Event code 2 (ABS_Z)
      Value   -250
      Min     -511
      Max      511
Properties:
root@letux:~# 

Although the sensor chips are mounted with different axis orientation,
the application of the mount matrix provides equivalent (despite noise
and precision) information on device orientation.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>

---
V1: initial RFC version
V2:
  - rework based on comments by Jonathan Cameron
  - mainly: use input_polldev instead of using own polling timer
  - no need for checking number of open()/close()
  - no need for locks (already handled by input framework)
V3:
  - use new iio_dev->input_mapping instead of mis-using iio_dev->private
  - removed some spurious printk from debugging
  - collect channels first and then register them all in one step
  - fix issue with unsigned int type propagation in atofix()
  - simplify code for handling negative numbers
  - fix sequence in unregister
---
 drivers/iio/Kconfig                    |   8 +
 drivers/iio/Makefile                   |   1 +
 drivers/iio/industrialio-core.c        |  12 ++
 drivers/iio/industrialio-inputbridge.c | 270 +++++++++++++++++++++++++
 drivers/iio/industrialio-inputbridge.h |  28 +++
 include/linux/iio/iio.h                |   4 +
 6 files changed, 323 insertions(+)
 create mode 100644 drivers/iio/industrialio-inputbridge.c
 create mode 100644 drivers/iio/industrialio-inputbridge.h

diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
index d08aeb41cd07..2f0295da6ebc 100644
--- a/drivers/iio/Kconfig
+++ b/drivers/iio/Kconfig
@@ -68,6 +68,14 @@ config IIO_TRIGGERED_EVENT
 	help
 	  Provides helper functions for setting up triggered events.
 
+config IIO_INPUT_BRIDGE
+	depends on INPUT
+	bool "Enable accelerometer bridge to input driver"
+	help
+	  Provides a /dev/input/event* device for accelerometers
+	  to use as a 3D input device, e.g. for gaming or auto-rotation
+	  of screen contents.
+
 source "drivers/iio/accel/Kconfig"
 source "drivers/iio/adc/Kconfig"
 source "drivers/iio/afe/Kconfig"
diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
index cb5993251381..d695e5a27da5 100644
--- a/drivers/iio/Makefile
+++ b/drivers/iio/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_IIO) += industrialio.o
 industrialio-y := industrialio-core.o industrialio-event.o inkern.o
 industrialio-$(CONFIG_IIO_BUFFER) += industrialio-buffer.o
 industrialio-$(CONFIG_IIO_TRIGGER) += industrialio-trigger.o
+industrialio-$(CONFIG_IIO_INPUT_BRIDGE) += industrialio-inputbridge.o
 
 obj-$(CONFIG_IIO_CONFIGFS) += industrialio-configfs.o
 obj-$(CONFIG_IIO_SW_DEVICE) += industrialio-sw-device.o
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 4700fd5d8c90..81f412b41a78 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -29,6 +29,7 @@
 #include <linux/iio/iio.h>
 #include "iio_core.h"
 #include "iio_core_trigger.h"
+#include "industrialio-inputbridge.h"
 #include <linux/iio/sysfs.h>
 #include <linux/iio/events.h>
 #include <linux/iio/buffer.h>
@@ -1723,6 +1724,15 @@ int __iio_device_register(struct iio_dev *indio_dev, struct module *this_mod)
 	if (ret < 0)
 		goto error_unreg_eventset;
 
+	ret = iio_device_register_inputbridge(indio_dev);
+	if (ret) {
+		dev_err(indio_dev->dev.parent,
+			"Failed to register as input driver\n");
+		device_del(&indio_dev->dev);
+
+		return ret;
+	}
+
 	return 0;
 
 error_unreg_eventset:
@@ -1745,6 +1755,8 @@ void iio_device_unregister(struct iio_dev *indio_dev)
 {
 	mutex_lock(&indio_dev->info_exist_lock);
 
+	iio_device_unregister_inputbridge(indio_dev);
+
 	cdev_device_del(&indio_dev->chrdev, &indio_dev->dev);
 
 	iio_device_unregister_debugfs(indio_dev);
diff --git a/drivers/iio/industrialio-inputbridge.c b/drivers/iio/industrialio-inputbridge.c
new file mode 100644
index 000000000000..592d5ee91a30
--- /dev/null
+++ b/drivers/iio/industrialio-inputbridge.c
@@ -0,0 +1,270 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * The Industrial I/O core, bridge to input devices
+ *
+ * Copyright (c) 2016-2019 Golden Delicious Computers GmbH&Co. KG
+ */
+
+#include <linux/iio/consumer.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/types.h>
+#include <linux/input.h>
+#include <linux/input-polldev.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+
+#include "industrialio-inputbridge.h"
+
+/* currently, only polling is implemented */
+#define POLLING_MSEC	100
+
+struct iio_input_map {
+	struct input_polled_dev *poll_dev;	/* the input device */
+	struct iio_channel channels[3];		/* x, y, z channels */
+	struct matrix {
+		int mxx, myx, mzx;	/* fixed point mount-matrix */
+		int mxy, myy, mzy;
+		int mxz, myz, mzz;
+	} matrix;
+};
+
+static inline struct iio_input_map *to_iio_input_map(
+		struct iio_channel *channel)
+{
+	return (struct iio_input_map *) channel->data;
+}
+
+/* minimum and maximum range we want to report */
+#define ABSMAX_ACC_VAL		(512 - 1)
+#define ABSMIN_ACC_VAL		-(ABSMAX_ACC_VAL)
+
+/* scale processed iio values so that 1g maps to ABSMAX_ACC_VAL / 2 */
+#define SCALE			((100 * ABSMAX_ACC_VAL) / (2 * 981))
+
+/*
+ * convert float string to scaled fixed point format, e.g.
+ *   1		-> 1000		(value passed as unit)
+ *   1.23	-> 1230
+ *   0.1234	->  123
+ *   -.01234	->  -12
+ */
+
+static int32_t atofix(const char *str, uint32_t unit)
+{
+	int32_t mantissa = 0;
+	bool decimal = false;
+	int divisor = 1;
+
+	if (*str == '-')
+		divisor = -1, str++;
+	while (*str && abs(divisor) < unit) {
+		if (*str >= '0' && *str <= '9') {
+			mantissa = 10 * mantissa + (*str - '0');
+			if (decimal)
+				divisor *= 10;
+		} else if (*str == '.')
+			decimal = true;
+		else
+			return 0;	/* error */
+		str++;
+	}
+
+	return (mantissa * (int32_t) unit) / divisor;
+}
+
+static void iio_apply_matrix(struct matrix *m, int *in, int *out, int unit)
+{
+	/* apply mount matrix */
+	out[0] = (m->mxx * in[0] + m->myx * in[1] + m->mzx * in[2]) / unit;
+	out[1] = (m->mxy * in[0] + m->myy * in[1] + m->mzy * in[2]) / unit;
+	out[2] = (m->mxz * in[0] + m->myz * in[1] + m->mzz * in[2]) / unit;
+}
+
+#define FIXED_POINT_UNIT	1000	/* seems reasonable for accelerometer input */
+
+static void iio_accel_poll(struct input_polled_dev *dev)
+{
+	struct iio_input_map *map = dev->private;
+	struct input_dev *input = dev->input;
+
+	int values[3];		/* values while processing */
+	int aligned_values[3];	/* mount matrix applied */
+
+	int cindex = 0;
+
+	while (cindex < ARRAY_SIZE(values)) {
+		struct iio_channel *channel =
+			&map->channels[cindex];
+		int val;
+		int ret;
+
+		if (!channel) {
+			values[cindex] = 0;
+			continue;
+		}
+
+		ret = iio_read_channel_raw(channel, &val);
+
+		if (ret < 0) {
+			pr_err("%s(): channel read error %d\n",
+				__func__, cindex);
+			return;
+		}
+
+		ret = iio_convert_raw_to_processed(channel, val,
+				 &values[cindex], SCALE);
+
+		if (ret < 0) {
+			pr_err("%s(): channel processing error\n",
+				__func__);
+			return;
+		}
+
+		cindex++;
+	}
+
+	iio_apply_matrix(&map->matrix, values, aligned_values, FIXED_POINT_UNIT);
+
+	input_report_abs(input, ABS_X, aligned_values[0]);
+	input_report_abs(input, ABS_Y, aligned_values[1]);
+	input_report_abs(input, ABS_Z, aligned_values[2]);
+	input_sync(input);
+}
+
+static int iio_input_register_accel_channels(struct iio_dev *indio_dev,
+		 const struct iio_chan_spec *chan[], int num_channels)
+{ /* we found some accelerometer channel */
+	int ret;
+	int cindex;
+	struct input_polled_dev *poll_dev;
+	struct iio_input_map *map = indio_dev->input_mapping;
+	const struct iio_chan_spec_ext_info *ext_info;
+
+	if (unlikely(map))
+		return -EINVAL;	/* already registered */
+
+	if (num_channels < 1)
+		return 0;	/* silently ignore */
+
+	map = devm_kzalloc(&indio_dev->dev, sizeof(struct iio_input_map), GFP_KERNEL);
+	if (!map)
+		return -ENOMEM;
+
+	indio_dev->input_mapping = map;
+
+	poll_dev = devm_input_allocate_polled_device(&indio_dev->dev);
+	if (!poll_dev)
+		return -ENOMEM;
+
+	poll_dev->private = map;
+	poll_dev->poll = iio_accel_poll;
+	poll_dev->poll_interval = POLLING_MSEC;
+
+	poll_dev->input->name = kasprintf(GFP_KERNEL, "iio-bridge: %s",
+						    indio_dev->name);
+	poll_dev->input->phys = kasprintf(GFP_KERNEL, "iio:device%d",
+						    indio_dev->id);
+
+// do we need something like this?
+//	poll_dev->input->id.bustype = BUS_IIO;
+//	poll_dev->input->id.vendor = 0x0001;
+//	poll_dev->input->id.product = 0x0001;
+//	poll_dev->input->id.version = 0x0001;
+
+	set_bit(INPUT_PROP_ACCELEROMETER, poll_dev->input->propbit);
+	poll_dev->input->evbit[0] = BIT_MASK(EV_ABS);
+	input_alloc_absinfo(poll_dev->input);
+	input_set_abs_params(poll_dev->input, ABS_X, ABSMIN_ACC_VAL,
+				ABSMAX_ACC_VAL, 0, 0);
+	input_set_abs_params(poll_dev->input, ABS_Y, ABSMIN_ACC_VAL,
+				ABSMAX_ACC_VAL, 0, 0);
+	input_set_abs_params(poll_dev->input, ABS_Z, ABSMIN_ACC_VAL,
+				ABSMAX_ACC_VAL, 0, 0);
+
+	map->poll_dev = poll_dev;
+
+	ret = input_register_polled_device(poll_dev);
+
+	if (ret < 0) {
+		kfree(poll_dev->input->name);
+		kfree(poll_dev->input->phys);
+		return ret;
+	}
+
+	/* assume all channels of a device share the same matrix */
+
+	ext_info = chan[0]->ext_info;
+	while (ext_info && ext_info->name) {
+		if (strcmp(ext_info->name, "mount_matrix") == 0)
+			break;	/* found */
+		ext_info++;
+		}
+
+	if (ext_info && ext_info->name) {
+		uintptr_t priv = ext_info->private;
+		const struct iio_mount_matrix *mtx;
+
+		mtx = ((iio_get_mount_matrix_t *) priv)(indio_dev,
+							chan[0]);
+
+		map->matrix.mxx = atofix(mtx->rotation[0], FIXED_POINT_UNIT);
+		map->matrix.myx = atofix(mtx->rotation[1], FIXED_POINT_UNIT);
+		map->matrix.mzx = atofix(mtx->rotation[2], FIXED_POINT_UNIT);
+		map->matrix.mxy = atofix(mtx->rotation[3], FIXED_POINT_UNIT);
+		map->matrix.myy = atofix(mtx->rotation[4], FIXED_POINT_UNIT);
+		map->matrix.mzy = atofix(mtx->rotation[5], FIXED_POINT_UNIT);
+		map->matrix.mxz = atofix(mtx->rotation[6], FIXED_POINT_UNIT);
+		map->matrix.myz = atofix(mtx->rotation[7], FIXED_POINT_UNIT);
+		map->matrix.mzz = atofix(mtx->rotation[8], FIXED_POINT_UNIT);
+	} else {
+		map->matrix.mxx = FIXED_POINT_UNIT;
+		map->matrix.myx = 0;
+		map->matrix.mzx = 0;
+		map->matrix.mxy = 0;
+		map->matrix.myy = FIXED_POINT_UNIT;
+		map->matrix.mzy = 0;
+		map->matrix.mxz = 0;
+		map->matrix.myz = 0;
+		map->matrix.mzz = FIXED_POINT_UNIT;
+	}
+
+	for (cindex = 0; cindex < ARRAY_SIZE(map->channels); cindex++) {
+		if (cindex < num_channels)
+			map->channels[cindex].channel = chan[cindex];
+		map->channels[cindex].indio_dev = indio_dev;
+		map->channels[cindex].data = map;
+	}
+
+	return 0;
+}
+
+int iio_device_register_inputbridge(struct iio_dev *indio_dev)
+{
+	int cindex;
+	int num_channels = 0;
+	const struct iio_chan_spec *channels[3];
+
+	for (cindex = 0; cindex < indio_dev->num_channels; cindex++) {
+		const struct iio_chan_spec *chan =
+				&indio_dev->channels[cindex];
+
+		if (chan->type == IIO_ACCEL && num_channels < ARRAY_SIZE(channels))
+			channels[num_channels++] = chan;
+	}
+
+	return iio_input_register_accel_channels(indio_dev, channels, num_channels);
+}
+
+void iio_device_unregister_inputbridge(struct iio_dev *indio_dev)
+{
+	struct iio_input_map *map = iio_device_get_drvdata(indio_dev);
+	struct input_dev *input = map->poll_dev->input;
+
+	input_unregister_polled_device(map->poll_dev);
+	kfree(input->name);
+	kfree(input->phys);
+}
+
+MODULE_AUTHOR("H. Nikolaus Schaller <hns@goldelico.com>");
+MODULE_DESCRIPTION("Bridge to present Industrial I/O accelerometers as properly oriented Input devices");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/industrialio-inputbridge.h b/drivers/iio/industrialio-inputbridge.h
new file mode 100644
index 000000000000..1363b10ab3f7
--- /dev/null
+++ b/drivers/iio/industrialio-inputbridge.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * The Industrial I/O core, bridge to input devices
+ *
+ * Copyright (c) 2016-2019 Golden Delicious Computers GmbH&Co. KG
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ */
+
+#if defined(CONFIG_IIO_INPUT_BRIDGE)
+
+extern int iio_device_register_inputbridge(struct iio_dev *indio_dev);
+extern void iio_device_unregister_inputbridge(struct iio_dev *indio_dev);
+
+#else
+
+static inline int iio_device_register_inputbridge(struct iio_dev *indio_dev)
+{
+	return 0;
+}
+
+static inline void iio_device_unregister_inputbridge(struct iio_dev *indio_dev)
+{
+}
+
+#endif
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index a74cb177dc6f..a4d2f11384e9 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -524,6 +524,7 @@ struct iio_buffer_setup_ops {
  * @flags:		[INTERN] file ops related flags including busy flag.
  * @debugfs_dentry:	[INTERN] device specific debugfs dentry.
  * @cached_reg_addr:	[INTERN] cached register address for debugfs reads.
+ * @input_mapping:	[INTERN] mapping for input device
  */
 struct iio_dev {
 	int				id;
@@ -570,6 +571,9 @@ struct iio_dev {
 	struct dentry			*debugfs_dentry;
 	unsigned			cached_reg_addr;
 #endif
+#if defined(CONFIG_IIO_INPUT_BRIDGE)
+	void				*input_mapping;
+#endif
 };
 
 const struct iio_chan_spec
-- 
2.19.1
