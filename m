From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [PATCH] input : wacom - report resolution for ABS_MT events
Date: Fri, 28 Jan 2011 10:23:59 -0800
Message-ID: <AANLkTi=d7frmTyAPzRSPmgXkvDh-Lc=WCvu9+tdA1Sg8@mail.gmail.com>
References: <1296179245-14614-1-git-send-email-pinglinux@gmail.com>
	<20110128173048.GC2586@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:53205 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755400Ab1A1SYB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 28 Jan 2011 13:24:01 -0500
Received: by wyb28 with SMTP id 28so3484789wyb.19
        for <linux-input@vger.kernel.org>; Fri, 28 Jan 2011 10:24:00 -0800 (PST)
In-Reply-To: <20110128173048.GC2586@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com

On Fri, Jan 28, 2011 at 9:30 AM, Henrik Rydberg <rydberg@euromail.se> w=
rote:
> Hi Ping,
>
>> This is mainly required by the serial pen and touch devices since
>> both pen and touch are on the same port. Updated the USB ones to
>> keep MT event definition consistent among serial and USB devices.
>
> Why is this change performed? What does the patch do? Please elaborat=
e
> a little bit.

Let's see if I can explain it clearer or not.

We need to report resolution to userland for wacom_w8001.c. Since pen
and touch data are reported through the same logical port for serial
devices, using input_abs_set_res  for ABS_X/Y,  we can only pass the
resolution for pen or touch. So, I let ABS_X/Y report pen resolution
since most legacy ST clients process pen data over touch. However, for
multi-touch clients, especially for those that support gestures, touch
resolution is needed to calculate the physical distance between two
touch points. Using  ABS_MT_POSITION_X/Y does not cause confusion and
it is quite intuitive.

This is not an issue for USB devices since pen and touch data are
reported on separate logical port to the userland. I added
ABS_MT_POSITION_X/Y for Bamboo touch only to make the interface
consistent between USB and serial.

Please see more comments inline.

