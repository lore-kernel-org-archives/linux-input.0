From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v10 1/3] Input: cyttsp - Cypress TTSP capacitive
 multi-touch screen support
Date: Fri, 27 Jan 2012 10:18:46 -0800
Message-ID: <20120127181846.GA22462@core.coreip.homeip.net>
References: <1327021046-18024-1-git-send-email-javier@dowhile0.org>
 <CABxcv=kE4-8mGVw9F0sFu_DsC2fU_HNsU-Q4+QEs_FDDqMzKTw@mail.gmail.com>
 <20120124075430.GA9775@core.coreip.homeip.net>
 <CABxcv=k_e3Pdx=OaLWW-xTGoDXEQKKGWYzcLLWvZEnYBPSv6qw@mail.gmail.com>
 <20120127081833.GA21903@core.coreip.homeip.net>
 <CABxcv=muzq2d+hJZCc0+r-wnE6vLBYwr4jOvXNiJG9_-nY9uEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="T4sUOijqQbZv57TR"
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:36764 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752609Ab2A0SSx (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 27 Jan 2012 13:18:53 -0500
Received: by dadi2 with SMTP id i2so1616861dad.19
        for <linux-input@vger.kernel.org>; Fri, 27 Jan 2012 10:18:53 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CABxcv=muzq2d+hJZCc0+r-wnE6vLBYwr4jOvXNiJG9_-nY9uEA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Javier Martinez Canillas <javier@dowhile0.org>
Cc: Henrik Rydberg <rydberg@euromail.se>, Mohan Pallaka <mpallaka@codeaurora.org>, Kevin McNeely <kev@cypress.com>, Shubhrajyoti Datta <omaplinuxkernel@gmail.com>, linux-input@vger.kernel.org


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Jan 27, 2012 at 04:57:12PM +0100, Javier Martinez Canillas wrote:
> On Fri, Jan 27, 2012 at 9:18 AM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > On Thu, Jan 26, 2012 at 01:12:50AM +0100, Javier Martinez Canillas wrote:
> >> On Tue, Jan 24, 2012 at 8:54 AM, Dmitry Torokhov
> >> <dmitry.torokhov@gmail.com> wrote:
> >> > On Tue, Jan 24, 2012 at 08:26:39AM +0100, Javier Martinez Canillas wrote:
> >> >> On Fri, Jan 20, 2012 at 1:57 AM, Javier Martinez Canillas
> >> >> <javier@dowhile0.org> wrote:
> >> >> > Cypress TrueTouch(tm) Standard Product controllers are found in
> >> >> > a wide range of embedded devices. This driver add support for a
> >> >> > variety of TTSP controllers.
> >> >> >
> >> >> > Since the hardware is capable of tracking identifiable contacts, multi-touch
> >> >> > protocol type B (stateful) is used to report contact information.
> >> >> >
> >> >> > The driver is composed of a core driver that process the data sent by
> >> >> > the contacts and a set of bus specific interface modules. This patch
> >> >> > adds the base core TTSP driver.
> >> >> >
> >> >> > Signed-off-by: Javier Martinez Canillas <javier@dowhile0.org>
> >> >> > ---
> >> >> >
> >> >> > Changes for v10: Fix issues called out by Dmitry Torokhov
> >> >> >        - Remove use_sleep and put device to sleep unconditionally on suspend
> >> >> >        - Cleanup cyttsp_power_on() and remove cyttsp_bl_app_valid() function
> >> >> >
> >> >> >  drivers/input/touchscreen/Kconfig       |   31 ++
> >> >> >  drivers/input/touchscreen/Makefile      |    3 +
> >> >> >  drivers/input/touchscreen/cyttsp_core.c |  682 +++++++++++++++++++++++++++++++
> >> >> >  drivers/input/touchscreen/cyttsp_core.h |  141 +++++++
> >> >> >  include/linux/input/cyttsp.h            |   68 +++
> >> >> >  5 files changed, 925 insertions(+), 0 deletions(-)
> >> >>
> >> >> Hello Dmitry,
> >> >>
> >> >> Any comments on this version?
> >> >
> >> > Looking at it... If you do not hear from me by Wednesday please ping
> >> > me again.
> >> >
> >> > Thanks.
> >> >
> >> > --
> >> > Dmitry
> >>
> >> ping :)
> >
> > Is it still Wednesday by any chance? ;)
> >
> 
> Hi Dmitry,
> 
> Thanks for the review and the cleanup patch!
> 
> > Anyway, the driver looks pretty good, still below are some changes that
> > I'd like to get in as well:
> >
> > - do not return EAGAIN when operation times out, EIO I believe suits
> >  better.
> > - introduce ttsp_send_command() to replace host of custom functions.
> > - reduce numver of states to 3 - IDLE, ACTIVE and BL mode.
> >  Suspended/full power is already covered by "suspended" attribute.
> > - streamline some functions.
> >
> 
> Seems that your patch handlers all these issues.
> 
> > Please see the FIXME comment in cyttsp_enable() - is there a generic way
> > to wake up the device, similarly to the way we put it to sleep?
> >
> 
> I guess that CY_OPERATE_MODE works but I have to try it since I don't
> have the hw data-sheet.
> 
> > Please tell me if the device still works with this patch.
> >
> > Thanks!
> >
> > --
> > Dmitry
> >
> 
> Strange enough, it doesn't apply cleanly on my tree...
> 
> with patch -p1 < your_patch
> 
> It should since only the files for this driver are modified and I've
> only applied the v10 patches I sent to you.
> Anyway I will manually do the changes, try it and resend to you.

