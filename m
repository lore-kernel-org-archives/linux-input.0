From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: [PATCH v5 02/12] ALSA: ac97: add an ac97 bus
Date: Sun,  6 Aug 2017 23:36:03 +0200
Message-ID: <20170806213613.5600-3-robert.jarzmik@free.fr>
References: <20170806213613.5600-1-robert.jarzmik@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20170806213613.5600-1-robert.jarzmik@free.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee.jones@linaro.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

AC97 is a bus for sound usage. It enables for a AC97 AC-Link to link one
controller to 0 to 4 AC97 codecs.

The goal of this new implementation is to implement a device/driver
model for AC97, with an automatic scan of the bus and automatic
discovery of AC97 codec devices.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
Since RFCv1:
 - Takashi's review
   - changed the codec.h guard ... a better name could be found ...
   - added the AC97_* macros missing parenthesis
   - constantified the id_table in the codec driver structure
   - changed the 4 codecs linked list into an array
   - enabled the ac97 bus to be a module
   - added a slots_available to snd_ac97_controller_register() to have a
     way to prevent scanning and probing of unconnected codecs
   - removed useless ac97 bus index
   - all exported functions begin with snd_ac97_*()
   - change bus operations to controller+slot parameters instead of
     codec device

 - Mark's review
   - changed ac97_digital_controller into ac97_controller
   - rename ac97_digital_controller_*() into ac97_controller_*()
   - add the ac97 ac-link clock to the codec device (ie. the AC'97
     BIT_CLK)

Since RFCv2:
 - more snd_ac97 namespace review
 - change the compat allocation prototype to force the user to provide
   and ac97_codec_device structure pointer

Since v1:
 - took into account all Lars comments

Since v3:
 - took into account Takashi's comments (ac97bus naming and module_exit)

Since v4:
 - took into account Takashi's comments (GPL, mask match on warm reset,
   device_put(), warnings)
---
 include/sound/ac97/codec.h      | 118 +++++++++
 include/sound/ac97/compat.h     |  20 ++
 include/sound/ac97/controller.h |  85 +++++++
 sound/ac97/Kconfig              |  19 ++
 sound/ac97/Makefile             |   8 +
 sound/ac97/ac97_core.h          |  16 ++
 sound/ac97/bus.c                | 539 ++++++++++++++++++++++++++++++++++++++++
 sound/ac97/codec.c              |  15 ++
 sound/ac97/snd_ac97_compat.c    | 108 ++++++++
 9 files changed, 928 insertions(+)
 create mode 100644 include/sound/ac97/codec.h
 create mode 100644 include/sound/ac97/compat.h
 create mode 100644 include/sound/ac97/controller.h
 create mode 100644 sound/ac97/Kconfig
 create mode 100644 sound/ac97/Makefile
 create mode 100644 sound/ac97/ac97_core.h
 create mode 100644 sound/ac97/bus.c
 create mode 100644 sound/ac97/codec.c
 create mode 100644 sound/ac97/snd_ac97_compat.c

