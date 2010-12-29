From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 3/3 v2] input - wacom_w8001: Add one finger touch support
Date: Tue, 28 Dec 2010 23:40:58 -0800
Message-ID: <20101229074058.GA13061@core.coreip.homeip.net>
References: <1292607474-22674-1-git-send-email-pinglinux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:62493 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750822Ab0L2HlF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 29 Dec 2010 02:41:05 -0500
Received: by mail-iw0-f174.google.com with SMTP id 9so9901414iwn.19
        for <linux-input@vger.kernel.org>; Tue, 28 Dec 2010 23:41:05 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1292607474-22674-1-git-send-email-pinglinux@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: linux-input@vger.kernel.org, Ping Cheng <pingc@wacom.com>

Hi Ping,

On Fri, Dec 17, 2010 at 09:37:54AM -0800, Ping Cheng wrote:
> Signed-off-by: Ping Cheng <pingc@wacom.com>
> ---
>  drivers/input/touchscreen/wacom_w8001.c |   89 +++++++++++++++++++++=
+++++++---
>  1 files changed, 82 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/input/touchscreen/wacom_w8001.c b/drivers/input/=
touchscreen/wacom_w8001.c
> index 59664a8..763eb8f 100644
> --- a/drivers/input/touchscreen/wacom_w8001.c
> +++ b/drivers/input/touchscreen/wacom_w8001.c
> @@ -3,6 +3,7 @@
>   *
>   * Copyright (c) 2008 Jaya Kumar
>   * Copyright (c) 2010 Red Hat, Inc.
> + * Copyright (c) 2010 Ping Cheng, Wacom. <pingc@wacom.com>
>   *
>   * This file is subject to the terms and conditions of the GNU Gener=
al Public
>   * License. See the file COPYING in the main directory of this archi=
ve for
> @@ -86,6 +87,12 @@ struct w8001 {
>  	char phys[32];
>  	int type;
>  	unsigned int pktlen;
> +	bool pen_in_prox;
> +	bool has_touch;

We already have type, why do we need these 2 fields a well?

Actually, I tried massaging the patch a bit, could you please tell me i=
f
the patch below still works for you?

Thanks.

--=20
Dmitry


Input: wacom_w8001 - add one finger touch support

=46rom: Ping Cheng <pinglinux@gmail.com>

Signed-off-by: Ping Cheng <pingc@wacom.com>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/touchscreen/wacom_w8001.c |  123 +++++++++++++++++++++++=
++------
 1 files changed, 101 insertions(+), 22 deletions(-)


diff --git a/drivers/input/touchscreen/wacom_w8001.c b/drivers/input/to=
uchscreen/wacom_w8001.c
index 4774c09..ce8c8e1 100644
--- a/drivers/input/touchscreen/wacom_w8001.c
+++ b/drivers/input/touchscreen/wacom_w8001.c
@@ -3,6 +3,7 @@
  *
  * Copyright (c) 2008 Jaya Kumar
  * Copyright (c) 2010 Red Hat, Inc.
+ * Copyright (c) 2010 Ping Cheng, Wacom. <pingc@wacom.com>
  *
  * This file is subject to the terms and conditions of the GNU General=
 Public
  * License. See the file COPYING in the main directory of this archive=
 for
@@ -63,11 +64,11 @@ struct w8001_coord {
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
@@ -86,9 +87,13 @@ struct w8001 {
 	char phys[32];
 	int type;
 	unsigned int pktlen;
+	u16 max_touch_x;
+	u16 max_touch_y;
+	u16 max_pen_x;
+	u16 max_pen_y;
 };
=20
-static void parse_data(u8 *data, struct w8001_coord *coord)
+static void parse_pen_data(u8 *data, struct w8001_coord *coord)
 {
 	memset(coord, 0, sizeof(*coord));
=20
@@ -112,7 +117,14 @@ static void parse_data(u8 *data, struct w8001_coor=
d *coord)
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
@@ -124,8 +136,8 @@ static void parse_touch(struct w8001 *w8001)
 		input_mt_slot(dev, i);
 		input_mt_report_slot_state(dev, MT_TOOL_FINGER, touch);
 		if (touch) {
-			int x =3D (data[6 * i + 1] << 7) | (data[6 * i + 2]);
-			int y =3D (data[6 * i + 3] << 7) | (data[6 * i + 4]);
+			int x =3D (data[6 * i + 1] << 7) | data[6 * i + 2];
+			int y =3D (data[6 * i + 3] << 7) | data[6 * i + 4];
 			/* data[5,6] and [11,12] is finger capacity */
=20
 			input_report_abs(dev, ABS_MT_POSITION_X, x);
@@ -151,6 +163,15 @@ static void parse_touchquery(u8 *data, struct w800=
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
@@ -160,16 +181,15 @@ static void report_pen_events(struct w8001 *w8001=
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
@@ -179,8 +199,21 @@ static void report_pen_events(struct w8001 *w8001,=
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
@@ -192,7 +225,30 @@ static void report_pen_events(struct w8001 *w8001,=
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
@@ -213,9 +269,18 @@ static irqreturn_t w8001_interrupt(struct serio *s=
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
@@ -224,18 +289,18 @@ static irqreturn_t w8001_interrupt(struct serio *=
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
@@ -248,7 +313,7 @@ static irqreturn_t w8001_interrupt(struct serio *se=
rio,
 	/* 2 finger touch packet */
 	case W8001_PKTLEN_TOUCH2FG - 1:
 		w8001->idx =3D 0;
-		parse_touch(w8001);
+		parse_multi_touch(w8001);
 		break;
 	}
=20
@@ -278,6 +343,7 @@ static int w8001_setup(struct w8001 *w8001)
 {
 	struct input_dev *dev =3D w8001->dev;
 	struct w8001_coord coord;
+	struct w8001_touch_query touch;
 	int error;
=20
 	error =3D w8001_command(w8001, W8001_CMD_STOP, false);
@@ -289,11 +355,15 @@ static int w8001_setup(struct w8001 *w8001)
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
@@ -312,24 +382,34 @@ static int w8001_setup(struct w8001 *w8001)
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
 			break;
+
 		case 1:
 		case 3:
 		case 4:
 			w8001->pktlen =3D W8001_PKTLEN_TOUCH9A;
 			break;
+
 		case 5:
 			w8001->pktlen =3D W8001_PKTLEN_TOUCH2FG;
=20
@@ -397,7 +477,6 @@ static int w8001_connect(struct serio *serio, struc=
t serio_driver *drv)
 	input_dev->dev.parent =3D &serio->dev;
=20
 	input_dev->evbit[0] =3D BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
-	__set_bit(BTN_TOUCH, input_dev->keybit);
=20
 	serio_set_drvdata(serio, w8001);
 	err =3D serio_open(serio, drv);
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
