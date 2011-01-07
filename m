From: Ping Cheng <pinglinux@gmail.com>
Subject: =?UTF-8?q?=5BPATCH=20v3=5D=20Input=3A=20wacom=5Fw8001=20-=20add=20single-touch=20support?=
Date: Fri,  7 Jan 2011 10:54:13 -0800
Message-ID: <1294426453-2531-1-git-send-email-pinglinux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:52302 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754254Ab1AGSxc (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 7 Jan 2011 13:53:32 -0500
Received: by gwj20 with SMTP id 20so7861825gwj.19
        for <linux-input@vger.kernel.org>; Fri, 07 Jan 2011 10:53:31 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, Ping Cheng <pinglinux@gmail.com>, Ping Cheng <pingc@wacom.com>

Emulate single-touch compatible events for the 2-finger panels
so that they can be used with single-touch legacy clients.

Assign device ids as Wacom USB vendor ID and product ID.
Name the device to reflect its specific features.

Scale touch cordinates to pen maximum if supported.

Signed-off-by: Ping Cheng <pingc@wacom.com>

---
Dmitry,

I can not find the sourceforge inputattach project you mentioned.
The options to attach Wacom serial devices can be add to the
static struct input_types input_types[] in inputattach.c as the
following:

{ "--wacom",		"-wacom",	"Wacom W8001-19200",
	B19200, CS8,
	SERIO_W8001,		0x00,	0x00,	0,	NULL },
{ "--wacom-384",		"-wacom-384",	"Wacom W8001-38400",
	B38400, CS8,
	SERIO_W8001,		0x00,	0x00,	0,	NULL },
---
 drivers/input/touchscreen/wacom_w8001.c |  165 +++++++++++++++++++++++=
+++-----
 1 files changed, 139 insertions(+), 26 deletions(-)

diff --git a/drivers/input/touchscreen/wacom_w8001.c b/drivers/input/to=
uchscreen/wacom_w8001.c
index 8ed53ad..144c4f3 100644
--- a/drivers/input/touchscreen/wacom_w8001.c
+++ b/drivers/input/touchscreen/wacom_w8001.c
@@ -3,6 +3,7 @@
  *
  * Copyright (c) 2008 Jaya Kumar
  * Copyright (c) 2010 Red Hat, Inc.
+ * Copyright (c) 2010 - 2011 Ping Cheng, Wacom. <pingc@wacom.com>
  *
  * This file is subject to the terms and conditions of the GNU General=
 Public
  * License. See the file COPYING in the main directory of this archive=
 for
@@ -64,11 +65,11 @@ struct w8001_coord {
=20
 /* touch query reply packet */
 struct w8001_touch_query {
+	u16 x;
+	u16 y;
 	u8 panel_res;
 	u8 capacity_res;
 	u8 sensor_id;
-	u16 x;
-	u16 y;
 };
=20
 /*
@@ -87,9 +88,14 @@ struct w8001 {
 	char phys[32];
 	int type;
 	unsigned int pktlen;
+	u16 max_touch_x;
+	u16 max_touch_y;
+	u16 max_pen_x;
+	u16 max_pen_y;
+	char name[64];
 };
=20
-static void parse_data(u8 *data, struct w8001_coord *coord)
+static void parse_pen_data(u8 *data, struct w8001_coord *coord)
 {
 	memset(coord, 0, sizeof(*coord));
=20
@@ -113,11 +119,19 @@ static void parse_data(u8 *data, struct w8001_coo=
rd *coord)
 	coord->tilt_y =3D data[8] & 0x7F;
 }
=20
-static void parse_touch(struct w8001 *w8001)
+static void parse_single_touch(u8 *data, struct w8001_coord *coord)
+{
+	coord->x =3D (data[1] << 7) | data[2];
+	coord->y =3D (data[3] << 7) | data[4];
+	coord->tsw =3D data[0] & 0x01;
+}
+
+static void parse_multi_touch(struct w8001 *w8001)
 {
 	struct input_dev *dev =3D w8001->dev;
 	unsigned char *data =3D w8001->data;
 	int i;
+	int count =3D 0;
=20
 	for (i =3D 0; i < 2; i++) {
 		bool touch =3D data[0] & (1 << i);
@@ -125,15 +139,33 @@ static void parse_touch(struct w8001 *w8001)
 		input_mt_slot(dev, i);
 		input_mt_report_slot_state(dev, MT_TOOL_FINGER, touch);
 		if (touch) {
-			int x =3D (data[6 * i + 1] << 7) | (data[6 * i + 2]);
-			int y =3D (data[6 * i + 3] << 7) | (data[6 * i + 4]);
+			int x =3D (data[6 * i + 1] << 7) | data[6 * i + 2];
+			int y =3D (data[6 * i + 3] << 7) | data[6 * i + 4];
 			/* data[5,6] and [11,12] is finger capacity */
=20
+			/* scale to pen maximum */
+			if (w8001->max_pen_x && w8001->max_touch_x)
+				x =3D x * w8001->max_pen_x / w8001->max_touch_x;
+
+			if (w8001->max_pen_y && w8001->max_touch_y)
+				y =3D y * w8001->max_pen_y / w8001->max_touch_y;
+
 			input_report_abs(dev, ABS_MT_POSITION_X, x);
 			input_report_abs(dev, ABS_MT_POSITION_Y, y);
+			count++;
 		}
 	}