>> Signed-off-by: Ping Cheng <pingc@wacom.com>
>> ---
>> =A0drivers/input/tablet/wacom_wac.c =A0 =A0 =A0 =A0| =A0 =A06 ++++++
>> =A0drivers/input/touchscreen/wacom_w8001.c | =A0 23 ++++++++++++++++=
++++++-
>> =A02 files changed, 28 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet=
/wacom_wac.c
>> index 367fa82..f129440 100644
>> --- a/drivers/input/tablet/wacom_wac.c
>> +++ b/drivers/input/tablet/wacom_wac.c
>> @@ -1283,6 +1283,12 @@ void wacom_setup_input_capabilities(struct in=
put_dev *input_dev,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_set_abs_params(inp=
ut_dev, ABS_MT_PRESSURE,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A00, features->pressure_max,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0features->pressure_fuzz, 0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_abs_set_res(input_de=
v, ABS_MT_POSITION_X,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wacom_calc=
ulate_touch_res(features->x_max,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->x_phy));
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_abs_set_res(input_de=
v, ABS_MT_POSITION_Y,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wacom_calc=
ulate_touch_res(features->y_max,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->y_phy));
>
> Is this for the BAMBOO_PT case? What about the extra x/y scaling for
> some of those devices?

Yes, it is for Bamboo. We do not need to scale the value here since
touch and pen are on different ports. We had to scale the value for
wacom_w8001 since both pen and touch are on the same port. Without
scaling the data, the pen/finger tip will not follow the cursor on the
screen (wacom_w8001 is a touchscren device).


>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_abs_set_res(input_=
dev, ABS_X,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wacom_ca=
lculate_touch_res(features->x_max,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->x_phy));
>> diff --git a/drivers/input/touchscreen/wacom_w8001.c b/drivers/input=
/touchscreen/wacom_w8001.c
>> index 5cb8449..f54da5c 100644
>> --- a/drivers/input/touchscreen/wacom_w8001.c
>> +++ b/drivers/input/touchscreen/wacom_w8001.c
>> @@ -51,6 +51,11 @@ MODULE_LICENSE("GPL");
>> =A0#define W8001_PKTLEN_TPCCTL =A011 =A0 =A0 =A0/* control packet */
>> =A0#define W8001_PKTLEN_TOUCH2FG =A0 =A0 =A0 =A013
>>
>> +/* resolution in points/mm */
>> +#define W8001_PEN_RESOLUTION =A0 =A0100
>> +#define W8001_TOUCH_RESOLUTION =A010
>> +
>> +
>> =A0struct w8001_coord {
>> =A0 =A0 =A0 u8 rdy;
>> =A0 =A0 =A0 u8 tsw;
>> @@ -92,6 +97,8 @@ struct w8001 {
>> =A0 =A0 =A0 u16 max_touch_y;
>> =A0 =A0 =A0 u16 max_pen_x;
>> =A0 =A0 =A0 u16 max_pen_y;
>> + =A0 =A0 u16 touch_res_x;
>> + =A0 =A0 u16 touch_res_y;
>
> Are these used anywhere?

Nice catch! I thought we needed to keep those two values when I worked
on it. But the final patch turned out they are only used once. I will
remove them with version 2 after I hear from you about the other
comments.

Thank you.

Ping

>> =A0 =A0 =A0 char name[64];
>> =A0};
>>
>> @@ -198,7 +205,7 @@ static void parse_touchquery(u8 *data, struct w8=
001_touch_query *query)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 query->y =3D 1024;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (query->panel_res)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 query->x =3D query->y =3D=
 (1 << query->panel_res);
>> - =A0 =A0 =A0 =A0 =A0 =A0 query->panel_res =3D 10;
>> + =A0 =A0 =A0 =A0 =A0 =A0 query->panel_res =3D W8001_TOUCH_RESOLUTIO=
N;
>> =A0 =A0 =A0 }
>> =A0}
>>
>> @@ -394,6 +401,8 @@ static int w8001_setup(struct w8001 *w8001)
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_set_abs_params(dev, ABS_X, 0, coor=
d.x, 0, 0);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_set_abs_params(dev, ABS_Y, 0, coor=
d.y, 0, 0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 input_abs_set_res(dev, ABS_X, W8001_PEN_RE=
SOLUTION);
>> + =A0 =A0 =A0 =A0 =A0 =A0 input_abs_set_res(dev, ABS_Y, W8001_PEN_RE=
SOLUTION);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_set_abs_params(dev, ABS_PRESSURE, =
0, coord.pen_pressure, 0, 0);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (coord.tilt_x && coord.tilt_y) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_set_abs_params(dev=
, ABS_TILT_X, 0, coord.tilt_x, 0, 0);
>> @@ -411,6 +420,9 @@ static int w8001_setup(struct w8001 *w8001)
>> =A0 =A0 =A0 =A0* second byte is empty, which indicates touch is not =
supported.
>> =A0 =A0 =A0 =A0*/
>> =A0 =A0 =A0 if (!error && w8001->response[1]) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 u16 touch_res_x =A0=3D touch.panel_res;
>> + =A0 =A0 =A0 =A0 =A0 =A0 u16 touch_res_y =3D touch.panel_res;
>> +
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(BTN_TOUCH, dev->keybit);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(BTN_TOOL_FINGER, dev->keybit);
>>
>> @@ -422,10 +434,17 @@ static int w8001_setup(struct w8001 *w8001)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (w8001->max_pen_x && w8001->max_pen_y=
) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 touch.x =3D w8001->max_p=
en_x;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 touch.y =3D w8001->max_p=
en_y;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* scale resolution as wel=
l */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 touch_res_x *=3D w8001->ma=
x_pen_x / w8001->max_touch_x;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 touch_res_y *=3D w8001->ma=
x_pen_y / w8001->max_touch_y;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_set_abs_params(dev, ABS_X, 0, touc=
h.x, 0, 0);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_set_abs_params(dev, ABS_Y, 0, touc=
h.y, 0, 0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* don't report touch resolution for ST si=
nce pen resolution
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* is more important
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 switch (touch.sensor_id) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 case 0:
>> @@ -453,6 +472,8 @@ static int w8001_setup(struct w8001 *w8001)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 0, touch.y, 0, 0);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_set_abs_params(dev=
, ABS_MT_TOOL_TYPE,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 0, MT_TOOL_MAX, 0, 0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_abs_set_res(dev, ABS=
_MT_POSITION_X, touch_res_x);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_abs_set_res(dev, ABS=
_MT_POSITION_Y, touch_res_y);
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 strlcat(w8001->name, " 2=
=46G", sizeof(w8001->name));
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (w8001->max_pen_x && =
w8001->max_pen_y)
>> --
>> 1.7.3.5
>>
>
> Thanks,
> Henrik
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
