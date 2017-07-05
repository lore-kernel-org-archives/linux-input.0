From: Anthony Kim <ktyrun@gmail.com>
Subject: [PATCH] Input: add support for HiDeep touchscreen
Date: Wed,  5 Jul 2017 15:19:48 +0900
Message-ID: <1499235588-32219-1-git-send-email-anthony.kim@hideep.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33206 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750868AbdGEGT7 (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 5 Jul 2017 02:19:59 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, devicetree@vger.kernel.org
Cc: Anthony Kim <anthony.kim@hideep.com>

The HiDeep touchscreen device is a capacitive multi-touch controller
mainly for multi-touch supported devices use. It use I2C interface for
communication to IC and provide axis X, Y, Z locations for ten finger
touch through input event interface to userspace.

It support the Crimson and the Lime two type IC. They are different
the number of channel supported and FW size. But the working protocol
is same.

Signed-off-by: Anthony Kim <anthony.kim@hideep.com>
---
 .../bindings/input/touchscreen/hideep.txt          |   40 +
 .../devicetree/bindings/vendor-prefixes.txt        |    1 +
 drivers/input/touchscreen/Kconfig                  |   32 +
 drivers/input/touchscreen/Makefile                 |    2 +
 drivers/input/touchscreen/hideep.h                 |  338 +++++++
 drivers/input/touchscreen/hideep_core.c            | 1029 ++++++++++++++++++++
 drivers/input/touchscreen/hideep_dbg.c             |  405 ++++++++
 drivers/input/touchscreen/hideep_dbg.h             |   24 +
 drivers/input/touchscreen/hideep_isp.c             |  584 +++++++++++
 drivers/input/touchscreen/hideep_isp.h             |   96 ++
 drivers/input/touchscreen/hideep_sysfs.c           |  249 +++++
 11 files changed, 2800 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/hideep.txt
 create mode 100644 drivers/input/touchscreen/hideep.h
 create mode 100644 drivers/input/touchscreen/hideep_core.c
 create mode 100644 drivers/input/touchscreen/hideep_dbg.c
 create mode 100644 drivers/input/touchscreen/hideep_dbg.h
 create mode 100644 drivers/input/touchscreen/hideep_isp.c
 create mode 100644 drivers/input/touchscreen/hideep_isp.h
 create mode 100644 drivers/input/touchscreen/hideep_sysfs.c

diff --git a/Documentation/devicetree/bindings/input/touchscreen/hideep.txt b/Documentation/devicetree/bindings/input/touchscreen/hideep.txt
new file mode 100644
index 0000000..f5ab5e6
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/hideep.txt
@@ -0,0 +1,40 @@
+* HiDeep Finger and Stylus touchscreen controller
+
+Required properties:
+- compatible		: must be "hideep,hideep_ts".
+- reg			: I2C slave address, (e.g. 0x6C).
+- hideep,max_coords	: Max value for axis X, Y, W, Z.
+
+Optional properties:
+- pinctrl-names	: "reset_down", "reset-up", "intb-ctrl".
+				They are gpio pinctrl names for should be search in driver code.
+- pinctrl-0	: Gpio control for "reset-down".
+- pinctrl-1	: Gpio control for "reset-up".
+- pinctrl-2	: Gpio control for "intb-ctrl".
+- hideep,regulator_vdd	: Main voltage(3.3V) name.
+- hideep,regulator_vid	: IO voltage(1.8V) name.
+- hideep,irq_gpio		: Define for interrupt gpio pin.
+						It is to use for set interrupt type.
+- hideep,reset_gpio		: Define for reset gpio pin.
+						It is to use for reset IC.
+
+Example:
+
+i2c@00000000 {
+
+	/* ... */
+
+	hideep@6c {
+		compatible = "hideep,hideep_ts";
+		reg = <0x6c>;
+		pinctrl-names = "reset-down", "reset-up", "intb-ctrl";
+		pinctrl-0 = <&reset_gpio0>;
+		pinctrl-1 = <&reset_gpio1>;
+		pinctrl-2 = <&touch_int>;
+		hideep,regulator_vdd = "vdd_ldo33";	// need modify
+		hideep,regulator_vid = "vdd_ldo18";	// need modify
+		hideep,irq_gpio = <&gpx0 5 0x0>;	// <gpio-name gpio-num gpio-val> need modify
+		hideep,reset_gpio = <&gpa0 5 0x1>;	// <gpio-name gpio-num gpio-val> need modify
+		hideep,max_coords = <1080 1920 65535 65535>;	// x y w z, need modify
+	};
+};
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index c03d201..aa2a301 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -131,6 +131,7 @@ gw	Gateworks Corporation
 hannstar	HannStar Display Corporation
 haoyu	Haoyu Microelectronic Co. Ltd.
 hardkernel	Hardkernel Co., Ltd
+hideep	HiDeep Inc.
 himax	Himax Technologies, Inc.
 hisilicon	Hisilicon Limited.
 hit	Hitachi Ltd.
diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 64b30fe..558f655 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -1246,4 +1246,36 @@ config TOUCHSCREEN_ROHM_BU21023
 	  To compile this driver as a module, choose M here: the
 	  module will be called bu21023_ts.
 
+config TOUCHSCREEN_HIDEEP
+	tristate "HiDeep Touch IC"
+	depends on I2C
+	help
+	  Say Y here if you have a touchscreen using HiDeep.
+
+	  If unsure, say N.
+
+	  To compile this driver as a moudle, choose M here : the
+	  module will be called hideep_ts.
+
+choice
+	prompt "Select IC"
+	depends on TOUCHSCREEN_HIDEEP
+	default TOUCHSCREEN_HIDEEP_CRIMSON
+	help
+	  This driver support two type IC.
+	  So it need to select IC.
+
+config TOUCHSCREEN_HIDEEP_CRIMSON
+	bool "Crimson Touch IC"
+	depends on TOUCHSCREEN_HIDEEP
+	help
+	  say Y to enable driver for Touchpanel using HiDeep Crimson Touch IC.
+
+config TOUCHSCREEN_HIDEEP_LIME
+	bool "Lime Touch IC"
+	depends on TOUCHSCREEN_HIDEEP
+	help
+	  say Y to enable driver for Touchpanel using HiDeep Lime Touch IC.
+endchoice
+
 endif
diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
index 6badce8..3aab466 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -103,3 +103,5 @@ obj-$(CONFIG_TOUCHSCREEN_ZET6223)	+= zet6223.o
 obj-$(CONFIG_TOUCHSCREEN_ZFORCE)	+= zforce_ts.o
 obj-$(CONFIG_TOUCHSCREEN_COLIBRI_VF50)	+= colibri-vf50-ts.o
 obj-$(CONFIG_TOUCHSCREEN_ROHM_BU21023)	+= rohm_bu21023.o
+obj-$(CONFIG_TOUCHSCREEN_HIDEEP) += hideep_ts.o
+hideep_ts-$(CONFIG_TOUCHSCREEN_HIDEEP) := hideep_core.o hideep_sysfs.o hideep_isp.o hideep_dbg.o
diff --git a/drivers/input/touchscreen/hideep.h b/drivers/input/touchscreen/hideep.h
new file mode 100644
index 0000000..3fff76d
--- /dev/null
+++ b/drivers/input/touchscreen/hideep.h
@@ -0,0 +1,338 @@
+/*
+ * Copyright (C) 2012-2017 Hideep, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2
+ * as published by the Free Software Foudation.
+ */
+
+#ifndef _LINUX_HIDEEP_H
+#define _LINUX_HIDEEP_H
+
+/*************************************************************************
+ * this is include special HEAD file.
+ *************************************************************************/
+#ifdef CONFIG_FB
+#include <linux/fb.h>
+#include <linux/notifier.h>
+#endif
+
+/*************************************************************************
+ * this is include normal HEAD file.
+ *************************************************************************/
+#include <linux/of_gpio.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/input.h>
+#include <linux/uaccess.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/proc_fs.h>
+#include <linux/regulator/consumer.h>
+#include <linux/firmware.h>
+#include <linux/pinctrl/consumer.h>
+#include <linux/pinctrl/pinctrl.h>
+#include <linux/pinctrl/machine.h>
+#include <linux/kthread.h>
+#include <linux/random.h>
+#include <linux/slab.h>
+#include <linux/sched.h>
+#include <linux/sched/rt.h>
+#include <linux/task_work.h>
+#include <linux/rtc.h>
+#include <linux/syscalls.h>
+#include <linux/timer.h>
+#include <linux/time.h>
+#include <linux/delay.h>
+#include <linux/gpio.h>
+#include <linux/hrtimer.h>
+#include <linux/i2c.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/input/mt.h>
+#include <linux/fs.h>
+#include <linux/completion.h>
+#include <linux/platform_device.h>
+#include <linux/miscdevice.h>
+#include <linux/init.h>
+#include <linux/gfp.h>
+#include <linux/kobject.h>
+#include <linux/string.h>
+#include <linux/sysfs.h>
+#include <linux/module.h>
+#include <linux/poll.h>
+#include <linux/fcntl.h>
+#include <linux/unistd.h>
+#include <linux/version.h>
+#include <linux/acpi.h>
+
+/*************************************************************************
+ * definition part.
+ * define is (open, set, enable) if not, is (close, clear, disable)
+ * some special switch of functions.
+ *************************************************************************/
+
+/* HIDEEP_PROTOCOL_2_0 is for protocol 2.0. */
+#define HIDEEP_PROTOCOL_2_0
+
+/* HIDEEP_TYPE_B_PROTOCOL is for input_dev, if define , using TYPE_B,
+ * otherwise TYPE_A.
+ */
+#define HIDEEP_TYPE_B_PROTOCOL
+
+/* HIDEEP_DWZ_VERSION_CHECK if define, it will check dwz version. */
+#define HIDEEP_DWZ_VERSION_CHECK
+
+/* HIDEEP_SUPPORT_KE if define, it will use key button. */
+#define HIDEEP_SUPPORT_KEY
+
+/* HIDEEP_SUPPORT_STYLUS if define, it will use key button. */
+#define HIDEEP_SUPPORT_STYLUS
+
+/*************************************************************************
+ * Firmware name & size.
+ *************************************************************************/
+#ifdef CONFIG_TOUCHSCREEN_HIDEEP_CRIMSON
+#define FIRMWARE_SIZE					(48 * 1024)
+#endif
+
+#ifdef CONFIG_TOUCHSCREEN_HIDEEP_LIME
+#define FIRMWARE_SIZE					(64 * 1024)
+#endif
+
+/*************************************************************************
+ * Buffer size
+ *************************************************************************/
+#define FRAME_HEADER_SIZE				8
+/* if size of system i2c buffer is smaller than this value, need to modify */
+#define MAX_I2C_BUFFER_SIZE				512
+
+/*************************************************************************
+ * board porting config
+ *************************************************************************/
+#define HIDEEP_DEBUG_DEVICE_NAME		"hideep_debug"
+#define HIDEEP_TS_NAME					"HiDeep Touchscreen"
+#define HIDEEP_I2C_NAME					"hideep_ts"
+
+/*************************************************************************
+ * register addr
+ *************************************************************************/
+/* Touch & key event */
+#define HIDEEP_EVENT_COUNT_ADDR			0x240
+#define HIDEEP_TOUCH_DATA_ADDR			0x242
+#define HIDEEP_KEY_DATA_ADDR			0x2A6
+#define HIDEEP_RAW_DATA_ADDR			0x1000
+
+/* command list */
+#define HIDEEP_RESET_CMD				0x9800
+#define HIDEEP_INTCLR_CMD				0x9802
+#define HIDEEP_OPMODE_CMD				0x9804
+#define HIDEEP_SWTICH_CMD				0x9805
+#define HIDEEP_SLEEP_CMD				0x980D
+
+/*************************************************************************
+ * multi-touch & key definitions.
+ *************************************************************************/
+#define HIDEEP_MT_MAX					10
+#define HIDEEP_KEY_MAX					3
+
+/* multi touch event bit */
+#define HIDEEP_MT_ALWAYS_REPORT			0
+#define HIDEEP_MT_TOUCHED				1
+#define HIDEEP_MT_FIRST_CONTACT			2
+#define HIDEEP_MT_DRAG_MOVE				3
+#define HIDEEP_MT_RELEASED				4
+#define HIDEEP_MT_PINCH					5
+#define HIDEEP_MT_PRESSURE				6
+
+/* key event bit */
+#define HIDEEP_KEY_RELEASED				0x20
+#define HIDEEP_KEY_PRESSED				0x40
+#define HIDEEP_KEY_FIRST_PRESSED		0x80
+#define HIDEEP_KEY_PRESSED_MASK			0xC0
+
+/*************************************************************************
+ * HIDEEP PROTOCOL
+ *************************************************************************/
+#ifdef HIDEEP_PROTOCOL_2_0
+struct hideep_mt_t {
+	unsigned short x;
+	unsigned short y;
+	unsigned short z;
+	unsigned char w;
+	unsigned char flag;
+	unsigned char type;
+	unsigned char index;
+};
+#else
+struct hideep_mt_t {
+	unsigned char flag;
+	unsigned char index;
+	unsigned short x;
+	unsigned short y;
+	unsigned char z;
+	unsigned char w;
+};
+#endif
+
+struct hideep_key_t {
+	unsigned char flag;
+	unsigned int key;
+};
+
+/*************************************************************************
+ * IC State
+ *************************************************************************/
+enum e_dev_state {
+	state_init = 1,
+	state_normal,
+	state_sleep,
+	state_updating,
+	state_debugging,
+};
+
+/*************************************************************************
+ * Firmware info
+ *************************************************************************/
+struct dwz_info_t {
+	unsigned int code_start;
+	unsigned char code_crc[12];
+
+	unsigned int c_code_start;
+	unsigned short c_code_len;
+	unsigned short gen_ver;
+
+	unsigned int vr_start;
+	unsigned short vr_len;
+	unsigned short rsv0;
+
+	unsigned int ft_start;
+	unsigned short ft_len;
+	unsigned short vr_version;
+
+	unsigned short boot_ver;
+	unsigned short core_ver;
+	unsigned short custom_ver;
+	unsigned short release_ver;
+
+	unsigned char factory_id;
+	unsigned char panel_type;
+	unsigned char model_name[6];
+	unsigned short product_code;
+	unsigned short extra_option;
+
+	unsigned short product_id;
+	unsigned short vendor_id;
+};
+
+/*************************************************************************
+ * driver information for hideep_t by device tree
+ *************************************************************************/
+struct hideep_platform_data_t {
+	unsigned int max_x;
+	unsigned int max_y;
+	unsigned int max_z;
+	unsigned int max_w;
+
+#ifdef CONFIG_OF
+	int irq_gpio;
+	int reset_gpio;
+
+	const char *regulator_vdd;
+	const char *regulator_vid;
+
+	struct regulator *vcc_vdd;
+	struct regulator *vcc_vid;
+
+	struct pinctrl *pinctrl;
+	struct pinctrl_state *reset_up;
+	struct pinctrl_state *reset_down;
+	struct pinctrl_state *intb_ctrl;
+#endif
+};
+
+struct hideep_debug_dev_t {
+	struct miscdevice misc;
+
+	wait_queue_head_t i_packet;
+
+	unsigned int ready;
+	unsigned char *vr_buff;
+	unsigned char *img_buff;
+	unsigned short vr_size;
+	unsigned short img_size;
+
+	bool debug_enable;
+	bool release_flag;
+
+	struct hideep_t *ts;
+};
+
+struct hideep_function_list_t {
+	//core
+	int (*i2c_read)(struct hideep_t *, unsigned short, unsigned short,
+		unsigned char *);
+	int (*i2c_write)(struct hideep_t *, unsigned short, unsigned short,
+		unsigned char *);
+	void (*reset_ic)(struct hideep_t *);
+	void (*power)(struct hideep_t *, int);
+
+	//isp
+	int (*update_all)(struct hideep_t *, const char *);
+	int (*update_part)(struct hideep_t *, unsigned char *, int, int, bool);
+	int (*get_dwz_info)(struct hideep_t *);
+	void (*sp_func)(struct hideep_t *, unsigned char *, int, int);
+};
+
+struct hideep_t {
+	struct i2c_client *client;
+	struct input_dev *input_dev;
+	struct hideep_platform_data_t *p_data;
+
+	struct mutex dev_mutex;
+	struct mutex i2c_mutex;
+
+	struct hideep_debug_dev_t debug_dev;
+	struct hideep_function_list_t *hideep_api;
+
+	struct task_struct *hthread_event;
+
+	bool suspended;
+	enum e_dev_state dev_state;
+
+#ifdef CONFIG_FB
+	struct notifier_block fb_notif;
+#endif
+
+	long tch_bit;
+	unsigned int tch_count;
+	unsigned int key_count;
+	unsigned int lpm_count;
+
+	struct hideep_mt_t touch_evt[HIDEEP_MT_MAX];
+
+#ifdef HIDEEP_SUPPORT_KEY
+	struct hideep_key_t key_evt[HIDEEP_KEY_MAX];
+	int key_codes[HIDEEP_KEY_MAX];
+#endif
+
+
+	unsigned char i2c_buf[256];
+	struct dwz_info_t *dwz_info;
+
+	int interrupt_state;
+};
+
+/*************************************************************************
+ * function define
+ *************************************************************************/
+int hideep_debug_init(struct hideep_t *ts);
+void hideep_debug_uninit(void);
+
+int hideep_sysfs_init(struct hideep_t *ts);
+int hideep_sysfs_exit(struct hideep_t *ts);
+
+void hideep_isp_init(struct hideep_t *ts);
+
+#endif
diff --git a/drivers/input/touchscreen/hideep_core.c b/drivers/input/touchscreen/hideep_core.c
new file mode 100644
index 0000000..7803c68
--- /dev/null
+++ b/drivers/input/touchscreen/hideep_core.c
@@ -0,0 +1,1029 @@
+/*
+ * Copyright (C) 2012-2017 Hideep, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2
+ * as published by the Free Software Foudation.
+ */
+
+#include "hideep.h"
+
+#define GET_PAYLOAD_SIZE_FROM_HEADER(x) \
+	((x[1]>>6) ? ((x[2]*256+x[3])*(x[7]+1)):(x[2]*x[3]*(x[7]+1)))
+
+static int hideep_pwr_on(struct hideep_t *ts)
+{
+	struct hideep_platform_data_t *pdata;
+	int ret = 0;
+
+	pdata = ts->p_data;
+
+#ifdef CONFIG_OF
+	if ((!IS_ERR(pdata->vcc_vdd)) && (pdata->regulator_vdd != NULL)) {
+		dev_info(&ts->client->dev, "hideep:vcc_vdd is enable");
+		ret = regulator_enable(pdata->vcc_vdd);
+		if (ret)
+			dev_err(&ts->client->dev,
+				"Regulator vdd enable failed ret=%d", ret);
+	}
+	usleep_range(999, 1000);
+
+	if ((!IS_ERR(pdata->vcc_vid)) && (pdata->regulator_vid != NULL)) {
+		dev_info(&ts->client->dev, "hideep:vcc_vid is enable");
+		ret = regulator_enable(pdata->vcc_vid);
+		if (ret)
+			dev_err(&ts->client->dev,
+				"Regulator vcc_vid enable failed ret=%d", ret);
+	}
+	usleep_range(2999, 3000);
+
+	if (pdata->reset_gpio > 0) {
+		dev_info(&ts->client->dev, "hideep:enable the reset_gpio");
+		ret = pinctrl_select_state(pdata->pinctrl, pdata->reset_up);
+		if (ret < 0)
+			dev_err(&ts->client->dev, "can not reset pin control!!!");
+	}
+#endif
+
+	return ret;
+}
+
+static int hideep_pwr_off(struct hideep_t *ts)
+{
+	struct hideep_platform_data_t *pdata;
+	int ret = 0;
+
+	pdata = ts->p_data;
+
+#ifdef CONFIG_OF
+	if (pdata->reset_gpio > 0) {
+		dev_info(&ts->client->dev, "hideep:disable the reset_gpio");
+
+		ret = pinctrl_select_state(pdata->pinctrl, pdata->reset_down);
+		if (ret < 0)
+			dev_err(&ts->client->dev, "can not reset pin control!!!");
+	}
+
+	if (!IS_ERR(pdata->vcc_vid) && (pdata->regulator_vid != NULL)) {
+		dev_info(&ts->client->dev, "hideep:vcc_vid is disable");
+		ret = regulator_disable(pdata->vcc_vid);
+		if (ret)
+			dev_err(&ts->client->dev,
+				"Regulator vcc_vid enable failed ret=%d", ret);
+	}
+
+	if (!IS_ERR(pdata->vcc_vdd) && (pdata->regulator_vdd != NULL)) {
+		dev_info(&ts->client->dev, "hideep:vcc_vdd is disable");
+		ret = regulator_disable(pdata->vcc_vdd);
+		if (ret)
+			dev_err(&ts->client->dev,
+				"Regulator vdd disable failed ret=%d", ret);
+	}
+#endif
+	return ret;
+}
+
+static void hideep_power(struct hideep_t *ts, int on)
+{
+	int ret = 0;
+
+	if (on) {
+		dev_info(&ts->client->dev, "power on");
+		ret = hideep_pwr_on(ts);
+	} else {
+		dev_info(&ts->client->dev, "power off");
+		ret = hideep_pwr_off(ts);
+	}
+}
+
+static int hideep_i2c_read(struct hideep_t *ts, unsigned short addr,
+	unsigned short len, unsigned char *buf)
+{
+	int ret = -1;
+	unsigned short r_len, raddr;
+	int length;
+
+	length = len;
+	raddr = addr;
+
+	dev_dbg(&ts->client->dev, "addr = 0x%02x, len = %d", addr, len);
+
+	mutex_lock(&ts->i2c_mutex);
+
+	do {
+		if (length > MAX_I2C_BUFFER_SIZE)
+			r_len = MAX_I2C_BUFFER_SIZE;
+		else
+			r_len = length;
+
+		dev_dbg(&ts->client->dev, "addr = 0x%02x, len = %d",
+			raddr, r_len);
+
+		ret = i2c_master_send(ts->client, (char *)&raddr, 2);
+
+		if (ret < 0)
+			goto i2c_err;
+
+		ret = i2c_master_recv(ts->client, (char *)buf, r_len);
+		length -= MAX_I2C_BUFFER_SIZE;
+		buf += MAX_I2C_BUFFER_SIZE;
+		raddr += MAX_I2C_BUFFER_SIZE;
+
+		if (ret < 0)
+			goto i2c_err;
+	} while (length > 0);
+
+	mutex_unlock(&ts->i2c_mutex);
+
+	return  0;
+i2c_err:
+	mutex_unlock(&ts->i2c_mutex);
+	return -1;
+}
+
+static int hideep_i2c_write(struct hideep_t *ts, unsigned short addr,
+	unsigned short len, unsigned char *buf)
+{
+	int ret = -1;
+
+	dev_dbg(&ts->client->dev, "addr = 0x%02x, len = %d", addr, len);
+
+	mutex_lock(&ts->i2c_mutex);
+
+	// data mangling..
+	ts->i2c_buf[0] = (addr >> 0) & 0xFF;
+	ts->i2c_buf[1] = (addr >> 8) & 0xFF;
+	memcpy(&ts->i2c_buf[2], buf, len);
+
+	ret = i2c_master_send(ts->client, (char *)ts->i2c_buf, len + 2);
+
+	if (ret < 0)
+		goto i2c_err;
+
+	mutex_unlock(&ts->i2c_mutex);
+	return  0;
+
+i2c_err:
+	mutex_unlock(&ts->i2c_mutex);
+	return -1;
+}
+
+#define __GET_MT_TOOL_TYPE(X) ((X == 0x01) ? MT_TOOL_FINGER : MT_TOOL_PEN)
+
+static void pops_mt(struct hideep_t *ts)
+{
+#ifdef HIDEEP_TYPE_B_PROTOCOL
+	int id;
+	int i;
+
+	for (i = 0; i < ts->tch_count; i++) {
+		id = (ts->touch_evt[i].index >> 0) & 0x0F;
+		input_mt_slot(ts->input_dev, id);
+		input_mt_report_slot_state(ts->input_dev,
+			__GET_MT_TOOL_TYPE(ts->touch_evt[i].type), false);
+		input_report_key(ts->input_dev, BTN_TOUCH, false);
+	}
+#else
+	input_report_key(ts->input_dev, BTN_TOUCH, false);
+	input_mt_sync(ts->input_dev);
+#endif
+
+	input_sync(ts->input_dev);
+}
+
+static void push_mt(struct hideep_t *ts)
+{
+	int id;
+	int i;
+	bool btn_up = 0;
+	bool btn_dn = 0;
+	bool btn_mv = 0;
+	int evt = 0;
+
+	/* load multi-touch event to input system */
+	for (i = 0; i < ts->tch_count; i++) {
+		id = (ts->touch_evt[i].index >> 0) & 0x0F;
+		btn_up = (ts->touch_evt[i].flag >> HIDEEP_MT_RELEASED) & 0x01;
+		btn_dn = (ts->touch_evt[i].flag >> HIDEEP_MT_FIRST_CONTACT)
+			& 0x01;
+		btn_mv = (ts->touch_evt[i].flag >> HIDEEP_MT_DRAG_MOVE) & 0x01;
+
+		if (btn_up)
+			clear_bit(id, &ts->tch_bit);
+		else
+			__set_bit(id, &ts->tch_bit);
+
+		dev_dbg(&ts->client->dev,
+			"type = %d, id = %d, i = %d, x = %d, y = %d, z = %d",
+			ts->touch_evt[i].type, ts->touch_evt[i].index,
+			i, ts->touch_evt[i].x, ts->touch_evt[i].y,
+			ts->touch_evt[i].z);
+
+#ifdef HIDEEP_TYPE_B_PROTOCOL
+		input_mt_slot(ts->input_dev, id);
+		input_mt_report_slot_state(ts->input_dev,
+			__GET_MT_TOOL_TYPE(ts->touch_evt[i].type),
+			(btn_up == 0));
+
+		if (btn_up == 0) {
+			input_report_abs(ts->input_dev, ABS_MT_POSITION_X,
+				ts->touch_evt[i].x);
+			input_report_abs(ts->input_dev, ABS_MT_POSITION_Y,
+				ts->touch_evt[i].y);
+			input_report_abs(ts->input_dev, ABS_MT_PRESSURE,
+				ts->touch_evt[i].z);
+			input_report_abs(ts->input_dev, ABS_MT_TOUCH_MAJOR,
+				ts->touch_evt[i].w);
+			evt++;
+		}
+#else
+		if (btn_up) {
+			input_mt_sync(ts->input_dev);
+		} else {
+			input_report_abs(ts->input_dev, ABS_MT_TRACKING_ID, id);
+			input_report_abs(ts->input_dev, ABS_MT_POSITION_X,
+				ts->touch_evt[i].x);
+			input_report_abs(ts->input_dev, ABS_MT_POSITION_Y,
+				ts->touch_evt[i].y);
+			input_report_abs(ts->input_dev, ABS_MT_PRESSURE,
+				ts->touch_evt[i].z);
+			input_report_abs(ts->input_dev, ABS_MT_TOUCH_MAJOR,
+				ts->touch_evt[i].w);
+			input_mt_sync(ts->input_dev);
+			evt++;
+		}
+#endif
+	}
+
+	if (ts->tch_bit == 0)
+		evt = 0;
+
+	input_report_key(ts->input_dev, BTN_TOUCH, evt);
+	input_mt_sync_frame(ts->input_dev);
+	input_sync(ts->input_dev);
+}
+
+#ifdef HIDEEP_SUPPORT_KEY
+static void pops_ky(struct hideep_t *ts)
+{
+	int i;
+
+	for (i = 0; i < ts->tch_count; i++) {
+		input_report_key(ts->input_dev, ts->key_codes[i], false);
+		input_report_key(ts->input_dev, BTN_TOUCH, false);
+	}
+
+	input_sync(ts->input_dev);
+}
+
+static void push_ky(struct hideep_t *ts)
+{
+	int i;
+	int pressed;
+	int key_code;
+	int key_status;
+
+	for (i = 0; i < ts->key_count; i++) {
+		key_code = ts->key_evt[i].flag & 0x0F;
+		key_status = ts->key_evt[i].flag & 0xF0;
+		pressed = false;
+
+		if (key_status & HIDEEP_KEY_PRESSED_MASK)
+			pressed = true;
+		else
+			pressed = false;
+
+		input_report_key(ts->input_dev, ts->key_codes[key_code],
+			pressed);
+		input_report_key(ts->input_dev, BTN_TOUCH, pressed);
+	}
+
+	input_sync(ts->input_dev);
+}
+#endif
+
+static void hideep_put_event(struct hideep_t *ts)
+{
+	/* mangling touch information */
+	if (ts->tch_count > 0)
+		push_mt(ts);
+
+#ifdef HIDEEP_SUPPORT_KEY
+	if (ts->key_count > 0)
+		push_ky(ts);
+#endif
+}
+
+static int hideep_get_event(struct hideep_t *ts)
+{
+	int ret;
+	int touch_count;
+	int info_size;
+
+
+	/* get touch event count */
+	dev_dbg(&ts->client->dev, "mt = %d, key = %d, lpm = %02x",
+		ts->tch_count, ts->key_count, ts->lpm_count);
+
+	/* get touch event information */
+	if (ts->tch_count > HIDEEP_MT_MAX)
+		ts->tch_count = 0;
+
+	if (ts->key_count > HIDEEP_KEY_MAX)
+		ts->key_count = 0;
+
+	touch_count = ts->tch_count + ts->key_count;
+
+	if (ts->tch_count > 0) {
+		info_size = ts->tch_count * sizeof(struct hideep_mt_t);
+		ret = hideep_i2c_read(ts, HIDEEP_TOUCH_DATA_ADDR,
+			info_size, (unsigned char *)ts->touch_evt);
+		if (ret < 0) {
+			dev_err(&ts->client->dev, "read I2C error.");
+			return -1;
+		}
+	}
+
+#ifdef HIDEEP_SUPPORT_KEY
+	if (ts->key_count > 0) {
+		info_size = ts->key_count * sizeof(struct hideep_key_t);
+		ret = hideep_i2c_read(ts, HIDEEP_KEY_DATA_ADDR,
+			info_size, (unsigned char *)ts->key_evt);
+		if (ret < 0) {
+			dev_err(&ts->client->dev, "read I2C error.");
+			return -1;
+		}
+	}
+#endif
+
+	return touch_count;
+}
+
+static int hideep_event_thread(void *arg)
+{
+	int t_evt;
+
+	struct hideep_t *ts = arg;
+
+	dev_info(&ts->client->dev, "start event thread");
+	// sched_setscheduler(current, SCHED_FIFO, ts->param);
+
+	while (!kthread_should_stop()) {
+		set_current_state(TASK_INTERRUPTIBLE);
+
+		schedule();
+
+		t_evt = hideep_get_event(ts);
+
+		if (t_evt >= 0)
+			hideep_put_event(ts);
+
+		if (kthread_should_stop())
+			break;
+	}
+
+	dev_info(&ts->client->dev, "end thread");
+	return 0;
+}
+
+static irqreturn_t hideep_irq_task(int irq, void *handle)
+{
+	unsigned char i2c_buff[2];
+	int ret;
+
+	struct hideep_t *ts = (struct hideep_t *) handle;
+
+	dev_dbg(&ts->client->dev, "state = 0x%x, debug = %d",
+		ts->dev_state, ts->debug_dev.debug_enable);
+
+	if (ts->debug_dev.debug_enable == false &&
+		ts->dev_state == state_normal) {
+		ret = hideep_i2c_read(ts, HIDEEP_EVENT_COUNT_ADDR,
+			2, (u8 *)&i2c_buff);
+		if (ret < 0) {
+			disable_irq(ts->client->irq);
+			ts->interrupt_state = 0;
+			return IRQ_HANDLED;
+		}
+
+		ts->tch_count = i2c_buff[0];
+		ts->key_count = i2c_buff[1] & 0x0f;
+		ts->lpm_count = i2c_buff[1] & 0xf0;
+
+		wake_up_process(ts->hthread_event);
+
+	} else if (ts->debug_dev.debug_enable == true
+		&& ts->dev_state == state_debugging) {
+		ret = ts->hideep_api->i2c_read(ts, HIDEEP_RAW_DATA_ADDR,
+			FRAME_HEADER_SIZE + ts->debug_dev.img_size,
+			ts->debug_dev.img_buff);
+		ts->debug_dev.img_size =
+			GET_PAYLOAD_SIZE_FROM_HEADER(ts->debug_dev.img_buff);
+		ts->debug_dev.ready = 1;
+		wake_up_interruptible(&ts->debug_dev.i_packet);
+	}
+	dev_dbg(&ts->client->dev, "end.");
+
+	return IRQ_HANDLED;
+}
+
+static int hideep_capability(struct hideep_t *ts)
+{
+#ifdef HIDEEP_SUPPORT_KEY
+	int i;
+
+	ts->key_codes[0] = KEY_MENU;
+	ts->key_codes[1] = KEY_HOME;
+	ts->key_codes[2] = KEY_BACK;
+
+	for (i = 0; i < HIDEEP_KEY_MAX; i++)
+		set_bit(ts->key_codes[i], ts->input_dev->keybit);
+#endif
+
+	ts->input_dev->name = HIDEEP_TS_NAME;
+	ts->input_dev->id.bustype = BUS_I2C;
+
+	set_bit(EV_ABS, ts->input_dev->evbit);
+	set_bit(EV_KEY, ts->input_dev->evbit);
+	set_bit(EV_SYN, ts->input_dev->evbit);
+	set_bit(BTN_TOUCH, ts->input_dev->keybit);
+	set_bit(MT_TOOL_FINGER, ts->input_dev->keybit);
+	set_bit(INPUT_PROP_DIRECT, ts->input_dev->propbit);
+
+	input_set_abs_params(ts->input_dev, ABS_X, 0, ts->p_data->max_x, 0, 0);
+	input_set_abs_params(ts->input_dev, ABS_Y, 0, ts->p_data->max_y, 0, 0);
+	input_set_abs_params(ts->input_dev, ABS_PRESSURE, 0,
+		ts->p_data->max_z, 0, 0);
+
+#ifdef HIDEEP_TYPE_B_PROTOCOL
+	input_mt_init_slots(ts->input_dev,
+		HIDEEP_MT_MAX, INPUT_MT_DIRECT);
+#else
+	input_set_abs_params(ts->input_dev,
+		ABS_MT_TRACKING_ID, 0, 10, 0, 0);
+#endif
+	input_set_abs_params(ts->input_dev,
+		ABS_MT_TOOL_TYPE, 0, MT_TOOL_MAX, 0, 0);
+	input_set_abs_params(ts->input_dev,
+		ABS_MT_POSITION_X, 0, ts->p_data->max_x - 1, 0, 0);
+	input_set_abs_params(ts->input_dev,
+		ABS_MT_POSITION_Y, 0, ts->p_data->max_y - 1, 0, 0);
+	input_set_abs_params(ts->input_dev,
+		ABS_MT_PRESSURE, 0, ts->p_data->max_z, 0, 0);
+	input_set_abs_params(ts->input_dev,
+		ABS_MT_TOUCH_MAJOR, 0, ts->p_data->max_w, 0, 0);
+
+	return 0;
+}
+
+static void hideep_reset_ic(struct hideep_t *ts)
+{
+	struct hideep_platform_data_t *pdata;
+	int ret;
+	unsigned char cmd = 0x01;
+
+	pdata = ts->p_data;
+
+	dev_info(&ts->client->dev, "start!!");
+
+#ifdef CONFIG_OF
+	if (pdata->reset_gpio > 0) {
+		dev_info(&ts->client->dev, "hideep:enable the reset_gpio");
+		// up, down, up
+		ret = pinctrl_select_state(pdata->pinctrl, pdata->reset_up);
+
+		if (ret < 0) {
+			dev_err(&ts->client->dev, "can not reset pin control!!!");
+		} else {
+			mdelay(1);    //modified
+			ret = pinctrl_select_state(pdata->pinctrl,
+				pdata->reset_down);
+
+			if (ret < 0) {
+				dev_err(&ts->client->dev, "can not reset pin control!!!");
+			} else {
+				mdelay(20);    //modified
+				ret = pinctrl_select_state(pdata->pinctrl,
+					pdata->reset_up);
+				if (ret < 0)
+					dev_err(&ts->client->dev, "can not reset pin control!!!");
+			}
+		}
+	} else
+#endif
+	{
+		ret = hideep_i2c_write(ts, HIDEEP_RESET_CMD, 1, &cmd);
+	}
+	mdelay(50);
+	dev_info(&ts->client->dev, "end!!");
+}
+
+static void hideep_get_info(struct hideep_t *ts)
+{
+	struct hideep_platform_data_t *pdata;
+	unsigned char val[4];
+
+	pdata = ts->p_data;
+	ts->hideep_api->i2c_read(ts, 0x28, 4, val);
+
+	pdata->max_x = val[3] << 8 | val[2];
+	pdata->max_y = val[1] << 8 | val[0];
+	pdata->max_w = 255;
+	pdata->max_z = 255;
+
+	dev_info(&ts->client->dev, "X : %d, Y : %d",
+		pdata->max_x, pdata->max_y);
+}
+
+static void hideep_init_ic(struct hideep_t *ts)
+{
+	struct hideep_platform_data_t *pdata;
+	struct device dev;
+
+	pdata = ts->p_data;
+	dev = ts->client->dev;
+
+#ifdef CONFIG_OF
+	/* regulator get */
+	if (pdata->regulator_vdd != NULL) {
+		pdata->vcc_vdd = regulator_get(&dev,
+			pdata->regulator_vdd);   // main valtage
+		if (IS_ERR(pdata->vcc_vdd)) {
+			ret = PTR_ERR(pdata->vcc_vdd);
+			dev_err(&dev, "Regulator get vcc_vdd ret=%d", ret);
+		}
+	}
+
+	if (pdata->regulator_vid != NULL) {
+		pdata->vcc_vid = regulator_get(&dev,
+			pdata->regulator_vid);   // I/O voltage
+		if (IS_ERR(pdata->vcc_vid)) {
+			ret = PTR_ERR(pdata->vcc_vid);
+			dev_info(&dev, "Regulator get vcc_vid ret=%d", ret);
+		}
+	}
+
+	if (pdata->reset_gpio > 0) {
+		if (gpio_is_valid(pdata->reset_gpio)) {
+			ret = gpio_request(pdata->reset_gpio, "reset_gpio");
+			if (ret)
+				dev_err(&dev, "unable to request gpio [%d]",
+					pdata->reset_gpio);
+		} else {
+			dev_err(&dev, "reset[%d] is used by other device",
+				pdata->reset_gpio);
+		}
+	}
+#endif
+
+	/* power on */
+	ts->hideep_api->power(ts, true);
+	ts->dev_state = state_init;
+	mdelay(30);
+
+#ifdef CONFIG_OF
+	/* interrupt pin set */
+	ret = pinctrl_select_state(pdata->pinctrl, pdata->intb_ctrl);
+	if (ret < 0)
+		dev_err(&dev, "can not intb pin setting!!!!");
+#endif
+	/* ic reset */
+	ts->hideep_api->reset_ic(ts);
+}
+
+static int hideep_resume(struct device *dev)
+{
+	struct hideep_t *ts = dev_get_drvdata(dev);
+	unsigned char sleep_cmd = 0x00;
+
+	dev_info(dev, "enter");
+
+	mutex_lock(&ts->dev_mutex);
+
+	if (ts->dev_state == state_normal)
+		goto hideep_resume_exit;
+
+	dev_info(dev, "not waiting.");
+	ts->dev_state = state_normal;
+
+	hideep_i2c_write(ts, HIDEEP_SLEEP_CMD, 1, &sleep_cmd);
+	enable_irq(ts->client->irq);
+	ts->interrupt_state = 1;
+
+hideep_resume_exit:
+	mdelay(10);
+	ts->hideep_api->reset_ic(ts);
+
+	mutex_unlock(&ts->dev_mutex);
+	dev_info(dev, "exit.");
+	return 0;
+}
+
+static int hideep_suspend(struct device *dev)
+{
+	struct hideep_t *ts = dev_get_drvdata(dev);
+	unsigned char sleep_cmd = 0x01;
+
+	dev_info(dev, "enter");
+
+	mutex_lock(&ts->dev_mutex);
+	if (ts->dev_state == state_sleep)
+		goto hideep_suspend_exit;
+
+	dev_info(dev, "not waiting.");
+	ts->dev_state = state_sleep;
+
+	/* send sleep command.. */
+	pops_mt(ts);
+#ifdef HIDEEP_SUPPORT_KEY
+	pops_ky(ts);
+#endif
+
+	/* default deep sleep */
+	hideep_i2c_write(ts, HIDEEP_SLEEP_CMD, 1, &sleep_cmd);
+	disable_irq(ts->client->irq);
+	ts->interrupt_state = 0;
+
+hideep_suspend_exit:
+	mutex_unlock(&ts->dev_mutex);
+	dev_info(dev, "exit.");
+	return 0;
+}
+
+#ifdef CONFIG_FB
+static int fb_notifier_callback(struct notifier_block *self,
+	unsigned long event, void *data)
+{
+	struct fb_event *evdata = data;
+	int *blank;
+
+	struct hideep_t *ts = container_of(self, struct hideep_t, fb_notif);
+
+	if ((evdata) && (evdata->data) &&
+		(event == FB_EVENT_BLANK) &&
+		(ts) && (ts->client)) {
+		blank = evdata->data;
+		if (*blank == FB_BLANK_UNBLANK) {
+			dev_info(&ts->client->dev, "resume");
+			if (ts->suspended == 1) {
+				hideep_resume(&ts->client->dev);
+				ts->suspended = 0;
+			}
+		} else if (*blank == FB_BLANK_POWERDOWN) {
+			dev_info(&ts->client->dev, "suspend");
+			if (ts->suspended == 0) {
+				ts->suspended = 1;
+				hideep_suspend(&ts->client->dev);
+			}
+		}
+	}
+
+	return 0;
+}
+#endif
+
+#ifdef CONFIG_OF
+static int hideep_parse_dts(struct device *dev,
+	struct hideep_platform_data_t *pdata)
+{
+	int ret = 0;
+	unsigned int coords[4];
+	struct device_node *np;
+
+	dev_info(dev, "enter");
+	np = dev->of_node;
+
+	ret = of_property_read_u32_array(np, "hideep,max_coords", coords, 4);
+	if (ret) {
+		dev_err(dev, "Failed to get max_coords property\n");
+		return ret;
+	}
+
+	pdata->max_x = coords[0];
+	pdata->max_y = coords[1];
+	pdata->max_w = coords[2];
+	pdata->max_z = coords[3];
+
+	dev_info(dev, "max coord data x : %d\n", pdata->max_x);
+	dev_info(dev, "max coord data y : %d\n", pdata->max_y);
+	dev_info(dev, "max coord data w : %d\n", pdata->max_w);
+	dev_info(dev, "max coord data z : %d\n", pdata->max_z);
+
+	/* device tree information get */
+	pdata->irq_gpio = of_get_named_gpio(np,
+		"hideep,irq_gpio", 0);
+	dev_info(dev, "irq_gpio = %d, is %s specified",
+		pdata->irq_gpio, pdata->irq_gpio < 0 ? "not" : "");
+
+	pdata->reset_gpio = of_get_named_gpio(np,
+		"hideep,reset_gpio", 0);
+	dev_info(dev, "reset_gpio = %d, is %s specified",
+		pdata->reset_gpio, pdata->reset_gpio < 0 ? "not" : "");
+
+	ret = of_property_read_string(np, "hideep,regulator_vid",
+		&pdata->regulator_vid);
+	if (ret)
+		dev_err(dev, "Failed to get regulator vid");
+	else
+		dev_info(dev, "p_data->regulator_vid = %s",
+			pdata->regulator_vid);
+
+	ret = of_property_read_string(np, "hideep,regulator_vdd",
+		&pdata->regulator_vdd);
+	if (ret)
+		dev_err(dev, "Failed to get regulator vdd");
+	else
+		dev_info(dev, "p_data->regulator_vdd = %s",
+			pdata->regulator_vdd);
+
+	pdata->pinctrl = devm_pinctrl_get(dev);
+
+	if (IS_ERR(pdata->pinctrl)) {
+		dev_err(dev, "can not get pinctrl!!!");
+		return PTR_ERR(pdata->pinctrl);
+	}
+
+	pdata->reset_down = pinctrl_lookup_state(pdata->pinctrl,
+		"reset-down");
+	if (IS_ERR(pdata->reset_down))
+		dev_err(dev, "can not get reset_down state");
+
+	pdata->reset_up = pinctrl_lookup_state(pdata->pinctrl,
+		"reset-up");
+	if (IS_ERR(pdata->reset_up))
+		dev_err(dev, "can not get reset_up state");
+
+	pdata->intb_ctrl = pinctrl_lookup_state(pdata->pinctrl,
+		"intb-ctrl");
+	if (IS_ERR(pdata->intb_ctrl))
+		dev_err(dev, "can not get intb-ctrl state");
+
+	return ret;
+}
+#endif
+
+static int hideep_probe(struct i2c_client *client,
+	const struct i2c_device_id *id)
+{
+	int ret = 0;
+	struct hideep_platform_data_t *p_data;
+	struct dwz_info_t *dwz;
+	struct hideep_function_list_t *function;
+	struct hideep_t *ts;
+
+	dev_info(&client->dev, "enter");
+
+	/* check i2c bus */
+	if (!i2c_check_functionality(client->adapter,
+		I2C_FUNC_I2C)) {
+		dev_err(&client->dev, "check i2c device error");
+		ret = -ENODEV;
+		return ret;
+	}
+
+	/* init platform data */
+	p_data = devm_kzalloc(&client->dev,
+		sizeof(struct hideep_platform_data_t), GFP_KERNEL);
+
+#ifdef CONFIG_OF
+	if (client->dev.of_node) {
+		ret = hideep_parse_dts(&client->dev, p_data);
+		if (ret)
+			return ret;
+	}
+#endif
+
+	/* init hideep_t */
+	ts = devm_kzalloc(&client->dev,
+		sizeof(struct hideep_t), GFP_KERNEL);
+	dwz = devm_kzalloc(&client->dev,
+		sizeof(struct dwz_info_t), GFP_KERNEL);
+	function = devm_kzalloc(&client->dev,
+		sizeof(struct hideep_function_list_t), GFP_KERNEL);
+
+	ts->client = client;
+	ts->p_data = p_data;
+	ts->dwz_info = dwz;
+	ts->hideep_api = function;
+
+	ts->hideep_api->i2c_read = hideep_i2c_read;
+	ts->hideep_api->i2c_write = hideep_i2c_write;
+	ts->hideep_api->reset_ic = hideep_reset_ic;
+	ts->hideep_api->power = hideep_power;
+
+	/* init for isp function */
+	hideep_isp_init(ts);
+
+	i2c_set_clientdata(client, ts);
+
+	mutex_init(&ts->i2c_mutex);
+	mutex_init(&ts->dev_mutex);
+
+	if (!client->dev.of_node)
+		hideep_get_info(ts);
+
+	/* hardware init */
+	hideep_init_ic(ts);
+
+#ifdef HIDEEP_DWZ_VERSION_CHECK
+	/* read info */
+	ret = ts->hideep_api->get_dwz_info(ts);
+	if (ret < 0) {
+		dev_err(&client->dev, "fail to load dwz, ret = 0x%x", ret);
+		goto hideep_probe_read_dwz_err;
+	}
+#endif
+
+	/* init input device */
+	ts->input_dev = devm_input_allocate_device(&client->dev);
+	if (!ts->input_dev) {
+		dev_err(&client->dev, "can't allocate memory for input_dev");
+		ret = -ENOMEM;
+		goto hideep_probe_input_dev_memory_err;
+	}
+
+	hideep_capability(ts);
+
+	ret = input_register_device(ts->input_dev);
+	if (ret) {
+		dev_err(&client->dev, "can't register input_dev");
+		ret = -ENOMEM;
+		goto hideep_probe_register_input_dev_err;
+	}
+
+	input_set_drvdata(ts->input_dev, ts);
+
+	/* init event thread */
+	ts->hthread_event = kthread_run(hideep_event_thread,
+		ts, "hideep_event_thread");
+	if (IS_ERR(ts->hthread_event)) {
+		dev_err(&client->dev, "can't create event thread !!!");
+		ret = PTR_ERR(ts->hthread_event);
+		goto hideep_probe_create_thread_err;
+	}
+
+#ifdef CONFIG_OF
+	/* interrupt set */
+	ts->client->irq = gpio_to_irq(p_data->irq_gpio);
+#endif
+
+	dev_info(&ts->client->dev, "ts irq: %d", ts->client->irq);
+	if (ts->client->irq <= 0) {
+		dev_err(&client->dev, "can't be assigned irq");
+		goto hideep_probe_assigned_irq_err;
+	}
+
+	if (ts->client->irq) {
+		ret = request_threaded_irq(ts->client->irq, NULL,
+			hideep_irq_task,
+			(IRQF_TRIGGER_LOW | IRQF_ONESHOT),
+			ts->client->name, ts);
+		disable_irq(ts->client->irq);
+		ts->interrupt_state = 0;
+		if (ret < 0) {
+			dev_err(&client->dev, "fail to get irq, ret = 0x%08x",
+				ret);
+			goto hideep_probe_request_irq_err;
+		}
+	}
+
+	ret = hideep_debug_init(ts);
+	if (ret) {
+		dev_err(&client->dev, "fail init debug, ret = 0x%x", ret);
+		ret = -1;
+		goto hideep_probe_debug_init_err;
+	}
+
+	ret = hideep_sysfs_init(ts);
+	if (ret) {
+		dev_err(&client->dev, "fail init sys, ret = 0x%x", ret);
+		ret = -1;
+		goto hideep_probe_sysfs_init_err;
+	}
+
+#ifdef CONFIG_FB
+	ts->suspended = 0;
+	ts->fb_notif.notifier_call = fb_notifier_callback;
+	ret = fb_register_client(&ts->fb_notif);
+	if (ret) {
+		dev_err(&client->dev, "Unable to register fb_notifier: ret = %d",
+			ret);
+		ret = -1;
+		goto hideep_probe_register_fb_err;
+	}
+#endif
+
+
+	ts->dev_state = state_normal;
+	enable_irq(ts->client->irq);
+	ts->interrupt_state = 1;
+
+	dev_info(&client->dev, "probe is ok!");
+	return 0;
+
+hideep_probe_register_fb_err:
+	hideep_sysfs_exit(ts);
+
+hideep_probe_sysfs_init_err:
+	hideep_debug_uninit();
+
+hideep_probe_debug_init_err:
+hideep_probe_request_irq_err:
+	free_irq(ts->client->irq, ts);
+
+hideep_probe_assigned_irq_err:
+hideep_probe_create_thread_err:
+	input_unregister_device(ts->input_dev);
+
+hideep_probe_register_input_dev_err:
+	if (ts->input_dev)
+		input_free_device(ts->input_dev);
+
+hideep_probe_input_dev_memory_err:
+#ifdef HIDEEP_DWZ_VERSION_CHECK
+hideep_probe_read_dwz_err:
+#endif
+
+#ifdef CONFIG_OF
+	if (ts->p_data->regulator_vid != NULL ||
+		ts->p_data->regulator_vdd != NULL)
+		ts->hideep_api->power(ts, false);
+#endif
+	dev_err(&client->dev, "probe err!");
+	return ret;
+}
+
+static int hideep_remove(struct i2c_client *client)
+{
+	struct hideep_t *ts = i2c_get_clientdata(client);
+
+	kthread_stop(ts->hthread_event);
+
+#ifdef CONFIG_FB
+	if (fb_unregister_client(&ts->fb_notif))
+		dev_info(&client->dev,
+			"Error occurred while unregistering fb_notifier");
+#endif
+
+#ifdef CONFIG_OF
+	if (ts->p_data->regulator_vid != NULL ||
+		ts->p_data->regulator_vdd != NULL)
+		ts->hideep_api->power(ts, false);
+#endif
+	free_irq(client->irq, ts);
+
+	input_unregister_device(ts->input_dev);
+	hideep_sysfs_exit(ts);
+
+	hideep_debug_uninit();
+	devm_kfree(&client->dev, ts);
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static const struct dev_pm_ops hideep_pm_ops = {
+	.suspend = hideep_suspend,
+	.resume = hideep_resume,
+};
+#endif
+
+static const struct i2c_device_id hideep_dev_idtable[] = {
+	{ HIDEEP_I2C_NAME, 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, hideep_dev_idtable);
+
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id hideep_acpi_id[] = {
+	{ "HIDP0001", 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(acpi, hideep_acpi_id);
+#endif
+
+#ifdef CONFIG_OF
+static const struct of_device_id hideep_match_table[] = {
+	{ .compatible = "hideep,hideep_ts" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, hideep_match_table);
+#endif
+
+static struct i2c_driver hideep_driver = {
+	.probe = hideep_probe,
+	.remove = hideep_remove,
+	.id_table = hideep_dev_idtable,
+	.driver = {
+		.name = HIDEEP_I2C_NAME,
+		.owner = THIS_MODULE,
+		.of_match_table = of_match_ptr(hideep_match_table),
+		.acpi_match_table = ACPI_PTR(hideep_acpi_id),
+		.pm = &hideep_pm_ops,
+	},
+};
+
+module_i2c_driver(hideep_driver);
+
+MODULE_DESCRIPTION("Driver for HiDeep Touchscreen Controller");
+MODULE_AUTHOR("anthony.kim@hideep.com");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/input/touchscreen/hideep_dbg.c b/drivers/input/touchscreen/hideep_dbg.c
new file mode 100644
index 0000000..1dc3d83
--- /dev/null
+++ b/drivers/input/touchscreen/hideep_dbg.c
@@ -0,0 +1,405 @@
+/*
+ * Copyright (C) 2012-2017 Hideep, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2
+ * as published by the Free Software Foudation.
+ */
+
+#include "hideep.h"
+#include "hideep_isp.h"
+#include "hideep_dbg.h"
+
+static struct hideep_debug_dev_t *hdd;
+
+static int hideep_i2c_recv(unsigned int len)
+{
+	int ret = 0;
+
+	mutex_lock(&hdd->ts->i2c_mutex);
+	ret = i2c_master_recv(hdd->ts->client, hdd->vr_buff, len);
+	mutex_unlock(&hdd->ts->i2c_mutex);
+	if (ret < 0)
+		goto i2c_err;
+
+	dev_info(&hdd->ts->client->dev, "(%d)", len);
+	return ret;
+
+i2c_err:
+	dev_err(&hdd->ts->client->dev, "i2c_err");
+	return ret;
+}
+
+static int hideep_i2c_send(unsigned int len)
+{
+	int ret = 0;
+	unsigned char *buff = hdd->vr_buff;
+
+	mutex_lock(&hdd->ts->i2c_mutex);
+	ret = i2c_master_send(hdd->ts->client, buff, len);
+	mutex_unlock(&hdd->ts->i2c_mutex);
+	if (ret < 0)
+		goto i2c_err;
+
+	dev_info(&hdd->ts->client->dev, "(%d)", len);
+	return ret;
+
+i2c_err:
+	dev_err(&hdd->ts->client->dev, "i2c_err");
+	return ret;
+}
+
+static int hideep_get_vreg(unsigned int addr, unsigned int len)
+{
+	int ret = 0;
+
+	ret = hdd->ts->hideep_api->i2c_read(hdd->ts, addr, len,
+		hdd->vr_buff);
+	if (ret < 0)
+		goto i2c_err;
+
+	dev_dbg(&hdd->ts->client->dev, "(0x%02x:%d)", addr, len);
+	return ret;
+
+i2c_err:
+	dev_err(&hdd->ts->client->dev, "i2c_err");
+	return ret;
+}
+
+static int hideep_set_vreg(unsigned int addr, unsigned int len)
+{
+	int ret = 0;
+	int wr_remain = len;
+	int vr_addr = addr;
+	int wr_len = len;
+	unsigned char *buff = hdd->vr_buff;
+
+	do {
+		if (wr_remain >=  MAX_VR_BUFF)
+			wr_len = MAX_VR_BUFF;
+		else
+			wr_len = wr_remain;
+
+		ret = hdd->ts->hideep_api->i2c_write(hdd->ts, vr_addr,
+			wr_len, buff);
+		if (ret < 0)
+			goto i2c_err;
+
+		wr_remain -= MAX_VR_BUFF;
+		vr_addr += MAX_VR_BUFF;
+		buff += MAX_VR_BUFF;
+	} while (wr_remain > 0);
+
+	dev_dbg(&hdd->ts->client->dev, "(0x%02x:%d)", addr, len);
+	return ret;
+
+i2c_err:
+	dev_err(&hdd->ts->client->dev, "i2c_err");
+	return ret;
+}
+
+static int hideep_download_uc(const char __user *uc, size_t count, int offset)
+{
+	int ret;
+	unsigned char *ucode;
+
+	dev_dbg(&hdd->ts->client->dev, "count = %zu", count);
+
+	if (count > FIRMWARE_SIZE) {
+		dev_err(&hdd->ts->client->dev, "over size data!!!");
+		return -1;
+	}
+
+	ucode = kmalloc(count, GFP_KERNEL);
+
+	ret = copy_from_user(ucode + offset, uc, count);
+	if (ret < 0) {
+		dev_err(&hdd->ts->client->dev, "ADDR_UC : copy_to_user");
+		kfree(ucode);
+		return 0;
+	}
+
+	disable_irq(hdd->ts->client->irq);
+	hdd->ts->interrupt_state = 0;
+	hdd->ts->hideep_api->update_part(hdd->ts, ucode, count, offset, false);
+	enable_irq(hdd->ts->client->irq);
+	hdd->ts->interrupt_state = 1;
+	kfree(ucode);
+
+	dev_dbg(&hdd->ts->client->dev, "Download_uc(%zu)", count);
+
+	return count;
+}
+
+static int hideep_debug_open(struct inode *inode, struct file *file)
+{
+	hdd->release_flag = false;
+
+	file->private_data = hdd;
+	dev_dbg(&hdd->ts->client->dev, "hideep_debug_open");
+
+	return 0;
+}
+
+static int hideep_debug_release(struct inode *inode, struct file *file)
+{
+	if (!hdd->release_flag)
+		return -1;
+	hdd->release_flag = false;
+	file->private_data = NULL;
+	return 0;
+}
+
+static unsigned int hideep_debug_poll(struct file *file,
+	struct poll_table_struct *wait)
+{
+	unsigned int mask = 0;
+	struct hideep_debug_dev_t *drv_info;
+
+	if (file->private_data == NULL)
+		return 0;
+
+	drv_info = file->private_data;
+
+	poll_wait(file, &drv_info->i_packet, wait);
+
+	if (drv_info->ready) {
+		disable_irq(drv_info->ts->client->irq);
+		drv_info->ts->interrupt_state = 0;
+		mask |= POLLIN | POLLRDNORM;
+		drv_info->ready = 0;
+	}
+
+	return mask;
+}
+
+static ssize_t hideep_debug_read(struct file *file, char __user *buf,
+	size_t count, loff_t *offset)
+{
+	int ret = -1;
+	ssize_t rd_len = 0;
+	unsigned char *rd_buffer = NULL;
+	unsigned char *data = NULL;
+	struct hideep_debug_dev_t *drv_info = file->private_data;
+
+	dev_dbg(&hdd->ts->client->dev, "count = %zu", count);
+
+	if (file->private_data == NULL)
+		return 0;
+
+	drv_info->vr_size = count;
+	rd_len = count;
+
+	data = kmalloc(rd_len, GFP_KERNEL);
+
+	if (*offset <= HIDEEP_VR_ADDR_LEN) {
+		// if offset is not belong to any special command
+		if ((*offset & HIDEEP_MAX_RAW_LEN) &&
+			(*offset < HIDEEP_MAX_RAW_LEN) &&
+			(drv_info->debug_enable == true)) {
+			mutex_lock(&drv_info->ts->dev_mutex);
+			rd_buffer = drv_info->img_buff;
+			ret = 0;
+			mutex_unlock(&drv_info->ts->dev_mutex);
+		} else {
+			ret = hideep_get_vreg(*offset, rd_len);
+			rd_buffer = drv_info->vr_buff;
+		}
+		if (ret < 0)
+			rd_len = 0;
+	} else if (*offset & (HIDEEP_I2C_BYPASS)) {
+		// if offset is belong to special command "i2c bypass"
+		ret = hideep_i2c_recv(rd_len);
+		if (ret < 0) {
+			dev_err(&hdd->ts->client->dev, "ret = %d", ret);
+			rd_len = 0;
+		} else {
+			rd_buffer = drv_info->vr_buff;
+		}
+	} else if (*offset & HIDEEP_NVM_DOWNLOAD) {
+		// if offset is belong to special command "nvm download"
+		rd_len = count;
+		memset(data, 0x0, rd_len);
+
+		disable_irq(drv_info->ts->client->irq);
+		drv_info->ts->interrupt_state = 0;
+		mutex_lock(&drv_info->ts->dev_mutex);
+		mutex_lock(&drv_info->ts->i2c_mutex);
+
+		drv_info->ts->hideep_api->sp_func(drv_info->ts, data, rd_len,
+			*offset & 0xfffff);
+
+		mutex_unlock(&drv_info->ts->dev_mutex);
+		mutex_unlock(&drv_info->ts->i2c_mutex);
+		enable_irq(drv_info->ts->client->irq);
+		drv_info->ts->interrupt_state = 1;
+
+		rd_buffer = data;
+	} else {
+		dev_err(&hdd->ts->client->dev, "undefined address");
+		kfree(data);
+		return 0;
+	}
+
+	ret = copy_to_user(buf, rd_buffer, rd_len);
+
+	if (drv_info->debug_enable == true && drv_info->ready == 0) {
+		enable_irq(drv_info->ts->client->irq);
+		drv_info->ts->interrupt_state = 1;
+	}
+
+	if (ret < 0) {
+		dev_err(&hdd->ts->client->dev, "error : copy_to_user");
+		kfree(data);
+		return -EFAULT;
+	}
+
+	kfree(data);
+	return rd_len;
+}
+
+static ssize_t hideep_debug_write(struct file *file, const char __user *buf,
+	size_t count, loff_t *offset)
+{
+	int ret;
+	struct hideep_debug_dev_t *drv_info = file->private_data;
+	int wr_len = 0;
+
+	dev_dbg(&hdd->ts->client->dev, "count = %zu", count);
+	if (file->private_data == NULL)
+		return 0;
+
+	if (*offset <= HIDEEP_VR_ADDR_LEN) {
+		// if offset is not belong to any special command
+		wr_len = count;
+
+		ret = copy_from_user(drv_info->vr_buff, buf, wr_len);
+		if (ret < 0) {
+			dev_err(&hdd->ts->client->dev, "error : copy_to_user");
+			return -EFAULT;
+		}
+
+		ret = hideep_set_vreg(*offset, wr_len);
+		if (ret < 0)
+			wr_len = 0;
+	} else if (*offset & (HIDEEP_I2C_BYPASS)) {
+		// if offset is belong to special command "i2c bypass"
+		wr_len = count;
+		ret = copy_from_user(drv_info->vr_buff, buf, wr_len);
+		ret = hideep_i2c_send(wr_len);
+	} else if (*offset & HIDEEP_NVM_DOWNLOAD) {
+		// if offset is belong to special command "nvm download"
+		wr_len = hideep_download_uc(buf, count, *offset & 0xfffff);
+	} else {
+		dev_err(&hdd->ts->client->dev,
+			"hideep_write : undefined address, 0x%08x",
+			(int)*offset);
+		return 0;
+	}
+
+	return wr_len;
+}
+
+static loff_t hideep_debug_llseek(struct file *file, loff_t off, int whence)
+{
+	loff_t newpos;
+	struct hideep_debug_dev_t *drv_info = file->private_data;
+
+	dev_dbg(&hdd->ts->client->dev, "off = 0x%08x, whence = %d",
+		(unsigned int)off, whence);
+	if (file->private_data == NULL)
+		return -EFAULT;
+
+	switch (whence) {
+	/* SEEK_SET */
+	case 0:
+		newpos = off;
+		break;
+	/* SEEK_CUR */
+	case 1:
+		dev_dbg(&hdd->ts->client->dev, "set mode off = 0x%08x",
+			(unsigned int)off);
+		if (off & HIDEEP_RELEASE_FLAG) {
+			dev_dbg(&hdd->ts->client->dev, "set release flag");
+			drv_info->release_flag = true;
+		}
+		newpos = file->f_pos;
+		break;
+	/* SEEK_END */
+	case 2:
+		newpos = file->f_pos;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (newpos < 0)
+		return -EINVAL;
+
+	file->f_pos = newpos;
+
+	return newpos;
+}
+
+static const struct file_operations hideep_debug_fops = {
+	.owner = THIS_MODULE,
+	.open = hideep_debug_open,
+	.poll = hideep_debug_poll,
+	.release = hideep_debug_release,
+	.read = hideep_debug_read,
+	.write = hideep_debug_write,
+	.llseek = hideep_debug_llseek,
+};
+
+static struct miscdevice hideep_debug_dev = {
+	.minor = MISC_DYNAMIC_MINOR,
+	.name = HIDEEP_DEBUG_DEVICE_NAME,
+	.fops = &hideep_debug_fops
+};
+
+void hideep_debug_uninit(void)
+{
+	kfree(hdd->vr_buff);
+	kfree(hdd->img_buff);
+
+	misc_deregister(&hideep_debug_dev);
+}
+
+int hideep_debug_init(struct hideep_t *ts)
+{
+	int ret = 0;
+
+	hdd = &ts->debug_dev;
+
+	ret = misc_register(&hideep_debug_dev);
+	if (ret) {
+		dev_err(&ts->client->dev,
+			"hideep debug device register fail!!!");
+		goto fail;
+	}
+
+	init_waitqueue_head(&hdd->i_packet);
+
+	hdd->ts = ts;
+	hdd->debug_enable = false;
+
+	hdd->img_size = 0;
+	hdd->vr_size = 0;
+
+	hdd->vr_buff = kmalloc(MAX_VR_BUFF, GFP_KERNEL);
+	hdd->img_buff = kmalloc(MAX_RAW_SIZE, GFP_KERNEL);
+
+	memset(hdd->vr_buff, 0x0, MAX_VR_BUFF);
+	memset(hdd->img_buff, 0x0, MAX_RAW_SIZE);
+
+	if (!hdd->vr_buff || !hdd->img_buff)
+		goto fail;
+
+	dev_info(&ts->client->dev, "debug init....");
+	return 0;
+
+fail:
+	kfree(hdd->vr_buff);
+	kfree(hdd->img_buff);
+	return ret;
+}
diff --git a/drivers/input/touchscreen/hideep_dbg.h b/drivers/input/touchscreen/hideep_dbg.h
new file mode 100644
index 0000000..f18a09f
--- /dev/null
+++ b/drivers/input/touchscreen/hideep_dbg.h
@@ -0,0 +1,24 @@
+/*
+ * Copyright (C) 2012-2017 Hideep, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2
+ * as published by the Free Software Foudation.
+ */
+
+#ifndef _LINUX_HIDEEP_DBG_H
+#define _LINUX_HIDEEP_DBG_H
+
+/* Device Driver <==> Application */
+/* lseek(), write(), read() command */
+#define HIDEEP_RELEASE_FLAG				0x8000
+#define HIDEEP_VR_ADDR_LEN				0xFFFF
+#define HIDEEP_MAX_RAW_LEN				0x3000
+#define HIDEEP_READ_WRITE_VR			0xF000
+#define HIDEEP_I2C_BYPASS				0x20000000
+
+#define MAX_VR_BUFF						2048
+
+/* max tx * max rx * 2 + 8 + 1, 1 is magin size */
+#define MAX_RAW_SIZE					7369
+#endif /* _LINUX_HIDEEP_DBG_H */
diff --git a/drivers/input/touchscreen/hideep_isp.c b/drivers/input/touchscreen/hideep_isp.c
new file mode 100644
index 0000000..7cdd422
--- /dev/null
+++ b/drivers/input/touchscreen/hideep_isp.c
@@ -0,0 +1,584 @@
+/*
+ * Copyright (C) 2012-2017 Hideep, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2
+ * as published by the Free Software Foudation.
+ */
+
+#include "hideep.h"
+#include "hideep_isp.h"
+
+static struct pgm_packet packet_w;
+static struct pgm_packet packet_r;
+
+static int hideep_pgm_w_mem(struct hideep_t *ts, unsigned int addr,
+	struct pgm_packet *packet, unsigned int len)
+{
+	int ret = 0;
+	int i;
+
+	if ((len % 4) != 0)
+		return -1;
+
+	mutex_lock(&ts->i2c_mutex);
+
+	packet->header.w[0] = htonl((0x80 | (len / 4-1)));
+	packet->header.w[1] = htonl(addr);
+
+	for (i = 0; i < NVM_PAGE_SIZE / sizeof(unsigned int); i++)
+		packet->payload[i] = htonl(packet->payload[i]);
+
+	ret = i2c_master_send(ts->client, (unsigned char *)&packet->header.b[3],
+		(len+5));
+
+	if (ret < 0)
+		goto err;
+
+err:
+	mutex_unlock(&ts->i2c_mutex);
+	return ret;
+}
+
+static int hideep_pgm_r_mem(struct hideep_t *ts, unsigned int addr,
+	struct pgm_packet *packet, unsigned int len)
+{
+	int ret = 0;
+	int i;
+
+	if ((len % 4) != 0)
+		return -1;
+
+	mutex_lock(&ts->i2c_mutex);
+
+	packet->header.w[0] = htonl((0x00 | (len / 4-1)));
+	packet->header.w[1] = htonl(addr);
+
+	ret = i2c_master_send(ts->client, (unsigned char *)&packet->header.b[3],
+		5);
+
+	if (ret < 0)
+		goto err;
+
+	ret = i2c_master_recv(ts->client, (unsigned char *)packet->payload,
+		len);
+
+	if (ret < 0)
+		goto err;
+
+	for (i = 0; i < NVM_PAGE_SIZE / sizeof(unsigned int); i++)
+		packet->payload[i] = htonl(packet->payload[i]);
+
+err:
+	mutex_unlock(&ts->i2c_mutex);
+	return ret;
+}
+
+static int hideep_pgm_r_reg(struct hideep_t *ts, unsigned int addr,
+	unsigned int *val)
+{
+	int ret = 0;
+	struct pgm_packet packet;
+
+	packet.header.w[0] = htonl(0x00);
+	packet.header.w[1] = htonl(addr);
+
+	ret = hideep_pgm_r_mem(ts, addr, &packet, 4);
+
+	if (ret < 0)
+		goto err;
+
+	*val = packet.payload[0];
+
+err:
+	return ret;
+}
+
+static int hideep_pgm_w_reg(struct hideep_t *ts, unsigned int addr,
+	unsigned int data)
+{
+	int ret = 0;
+	struct pgm_packet packet;
+
+	packet.header.w[0] = htonl(0x80);
+	packet.header.w[1] = htonl(addr);
+	packet.payload[0] = data;
+
+	ret = hideep_pgm_w_mem(ts, addr, &packet, 4);
+
+	return ret;
+}
+
+#define SW_RESET_IN_PGM(CLK) \
+{ \
+	hideep_pgm_w_reg(ts, SYSCON_WDT_CNT, CLK); \
+	hideep_pgm_w_reg(ts, SYSCON_WDT_CON, 0x03); \
+	hideep_pgm_w_reg(ts, SYSCON_WDT_CON, 0x01); \
+}
+
+#define SET_FLASH_PIO(CE) \
+	hideep_pgm_w_reg(ts, FLASH_CON, 0x01 | ((CE) << 1))
+#define SET_PIO_SIG(X, Y) \
+	hideep_pgm_w_reg(ts, FLASH_BASE + PIO_SIG + (X), Y)
+#define SET_FLASH_HWCONTROL() \
+	hideep_pgm_w_reg(ts, FLASH_CON, 0x00000000)
+
+#define NVM_W_SFR(x, y) \
+{ \
+	SET_FLASH_PIO(1); \
+	SET_PIO_SIG(x, y); \
+	SET_FLASH_PIO(0); \
+}
+
+static void get_dwz_from_binary(unsigned char *pres,
+	struct dwz_info_t *dwz_info)
+{
+	memcpy(dwz_info, pres + HIDEEP_DWZ_INFO_OFS,
+		sizeof(struct dwz_info_t));
+}
+
+static void hideep_sw_reset(struct hideep_t *ts, unsigned int food)
+{
+	SW_RESET_IN_PGM(food);
+}
+
+static int hideep_enter_pgm(struct hideep_t *ts)
+{
+	int ret = 0;
+	int retry_count = 10;
+	int retry = 0;
+	unsigned int status;
+	unsigned int pattern = 0xDF9DAF39;
+
+	while (retry < retry_count) {
+		i2c_master_send(ts->client, (unsigned char *)&pattern, 4);
+		mdelay(1);
+
+		/* flush invalid Tx load register */
+		hideep_pgm_w_reg(ts, ESI_TX_INVALID, 0x01);
+
+		hideep_pgm_r_reg(ts, SYSCON_PGM_ID, &status);
+
+		if (status != htonl(pattern)) {
+			retry++;
+			dev_err(&ts->client->dev, "enter_pgm : error(%08x):",
+				status);
+		} else {
+			dev_dbg(&ts->client->dev, "found magic code");
+			break;
+		}
+	}
+
+	if (retry < retry_count) {
+		hideep_pgm_w_reg(ts, SYSCON_WDT_CON, 0x00);
+		hideep_pgm_w_reg(ts, SYSCON_SPC_CON, 0x00);
+		hideep_pgm_w_reg(ts, SYSCON_CLK_ENA, 0xFF);
+		hideep_pgm_w_reg(ts, SYSCON_CLK_CON, 0x01);
+		hideep_pgm_w_reg(ts, SYSCON_PWR_CON, 0x01);
+		hideep_pgm_w_reg(ts, FLASH_TIM, 0x03);
+		hideep_pgm_w_reg(ts, FLASH_CACHE_CFG, 0x00);
+		hideep_pgm_w_reg(ts, FLASH_CACHE_CFG, 0x02);
+
+		mdelay(1);
+	} else {
+		ret = -1;
+	}
+
+	return ret;
+}
+
+static int hideep_load_dwz(struct hideep_t *ts)
+{
+	int ret = 0;
+	struct pgm_packet packet_r;
+
+	ret = hideep_enter_pgm(ts);
+
+	mdelay(50);
+
+	ret = hideep_pgm_r_mem(ts, HIDEEP_DWZ_INFO_OFS, &packet_r,
+		sizeof(struct dwz_info_t));
+
+	memcpy((unsigned char *)ts->dwz_info, packet_r.payload,
+		sizeof(struct dwz_info_t));
+	hideep_sw_reset(ts, 10);
+
+	dev_dbg(&ts->client->dev, "firmware release version : %04x",
+		ts->dwz_info->release_ver);
+
+	mdelay(50);
+
+	return ret;
+}
+
+static int hideep_nvm_unlock(struct hideep_t *ts)
+{
+	int ret = 0;
+	unsigned int unmask_code = 0;
+
+	ret = hideep_pgm_w_reg(ts, FLASH_CFG, NVM_SFR_RPAGE);
+
+	ret = hideep_pgm_r_reg(ts, 0x0000000C, &unmask_code);
+
+	ret = hideep_pgm_w_reg(ts, FLASH_CFG, NVM_DEFAULT_PAGE);
+
+	/* make it unprotected code */
+	unmask_code &= (~_PROT_MODE);
+
+	/* compare unmask code */
+	if (unmask_code != NVM_MASK)
+		dev_dbg(&ts->client->dev, "read mask code different 0x%x",
+			unmask_code);
+
+	ret = hideep_pgm_w_reg(ts, FLASH_CFG, NVM_SFR_WPAGE);
+	SET_FLASH_PIO(0);
+
+	NVM_W_SFR(NVM_MASK_OFS, NVM_MASK);
+	SET_FLASH_HWCONTROL();
+	ret = hideep_pgm_w_reg(ts, FLASH_CFG, NVM_DEFAULT_PAGE);
+
+	return ret;
+}
+
+static int hideep_program_page(struct hideep_t *ts,
+	unsigned int addr, struct pgm_packet *packet_w)
+{
+	int ret = 0;
+	unsigned int pio_cmd = WRONLY;
+	unsigned int pio_cmd_page_erase = PERASE;
+	unsigned int status;
+	int time_out = 0;
+	int inf_en = 0;
+	unsigned int end_flag = 124;
+#ifndef PGM_BURST_WR
+	unsigned int i;
+#endif
+
+	hideep_pgm_r_reg(ts, FLASH_STA, &status);
+	ret = (status == 0) ? -1:0;
+
+	addr = addr & ~(NVM_PAGE_SIZE - 1);
+
+	if (addr > INF_SECTION) {
+		/* added INF flag set in pio_cmd */
+		addr -= INF_SECTION;
+		pio_cmd |= INF;
+		pio_cmd_page_erase |= INF;
+		inf_en = 1;
+	}
+
+	SET_FLASH_PIO(0);
+	SET_FLASH_PIO(1);
+
+	/* first erase */
+	SET_PIO_SIG(pio_cmd_page_erase  + addr, 0xFFFFFFFF);
+
+	SET_FLASH_PIO(0);
+	time_out = 0;
+
+	while (1) {
+		mdelay(1);
+		hideep_pgm_r_reg(ts, FLASH_STA, &status);
+		if ((status) != 0)
+			break;
+		if (time_out++ > 100)
+			break;
+	}
+	SET_FLASH_PIO(1);
+	/* first erase end*/
+
+	SET_PIO_SIG(pio_cmd + addr, htonl(packet_w->payload[0]));
+
+#ifdef PGM_BURST_WR
+	hideep_pgm_w_mem(ts, (FLASH_BASE + 0x400000) + pio_cmd,
+		packet_w, NVM_PAGE_SIZE);
+#else
+	for (i = 0; i < NVM_PAGE_SIZE / 4; i++)
+		SET_PIO_SIG(pio_cmd + (i<<2), packet_w->payload[i]);
+#endif
+	if (inf_en == 0)
+		SET_PIO_SIG(end_flag, htonl(packet_w->payload[31]));
+	else
+		SET_PIO_SIG(end_flag | INF, htonl(packet_w->payload[31]));
+
+	SET_FLASH_PIO(0);
+
+	mdelay(1);
+
+	while (1) {
+		hideep_pgm_r_reg(ts, FLASH_STA, &status);
+		if ((status) != 0)
+			break;
+	}
+	/* write routine end */
+
+	SET_FLASH_HWCONTROL();
+
+	return ret;
+}
+
+static int hideep_program_nvm(struct hideep_t *ts, const unsigned char *ucode,
+	int len, int offset, unsigned char *old_fw)
+{
+	int i;
+	int ret = 0;
+	int len_r;
+	int len_w;
+	int addr = 0;
+	unsigned int pages;
+
+	ret = hideep_enter_pgm(ts);
+
+	hideep_nvm_unlock(ts);
+
+	pages = (len + NVM_PAGE_SIZE - 1) / NVM_PAGE_SIZE;
+	addr = offset;
+	len_r = len;
+	len_w = len_r;
+
+	dev_dbg(&ts->client->dev, "pages : %d", pages);
+	for (i = 0; i < pages; i++) {
+		if (len_r >= NVM_PAGE_SIZE)
+			len_w = NVM_PAGE_SIZE;
+
+		/* compare */
+		if (old_fw != NULL)
+			ret = memcmp(&ucode[addr], &old_fw[addr], len_w);
+
+		if (ret != 0 || old_fw == NULL) {
+			/* write page */
+			memcpy(packet_w.payload, &(ucode[addr]), len_w);
+
+			ret = hideep_program_page(ts, addr, &packet_w);
+			mdelay(1);
+			if (ret < 0)
+				dev_err(&ts->client->dev,
+					"hideep_program_nvm : error(%08x):",
+					addr);
+		}
+
+		addr += NVM_PAGE_SIZE;
+		len_r -= NVM_PAGE_SIZE;
+		len_w = len_r;
+	}
+
+	return ret;
+}
+
+static int hideep_verify_nvm(struct hideep_t *ts, const unsigned char *ucode,
+	int len, int offset)
+{
+	int i, j;
+	int ret = 0;
+	unsigned char page_chk = 0;
+	unsigned int addr = offset;
+	unsigned int pages = (len + NVM_PAGE_SIZE - 1) / NVM_PAGE_SIZE;
+	int len_r = len;
+	int len_v = len_r;
+
+	for (i = 0; i < pages; i++) {
+		if (len_r >= NVM_PAGE_SIZE)
+			len_v = NVM_PAGE_SIZE;
+
+#ifdef PGM_BURST_WR
+		hideep_pgm_r_mem(ts, 0x00000000 + addr, &packet_r,
+			NVM_PAGE_SIZE);
+#else
+		for (j = 0; j < (NVM_PAGE_SIZE >> 2); j++)
+			hideep_pgm_r_reg(ts, addr + (j << 2),
+				&(packet_r.payload[j]));
+#endif
+		page_chk = memcmp(&(ucode[addr]), packet_r.payload, len_v);
+
+		if (page_chk != 0) {
+			u8 *read = (u8 *)packet_r.payload;
+
+			for (j = 0; j < NVM_PAGE_SIZE; j++)
+				dev_err(&ts->client->dev, "%02x : %02x",
+						ucode[addr+j], read[j]);
+
+			dev_err(&ts->client->dev, "verify : error(addr : %d)",
+				addr);
+
+			ret = -1;
+		}
+
+		addr += NVM_PAGE_SIZE;
+		len_r -= NVM_PAGE_SIZE;
+		len_v = len_r;
+	}
+
+	return ret;
+}
+
+static void hideep_read_nvm(struct hideep_t *ts, unsigned char *data, int len,
+	int offset)
+{
+	int ret = 0;
+	int pages, i;
+	int len_r, len_v;
+	int addr = offset;
+#ifndef PGM_BURST_WR
+	int j;
+#endif
+
+	pages = (len + NVM_PAGE_SIZE - 1) / NVM_PAGE_SIZE;
+	len_r = len;
+	len_v = len_r;
+
+	ts->hideep_api->reset_ic(ts);
+
+	ret = hideep_enter_pgm(ts);
+
+	hideep_nvm_unlock(ts);
+
+	for (i = 0; i < pages; i++) {
+		if (len_r >= NVM_PAGE_SIZE)
+			len_v = NVM_PAGE_SIZE;
+
+#ifdef PGM_BURST_WR
+		hideep_pgm_r_mem(ts, 0x00000000 + addr, &packet_r,
+			NVM_PAGE_SIZE);
+#else
+		for (j = 0; j < NVM_PAGE_SIZE / 4; j++)
+			hideep_pgm_r_reg(ts, addr + (j << 2),
+				&(packet_r.payload[j]));
+#endif
+		memcpy(&(data[i * NVM_PAGE_SIZE]), &packet_r.payload[0], len_v);
+
+		addr += NVM_PAGE_SIZE;
+		len_r -= NVM_PAGE_SIZE;
+		len_v = len_r;
+	}
+
+	hideep_sw_reset(ts, 1000);
+}
+
+static int hideep_fw_verify_run(struct hideep_t *ts, unsigned char *fw,
+	size_t len, int offset)
+{
+	int ret = 0;
+	int retry = 3;
+
+	while (retry--) {
+		ret = hideep_verify_nvm(ts, fw, len, offset);
+		if (ret == 0) {
+			dev_dbg(&ts->client->dev, "update success");
+			break;
+		}
+		dev_err(&ts->client->dev, "download fw failed(%d)", retry);
+	}
+
+	ret = (retry == 0) ? -1:0;
+
+	return ret;
+}
+
+static int hideep_wr_firmware(struct hideep_t *ts, unsigned char *code,
+	int len, int offset, bool mode)
+{
+	int ret = 0;
+	int firm_len;
+	unsigned char *ic_fw;
+	unsigned char *dwz_info;
+
+	ic_fw = kmalloc(FIRMWARE_SIZE, GFP_KERNEL);
+	dwz_info = kmalloc(sizeof(struct dwz_info_t) + 64, GFP_KERNEL);
+
+	memset(dwz_info, 0x0, sizeof(struct dwz_info_t) + 64);
+
+	firm_len = len;
+	dev_dbg(&ts->client->dev, "fw len : %d, define size : %d",
+		firm_len, FIRMWARE_SIZE);
+
+	if (firm_len > FIRMWARE_SIZE)
+		firm_len = FIRMWARE_SIZE;
+
+	dev_dbg(&ts->client->dev, "enter");
+	/* memory dump of target IC */
+	hideep_read_nvm(ts, ic_fw, firm_len, offset);
+	/* comparing & programming each page, if the memory of specified
+	 * page is exactly same, no need to update.
+	 */
+	ret = hideep_program_nvm(ts, code, firm_len, offset, ic_fw);
+
+#ifdef PGM_VERIFY
+	hideep_fw_verify_run(ts, code, firm_len, offset);
+	if (ret < 0) {
+		if (mode == true) {
+			/* clear dwz version, it will be store once again
+			 * after update success
+			 */
+			ts->dwz_info->release_ver = 0;
+			memcpy(&dwz_info[64], ts->dwz_info,
+				sizeof(struct dwz_info_t));
+			ret = hideep_program_nvm(ts, dwz_info, HIDEEP_DWZ_LEN,
+				0x280, NULL);
+		}
+	}
+#endif
+	get_dwz_from_binary(code, ts->dwz_info);
+
+	hideep_sw_reset(ts, 1000);
+
+	kfree(ic_fw);
+	kfree(dwz_info);
+
+	return ret;
+}
+
+static int hideep_update_all_firmware(struct hideep_t *ts, const char *fn)
+{
+	int ret = 0;
+	const struct firmware *fw_entry;
+	unsigned char *fw_buf;
+	unsigned int fw_length;
+
+	dev_dbg(&ts->client->dev, "enter");
+	ret = request_firmware(&fw_entry, fn, &ts->client->dev);
+
+	if (ret != 0) {
+		dev_err(&ts->client->dev, "request_firmware : fail(%d)", ret);
+		return ret;
+	}
+
+	fw_buf = (unsigned char *)fw_entry->data;
+	fw_length = (unsigned int)fw_entry->size;
+
+	/* chip specific code for flash fuse */
+	mutex_lock(&ts->dev_mutex);
+
+	ts->dev_state = state_updating;
+
+	ret = hideep_wr_firmware(ts, fw_buf, fw_length, 0, true);
+
+	ts->dev_state = state_normal;
+
+	mutex_unlock(&ts->dev_mutex);
+
+	release_firmware(fw_entry);
+
+	return ret;
+}
+
+static int hideep_update_part_firmware(struct hideep_t *ts,
+	unsigned char *code, int len, int offset, bool mode)
+{
+	int ret = 0;
+
+	mutex_lock(&ts->dev_mutex);
+
+	ret = hideep_wr_firmware(ts, code, len, offset, false);
+
+	mutex_unlock(&ts->dev_mutex);
+
+	return ret;
+}
+
+void hideep_isp_init(struct hideep_t *ts)
+{
+	ts->hideep_api->update_all = hideep_update_all_firmware;
+	ts->hideep_api->update_part = hideep_update_part_firmware;
+	ts->hideep_api->get_dwz_info = hideep_load_dwz;
+	ts->hideep_api->sp_func = hideep_read_nvm;
+}
diff --git a/drivers/input/touchscreen/hideep_isp.h b/drivers/input/touchscreen/hideep_isp.h
new file mode 100644
index 0000000..648f271
--- /dev/null
+++ b/drivers/input/touchscreen/hideep_isp.h
@@ -0,0 +1,96 @@
+/*
+ * Copyright (C) 2012-2017 Hideep, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2
+ * as published by the Free Software Foudation.
+ */
+
+#ifndef _LINUX_HIDEEP_ISP_H
+#define _LINUX_HIDEEP_ISP_H
+
+#define PGM_BURST_WR
+#define PGM_VERIFY
+
+#define NVM_DEFAULT_PAGE		0
+#define NVM_SFR_WPAGE			1
+#define NVM_SFR_RPAGE			2
+
+#define PIO_SIG					0x00400000
+#define _PROT_MODE				0x03400000
+
+#define NVM_PAGE_SIZE			128
+
+#define HIDEEP_NVM_DOWNLOAD		0x10000000
+
+/*************************************************************************
+ * register map
+ *************************************************************************/
+#define YRAM_BASE				0x40000000
+#define PERIPHERAL_BASE			0x50000000
+#define ESI_BASE				(PERIPHERAL_BASE + 0x00000000)
+#define FLASH_BASE				(PERIPHERAL_BASE + 0x01000000)
+#define SYSCON_BASE				(PERIPHERAL_BASE + 0x02000000)
+
+#define SYSCON_MOD_CON			(SYSCON_BASE + 0x0000)
+#define SYSCON_SPC_CON			(SYSCON_BASE + 0x0004)
+#define SYSCON_CLK_CON			(SYSCON_BASE + 0x0008)
+#define SYSCON_CLK_ENA			(SYSCON_BASE + 0x000C)
+#define SYSCON_RST_CON			(SYSCON_BASE + 0x0010)
+#define SYSCON_WDT_CON			(SYSCON_BASE + 0x0014)
+#define SYSCON_WDT_CNT			(SYSCON_BASE + 0x0018)
+#define SYSCON_PWR_CON			(SYSCON_BASE + 0x0020)
+#define SYSCON_PGM_ID			(SYSCON_BASE + 0x00F4)
+
+#define FLASH_CON				(FLASH_BASE + 0x0000)
+#define FLASH_STA				(FLASH_BASE + 0x0004)
+#define FLASH_CFG				(FLASH_BASE + 0x0008)
+#define FLASH_TIM				(FLASH_BASE + 0x000C)
+#define FLASH_CACHE_CFG			(FLASH_BASE + 0x0010)
+
+#define ESI_TX_INVALID			(ESI_BASE + 0x0008)
+
+/*************************************************************************
+ * flash commands
+ *************************************************************************/
+#define MERASE					0x00010000
+#define SERASE					0x00020000
+#define PERASE					0x00040000
+#define PROG					0x00080000
+#define WRONLY					0x00100000
+#define INF						0x00200000
+
+/*************************************************************************
+ * NVM Mask
+ *************************************************************************/
+#ifdef CONFIG_TOUCHSCREEN_HIDEEP_CRIMSON
+#define NVM_MASK_OFS			0x0000000C
+#define NVM_MASK				0x00310000
+#define INF_SECTION				0x0000C000
+#endif
+#ifdef CONFIG_TOUCHSCREEN_HIDEEP_LIME
+#define NVM_MASK_OFS			0x0000000C
+#define NVM_MASK				0x0030027B
+#define INF_SECTION				0x00010000
+#endif
+
+/*************************************************************************
+ * DWZ info
+ *************************************************************************/
+#define HIDEEP_BOOT_SECTION		0x00000400
+#define HIDEEP_BOOT_LEN			0x00000400
+#define HIDEEP_DWZ_SECTION		0x00000280
+#define HIDEEP_DWZ_INFO_OFS		0x000002C0
+#define HIDEEP_DWZ_LEN			(HIDEEP_BOOT_SECTION \
+							- HIDEEP_DWZ_SECTION)
+
+struct pgm_packet {
+	union {
+		unsigned char b[8];
+		unsigned int w[2];
+	} header;
+
+	unsigned int payload[NVM_PAGE_SIZE / sizeof(unsigned int)];
+};
+
+#endif /* _LINUX_HIDEEP_ISP_H */
diff --git a/drivers/input/touchscreen/hideep_sysfs.c b/drivers/input/touchscreen/hideep_sysfs.c
new file mode 100644
index 0000000..4aedec6
--- /dev/null
+++ b/drivers/input/touchscreen/hideep_sysfs.c
@@ -0,0 +1,249 @@
+/*
+ * Copyright (C) 2012-2017 Hideep, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2
+ * as published by the Free Software Foudation.
+ */
+
+#include "hideep.h"
+
+static ssize_t update_fw(struct device *dev, struct device_attribute *attr,
+	const char *buf, size_t count)
+{
+	struct hideep_t *ts = dev_get_drvdata(dev);
+	int mode, ret;
+	char *fw_name;
+
+	if (count == 1)
+		mode = buf[0] & 0xff;
+	else
+		return count;
+
+	if (mode == 1) {
+		disable_irq(ts->client->irq);
+
+		ts->dev_state = state_updating;
+		fw_name = kasprintf(GFP_KERNEL, "hideep_ts_%04x.bin",
+			ts->dwz_info->product_id);
+		ret = ts->hideep_api->update_all(ts, fw_name);
+
+		kfree(fw_name);
+
+		enable_irq(ts->client->irq);
+
+		ts->dev_state = state_normal;
+		if (ret != 0)
+			dev_err(dev, "The firmware update failed(%d)", ret);
+	}
+
+	return count;
+}
+
+static ssize_t fw_version_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	int len = 0;
+	struct hideep_t *ts = dev_get_drvdata(dev);
+
+	dev_info(dev, "release version : %04x",
+		ts->dwz_info->release_ver);
+
+	mutex_lock(&ts->dev_mutex);
+	len = scnprintf(buf, PAGE_SIZE,
+		"%04x\n", ts->dwz_info->release_ver);
+	mutex_unlock(&ts->dev_mutex);
+
+	return len;
+}
+
+static ssize_t product_id_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	int len = 0;
+	struct hideep_t *ts = dev_get_drvdata(dev);
+
+	dev_info(dev, "product id : %04x",
+		ts->dwz_info->product_id);
+
+	mutex_lock(&ts->dev_mutex);
+	len = scnprintf(buf, PAGE_SIZE,
+		"%04x\n", ts->dwz_info->product_id);
+	mutex_unlock(&ts->dev_mutex);
+
+	return len;
+}
+
+static ssize_t power_status(struct device *dev, struct device_attribute *attr,
+	char *buf)
+{
+	struct hideep_t *ts = dev_get_drvdata(dev);
+	int len;
+
+	len = scnprintf(buf, PAGE_SIZE, "power status : %s\n",
+		(ts->dev_state == state_init) ? "off" : "on");
+
+	return len;
+}
+
+static ssize_t power_control(struct device *dev, struct device_attribute *attr,
+	const char *buf, size_t count)
+{
+	struct hideep_t *ts = dev_get_drvdata(dev);
+	int on;
+
+	if (count == 1)
+		on = buf[0] & 0xff;
+	else
+		return count;
+
+	if (on) {
+		ts->hideep_api->power(ts, on);
+		ts->dev_state = state_normal;
+		ts->hideep_api->reset_ic(ts);
+	} else {
+		ts->hideep_api->power(ts, on);
+		ts->dev_state = state_init;
+	}
+
+	return count;
+}
+
+#ifdef HIDEEP_SUPPORT_STYLUS
+static ssize_t stylus_status(struct device *dev, struct device_attribute *attr,
+	char *buf)
+{
+	struct hideep_t *ts = dev_get_drvdata(dev);
+	int len;
+	unsigned char status[1];
+
+	ts->hideep_api->i2c_read(ts, 0xB00C, 1, status);
+
+	len = scnprintf(buf, PAGE_SIZE, "stylus mode enable : %s\n",
+		(status[0] == 0x00) ? "off" : "on");
+
+	return len;
+}
+
+static ssize_t stylus_enable(struct device *dev, struct device_attribute *attr,
+	const char *buf, size_t count)
+{
+	struct hideep_t *ts = dev_get_drvdata(dev);
+	int on;
+	unsigned char data[2];
+
+	if (count == 1)
+		on = buf[0] & 0xff;
+	else
+		return count;
+
+	data[0] = 0x04;
+
+	if (on) {
+		data[1] = 0x01;
+		ts->hideep_api->i2c_write(ts, HIDEEP_SWTICH_CMD, 2, data);
+	} else {
+		data[1] = 0x00;
+		ts->hideep_api->i2c_write(ts, HIDEEP_SWTICH_CMD, 2, data);
+	}
+
+	return count;
+}
+#endif
+
+static ssize_t debug_status(struct device *dev, struct device_attribute *attr,
+	char *buf)
+{
+	struct hideep_t *ts = dev_get_drvdata(dev);
+	int len;
+
+	len = scnprintf(buf, PAGE_SIZE, "debug mode : %s\n",
+		(ts->debug_dev.debug_enable == 0) ? "off" : "on");
+
+	return len;
+}
+
+static ssize_t debug_mode(struct device *dev, struct device_attribute *attr,
+	const char *buf, size_t count)
+{
+	struct hideep_t *ts = dev_get_drvdata(dev);
+	int on;
+	unsigned char data[2];
+
+	if (count == 1)
+		on = buf[0] & 0xff;
+	else
+		return count;
+
+	if (on) {
+		ts->debug_dev.debug_enable = 1;
+		ts->dev_state = state_debugging;
+	} else {
+		ts->debug_dev.debug_enable = 0;
+		ts->dev_state = state_normal;
+		/* set touch mode */
+		data[0] = 0x00;
+		data[1] = 0x00;
+		ts->hideep_api->i2c_write(ts, HIDEEP_OPMODE_CMD, 2, data);
+		if (ts->interrupt_state == 0) {
+			data[0] = 0x5A;
+			ts->hideep_api->i2c_write(ts, HIDEEP_INTCLR_CMD, 1,
+				data);
+			enable_irq(ts->client->irq);
+			ts->interrupt_state = 1;
+		}
+	}
+
+	return count;
+}
+
+static DEVICE_ATTR(update_fw, 0664, NULL, update_fw);
+static DEVICE_ATTR(version, 0664, fw_version_show, NULL);
+static DEVICE_ATTR(product_id, 0664, product_id_show, NULL);
+static DEVICE_ATTR(power_en, 0664, power_status, power_control);
+static DEVICE_ATTR(debug_en, 0664, debug_status, debug_mode);
+#ifdef HIDEEP_SUPPORT_STYLUS
+static DEVICE_ATTR(stylus_en, 0664, stylus_status, stylus_enable);
+#endif
+
+static struct attribute *hideep_ts_sysfs_entries[] = {
+	&dev_attr_update_fw.attr,
+	&dev_attr_version.attr,
+	&dev_attr_product_id.attr,
+	&dev_attr_power_en.attr,
+	&dev_attr_debug_en.attr,
+#ifdef HIDEEP_SUPPORT_STYLUS
+	&dev_attr_stylus_en.attr,
+#endif
+	NULL
+};
+
+static struct attribute_group hideep_ts_attr_group = {
+	.attrs = hideep_ts_sysfs_entries,
+};
+
+int hideep_sysfs_init(struct hideep_t *ts)
+{
+	int ret;
+	struct i2c_client *client = ts->client;
+
+	/* Create the files associated with this kobject */
+	ret = sysfs_create_group(&client->dev.kobj, &hideep_ts_attr_group);
+
+	dev_info(&ts->client->dev, "device : %s ", client->dev.kobj.name);
+
+	if (ret)
+		dev_err(&ts->client->dev, "%s: Fail create link error = %d\n",
+			 __func__, ret);
+
+	return ret;
+}
+
+int hideep_sysfs_exit(struct hideep_t *ts)
+{
+	struct i2c_client *client = ts->client;
+
+	sysfs_remove_group(&client->dev.kobj, &hideep_ts_attr_group);
+
+	return 0;
+}
-- 
2.7.4

