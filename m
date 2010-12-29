From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [PATCH 3/3 v2] input - wacom_w8001: Add one finger touch support
Date: Wed, 29 Dec 2010 14:30:24 -0800
Message-ID: <AANLkTinmm1=Xp587ii4fHWUv25Skx_V=3eumjpuC48O6@mail.gmail.com>
References: <1292607474-22674-1-git-send-email-pinglinux@gmail.com>
	<20101229074058.GA13061@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:53465 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753592Ab0L2WaZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 29 Dec 2010 17:30:25 -0500
Received: by wyb28 with SMTP id 28so10515801wyb.19
        for <linux-input@vger.kernel.org>; Wed, 29 Dec 2010 14:30:24 -0800 (PST)
In-Reply-To: <20101229074058.GA13061@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Dmitry,

Thank you for your effort in updating the patch. Most changes work for
me. I do have comments related to raw touch data scaling for MT and
single touch legacy client support. Details are inline.

Ping

On Tue, Dec 28, 2010 at 11:40 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Hi Ping,
>
> On Fri, Dec 17, 2010 at 09:37:54AM -0800, Ping Cheng wrote:
>> Signed-off-by: Ping Cheng <pingc@wacom.com>
>> ---
>> =C2=A0drivers/input/touchscreen/wacom_w8001.c | =C2=A0 89 ++++++++++=
++++++++++++++++++---
>> =C2=A01 files changed, 82 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/input/touchscreen/wacom_w8001.c b/drivers/input=
/touchscreen/wacom_w8001.c
>> index 59664a8..763eb8f 100644
>> --- a/drivers/input/touchscreen/wacom_w8001.c
>> +++ b/drivers/input/touchscreen/wacom_w8001.c
>> @@ -3,6 +3,7 @@
>> =C2=A0 *
>> =C2=A0 * Copyright (c) 2008 Jaya Kumar
>> =C2=A0 * Copyright (c) 2010 Red Hat, Inc.
>> + * Copyright (c) 2010 Ping Cheng, Wacom. <pingc@wacom.com>
>> =C2=A0 *
>> =C2=A0 * This file is subject to the terms and conditions of the GNU=
 General Public
>> =C2=A0 * License. See the file COPYING in the main directory of this=
 archive for
