From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v10 1/3] Input: cyttsp - Cypress TTSP capacitive
 multi-touch screen support
Date: Fri, 27 Jan 2012 00:18:33 -0800
Message-ID: <20120127081833.GA21903@core.coreip.homeip.net>
References: <1327021046-18024-1-git-send-email-javier@dowhile0.org>
 <CABxcv=kE4-8mGVw9F0sFu_DsC2fU_HNsU-Q4+QEs_FDDqMzKTw@mail.gmail.com>
 <20120124075430.GA9775@core.coreip.homeip.net>
 <CABxcv=k_e3Pdx=OaLWW-xTGoDXEQKKGWYzcLLWvZEnYBPSv6qw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:36637 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751995Ab2A0ISm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 27 Jan 2012 03:18:42 -0500
Received: by dadi2 with SMTP id i2so1205802dad.19
        for <linux-input@vger.kernel.org>; Fri, 27 Jan 2012 00:18:41 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CABxcv=k_e3Pdx=OaLWW-xTGoDXEQKKGWYzcLLWvZEnYBPSv6qw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Javier Martinez Canillas <javier@dowhile0.org>
Cc: Henrik Rydberg <rydberg@euromail.se>, Mohan Pallaka <mpallaka@codeaurora.org>, Kevin McNeely <kev@cypress.com>, Shubhrajyoti Datta <omaplinuxkernel@gmail.com>, linux-input@vger.kernel.org

On Thu, Jan 26, 2012 at 01:12:50AM +0100, Javier Martinez Canillas wrot=
e:
> On Tue, Jan 24, 2012 at 8:54 AM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > On Tue, Jan 24, 2012 at 08:26:39AM +0100, Javier Martinez Canillas =
wrote:
> >> On Fri, Jan 20, 2012 at 1:57 AM, Javier Martinez Canillas
> >> <javier@dowhile0.org> wrote:
> >> > Cypress TrueTouch(tm) Standard Product controllers are found in
> >> > a wide range of embedded devices. This driver add support for a
> >> > variety of TTSP controllers.
> >> >
> >> > Since the hardware is capable of tracking identifiable contacts,=
 multi-touch
> >> > protocol type B (stateful) is used to report contact information=
=2E
> >> >
> >> > The driver is composed of a core driver that process the data se=
nt by
> >> > the contacts and a set of bus specific interface modules. This p=
atch
> >> > adds the base core TTSP driver.
> >> >
> >> > Signed-off-by: Javier Martinez Canillas <javier@dowhile0.org>
> >> > ---
> >> >
> >> > Changes for v10: Fix issues called out by Dmitry Torokhov
> >> > =A0 =A0 =A0 =A0- Remove use_sleep and put device to sleep uncond=
itionally on suspend
> >> > =A0 =A0 =A0 =A0- Cleanup cyttsp_power_on() and remove cyttsp_bl_=
app_valid() function
> >> >
> >> > =A0drivers/input/touchscreen/Kconfig =A0 =A0 =A0 | =A0 31 ++
> >> > =A0drivers/input/touchscreen/Makefile =A0 =A0 =A0| =A0 =A03 +
> >> > =A0drivers/input/touchscreen/cyttsp_core.c | =A0682 ++++++++++++=
+++++++++++++++++++
> >> > =A0drivers/input/touchscreen/cyttsp_core.h | =A0141 +++++++
> >> > =A0include/linux/input/cyttsp.h =A0 =A0 =A0 =A0 =A0 =A0| =A0 68 =
+++
> >> > =A05 files changed, 925 insertions(+), 0 deletions(-)
> >>
> >> Hello Dmitry,
> >>
> >> Any comments on this version?
> >
> > Looking at it... If you do not hear from me by Wednesday please pin=
g
> > me again.
> >
> > Thanks.
> >
> > --
> > Dmitry
>=20
> ping :)

Is it still Wednesday by any chance? ;)

Anyway, the driver looks pretty good, still below are some changes that
I'd like to get in as well:

- do not return EAGAIN when operation times out, EIO I believe suits
  better.
- introduce ttsp_send_command() to replace host of custom functions.
- reduce numver of states to 3 - IDLE, ACTIVE and BL mode.
  Suspended/full power is already covered by "suspended" attribute.
- streamline some functions.

Please see the FIXME comment in cyttsp_enable() - is there a generic wa=
y
to wake up the device, similarly to the way we put it to sleep?

Please tell me if the device still works with this patch.

Thanks!

--=20
Dmitry

Input: cyttsp - random edits

=46rom: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/touchscreen/cyttsp_core.c |  562 ++++++++++++++---------=
--------
 drivers/input/touchscreen/cyttsp_core.h |   10 -
 drivers/input/touchscreen/cyttsp_i2c.c  |   44 +-
 drivers/input/touchscreen/cyttsp_spi.c  |   97 ++---
 include/linux/input/cyttsp.h            |    9=20
 5 files changed, 321 insertions(+), 401 deletions(-)


diff --git a/drivers/input/touchscreen/cyttsp_core.c b/drivers/input/to=
uchscreen/cyttsp_core.c
index 28d5ef0..ff74a33 100644
--- a/drivers/input/touchscreen/cyttsp_core.c
+++ b/drivers/input/touchscreen/cyttsp_core.c
@@ -27,8 +27,6 @@
  *
  */
=20
-#include "cyttsp_core.h"
-
 #include <linux/delay.h>
 #include <linux/input.h>
 #include <linux/input/mt.h>
@@ -36,39 +34,41 @@
 #include <linux/interrupt.h>
 #include <linux/slab.h>
=20
+#include "cyttsp_core.h"
+
 /* Bootloader number of command keys */