diff --git a/include/sound/ac97/codec.h b/include/sound/ac97/codec.h
new file mode 100644
index 000000000000..ec04be9ab119
--- /dev/null
+++ b/include/sound/ac97/codec.h
@@ -0,0 +1,118 @@
+/*
+ *  Copyright (C) 2016 Robert Jarzmik <robert.jarzmik@free.fr>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef __SOUND_AC97_CODEC2_H
+#define __SOUND_AC97_CODEC2_H
+
+#include <linux/device.h>
+
+#define AC97_ID(vendor_id1, vendor_id2) \
+	((((vendor_id1) & 0xffff) << 16) | ((vendor_id2) & 0xffff))
+#define AC97_DRIVER_ID(vendor_id1, vendor_id2, mask_id1, mask_id2, _data) \
+	{ .id = (((vendor_id1) & 0xffff) << 16) | ((vendor_id2) & 0xffff), \
+	  .mask = (((mask_id1) & 0xffff) << 16) | ((mask_id2) & 0xffff), \
+	  .data = (_data) }
+
+struct ac97_controller;
+struct clk;
+
+/**
+ * struct ac97_id - matches a codec device and driver on an ac97 bus
+ * @id: The significant bits if the codec vendor ID1 and ID2
+ * @mask: Bitmask specifying which bits of the id field are significant when
+ *	  matching. A driver binds to a device when :
+ *        ((vendorID1 << 8 | vendorID2) & (mask_id1 << 8 | mask_id2)) == id.
+ * @data: Private data used by the driver.
+ */
+struct ac97_id {
+	unsigned int		id;
+	unsigned int		mask;
+	void			*data;
+};
+
+/**
+ * ac97_codec_device - a ac97 codec
+ * @dev: the core device
+ * @vendor_id: the vendor_id of the codec, as sensed on the AC-link
+ * @num: the codec number, 0 is primary, 1 is first slave, etc ...
+ * @clk: the clock BIT_CLK provided by the codec
+ * @ac97_ctrl: ac97 digital controller on the same AC-link
+ *
+ * This is the device instantiated for each codec living on a AC-link. There are
+ * normally 0 to 4 codec devices per AC-link, and all of them are controlled by
+ * an AC97 digital controller.
+ */
+struct ac97_codec_device {
+	struct device		dev;
+	unsigned int		vendor_id;
+	unsigned int		num;
+	struct clk		*clk;
+	struct ac97_controller	*ac97_ctrl;
+};
+
+/**
+ * ac97_codec_driver - a ac97 codec driver
+ * @driver: the device driver structure
+ * @probe: the function called when a ac97_codec_device is matched
+ * @remove: the function called when the device is unbound/removed
+ * @shutdown: shutdown function (might be NULL)
+ * @id_table: ac97 vendor_id match table, { } member terminated
+ */
+struct ac97_codec_driver {
+	struct device_driver	driver;
+	int			(*probe)(struct ac97_codec_device *);
+	int			(*remove)(struct ac97_codec_device *);
+	void			(*shutdown)(struct ac97_codec_device *);
+	const struct ac97_id	*id_table;
+};
+
+static inline struct ac97_codec_device *to_ac97_device(struct device *d)
+{
+	return container_of(d, struct ac97_codec_device, dev);
+}
+
+static inline struct ac97_codec_driver *to_ac97_driver(struct device_driver *d)
+{
+	return container_of(d, struct ac97_codec_driver, driver);
+}
+
+#if IS_ENABLED(CONFIG_AC97_BUS_NEW)
+int snd_ac97_codec_driver_register(struct ac97_codec_driver *drv);
+void snd_ac97_codec_driver_unregister(struct ac97_codec_driver *drv);
+#else
+static inline int
+snd_ac97_codec_driver_register(struct ac97_codec_driver *drv)
+{
+	return 0;
+}
+static inline void
+snd_ac97_codec_driver_unregister(struct ac97_codec_driver *drv)
+{
+}
+#endif
+
+
+static inline struct device *
+ac97_codec_dev2dev(struct ac97_codec_device *adev)
+{
+	return &adev->dev;
+}
+
+static inline void *ac97_get_drvdata(struct ac97_codec_device *adev)
+{
+	return dev_get_drvdata(ac97_codec_dev2dev(adev));
+}
+
+static inline void ac97_set_drvdata(struct ac97_codec_device *adev,
+				    void *data)
+{
+	dev_set_drvdata(ac97_codec_dev2dev(adev), data);
+}
+
+void *snd_ac97_codec_get_platdata(const struct ac97_codec_device *adev);
+
+#endif
diff --git a/include/sound/ac97/compat.h b/include/sound/ac97/compat.h
new file mode 100644
index 000000000000..1351cba40048
--- /dev/null
+++ b/include/sound/ac97/compat.h
@@ -0,0 +1,20 @@
+/*
+ *  Copyright (C) 2016 Robert Jarzmik <robert.jarzmik@free.fr>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This file is for backward compatibility with snd_ac97 structure and its
+ * multiple usages, such as the snd_ac97_bus and snd_ac97_build_ops.
+ *
+ */
+#ifndef AC97_COMPAT_H
+#define AC97_COMPAT_H
+
+#include <sound/ac97_codec.h>
+
+struct snd_ac97 *snd_ac97_compat_alloc(struct ac97_codec_device *adev);
+void snd_ac97_compat_release(struct snd_ac97 *ac97);
+
+#endif
diff --git a/include/sound/ac97/controller.h b/include/sound/ac97/controller.h
new file mode 100644
index 000000000000..b36ecdd64f14
--- /dev/null
+++ b/include/sound/ac97/controller.h
@@ -0,0 +1,85 @@
+/*
+ *  Copyright (C) 2016 Robert Jarzmik <robert.jarzmik@free.fr>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef AC97_CONTROLLER_H
+#define AC97_CONTROLLER_H
+
+#include <linux/device.h>
+#include <linux/list.h>
+
+#define AC97_BUS_MAX_CODECS 4
+#define AC97_SLOTS_AVAILABLE_ALL 0xf
+
+struct ac97_controller_ops;
+
+/**
+ * struct ac97_controller - The AC97 controller of the AC-Link
+ * @ops:		the AC97 operations.
+ * @controllers:	linked list of all existing controllers.
+ * @adap:		the shell device ac97-%d, ie. ac97 adapter
+ * @nr:			the number of the shell device
+ * @slots_available:	the mask of accessible/scanable codecs.
+ * @parent:		the device providing the AC97 controller.
+ * @codecs:		the 4 possible AC97 codecs (NULL if none found).
+ * @codecs_pdata:	platform_data for each codec (NULL if no pdata).
+ *
+ * This structure is internal to AC97 bus, and should not be used by the
+ * controllers themselves, excepting for using @dev.
+ */
+struct ac97_controller {
+	const struct ac97_controller_ops *ops;
+	struct list_head controllers;
+	struct device adap;
+	int nr;
+	unsigned short slots_available;
+	struct device *parent;
+	struct ac97_codec_device *codecs[AC97_BUS_MAX_CODECS];
+	void *codecs_pdata[AC97_BUS_MAX_CODECS];
+};
+
+/**
+ * struct ac97_controller_ops - The AC97 operations
+ * @reset:	Cold reset of the AC97 AC-Link.
+ * @warm_reset:	Warm reset of the AC97 AC-Link.
+ * @read:	Read of a single AC97 register.
+ *		Returns the register value or a negative error code.
+ * @write:	Write of a single AC97 register.
+ *
+ * These are the basic operation an AC97 controller must provide for an AC97
+ * access functions. Amongst these, all but the last 2 are mandatory.
+ * The slot number is also known as the AC97 codec number, between 0 and 3.
+ */
+struct ac97_controller_ops {
+	void (*reset)(struct ac97_controller *adrv);
+	void (*warm_reset)(struct ac97_controller *adrv);
+	int (*write)(struct ac97_controller *adrv, int slot,
+		     unsigned short reg, unsigned short val);
+	int (*read)(struct ac97_controller *adrv, int slot, unsigned short reg);
+};
+
+#if IS_ENABLED(CONFIG_AC97_BUS_NEW)
+struct ac97_controller *snd_ac97_controller_register(
+	const struct ac97_controller_ops *ops, struct device *dev,
+	unsigned short slots_available, void **codecs_pdata);
+void snd_ac97_controller_unregister(struct ac97_controller *ac97_ctrl);
+#else
+static inline struct ac97_controller *
+snd_ac97_controller_register(const struct ac97_controller_ops *ops,
+			     struct device *dev,
+			     unsigned short slots_available,
+			     void **codecs_pdata)
+{
+	return ERR_PTR(-ENODEV);
+}
+
+static inline void
+snd_ac97_controller_unregister(struct ac97_controller *ac97_ctrl)
+{
+}
+#endif
+
+#endif
diff --git a/sound/ac97/Kconfig b/sound/ac97/Kconfig
new file mode 100644
index 000000000000..f8a64e15e5bf
--- /dev/null
+++ b/sound/ac97/Kconfig
@@ -0,0 +1,19 @@
+#
+# AC97 configuration
+#
+
+
+config AC97_BUS_NEW
+	tristate
+	select AC97
+	help
+	  This is the new AC97 bus type, successor of AC97_BUS. The ported
+	  drivers which benefit from the AC97 automatic probing should "select"
+	  this instead of the AC97_BUS.
+	  Say Y here if you want to have AC97 devices, which are sound oriented
+	  devices around an AC-Link.
+
+config AC97_BUS_COMPAT
+	bool
+	depends on AC97_BUS_NEW
+	depends on !AC97_BUS
diff --git a/sound/ac97/Makefile b/sound/ac97/Makefile
new file mode 100644
index 000000000000..f9c2640bfb59
--- /dev/null
+++ b/sound/ac97/Makefile
@@ -0,0 +1,8 @@
+#
+# make for AC97 bus drivers
+#
+
+obj-$(CONFIG_AC97_BUS_NEW)	+= ac97.o
+
+ac97-y				+= bus.o codec.o
+ac97-$(CONFIG_AC97_BUS_COMPAT)	+= snd_ac97_compat.o
diff --git a/sound/ac97/ac97_core.h b/sound/ac97/ac97_core.h
new file mode 100644
index 000000000000..08441a4fda7c
--- /dev/null
+++ b/sound/ac97/ac97_core.h
@@ -0,0 +1,16 @@
+/*
+ * Copyright (C) 2016 Robert Jarzmik <robert.jarzmik@free.fr>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+unsigned int snd_ac97_bus_scan_one(struct ac97_controller *ac97,
+				   unsigned int codec_num);
+
+static inline bool ac97_ids_match(unsigned int id1, unsigned int id2,
+				  unsigned int mask)
+{
+	return (id1 & mask) == (id2 & mask);
+}
diff --git a/sound/ac97/bus.c b/sound/ac97/bus.c
new file mode 100644
index 000000000000..31f858eceffc
--- /dev/null
+++ b/sound/ac97/bus.c
@@ -0,0 +1,539 @@
+/*
+ * Copyright (C) 2016 Robert Jarzmik <robert.jarzmik@free.fr>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/bitops.h>
+#include <linux/clk.h>
+#include <linux/device.h>
+#include <linux/idr.h>
+#include <linux/list.h>
+#include <linux/mutex.h>
+#include <linux/pm.h>
+#include <linux/pm_runtime.h>
+#include <linux/slab.h>
+#include <linux/sysfs.h>
+#include <sound/ac97/codec.h>
+#include <sound/ac97/controller.h>
+#include <sound/ac97/regs.h>
+
+#include "ac97_core.h"
+
+/*
+ * Protects ac97_controllers and each ac97_controller structure.
+ */
+static DEFINE_MUTEX(ac97_controllers_mutex);
+static DEFINE_IDR(ac97_adapter_idr);
+static LIST_HEAD(ac97_controllers);
+
+static struct bus_type ac97_bus_type;
+
+static inline struct ac97_controller*
+to_ac97_controller(struct device *ac97_adapter)
+{
+	return container_of(ac97_adapter, struct ac97_controller, adap);
+}
+
+static int ac97_unbound_ctrl_write(struct ac97_controller *adrv, int slot,
+		     unsigned short reg, unsigned short val)
+{
+	return -ENODEV;
+}
+
+static int ac97_unbound_ctrl_read(struct ac97_controller *adrv, int slot,
+				  unsigned short reg)
+{
+	return -ENODEV;
+}
+
+static const struct ac97_controller_ops ac97_unbound_ctrl_ops = {
+	.write = ac97_unbound_ctrl_write,
+	.read = ac97_unbound_ctrl_read,
+};
+
+static struct ac97_controller ac97_unbound_ctrl = {
+	.ops = &ac97_unbound_ctrl_ops,
+};
+
+static struct ac97_codec_device *
+ac97_codec_find(struct ac97_controller *ac97_ctrl, unsigned int codec_num)
+{
+	if (codec_num >= AC97_BUS_MAX_CODECS)
+		return ERR_PTR(-EINVAL);
+
+	return ac97_ctrl->codecs[codec_num];
+}
+
+static void ac97_codec_release(struct device *dev)
+{
+	struct ac97_codec_device *adev;
+	struct ac97_controller *ac97_ctrl;
+
+	adev = to_ac97_device(dev);
+	ac97_ctrl = adev->ac97_ctrl;
+	ac97_ctrl->codecs[adev->num] = NULL;
+	kfree(adev);
+}
+
+static int ac97_codec_add(struct ac97_controller *ac97_ctrl, int idx,
+		   unsigned int vendor_id)
+{
+	struct ac97_codec_device *codec;
+	int ret;
+
+	codec = kzalloc(sizeof(*codec), GFP_KERNEL);
+	if (!codec)
+		return -ENOMEM;
+	ac97_ctrl->codecs[idx] = codec;
+	codec->vendor_id = vendor_id;
+	codec->dev.release = ac97_codec_release;
+	codec->dev.bus = &ac97_bus_type;
+	codec->dev.parent = &ac97_ctrl->adap;
+	codec->num = idx;
+	codec->ac97_ctrl = ac97_ctrl;
+
+	device_initialize(&codec->dev);
+	dev_set_name(&codec->dev, "%s:%u", dev_name(ac97_ctrl->parent), idx);
+
+	ret = device_add(&codec->dev);
+	if (ret)
+		goto err_free_codec;
+
+	return 0;
+err_free_codec:
+	put_device(&codec->dev);
+	kfree(codec);
+	ac97_ctrl->codecs[idx] = NULL;
+
+	return ret;
+}
+
+unsigned int snd_ac97_bus_scan_one(struct ac97_controller *adrv,
+				   unsigned int codec_num)
+{
+	unsigned short vid1, vid2;
+	int ret;
+
+	ret = adrv->ops->read(adrv, codec_num, AC97_VENDOR_ID1);
+	vid1 = (ret & 0xffff);
+	if (ret < 0)
+		return 0;
+
+	ret = adrv->ops->read(adrv, codec_num, AC97_VENDOR_ID2);
+	vid2 = (ret & 0xffff);
+	if (ret < 0)
+		return 0;
+
+	dev_dbg(&adrv->adap, "%s(codec_num=%u): vendor_id=0x%08x\n",
+		__func__, codec_num, AC97_ID(vid1, vid2));
+	return AC97_ID(vid1, vid2);
+}
+
+static int ac97_bus_scan(struct ac97_controller *ac97_ctrl)
+{
+	int ret, i;
+	unsigned int vendor_id;
+
+	for (i = 0; i < AC97_BUS_MAX_CODECS; i++) {
+		if (ac97_codec_find(ac97_ctrl, i))
+			continue;
+		if (!(ac97_ctrl->slots_available & BIT(i)))
+			continue;
+		vendor_id = snd_ac97_bus_scan_one(ac97_ctrl, i);
+		if (!vendor_id)
+			continue;
+
+		ret = ac97_codec_add(ac97_ctrl, i, vendor_id);
+		if (ret < 0)
+			return ret;
+	}
+	return 0;
+}
+
+static int ac97_bus_reset(struct ac97_controller *ac97_ctrl)
+{
+	ac97_ctrl->ops->reset(ac97_ctrl);
+
+	return 0;
+}
+
+/**
+ * snd_ac97_codec_driver_register - register an AC97 codec driver
+ * @dev: AC97 driver codec to register
+ *
+ * Register an AC97 codec driver to the ac97 bus driver, aka. the AC97 digital
+ * controller.
+ *
+ * Returns 0 on success or error code
+ */
+int snd_ac97_codec_driver_register(struct ac97_codec_driver *drv)
+{
+	drv->driver.bus = &ac97_bus_type;
+	return driver_register(&drv->driver);
+}
+EXPORT_SYMBOL_GPL(snd_ac97_codec_driver_register);
+
+/**
+ * snd_ac97_codec_driver_unregister - unregister an AC97 codec driver
+ * @dev: AC97 codec driver to unregister
+ *
+ * Unregister a previously registered ac97 codec driver.
+ */
+void snd_ac97_codec_driver_unregister(struct ac97_codec_driver *drv)
+{
+	driver_unregister(&drv->driver);
+}
+EXPORT_SYMBOL_GPL(snd_ac97_codec_driver_unregister);
+
+/**
+ * snd_ac97_codec_get_platdata - get platform_data
+ * @adev: the ac97 codec device
+ *
+ * For legacy platforms, in order to have platform_data in codec drivers
+ * available, while ac97 device are auto-created upon probe, this retrieves the
+ * platdata which was setup on ac97 controller registration.
+ *
+ * Returns the platform data pointer
+ */
+void *snd_ac97_codec_get_platdata(const struct ac97_codec_device *adev)
+{
+	struct ac97_controller *ac97_ctrl = adev->ac97_ctrl;
+
+	return ac97_ctrl->codecs_pdata[adev->num];
+}
+EXPORT_SYMBOL_GPL(snd_ac97_codec_get_platdata);
+
+static void ac97_ctrl_codecs_unregister(struct ac97_controller *ac97_ctrl)
+{
+	int i;
+
+	for (i = 0; i < AC97_BUS_MAX_CODECS; i++)
+		if (ac97_ctrl->codecs[i]) {
+			ac97_ctrl->codecs[i]->ac97_ctrl = &ac97_unbound_ctrl;
+			device_unregister(&ac97_ctrl->codecs[i]->dev);
+		}
+}
+
+static ssize_t cold_reset_store(struct device *dev,
+				struct device_attribute *attr, const char *buf,
+				size_t len)
+{
+	struct ac97_controller *ac97_ctrl;
+
+	mutex_lock(&ac97_controllers_mutex);
+	ac97_ctrl = to_ac97_controller(dev);
+	ac97_ctrl->ops->reset(ac97_ctrl);
+	mutex_unlock(&ac97_controllers_mutex);
+	return len;
+}
+static DEVICE_ATTR_WO(cold_reset);
+
+static ssize_t warm_reset_store(struct device *dev,
+				struct device_attribute *attr, const char *buf,
+				size_t len)
+{
+	struct ac97_controller *ac97_ctrl;
+
+	if (!dev)
+		return -ENODEV;
+
+	mutex_lock(&ac97_controllers_mutex);
+	ac97_ctrl = to_ac97_controller(dev);
+	ac97_ctrl->ops->warm_reset(ac97_ctrl);
+	mutex_unlock(&ac97_controllers_mutex);
+	return len;
+}
+static DEVICE_ATTR_WO(warm_reset);
+
+static struct attribute *ac97_controller_device_attrs[] = {
+	&dev_attr_cold_reset.attr,
+	&dev_attr_warm_reset.attr,
+	NULL
+};
+
+static struct attribute_group ac97_adapter_attr_group = {
+	.name	= "ac97_operations",
+	.attrs	= ac97_controller_device_attrs,
+};
+
+static const struct attribute_group *ac97_adapter_groups[] = {
+	&ac97_adapter_attr_group,
+	NULL,
+};
+
+static void ac97_del_adapter(struct ac97_controller *ac97_ctrl)
+{
+	mutex_lock(&ac97_controllers_mutex);
+	ac97_ctrl_codecs_unregister(ac97_ctrl);
+	list_del(&ac97_ctrl->controllers);
+	mutex_unlock(&ac97_controllers_mutex);
+
+	device_unregister(&ac97_ctrl->adap);
+}
+
+static void ac97_adapter_release(struct device *dev)
+{
+	struct ac97_controller *ac97_ctrl;
+
+	ac97_ctrl = to_ac97_controller(dev);
+	idr_remove(&ac97_adapter_idr, ac97_ctrl->nr);
+	dev_dbg(&ac97_ctrl->adap, "adapter unregistered by %s\n",
+		dev_name(ac97_ctrl->parent));
+}
+
+static const struct device_type ac97_adapter_type = {
+	.groups		= ac97_adapter_groups,
+	.release	= ac97_adapter_release,
+};
+
+static int ac97_add_adapter(struct ac97_controller *ac97_ctrl)
+{
+	int ret;
+
+	mutex_lock(&ac97_controllers_mutex);
+	ret = idr_alloc(&ac97_adapter_idr, ac97_ctrl, 0, 0, GFP_KERNEL);
+	ac97_ctrl->nr = ret;
+	if (ret >= 0) {
+		dev_set_name(&ac97_ctrl->adap, "ac97-%d", ret);
+		ac97_ctrl->adap.type = &ac97_adapter_type;
+		ac97_ctrl->adap.parent = ac97_ctrl->parent;
+		ret = device_register(&ac97_ctrl->adap);
+		if (ret)
+			put_device(&ac97_ctrl->adap);
+	}
+	if (!ret)
+		list_add(&ac97_ctrl->controllers, &ac97_controllers);
+	mutex_unlock(&ac97_controllers_mutex);
+
+	if (!ret)
+		dev_dbg(&ac97_ctrl->adap, "adapter registered by %s\n",
+			dev_name(ac97_ctrl->parent));
+	return ret;
+}
+
+/**
+ * snd_ac97_controller_register - register an ac97 controller
+ * @ops: the ac97 bus operations
+ * @dev: the device providing the ac97 DC function
+ * @slots_available: mask of the ac97 codecs that can be scanned and probed
+ *                   bit0 => codec 0, bit1 => codec 1 ... bit 3 => codec 3
+ *
+ * Register a digital controller which can control up to 4 ac97 codecs. This is
+ * the controller side of the AC97 AC-link, while the slave side are the codecs.
+ *
+ * Returns a valid controller upon success, negative pointer value upon error
+ */
+struct ac97_controller *snd_ac97_controller_register(
+	const struct ac97_controller_ops *ops, struct device *dev,
+	unsigned short slots_available, void **codecs_pdata)
+{
+	struct ac97_controller *ac97_ctrl;
+	int ret, i;
+
+	ac97_ctrl = kzalloc(sizeof(*ac97_ctrl), GFP_KERNEL);
+	if (!ac97_ctrl)
+		return ERR_PTR(-ENOMEM);
+
+	for (i = 0; i < AC97_BUS_MAX_CODECS && codecs_pdata; i++)
+		ac97_ctrl->codecs_pdata[i] = codecs_pdata[i];
+
+	ac97_ctrl->ops = ops;
+	ac97_ctrl->slots_available = slots_available;
+	ac97_ctrl->parent = dev;
+	ret = ac97_add_adapter(ac97_ctrl);
+
+	if (ret)
+		goto err;
+	ac97_bus_reset(ac97_ctrl);
+	ac97_bus_scan(ac97_ctrl);
+
+	return ac97_ctrl;
+err:
+	kfree(ac97_ctrl);
+	return ERR_PTR(ret);
+}
+EXPORT_SYMBOL_GPL(snd_ac97_controller_register);
+
+/**
+ * snd_ac97_controller_unregister - unregister an ac97 controller
+ * @ac97_ctrl: the device previously provided to ac97_controller_register()
+ *
+ */
+void snd_ac97_controller_unregister(struct ac97_controller *ac97_ctrl)
+{
+	ac97_del_adapter(ac97_ctrl);
+}
+EXPORT_SYMBOL_GPL(snd_ac97_controller_unregister);
+
+#ifdef CONFIG_PM
+static int ac97_pm_runtime_suspend(struct device *dev)
+{
+	struct ac97_codec_device *codec = to_ac97_device(dev);
+	int ret = pm_generic_runtime_suspend(dev);
+
+	if (ret == 0 && dev->driver) {
+		if (pm_runtime_is_irq_safe(dev))
+			clk_disable(codec->clk);
+		else
+			clk_disable_unprepare(codec->clk);
+	}
+
+	return ret;
+}
+
+static int ac97_pm_runtime_resume(struct device *dev)
+{
+	struct ac97_codec_device *codec = to_ac97_device(dev);
+	int ret;
+
+	if (dev->driver) {
+		if (pm_runtime_is_irq_safe(dev))
+			ret = clk_enable(codec->clk);
+		else
+			ret = clk_prepare_enable(codec->clk);
+		if (ret)
+			return ret;
+	}
+
+	return pm_generic_runtime_resume(dev);
+}
+#endif /* CONFIG_PM */
+
+static const struct dev_pm_ops ac97_pm = {
+	.suspend	= pm_generic_suspend,
+	.resume		= pm_generic_resume,
+	.freeze		= pm_generic_freeze,
+	.thaw		= pm_generic_thaw,
+	.poweroff	= pm_generic_poweroff,
+	.restore	= pm_generic_restore,
+	SET_RUNTIME_PM_OPS(
+		ac97_pm_runtime_suspend,
+		ac97_pm_runtime_resume,
+		NULL)
+};
+
+static int ac97_get_enable_clk(struct ac97_codec_device *adev)
+{
+	int ret;
+
+	adev->clk = clk_get(&adev->dev, "ac97_clk");
+	if (IS_ERR(adev->clk))
+		return PTR_ERR(adev->clk);
+
+	ret = clk_prepare_enable(adev->clk);
+	if (ret)
+		clk_put(adev->clk);
+
+	return ret;
+}
+
+static void ac97_put_disable_clk(struct ac97_codec_device *adev)
+{
+	clk_disable_unprepare(adev->clk);
+	clk_put(adev->clk);
+}
+
+static ssize_t vendor_id_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
+{
+	struct ac97_codec_device *codec = to_ac97_device(dev);
+
+	return sprintf(buf, "%08x", codec->vendor_id);
+}
+DEVICE_ATTR_RO(vendor_id);
+
+static struct attribute *ac97_dev_attrs[] = {
+	&dev_attr_vendor_id.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(ac97_dev);
+
+static int ac97_bus_match(struct device *dev, struct device_driver *drv)
+{
+	struct ac97_codec_device *adev = to_ac97_device(dev);
+	struct ac97_codec_driver *adrv = to_ac97_driver(drv);
+	const struct ac97_id *id = adrv->id_table;
+	int i = 0;
+
+	if (adev->vendor_id == 0x0 || adev->vendor_id == 0xffffffff)
+		return false;
+
+	do {
+		if (ac97_ids_match(id[i].id, adev->vendor_id, id[i].mask))
+			return true;
+	} while (id[i++].id);
+
+	return false;
+}
+
+static int ac97_bus_probe(struct device *dev)
+{
+	struct ac97_codec_device *adev = to_ac97_device(dev);
+	struct ac97_codec_driver *adrv = to_ac97_driver(dev->driver);
+	int ret;
+
+	ret = ac97_get_enable_clk(adev);
+	if (ret)
+		return ret;
+
+	pm_runtime_get_noresume(dev);
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+
+	ret = adrv->probe(adev);
+	if (ret == 0)
+		return 0;
+
+	pm_runtime_disable(dev);
+	pm_runtime_set_suspended(dev);
+	pm_runtime_put_noidle(dev);
+	ac97_put_disable_clk(adev);
+
+	return ret;
+}
+
+static int ac97_bus_remove(struct device *dev)
+{
+	struct ac97_codec_device *adev = to_ac97_device(dev);
+	struct ac97_codec_driver *adrv = to_ac97_driver(dev->driver);
+	int ret;
+
+	ret = pm_runtime_get_sync(dev);
+	if (ret)
+		return ret;
+
+	ret = adrv->remove(adev);
+	pm_runtime_put_noidle(dev);
+	if (ret == 0)
+		ac97_put_disable_clk(adev);
+
+	return ret;
+}
+
+static struct bus_type ac97_bus_type = {
+	.name		= "ac97bus",
+	.dev_groups	= ac97_dev_groups,
+	.match		= ac97_bus_match,
+	.pm		= &ac97_pm,
+	.probe		= ac97_bus_probe,
+	.remove		= ac97_bus_remove,
+};
+
+static int __init ac97_bus_init(void)
+{
+	return bus_register(&ac97_bus_type);
+}
+subsys_initcall(ac97_bus_init);
+
+static void __exit ac97_bus_exit(void)
+{
+	bus_unregister(&ac97_bus_type);
+}
+module_exit(ac97_bus_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Robert Jarzmik <robert.jarzmik@free.fr>");
diff --git a/sound/ac97/codec.c b/sound/ac97/codec.c
new file mode 100644
index 000000000000..a835f03744bf
--- /dev/null
+++ b/sound/ac97/codec.c
@@ -0,0 +1,15 @@
+/*
+ *  Copyright (C) 2016 Robert Jarzmik <robert.jarzmik@free.fr>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <sound/ac97_codec.h>
+#include <sound/ac97/codec.h>
+#include <sound/ac97/controller.h>
+#include <linux/device.h>
+#include <linux/slab.h>
+#include <sound/soc.h>	/* For compat_ac97_* */
+
diff --git a/sound/ac97/snd_ac97_compat.c b/sound/ac97/snd_ac97_compat.c
new file mode 100644
index 000000000000..61544e0d8de4
--- /dev/null
+++ b/sound/ac97/snd_ac97_compat.c
@@ -0,0 +1,108 @@
+/*
+ *  Copyright (C) 2016 Robert Jarzmik <robert.jarzmik@free.fr>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/list.h>
+#include <linux/slab.h>
+#include <sound/ac97/codec.h>
+#include <sound/ac97/compat.h>
+#include <sound/ac97/controller.h>
+#include <sound/soc.h>
+
+#include "ac97_core.h"
+
+static void compat_ac97_reset(struct snd_ac97 *ac97)
+{
+	struct ac97_codec_device *adev = to_ac97_device(ac97->private_data);
+	struct ac97_controller *actrl = adev->ac97_ctrl;
+
+	if (actrl->ops->reset)
+		actrl->ops->reset(actrl);
+}
+
+static void compat_ac97_warm_reset(struct snd_ac97 *ac97)
+{
+	struct ac97_codec_device *adev = to_ac97_device(ac97->private_data);
+	struct ac97_controller *actrl = adev->ac97_ctrl;
+
+	if (actrl->ops->warm_reset)
+		actrl->ops->warm_reset(actrl);
+}
+
+static void compat_ac97_write(struct snd_ac97 *ac97, unsigned short reg,
+			      unsigned short val)
+{
+	struct ac97_codec_device *adev = to_ac97_device(ac97->private_data);
+	struct ac97_controller *actrl = adev->ac97_ctrl;
+
+	actrl->ops->write(actrl, ac97->num, reg, val);
+}
+
+static unsigned short compat_ac97_read(struct snd_ac97 *ac97,
+				       unsigned short reg)
+{
+	struct ac97_codec_device *adev = to_ac97_device(ac97->private_data);
+	struct ac97_controller *actrl = adev->ac97_ctrl;
+
+	return actrl->ops->read(actrl, ac97->num, reg);
+}
+
+static struct snd_ac97_bus_ops compat_snd_ac97_bus_ops = {
+	.reset = compat_ac97_reset,
+	.warm_reset = compat_ac97_warm_reset,
+	.write = compat_ac97_write,
+	.read = compat_ac97_read,
+};
+
+static struct snd_ac97_bus compat_soc_ac97_bus = {
+	.ops = &compat_snd_ac97_bus_ops,
+};
+
+struct snd_ac97 *snd_ac97_compat_alloc(struct ac97_codec_device *adev)
+{
+	struct snd_ac97 *ac97;
+
+	ac97 = kzalloc(sizeof(struct snd_ac97), GFP_KERNEL);
+	if (ac97 == NULL)
+		return ERR_PTR(-ENOMEM);
+
+	ac97->dev = adev->dev;
+	ac97->private_data = adev;
+	ac97->bus = &compat_soc_ac97_bus;
+	return ac97;
+}
+EXPORT_SYMBOL_GPL(snd_ac97_compat_alloc);
+
+void snd_ac97_compat_release(struct snd_ac97 *ac97)
+{
+	kfree(ac97);
+}
+EXPORT_SYMBOL_GPL(snd_ac97_compat_release);
+
+int snd_ac97_reset(struct snd_ac97 *ac97, bool try_warm, unsigned int id,
+	unsigned int id_mask)
+{
+	struct ac97_codec_device *adev = to_ac97_device(ac97->private_data);
+	struct ac97_controller *actrl = adev->ac97_ctrl;
+	unsigned int scanned;
+
+	if (try_warm) {
+		compat_ac97_warm_reset(ac97);
+		scanned = snd_ac97_bus_scan_one(actrl, adev->num);
+		if (ac97_ids_match(scanned, adev->vendor_id, id_mask))
+			return 1;
+	}
+
+	compat_ac97_reset(ac97);
+	compat_ac97_warm_reset(ac97);
+	scanned = snd_ac97_bus_scan_one(actrl, adev->num);
+	if (ac97_ids_match(scanned, adev->vendor_id, id_mask))
+		return 0;
+
+	return -ENODEV;
+}
+EXPORT_SYMBOL_GPL(snd_ac97_reset);
-- 
2.11.0