>> @@ -86,6 +87,12 @@ struct w8001 {
>> =C2=A0 =C2=A0 =C2=A0 char phys[32];
>> =C2=A0 =C2=A0 =C2=A0 int type;
>> =C2=A0 =C2=A0 =C2=A0 unsigned int pktlen;
>> + =C2=A0 =C2=A0 bool pen_in_prox;
>> + =C2=A0 =C2=A0 bool has_touch;
>
> We already have type, why do we need these 2 fields a well?
>
> Actually, I tried massaging the patch a bit, could you please tell me=
 if
> the patch below still works for you?
>
> Thanks.
>
> --
> Dmitry
>
>
> Input: wacom_w8001 - add one finger touch support
>
> From: Ping Cheng <pinglinux@gmail.com>
>
> Signed-off-by: Ping Cheng <pingc@wacom.com>
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> ---
>
> =C2=A0drivers/input/touchscreen/wacom_w8001.c | =C2=A0123 +++++++++++=
++++++++++++++------
> =C2=A01 files changed, 101 insertions(+), 22 deletions(-)
>
>
> diff --git a/drivers/input/touchscreen/wacom_w8001.c b/drivers/input/=
touchscreen/wacom_w8001.c
> index 4774c09..ce8c8e1 100644
> --- a/drivers/input/touchscreen/wacom_w8001.c
> +++ b/drivers/input/touchscreen/wacom_w8001.c
> @@ -3,6 +3,7 @@
> =C2=A0*
> =C2=A0* Copyright (c) 2008 Jaya Kumar
> =C2=A0* Copyright (c) 2010 Red Hat, Inc.
> + * Copyright (c) 2010 Ping Cheng, Wacom. <pingc@wacom.com>
> =C2=A0*
> =C2=A0* This file is subject to the terms and conditions of the GNU G=
eneral Public
> =C2=A0* License. See the file COPYING in the main directory of this a=
rchive for
> @@ -63,11 +64,11 @@ struct w8001_coord {
>
> =C2=A0/* touch query reply packet */
> =C2=A0struct w8001_touch_query {
> + =C2=A0 =C2=A0 =C2=A0 u16 x;
> + =C2=A0 =C2=A0 =C2=A0 u16 y;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0u8 panel_res;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0u8 capacity_res;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0u8 sensor_id;
> - =C2=A0 =C2=A0 =C2=A0 u16 x;
> - =C2=A0 =C2=A0 =C2=A0 u16 y;
> =C2=A0};
>
> =C2=A0/*
> @@ -86,9 +87,13 @@ struct w8001 {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0char phys[32];
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int type;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int pktlen;
> + =C2=A0 =C2=A0 =C2=A0 u16 max_touch_x;
> + =C2=A0 =C2=A0 =C2=A0 u16 max_touch_y;
> + =C2=A0 =C2=A0 =C2=A0 u16 max_pen_x;
> + =C2=A0 =C2=A0 =C2=A0 u16 max_pen_y;
> =C2=A0};
>
> -static void parse_data(u8 *data, struct w8001_coord *coord)
> +static void parse_pen_data(u8 *data, struct w8001_coord *coord)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0memset(coord, 0, sizeof(*coord));
>
> @@ -112,7 +117,14 @@ static void parse_data(u8 *data, struct w8001_co=
ord *coord)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0coord->tilt_y =3D data[8] & 0x7F;
> =C2=A0}
>
> -static void parse_touch(struct w8001 *w8001)
> +static void parse_single_touch(u8 *data, struct w8001_coord *coord)
> +{
> + =C2=A0 =C2=A0 =C2=A0 coord->x =3D (data[1] << 7) | data[2];
> + =C2=A0 =C2=A0 =C2=A0 coord->y =3D (data[3] << 7) | data[4];
> + =C2=A0 =C2=A0 =C2=A0 coord->tsw =3D data[0] & 0x01;
> +}
> +
> +static void parse_multi_touch(struct w8001 *w8001)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct input_dev *dev =3D w8001->dev;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned char *data =3D w8001->data;
> @@ -124,8 +136,8 @@ static void parse_touch(struct w8001 *w8001)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0input_mt_slot(=
dev, i);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0input_mt_repor=
t_slot_state(dev, MT_TOOL_FINGER, touch);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (touch) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 int x =3D (data[6 * i + 1] << 7) | (data[6 * i + 2]);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 int y =3D (data[6 * i + 3] << 7) | (data[6 * i + 4]);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 int x =3D (data[6 * i + 1] << 7) | data[6 * i + 2];
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 int y =3D (data[6 * i + 3] << 7) | data[6 * i + 4];

Since you scaled MT max_touch_x/y to max_pen_x/y, you would need to
scale the x and y here as well. I didn't scale MT touch data since MT
protocol can report touch resolution on its own. See more comments
below.

> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0/* data[5,6] and [11,12] is finger capacity */
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0input_report_abs(dev, ABS_MT_POSITION_X, x);
> @@ -151,6 +163,15 @@ static void parse_touchquery(u8 *data, struct w8=
001_touch_query *query)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0query->y =3D data[5] << 9;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0query->y |=3D data[6] << 2;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0query->y |=3D (data[2] >> 3) & 0x3;
> +
> + =C2=A0 =C2=A0 =C2=A0 /* Early days' single-finger touch models need=
 the following defaults */
> + =C2=A0 =C2=A0 =C2=A0 if (!query->x && !query->y) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 query->x =3D 1024;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 query->y =3D 1024;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (query->panel_r=
es)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 query->x =3D query->y =3D (1 << query->panel_res);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 query->panel_res =3D=
 10;
> + =C2=A0 =C2=A0 =C2=A0 }
> =C2=A0}
>
> =C2=A0static void report_pen_events(struct w8001 *w8001, struct w8001=
_coord *coord)
> @@ -160,16 +181,15 @@ static void report_pen_events(struct w8001 *w80=
01, struct w8001_coord *coord)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/*
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 * We have 1 bit for proximity (rdy) and 3=
 bits for tip, side,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 * side2/eraser. If rdy && f2 are set, thi=
s can be either pen + side2,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0* or eraser. assume
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* or eraser. Assume:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 * - if dev is already in proximity and f2=
 is toggled =E2=86=92 pen + side2
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 * - if dev comes into proximity with f2 s=
et =E2=86=92 eraser
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 * If f2 disappears after assuming eraser,=
 fake proximity out for
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 * eraser and in for pen.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 */
>
> - =C2=A0 =C2=A0 =C2=A0 if (!w8001->type) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 w8001->type =3D co=
ord->f2 ? BTN_TOOL_RUBBER : BTN_TOOL_PEN;
> - =C2=A0 =C2=A0 =C2=A0 } else if (w8001->type =3D=3D BTN_TOOL_RUBBER)=
 {
> + =C2=A0 =C2=A0 =C2=A0 switch (w8001->type) {
> + =C2=A0 =C2=A0 =C2=A0 case BTN_TOOL_RUBBER:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!coord->f2=
) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0input_report_abs(dev, ABS_PRESSURE, 0);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0input_report_key(dev, BTN_TOUCH, 0);
> @@ -179,8 +199,21 @@ static void report_pen_events(struct w8001 *w800=
1, struct w8001_coord *coord)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0input_sync(dev);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0w8001->type =3D BTN_TOOL_PEN;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> - =C2=A0 =C2=A0 =C2=A0 } else {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
> +
> + =C2=A0 =C2=A0 =C2=A0 case BTN_TOOL_FINGER:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 input_report_key(d=
ev, BTN_TOUCH, 0);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 input_report_key(d=
ev, BTN_TOOL_FINGER, 0);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 input_sync(dev);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* fall through */
> +
> + =C2=A0 =C2=A0 =C2=A0 case KEY_RESERVED:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 w8001->type =3D co=
ord->f2 ? BTN_TOOL_RUBBER : BTN_TOOL_PEN;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
> +
> + =C2=A0 =C2=A0 =C2=A0 default:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0input_report_k=
ey(dev, BTN_STYLUS2, coord->f2);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0input_report_abs(dev, ABS_X, coord->x);
> @@ -192,7 +225,30 @@ static void report_pen_events(struct w8001 *w800=
1, struct w8001_coord *coord)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0input_sync(dev);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!coord->rdy)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 w8001->type =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 w8001->type =3D KE=
Y_RESERVED;
> +}
> +
> +static void report_single_touch(struct w8001 *w8001, struct w8001_co=
ord *coord)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct input_dev *dev =3D w8001->dev;
> + =C2=A0 =C2=A0 =C2=A0 unsigned int x =3D coord->x;
> + =C2=A0 =C2=A0 =C2=A0 unsigned int y =3D coord->y;
> +
> + =C2=A0 =C2=A0 =C2=A0 /* scale to pen maximum */
> + =C2=A0 =C2=A0 =C2=A0 if (w8001->max_pen_x && w8001->max_touch_x)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 x =3D x * w8001->m=
ax_pen_x / w8001->max_touch_x;
> +
> + =C2=A0 =C2=A0 =C2=A0 if (w8001->max_pen_y && w8001->max_touch_y)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 y =3D y * w8001->m=
ax_pen_y / w8001->max_touch_y;
> +
> + =C2=A0 =C2=A0 =C2=A0 input_report_abs(dev, ABS_X, x);
> + =C2=A0 =C2=A0 =C2=A0 input_report_abs(dev, ABS_Y, y);
> + =C2=A0 =C2=A0 =C2=A0 input_report_key(dev, BTN_TOUCH, coord->tsw);
> + =C2=A0 =C2=A0 =C2=A0 input_report_key(dev, BTN_TOOL_FINGER, coord->=
tsw);
> +
> + =C2=A0 =C2=A0 =C2=A0 input_sync(dev);
> +
> + =C2=A0 =C2=A0 =C2=A0 w8001->type =3D coord->tsw ? BTN_TOOL_FINGER :=
 KEY_RESERVED;