-#define CY_NUM_BL_KEYS    8
+#define CY_NUM_BL_KEYS		8
=20
 /* helpers */
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
-#define CY_DELAY_MAX                500
-#define CY_ACT_DIST_DFLT            0xF8
-#define CY_HNDSHK_BIT               0x80
+#define GET_NUM_TOUCHES(x)		((x) & 0x0F)
+#define IS_LARGE_AREA(x)		(((x) & 0x10) >> 4)
+#define IS_BAD_PKT(x)			((x) & 0x20)
+#define IS_VALID_APP(x)			((x) & 0x01)
+#define IS_OPERATIONAL_ERR(x)		((x) & 0x3F)
+#define GET_HSTMODE(reg)		(((reg) & 0x70) >> 4)
+#define GET_BOOTLOADERMODE(reg)		(((reg) & 0x10) >> 4)
+
+#define CY_REG_BASE			0x00
+#define CY_REG_ACT_DIST			0x1E
+#define CY_REG_ACT_INTRVL		0x1D
+#define CY_REG_TCH_TMOUT		(CY_REG_ACT_INTRVL + 1)
+#define CY_REG_LP_INTRVL		(CY_REG_TCH_TMOUT + 1)
+#define CY_MAXZ				255
+#define CY_DELAY_DFLT			20 /* ms */
+#define CY_DELAY_MAX			500
+#define CY_ACT_DIST_DFLT		0xF8
+#define CY_HNDSHK_BIT			0x80
 /* device mode bits */
-#define CY_OPERATE_MODE             0x00
-#define CY_SYSINFO_MODE             0x10
+#define CY_OPERATE_MODE			0x00
+#define CY_SYSINFO_MODE			0x10
 /* power mode select bits */
-#define CY_SOFT_RESET_MODE          0x01 /* return to Bootloader mode =
*/
-#define CY_DEEP_SLEEP_MODE          0x02
-#define CY_LOW_POWER_MODE           0x04
+#define CY_SOFT_RESET_MODE		0x01 /* return to Bootloader mode */
+#define CY_DEEP_SLEEP_MODE		0x02
+#define CY_LOW_POWER_MODE		0x04
=20
 /* Slots management */
