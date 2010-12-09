From: Chris Bagwell <chris@cnpbagwell.com>
Subject: Re: [PATCH 1/2]input - wacom_w8001: Support pen or touch only devices
Date: Thu, 9 Dec 2010 08:51:16 -0600
Message-ID: <AANLkTinG++maK+VLS9qHJMyGEfwsTiYex08KftG0cbbO@mail.gmail.com>
References: <1291857433-13731-1-git-send-email-pinglinux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:37288 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753911Ab0LIOvR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 9 Dec 2010 09:51:17 -0500
Received: by yxt3 with SMTP id 3so1393131yxt.19
        for <linux-input@vger.kernel.org>; Thu, 09 Dec 2010 06:51:17 -0800 (PST)
In-Reply-To: <1291857433-13731-1-git-send-email-pinglinux@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, Ping Cheng <pingc@wacom.com>

Hi Ping,

On Wed, Dec 8, 2010 at 7:17 PM, Ping Cheng <pinglinux@gmail.com> wrote:
> Not all penabled devices support touch. The same idea is true for
> touch devices. Setting up the devices according to the specific
> querying results.
>
> Signed-off-by: Ping Cheng <pingc@wacom.com>
> ---
> =A0drivers/input/touchscreen/wacom_w8001.c | =A0 39 +++++++++++++++++=
+++++++------
> =A01 files changed, 31 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/input/touchscreen/wacom_w8001.c b/drivers/input/=
touchscreen/wacom_w8001.c
> index 361d00a..90b92e8 100644
> --- a/drivers/input/touchscreen/wacom_w8001.c
> +++ b/drivers/input/touchscreen/wacom_w8001.c
> @@ -37,6 +37,7 @@ MODULE_LICENSE("GPL");
>
> =A0#define W8001_QUERY_PACKET =A0 =A0 0x20
>
> +#define W8001_CMD_STOP =A0 =A0 =A0 =A0 '0'
> =A0#define W8001_CMD_START =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0'1'
> =A0#define W8001_CMD_QUERY =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0'*'
> =A0#define W8001_CMD_TOUCHQUERY =A0 '%'
> @@ -279,24 +280,46 @@ static int w8001_setup(struct w8001 *w8001)
> =A0 =A0 =A0 =A0struct w8001_coord coord;
> =A0 =A0 =A0 =A0int error;
>
> - =A0 =A0 =A0 error =3D w8001_command(w8001, W8001_CMD_QUERY, true);
> + =A0 =A0 =A0 error =3D w8001_command(w8001, W8001_CMD_STOP, false);
> =A0 =A0 =A0 =A0if (error)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return error;
>
> - =A0 =A0 =A0 parse_data(w8001->response, &coord);
> + =A0 =A0 =A0 mdelay(250); =A0 =A0/* wait 250ms before querying the d=
evice */
>
> - =A0 =A0 =A0 input_set_abs_params(dev, ABS_X, 0, coord.x, 0, 0);
> - =A0 =A0 =A0 input_set_abs_params(dev, ABS_Y, 0, coord.y, 0, 0);
> - =A0 =A0 =A0 input_set_abs_params(dev, ABS_PRESSURE, 0, coord.pen_pr=
essure, 0, 0);
> - =A0 =A0 =A0 input_set_abs_params(dev, ABS_TILT_X, 0, coord.tilt_x, =
0, 0);
> - =A0 =A0 =A0 input_set_abs_params(dev, ABS_TILT_Y, 0, coord.tilt_y, =
0, 0);
> + =A0 =A0 =A0 /* penabled? */
> + =A0 =A0 =A0 error =3D w8001_command(w8001, W8001_CMD_QUERY, true);
> + =A0 =A0 =A0 if (!error) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->keybit[BIT_WORD(BTN_TOOL_PEN)] |=3D=
 BIT_MASK(BTN_TOOL_PEN);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->keybit[BIT_WORD(BTN_TOOL_RUBBER)] =
|=3D BIT_MASK(BTN_TOOL_RUBBER);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->keybit[BIT_WORD(BTN_STYLUS)] |=3D =
BIT_MASK(BTN_STYLUS);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->keybit[BIT_WORD(BTN_STYLUS2)] |=3D=
 BIT_MASK(BTN_STYLUS2);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 parse_data(w8001->response, &coord);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_set_abs_params(dev, ABS_X, 0, coo=
rd.x, 0, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_set_abs_params(dev, ABS_Y, 0, coo=
rd.y, 0, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_set_abs_params(dev, ABS_PRESSURE,=
 0, coord.pen_pressure, 0, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (coord.tilt_x && coord.tilt_y)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_set_abs_params(de=
v, ABS_TILT_X, 0, coord.tilt_x, 0, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_set_abs_params(de=
v, ABS_TILT_Y, 0, coord.tilt_y, 0, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
>
> + =A0 =A0 =A0 /* touch enabled? */
> =A0 =A0 =A0 =A0error =3D w8001_command(w8001, W8001_CMD_TOUCHQUERY, t=
rue);
> - =A0 =A0 =A0 if (!error) {
> +
> + =A0 =A0 =A0 /* Some non-touch devices may reply to the touch query.=
 But their
> + =A0 =A0 =A0 =A0* second byte is empty, which indicates touch is not=
 supported.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (!error && w8001->response[1]) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct w8001_touch_query touch;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0parse_touchquery(w8001->response, &tou=
ch);
>
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_set_abs_params(dev, ABS_X, 0, tou=
ch.x, 0, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_set_abs_params(dev, ABS_Y, 0, tou=
ch.y, 0, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->keybit[BIT_WORD(BTN_TOOL_FINGER)] =
|=3D BIT_MASK(BTN_TOOL_FINGER);

Sorry for such basic questions: Is this an either/or thing?  Is it
either pen or touch device?  Is the answer different for single vs. 2
touch devices?  Doesn't this create a single input device?

If it can be combo on single input then it looks like it overrides its
shared events.  Probably the easiest solution is to normalize to
single range... and I'd think that pen is higher resolution then touch
so I'd put this logic before pen logic so pens resolution wins in
combo case.

Shouldn't this also be disabling the MT events as well when touch
isn't supported?

Chris

> +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0switch (touch.sensor_id) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case 0:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case 2:
> --
> 1.7.2.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
