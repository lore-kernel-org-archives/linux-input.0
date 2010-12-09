From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [PATCH 1/2]input - wacom_w8001: Support pen or touch only devices
Date: Thu, 9 Dec 2010 11:01:01 -0800
Message-ID: <AANLkTi=85Qsq37XOqcm9ESANqZW-q_YM7icBirtgh4A8@mail.gmail.com>
References: <1291857433-13731-1-git-send-email-pinglinux@gmail.com>
	<20101209064222.GA6233@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ew0-f45.google.com ([209.85.215.45]:51942 "EHLO
	mail-ew0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755499Ab0LITBD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 9 Dec 2010 14:01:03 -0500
Received: by ewy10 with SMTP id 10so2012370ewy.4
        for <linux-input@vger.kernel.org>; Thu, 09 Dec 2010 11:01:02 -0800 (PST)
In-Reply-To: <20101209064222.GA6233@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

On Wed, Dec 8, 2010 at 10:42 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Hi Ping,
>
> On Wed, Dec 08, 2010 at 05:17:13PM -0800, Ping Cheng wrote:
>> Not all penabled devices support touch. The same idea is true for
>> touch devices. Setting up the devices according to the specific
>> querying results.
>>
>> Signed-off-by: Ping Cheng <pingc@wacom.com>
>> ---
>> =A0drivers/input/touchscreen/wacom_w8001.c | =A0 39 ++++++++++++++++=
++++++++------
>> =A01 files changed, 31 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/input/touchscreen/wacom_w8001.c b/drivers/input=
/touchscreen/wacom_w8001.c
>> index 361d00a..90b92e8 100644
>> --- a/drivers/input/touchscreen/wacom_w8001.c
>> +++ b/drivers/input/touchscreen/wacom_w8001.c
>> @@ -37,6 +37,7 @@ MODULE_LICENSE("GPL");
>>
>> =A0#define W8001_QUERY_PACKET =A0 0x20
>>
>> +#define W8001_CMD_STOP =A0 =A0 =A0 =A0 =A0 =A0 =A0 '0'
>> =A0#define W8001_CMD_START =A0 =A0 =A0 =A0 =A0 =A0 =A0'1'
>> =A0#define W8001_CMD_QUERY =A0 =A0 =A0 =A0 =A0 =A0 =A0'*'
>> =A0#define W8001_CMD_TOUCHQUERY '%'
>> @@ -279,24 +280,46 @@ static int w8001_setup(struct w8001 *w8001)
>> =A0 =A0 =A0 struct w8001_coord coord;
>> =A0 =A0 =A0 int error;
>>
>> - =A0 =A0 error =3D w8001_command(w8001, W8001_CMD_QUERY, true);
>> + =A0 =A0 error =3D w8001_command(w8001, W8001_CMD_STOP, false);
>
> Isn't there any response from the device to W8001_CMD_STOP?

No, there is no response. We just tell the device to set ready for
QUERY command.

>> =A0 =A0 =A0 if (error)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return error;
>>
>> - =A0 =A0 parse_data(w8001->response, &coord);
>> + =A0 =A0 mdelay(250); =A0 =A0/* wait 250ms before querying the devi=
ce */
>>
>> - =A0 =A0 input_set_abs_params(dev, ABS_X, 0, coord.x, 0, 0);
>> - =A0 =A0 input_set_abs_params(dev, ABS_Y, 0, coord.y, 0, 0);
>> - =A0 =A0 input_set_abs_params(dev, ABS_PRESSURE, 0, coord.pen_press=
ure, 0, 0);
>> - =A0 =A0 input_set_abs_params(dev, ABS_TILT_X, 0, coord.tilt_x, 0, =
0);
>> - =A0 =A0 input_set_abs_params(dev, ABS_TILT_Y, 0, coord.tilt_y, 0, =
0);
>> + =A0 =A0 /* penabled? */
>> + =A0 =A0 error =3D w8001_command(w8001, W8001_CMD_QUERY, true);
>> + =A0 =A0 if (!error) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev->keybit[BIT_WORD(BTN_TOOL_PEN)] |=3D B=
IT_MASK(BTN_TOOL_PEN);
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev->keybit[BIT_WORD(BTN_TOOL_RUBBER)] |=3D=
 BIT_MASK(BTN_TOOL_RUBBER);
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev->keybit[BIT_WORD(BTN_STYLUS)] |=3D BIT=
_MASK(BTN_STYLUS);
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev->keybit[BIT_WORD(BTN_STYLUS2)] |=3D BI=
T_MASK(BTN_STYLUS2);
>
> Could we start switching to __set_bit(BTN_TOOL_PEN, dev->keybit) styl=
e?

Sure, I'll make a new patch. I was following the existing code style
for consistency ......

> The original way was somewhat OK when setting several buttons at once
> but I feel __set_bit() form is much safer.
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 parse_data(w8001->response, &coord);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 input_set_abs_params(dev, ABS_X, 0, coord.=
x, 0, 0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 input_set_abs_params(dev, ABS_Y, 0, coord.=
y, 0, 0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 input_set_abs_params(dev, ABS_PRESSURE, 0,=
 coord.pen_pressure, 0, 0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (coord.tilt_x && coord.tilt_y)
>> + =A0 =A0 =A0 =A0 =A0 =A0 {
>
> Formatting: opening brace goes on the same as the statement.

Oops. I thought I've taken care of this already.

Thanks.

Ping

>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_set_abs_params(dev, =
ABS_TILT_X, 0, coord.tilt_x, 0, 0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_set_abs_params(dev, =
ABS_TILT_Y, 0, coord.tilt_y, 0, 0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 }
>>
>> + =A0 =A0 /* touch enabled? */
>> =A0 =A0 =A0 error =3D w8001_command(w8001, W8001_CMD_TOUCHQUERY, tru=
e);
>> - =A0 =A0 if (!error) {
>> +
>> + =A0 =A0 /* Some non-touch devices may reply to the touch query. Bu=
t their
>> + =A0 =A0 =A0* second byte is empty, which indicates touch is not su=
pported.
>> + =A0 =A0 =A0*/
>> + =A0 =A0 if (!error && w8001->response[1]) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct w8001_touch_query touch;
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 parse_touchquery(w8001->response, &touch=
);
>>
>> + =A0 =A0 =A0 =A0 =A0 =A0 input_set_abs_params(dev, ABS_X, 0, touch.=
x, 0, 0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 input_set_abs_params(dev, ABS_Y, 0, touch.=
y, 0, 0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev->keybit[BIT_WORD(BTN_TOOL_FINGER)] |=3D=
 BIT_MASK(BTN_TOOL_FINGER);
>> +
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 switch (touch.sensor_id) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 case 0:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 case 2:
>> --
>> 1.7.2.3
>>
>
> Thanks.
>
> --
> Dmitry
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
