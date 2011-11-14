From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 1/7] Input: cyttsp - move up into main touchscreen directory
Date: Mon, 14 Nov 2011 00:15:46 -0800
Message-ID: <20111114081546.10141.5142.stgit@hammer.corenet.prv>
References: <20111114080939.10141.46174.stgit@hammer.corenet.prv>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:50959 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752086Ab1KNIPw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Nov 2011 03:15:52 -0500
Received: by ywt32 with SMTP id 32so1937786ywt.19
        for <linux-input@vger.kernel.org>; Mon, 14 Nov 2011 00:15:51 -0800 (PST)
In-Reply-To: <20111114080939.10141.46174.stgit@hammer.corenet.prv>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Javier Martinez Canillas <martinez.javier@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, Mohan Pallaka <mpallaka@codeaurora.org>, Kevin McNeely <kev@cypress.com>, Shubhrajyoti Datta <omaplinuxkernel@gmail.com>, linux-input@vger.kernel.org

All the other touchscreen drivers do not use separate directories
so let's follow the same suit.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/touchscreen/Kconfig              |   39 +
 drivers/input/touchscreen/Makefile             |    4 
 drivers/input/touchscreen/cyttsp/Kconfig       |   36 -
 drivers/input/touchscreen/cyttsp/Makefile      |    3 
 drivers/input/touchscreen/cyttsp/cyttsp_core.c |  768 ------------------------
 drivers/input/touchscreen/cyttsp/cyttsp_core.h |   59 --
 drivers/input/touchscreen/cyttsp/cyttsp_i2c.c  |  178 ------
 drivers/input/touchscreen/cyttsp/cyttsp_spi.c  |  275 ---------
 drivers/input/touchscreen/cyttsp_core.c        |  767 ++++++++++++++++++++++++
 drivers/input/touchscreen/cyttsp_core.h        |   59 ++
 drivers/input/touchscreen/cyttsp_i2c.c         |  178 ++++++
 drivers/input/touchscreen/cyttsp_spi.c         |  274 +++++++++
 12 files changed, 1318 insertions(+), 1322 deletions(-)
 delete mode 100644 drivers/input/touchscreen/cyttsp/Kconfig
 delete mode 100644 drivers/input/touchscreen/cyttsp/Makefile
 delete mode 100644 drivers/input/touchscreen/cyttsp/cyttsp_core.c
 delete mode 100644 drivers/input/touchscreen/cyttsp/cyttsp_core.h
 delete mode 100644 drivers/input/touchscreen/cyttsp/cyttsp_i2c.c
 delete mode 100644 drivers/input/touchscreen/cyttsp/cyttsp_spi.c
 create mode 100644 drivers/input/touchscreen/cyttsp_core.c
 create mode 100644 drivers/input/touchscreen/cyttsp_core.h
 create mode 100644 drivers/input/touchscreen/cyttsp_i2c.c
 create mode 100644 drivers/input/touchscreen/cyttsp_spi.c

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 6e918f8..9537404 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -136,6 +136,43 @@ config TOUCHSCREEN_CY8CTMG110
 	  To compile this driver as a module, choose M here: the
 	  module will be called cy8ctmg110_ts.
 
+config TOUCHSCREEN_CYTTSP_CORE
+	tristate "Cypress TTSP touchscreen core"
+	depends on INPUT_TOUCHSCREEN
+	help
+          Say Y here if you have a touchscreen interface using one
+          controller from the Cypress TrueTouch(tm) Standard Product
+	  family.
+
+	  If unsure, say N.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called cyttsp_core.
+
+config TOUCHSCREEN_CYTTSP_I2C
+	tristate "Cypress TTSP i2c touchscreen"
+	depends on I2C && TOUCHSCREEN_CYTTSP_CORE
+	help
+	  Say Y here if you have a Cypress TTSP touchscreen
+	  connected to your system with an I2C interface.
+
+	  If unsure, say N.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called cyttsp_i2c.
+
+config TOUCHSCREEN_CYTTSP_SPI
+	tristate "Cypress TTSP spi touchscreen"
+	depends on SPI_MASTER && TOUCHSCREEN_CYTTSP_CORE
+	help
+	  Say Y here if you have a Cypress TTSP touchscreen
+	  connected to your  with an SPI interface.
+
+	  If unsure, say N.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called cyttsp_spi.
+
 config TOUCHSCREEN_DA9034
 	tristate "Touchscreen support for Dialog Semiconductor DA9034"
 	depends on PMIC_DA903X
@@ -775,6 +812,4 @@ config TOUCHSCREEN_TPS6507X
 	  To compile this driver as a module, choose M here: the
 	  module will be called tps6507x_ts.
 
-source "drivers/input/touchscreen/cyttsp/Kconfig"
-
 endif
diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
index d697e16..d1848e7 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -17,6 +17,9 @@ obj-$(CONFIG_TOUCHSCREEN_ATMEL_TSADCC)	+= atmel_tsadcc.o
 obj-$(CONFIG_TOUCHSCREEN_BITSY)		+= h3600_ts_input.o
 obj-$(CONFIG_TOUCHSCREEN_BU21013)       += bu21013_ts.o
 obj-$(CONFIG_TOUCHSCREEN_CY8CTMG110)	+= cy8ctmg110_ts.o
+obj-$(CONFIG_TOUCHSCREEN_CYTTSP_CORE)   += cyttsp_core.o
+obj-$(CONFIG_TOUCHSCREEN_CYTTSP_I2C)    += cyttsp_i2c.o
+obj-$(CONFIG_TOUCHSCREEN_CYTTSP_SPI)    += cyttsp_spi.o
 obj-$(CONFIG_TOUCHSCREEN_DA9034)	+= da9034-ts.o
 obj-$(CONFIG_TOUCHSCREEN_DA9052)	+= da9052_tsi.o
 obj-$(CONFIG_TOUCHSCREEN_DYNAPRO)	+= dynapro.o
@@ -64,4 +67,3 @@ obj-$(CONFIG_TOUCHSCREEN_WM97XX_MAINSTONE)	+= mainstone-wm97xx.o
 obj-$(CONFIG_TOUCHSCREEN_WM97XX_ZYLONITE)	+= zylonite-wm97xx.o
 obj-$(CONFIG_TOUCHSCREEN_W90X900)	+= w90p910_ts.o
 obj-$(CONFIG_TOUCHSCREEN_TPS6507X)	+= tps6507x-ts.o