-#define CY_MAX_FINGER               4
-#define CY_MAX_ID                   16
+#define CY_MAX_FINGER			4
+#define CY_MAX_ID			16
=20
 static const u8 bl_command[] =3D {
 	0x00,			/* file offset */
@@ -78,60 +78,56 @@ static const u8 bl_command[] =3D {
 };
=20
 static int ttsp_read_block_data(struct cyttsp *ts, u8 command,
-	u8 length, void *buf)
+				u8 length, void *buf)
 {
-	int retval =3D -1;
+	int error;
 	int tries;
=20
-	if (!buf || !length)
-		return -EINVAL;
+	for (tries =3D 0; tries < CY_NUM_RETRY; tries++) {
+		error =3D ts->bus_ops->read(ts->dev, command, length, buf);
+		if (!error)
+			return 0;
=20
-	for (tries =3D 0; tries < CY_NUM_RETRY && (retval < 0); tries++) {
-		retval =3D ts->bus_ops->read(ts->dev, command, length, buf);
-		if (retval)
-			msleep(CY_DELAY_DFLT);
+		msleep(CY_DELAY_DFLT);
 	}
=20
-	if (tries >=3D CY_NUM_RETRY)
-		return -EAGAIN;
-
-	return retval;
+	return -EIO;
 }
=20
 static int ttsp_write_block_data(struct cyttsp *ts, u8 command,
-	u8 length, void *buf)
+				 u8 length, void *buf)
 {
-	int retval =3D -1;
+	int error;
 	int tries;
=20
-	if (!buf || !length)
-		return -EINVAL;
+	for (tries =3D 0; tries < CY_NUM_RETRY; tries++) {
+		error =3D ts->bus_ops->write(ts->dev, command, length, buf);
+		if (!error)
+			return 0;
=20
-	for (tries =3D 0; tries < CY_NUM_RETRY && (retval < 0); tries++) {
-		retval =3D ts->bus_ops->write(ts->dev, command, length, buf);
-		if (retval)
-			msleep(CY_DELAY_DFLT);
+		msleep(CY_DELAY_DFLT);
 	}
=20
-	if (tries >=3D CY_NUM_RETRY)
-		return -EAGAIN;
+	return -EIO;
+}
=20
-	return retval;
+static int ttsp_send_command(struct cyttsp *ts, u8 cmd)
+{
+	return ttsp_write_block_data(ts, CY_REG_BASE, sizeof(cmd), &cmd);
 }
=20
 static int cyttsp_load_bl_regs(struct cyttsp *ts)
 {
-	memset(&(ts->bl_data), 0, sizeof(struct cyttsp_bootloader_data));
-
+	memset(&ts->bl_data, 0, sizeof(ts->bl_data));
 	ts->bl_data.bl_status =3D 0x10;
=20
-	return  ttsp_read_block_data(ts, CY_REG_BASE, sizeof(ts->bl_data),
-				     &ts->bl_data);
+	return ttsp_read_block_data(ts, CY_REG_BASE,
+				    sizeof(ts->bl_data), &ts->bl_data);
 }
=20
 static int cyttsp_exit_bl_mode(struct cyttsp *ts)
 {
-	int retval;
+	int error;
 	u8 bl_cmd[sizeof(bl_command)];
=20
 	memcpy(bl_cmd, bl_command, sizeof(bl_command));
@@ -139,65 +135,63 @@ static int cyttsp_exit_bl_mode(struct cyttsp *ts)
 		memcpy(&bl_cmd[sizeof(bl_command) - CY_NUM_BL_KEYS],
 			ts->pdata->bl_keys, sizeof(bl_command));
=20
-	retval =3D ttsp_write_block_data(ts, CY_REG_BASE,
-		sizeof(bl_cmd), (void *)bl_cmd);
-
-	if (retval < 0)
-		return retval;
+	error =3D ttsp_write_block_data(ts, CY_REG_BASE,
+				      sizeof(bl_cmd), bl_cmd);
+	if (error)
+		return error;
=20
 	/* wait for TTSP Device to complete the operation */
 	msleep(CY_DELAY_DFLT);
-	retval =3D cyttsp_load_bl_regs(ts);
=20
-	if (retval || GET_BOOTLOADERMODE(ts->bl_data.bl_status))
-		return -ENODEV;
+	error =3D cyttsp_load_bl_regs(ts);
+	if (error)
+		return error;
=20
-	return retval;
+	if (GET_BOOTLOADERMODE(ts->bl_data.bl_status))
+		return -EIO;
+
+	return 0;
 }
=20
 static int cyttsp_set_operational_mode(struct cyttsp *ts)
 {
-	struct cyttsp_xydata xy_data;
-	int retval;
-	u8 cmd =3D CY_OPERATE_MODE;
-
-	retval =3D ttsp_write_block_data(ts, CY_REG_BASE, sizeof(cmd), &cmd);
+	int error;
=20
-	if (retval < 0)
-		return retval;
+	error =3D ttsp_send_command(ts, CY_OPERATE_MODE);
+	if (error)
+		return error;
=20
 	/* wait for TTSP Device to complete switch to Operational mode */
-	retval =3D ttsp_read_block_data(ts, CY_REG_BASE,
-				      sizeof(xy_data), &(xy_data));
+	error =3D ttsp_read_block_data(ts, CY_REG_BASE,
+				     sizeof(ts->xy_data), &ts->xy_data);
+	if (error)
+		return error;
=20
-	if (retval || xy_data.act_dist =3D=3D CY_ACT_DIST_DFLT)
-		return -EAGAIN;
-
-	return retval;
+	return ts->xy_data.act_dist =3D=3D CY_ACT_DIST_DFLT ? -EIO : 0;
 }
=20
 static int cyttsp_set_sysinfo_mode(struct cyttsp *ts)
 {
-	int retval;
-	u8 cmd =3D CY_SYSINFO_MODE;
+	int error;
=20
-	memset(&(ts->sysinfo_data), 0, sizeof(struct cyttsp_sysinfo_data));
+	memset(&ts->sysinfo_data, 0, sizeof(ts->sysinfo_data));
=20
 	/* switch to sysinfo mode */
-	retval =3D ttsp_write_block_data(ts, CY_REG_BASE, sizeof(cmd), &cmd);
-	if (retval < 0)
-		return retval;
+	error =3D ttsp_send_command(ts, CY_SYSINFO_MODE);
+	if (error)
+		return error;
=20
 	/* read sysinfo registers */
 	msleep(CY_DELAY_DFLT);
-	retval =3D ttsp_read_block_data(ts, CY_REG_BASE, sizeof(ts->sysinfo_d=
ata),
+	error =3D ttsp_read_block_data(ts, CY_REG_BASE, sizeof(ts->sysinfo_da=
ta),
 				      &ts->sysinfo_data);
+	if (error)
+		return error;
=20
-	if (retval || (!ts->sysinfo_data.tts_verh &&
-		       !ts->sysinfo_data.tts_verl))
-		return -EAGAIN;
+	if (!ts->sysinfo_data.tts_verh && !ts->sysinfo_data.tts_verl)
+		return -EIO;
=20
-	return retval;
+	return 0;
 }
=20
 static int cyttsp_set_sysinfo_regs(struct cyttsp *ts)
@@ -205,20 +199,18 @@ static int cyttsp_set_sysinfo_regs(struct cyttsp =
*ts)
 	int retval =3D 0;
=20
 	if (ts->pdata->act_intrvl !=3D CY_ACT_INTRVL_DFLT ||
-		ts->pdata->tch_tmout !=3D CY_TCH_TMOUT_DFLT ||
-		ts->pdata->lp_intrvl !=3D CY_LP_INTRVL_DFLT) {
-
-		u8 intrvl_ray[3];
+	    ts->pdata->tch_tmout !=3D CY_TCH_TMOUT_DFLT ||
+	    ts->pdata->lp_intrvl !=3D CY_LP_INTRVL_DFLT) {
=20
-		intrvl_ray[0] =3D ts->pdata->act_intrvl;
-		intrvl_ray[1] =3D ts->pdata->tch_tmout;
-		intrvl_ray[2] =3D ts->pdata->lp_intrvl;
+		u8 intrvl_ray[] =3D {
+			ts->pdata->act_intrvl,
+			ts->pdata->tch_tmout,
+			ts->pdata->lp_intrvl
+		};
=20
 		/* set intrvl registers */
-		retval =3D ttsp_write_block_data(ts,
-				CY_REG_ACT_INTRVL,
-				sizeof(intrvl_ray), intrvl_ray);
-
+		retval =3D ttsp_write_block_data(ts, CY_REG_ACT_INTRVL,
+					sizeof(intrvl_ray), intrvl_ray);
 		msleep(CY_DELAY_DFLT);
 	}
=20
@@ -227,55 +219,36 @@ static int cyttsp_set_sysinfo_regs(struct cyttsp =
*ts)
=20
 static int cyttsp_soft_reset(struct cyttsp *ts)
 {
+	unsigned long timeout;
 	int retval;
-	u8 cmd =3D CY_SOFT_RESET_MODE;
-	long wait_jiffies =3D msecs_to_jiffies(CY_DELAY_DFLT * CY_DELAY_MAX);
+
 	/* wait for interrupt to set ready completion */
 	INIT_COMPLETION(ts->bl_ready);
+	ts->state =3D CY_BL_STATE;
=20
-	retval =3D ttsp_write_block_data(ts, CY_REG_BASE, sizeof(cmd), &cmd);
-	if (retval < 0)
-		return retval;
+	enable_irq(ts->irq);
=20
-	return wait_for_completion_timeout(&ts->bl_ready, wait_jiffies);
-}
+	retval =3D ttsp_send_command(ts, CY_SOFT_RESET_MODE);
+	if (retval)
+		goto out;
=20
-static int cyttsp_act_dist_setup(struct cyttsp *ts)
-{
-	int retval;
-	u8 act_dist_setup;
-
-	/* Init gesture; active distance setup */
-	act_dist_setup =3D ts->pdata->act_dist;
-	retval =3D ttsp_write_block_data(ts, CY_REG_ACT_DIST,
-		sizeof(act_dist_setup), &act_dist_setup);
+	timeout =3D wait_for_completion_timeout(&ts->bl_ready,
+			msecs_to_jiffies(CY_DELAY_DFLT * CY_DELAY_MAX));
+	retval =3D timeout ? 0 : -EIO;
=20
+out:
+	ts->state =3D CY_IDLE_STATE;
+	disable_irq(ts->irq);
 	return retval;
 }
=20
-static int cyttsp_hndshk(struct cyttsp *ts, u8 hst_mode)
-{
-	u8 cmd;
-
-	cmd =3D hst_mode ^ CY_HNDSHK_BIT;
-
-	return ttsp_write_block_data(ts, CY_REG_BASE, sizeof(cmd), (u8 *)&cmd=
);
-}
-
-static void cyttsp_report_slot(struct input_dev *dev, int slot,
-			       int x, int y, int z)
+static int cyttsp_act_dist_setup(struct cyttsp *ts)
 {
-	input_mt_slot(dev, slot);
-	input_mt_report_slot_state(dev, MT_TOOL_FINGER, true);
-	input_report_abs(dev, ABS_MT_POSITION_X, x);
-	input_report_abs(dev, ABS_MT_POSITION_Y, y);
-	input_report_abs(dev, ABS_MT_TOUCH_MAJOR, z);
-}
+	u8 act_dist_setup =3D ts->pdata->act_dist;
=20
-static void cyttsp_report_slot_empty(struct input_dev *dev, int slot)
-{
-	input_mt_slot(dev, slot);
-	input_mt_report_slot_state(dev, MT_TOOL_FINGER, false);
+	/* Init gesture; active distance setup */
+	return ttsp_write_block_data(ts, CY_REG_ACT_DIST,
+				sizeof(act_dist_setup), &act_dist_setup);
 }
=20
 static void cyttsp_extract_track_ids(struct cyttsp_xydata *xy_data, in=
t *ids)
@@ -297,249 +270,231 @@ static const struct cyttsp_tch *cyttsp_get_tch(=
struct cyttsp_xydata *xy_data,
 	case 2:
 		return &xy_data->tch3;
 	case 3:
-		return  &xy_data->tch4;
+		return &xy_data->tch4;
 	default:
 		return NULL;
 	}
 }
=20
-static int cyttsp_handle_tchdata(struct cyttsp *ts)
+static void cyttsp_report_tchdata(struct cyttsp *ts)
 {
-	struct cyttsp_xydata xy_data;
-	u8 num_cur_tch;
+	struct cyttsp_xydata *xy_data =3D &ts->xy_data;
+	struct input_dev *input =3D ts->input;
+	int num_tch =3D GET_NUM_TOUCHES(xy_data->tt_stat);
+	const struct cyttsp_tch *tch;
+	int ids[CY_MAX_ID];
 	int i;
-	int ids[4];
-	const struct cyttsp_tch *tch =3D NULL;
-	int x, y, z;
-	int used =3D 0;
-
-	/* Get touch data from CYTTSP device */
-	if (ttsp_read_block_data(ts,
-		CY_REG_BASE, sizeof(struct cyttsp_xydata), &xy_data))
-		return 0;
+	DECLARE_BITMAP(used, CY_MAX_ID);
=20
-	/* provide flow control handshake */
-	if (ts->pdata->use_hndshk)
-		if (cyttsp_hndshk(ts, xy_data.hst_mode))
-			return 0;
-
-	/* determine number of currently active touches */
-	num_cur_tch =3D GET_NUM_TOUCHES(xy_data.tt_stat);
-
-	/* check for any error conditions */
-	if (ts->power_state =3D=3D CY_IDLE_STATE)
-		return 0;
-	else if (GET_BOOTLOADERMODE(xy_data.tt_mode)) {
-		return -1;
-	} else if (IS_LARGE_AREA(xy_data.tt_stat) =3D=3D 1) {
+	if (IS_LARGE_AREA(xy_data->tt_stat) =3D=3D 1) {
 		/* terminate all active tracks */
-		num_cur_tch =3D 0;
+		num_tch =3D 0;
 		dev_dbg(ts->dev, "%s: Large area detected\n", __func__);
-	} else if (num_cur_tch > CY_MAX_FINGER) {
+	} else if (num_tch > CY_MAX_FINGER) {
 		/* terminate all active tracks */
-		num_cur_tch =3D 0;
+		num_tch =3D 0;
 		dev_dbg(ts->dev, "%s: Num touch error detected\n", __func__);
-	} else if (IS_BAD_PKT(xy_data.tt_mode)) {
+	} else if (IS_BAD_PKT(xy_data->tt_mode)) {
 		/* terminate all active tracks */
-		num_cur_tch =3D 0;
+		num_tch =3D 0;
 		dev_dbg(ts->dev, "%s: Invalid buffer detected\n", __func__);
 	}
=20
-	cyttsp_extract_track_ids(&xy_data, ids);
+	cyttsp_extract_track_ids(xy_data, ids);
=20
-	for (i =3D 0; i < num_cur_tch; i++) {
-		used |=3D (1 << ids[i]);
+	bitmap_zero(used, CY_MAX_ID);
=20
-		tch =3D cyttsp_get_tch(&xy_data, i);
+	for (i =3D 0; i < num_tch; i++) {
+		tch =3D cyttsp_get_tch(xy_data, ids[i]);
=20
-		x =3D be16_to_cpu(tch->x);
-		y =3D be16_to_cpu(tch->y);
-		z =3D tch->z;
+		input_mt_slot(input, ids[i]);
+		input_mt_report_slot_state(input, MT_TOOL_FINGER, true);
+		input_report_abs(input, ABS_MT_POSITION_X, be16_to_cpu(tch->x));
+		input_report_abs(input, ABS_MT_POSITION_Y, be16_to_cpu(tch->y));
+		input_report_abs(input, ABS_MT_TOUCH_MAJOR, tch->z);
=20
-		cyttsp_report_slot(ts->input, ids[i], x, y, z);
+		__set_bit(ids[i], used);
 	}
=20
-	for (i =3D 0; i < CY_MAX_ID; i++)
-		if (!(used & (1 << i)))
-			cyttsp_report_slot_empty(ts->input, i);
+	for (i =3D 0; i < CY_MAX_ID; i++) {
+		if (test_bit(i, used))
+			continue;
=20
-	input_sync(ts->input);
-
-	return 0;
-}
+		input_mt_slot(input, i);
+		input_mt_report_slot_state(input, MT_TOOL_FINGER, false);
+	}
=20
-static void cyttsp_pr_state(struct cyttsp *ts)
-{
-	static char *cyttsp_powerstate_string[] =3D {
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
+	input_sync(input);
 }
=20
 static irqreturn_t cyttsp_irq(int irq, void *handle)
 {
 	struct cyttsp *ts =3D handle;
-	int retval;
+	int error;
=20
-	if (ts->power_state =3D=3D CY_BL_STATE)
+	if (unlikely(ts->state =3D=3D CY_BL_STATE)) {
 		complete(&ts->bl_ready);
-	else {
-		/* process the touches */
-		retval =3D cyttsp_handle_tchdata(ts);
-
-		if (retval < 0) {
-			/*
-			 * TTSP device has reset back to bootloader mode.
-			 * Restore to operational mode.
-			 */
-			retval =3D cyttsp_exit_bl_mode(ts);
-			if (retval)
-				ts->power_state =3D CY_IDLE_STATE;
-			else
-				ts->power_state =3D CY_ACTIVE_STATE;
-			cyttsp_pr_state(ts);
+		goto out;
+	}
+
+	/* Get touch data from CYTTSP device */
+	error =3D ttsp_read_block_data(ts, CY_REG_BASE,
+				 sizeof(struct cyttsp_xydata), &ts->xy_data);
+	if (error)
+		goto out;
+
+	/* provide flow control handshake */
+	if (ts->pdata->use_hndshk) {
+		error =3D ttsp_send_command(ts,
+				ts->xy_data.hst_mode ^ CY_HNDSHK_BIT);
+		if (error)
+			goto out;
+	}
+
+	if (unlikely(ts->state =3D=3D CY_IDLE_STATE))
+		goto out;
+
+	if (GET_BOOTLOADERMODE(ts->xy_data.tt_mode)) {
+		/*
+		 * TTSP device has reset back to bootloader mode.
+		 * Restore to operational mode.
+		 */
+		error =3D cyttsp_exit_bl_mode(ts);
+		if (error) {
+			dev_err(ts->dev,
+				"Could not return to operational mode, err: %d\n",
+				error);
+			ts->state =3D CY_IDLE_STATE;
 		}
+	} else {
+		cyttsp_report_tchdata(ts);
 	}
=20
+out:
 	return IRQ_HANDLED;
 }
=20
 static int cyttsp_power_on(struct cyttsp *ts)
 {
-	int retval =3D 0;
-
-	ts->power_state =3D CY_BL_STATE;
-	enable_irq(ts->irq);
+	int error;
=20
-	retval =3D cyttsp_soft_reset(ts);
-	if (retval < 0)
-		return retval;
+	error =3D cyttsp_soft_reset(ts);
+	if (error)
+		return error;
=20
-	retval =3D cyttsp_load_bl_regs(ts);
-	if (retval < 0)
-		return retval;
+	error =3D cyttsp_load_bl_regs(ts);
+	if (error)
+		return error;
=20
 	if (GET_BOOTLOADERMODE(ts->bl_data.bl_status) &&
-	    IS_VALID_APP(ts->bl_data.bl_status))
-		retval =3D cyttsp_exit_bl_mode(ts);
-
-	if (retval < 0)
-		return retval;
-	else
-		ts->power_state =3D CY_IDLE_STATE;
+	    IS_VALID_APP(ts->bl_data.bl_status)) {
+		error =3D cyttsp_exit_bl_mode(ts);
+		if (error)
+			return error;
+	}
=20
-	if (GET_HSTMODE(ts->bl_data.bl_file) =3D=3D CY_OPERATE_MODE &&
-	    !IS_OPERATIONAL_ERR(ts->bl_data.bl_status)) {
-		retval =3D cyttsp_set_sysinfo_mode(ts);
-		if (retval < 0)
-			return retval;
+	if (GET_HSTMODE(ts->bl_data.bl_file) !=3D CY_OPERATE_MODE ||
+	    IS_OPERATIONAL_ERR(ts->bl_data.bl_status)) {
+		return -ENODEV;
+	}
=20
-		retval =3D cyttsp_set_sysinfo_regs(ts);
-		if (retval < 0)
-			return retval;
+	error =3D cyttsp_set_sysinfo_mode(ts);
+	if (error)
+		return error;
=20
-		retval =3D cyttsp_set_operational_mode(ts);
-		if (retval < 0)
-			return retval;
+	error =3D cyttsp_set_sysinfo_regs(ts);
+	if (error)
+		return error;
=20
-		/* init active distance */
-		retval =3D cyttsp_act_dist_setup(ts);
-		if (retval < 0)
-			return retval;
+	error =3D cyttsp_set_operational_mode(ts);
+	if (error)
+		return error;
=20
-		ts->power_state =3D CY_ACTIVE_STATE;
+	/* init active distance */
+	error =3D cyttsp_act_dist_setup(ts);
+	if (error)
+		return error;
=20
-		return 0;
-	}
+	ts->state =3D CY_ACTIVE_STATE;
=20
-	return -ENODEV;
+	return 0;
 }
=20
-static int __cyttsp_enable(struct cyttsp *ts)
+static int cyttsp_enable(struct cyttsp *ts)
 {
-	struct cyttsp_xydata xydata;
-	int retval =3D 0;
+	int error;
=20
-	if (ts->power_state !=3D CY_ACTIVE_STATE) {
+	// FIXME: Why do we need wakeup? The system is already woken up
+	// so I assume this is device wakeup. It should be generic, just
+	// like suspend is generic.
+	// Is there CY_FULL_POWER_MODE that is opposite to CY_LOW_POWER_MODE?
+	if (ts->pdata->wakeup) {
+		error =3D ts->pdata->wakeup();
+		if (error)
+			return error;
+	}
=20
-		if (ts->pdata->wakeup)
-			retval =3D ts->pdata->wakeup();
+	error =3D ttsp_read_block_data(ts, CY_REG_BASE,
+				     sizeof(ts->xy_data), &ts->xy_data);
+	if (error)
+		return error;
=20
-		if (retval =3D=3D 0) {
-			retval =3D ttsp_read_block_data(ts, CY_REG_BASE,
-						      sizeof(xydata),
-						      &xydata);
-			if (retval =3D=3D 0 &&
-			    !GET_HSTMODE(xydata.hst_mode)) {
-				ts->power_state =3D CY_ACTIVE_STATE;
-				enable_irq(ts->irq);
-			}
-		}
-	}
+	if (GET_HSTMODE(ts->xy_data.hst_mode))
+		return -EIO;
=20
-	return retval;
+	enable_irq(ts->irq);
+
+	return 0;
 }
=20
-static int __cyttsp_disable(struct cyttsp *ts)
+static int cyttsp_disable(struct cyttsp *ts)
 {
-	u8 cmd =3D CY_LOW_POWER_MODE;
-	int retval =3D 0;
+	int error;
=20
-	if (ts->power_state =3D=3D CY_ACTIVE_STATE) {
-		retval =3D ttsp_write_block_data(ts, CY_REG_BASE,
-					       sizeof(cmd), &cmd);
-		if (retval =3D=3D 0) {
-			ts->power_state =3D CY_SLEEP_STATE;
-			disable_irq(ts->irq);
-		}
-	}
+	error =3D ttsp_send_command(ts, CY_LOW_POWER_MODE);
+	if (error)
+		return error;
=20
-	return retval;
+	disable_irq(ts->irq);
+
+	return 0;
 }
=20
 #ifdef CONFIG_PM_SLEEP
-static int cyttsp_resume(struct device *dev)
+static int cyttsp_suspend(struct device *dev)
 {
 	struct cyttsp *ts =3D dev_get_drvdata(dev);
 	int retval =3D 0;
=20
 	mutex_lock(&ts->input->mutex);
=20
-	if (ts->suspended)
-		retval =3D __cyttsp_enable(ts);
-
-	ts->suspended =3D false;
+	if (ts->input->users) {
+		retval =3D cyttsp_disable(ts);
+		if (retval =3D=3D 0)
+			ts->suspended =3D true;
+	}
=20
 	mutex_unlock(&ts->input->mutex);
=20
 	return retval;
 }
=20
-static int cyttsp_suspend(struct device *dev)
+static int cyttsp_resume(struct device *dev)
 {
 	struct cyttsp *ts =3D dev_get_drvdata(dev);
-	int retval =3D 0;
=20
 	mutex_lock(&ts->input->mutex);
=20
-	if (!ts->suspended)
-		retval =3D __cyttsp_disable(ts);
+	if (ts->input->users)
+		cyttsp_enable(ts);
=20
-	ts->suspended =3D true;
+	ts->suspended =3D false;
=20
 	mutex_unlock(&ts->input->mutex);
=20
-	return retval;
+	return 0;
 }
+
 #endif
=20
 SIMPLE_DEV_PM_OPS(cyttsp_pm_ops, cyttsp_suspend, cyttsp_resume);
@@ -550,18 +505,8 @@ static int cyttsp_open(struct input_dev *dev)
 	struct cyttsp *ts =3D input_get_drvdata(dev);
 	int retval =3D 0;
=20
-	if (!ts->on) {
-		retval =3D cyttsp_power_on(ts);
-
-		if (retval) {
-			cyttsp_pr_state(ts);
-			return retval;
-		} else
-			ts->on =3D true;
-	}
-
 	if (!ts->suspended)
-		retval =3D __cyttsp_enable(ts);
+		retval =3D cyttsp_enable(ts);
=20
 	return retval;
 }
@@ -571,7 +516,7 @@ static void cyttsp_close(struct input_dev *dev)
 	struct cyttsp *ts =3D input_get_drvdata(dev);
=20
 	if (!ts->suspended)
-		__cyttsp_disable(ts);
+		cyttsp_disable(ts);
 }
=20
 struct cyttsp *cyttsp_probe(const struct cyttsp_bus_ops *bus_ops,
@@ -599,8 +544,6 @@ struct cyttsp *cyttsp_probe(const struct cyttsp_bus=
_ops *bus_ops,
 	ts->pdata =3D dev->platform_data;
 	ts->bus_ops =3D bus_ops;
 	ts->irq =3D irq;
-	ts->suspended =3D false;
-	ts->on =3D false;
=20
 	init_completion(&ts->bl_ready);
 	snprintf(ts->phys, sizeof(ts->phys), "%s/input0", dev_name(dev));
@@ -642,6 +585,11 @@ struct cyttsp *cyttsp_probe(const struct cyttsp_bu=
s_ops *bus_ops,
 			ts->irq, error);
 		goto err_platform_exit;
 	}
+
+	error =3D cyttsp_power_on(ts);
+	if (error)
+		goto err_free_irq;
+
 	disable_irq(ts->irq);
=20
 	error =3D input_register_device(input_dev);
diff --git a/drivers/input/touchscreen/cyttsp_core.h b/drivers/input/to=
uchscreen/cyttsp_core.h
index 866f5e2..560f959 100644
--- a/drivers/input/touchscreen/cyttsp_core.h
+++ b/drivers/input/touchscreen/cyttsp_core.h
@@ -115,6 +115,12 @@ struct cyttsp_bus_ops {
 	int (*read)(struct device *dev, u8 addr, u8 length, void *values);
 };
=20
+enum cyttsp_state {
+	CY_IDLE_STATE,
+	CY_ACTIVE_STATE,
+	CY_BL_STATE,
+};
+
 struct cyttsp {
 	struct device *dev;
 	int irq;
@@ -124,10 +130,10 @@ struct cyttsp {
 	const struct cyttsp_bus_ops *bus_ops;
 	struct cyttsp_bootloader_data bl_data;
 	struct cyttsp_sysinfo_data sysinfo_data;
+	struct cyttsp_xydata xy_data;
 	struct completion bl_ready;
-	enum cyttsp_powerstate power_state;
+	enum cyttsp_state state;
 	bool suspended;
-	bool on;
=20
 	u8 xfer_buf[] ____cacheline_aligned;
 };
diff --git a/drivers/input/touchscreen/cyttsp_i2c.c b/drivers/input/tou=
chscreen/cyttsp_i2c.c
index cdbf61d..6394c8e 100644
--- a/drivers/input/touchscreen/cyttsp_i2c.c
+++ b/drivers/input/touchscreen/cyttsp_i2c.c
@@ -32,24 +32,33 @@
 #include <linux/i2c.h>
 #include <linux/input.h>
=20
-#define CY_I2C_DATA_SIZE  128
+#define CY_I2C_DATA_SIZE	128
=20
 static int cyttsp_i2c_read_block_data(struct device *dev,
 				      u8 addr, u8 length, void *values)
 {
 	struct i2c_client *client =3D to_i2c_client(dev);
+	struct i2c_msg msgs[] =3D {
+		{
+			.addr =3D client->addr,
+			.flags =3D 0,
+			.len =3D 1,
+			.buf =3D &addr,
+		},
+		{
+			.addr =3D client->addr,
+			.flags =3D I2C_M_RD,
+			.len =3D length,
+			.buf =3D values,
+		},
+	};
 	int retval;
=20
-	retval =3D i2c_master_send(client, &addr, 1);
+	retval =3D i2c_transfer(client->adapter, msgs, ARRAY_SIZE(msgs));
 	if (retval < 0)
 		return retval;
=20
-	retval =3D i2c_master_recv(client, values, length);
-
-	if (retval < 0)
-		return retval;
-
-	return (retval !=3D length) ? -EIO : 0;
+	return retval !=3D ARRAY_SIZE(msgs) ? -EIO : 0;
 }
=20
 static int cyttsp_i2c_write_block_data(struct device *dev,
@@ -61,14 +70,15 @@ static int cyttsp_i2c_write_block_data(struct devic=
e *dev,
=20
 	ts->xfer_buf[0] =3D addr;
 	memcpy(&ts->xfer_buf[1], values, length);
+
 	retval =3D i2c_master_send(client, ts->xfer_buf, length + 1);
=20
-	return (retval < 0) ? retval : 0;
+	return retval < 0 ? retval : 0;
 }
=20
 static const struct cyttsp_bus_ops cyttsp_i2c_bus_ops =3D {
-	.bustype        =3D BUS_I2C,
-	.write          =3D cyttsp_i2c_write_block_data,
+	.bustype	=3D BUS_I2C,
+	.write		=3D cyttsp_i2c_write_block_data,
 	.read           =3D cyttsp_i2c_read_block_data,
 };
=20
@@ -110,13 +120,13 @@ MODULE_DEVICE_TABLE(i2c, cyttsp_i2c_id);
=20
 static struct i2c_driver cyttsp_i2c_driver =3D {
 	.driver =3D {
-		.name   =3D CY_I2C_NAME,
-		.owner  =3D THIS_MODULE,
-		.pm     =3D &cyttsp_pm_ops,
+		.name	=3D CY_I2C_NAME,
+		.owner	=3D THIS_MODULE,
+		.pm	=3D &cyttsp_pm_ops,
 	},
-	.probe          =3D cyttsp_i2c_probe,
-	.remove         =3D __devexit_p(cyttsp_i2c_remove),
-	.id_table       =3D cyttsp_i2c_id,
+	.probe		=3D cyttsp_i2c_probe,
+	.remove		=3D __devexit_p(cyttsp_i2c_remove),
+	.id_table	=3D cyttsp_i2c_id,
 };
=20
 static int __init cyttsp_i2c_init(void)
diff --git a/drivers/input/touchscreen/cyttsp_spi.c b/drivers/input/tou=
chscreen/cyttsp_spi.c
index 3238c7d..d404cd2 100644
--- a/drivers/input/touchscreen/cyttsp_spi.c
+++ b/drivers/input/touchscreen/cyttsp_spi.c
@@ -33,29 +33,30 @@
 #include <linux/input.h>
 #include <linux/spi/spi.h>
=20
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
-static int cyttsp_spi_xfer(u8 op, struct spi_device *spi,
+#define CY_SPI_WR_OP		0x00 /* r/~w */
+#define CY_SPI_RD_OP		0x01
+#define CY_SPI_CMD_BYTES	4
+#define CY_SPI_SYNC_BYTE	2
+#define CY_SPI_SYNC_ACK1	0x62 /* from protocol v.2 */
+#define CY_SPI_SYNC_ACK2	0x9D /* from protocol v.2 */
+#define CY_SPI_DATA_SIZE	128
+#define CY_SPI_DATA_BUF_SIZE	(CY_SPI_CMD_BYTES + CY_SPI_DATA_SIZE)
+#define CY_SPI_BITS_PER_WORD	8
+
+static int cyttsp_spi_xfer(u8 op, struct device *dev,
 			   u8 reg, u8 *buf, int length)
 {
+	struct spi_device *spi =3D to_spi_device(dev);
 	struct cyttsp *ts =3D spi_get_drvdata(spi);
 	struct spi_message msg;
 	struct spi_transfer xfer[2];
 	u8 *wr_buf =3D &ts->xfer_buf[0];
 	u8 *rd_buf =3D &ts->xfer_buf[CY_SPI_DATA_BUF_SIZE];
 	int retval;
+	int i;
=20
 	if (length > CY_SPI_DATA_SIZE) {
-		dev_dbg(&spi->dev, "%s: length %d is too big.\n",
-			__func__, length);
+		dev_err(dev, "%s: length %d is too big.\n", __func__, length);
 		return -EINVAL;
 	}
=20
@@ -94,15 +95,13 @@ static int cyttsp_spi_xfer(u8 op, struct spi_device=
 *spi,
 		break;
=20
 	default:
-		dev_dbg(&spi->dev,
-			"%s: bad operation code=3D%d\n", __func__, op);
+		dev_err(dev, "%s: bad operation code=3D%d\n", __func__, op);
 		return -EINVAL;
 	}
=20
 	retval =3D spi_sync(spi, &msg);
 	if (retval < 0) {
-		dev_dbg(&spi->dev,
-			"%s: spi_sync() error %d, len=3D%d, op=3D%d\n",
+		dev_dbg(dev, "%s: spi_sync() error %d, len=3D%d, op=3D%d\n",
 			__func__, retval, xfer[1].len, op);
=20
 		/*
@@ -114,18 +113,17 @@ static int cyttsp_spi_xfer(u8 op, struct spi_devi=
ce *spi,
=20
 	if (rd_buf[CY_SPI_SYNC_BYTE] !=3D CY_SPI_SYNC_ACK1 ||
 	    rd_buf[CY_SPI_SYNC_BYTE + 1] !=3D CY_SPI_SYNC_ACK2) {
-		int i;
+
+		dev_dbg(dev, "%s: operation %d failed\n", __func__, op);
+
 		for (i =3D 0; i < CY_SPI_CMD_BYTES; i++)
-			dev_dbg(&spi->dev,
-				"%s: test rd_buf[%d]:0x%02x\n",
+			dev_dbg(dev, "%s: test rd_buf[%d]:0x%02x\n",
 				__func__, i, rd_buf[i]);
 		for (i =3D 0; i < length; i++)
-			dev_dbg(&spi->dev,
-				"%s: test buf[%d]:0x%02x\n",
+			dev_dbg(dev, "%s: test buf[%d]:0x%02x\n",
 				__func__, i, buf[i]);
=20
-		/* signal ACK error so silent retry */
-		return 1;
+		return -EIO;
 	}
=20
 	return 0;
@@ -134,51 +132,19 @@ static int cyttsp_spi_xfer(u8 op, struct spi_devi=
ce *spi,
 static int cyttsp_spi_read_block_data(struct device *dev,
 				      u8 addr, u8 length, void *data)
 {
-	struct spi_device *spi =3D to_spi_device(dev);
-	int retval;
-
-	retval =3D cyttsp_spi_xfer(CY_SPI_RD_OP, spi, addr, data, length);
-	if (retval < 0)
-		dev_err(dev, "cyttsp_spi_read_block_data failed, err: %d\n",
-			retval);
-
-	/*
-	 * Do not print the above error if the data sync bytes were not found=
=2E
-	 * This is a normal condition for the bootloader loader startup and n=
eed
-	 * to retry until data sync bytes are found.
-	 */
-	if (retval > 0)
-		retval =3D -EIO;  /* now signal fail; so retry can be done */
-
-	return retval;
+	return cyttsp_spi_xfer(CY_SPI_RD_OP, dev, addr, data, length);
 }
=20
 static int cyttsp_spi_write_block_data(struct device *dev,
 				       u8 addr, u8 length, const void *data)
 {
-	struct spi_device *spi =3D to_spi_device(dev);
-	int retval;
-
-	retval =3D cyttsp_spi_xfer(CY_SPI_WR_OP, spi, addr, (void *)data, len=
gth);
-	if (retval < 0)
-		dev_err(dev, "cyttsp_spi_write_block_data failed, err: %d\n",
-			retval);
-
-	/*
-	 * Do not print the above error if the data sync bytes were not found=
=2E
-	 * This is a normal condition for the bootloader loader startup and n=
eed
-	 * to retry until data sync bytes are found.
-	 */
-	if (retval > 0)
-		retval =3D -EIO;  /* now signal fail; so retry can be done */
-
-	return retval;
+	return cyttsp_spi_xfer(CY_SPI_WR_OP, dev, addr, (void *)data, length)=
;
 }
=20
 static const struct cyttsp_bus_ops cyttsp_spi_bus_ops =3D {
-	.bustype        =3D BUS_SPI,
-	.write          =3D cyttsp_spi_write_block_data,
-	.read           =3D cyttsp_spi_read_block_data,
+	.bustype	=3D BUS_SPI,
+	.write		=3D cyttsp_spi_write_block_data,
+	.read		=3D cyttsp_spi_read_block_data,
 };
=20
 static int __devinit cyttsp_spi_probe(struct spi_device *spi)
@@ -208,7 +174,7 @@ static int __devinit cyttsp_spi_probe(struct spi_de=
vice *spi)
=20
 static int __devexit cyttsp_spi_remove(struct spi_device *spi)
 {
-	struct cyttsp *ts =3D dev_get_drvdata(&spi->dev);
+	struct cyttsp *ts =3D spi_get_drvdata(spi);
=20
 	cyttsp_remove(ts);
=20
@@ -217,9 +183,9 @@ static int __devexit cyttsp_spi_remove(struct spi_d=
evice *spi)
=20
 static struct spi_driver cyttsp_spi_driver =3D {
 	.driver =3D {
-		.name   =3D CY_SPI_NAME,
-		.owner  =3D THIS_MODULE,
-		.pm     =3D &cyttsp_pm_ops,
+		.name	=3D CY_SPI_NAME,
+		.owner	=3D THIS_MODULE,
+		.pm	=3D &cyttsp_pm_ops,
 	},
 	.probe  =3D cyttsp_spi_probe,
 	.remove =3D __devexit_p(cyttsp_spi_remove),
@@ -242,4 +208,3 @@ MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Cypress TrueTouch(R) Standard Product (TTSP) SPI d=
river");
 MODULE_AUTHOR("Cypress");
 MODULE_ALIAS("spi:cyttsp");
-
diff --git a/include/linux/input/cyttsp.h b/include/linux/input/cyttsp.=
h
index f792603..3cdd574 100644
--- a/include/linux/input/cyttsp.h
+++ b/include/linux/input/cyttsp.h
@@ -40,15 +40,6 @@
 /* Active distance in pixels for a gesture to be reported */
 #define CY_ACT_DIST_DFLT 0xF8 /* pixels */
=20
-enum cyttsp_powerstate {
-	CY_IDLE_STATE,
-	CY_ACTIVE_STATE,
-	CY_LOW_PWR_STATE,
-	CY_SLEEP_STATE,
-	CY_BL_STATE,
-	CY_INVALID_STATE	/* always last in the list */
-};
-
 struct cyttsp_platform_data {
 	u32 maxx;
 	u32 maxy;
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
