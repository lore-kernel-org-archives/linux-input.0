From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [PATCH 2/2]input - wacom_w8001: Add one finger touch support
Date: Thu, 9 Dec 2010 11:36:19 -0800
Message-ID: <AANLkTi=w3uOQKFN3WBgzib9M0Cb143vChPPaYm6fWypi@mail.gmail.com>
References: <1291857829-13804-1-git-send-email-pinglinux@gmail.com>
	<AANLkTikatcsta_EQ26CzouHj+WMfQptJF_ZkMfCwUmnN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:52446 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752893Ab0LITgU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 9 Dec 2010 14:36:20 -0500
Received: by wwa36 with SMTP id 36so2836590wwa.1
        for <linux-input@vger.kernel.org>; Thu, 09 Dec 2010 11:36:19 -0800 (PST)
In-Reply-To: <AANLkTikatcsta_EQ26CzouHj+WMfQptJF_ZkMfCwUmnN@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chris Bagwell <chris@cnpbagwell.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com

On Thu, Dec 9, 2010 at 7:06 AM, Chris Bagwell <chris@cnpbagwell.com> wr=
ote:
> On Wed, Dec 8, 2010 at 7:23 PM, Ping Cheng <pinglinux@gmail.com> wrot=
e:
>> Signed-off-by: Ping Cheng <pingc@wacom.com>
>> ---
>> =A0drivers/input/touchscreen/wacom_w8001.c | =A0 74 ++++++++++++++++=
+++++++++++++--
>> =A01 files changed, 70 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/input/touchscreen/wacom_w8001.c b/drivers/input=
/touchscreen/wacom_w8001.c
>> index 90b92e8..68087d8 100644
>> --- a/drivers/input/touchscreen/wacom_w8001.c
>> +++ b/drivers/input/touchscreen/wacom_w8001.c
>> @@ -3,6 +3,7 @@
>> =A0*
>> =A0* Copyright (c) 2008 Jaya Kumar
>> =A0* Copyright (c) 2010 Red Hat, Inc.
>> + * Copyright (c) 2010 Ping Cheng, Wacom. <pingc@wacom.com>
>> =A0*
>> =A0* This file is subject to the terms and conditions of the GNU Gen=
eral Public
>> =A0* License. See the file COPYING in the main directory of this arc=
hive for
>> @@ -86,6 +87,12 @@ struct w8001 {
>> =A0 =A0 =A0 =A0char phys[32];
>> =A0 =A0 =A0 =A0int type;
>> =A0 =A0 =A0 =A0unsigned int pktlen;
>> + =A0 =A0 =A0 bool pen_in_prox;
>> + =A0 =A0 =A0 bool has_touch;
>> + =A0 =A0 =A0 int max_touch_x;
>> + =A0 =A0 =A0 int max_touch_y;
>> + =A0 =A0 =A0 int max_pen_x;
>> + =A0 =A0 =A0 int max_pen_y;
>> =A0};
>>
>> =A0static void parse_data(u8 *data, struct w8001_coord *coord)
>> @@ -112,6 +119,29 @@ static void parse_data(u8 *data, struct w8001_c=
oord *coord)
>> =A0 =A0 =A0 =A0coord->tilt_y =3D data[8] & 0x7F;
>> =A0}
>>
>> +static void parse_single_touch(struct w8001 *w8001)
>> +{
>> + =A0 =A0 =A0 struct input_dev *dev =3D w8001->dev;
>> + =A0 =A0 =A0 unsigned char *data =3D w8001->data;
>> +
>> + =A0 =A0 =A0 int x =3D (data[1] << 7) | data[2];
>> + =A0 =A0 =A0 int y =3D (data[3] << 7) | data[4];
>> + =A0 =A0 =A0 w8001->has_touch =3D data[0] & 0x1;
>> +
>> + =A0 =A0 =A0 /* scale to pen maximum */
>> + =A0 =A0 =A0 if (w8001->max_pen_x && w8001->max_pen_y && w8001->max=
_touch_x) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 x =3D x * w8001->max_pen_x / w8001->ma=
x_touch_x;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 y =3D y * w8001->max_pen_y / w8001->ma=
x_touch_y;
>
> Ok, you are doing scaling.
>
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 input_report_abs(dev, ABS_X, x);
>> + =A0 =A0 =A0 input_report_abs(dev, ABS_Y, y);
>> + =A0 =A0 =A0 input_report_key(dev, BTN_TOUCH, w8001->has_touch);
>> + =A0 =A0 =A0 input_report_key(dev, BTN_TOOL_FINGER, w8001->has_touc=
h);
>
> Wacom seems good about report x/y=3D0 when !has_touch but its probabl=
y
> safer to enforce that if this can be a combo device. =A0More below.

I can do that although it's not necessary, especially only for (x,y).
We don't emit motion events once the finger is up or the tool is
out-prox.

>> +
>> + =A0 =A0 =A0 input_sync(dev);
>> +}
>> +
>> =A0static void parse_touch(struct w8001 *w8001)
>> =A0{
>> =A0 =A0 =A0 =A0struct input_dev *dev =3D w8001->dev;
>> @@ -151,6 +181,18 @@ static void parse_touchquery(u8 *data, struct w=
8001_touch_query *query)
>> =A0 =A0 =A0 =A0query->y =3D data[5] << 9;
>> =A0 =A0 =A0 =A0query->y |=3D data[6] << 2;
>> =A0 =A0 =A0 =A0query->y |=3D (data[2] >> 3) & 0x3;
>> +
>> + =A0 =A0 =A0 /* Early days' one finger touch models need the follow=
ing defaults */
>> + =A0 =A0 =A0 if (!query->x && !query->y) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 query->x =3D 1024;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 query->y =3D 1024;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 query->panel_res =3D 10;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 query->panel_res =3D 10;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (data[1]) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 query->x =3D (1 << dat=
a[1]);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 query->y =3D (1 << dat=
a[1]);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 }
>> =A0}
>>
>> =A0static void report_pen_events(struct w8001 *w8001, struct w8001_c=
oord *coord)
>> @@ -199,6 +241,7 @@ static irqreturn_t w8001_interrupt(struct serio =
*serio,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
unsigned char data, unsigned int flags)
>> =A0{
>> =A0 =A0 =A0 =A0struct w8001 *w8001 =3D serio_get_drvdata(serio);
>> + =A0 =A0 =A0 struct input_dev *dev =3D w8001->dev;
>> =A0 =A0 =A0 =A0struct w8001_coord coord;
>> =A0 =A0 =A0 =A0unsigned char tmp;
>>
>> @@ -213,9 +256,15 @@ static irqreturn_t w8001_interrupt(struct serio=
 *serio,
>>
>> =A0 =A0 =A0 =A0case W8001_PKTLEN_TOUCH93 - 1:
>> =A0 =A0 =A0 =A0case W8001_PKTLEN_TOUCH9A - 1:
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* ignore one-finger touch packet. */
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (w8001->pktlen =3D=3D w8001->idx)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp =3D (w8001->data[0] & W8001_TOUCH_=
BYTE);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (tmp !=3D W8001_TOUCH_BYTE)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (w8001->pktlen =3D=3D w8001->idx) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0w8001->idx =3D 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!w8001->pen_in_pro=
x)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 parse_=
single_touch(w8001);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>>
>> =A0 =A0 =A0 =A0/* Pen coordinates packet */
>> @@ -228,9 +277,17 @@ static irqreturn_t w8001_interrupt(struct serio=
 *serio,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (tmp =3D=3D W8001_TOUCH_BYTE)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (w8001->has_touch) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* send touch data out=
 */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 w8001->has_touch =3D 0=
;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(dev, =
BTN_TOUCH, 0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(dev, =
BTN_TOOL_FINGER, 0);
>
> Probably its better to set ABS_X/ABS_Y to zero and do a sync here? =A0=
So
> duplicate x/y values don't get dropped and aligns with wacom_wac.c.
> This is related to comment about forcing ABS_X/Y to zero above. =A0It=
s
> so pen has known starting point when coming in proximity. =A0I wouldn=
't
> do one without the other.

I'll do both to make you happy (just kidding, to make it safe ;).

>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0w8001->idx =3D 0;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0parse_data(w8001->data, &coord);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0report_pen_events(w8001, &coord);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 w8001->pen_in_prox =3D coord.rdy ? tru=
e : false;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>>
>> =A0 =A0 =A0 =A0/* control packet */
>> @@ -313,11 +370,20 @@ static int w8001_setup(struct w8001 *w8001)
>> =A0 =A0 =A0 =A0 */
>> =A0 =A0 =A0 =A0if (!error && w8001->response[1]) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct w8001_touch_query touch;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int px, py;
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0parse_touchquery(w8001->response, &to=
uch);
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_set_abs_params(dev, ABS_X, 0, to=
uch.x, 0, 0);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_set_abs_params(dev, ABS_Y, 0, to=
uch.y, 0, 0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 px =3D w8001->max_touch_x =3D touch.x;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 py =3D w8001->max_touch_x =3D touch.y;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* scale to pen maximum */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (coord.x && coord.y) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 px =3D w8001->max_pen_=
x =3D coord.x;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 py =3D w8001->max_pen_=
y =3D coord.y;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_set_abs_params(dev, ABS_X, 0, px=
, 0, 0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_set_abs_params(dev, ABS_Y, 0, py=
, 0, 0);
>
> I see. =A0My previous comments are addressed... except for MT comment=
=2E
> Should those be disabled or does sensor_id take care of that?

sensor_id takes care of it.

Thank you for reviewing.

Ping

>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev->keybit[BIT_WORD(BTN_TOOL_FINGER)=
] |=3D BIT_MASK(BTN_TOOL_FINGER);
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0switch (touch.sensor_id) {
>> --
>> 1.7.2.3
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-inpu=
t" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