Hmm, not sure why it gives you trouble, I tried not to change anything
when applying your v10 patches except for folding them all together.

I am attaching the version of the driver I've used as a base - maybe it
will save you some time instead of applying the changes manually.

Also, could you please send changes needed to make my patch work as
incremental patch so that I can apply on top of mime locally and fold
all 3 together? It will be easier to see what exactly changed.

Thanks!

-- 
Dmitry

--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="input-cyttsp-cypress-ttsp-capacitive-multi-touch-screen-support.patch"

Input: cyttsp - Cypress TTSP capacitive multi-touch screen support

From: Javier Martinez Canillas <javier@dowhile0.org>

Cypress TrueTouch(tm) Standard Product controllers are found in
a wide range of embedded devices. This driver add support for a
variety of TTSP controllers.

Since the hardware is capable of tracking identifiable contacts, multi-touch
protocol type B (stateful) is used to report contact information.

The driver is composed of a core driver that process the data sent by
the contacts and a set of bus specific interface modules. This patch
adds the base core TTSP driver.

Signed-off-by: Javier Martinez Canillas <javier@dowhile0.org>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/touchscreen/Kconfig       |   32 +
 drivers/input/touchscreen/Makefile      |    5 
 drivers/input/touchscreen/cyttsp_core.c |  682 +++++++++++++++++++++++++++++++
 drivers/input/touchscreen/cyttsp_core.h |  141 ++++++
 drivers/input/touchscreen/cyttsp_i2c.c  |  137 ++++++
 drivers/input/touchscreen/cyttsp_spi.c  |  245 +++++++++++
 include/linux/input/cyttsp.h            |   68 +++
 7 files changed, 1308 insertions(+), 2 deletions(-)
 create mode 100644 drivers/input/touchscreen/cyttsp_core.c
 create mode 100644 drivers/input/touchscreen/cyttsp_core.h
 create mode 100644 drivers/input/touchscreen/cyttsp_i2c.c
 create mode 100644 drivers/input/touchscreen/cyttsp_spi.c
 create mode 100644 include/linux/input/cyttsp.h


diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 6caae44..29e126f 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -139,7 +139,6 @@ config TOUCHSCREEN_CY8CTMG110
 	tristate "cy8ctmg110 touchscreen"
 	depends on I2C
 	depends on GPIOLIB
-
 	help
 	  Say Y here if you have a cy8ctmg110 capacitive touchscreen on
 	  an AAVA device.
@@ -149,6 +148,37 @@ config TOUCHSCREEN_CY8CTMG110
 	  To compile this driver as a module, choose M here: the
 	  module will be called cy8ctmg110_ts.
 
+config TOUCHSCREEN_CYTTSP_CORE
+	tristate "Cypress TTSP touchscreen"
+	help
+	  Say Y here if you have a touchscreen using controller from
+	  the Cypress TrueTouch(tm) Standard Product family connected
+	  to your system. You will also need to select appropriate
+	  bus connection below.
+
+	  If unsure, say N.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called cyttsp_core.
+
+config TOUCHSCREEN_CYTTSP_I2C
+	tristate "support I2C bus connection"
+	depends on TOUCHSCREEN_CYTTSP_CORE && I2C
+	help
+	  Say Y here if the touchscreen is connected via I2C bus.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called cyttsp_i2c.
+
+config TOUCHSCREEN_CYTTSP_SPI
+	tristate "support SPI bus connection"
+	depends on TOUCHSCREEN_CYTTSP_CORE && SPI_MASTER
+	help
+	  Say Y here if the touchscreen is connected via SPI bus.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called cyttsp_spi.
+
 config TOUCHSCREEN_DA9034
 	tristate "Touchscreen support for Dialog Semiconductor DA9034"
 	depends on PMIC_DA903X
diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
index 6246e52..bc2b513 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -16,8 +16,11 @@ obj-$(CONFIG_TOUCHSCREEN_ATMEL_MXT)	+= atmel_mxt_ts.o
 obj-$(CONFIG_TOUCHSCREEN_ATMEL_TSADCC)	+= atmel_tsadcc.o
 obj-$(CONFIG_TOUCHSCREEN_AUO_PIXCIR)	+= auo-pixcir-ts.o
 obj-$(CONFIG_TOUCHSCREEN_BITSY)		+= h3600_ts_input.o
-obj-$(CONFIG_TOUCHSCREEN_BU21013)       += bu21013_ts.o
+obj-$(CONFIG_TOUCHSCREEN_BU21013)	+= bu21013_ts.o
 obj-$(CONFIG_TOUCHSCREEN_CY8CTMG110)	+= cy8ctmg110_ts.o
+obj-$(CONFIG_TOUCHSCREEN_CYTTSP_CORE)	+= cyttsp_core.o
+obj-$(CONFIG_TOUCHSCREEN_CYTTSP_I2C)	+= cyttsp_i2c.o
+obj-$(CONFIG_TOUCHSCREEN_CYTTSP_SPI)	+= cyttsp_spi.o
 obj-$(CONFIG_TOUCHSCREEN_DA9034)	+= da9034-ts.o
 obj-$(CONFIG_TOUCHSCREEN_DA9052)	+= da9052_tsi.o
 obj-$(CONFIG_TOUCHSCREEN_DYNAPRO)	+= dynapro.o