=20
+	/* emulate single touch events when stylus is out of proximity.
+	 * This is to make single touch backward support consistent
+	 * across all Wacom single touch devices.
+	 */
+	if (w8001->type !=3D BTN_TOOL_PEN &&
+			    w8001->type !=3D BTN_TOOL_RUBBER) {
+		w8001->type =3D count =3D=3D 1 ? BTN_TOOL_FINGER : KEY_RESERVED;
+		input_mt_report_pointer_emulation(dev, true);
+	}
+
 	input_sync(dev);
 }
=20
@@ -152,6 +184,15 @@ static void parse_touchquery(u8 *data, struct w800=
1_touch_query *query)
 	query->y =3D data[5] << 9;
 	query->y |=3D data[6] << 2;
 	query->y |=3D (data[2] >> 3) & 0x3;
+
+	/* Early days' single-finger touch models need the following defaults=
 */
+	if (!query->x && !query->y) {
+		query->x =3D 1024;
+		query->y =3D 1024;
+		if (query->panel_res)
+			query->x =3D query->y =3D (1 << query->panel_res);
+		query->panel_res =3D 10;
+	}
 }
=20
 static void report_pen_events(struct w8001 *w8001, struct w8001_coord =
*coord)
@@ -161,16 +202,15 @@ static void report_pen_events(struct w8001 *w8001=
, struct w8001_coord *coord)
 	/*
 	 * We have 1 bit for proximity (rdy) and 3 bits for tip, side,
 	 * side2/eraser. If rdy && f2 are set, this can be either pen + side2=
,
-	 * or eraser. assume
+	 * or eraser. Assume:
 	 * - if dev is already in proximity and f2 is toggled =E2=86=92 pen +=
 side2
 	 * - if dev comes into proximity with f2 set =E2=86=92 eraser
 	 * If f2 disappears after assuming eraser, fake proximity out for
 	 * eraser and in for pen.
 	 */
=20
-	if (!w8001->type) {
-		w8001->type =3D coord->f2 ? BTN_TOOL_RUBBER : BTN_TOOL_PEN;
-	} else if (w8001->type =3D=3D BTN_TOOL_RUBBER) {
+	switch (w8001->type) {
+	case BTN_TOOL_RUBBER:
 		if (!coord->f2) {
 			input_report_abs(dev, ABS_PRESSURE, 0);
 			input_report_key(dev, BTN_TOUCH, 0);
@@ -180,8 +220,21 @@ static void report_pen_events(struct w8001 *w8001,=
 struct w8001_coord *coord)
 			input_sync(dev);
 			w8001->type =3D BTN_TOOL_PEN;
 		}
-	} else {
+		break;
+
+	case BTN_TOOL_FINGER:
+		input_report_key(dev, BTN_TOUCH, 0);
+		input_report_key(dev, BTN_TOOL_FINGER, 0);
+		input_sync(dev);
+		/* fall through */
+
+	case KEY_RESERVED:
+		w8001->type =3D coord->f2 ? BTN_TOOL_RUBBER : BTN_TOOL_PEN;
+		break;
+
+	default:
 		input_report_key(dev, BTN_STYLUS2, coord->f2);
+		break;
 	}
=20
 	input_report_abs(dev, ABS_X, coord->x);
@@ -193,7 +246,30 @@ static void report_pen_events(struct w8001 *w8001,=
 struct w8001_coord *coord)
 	input_sync(dev);
=20
 	if (!coord->rdy)
-		w8001->type =3D 0;
+		w8001->type =3D KEY_RESERVED;
+}
+
+static void report_single_touch(struct w8001 *w8001, struct w8001_coor=
d *coord)
+{
+	struct input_dev *dev =3D w8001->dev;
+	unsigned int x =3D coord->x;
+	unsigned int y =3D coord->y;
+
+	/* scale to pen maximum */
+	if (w8001->max_pen_x && w8001->max_touch_x)
+		x =3D x * w8001->max_pen_x / w8001->max_touch_x;
+
+	if (w8001->max_pen_y && w8001->max_touch_y)
+		y =3D y * w8001->max_pen_y / w8001->max_touch_y;
+
+	input_report_abs(dev, ABS_X, x);
+	input_report_abs(dev, ABS_Y, y);
+	input_report_key(dev, BTN_TOUCH, coord->tsw);
+	input_report_key(dev, BTN_TOOL_FINGER, coord->tsw);
+
+	input_sync(dev);
+
+	w8001->type =3D coord->tsw ? BTN_TOOL_FINGER : KEY_RESERVED;
 }