-obj-$(CONFIG_TOUCHSCREEN_CYTTSP_CORE)	+= cyttsp/
diff --git a/drivers/input/touchscreen/cyttsp/Kconfig b/drivers/input/touchscreen/cyttsp/Kconfig
deleted file mode 100644
index c8bc322..0000000
--- a/drivers/input/touchscreen/cyttsp/Kconfig
+++ /dev/null
@@ -1,36 +0,0 @@
-config TOUCHSCREEN_CYTTSP_CORE
-	tristate "Cypress TTSP touchscreen core"
-	depends on INPUT_TOUCHSCREEN
-	help
-          Say Y here if you have a touchscreen interface using one
-          controller from the Cypress TrueTouch(tm) Standard Product
-	  family.
-
-	  If unsure, say N.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called cyttsp_core.
-
-config TOUCHSCREEN_CYTTSP_I2C
-	tristate "Cypress TTSP i2c touchscreen"
-	depends on I2C && TOUCHSCREEN_CYTTSP_CORE
-	help
-	  Say Y here if you have a Cypress TTSP touchscreen
-	  connected to your system with an I2C interface.
-
-	  If unsure, say N.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called cyttsp_i2c.
-
-config TOUCHSCREEN_CYTTSP_SPI
-	tristate "Cypress TTSP spi touchscreen"
-	depends on SPI_MASTER && TOUCHSCREEN_CYTTSP_CORE
-	help
-	  Say Y here if you have a Cypress TTSP touchscreen
-	  connected to your  with an SPI interface.
-
-	  If unsure, say N.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called cyttsp_spi.
diff --git a/drivers/input/touchscreen/cyttsp/Makefile b/drivers/input/touchscreen/cyttsp/Makefile
deleted file mode 100644
index 687eeaa..0000000
--- a/drivers/input/touchscreen/cyttsp/Makefile
+++ /dev/null
@@ -1,3 +0,0 @@
-obj-$(CONFIG_TOUCHSCREEN_CYTTSP_CORE)   += cyttsp_core.o
-obj-$(CONFIG_TOUCHSCREEN_CYTTSP_I2C)    += cyttsp_i2c.o
-obj-$(CONFIG_TOUCHSCREEN_CYTTSP_SPI)    += cyttsp_spi.o
diff --git a/drivers/input/touchscreen/cyttsp/cyttsp_core.c b/drivers/input/touchscreen/cyttsp/cyttsp_core.c
deleted file mode 100644
index 240998d..0000000
--- a/drivers/input/touchscreen/cyttsp/cyttsp_core.c
+++ /dev/null
@@ -1,768 +0,0 @@
-/*
- * Core Source for:
- * Cypress TrueTouch(TM) Standard Product (TTSP) touchscreen drivers.
- * For use with Cypress Txx3xx parts.
- * Supported parts include:
- * CY8CTST341
- * CY8CTMA340
- *
- * Copyright (C) 2009, 2010, 2011 Cypress Semiconductor, Inc.
- * Copyright (C) 2011 Javier Martinez Canillas <martinez.javier@gmail.com>
- *
- * Multi-touch protocol type B support and cleanups by Javier Martinez Canillas
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2, and only version 2, as published by the
- * Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
- *
- * Contact Cypress Semiconductor at www.cypress.com <kev@cypress.com>
- *
- */
-
-#include "cyttsp_core.h"
-
-#include <linux/delay.h>
-#include <linux/input.h>
-#include <linux/input/mt.h>
-#include <linux/gpio.h>
-#include <linux/interrupt.h>
-#include <linux/slab.h>
-
-/* Bootloader number of command keys */
-#define CY_NUM_BL_KEYS    8
-
-/* helpers */
-#define GET_NUM_TOUCHES(x)          ((x) & 0x0F)
-#define IS_LARGE_AREA(x)            (((x) & 0x10) >> 4)
-#define IS_BAD_PKT(x)               ((x) & 0x20)
-#define IS_VALID_APP(x)             ((x) & 0x01)
-#define IS_OPERATIONAL_ERR(x)       ((x) & 0x3F)
-#define GET_HSTMODE(reg)            ((reg & 0x70) >> 4)
-#define GET_BOOTLOADERMODE(reg)     ((reg & 0x10) >> 4)
-
-#define CY_REG_BASE                 0x00
-#define CY_REG_ACT_DIST             0x1E
-#define CY_REG_ACT_INTRVL           0x1D
-#define CY_REG_TCH_TMOUT            (CY_REG_ACT_INTRVL+1)
-#define CY_REG_LP_INTRVL            (CY_REG_TCH_TMOUT+1)
-#define CY_MAXZ                     255
-#define CY_DELAY_DFLT               20 /* ms */
-#define CY_DELAY_MAX                (500/CY_DELAY_DFLT) /* half second */
-#define CY_ACT_DIST_DFLT            0xF8
-#define CY_HNDSHK_BIT               0x80
-/* device mode bits */
-#define CY_OPERATE_MODE             0x00
-#define CY_SYSINFO_MODE             0x10
-/* power mode select bits */
-#define CY_SOFT_RESET_MODE          0x01 /* return to Bootloader mode */
-#define CY_DEEP_SLEEP_MODE          0x02
-#define CY_LOW_POWER_MODE           0x04
-
-/* Slots management */
-#define CY_MAX_FINGER               4
-#define CY_MAX_ID                   16
-
-struct cyttsp_tch {
-	__be16 x, y;
-	u8 z;
-} __packed;
-
-/* TrueTouch Standard Product Gen3 interface definition */
-struct cyttsp_xydata {
-	u8 hst_mode;
-	u8 tt_mode;
-	u8 tt_stat;
-	struct cyttsp_tch tch1;
-	u8 touch12_id;
-	struct cyttsp_tch tch2;
-	u8 gest_cnt;
-	u8 gest_id;
-	struct cyttsp_tch tch3;
-	u8 touch34_id;
-	struct cyttsp_tch tch4;
-	u8 tt_undef[3];
-	u8 act_dist;
-	u8 tt_reserved;
-} __packed;
-
-/* TTSP System Information interface definition */
-struct cyttsp_sysinfo_data {
-	u8 hst_mode;
-	u8 mfg_cmd;
-	u8 mfg_stat;
-	u8 cid[3];
-	u8 tt_undef1;
-	u8 uid[8];
-	u8 bl_verh;
-	u8 bl_verl;
-	u8 tts_verh;
-	u8 tts_verl;
-	u8 app_idh;
-	u8 app_idl;
-	u8 app_verh;
-	u8 app_verl;
-	u8 tt_undef[5];
-	u8 scn_typ;
-	u8 act_intrvl;
-	u8 tch_tmout;
-	u8 lp_intrvl;
-};
-
-/* TTSP Bootloader Register Map interface definition */
-#define CY_BL_CHKSUM_OK 0x01
-struct cyttsp_bootloader_data {
-	u8 bl_file;
-	u8 bl_status;
-	u8 bl_error;
-	u8 blver_hi;
-	u8 blver_lo;
-	u8 bld_blver_hi;
-	u8 bld_blver_lo;
-	u8 ttspver_hi;
-	u8 ttspver_lo;
-	u8 appid_hi;
-	u8 appid_lo;
-	u8 appver_hi;
-	u8 appver_lo;
-	u8 cid_0;
-	u8 cid_1;
-	u8 cid_2;
-};
-
-struct cyttsp {
-	struct device *dev;
-	int irq;
-	struct input_dev *input;
-	char phys[32];
-	const struct cyttsp_platform_data *platform_data;
-	struct cyttsp_bus_ops *bus_ops;
-	struct cyttsp_bootloader_data bl_data;
-	struct cyttsp_sysinfo_data sysinfo_data;
-	struct completion bl_ready;
-	enum cyttsp_powerstate power_state;
-};
-
-static const u8 bl_command[] = {
-	0x00,			/* file offset */
-	0xFF,			/* command */
-	0xA5,			/* exit bootloader command */
-	0, 1, 2, 3, 4, 5, 6, 7	/* default keys */
-};
-
-static int ttsp_read_block_data(struct cyttsp *ts, u8 command,
-	u8 length, void *buf)
-{
-	int retval = -1;
-	int tries;
-
-	if (!buf || !length)
-		return -EINVAL;
-
-	for (tries = 0; tries < CY_NUM_RETRY && (retval < 0); tries++) {
-		retval = ts->bus_ops->read(ts->bus_ops, command, length, buf);
-		if (retval)
-			msleep(CY_DELAY_DFLT);
-	}
-
-	return retval;
-}
-
-static int ttsp_write_block_data(struct cyttsp *ts, u8 command,
-	u8 length, void *buf)
-{
-	int retval = -1;
-	int tries;
-
-	if (!buf || !length)
-		return -EINVAL;
-
-	for (tries = 0; tries < CY_NUM_RETRY && (retval < 0); tries++) {
-		retval = ts->bus_ops->write(ts->bus_ops, command, length, buf);
-		if (retval)
-			msleep(CY_DELAY_DFLT);
-	}
-
-	return retval;
-}
-
-static int cyttsp_load_bl_regs(struct cyttsp *ts)
-{
-	memset(&(ts->bl_data), 0, sizeof(struct cyttsp_bootloader_data));
-
-	ts->bl_data.bl_status = 0x10;
-
-	return  ttsp_read_block_data(ts, CY_REG_BASE, sizeof(ts->bl_data),
-				     &ts->bl_data);
-}
-
-static int cyttsp_bl_app_valid(struct cyttsp *ts)
-{
-	int retval;
-
-	retval = cyttsp_load_bl_regs(ts);
-
-	if (retval < 0) {
-		retval = -ENODEV;
-		goto done;
-	}
-
-	if (GET_BOOTLOADERMODE(ts->bl_data.bl_status)) {
-		if (IS_VALID_APP(ts->bl_data.bl_status))
-			return 0;
-		else
-			return -ENODEV;
-	}
-
-	if (GET_HSTMODE(ts->bl_data.bl_file) == CY_OPERATE_MODE) {
-		if (!(IS_OPERATIONAL_ERR(ts->bl_data.bl_status)))
-			return 1;
-		else
-			return -ENODEV;
-	}
-
-	retval = -ENODEV;
-done:
-	return retval;
-}
-
-static int cyttsp_exit_bl_mode(struct cyttsp *ts)
-{
-	int retval;
-	int tries;
-	u8 bl_cmd[sizeof(bl_command)];
-
-	memcpy(bl_cmd, bl_command, sizeof(bl_command));
-	if (ts->platform_data->bl_keys)
-		memcpy(&bl_cmd[sizeof(bl_command) - CY_NUM_BL_KEYS],
-			ts->platform_data->bl_keys, sizeof(bl_command));
-
-	retval = ttsp_write_block_data(ts, CY_REG_BASE,
-		sizeof(bl_cmd), (void *)bl_cmd);
-
-	if (retval < 0)
-		return retval;
-
-	/* wait for TTSP Device to complete switch to Operational mode */
-	tries = 0;
-	do {
-		msleep(CY_DELAY_DFLT);
-		retval = cyttsp_load_bl_regs(ts);
-	} while ((retval || GET_BOOTLOADERMODE(ts->bl_data.bl_status)) &&
-		(tries++ < CY_DELAY_MAX));
-
-	if (tries >= CY_DELAY_MAX)
-		return -ENODEV;
-
-	return retval;
-}
-
-static int cyttsp_set_operational_mode(struct cyttsp *ts)
-{
-	struct cyttsp_xydata xy_data;
-	int retval;
-	int tries = 0;
-	u8 cmd = CY_OPERATE_MODE;
-
-	retval = ttsp_write_block_data(ts, CY_REG_BASE, sizeof(cmd), &cmd);
-
-	if (retval < 0)
-		return retval;
-
-	/* wait for TTSP Device to complete switch to Operational mode */
-	do {
-		retval = ttsp_read_block_data(ts, CY_REG_BASE,
-			sizeof(xy_data), &(xy_data));
-	} while ((retval || xy_data.act_dist != CY_ACT_DIST_DFLT) &&
-		 (tries++ < CY_DELAY_MAX));
-
-	if (tries >= CY_DELAY_MAX)
-		return -EAGAIN;
-
-	return retval;
-}
-
-static int cyttsp_set_sysinfo_mode(struct cyttsp *ts)
-{
-	int retval;
-	int tries;
-	u8 cmd = CY_SYSINFO_MODE;
-
-	memset(&(ts->sysinfo_data), 0, sizeof(struct cyttsp_sysinfo_data));
-
-	/* switch to sysinfo mode */
-	retval = ttsp_write_block_data(ts, CY_REG_BASE, sizeof(cmd), &cmd);
-	if (retval < 0)
-		return retval;
-
-	/* read sysinfo registers */
-	tries = 0;
-	do {
-		msleep(CY_DELAY_DFLT);
-		retval = ttsp_read_block_data(ts, CY_REG_BASE,
-			sizeof(ts->sysinfo_data), &ts->sysinfo_data);
-	} while ((retval || (!ts->sysinfo_data.tts_verh &&
-			     !ts->sysinfo_data.tts_verl)) &&
-		 (tries++ < CY_DELAY_MAX));
-
-	if (tries >= CY_DELAY_MAX)
-		return -EAGAIN;
-
-	return retval;
-}
-
-static int cyttsp_set_sysinfo_regs(struct cyttsp *ts)
-{
-	int retval = 0;
-
-	if (ts->platform_data->act_intrvl != CY_ACT_INTRVL_DFLT ||
-		ts->platform_data->tch_tmout != CY_TCH_TMOUT_DFLT ||
-		ts->platform_data->lp_intrvl != CY_LP_INTRVL_DFLT) {
-
-		u8 intrvl_ray[3];
-
-		intrvl_ray[0] = ts->platform_data->act_intrvl;
-		intrvl_ray[1] = ts->platform_data->tch_tmout;
-		intrvl_ray[2] = ts->platform_data->lp_intrvl;
-
-		/* set intrvl registers */
-		retval = ttsp_write_block_data(ts,
-				CY_REG_ACT_INTRVL,
-				sizeof(intrvl_ray), intrvl_ray);
-
-		msleep(CY_DELAY_DFLT);
-	}
-
-	return retval;
-}
-
-static int cyttsp_soft_reset(struct cyttsp *ts)
-{
-	int retval;
-	u8 cmd = CY_SOFT_RESET_MODE;
-	long wait_jiffies = msecs_to_jiffies(CY_DELAY_DFLT * CY_DELAY_MAX);
-	/* wait for interrupt to set ready completion */
-	INIT_COMPLETION(ts->bl_ready);
-
-	retval = ttsp_write_block_data(ts, CY_REG_BASE, sizeof(cmd), &cmd);
-	if (retval < 0)
-		return retval;
-
-	return wait_for_completion_timeout(&ts->bl_ready, wait_jiffies);
-}
-
-static int cyttsp_act_dist_setup(struct cyttsp *ts)
-{
-	int retval;
-	u8 act_dist_setup;
-
-	/* Init gesture; active distance setup */
-	act_dist_setup = ts->platform_data->act_dist;
-	retval = ttsp_write_block_data(ts, CY_REG_ACT_DIST,
-		sizeof(act_dist_setup), &act_dist_setup);
-
-	return retval;
-}
-
-static int cyttsp_hndshk(struct cyttsp *ts, u8 hst_mode)
-{
-	u8 cmd;
-
-	cmd = hst_mode ^ CY_HNDSHK_BIT;
-
-	return ttsp_write_block_data(ts, CY_REG_BASE, sizeof(cmd), (u8 *)&cmd);
-}
-
-static void cyttsp_report_slot(struct input_dev *dev, int slot,
-			       int x, int y, int z)
-{
-	input_mt_slot(dev, slot);
-	input_mt_report_slot_state(dev, MT_TOOL_FINGER, true);
-	input_report_abs(dev, ABS_MT_POSITION_X, x);
-	input_report_abs(dev, ABS_MT_POSITION_Y, y);
-	input_report_abs(dev, ABS_MT_TOUCH_MAJOR, z);
-}
-
-static void cyttsp_report_slot_empty(struct input_dev *dev, int slot)
-{
-	input_mt_slot(dev, slot);
-	input_mt_report_slot_state(dev, MT_TOOL_FINGER, false);
-}
-
-static void cyttsp_extract_track_ids(struct cyttsp_xydata *xy_data, int *ids)
-{
-	ids[0] = xy_data->touch12_id >> 4;
-	ids[1] = xy_data->touch12_id & 0xF;
-	ids[2] = xy_data->touch34_id >> 4;
-	ids[3] = xy_data->touch34_id & 0xF;
-}
-
-static const struct cyttsp_tch *cyttsp_get_tch(struct cyttsp_xydata *xy_data,
-					       int idx)
-{
-	switch (idx) {
-	case 0:
-		return &xy_data->tch1;
-	case 1:
-		return &xy_data->tch2;
-	case 2:
-		return &xy_data->tch3;
-	case 3:
-		return  &xy_data->tch4;
-	default:
-		return NULL;
-	}
-}
-
-static int cyttsp_handle_tchdata(struct cyttsp *ts)
-{
-	struct cyttsp_xydata xy_data;
-	u8 num_cur_tch;
-	int i;
-	int ids[4];
-	const struct cyttsp_tch *tch = NULL;
-	int x, y, z;
-	int used = 0;
-
-	/* Get touch data from CYTTSP device */
-	if (ttsp_read_block_data(ts,
-		CY_REG_BASE, sizeof(struct cyttsp_xydata), &xy_data))
-		return 0;
-
-	/* provide flow control handshake */
-	if (ts->platform_data->use_hndshk)
-		if (cyttsp_hndshk(ts, xy_data.hst_mode))
-			return 0;
-
-	/* determine number of currently active touches */
-	num_cur_tch = GET_NUM_TOUCHES(xy_data.tt_stat);
-
-	/* check for any error conditions */
-	if (ts->power_state == CY_IDLE_STATE)
-		return 0;
-	else if (GET_BOOTLOADERMODE(xy_data.tt_mode)) {
-		return -1;
-	} else if (IS_LARGE_AREA(xy_data.tt_stat) == 1) {
-		/* terminate all active tracks */
-		num_cur_tch = 0;
-		dev_dbg(ts->dev, "%s: Large area detected\n", __func__);
-	} else if (num_cur_tch > CY_MAX_FINGER) {
-		/* terminate all active tracks */
-		num_cur_tch = 0;
-		dev_dbg(ts->dev, "%s: Num touch error detected\n", __func__);
-	} else if (IS_BAD_PKT(xy_data.tt_mode)) {
-		/* terminate all active tracks */
-		num_cur_tch = 0;
-		dev_dbg(ts->dev, "%s: Invalid buffer detected\n", __func__);
-	}
-
-	cyttsp_extract_track_ids(&xy_data, ids);
-
-	for (i = 0; i < num_cur_tch; i++) {
-		used |= (1 << ids[i]);
-
-		tch = cyttsp_get_tch(&xy_data, i);
-
-		x = be16_to_cpu(tch->x);
-		y = be16_to_cpu(tch->y);
-		z = tch->z;
-
-		cyttsp_report_slot(ts->input, ids[i], x, y, z);
-	}
-
-	for (i = 0; i < CY_MAX_ID; i++)
-		if (!(used & (1 << i)))
-			cyttsp_report_slot_empty(ts->input, i);
-
-	input_sync(ts->input);
-
-	return 0;
-}
-
-static void cyttsp_pr_state(struct cyttsp *ts)
-{
-	static char *cyttsp_powerstate_string[] = {
-		"IDLE",
-		"ACTIVE",
-		"LOW_PWR",
-		"SLEEP",
-		"BOOTLOADER",
-		"INVALID"
-	};
-
-	dev_info(ts->dev, "%s: %s\n", __func__,
-		ts->power_state < CY_INVALID_STATE ?
-		cyttsp_powerstate_string[ts->power_state] :
-		"INVALID");
-}
-
-static irqreturn_t cyttsp_irq(int irq, void *handle)
-{
-	struct cyttsp *ts = handle;
-	int retval;
-
-	if (ts->power_state == CY_BL_STATE)
-		complete(&ts->bl_ready);
-	else {
-		/* process the touches */
-		retval = cyttsp_handle_tchdata(ts);
-
-		if (retval < 0) {
-			/*
-			 * TTSP device has reset back to bootloader mode.
-			 * Restore to operational mode.
-			 */
-			retval = cyttsp_exit_bl_mode(ts);
-			if (retval)
-				ts->power_state = CY_IDLE_STATE;
-			else
-				ts->power_state = CY_ACTIVE_STATE;
-			cyttsp_pr_state(ts);
-		}
-	}
-
-	return IRQ_HANDLED;
-}
-
-static int cyttsp_power_on(struct cyttsp *ts)
-{
-	int retval = 0;
-
-	if (!ts)
-		return -ENOMEM;
-
-	ts->power_state = CY_BL_STATE;
-
-	/* enable interrupts */
-	retval = request_threaded_irq(ts->irq, NULL, cyttsp_irq,
-		IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
-		ts->platform_data->name, ts);
-	if (retval < 0)
-		goto bypass;
-
-	retval = cyttsp_soft_reset(ts);
-	if (retval == 0)
-		goto bypass;
-
-	retval = cyttsp_bl_app_valid(ts);
-	if (retval < 0)
-		goto bypass;
-	else if (retval > 0)
-		goto no_bl_bypass;
-
-	retval = cyttsp_exit_bl_mode(ts);
-
-	if (retval < 0)
-		goto bypass;
-
-	ts->power_state = CY_IDLE_STATE;
-
-no_bl_bypass:
-	retval = cyttsp_set_sysinfo_mode(ts);
-	if (retval < 0)
-		goto bypass;
-
-	retval = cyttsp_set_sysinfo_regs(ts);
-	if (retval < 0)
-		goto bypass;
-
-	retval = cyttsp_set_operational_mode(ts);
-	if (retval < 0)
-		goto bypass;
-
-	/* init active distance */
-	retval = cyttsp_act_dist_setup(ts);
-	if (retval < 0)
-		goto bypass;
-
-	ts->power_state = CY_ACTIVE_STATE;
-	retval = 0;
-
-bypass:
-	cyttsp_pr_state(ts);
-	return retval;
-}
-
-#ifdef CONFIG_PM
-int cyttsp_resume(void *handle)
-{
-	struct cyttsp *ts = handle;
-	int retval = 0;
-	struct cyttsp_xydata xydata;
-
-	if (!ts)
-		return retval;
-
-	if (ts->platform_data->use_sleep && (ts->power_state !=
-					     CY_ACTIVE_STATE)) {
-
-		if (ts->platform_data->wakeup)
-			retval = ts->platform_data->wakeup();
-		else
-			retval = -ENOSYS;
-
-		if (retval >= 0) {
-			retval = ttsp_read_block_data(ts, CY_REG_BASE,
-						      sizeof(xydata),
-						      &xydata);
-			if (retval >= 0 &&
-			    !GET_HSTMODE(xydata.hst_mode))
-				ts->power_state = CY_ACTIVE_STATE;
-		}
-	}
-
-	return retval;
-}
-EXPORT_SYMBOL_GPL(cyttsp_resume);
-
-int cyttsp_suspend(void *handle)
-{
-	struct cyttsp *ts = handle;
-	u8 sleep_mode = 0;
-	int retval = 0;
-
-	if (ts->platform_data->use_sleep &&
-		(ts->power_state == CY_ACTIVE_STATE)) {
-		sleep_mode = ts->platform_data->use_sleep;
-		retval = ttsp_write_block_data(ts,
-			CY_REG_BASE, sizeof(sleep_mode), &sleep_mode);
-		if (retval >= 0)
-			ts->power_state = CY_SLEEP_STATE;
-	}
-
-	return retval;
-}
-EXPORT_SYMBOL_GPL(cyttsp_suspend);
-#endif
-
-static int cyttsp_open(struct input_dev *dev)
-{
-	struct cyttsp *ts = input_get_drvdata(dev);
-
-	return cyttsp_power_on(ts);
-}
-
-void cyttsp_core_release(void *handle)
-{
-	struct cyttsp *ts = handle;
-
-	if (ts) {
-		free_irq(ts->irq, ts);
-		input_unregister_device(ts->input);
-		if (ts->platform_data->exit)
-			ts->platform_data->exit();
-		kfree(ts);
-	}
-}
-EXPORT_SYMBOL_GPL(cyttsp_core_release);
-
-static void cyttsp_close(struct input_dev *dev)
-{
-	struct cyttsp *ts = input_get_drvdata(dev);
-
-	free_irq(ts->irq, ts);
-}
-
-void *cyttsp_core_init(struct cyttsp_bus_ops *bus_ops,
-		       struct device *dev, int irq)
-{
-	struct input_dev *input_device;
-	int ret;
-
-	struct cyttsp *ts = kzalloc(sizeof(*ts), GFP_KERNEL);
-
-	if (!ts) {
-		pr_err("%s: Error, kzalloc\n", __func__);
-		goto error_alloc_data;
-	}
-
-	if (dev == NULL || bus_ops == NULL) {
-		kfree(ts);
-		goto error_alloc_data;
-	}
-
-	ts->dev = dev;
-	ts->platform_data = dev->platform_data;
-	ts->bus_ops = bus_ops;
-	init_completion(&ts->bl_ready);
-
-	if (ts->platform_data->init) {
-		if (ts->platform_data->init()) {
-			dev_dbg(ts->dev, "%s: Error, platform init failed!\n",
-				__func__);
-			goto error_init;
-		}
-	}
-
-	ts->irq = irq;
-	if (ts->irq <= 0) {
-		dev_dbg(ts->dev, "%s: Error, failed to allocate irq\n",
-			__func__);
-			goto error_init;
-	}
-
-	/* Create the input device and register it. */
-	input_device = input_allocate_device();
-	if (!input_device) {
-		dev_dbg(ts->dev, "%s: Error, failed to allocate input device\n",
-			__func__);
-		goto error_input_allocate_device;
-	}
-
-	ts->input = input_device;
-	input_device->name = ts->platform_data->name;
-	snprintf(ts->phys, sizeof(ts->phys), "%s", dev_name(dev));
-	input_device->phys = ts->phys;
-	input_device->dev.parent = ts->dev;
-	input_device->open = cyttsp_open;
-	input_device->close = cyttsp_close;
-	input_set_drvdata(input_device, ts);
-
-	__set_bit(EV_SYN, input_device->evbit);
-	__set_bit(EV_KEY, input_device->evbit);
-	__set_bit(EV_ABS, input_device->evbit);
-
-	input_set_abs_params(input_device, ABS_MT_POSITION_X,
-			     0, ts->platform_data->maxx, 0, 0);
-	input_set_abs_params(input_device, ABS_MT_POSITION_Y,
-			     0, ts->platform_data->maxy, 0, 0);
-	input_set_abs_params(input_device, ABS_MT_TOUCH_MAJOR,
-			     0, CY_MAXZ, 0, 0);
-
-	input_mt_init_slots(input_device, CY_MAX_ID);
-
-	ret = input_register_device(input_device);
-	if (ret) {
-		dev_err(ts->dev, "%s: Error, failed to register input device: %d\n",
-			__func__, ret);
-		goto error_input_register_device;
-	}
-
-	goto no_error;
-
-error_input_register_device:
-	input_free_device(input_device);
-error_input_allocate_device:
-	if (ts->platform_data->exit)
-		ts->platform_data->exit();
-error_init:
-	kfree(ts);
-error_alloc_data:
-no_error:
-	return ts;
-}
-EXPORT_SYMBOL_GPL(cyttsp_core_init);
-
-MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("Cypress TrueTouch(R) Standard touchscreen driver core");
-MODULE_AUTHOR("Cypress");
-
diff --git a/drivers/input/touchscreen/cyttsp/cyttsp_core.h b/drivers/input/touchscreen/cyttsp/cyttsp_core.h
deleted file mode 100644
index c4c7d9e..0000000
--- a/drivers/input/touchscreen/cyttsp/cyttsp_core.h
+++ /dev/null
@@ -1,59 +0,0 @@
-/*
- * Header file for:
- * Cypress TrueTouch(TM) Standard Product (TTSP) touchscreen drivers.
- * For use with Cypress Txx3xx parts.
- * Supported parts include:
- * CY8CTST341
- * CY8CTMA340
- *
- * Copyright (C) 2009, 2010, 2011 Cypress Semiconductor, Inc.
- * Copyright (C) 2011 Javier Martinez Canillas <martinez.javier@gmail.com>
- *
- * Multi-touch protocol type B support and cleanups by Javier Martinez Canillas
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2, and only version 2, as published by the
- * Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
- *
- * Contact Cypress Semiconductor at www.cypress.com <kev@cypress.com>
- *
- */
-
-
-#ifndef __CYTTSP_CORE_H__
-#define __CYTTSP_CORE_H__
-
-#include <linux/kernel.h>
-#include <linux/err.h>
-#include <linux/module.h>
-#include <linux/input/cyttsp.h>
-
-#define CY_NUM_RETRY                4 /* max number of retries for read ops */
-
-
-struct cyttsp_bus_ops {
-	s32 (*write)(void *handle, u8 addr, u8 length, const void *values);
-	s32 (*read)(void *handle, u8 addr, u8 length, void *values);
-	struct device *dev;
-};
-
-void *cyttsp_core_init(struct cyttsp_bus_ops *bus_ops,
-		       struct device *dev, int irq);
-
-void cyttsp_core_release(void *handle);
-#ifdef CONFIG_PM
-int cyttsp_resume(void *handle);
-int cyttsp_suspend(void *handle);
-#endif
-
-#endif /* __CYTTSP_CORE_H__ */
diff --git a/drivers/input/touchscreen/cyttsp/cyttsp_i2c.c b/drivers/input/touchscreen/cyttsp/cyttsp_i2c.c
deleted file mode 100644
index d7d62d4..0000000
--- a/drivers/input/touchscreen/cyttsp/cyttsp_i2c.c
+++ /dev/null
@@ -1,178 +0,0 @@
-/*
- * Source for:
- * Cypress TrueTouch(TM) Standard Product (TTSP) I2C touchscreen driver.
- * For use with Cypress Txx3xx parts.
- * Supported parts include:
- * CY8CTST341
- * CY8CTMA340
- *
- * Copyright (C) 2009, 2010, 2011 Cypress Semiconductor, Inc.
- * Copyright (C) 2011 Javier Martinez Canillas <martinez.javier@gmail.com>
- *
- * Multi-touch protocol type B support and cleanups by Javier Martinez Canillas
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2, and only version 2, as published by the
- * Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
- *
- * Contact Cypress Semiconductor at www.cypress.com <kev@cypress.com>
- *
- */
-
-#include "cyttsp_core.h"
-
-#include <linux/i2c.h>
-#include <linux/slab.h>
-
-#define CY_I2C_DATA_SIZE  128
-
-struct cyttsp_i2c {
-	struct cyttsp_bus_ops ops;
-	struct i2c_client *client;
-	void *ttsp_client;
-	u8 wr_buf[CY_I2C_DATA_SIZE];
-};
-
-static s32 ttsp_i2c_read_block_data(void *handle, u8 addr,
-	u8 length, void *values)
-{
-	struct cyttsp_i2c *ts = container_of(handle, struct cyttsp_i2c, ops);
-	int retval = 0;
-
-	retval = i2c_master_send(ts->client, &addr, 1);
-	if (retval < 0)
-		return retval;
-
-	retval = i2c_master_recv(ts->client, values, length);
-
-	if (retval != length)
-		return -EIO;
-
-	return (retval < 0) ? retval : 0;
-}
-
-static s32 ttsp_i2c_write_block_data(void *handle, u8 addr,
-	u8 length, const void *values)
-{
-	struct cyttsp_i2c *ts = container_of(handle, struct cyttsp_i2c, ops);
-	int retval;
-
-	ts->wr_buf[0] = addr;
-	memcpy(&ts->wr_buf[1], values, length);
-
-	retval = i2c_master_send(ts->client, ts->wr_buf, length+1);
-
-	if (retval != length)
-		return -EIO;
-
-	return (retval < 0) ? retval : 0;
-}
-
-static int __devinit cyttsp_i2c_probe(struct i2c_client *client,
-	const struct i2c_device_id *id)
-{
-	struct cyttsp_i2c *ts;
-
-	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
-		return -EIO;
-
-	/* allocate and clear memory */
-	ts = kzalloc(sizeof(*ts), GFP_KERNEL);
-	if (!ts) {
-		dev_dbg(&client->dev, "%s: Error, kzalloc.\n", __func__);
-		return -ENOMEM;
-	}
-
-	/* register driver_data */
-	ts->client = client;
-	i2c_set_clientdata(client, ts);
-	ts->ops.write = ttsp_i2c_write_block_data;
-	ts->ops.read = ttsp_i2c_read_block_data;
-	ts->ops.dev = &client->dev;
-
-	ts->ttsp_client = cyttsp_core_init(&ts->ops, &client->dev, client->irq);
-	if (IS_ERR(ts->ttsp_client)) {
-		int retval = PTR_ERR(ts->ttsp_client);
-		kfree(ts);
-		return retval;
-	}
-
-	return 0;
-}
-
-
-/* registered in driver struct */
-static int __devexit cyttsp_i2c_remove(struct i2c_client *client)
-{
-	struct cyttsp_i2c *ts;
-
-	ts = i2c_get_clientdata(client);
-	cyttsp_core_release(ts->ttsp_client);
-	kfree(ts);
-	return 0;
-}
-
-#ifdef CONFIG_PM
-static int cyttsp_i2c_suspend(struct device *dev)
-{
-	struct i2c_client *client = to_i2c_client(dev);
-	struct cyttsp_i2c *ts = i2c_get_clientdata(client);
-
-	return cyttsp_suspend(ts->ttsp_client);
-}
-
-static int cyttsp_i2c_resume(struct device *dev)
-{
-	struct i2c_client *client = to_i2c_client(dev);
-	struct cyttsp_i2c *ts = i2c_get_clientdata(client);
-
-	return cyttsp_resume(ts->ttsp_client);
-}
-static SIMPLE_DEV_PM_OPS(cyttsp_i2c_pm, cyttsp_i2c_suspend, cyttsp_i2c_resume);
-#endif
-
-static const struct i2c_device_id cyttsp_i2c_id[] = {
-	{ CY_I2C_NAME, 0 },  { }
-};
-
-static struct i2c_driver cyttsp_i2c_driver = {
-	.driver = {
-		.name = CY_I2C_NAME,
-		.owner = THIS_MODULE,
-#ifdef CONFIG_PM
-		.pm = &cyttsp_i2c_pm,
-#endif
-	},
-	.probe = cyttsp_i2c_probe,
-	.remove = __devexit_p(cyttsp_i2c_remove),
-	.id_table = cyttsp_i2c_id,
-};
-
-static int __init cyttsp_i2c_init(void)
-{
-	return i2c_add_driver(&cyttsp_i2c_driver);
-}
-
-static void __exit cyttsp_i2c_exit(void)
-{
-	return i2c_del_driver(&cyttsp_i2c_driver);
-}
-
-module_init(cyttsp_i2c_init);
-module_exit(cyttsp_i2c_exit);
-
-MODULE_ALIAS("i2c:cyttsp");
-MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("Cypress TrueTouch(R) Standard Product (TTSP) I2C driver");
-MODULE_AUTHOR("Cypress");
-MODULE_DEVICE_TABLE(i2c, cyttsp_i2c_id);
diff --git a/drivers/input/touchscreen/cyttsp/cyttsp_spi.c b/drivers/input/touchscreen/cyttsp/cyttsp_spi.c
deleted file mode 100644
index 95dc7c8..0000000
--- a/drivers/input/touchscreen/cyttsp/cyttsp_spi.c
+++ /dev/null
@@ -1,275 +0,0 @@
-/*
- * Source for:
- * Cypress TrueTouch(TM) Standard Product (TTSP) SPI touchscreen driver.
- * For use with Cypress Txx3xx parts.
- * Supported parts include:
- * CY8CTST341
- * CY8CTMA340
- *
- * Copyright (C) 2009, 2010, 2011 Cypress Semiconductor, Inc.
- * Copyright (C) 2011 Javier Martinez Canillas <martinez.javier@gmail.com>
- *
- * Multi-touch protocol type B support and cleanups by Javier Martinez Canillas
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2, and only version 2, as published by the
- * Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
- *
- * Contact Cypress Semiconductor at www.cypress.com <kev@cypress.com>
- *
- */
-
-#include "cyttsp_core.h"
-
-#include <linux/spi/spi.h>
-#include <linux/delay.h>
-
-#define CY_SPI_WR_OP      0x00 /* r/~w */
-#define CY_SPI_RD_OP      0x01
-#define CY_SPI_CMD_BYTES  4
-#define CY_SPI_SYNC_BYTE  2
-#define CY_SPI_SYNC_ACK1  0x62 /* from protocol v.2 */
-#define CY_SPI_SYNC_ACK2  0x9D /* from protocol v.2 */
-#define CY_SPI_DATA_SIZE  128
-#define CY_SPI_DATA_BUF_SIZE (CY_SPI_CMD_BYTES + CY_SPI_DATA_SIZE)
-#define CY_SPI_BITS_PER_WORD 8
-
-struct cyttsp_spi {
-	struct cyttsp_bus_ops bus_ops;
-	struct spi_device *spi_client;
-	void *ttsp_client;
-	u8 wr_buf[CY_SPI_DATA_BUF_SIZE];
-	u8 rd_buf[CY_SPI_DATA_BUF_SIZE];
-};
-
-static int cyttsp_spi_xfer(u8 op, struct cyttsp_spi *ts,
-			   u8 reg, u8 *buf, int length)
-{
-	struct spi_message msg;
-	struct spi_transfer xfer[2];
-	u8 *wr_buf = ts->wr_buf;
-	u8 *rd_buf = ts->rd_buf;
-	int retval;
-
-	if (length > CY_SPI_DATA_SIZE) {
-		dev_dbg(ts->bus_ops.dev,
-			"%s: length %d is too big.\n",
-			__func__, length);
-		return -EINVAL;
-	}
-
-	memset(wr_buf, 0, CY_SPI_DATA_BUF_SIZE);
-	memset(rd_buf, 0, CY_SPI_DATA_BUF_SIZE);
-
-	wr_buf[0] = 0x00; /* header byte 0 */
-	wr_buf[1] = 0xFF; /* header byte 1 */
-	wr_buf[2] = reg;  /* reg index */
-	wr_buf[3] = op;   /* r/~w */
-	if (op == CY_SPI_WR_OP)
-		memcpy(wr_buf + CY_SPI_CMD_BYTES, buf, length);
-
-	memset((void *)xfer, 0, sizeof(xfer));
-	spi_message_init(&msg);
-
-	/*
-	  We set both TX and RX buffers because Cypress TTSP
-	  requires full duplex operation.
-	*/
-	xfer[0].tx_buf = wr_buf;
-	xfer[0].rx_buf = rd_buf;
-	if (op == CY_SPI_WR_OP) {
-		xfer[0].len = length + CY_SPI_CMD_BYTES;
-		spi_message_add_tail(&xfer[0], &msg);
-	} else if (op == CY_SPI_RD_OP) {
-		xfer[0].len = CY_SPI_CMD_BYTES;
-		spi_message_add_tail(&xfer[0], &msg);
-
-		xfer[1].rx_buf = buf;
-		xfer[1].len = length;
-		spi_message_add_tail(&xfer[1], &msg);
-	}
-
-	retval = spi_sync(ts->spi_client, &msg);
-	if (retval < 0) {
-		dev_dbg(ts->bus_ops.dev,
-			"%s: spi_sync() error %d, len=%d, op=%d\n",
-			__func__, retval, xfer[1].len, op);
-
-		/*
-		 * do not return here since was a bad ACK sequence
-		 * let the following ACK check handle any errors and
-		 * allow silent retries
-		 */
-	}
-
-	if ((rd_buf[CY_SPI_SYNC_BYTE] == CY_SPI_SYNC_ACK1) &&
-	    (rd_buf[CY_SPI_SYNC_BYTE+1] == CY_SPI_SYNC_ACK2))
-		retval = 0;
-	else {
-		int i;
-		for (i = 0; i < (CY_SPI_CMD_BYTES); i++)
-			dev_dbg(ts->bus_ops.dev,
-				"%s: test rd_buf[%d]:0x%02x\n",
-				__func__, i, rd_buf[i]);
-		for (i = 0; i < (length); i++)
-			dev_dbg(ts->bus_ops.dev,
-				"%s: test buf[%d]:0x%02x\n",
-				__func__, i, buf[i]);
-
-		/* signal ACK error so silent retry */
-		retval = 1;
-	}
-
-	return retval;
-}
-
-static s32 ttsp_spi_read_block_data(void *handle, u8 addr,
-				    u8 length, void *data)
-{
-	struct cyttsp_spi *ts =
-		container_of(handle, struct cyttsp_spi, bus_ops);
-	int retval;
-
-	retval = cyttsp_spi_xfer(CY_SPI_RD_OP, ts, addr, data, length);
-	if (retval < 0)
-		pr_err("%s: ttsp_spi_read_block_data failed\n",
-		       __func__);
-
-	/*
-	 * Do not print the above error if the data sync bytes were not found.
-	 * This is a normal condition for the bootloader loader startup and need
-	 * to retry until data sync bytes are found.
-	 */
-	if (retval > 0)
-		retval = -EIO;  /* now signal fail; so retry can be done */
-
-	return retval;
-}
-
-static s32 ttsp_spi_write_block_data(void *handle, u8 addr,
-				     u8 length, const void *data)
-{
-	struct cyttsp_spi *ts =
-		container_of(handle, struct cyttsp_spi, bus_ops);
-	int retval;
-
-	retval = cyttsp_spi_xfer(CY_SPI_WR_OP, ts, addr, (void *)data, length);
-	if (retval < 0)
-		pr_err("%s: ttsp_spi_write_block_data failed\n",
-		       __func__);
-
-	/*
-	 * Do not print the above error if the data sync bytes were not found.
-	 * This is a normal condition for the bootloader loader startup and need
-	 * to retry until data sync bytes are found.
-	 */
-	if (retval > 0)
-		retval = -EIO;  /* now signal fail; so retry can be done */
-
-	return retval;
-}
-
-static int __devinit cyttsp_spi_probe(struct spi_device *spi)
-{
-	struct cyttsp_spi *ts;
-	int retval;
-
-	/* Set up SPI*/
-	spi->bits_per_word = CY_SPI_BITS_PER_WORD;
-	spi->mode = SPI_MODE_0;
-	retval = spi_setup(spi);
-	if (retval < 0) {
-		dev_dbg(&spi->dev, "%s: SPI setup error %d\n",
-			__func__, retval);
-		return retval;
-	}
-
-	ts = kzalloc(sizeof(*ts), GFP_KERNEL);
-	if (!ts) {
-		dev_dbg(&spi->dev, "%s: Error, kzalloc\n", __func__);
-		return -ENOMEM;
-	}
-
-	ts->spi_client = spi;
-	dev_set_drvdata(&spi->dev, ts);
-	ts->bus_ops.write = ttsp_spi_write_block_data;
-	ts->bus_ops.read = ttsp_spi_read_block_data;
-	ts->bus_ops.dev = &spi->dev;
-
-	ts->ttsp_client = cyttsp_core_init(&ts->bus_ops, &spi->dev, spi->irq);
-	if (IS_ERR(ts->ttsp_client)) {
-		int retval = PTR_ERR(ts->ttsp_client);
-		kfree(ts);
-		return retval;
-	}
-
-	dev_dbg(ts->bus_ops.dev, "%s: Registration complete\n", __func__);
-
-	return 0;
-}
-
-static int __devexit cyttsp_spi_remove(struct spi_device *spi)
-{
-	struct cyttsp_spi *ts = dev_get_drvdata(&spi->dev);
-
-	cyttsp_core_release(ts->ttsp_client);
-	kfree(ts);
-	return 0;
-}
-
-#ifdef CONFIG_PM
-static int cyttsp_spi_suspend(struct device *dev)
-{
-	struct cyttsp_spi *ts = dev_get_drvdata(dev);
-
-	return cyttsp_suspend(ts->ttsp_client);
-}
-
-static int cyttsp_spi_resume(struct device *dev)
-{
-	struct cyttsp_spi *ts = dev_get_drvdata(dev);
-
-	return cyttsp_resume(ts->ttsp_client);
-}
-static SIMPLE_DEV_PM_OPS(cyttsp_spi_pm, cyttsp_spi_suspend, cyttsp_spi_resume);
-#endif
-
-static struct spi_driver cyttsp_spi_driver = {
-	.driver = {
-		.name = CY_SPI_NAME,
-		.owner = THIS_MODULE,
-#ifdef CONFIG_PM
-		.pm = &cyttsp_spi_pm,
-#endif
-	},
-	.probe = cyttsp_spi_probe,
-	.remove = __devexit_p(cyttsp_spi_remove),
-};
-
-static int __init cyttsp_spi_init(void)
-{
-	return spi_register_driver(&cyttsp_spi_driver);
-}
-module_init(cyttsp_spi_init);
-
-static void __exit cyttsp_spi_exit(void)
-{
-	spi_unregister_driver(&cyttsp_spi_driver);
-}
-module_exit(cyttsp_spi_exit);
-
-MODULE_ALIAS("spi:cyttsp");
-MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("Cypress TrueTouch(R) Standard Product (TTSP) SPI driver");
-MODULE_AUTHOR("Cypress");
-
diff --git a/drivers/input/touchscreen/cyttsp_core.c b/drivers/input/touchscreen/cyttsp_core.c
new file mode 100644
index 0000000..47a0958
--- /dev/null
+++ b/drivers/input/touchscreen/cyttsp_core.c
@@ -0,0 +1,767 @@
+/*
+ * Core Source for:
+ * Cypress TrueTouch(TM) Standard Product (TTSP) touchscreen drivers.
+ * For use with Cypress Txx3xx parts.
+ * Supported parts include:
+ * CY8CTST341
+ * CY8CTMA340
+ *
+ * Copyright (C) 2009, 2010, 2011 Cypress Semiconductor, Inc.
+ * Copyright (C) 2011 Javier Martinez Canillas <martinez.javier@gmail.com>
+ *
+ * Multi-touch protocol type B support and cleanups by Javier Martinez Canillas
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2, and only version 2, as published by the
+ * Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
+ *
+ * Contact Cypress Semiconductor at www.cypress.com <kev@cypress.com>
+ *
+ */
+
+#include "cyttsp_core.h"
+
+#include <linux/delay.h>
+#include <linux/input.h>
+#include <linux/input/mt.h>
+#include <linux/gpio.h>
+#include <linux/interrupt.h>
+#include <linux/slab.h>
+
+/* Bootloader number of command keys */
+#define CY_NUM_BL_KEYS    8
+
+/* helpers */
+#define GET_NUM_TOUCHES(x)          ((x) & 0x0F)
+#define IS_LARGE_AREA(x)            (((x) & 0x10) >> 4)
+#define IS_BAD_PKT(x)               ((x) & 0x20)
+#define IS_VALID_APP(x)             ((x) & 0x01)
+#define IS_OPERATIONAL_ERR(x)       ((x) & 0x3F)
+#define GET_HSTMODE(reg)            ((reg & 0x70) >> 4)
+#define GET_BOOTLOADERMODE(reg)     ((reg & 0x10) >> 4)
+
+#define CY_REG_BASE                 0x00
+#define CY_REG_ACT_DIST             0x1E
+#define CY_REG_ACT_INTRVL           0x1D
+#define CY_REG_TCH_TMOUT            (CY_REG_ACT_INTRVL+1)
+#define CY_REG_LP_INTRVL            (CY_REG_TCH_TMOUT+1)
+#define CY_MAXZ                     255
+#define CY_DELAY_DFLT               20 /* ms */
+#define CY_DELAY_MAX                (500/CY_DELAY_DFLT) /* half second */
+#define CY_ACT_DIST_DFLT            0xF8
+#define CY_HNDSHK_BIT               0x80
+/* device mode bits */
+#define CY_OPERATE_MODE             0x00
+#define CY_SYSINFO_MODE             0x10
+/* power mode select bits */
+#define CY_SOFT_RESET_MODE          0x01 /* return to Bootloader mode */
+#define CY_DEEP_SLEEP_MODE          0x02
+#define CY_LOW_POWER_MODE           0x04
+
+/* Slots management */
+#define CY_MAX_FINGER               4
+#define CY_MAX_ID                   16
+
+struct cyttsp_tch {
+	__be16 x, y;
+	u8 z;
+} __packed;
+
+/* TrueTouch Standard Product Gen3 interface definition */
+struct cyttsp_xydata {
+	u8 hst_mode;
+	u8 tt_mode;
+	u8 tt_stat;
+	struct cyttsp_tch tch1;
+	u8 touch12_id;
+	struct cyttsp_tch tch2;
+	u8 gest_cnt;
+	u8 gest_id;
+	struct cyttsp_tch tch3;
+	u8 touch34_id;
+	struct cyttsp_tch tch4;
+	u8 tt_undef[3];
+	u8 act_dist;
+	u8 tt_reserved;
+} __packed;
+
+/* TTSP System Information interface definition */
+struct cyttsp_sysinfo_data {
+	u8 hst_mode;
+	u8 mfg_cmd;
+	u8 mfg_stat;
+	u8 cid[3];
+	u8 tt_undef1;
+	u8 uid[8];
+	u8 bl_verh;
+	u8 bl_verl;
+	u8 tts_verh;
+	u8 tts_verl;
+	u8 app_idh;
+	u8 app_idl;
+	u8 app_verh;
+	u8 app_verl;
+	u8 tt_undef[5];
+	u8 scn_typ;
+	u8 act_intrvl;
+	u8 tch_tmout;
+	u8 lp_intrvl;
+};
+
+/* TTSP Bootloader Register Map interface definition */
+#define CY_BL_CHKSUM_OK 0x01
+struct cyttsp_bootloader_data {
+	u8 bl_file;
+	u8 bl_status;
+	u8 bl_error;
+	u8 blver_hi;
+	u8 blver_lo;
+	u8 bld_blver_hi;
+	u8 bld_blver_lo;
+	u8 ttspver_hi;
+	u8 ttspver_lo;
+	u8 appid_hi;
+	u8 appid_lo;
+	u8 appver_hi;
+	u8 appver_lo;
+	u8 cid_0;
+	u8 cid_1;
+	u8 cid_2;
+};
+
+struct cyttsp {
+	struct device *dev;
+	int irq;
+	struct input_dev *input;
+	char phys[32];
+	const struct cyttsp_platform_data *platform_data;
+	struct cyttsp_bus_ops *bus_ops;
+	struct cyttsp_bootloader_data bl_data;
+	struct cyttsp_sysinfo_data sysinfo_data;
+	struct completion bl_ready;
+	enum cyttsp_powerstate power_state;
+};
+
+static const u8 bl_command[] = {
+	0x00,			/* file offset */
+	0xFF,			/* command */
+	0xA5,			/* exit bootloader command */
+	0, 1, 2, 3, 4, 5, 6, 7	/* default keys */
+};
+
+static int ttsp_read_block_data(struct cyttsp *ts, u8 command,
+	u8 length, void *buf)
+{
+	int retval = -1;
+	int tries;
+
+	if (!buf || !length)
+		return -EINVAL;
+
+	for (tries = 0; tries < CY_NUM_RETRY && (retval < 0); tries++) {
+		retval = ts->bus_ops->read(ts->bus_ops, command, length, buf);
+		if (retval)
+			msleep(CY_DELAY_DFLT);
+	}
+
+	return retval;
+}
+
+static int ttsp_write_block_data(struct cyttsp *ts, u8 command,
+	u8 length, void *buf)
+{
+	int retval = -1;
+	int tries;
+
+	if (!buf || !length)
+		return -EINVAL;
+
+	for (tries = 0; tries < CY_NUM_RETRY && (retval < 0); tries++) {
+		retval = ts->bus_ops->write(ts->bus_ops, command, length, buf);
+		if (retval)
+			msleep(CY_DELAY_DFLT);
+	}
+
+	return retval;
+}
+
+static int cyttsp_load_bl_regs(struct cyttsp *ts)
+{
+	memset(&(ts->bl_data), 0, sizeof(struct cyttsp_bootloader_data));
+
+	ts->bl_data.bl_status = 0x10;
+
+	return  ttsp_read_block_data(ts, CY_REG_BASE, sizeof(ts->bl_data),
+				     &ts->bl_data);
+}
+
+static int cyttsp_bl_app_valid(struct cyttsp *ts)
+{
+	int retval;
+
+	retval = cyttsp_load_bl_regs(ts);
+
+	if (retval < 0) {
+		retval = -ENODEV;
+		goto done;
+	}
+
+	if (GET_BOOTLOADERMODE(ts->bl_data.bl_status)) {
+		if (IS_VALID_APP(ts->bl_data.bl_status))
+			return 0;
+		else
+			return -ENODEV;
+	}
+
+	if (GET_HSTMODE(ts->bl_data.bl_file) == CY_OPERATE_MODE) {
+		if (!(IS_OPERATIONAL_ERR(ts->bl_data.bl_status)))
+			return 1;
+		else
+			return -ENODEV;
+	}
+
+	retval = -ENODEV;
+done:
+	return retval;
+}
+
+static int cyttsp_exit_bl_mode(struct cyttsp *ts)
+{
+	int retval;
+	int tries;
+	u8 bl_cmd[sizeof(bl_command)];
+
+	memcpy(bl_cmd, bl_command, sizeof(bl_command));
+	if (ts->platform_data->bl_keys)
+		memcpy(&bl_cmd[sizeof(bl_command) - CY_NUM_BL_KEYS],
+			ts->platform_data->bl_keys, sizeof(bl_command));
+
+	retval = ttsp_write_block_data(ts, CY_REG_BASE,
+		sizeof(bl_cmd), (void *)bl_cmd);
+
+	if (retval < 0)
+		return retval;
+
+	/* wait for TTSP Device to complete switch to Operational mode */
+	tries = 0;
+	do {
+		msleep(CY_DELAY_DFLT);
+		retval = cyttsp_load_bl_regs(ts);
+	} while ((retval || GET_BOOTLOADERMODE(ts->bl_data.bl_status)) &&
+		(tries++ < CY_DELAY_MAX));
+
+	if (tries >= CY_DELAY_MAX)
+		return -ENODEV;
+
+	return retval;
+}
+
+static int cyttsp_set_operational_mode(struct cyttsp *ts)
+{
+	struct cyttsp_xydata xy_data;
+	int retval;
+	int tries = 0;
+	u8 cmd = CY_OPERATE_MODE;
+
+	retval = ttsp_write_block_data(ts, CY_REG_BASE, sizeof(cmd), &cmd);
+
+	if (retval < 0)
+		return retval;
+
+	/* wait for TTSP Device to complete switch to Operational mode */
+	do {
+		retval = ttsp_read_block_data(ts, CY_REG_BASE,
+			sizeof(xy_data), &(xy_data));
+	} while ((retval || xy_data.act_dist != CY_ACT_DIST_DFLT) &&
+		 (tries++ < CY_DELAY_MAX));
+
+	if (tries >= CY_DELAY_MAX)
+		return -EAGAIN;
+
+	return retval;
+}
+
+static int cyttsp_set_sysinfo_mode(struct cyttsp *ts)
+{
+	int retval;
+	int tries;
+	u8 cmd = CY_SYSINFO_MODE;
+
+	memset(&(ts->sysinfo_data), 0, sizeof(struct cyttsp_sysinfo_data));
+
+	/* switch to sysinfo mode */
+	retval = ttsp_write_block_data(ts, CY_REG_BASE, sizeof(cmd), &cmd);
+	if (retval < 0)
+		return retval;
+
+	/* read sysinfo registers */
+	tries = 0;
+	do {
+		msleep(CY_DELAY_DFLT);
+		retval = ttsp_read_block_data(ts, CY_REG_BASE,
+			sizeof(ts->sysinfo_data), &ts->sysinfo_data);
+	} while ((retval || (!ts->sysinfo_data.tts_verh &&
+			     !ts->sysinfo_data.tts_verl)) &&
+		 (tries++ < CY_DELAY_MAX));
+
+	if (tries >= CY_DELAY_MAX)
+		return -EAGAIN;
+
+	return retval;
+}
+
+static int cyttsp_set_sysinfo_regs(struct cyttsp *ts)
+{
+	int retval = 0;
+
+	if (ts->platform_data->act_intrvl != CY_ACT_INTRVL_DFLT ||
+		ts->platform_data->tch_tmout != CY_TCH_TMOUT_DFLT ||
+		ts->platform_data->lp_intrvl != CY_LP_INTRVL_DFLT) {
+
+		u8 intrvl_ray[3];
+
+		intrvl_ray[0] = ts->platform_data->act_intrvl;
+		intrvl_ray[1] = ts->platform_data->tch_tmout;
+		intrvl_ray[2] = ts->platform_data->lp_intrvl;
+
+		/* set intrvl registers */
+		retval = ttsp_write_block_data(ts,
+				CY_REG_ACT_INTRVL,
+				sizeof(intrvl_ray), intrvl_ray);
+
+		msleep(CY_DELAY_DFLT);
+	}
+
+	return retval;
+}
+
+static int cyttsp_soft_reset(struct cyttsp *ts)
+{
+	int retval;
+	u8 cmd = CY_SOFT_RESET_MODE;
+	long wait_jiffies = msecs_to_jiffies(CY_DELAY_DFLT * CY_DELAY_MAX);
+	/* wait for interrupt to set ready completion */
+	INIT_COMPLETION(ts->bl_ready);
+
+	retval = ttsp_write_block_data(ts, CY_REG_BASE, sizeof(cmd), &cmd);
+	if (retval < 0)
+		return retval;
+
+	return wait_for_completion_timeout(&ts->bl_ready, wait_jiffies);
+}
+
+static int cyttsp_act_dist_setup(struct cyttsp *ts)
+{
+	int retval;
+	u8 act_dist_setup;
+
+	/* Init gesture; active distance setup */
+	act_dist_setup = ts->platform_data->act_dist;
+	retval = ttsp_write_block_data(ts, CY_REG_ACT_DIST,
+		sizeof(act_dist_setup), &act_dist_setup);
+
+	return retval;
+}
+
+static int cyttsp_hndshk(struct cyttsp *ts, u8 hst_mode)
+{
+	u8 cmd;
+
+	cmd = hst_mode ^ CY_HNDSHK_BIT;
+
+	return ttsp_write_block_data(ts, CY_REG_BASE, sizeof(cmd), (u8 *)&cmd);
+}
+
+static void cyttsp_report_slot(struct input_dev *dev, int slot,
+			       int x, int y, int z)
+{
+	input_mt_slot(dev, slot);
+	input_mt_report_slot_state(dev, MT_TOOL_FINGER, true);
+	input_report_abs(dev, ABS_MT_POSITION_X, x);
+	input_report_abs(dev, ABS_MT_POSITION_Y, y);
+	input_report_abs(dev, ABS_MT_TOUCH_MAJOR, z);
+}
+
+static void cyttsp_report_slot_empty(struct input_dev *dev, int slot)
+{
+	input_mt_slot(dev, slot);
+	input_mt_report_slot_state(dev, MT_TOOL_FINGER, false);
+}
+
+static void cyttsp_extract_track_ids(struct cyttsp_xydata *xy_data, int *ids)
+{
+	ids[0] = xy_data->touch12_id >> 4;
+	ids[1] = xy_data->touch12_id & 0xF;
+	ids[2] = xy_data->touch34_id >> 4;
+	ids[3] = xy_data->touch34_id & 0xF;
+}
+
+static const struct cyttsp_tch *cyttsp_get_tch(struct cyttsp_xydata *xy_data,
+					       int idx)
+{
+	switch (idx) {
+	case 0:
+		return &xy_data->tch1;
+	case 1:
+		return &xy_data->tch2;
+	case 2:
+		return &xy_data->tch3;
+	case 3:
+		return  &xy_data->tch4;
+	default:
+		return NULL;
+	}
+}
+
+static int cyttsp_handle_tchdata(struct cyttsp *ts)
+{
+	struct cyttsp_xydata xy_data;
+	u8 num_cur_tch;
+	int i;
+	int ids[4];
+	const struct cyttsp_tch *tch = NULL;
+	int x, y, z;
+	int used = 0;
+
+	/* Get touch data from CYTTSP device */
+	if (ttsp_read_block_data(ts,
+		CY_REG_BASE, sizeof(struct cyttsp_xydata), &xy_data))
+		return 0;
+
+	/* provide flow control handshake */
+	if (ts->platform_data->use_hndshk)
+		if (cyttsp_hndshk(ts, xy_data.hst_mode))
+			return 0;
+
+	/* determine number of currently active touches */
+	num_cur_tch = GET_NUM_TOUCHES(xy_data.tt_stat);
+
+	/* check for any error conditions */
+	if (ts->power_state == CY_IDLE_STATE)
+		return 0;
+	else if (GET_BOOTLOADERMODE(xy_data.tt_mode)) {
+		return -1;
+	} else if (IS_LARGE_AREA(xy_data.tt_stat) == 1) {
+		/* terminate all active tracks */
+		num_cur_tch = 0;
+		dev_dbg(ts->dev, "%s: Large area detected\n", __func__);
+	} else if (num_cur_tch > CY_MAX_FINGER) {
+		/* terminate all active tracks */
+		num_cur_tch = 0;
+		dev_dbg(ts->dev, "%s: Num touch error detected\n", __func__);
+	} else if (IS_BAD_PKT(xy_data.tt_mode)) {
+		/* terminate all active tracks */
+		num_cur_tch = 0;
+		dev_dbg(ts->dev, "%s: Invalid buffer detected\n", __func__);
+	}
+
+	cyttsp_extract_track_ids(&xy_data, ids);
+
+	for (i = 0; i < num_cur_tch; i++) {
+		used |= (1 << ids[i]);
+
+		tch = cyttsp_get_tch(&xy_data, i);
+
+		x = be16_to_cpu(tch->x);
+		y = be16_to_cpu(tch->y);
+		z = tch->z;
+
+		cyttsp_report_slot(ts->input, ids[i], x, y, z);
+	}
+
+	for (i = 0; i < CY_MAX_ID; i++)
+		if (!(used & (1 << i)))
+			cyttsp_report_slot_empty(ts->input, i);
+
+	input_sync(ts->input);
+
+	return 0;
+}
+
+static void cyttsp_pr_state(struct cyttsp *ts)
+{
+	static char *cyttsp_powerstate_string[] = {
+		"IDLE",
+		"ACTIVE",
+		"LOW_PWR",
+		"SLEEP",
+		"BOOTLOADER",
+		"INVALID"
+	};
+
+	dev_info(ts->dev, "%s: %s\n", __func__,
+		ts->power_state < CY_INVALID_STATE ?
+		cyttsp_powerstate_string[ts->power_state] :
+		"INVALID");
+}
+
+static irqreturn_t cyttsp_irq(int irq, void *handle)
+{
+	struct cyttsp *ts = handle;
+	int retval;
+
+	if (ts->power_state == CY_BL_STATE)
+		complete(&ts->bl_ready);
+	else {
+		/* process the touches */
+		retval = cyttsp_handle_tchdata(ts);
+
+		if (retval < 0) {
+			/*
+			 * TTSP device has reset back to bootloader mode.
+			 * Restore to operational mode.
+			 */
+			retval = cyttsp_exit_bl_mode(ts);
+			if (retval)
+				ts->power_state = CY_IDLE_STATE;
+			else
+				ts->power_state = CY_ACTIVE_STATE;
+			cyttsp_pr_state(ts);
+		}
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int cyttsp_power_on(struct cyttsp *ts)
+{
+	int retval = 0;
+
+	if (!ts)
+		return -ENOMEM;
+
+	ts->power_state = CY_BL_STATE;
+
+	/* enable interrupts */
+	retval = request_threaded_irq(ts->irq, NULL, cyttsp_irq,
+		IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+		ts->platform_data->name, ts);
+	if (retval < 0)
+		goto bypass;
+
+	retval = cyttsp_soft_reset(ts);
+	if (retval == 0)
+		goto bypass;
+
+	retval = cyttsp_bl_app_valid(ts);
+	if (retval < 0)
+		goto bypass;
+	else if (retval > 0)
+		goto no_bl_bypass;
+
+	retval = cyttsp_exit_bl_mode(ts);
+
+	if (retval < 0)
+		goto bypass;
+
+	ts->power_state = CY_IDLE_STATE;
+
+no_bl_bypass:
+	retval = cyttsp_set_sysinfo_mode(ts);
+	if (retval < 0)
+		goto bypass;
+
+	retval = cyttsp_set_sysinfo_regs(ts);
+	if (retval < 0)
+		goto bypass;
+
+	retval = cyttsp_set_operational_mode(ts);
+	if (retval < 0)
+		goto bypass;
+
+	/* init active distance */
+	retval = cyttsp_act_dist_setup(ts);
+	if (retval < 0)
+		goto bypass;
+
+	ts->power_state = CY_ACTIVE_STATE;
+	retval = 0;
+
+bypass:
+	cyttsp_pr_state(ts);
+	return retval;
+}
+
+#ifdef CONFIG_PM
+int cyttsp_resume(void *handle)
+{
+	struct cyttsp *ts = handle;
+	int retval = 0;
+	struct cyttsp_xydata xydata;
+
+	if (!ts)
+		return retval;
+
+	if (ts->platform_data->use_sleep && (ts->power_state !=
+					     CY_ACTIVE_STATE)) {
+
+		if (ts->platform_data->wakeup)
+			retval = ts->platform_data->wakeup();
+		else
+			retval = -ENOSYS;
+
+		if (retval >= 0) {
+			retval = ttsp_read_block_data(ts, CY_REG_BASE,
+						      sizeof(xydata),
+						      &xydata);
+			if (retval >= 0 &&
+			    !GET_HSTMODE(xydata.hst_mode))
+				ts->power_state = CY_ACTIVE_STATE;
+		}
+	}
+
+	return retval;
+}
+EXPORT_SYMBOL_GPL(cyttsp_resume);
+
+int cyttsp_suspend(void *handle)
+{
+	struct cyttsp *ts = handle;
+	u8 sleep_mode = 0;
+	int retval = 0;
+
+	if (ts->platform_data->use_sleep &&
+		(ts->power_state == CY_ACTIVE_STATE)) {
+		sleep_mode = ts->platform_data->use_sleep;
+		retval = ttsp_write_block_data(ts,
+			CY_REG_BASE, sizeof(sleep_mode), &sleep_mode);
+		if (retval >= 0)
+			ts->power_state = CY_SLEEP_STATE;
+	}
+
+	return retval;
+}
+EXPORT_SYMBOL_GPL(cyttsp_suspend);
+#endif
+
+static int cyttsp_open(struct input_dev *dev)
+{
+	struct cyttsp *ts = input_get_drvdata(dev);
+
+	return cyttsp_power_on(ts);
+}
+
+void cyttsp_core_release(void *handle)
+{
+	struct cyttsp *ts = handle;
+
+	if (ts) {
+		free_irq(ts->irq, ts);
+		input_unregister_device(ts->input);
+		if (ts->platform_data->exit)
+			ts->platform_data->exit();
+		kfree(ts);
+	}
+}
+EXPORT_SYMBOL_GPL(cyttsp_core_release);
+
+static void cyttsp_close(struct input_dev *dev)
+{
+	struct cyttsp *ts = input_get_drvdata(dev);
+
+	free_irq(ts->irq, ts);
+}
+
+void *cyttsp_core_init(struct cyttsp_bus_ops *bus_ops,
+		       struct device *dev, int irq)
+{
+	struct input_dev *input_device;
+	int ret;
+
+	struct cyttsp *ts = kzalloc(sizeof(*ts), GFP_KERNEL);
+
+	if (!ts) {
+		pr_err("%s: Error, kzalloc\n", __func__);
+		goto error_alloc_data;
+	}
+
+	if (dev == NULL || bus_ops == NULL) {
+		kfree(ts);
+		goto error_alloc_data;
+	}
+
+	ts->dev = dev;
+	ts->platform_data = dev->platform_data;
+	ts->bus_ops = bus_ops;
+	init_completion(&ts->bl_ready);
+
+	if (ts->platform_data->init) {
+		if (ts->platform_data->init()) {
+			dev_dbg(ts->dev, "%s: Error, platform init failed!\n",
+				__func__);
+			goto error_init;
+		}
+	}
+
+	ts->irq = irq;
+	if (ts->irq <= 0) {
+		dev_dbg(ts->dev, "%s: Error, failed to allocate irq\n",
+			__func__);
+			goto error_init;
+	}
+
+	/* Create the input device and register it. */
+	input_device = input_allocate_device();
+	if (!input_device) {
+		dev_dbg(ts->dev, "%s: Error, failed to allocate input device\n",
+			__func__);
+		goto error_input_allocate_device;
+	}
+
+	ts->input = input_device;
+	input_device->name = ts->platform_data->name;
+	snprintf(ts->phys, sizeof(ts->phys), "%s", dev_name(dev));
+	input_device->phys = ts->phys;
+	input_device->dev.parent = ts->dev;
+	input_device->open = cyttsp_open;
+	input_device->close = cyttsp_close;
+	input_set_drvdata(input_device, ts);
+
+	__set_bit(EV_SYN, input_device->evbit);
+	__set_bit(EV_KEY, input_device->evbit);
+	__set_bit(EV_ABS, input_device->evbit);
+
+	input_set_abs_params(input_device, ABS_MT_POSITION_X,
+			     0, ts->platform_data->maxx, 0, 0);
+	input_set_abs_params(input_device, ABS_MT_POSITION_Y,
+			     0, ts->platform_data->maxy, 0, 0);
+	input_set_abs_params(input_device, ABS_MT_TOUCH_MAJOR,
+			     0, CY_MAXZ, 0, 0);
+
+	input_mt_init_slots(input_device, CY_MAX_ID);
+
+	ret = input_register_device(input_device);
+	if (ret) {
+		dev_err(ts->dev, "%s: Error, failed to register input device: %d\n",
+			__func__, ret);
+		goto error_input_register_device;
+	}
+
+	goto no_error;
+
+error_input_register_device:
+	input_free_device(input_device);
+error_input_allocate_device:
+	if (ts->platform_data->exit)
+		ts->platform_data->exit();
+error_init:
+	kfree(ts);
+error_alloc_data:
+no_error:
+	return ts;
+}
+EXPORT_SYMBOL_GPL(cyttsp_core_init);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Cypress TrueTouch(R) Standard touchscreen driver core");
+MODULE_AUTHOR("Cypress");
diff --git a/drivers/input/touchscreen/cyttsp_core.h b/drivers/input/touchscreen/cyttsp_core.h
new file mode 100644
index 0000000..c4c7d9e
--- /dev/null
+++ b/drivers/input/touchscreen/cyttsp_core.h
@@ -0,0 +1,59 @@
+/*
+ * Header file for:
+ * Cypress TrueTouch(TM) Standard Product (TTSP) touchscreen drivers.
+ * For use with Cypress Txx3xx parts.
+ * Supported parts include:
+ * CY8CTST341
+ * CY8CTMA340
+ *
+ * Copyright (C) 2009, 2010, 2011 Cypress Semiconductor, Inc.
+ * Copyright (C) 2011 Javier Martinez Canillas <martinez.javier@gmail.com>
+ *
+ * Multi-touch protocol type B support and cleanups by Javier Martinez Canillas
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2, and only version 2, as published by the
+ * Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
+ *
+ * Contact Cypress Semiconductor at www.cypress.com <kev@cypress.com>
+ *
+ */
+
+
+#ifndef __CYTTSP_CORE_H__
+#define __CYTTSP_CORE_H__
+
+#include <linux/kernel.h>
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/input/cyttsp.h>
+
+#define CY_NUM_RETRY                4 /* max number of retries for read ops */
+
+
+struct cyttsp_bus_ops {
+	s32 (*write)(void *handle, u8 addr, u8 length, const void *values);
+	s32 (*read)(void *handle, u8 addr, u8 length, void *values);
+	struct device *dev;
+};
+
+void *cyttsp_core_init(struct cyttsp_bus_ops *bus_ops,
+		       struct device *dev, int irq);
+
+void cyttsp_core_release(void *handle);
+#ifdef CONFIG_PM
+int cyttsp_resume(void *handle);
+int cyttsp_suspend(void *handle);
+#endif
+
+#endif /* __CYTTSP_CORE_H__ */
diff --git a/drivers/input/touchscreen/cyttsp_i2c.c b/drivers/input/touchscreen/cyttsp_i2c.c
new file mode 100644
index 0000000..d7d62d4
--- /dev/null
+++ b/drivers/input/touchscreen/cyttsp_i2c.c
@@ -0,0 +1,178 @@
+/*
+ * Source for:
+ * Cypress TrueTouch(TM) Standard Product (TTSP) I2C touchscreen driver.
+ * For use with Cypress Txx3xx parts.
+ * Supported parts include:
+ * CY8CTST341
+ * CY8CTMA340
+ *
+ * Copyright (C) 2009, 2010, 2011 Cypress Semiconductor, Inc.
+ * Copyright (C) 2011 Javier Martinez Canillas <martinez.javier@gmail.com>
+ *
+ * Multi-touch protocol type B support and cleanups by Javier Martinez Canillas
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2, and only version 2, as published by the
+ * Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
+ *
+ * Contact Cypress Semiconductor at www.cypress.com <kev@cypress.com>
+ *
+ */
+
+#include "cyttsp_core.h"
+
+#include <linux/i2c.h>
+#include <linux/slab.h>
+
+#define CY_I2C_DATA_SIZE  128
+
+struct cyttsp_i2c {
+	struct cyttsp_bus_ops ops;
+	struct i2c_client *client;
+	void *ttsp_client;
+	u8 wr_buf[CY_I2C_DATA_SIZE];
+};
+
+static s32 ttsp_i2c_read_block_data(void *handle, u8 addr,
+	u8 length, void *values)
+{
+	struct cyttsp_i2c *ts = container_of(handle, struct cyttsp_i2c, ops);
+	int retval = 0;
+
+	retval = i2c_master_send(ts->client, &addr, 1);
+	if (retval < 0)
+		return retval;
+
+	retval = i2c_master_recv(ts->client, values, length);
+
+	if (retval != length)
+		return -EIO;
+
+	return (retval < 0) ? retval : 0;
+}
+
+static s32 ttsp_i2c_write_block_data(void *handle, u8 addr,
+	u8 length, const void *values)
+{
+	struct cyttsp_i2c *ts = container_of(handle, struct cyttsp_i2c, ops);
+	int retval;
+
+	ts->wr_buf[0] = addr;
+	memcpy(&ts->wr_buf[1], values, length);
+
+	retval = i2c_master_send(ts->client, ts->wr_buf, length+1);
+
+	if (retval != length)
+		return -EIO;
+
+	return (retval < 0) ? retval : 0;
+}
+
+static int __devinit cyttsp_i2c_probe(struct i2c_client *client,
+	const struct i2c_device_id *id)
+{
+	struct cyttsp_i2c *ts;
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
+		return -EIO;
+
+	/* allocate and clear memory */
+	ts = kzalloc(sizeof(*ts), GFP_KERNEL);
+	if (!ts) {
+		dev_dbg(&client->dev, "%s: Error, kzalloc.\n", __func__);
+		return -ENOMEM;
+	}
+
+	/* register driver_data */
+	ts->client = client;
+	i2c_set_clientdata(client, ts);
+	ts->ops.write = ttsp_i2c_write_block_data;
+	ts->ops.read = ttsp_i2c_read_block_data;
+	ts->ops.dev = &client->dev;
+
+	ts->ttsp_client = cyttsp_core_init(&ts->ops, &client->dev, client->irq);
+	if (IS_ERR(ts->ttsp_client)) {
+		int retval = PTR_ERR(ts->ttsp_client);
+		kfree(ts);
+		return retval;
+	}
+
+	return 0;
+}
+
+
+/* registered in driver struct */
+static int __devexit cyttsp_i2c_remove(struct i2c_client *client)
+{
+	struct cyttsp_i2c *ts;
+
+	ts = i2c_get_clientdata(client);
+	cyttsp_core_release(ts->ttsp_client);
+	kfree(ts);
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int cyttsp_i2c_suspend(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct cyttsp_i2c *ts = i2c_get_clientdata(client);
+
+	return cyttsp_suspend(ts->ttsp_client);
+}
+
+static int cyttsp_i2c_resume(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct cyttsp_i2c *ts = i2c_get_clientdata(client);
+
+	return cyttsp_resume(ts->ttsp_client);
+}
+static SIMPLE_DEV_PM_OPS(cyttsp_i2c_pm, cyttsp_i2c_suspend, cyttsp_i2c_resume);
+#endif
+
+static const struct i2c_device_id cyttsp_i2c_id[] = {
+	{ CY_I2C_NAME, 0 },  { }
+};
+
+static struct i2c_driver cyttsp_i2c_driver = {
+	.driver = {
+		.name = CY_I2C_NAME,
+		.owner = THIS_MODULE,
+#ifdef CONFIG_PM
+		.pm = &cyttsp_i2c_pm,
+#endif
+	},
+	.probe = cyttsp_i2c_probe,
+	.remove = __devexit_p(cyttsp_i2c_remove),
+	.id_table = cyttsp_i2c_id,
+};
+
+static int __init cyttsp_i2c_init(void)
+{
+	return i2c_add_driver(&cyttsp_i2c_driver);
+}
+
+static void __exit cyttsp_i2c_exit(void)
+{
+	return i2c_del_driver(&cyttsp_i2c_driver);
+}
+
+module_init(cyttsp_i2c_init);
+module_exit(cyttsp_i2c_exit);
+
+MODULE_ALIAS("i2c:cyttsp");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Cypress TrueTouch(R) Standard Product (TTSP) I2C driver");
+MODULE_AUTHOR("Cypress");
+MODULE_DEVICE_TABLE(i2c, cyttsp_i2c_id);
diff --git a/drivers/input/touchscreen/cyttsp_spi.c b/drivers/input/touchscreen/cyttsp_spi.c
new file mode 100644
index 0000000..1324695
--- /dev/null
+++ b/drivers/input/touchscreen/cyttsp_spi.c
@@ -0,0 +1,274 @@
+/*
+ * Source for:
+ * Cypress TrueTouch(TM) Standard Product (TTSP) SPI touchscreen driver.
+ * For use with Cypress Txx3xx parts.
+ * Supported parts include:
+ * CY8CTST341
+ * CY8CTMA340
+ *
+ * Copyright (C) 2009, 2010, 2011 Cypress Semiconductor, Inc.
+ * Copyright (C) 2011 Javier Martinez Canillas <martinez.javier@gmail.com>
+ *
+ * Multi-touch protocol type B support and cleanups by Javier Martinez Canillas
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2, and only version 2, as published by the
+ * Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
+ *
+ * Contact Cypress Semiconductor at www.cypress.com <kev@cypress.com>
+ *
+ */
+
+#include "cyttsp_core.h"
+
+#include <linux/spi/spi.h>
+#include <linux/delay.h>
+
+#define CY_SPI_WR_OP      0x00 /* r/~w */
+#define CY_SPI_RD_OP      0x01
+#define CY_SPI_CMD_BYTES  4
+#define CY_SPI_SYNC_BYTE  2
+#define CY_SPI_SYNC_ACK1  0x62 /* from protocol v.2 */
+#define CY_SPI_SYNC_ACK2  0x9D /* from protocol v.2 */
+#define CY_SPI_DATA_SIZE  128
+#define CY_SPI_DATA_BUF_SIZE (CY_SPI_CMD_BYTES + CY_SPI_DATA_SIZE)
+#define CY_SPI_BITS_PER_WORD 8
+
+struct cyttsp_spi {
+	struct cyttsp_bus_ops bus_ops;
+	struct spi_device *spi_client;
+	void *ttsp_client;
+	u8 wr_buf[CY_SPI_DATA_BUF_SIZE];
+	u8 rd_buf[CY_SPI_DATA_BUF_SIZE];
+};
+
+static int cyttsp_spi_xfer(u8 op, struct cyttsp_spi *ts,
+			   u8 reg, u8 *buf, int length)
+{
+	struct spi_message msg;
+	struct spi_transfer xfer[2];
+	u8 *wr_buf = ts->wr_buf;
+	u8 *rd_buf = ts->rd_buf;
+	int retval;
+
+	if (length > CY_SPI_DATA_SIZE) {
+		dev_dbg(ts->bus_ops.dev,
+			"%s: length %d is too big.\n",
+			__func__, length);
+		return -EINVAL;
+	}
+
+	memset(wr_buf, 0, CY_SPI_DATA_BUF_SIZE);
+	memset(rd_buf, 0, CY_SPI_DATA_BUF_SIZE);
+
+	wr_buf[0] = 0x00; /* header byte 0 */
+	wr_buf[1] = 0xFF; /* header byte 1 */
+	wr_buf[2] = reg;  /* reg index */
+	wr_buf[3] = op;   /* r/~w */
+	if (op == CY_SPI_WR_OP)
+		memcpy(wr_buf + CY_SPI_CMD_BYTES, buf, length);
+
+	memset((void *)xfer, 0, sizeof(xfer));
+	spi_message_init(&msg);
+
+	/*
+	  We set both TX and RX buffers because Cypress TTSP
+	  requires full duplex operation.
+	*/
+	xfer[0].tx_buf = wr_buf;
+	xfer[0].rx_buf = rd_buf;
+	if (op == CY_SPI_WR_OP) {
+		xfer[0].len = length + CY_SPI_CMD_BYTES;
+		spi_message_add_tail(&xfer[0], &msg);
+	} else if (op == CY_SPI_RD_OP) {
+		xfer[0].len = CY_SPI_CMD_BYTES;
+		spi_message_add_tail(&xfer[0], &msg);
+
+		xfer[1].rx_buf = buf;
+		xfer[1].len = length;
+		spi_message_add_tail(&xfer[1], &msg);
+	}
+
+	retval = spi_sync(ts->spi_client, &msg);
+	if (retval < 0) {
+		dev_dbg(ts->bus_ops.dev,
+			"%s: spi_sync() error %d, len=%d, op=%d\n",
+			__func__, retval, xfer[1].len, op);
+
+		/*
+		 * do not return here since was a bad ACK sequence
+		 * let the following ACK check handle any errors and
+		 * allow silent retries
+		 */
+	}
+
+	if ((rd_buf[CY_SPI_SYNC_BYTE] == CY_SPI_SYNC_ACK1) &&
+	    (rd_buf[CY_SPI_SYNC_BYTE+1] == CY_SPI_SYNC_ACK2))
+		retval = 0;
+	else {
+		int i;
+		for (i = 0; i < (CY_SPI_CMD_BYTES); i++)
+			dev_dbg(ts->bus_ops.dev,
+				"%s: test rd_buf[%d]:0x%02x\n",
+				__func__, i, rd_buf[i]);
+		for (i = 0; i < (length); i++)
+			dev_dbg(ts->bus_ops.dev,
+				"%s: test buf[%d]:0x%02x\n",
+				__func__, i, buf[i]);
+
+		/* signal ACK error so silent retry */
+		retval = 1;
+	}
+
+	return retval;
+}
+
+static s32 ttsp_spi_read_block_data(void *handle, u8 addr,
+				    u8 length, void *data)
+{
+	struct cyttsp_spi *ts =
+		container_of(handle, struct cyttsp_spi, bus_ops);
+	int retval;
+
+	retval = cyttsp_spi_xfer(CY_SPI_RD_OP, ts, addr, data, length);
+	if (retval < 0)
+		pr_err("%s: ttsp_spi_read_block_data failed\n",
+		       __func__);
+
+	/*
+	 * Do not print the above error if the data sync bytes were not found.
+	 * This is a normal condition for the bootloader loader startup and need
+	 * to retry until data sync bytes are found.
+	 */
+	if (retval > 0)
+		retval = -EIO;  /* now signal fail; so retry can be done */
+
+	return retval;
+}
+
+static s32 ttsp_spi_write_block_data(void *handle, u8 addr,
+				     u8 length, const void *data)
+{
+	struct cyttsp_spi *ts =
+		container_of(handle, struct cyttsp_spi, bus_ops);
+	int retval;
+
+	retval = cyttsp_spi_xfer(CY_SPI_WR_OP, ts, addr, (void *)data, length);
+	if (retval < 0)
+		pr_err("%s: ttsp_spi_write_block_data failed\n",
+		       __func__);
+
+	/*
+	 * Do not print the above error if the data sync bytes were not found.
+	 * This is a normal condition for the bootloader loader startup and need
+	 * to retry until data sync bytes are found.
+	 */
+	if (retval > 0)
+		retval = -EIO;  /* now signal fail; so retry can be done */
+
+	return retval;
+}
+
+static int __devinit cyttsp_spi_probe(struct spi_device *spi)
+{
+	struct cyttsp_spi *ts;
+	int retval;
+
+	/* Set up SPI*/
+	spi->bits_per_word = CY_SPI_BITS_PER_WORD;
+	spi->mode = SPI_MODE_0;
+	retval = spi_setup(spi);
+	if (retval < 0) {
+		dev_dbg(&spi->dev, "%s: SPI setup error %d\n",
+			__func__, retval);
+		return retval;
+	}
+
+	ts = kzalloc(sizeof(*ts), GFP_KERNEL);
+	if (!ts) {
+		dev_dbg(&spi->dev, "%s: Error, kzalloc\n", __func__);
+		return -ENOMEM;
+	}
+
+	ts->spi_client = spi;
+	dev_set_drvdata(&spi->dev, ts);
+	ts->bus_ops.write = ttsp_spi_write_block_data;
+	ts->bus_ops.read = ttsp_spi_read_block_data;
+	ts->bus_ops.dev = &spi->dev;
+
+	ts->ttsp_client = cyttsp_core_init(&ts->bus_ops, &spi->dev, spi->irq);
+	if (IS_ERR(ts->ttsp_client)) {
+		int retval = PTR_ERR(ts->ttsp_client);
+		kfree(ts);
+		return retval;
+	}
+
+	dev_dbg(ts->bus_ops.dev, "%s: Registration complete\n", __func__);
+
+	return 0;
+}
+
+static int __devexit cyttsp_spi_remove(struct spi_device *spi)
+{
+	struct cyttsp_spi *ts = dev_get_drvdata(&spi->dev);
+
+	cyttsp_core_release(ts->ttsp_client);
+	kfree(ts);
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int cyttsp_spi_suspend(struct device *dev)
+{
+	struct cyttsp_spi *ts = dev_get_drvdata(dev);
+
+	return cyttsp_suspend(ts->ttsp_client);
+}
+
+static int cyttsp_spi_resume(struct device *dev)
+{
+	struct cyttsp_spi *ts = dev_get_drvdata(dev);
+
+	return cyttsp_resume(ts->ttsp_client);
+}
+static SIMPLE_DEV_PM_OPS(cyttsp_spi_pm, cyttsp_spi_suspend, cyttsp_spi_resume);
+#endif
+
+static struct spi_driver cyttsp_spi_driver = {
+	.driver = {
+		.name = CY_SPI_NAME,
+		.owner = THIS_MODULE,
+#ifdef CONFIG_PM
+		.pm = &cyttsp_spi_pm,
+#endif
+	},
+	.probe = cyttsp_spi_probe,
+	.remove = __devexit_p(cyttsp_spi_remove),
+};
+
+static int __init cyttsp_spi_init(void)
+{
+	return spi_register_driver(&cyttsp_spi_driver);
+}
+module_init(cyttsp_spi_init);
+
+static void __exit cyttsp_spi_exit(void)
+{
+	spi_unregister_driver(&cyttsp_spi_driver);
+}
+module_exit(cyttsp_spi_exit);
+
+MODULE_ALIAS("spi:cyttsp");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Cypress TrueTouch(R) Standard Product (TTSP) SPI driver");
+MODULE_AUTHOR("Cypress");