> =C2=A0}
>
> =C2=A0static irqreturn_t w8001_interrupt(struct serio *serio,
> @@ -213,9 +269,18 @@ static irqreturn_t w8001_interrupt(struct serio =
*serio,
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0case W8001_PKTLEN_TOUCH93 - 1:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0case W8001_PKTLEN_TOUCH9A - 1:
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* ignore one-fing=
er touch packet. */
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (w8001->pktlen =
=3D=3D w8001->idx)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tmp =3D w8001->dat=
a[0] & W8001_TOUCH_BYTE;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (tmp !=3D W8001=
_TOUCH_BYTE)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 break;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (w8001->pktlen =
=3D=3D w8001->idx) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0w8001->idx =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 if (w8001->type !=3D BTN_TOOL_PEN &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 w8001->type !=3D BTN_TOOL_RUBBER) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 parse_single_touch(w8001->data, &co=
ord);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 report_single_touch(w8001, &coord);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Pen coordinates packet */
> @@ -224,18 +289,18 @@ static irqreturn_t w8001_interrupt(struct serio=
 *serio,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (unlikely(t=
mp =3D=3D W8001_TAB_BYTE))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0break;
>
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tmp =3D (w8001->da=
ta[0] & W8001_TOUCH_BYTE);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tmp =3D w8001->dat=
a[0] & W8001_TOUCH_BYTE;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (tmp =3D=3D=
 W8001_TOUCH_BYTE)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0break;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0w8001->idx =3D=
 0;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 parse_data(w8001->=
data, &coord);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 parse_pen_data(w80=
01->data, &coord);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0report_pen_eve=
nts(w8001, &coord);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* control packet */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0case W8001_PKTLEN_TPCCTL - 1:
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tmp =3D (w8001->da=
ta[0] & W8001_TOUCH_MASK);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tmp =3D w8001->dat=
a[0] & W8001_TOUCH_MASK;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (tmp =3D=3D=
 W8001_TOUCH_BYTE)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0break;
>
> @@ -248,7 +313,7 @@ static irqreturn_t w8001_interrupt(struct serio *=
serio,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* 2 finger touch packet */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0case W8001_PKTLEN_TOUCH2FG - 1:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0w8001->idx =3D=
 0;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 parse_touch(w8001)=
;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 parse_multi_touch(=
w8001);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> @@ -278,6 +343,7 @@ static int w8001_setup(struct w8001 *w8001)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct input_dev *dev =3D w8001->dev;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct w8001_coord coord;
> + =C2=A0 =C2=A0 =C2=A0 struct w8001_touch_query touch;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int error;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0error =3D w8001_command(w8001, W8001_CMD_S=
TOP, false);
> @@ -289,11 +355,15 @@ static int w8001_setup(struct w8001 *w8001)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* penabled? */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0error =3D w8001_command(w8001, W8001_CMD_Q=
UERY, true);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!error) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __set_bit(BTN_TOUC=
H, dev->keybit);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__set_bit(BTN_=
TOOL_PEN, dev->keybit);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__set_bit(BTN_=
TOOL_RUBBER, dev->keybit);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__set_bit(BTN_=
STYLUS, dev->keybit);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__set_bit(BTN_=
STYLUS2, dev->keybit);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 parse_data(w8001->=
response, &coord);
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 parse_pen_data(w80=
01->response, &coord);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 w8001->max_pen_x =3D=
 coord.x;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 w8001->max_pen_y =3D=
 coord.y;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0input_set_abs_=
params(dev, ABS_X, 0, coord.x, 0, 0);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0input_set_abs_=
params(dev, ABS_Y, 0, coord.y, 0, 0);
> @@ -312,24 +382,34 @@ static int w8001_setup(struct w8001 *w8001)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 * second byte is empty, which indicates t=
ouch is not supported.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!error && w8001->response[1]) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct w8001_touch=
_query touch;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __set_bit(BTN_TOUC=
H, dev->keybit);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __set_bit(BTN_TOOL=
_FINGER, dev->keybit);

I do not think we want to set BTN_TOUCH and BTN_TOOL_FINGER for MT
device since we do not need to support single touch for this MT
device. Please refer to my comments for your other patch in the next
email.

> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0parse_touchque=
ry(w8001->response, &touch);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 w8001->max_touch_x=
 =3D touch.x;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 w8001->max_touch_y=
 =3D touch.y;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* scale to pen ma=
ximum */
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (w8001->max_pen=
_x && w8001->max_pen_y) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 touch.x =3D w8001->max_pen_x;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 touch.y =3D w8001->max_pen_y;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }

If we scale touch for both single and MT, we need to scale the raw
(x,y) for both too. I purposely did not want to scale MT touch since
they can be supported in different resolution from pen by MT protocol
now.

>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0input_set_abs_=
params(dev, ABS_X, 0, touch.x, 0, 0);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0input_set_abs_=
params(dev, ABS_Y, 0, touch.y, 0, 0);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __set_bit(BTN_TOOL=
_FINGER, dev->keybit);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0switch (touch.=
sensor_id) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case 0:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case 2:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0w8001->pktlen =3D W8001_PKTLEN_TOUCH93;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0break;
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case 1:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case 3:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case 4:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0w8001->pktlen =3D W8001_PKTLEN_TOUCH9A;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0break;
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case 5:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0w8001->pktlen =3D W8001_PKTLEN_TOUCH2FG;
>
> @@ -397,7 +477,6 @@ static int w8001_connect(struct serio *serio, str=
uct serio_driver *drv)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0input_dev->dev.parent =3D &serio->dev;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0input_dev->evbit[0] =3D BIT_MASK(EV_KEY) |=
 BIT_MASK(EV_ABS);
> - =C2=A0 =C2=A0 =C2=A0 __set_bit(BTN_TOUCH, input_dev->keybit);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0serio_set_drvdata(serio, w8001);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D serio_open(serio, drv);
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