=20
 static irqreturn_t w8001_interrupt(struct serio *serio,
@@ -214,9 +290,18 @@ static irqreturn_t w8001_interrupt(struct serio *s=
erio,
=20
 	case W8001_PKTLEN_TOUCH93 - 1:
 	case W8001_PKTLEN_TOUCH9A - 1:
-		/* ignore one-finger touch packet. */
-		if (w8001->pktlen =3D=3D w8001->idx)
+		tmp =3D w8001->data[0] & W8001_TOUCH_BYTE;
+		if (tmp !=3D W8001_TOUCH_BYTE)
+			break;
+
+		if (w8001->pktlen =3D=3D w8001->idx) {
 			w8001->idx =3D 0;
+			if (w8001->type !=3D BTN_TOOL_PEN &&
+			    w8001->type !=3D BTN_TOOL_RUBBER) {
+				parse_single_touch(w8001->data, &coord);
+				report_single_touch(w8001, &coord);
+			}
+		}
 		break;
=20
 	/* Pen coordinates packet */
@@ -225,18 +310,18 @@ static irqreturn_t w8001_interrupt(struct serio *=
serio,
 		if (unlikely(tmp =3D=3D W8001_TAB_BYTE))
 			break;
=20
-		tmp =3D (w8001->data[0] & W8001_TOUCH_BYTE);
+		tmp =3D w8001->data[0] & W8001_TOUCH_BYTE;
 		if (tmp =3D=3D W8001_TOUCH_BYTE)
 			break;
=20
 		w8001->idx =3D 0;
-		parse_data(w8001->data, &coord);
+		parse_pen_data(w8001->data, &coord);
 		report_pen_events(w8001, &coord);
 		break;
=20
 	/* control packet */
 	case W8001_PKTLEN_TPCCTL - 1:
-		tmp =3D (w8001->data[0] & W8001_TOUCH_MASK);
+		tmp =3D w8001->data[0] & W8001_TOUCH_MASK;
 		if (tmp =3D=3D W8001_TOUCH_BYTE)
 			break;
=20
@@ -249,7 +334,7 @@ static irqreturn_t w8001_interrupt(struct serio *se=
rio,
 	/* 2 finger touch packet */
 	case W8001_PKTLEN_TOUCH2FG - 1:
 		w8001->idx =3D 0;
-		parse_touch(w8001);
+		parse_multi_touch(w8001);
 		break;
 	}
=20
@@ -279,6 +364,7 @@ static int w8001_setup(struct w8001 *w8001)
 {
 	struct input_dev *dev =3D w8001->dev;
 	struct w8001_coord coord;
+	struct w8001_touch_query touch;
 	int error;
=20
 	error =3D w8001_command(w8001, W8001_CMD_STOP, false);
@@ -287,14 +373,20 @@ static int w8001_setup(struct w8001 *w8001)
=20
 	msleep(250);	/* wait 250ms before querying the device */
=20
+	strlcat(w8001->name, "Wacom Serial", sizeof(w8001->name));
+
 	/* penabled? */
 	error =3D w8001_command(w8001, W8001_CMD_QUERY, true);
 	if (!error) {
+		__set_bit(BTN_TOUCH, dev->keybit);
 		__set_bit(BTN_TOOL_PEN, dev->keybit);
 		__set_bit(BTN_TOOL_RUBBER, dev->keybit);
 		__set_bit(BTN_STYLUS, dev->keybit);
 		__set_bit(BTN_STYLUS2, dev->keybit);
-		parse_data(w8001->response, &coord);
+
+		parse_pen_data(w8001->response, &coord);
+		w8001->max_pen_x =3D coord.x;
+		w8001->max_pen_y =3D coord.y;
=20
 		input_set_abs_params(dev, ABS_X, 0, coord.x, 0, 0);
 		input_set_abs_params(dev, ABS_Y, 0, coord.y, 0, 0);
@@ -303,6 +395,8 @@ static int w8001_setup(struct w8001 *w8001)
 			input_set_abs_params(dev, ABS_TILT_X, 0, coord.tilt_x, 0, 0);
 			input_set_abs_params(dev, ABS_TILT_Y, 0, coord.tilt_y, 0, 0);
 		}
+		w8001->id =3D 0x90;
+		strlcat(w8001->name, " Penabled", sizeof(w8001->name));
 	}
=20
 	/* Touch enabled? */
@@ -313,24 +407,38 @@ static int w8001_setup(struct w8001 *w8001)
 	 * second byte is empty, which indicates touch is not supported.
 	 */
 	if (!error && w8001->response[1]) {
-		struct w8001_touch_query touch;
+		__set_bit(BTN_TOUCH, dev->keybit);
+		__set_bit(BTN_TOOL_FINGER, dev->keybit);
=20
 		parse_touchquery(w8001->response, &touch);
+		w8001->max_touch_x =3D touch.x;
+		w8001->max_touch_y =3D touch.y;
+
+		/* scale to pen maximum */
+		if (w8001->max_pen_x && w8001->max_pen_y) {
+			touch.x =3D w8001->max_pen_x;
+			touch.y =3D w8001->max_pen_y;
+		}
=20
 		input_set_abs_params(dev, ABS_X, 0, touch.x, 0, 0);
 		input_set_abs_params(dev, ABS_Y, 0, touch.y, 0, 0);
-		__set_bit(BTN_TOOL_FINGER, dev->keybit);
=20
 		switch (touch.sensor_id) {
 		case 0:
 		case 2:
 			w8001->pktlen =3D W8001_PKTLEN_TOUCH93;
+			w8001->id =3D 0x93;
+			strlcat(w8001->name, " 1FG", sizeof(w8001->name));
 			break;
+
 		case 1:
 		case 3:
 		case 4:
 			w8001->pktlen =3D W8001_PKTLEN_TOUCH9A;
+			strlcat(w8001->name, " 1FG", sizeof(w8001->name));
+			w8001->id =3D 0x9a;
 			break;
+
 		case 5:
 			w8001->pktlen =3D W8001_PKTLEN_TOUCH2FG;
=20
@@ -341,10 +449,17 @@ static int w8001_setup(struct w8001 *w8001)
 						0, touch.y, 0, 0);
 			input_set_abs_params(dev, ABS_MT_TOOL_TYPE,
 						0, MT_TOOL_MAX, 0, 0);
+
+			strlcat(w8001->name, " 2FG", sizeof(w8001->name));
+			if (w8001->max_pen_x && w8001->max_pen_y)
+				w8001->id =3D 0xE3;
+			else
+				w8001->id =3D 0xE2;
 			break;
 		}
 	}
=20
+	strlcat(w8001->name, " Touchscreen", sizeof(w8001->name));
 	return w8001_command(w8001, W8001_CMD_START, false);
 }
=20
@@ -384,21 +499,17 @@ static int w8001_connect(struct serio *serio, str=
uct serio_driver *drv)
 	}