diff --git a/drivers/input/touchscreen/cyttsp_core.c b/drivers/input/touchscreen/cyttsp_core.c
new file mode 100644
index 0000000..28d5ef0
--- /dev/null
+++ b/drivers/input/touchscreen/cyttsp_core.c
@@ -0,0 +1,682 @@
+/*
+ * Core Source for:
+ * Cypress TrueTouch(TM) Standard Product (TTSP) touchscreen drivers.
+ * For use with Cypress Txx3xx parts.
+ * Supported parts include:
+ * CY8CTST341
+ * CY8CTMA340
+ *
+ * Copyright (C) 2009, 2010, 2011 Cypress Semiconductor, Inc.
+ * Copyright (C) 2012 Javier Martinez Canillas <javier@dowhile0.org>
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
+#define CY_DELAY_MAX                500
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
+		retval = ts->bus_ops->read(ts->dev, command, length, buf);
+		if (retval)
+			msleep(CY_DELAY_DFLT);
+	}
+
+	if (tries >= CY_NUM_RETRY)
+		return -EAGAIN;
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
+		retval = ts->bus_ops->write(ts->dev, command, length, buf);
+		if (retval)
+			msleep(CY_DELAY_DFLT);
+	}
+
+	if (tries >= CY_NUM_RETRY)
+		return -EAGAIN;
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
+static int cyttsp_exit_bl_mode(struct cyttsp *ts)
+{
+	int retval;
+	u8 bl_cmd[sizeof(bl_command)];
+
+	memcpy(bl_cmd, bl_command, sizeof(bl_command));
+	if (ts->pdata->bl_keys)
+		memcpy(&bl_cmd[sizeof(bl_command) - CY_NUM_BL_KEYS],
+			ts->pdata->bl_keys, sizeof(bl_command));
+
+	retval = ttsp_write_block_data(ts, CY_REG_BASE,
+		sizeof(bl_cmd), (void *)bl_cmd);
+
+	if (retval < 0)
+		return retval;
+
+	/* wait for TTSP Device to complete the operation */
+	msleep(CY_DELAY_DFLT);
+	retval = cyttsp_load_bl_regs(ts);
+
+	if (retval || GET_BOOTLOADERMODE(ts->bl_data.bl_status))
+		return -ENODEV;
+
+	return retval;
+}
+
+static int cyttsp_set_operational_mode(struct cyttsp *ts)
+{
+	struct cyttsp_xydata xy_data;
+	int retval;
+	u8 cmd = CY_OPERATE_MODE;
+
+	retval = ttsp_write_block_data(ts, CY_REG_BASE, sizeof(cmd), &cmd);
+
+	if (retval < 0)
+		return retval;
+
+	/* wait for TTSP Device to complete switch to Operational mode */
+	retval = ttsp_read_block_data(ts, CY_REG_BASE,
+				      sizeof(xy_data), &(xy_data));
+
+	if (retval || xy_data.act_dist == CY_ACT_DIST_DFLT)
+		return -EAGAIN;
+
+	return retval;
+}
+
+static int cyttsp_set_sysinfo_mode(struct cyttsp *ts)
+{
+	int retval;
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
+	msleep(CY_DELAY_DFLT);
+	retval = ttsp_read_block_data(ts, CY_REG_BASE, sizeof(ts->sysinfo_data),
+				      &ts->sysinfo_data);
+
+	if (retval || (!ts->sysinfo_data.tts_verh &&
+		       !ts->sysinfo_data.tts_verl))
+		return -EAGAIN;
+
+	return retval;
+}
+
+static int cyttsp_set_sysinfo_regs(struct cyttsp *ts)
+{
+	int retval = 0;
+
+	if (ts->pdata->act_intrvl != CY_ACT_INTRVL_DFLT ||
+		ts->pdata->tch_tmout != CY_TCH_TMOUT_DFLT ||
+		ts->pdata->lp_intrvl != CY_LP_INTRVL_DFLT) {
+
+		u8 intrvl_ray[3];
+
+		intrvl_ray[0] = ts->pdata->act_intrvl;
+		intrvl_ray[1] = ts->pdata->tch_tmout;
+		intrvl_ray[2] = ts->pdata->lp_intrvl;
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
+	act_dist_setup = ts->pdata->act_dist;
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
+	if (ts->pdata->use_hndshk)
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
+	ts->power_state = CY_BL_STATE;
+	enable_irq(ts->irq);
+
+	retval = cyttsp_soft_reset(ts);
+	if (retval < 0)
+		return retval;
+
+	retval = cyttsp_load_bl_regs(ts);
+	if (retval < 0)
+		return retval;
+
+	if (GET_BOOTLOADERMODE(ts->bl_data.bl_status) &&
+	    IS_VALID_APP(ts->bl_data.bl_status))
+		retval = cyttsp_exit_bl_mode(ts);
+
+	if (retval < 0)
+		return retval;
+	else
+		ts->power_state = CY_IDLE_STATE;
+
+	if (GET_HSTMODE(ts->bl_data.bl_file) == CY_OPERATE_MODE &&
+	    !IS_OPERATIONAL_ERR(ts->bl_data.bl_status)) {
+		retval = cyttsp_set_sysinfo_mode(ts);
+		if (retval < 0)
+			return retval;
+
+		retval = cyttsp_set_sysinfo_regs(ts);
+		if (retval < 0)
+			return retval;
+
+		retval = cyttsp_set_operational_mode(ts);
+		if (retval < 0)
+			return retval;
+
+		/* init active distance */
+		retval = cyttsp_act_dist_setup(ts);
+		if (retval < 0)
+			return retval;
+
+		ts->power_state = CY_ACTIVE_STATE;
+
+		return 0;
+	}
+
+	return -ENODEV;
+}
+
+static int __cyttsp_enable(struct cyttsp *ts)
+{
+	struct cyttsp_xydata xydata;
+	int retval = 0;
+
+	if (ts->power_state != CY_ACTIVE_STATE) {
+
+		if (ts->pdata->wakeup)
+			retval = ts->pdata->wakeup();
+
+		if (retval == 0) {
+			retval = ttsp_read_block_data(ts, CY_REG_BASE,
+						      sizeof(xydata),
+						      &xydata);
+			if (retval == 0 &&
+			    !GET_HSTMODE(xydata.hst_mode)) {
+				ts->power_state = CY_ACTIVE_STATE;
+				enable_irq(ts->irq);
+			}
+		}
+	}
+
+	return retval;
+}
+
+static int __cyttsp_disable(struct cyttsp *ts)
+{
+	u8 cmd = CY_LOW_POWER_MODE;
+	int retval = 0;
+
+	if (ts->power_state == CY_ACTIVE_STATE) {
+		retval = ttsp_write_block_data(ts, CY_REG_BASE,
+					       sizeof(cmd), &cmd);
+		if (retval == 0) {
+			ts->power_state = CY_SLEEP_STATE;
+			disable_irq(ts->irq);
+		}
+	}
+
+	return retval;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int cyttsp_resume(struct device *dev)
+{
+	struct cyttsp *ts = dev_get_drvdata(dev);
+	int retval = 0;
+
+	mutex_lock(&ts->input->mutex);
+
+	if (ts->suspended)
+		retval = __cyttsp_enable(ts);
+
+	ts->suspended = false;
+
+	mutex_unlock(&ts->input->mutex);
+
+	return retval;
+}
+
+static int cyttsp_suspend(struct device *dev)
+{
+	struct cyttsp *ts = dev_get_drvdata(dev);
+	int retval = 0;
+
+	mutex_lock(&ts->input->mutex);
+
+	if (!ts->suspended)
+		retval = __cyttsp_disable(ts);
+
+	ts->suspended = true;
+
+	mutex_unlock(&ts->input->mutex);
+
+	return retval;
+}
+#endif
+
+SIMPLE_DEV_PM_OPS(cyttsp_pm_ops, cyttsp_suspend, cyttsp_resume);
+EXPORT_SYMBOL_GPL(cyttsp_pm_ops);
+
+static int cyttsp_open(struct input_dev *dev)
+{
+	struct cyttsp *ts = input_get_drvdata(dev);
+	int retval = 0;
+
+	if (!ts->on) {
+		retval = cyttsp_power_on(ts);
+
+		if (retval) {
+			cyttsp_pr_state(ts);
+			return retval;
+		} else
+			ts->on = true;
+	}
+
+	if (!ts->suspended)
+		retval = __cyttsp_enable(ts);
+
+	return retval;
+}
+
+static void cyttsp_close(struct input_dev *dev)
+{
+	struct cyttsp *ts = input_get_drvdata(dev);
+
+	if (!ts->suspended)
+		__cyttsp_disable(ts);
+}
+
+struct cyttsp *cyttsp_probe(const struct cyttsp_bus_ops *bus_ops,
+			    struct device *dev, int irq, size_t xfer_buf_size)
+{
+	const struct cyttsp_platform_data *pdata = dev->platform_data;
+	struct cyttsp *ts;
+	struct input_dev *input_dev;
+	int error;
+
+	if (!dev || !bus_ops || !pdata || !pdata->name || irq <= 0) {
+		error = -EINVAL;
+		goto err_out;
+	}
+
+	ts = kzalloc(sizeof(*ts) + xfer_buf_size, GFP_KERNEL);
+	input_dev = input_allocate_device();
+	if (!ts || !input_dev) {
+		error = -ENOMEM;
+		goto err_free_mem;
+	}
+
+	ts->dev = dev;
+	ts->input = input_dev;
+	ts->pdata = dev->platform_data;
+	ts->bus_ops = bus_ops;
+	ts->irq = irq;
+	ts->suspended = false;
+	ts->on = false;
+
+	init_completion(&ts->bl_ready);
+	snprintf(ts->phys, sizeof(ts->phys), "%s/input0", dev_name(dev));
+
+	if (pdata->init) {
+		error = pdata->init();
+		if (error) {
+			dev_err(ts->dev, "platform init failed, err: %d\n",
+				error);
+			goto err_free_mem;
+		}
+	}
+
+	input_dev->name = pdata->name;
+	input_dev->phys = ts->phys;
+	input_dev->id.bustype = bus_ops->bustype;
+	input_dev->dev.parent = ts->dev;
+
+	input_dev->open = cyttsp_open;
+	input_dev->close = cyttsp_close;
+
+	input_set_drvdata(input_dev, ts);
+
+	__set_bit(EV_ABS, input_dev->evbit);
+	input_set_abs_params(input_dev, ABS_MT_POSITION_X,
+			     0, pdata->maxx, 0, 0);
+	input_set_abs_params(input_dev, ABS_MT_POSITION_Y,
+			     0, pdata->maxy, 0, 0);
+	input_set_abs_params(input_dev, ABS_MT_TOUCH_MAJOR,
+			     0, CY_MAXZ, 0, 0);
+
+	input_mt_init_slots(input_dev, CY_MAX_ID);
+
+	error = request_threaded_irq(ts->irq, NULL, cyttsp_irq,
+				     IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+				     pdata->name, ts);
+	if (error) {
+		dev_err(ts->dev, "failed to request IRQ %d, err: %d\n",
+			ts->irq, error);
+		goto err_platform_exit;
+	}
+	disable_irq(ts->irq);
+
+	error = input_register_device(input_dev);
+	if (error) {
+		dev_err(ts->dev, "failed to register input device: %d\n",
+			error);
+		goto err_free_irq;
+	}
+
+	return ts;
+
+err_free_irq:
+	free_irq(ts->irq, ts);
+err_platform_exit:
+	if (pdata->exit)
+		pdata->exit();
+err_free_mem:
+	input_free_device(input_dev);
+	kfree(ts);
+err_out:
+	return ERR_PTR(error);
+}
+EXPORT_SYMBOL_GPL(cyttsp_probe);
+
+void cyttsp_remove(struct cyttsp *ts)
+{
+	free_irq(ts->irq, ts);
+	input_unregister_device(ts->input);
+	if (ts->pdata->exit)
+		ts->pdata->exit();
+	kfree(ts);
+}
+EXPORT_SYMBOL_GPL(cyttsp_remove);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Cypress TrueTouch(R) Standard touchscreen driver core");
+MODULE_AUTHOR("Cypress");
+
diff --git a/drivers/input/touchscreen/cyttsp_core.h b/drivers/input/touchscreen/cyttsp_core.h
new file mode 100644
index 0000000..866f5e2
--- /dev/null
+++ b/drivers/input/touchscreen/cyttsp_core.h
@@ -0,0 +1,141 @@
+/*
+ * Header file for:
+ * Cypress TrueTouch(TM) Standard Product (TTSP) touchscreen drivers.
+ * For use with Cypress Txx3xx parts.
+ * Supported parts include:
+ * CY8CTST341
+ * CY8CTMA340
+ *
+ * Copyright (C) 2009, 2010, 2011 Cypress Semiconductor, Inc.
+ * Copyright (C) 2012 Javier Martinez Canillas <javier@dowhile0.org>
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
+#include <linux/types.h>
+#include <linux/device.h>
+#include <linux/input/cyttsp.h>
+
+#define CY_NUM_RETRY		16 /* max number of retries for read ops */
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
+struct cyttsp_bus_ops {
+	u16 bustype;
+	int (*write)(struct device *dev,
+		     u8 addr, u8 length, const void *values);
+	int (*read)(struct device *dev, u8 addr, u8 length, void *values);
+};
+
+struct cyttsp {
+	struct device *dev;
+	int irq;
+	struct input_dev *input;
+	char phys[32];
+	const struct cyttsp_platform_data *pdata;
+	const struct cyttsp_bus_ops *bus_ops;
+	struct cyttsp_bootloader_data bl_data;
+	struct cyttsp_sysinfo_data sysinfo_data;
+	struct completion bl_ready;
+	enum cyttsp_powerstate power_state;
+	bool suspended;
+	bool on;
+
+	u8 xfer_buf[] ____cacheline_aligned;
+};
+
+struct cyttsp *cyttsp_probe(const struct cyttsp_bus_ops *bus_ops,
+			    struct device *dev, int irq, size_t xfer_buf_size);
+void cyttsp_remove(struct cyttsp *ts);
+
+extern const struct dev_pm_ops cyttsp_pm_ops;
+
+#endif /* __CYTTSP_CORE_H__ */
diff --git a/drivers/input/touchscreen/cyttsp_i2c.c b/drivers/input/touchscreen/cyttsp_i2c.c
new file mode 100644
index 0000000..cdbf61d
--- /dev/null
+++ b/drivers/input/touchscreen/cyttsp_i2c.c
@@ -0,0 +1,137 @@
+/*
+ * Source for:
+ * Cypress TrueTouch(TM) Standard Product (TTSP) I2C touchscreen driver.
+ * For use with Cypress Txx3xx parts.
+ * Supported parts include:
+ * CY8CTST341
+ * CY8CTMA340
+ *
+ * Copyright (C) 2009, 2010, 2011 Cypress Semiconductor, Inc.
+ * Copyright (C) 2012 Javier Martinez Canillas <javier@dowhile0.org>
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
+#include <linux/input.h>
+
+#define CY_I2C_DATA_SIZE  128
+
+static int cyttsp_i2c_read_block_data(struct device *dev,
+				      u8 addr, u8 length, void *values)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	int retval;
+
+	retval = i2c_master_send(client, &addr, 1);
+	if (retval < 0)
+		return retval;
+
+	retval = i2c_master_recv(client, values, length);
+
+	if (retval < 0)
+		return retval;
+
+	return (retval != length) ? -EIO : 0;
+}
+
+static int cyttsp_i2c_write_block_data(struct device *dev,
+				       u8 addr, u8 length, const void *values)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct cyttsp *ts = i2c_get_clientdata(client);
+	int retval;
+
+	ts->xfer_buf[0] = addr;
+	memcpy(&ts->xfer_buf[1], values, length);
+	retval = i2c_master_send(client, ts->xfer_buf, length + 1);
+
+	return (retval < 0) ? retval : 0;
+}
+
+static const struct cyttsp_bus_ops cyttsp_i2c_bus_ops = {
+	.bustype        = BUS_I2C,
+	.write          = cyttsp_i2c_write_block_data,
+	.read           = cyttsp_i2c_read_block_data,
+};
+
+static int __devinit cyttsp_i2c_probe(struct i2c_client *client,
+				      const struct i2c_device_id *id)
+{
+	struct cyttsp *ts;
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
+		dev_err(&client->dev, "I2C functionality not Supported\n");
+		return -EIO;
+	}
+
+	ts = cyttsp_probe(&cyttsp_i2c_bus_ops, &client->dev, client->irq,
+			  CY_I2C_DATA_SIZE);
+
+	if (IS_ERR(ts))
+		return PTR_ERR(ts);
+
+	i2c_set_clientdata(client, ts);
+
+	return 0;
+}
+
+static int __devexit cyttsp_i2c_remove(struct i2c_client *client)
+{
+	struct cyttsp *ts = i2c_get_clientdata(client);
+
+	cyttsp_remove(ts);
+
+	return 0;
+}
+
+static const struct i2c_device_id cyttsp_i2c_id[] = {
+	{ CY_I2C_NAME, 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, cyttsp_i2c_id);
+
+static struct i2c_driver cyttsp_i2c_driver = {
+	.driver = {
+		.name   = CY_I2C_NAME,
+		.owner  = THIS_MODULE,
+		.pm     = &cyttsp_pm_ops,
+	},
+	.probe          = cyttsp_i2c_probe,
+	.remove         = __devexit_p(cyttsp_i2c_remove),
+	.id_table       = cyttsp_i2c_id,
+};
+
+static int __init cyttsp_i2c_init(void)
+{
+	return i2c_add_driver(&cyttsp_i2c_driver);
+}
+module_init(cyttsp_i2c_init);
+
+static void __exit cyttsp_i2c_exit(void)
+{
+	return i2c_del_driver(&cyttsp_i2c_driver);
+}
+module_exit(cyttsp_i2c_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Cypress TrueTouch(R) Standard Product (TTSP) I2C driver");
+MODULE_AUTHOR("Cypress");
+MODULE_ALIAS("i2c:cyttsp");
diff --git a/drivers/input/touchscreen/cyttsp_spi.c b/drivers/input/touchscreen/cyttsp_spi.c
new file mode 100644
index 0000000..3238c7d
--- /dev/null
+++ b/drivers/input/touchscreen/cyttsp_spi.c
@@ -0,0 +1,245 @@
+/*
+ * Source for:
+ * Cypress TrueTouch(TM) Standard Product (TTSP) SPI touchscreen driver.
+ * For use with Cypress Txx3xx parts.
+ * Supported parts include:
+ * CY8CTST341
+ * CY8CTMA340
+ *
+ * Copyright (C) 2009, 2010, 2011 Cypress Semiconductor, Inc.
+ * Copyright (C) 2012 Javier Martinez Canillas <javier@dowhile0.org>
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
+#include <linux/spi/spi.h>
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
+static int cyttsp_spi_xfer(u8 op, struct spi_device *spi,
+			   u8 reg, u8 *buf, int length)
+{
+	struct cyttsp *ts = spi_get_drvdata(spi);
+	struct spi_message msg;
+	struct spi_transfer xfer[2];
+	u8 *wr_buf = &ts->xfer_buf[0];
+	u8 *rd_buf = &ts->xfer_buf[CY_SPI_DATA_BUF_SIZE];
+	int retval;
+
+	if (length > CY_SPI_DATA_SIZE) {
+		dev_dbg(&spi->dev, "%s: length %d is too big.\n",
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
+	memset(xfer, 0, sizeof(xfer));
+	spi_message_init(&msg);
+
+	/*
+	  We set both TX and RX buffers because Cypress TTSP
+	  requires full duplex operation.
+	*/
+	xfer[0].tx_buf = wr_buf;
+	xfer[0].rx_buf = rd_buf;
+	switch (op) {
+	case CY_SPI_WR_OP:
+		xfer[0].len = length + CY_SPI_CMD_BYTES;
+		spi_message_add_tail(&xfer[0], &msg);
+		break;
+
+	case CY_SPI_RD_OP:
+		xfer[0].len = CY_SPI_CMD_BYTES;
+		spi_message_add_tail(&xfer[0], &msg);
+
+		xfer[1].rx_buf = buf;
+		xfer[1].len = length;
+		spi_message_add_tail(&xfer[1], &msg);
+		break;
+
+	default:
+		dev_dbg(&spi->dev,
+			"%s: bad operation code=%d\n", __func__, op);
+		return -EINVAL;
+	}
+
+	retval = spi_sync(spi, &msg);
+	if (retval < 0) {
+		dev_dbg(&spi->dev,
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
+	if (rd_buf[CY_SPI_SYNC_BYTE] != CY_SPI_SYNC_ACK1 ||
+	    rd_buf[CY_SPI_SYNC_BYTE + 1] != CY_SPI_SYNC_ACK2) {
+		int i;
+		for (i = 0; i < CY_SPI_CMD_BYTES; i++)
+			dev_dbg(&spi->dev,
+				"%s: test rd_buf[%d]:0x%02x\n",
+				__func__, i, rd_buf[i]);
+		for (i = 0; i < length; i++)
+			dev_dbg(&spi->dev,
+				"%s: test buf[%d]:0x%02x\n",
+				__func__, i, buf[i]);
+
+		/* signal ACK error so silent retry */
+		return 1;
+	}
+
+	return 0;
+}
+
+static int cyttsp_spi_read_block_data(struct device *dev,
+				      u8 addr, u8 length, void *data)
+{
+	struct spi_device *spi = to_spi_device(dev);
+	int retval;
+
+	retval = cyttsp_spi_xfer(CY_SPI_RD_OP, spi, addr, data, length);
+	if (retval < 0)
+		dev_err(dev, "cyttsp_spi_read_block_data failed, err: %d\n",
+			retval);
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
+static int cyttsp_spi_write_block_data(struct device *dev,
+				       u8 addr, u8 length, const void *data)
+{
+	struct spi_device *spi = to_spi_device(dev);
+	int retval;
+
+	retval = cyttsp_spi_xfer(CY_SPI_WR_OP, spi, addr, (void *)data, length);
+	if (retval < 0)
+		dev_err(dev, "cyttsp_spi_write_block_data failed, err: %d\n",
+			retval);
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
+static const struct cyttsp_bus_ops cyttsp_spi_bus_ops = {
+	.bustype        = BUS_SPI,
+	.write          = cyttsp_spi_write_block_data,
+	.read           = cyttsp_spi_read_block_data,
+};
+
+static int __devinit cyttsp_spi_probe(struct spi_device *spi)
+{
+	struct cyttsp *ts;
+	int error;
+
+	/* Set up SPI*/
+	spi->bits_per_word = CY_SPI_BITS_PER_WORD;
+	spi->mode = SPI_MODE_0;
+	error = spi_setup(spi);
+	if (error < 0) {
+		dev_err(&spi->dev, "%s: SPI setup error %d\n",
+			__func__, error);
+		return error;
+	}
+
+	ts = cyttsp_probe(&cyttsp_spi_bus_ops, &spi->dev, spi->irq,
+			  CY_SPI_DATA_BUF_SIZE * 2);
+	if (IS_ERR(ts))
+		return PTR_ERR(ts);
+
+	spi_set_drvdata(spi, ts);
+
+	return 0;
+}
+
+static int __devexit cyttsp_spi_remove(struct spi_device *spi)
+{
+	struct cyttsp *ts = dev_get_drvdata(&spi->dev);
+
+	cyttsp_remove(ts);
+
+	return 0;
+}
+
+static struct spi_driver cyttsp_spi_driver = {
+	.driver = {
+		.name   = CY_SPI_NAME,
+		.owner  = THIS_MODULE,
+		.pm     = &cyttsp_pm_ops,
+	},
+	.probe  = cyttsp_spi_probe,
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
+MODULE_ALIAS("spi:cyttsp");
+
diff --git a/include/linux/input/cyttsp.h b/include/linux/input/cyttsp.h
new file mode 100644
index 0000000..f792603
--- /dev/null
+++ b/include/linux/input/cyttsp.h
@@ -0,0 +1,68 @@
+/*
+ * Header file for:
+ * Cypress TrueTouch(TM) Standard Product (TTSP) touchscreen drivers.
+ * For use with Cypress Txx3xx parts.
+ * Supported parts include:
+ * CY8CTST341
+ * CY8CTMA340
+ *
+ * Copyright (C) 2009, 2010, 2011 Cypress Semiconductor, Inc.
+ * Copyright (C) 2012 Javier Martinez Canillas <javier@dowhile0.org>
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
+ * Contact Cypress Semiconductor at www.cypress.com (kev@cypress.com)
+ *
+ */
+#ifndef _CYTTSP_H_
+#define _CYTTSP_H_
+
+#define CY_SPI_NAME "cyttsp-spi"
+#define CY_I2C_NAME "cyttsp-i2c"
+/* Active Power state scanning/processing refresh interval */
+#define CY_ACT_INTRVL_DFLT 0x00 /* ms */
+/* touch timeout for the Active power */
+#define CY_TCH_TMOUT_DFLT 0xFF /* ms */
+/* Low Power state scanning/processing refresh interval */
+#define CY_LP_INTRVL_DFLT 0x0A /* ms */
+/* Active distance in pixels for a gesture to be reported */
+#define CY_ACT_DIST_DFLT 0xF8 /* pixels */
+
+enum cyttsp_powerstate {
+	CY_IDLE_STATE,
+	CY_ACTIVE_STATE,
+	CY_LOW_PWR_STATE,
+	CY_SLEEP_STATE,
+	CY_BL_STATE,
+	CY_INVALID_STATE	/* always last in the list */
+};
+
+struct cyttsp_platform_data {
+	u32 maxx;
+	u32 maxy;
+	bool use_hndshk;
+	u8 act_dist;	/* Active distance */
+	u8 act_intrvl;  /* Active refresh interval; ms */
+	u8 tch_tmout;   /* Active touch timeout; ms */
+	u8 lp_intrvl;   /* Low power refresh interval; ms */
+	int (*wakeup)(void);
+	int (*init)(void);
+	void (*exit)(void);
+	char *name;
+	s16 irq_gpio;
+	u8 *bl_keys;
+};
+
+#endif /* _CYTTSP_H_ */

--T4sUOijqQbZv57TR--