=20
 	w8001->serio =3D serio;
-	w8001->id =3D serio->id.id;
 	w8001->dev =3D input_dev;
 	init_completion(&w8001->cmd_done);
 	snprintf(w8001->phys, sizeof(w8001->phys), "%s/input0", serio->phys);
=20
-	input_dev->name =3D "Wacom W8001 Penabled Serial TouchScreen";
 	input_dev->phys =3D w8001->phys;
 	input_dev->id.bustype =3D BUS_RS232;
-	input_dev->id.vendor =3D SERIO_W8001;
-	input_dev->id.product =3D w8001->id;
+	input_dev->id.vendor =3D 0x056a;
 	input_dev->id.version =3D 0x0100;
 	input_dev->dev.parent =3D &serio->dev;
=20
 	input_dev->evbit[0] =3D BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
-	__set_bit(BTN_TOUCH, input_dev->keybit);
=20
 	serio_set_drvdata(serio, w8001);
 	err =3D serio_open(serio, drv);
@@ -409,6 +520,8 @@ static int w8001_connect(struct serio *serio, struc=
t serio_driver *drv)
 	if (err)
 		goto fail3;
=20
+	input_dev->name =3D w8001->name;
+	input_dev->id.product =3D w8001->id;
 	err =3D input_register_device(w8001->dev);
 	if (err)
 		goto fail3;
--=20
1.7.3.4

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
