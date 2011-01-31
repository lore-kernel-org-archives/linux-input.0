From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [PATCH v3] input : wacom_w8001 - report resolution to userland
Date: Mon, 31 Jan 2011 09:44:06 -0800
Message-ID: <AANLkTi=3hoFxhN6WSeHm3F8r5agzm_TMesZ-aVNRkyYi@mail.gmail.com>
References: <1296283062-20469-1-git-send-email-pinglinux@gmail.com>
	<20110131115014.GA5576@polaris.bitmath.org>
	<20110131172643.GC31891@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:63928 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753048Ab1AaRoI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 31 Jan 2011 12:44:08 -0500
Received: by wwi17 with SMTP id 17so3776680wwi.1
        for <linux-input@vger.kernel.org>; Mon, 31 Jan 2011 09:44:07 -0800 (PST)
In-Reply-To: <20110131172643.GC31891@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org, Ping Cheng <pingc@wacom.com>

On Mon, Jan 31, 2011 at 9:26 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Mon, Jan 31, 2011 at 12:50:14PM +0100, Henrik Rydberg wrote:
>> Hi Ping,
>>
>> On Fri, Jan 28, 2011 at 10:37:42PM -0800, Ping Cheng wrote:
>> > Serial devices send both pen and touch data through the same logic=
al
>> > port. Since we scaled touch to pen maximum, we use pen resolution
>> > for touch as well here.
>> >
>> > This is under the assumption that pen and touch share the same phy=
sical
>> > surface. In the case when a small physical dimensional difference =
occurs
>> > between pen and touch, we assume the tolerance for touch point pre=
cision
>> > is higher than pen and the difference is within touch point tolera=
nce.
>> >
>> > A per-MT tool based resolution mechanism should be introduced if t=
he
>> > above assumption does not hold true for the pen and touch devices =
any
>> > more. A good candidate to resolve this issue without introducing d=
esign
>> > change could be to report touch resolution through ABS_MT_POSITION=
_X/Y.
>>
>> This still sounds a bit like mixing apples and oranges. If this case
>> would ever happen, and I doubt it since the whole idea is to use
>> different tools on the same surface, then splitting into separate
>> devices would be appropriate.
>>
>> >
>> > This version corrected an oversimplified if statement in v2.
>> >
>> > Signed-off-by: Ping Cheng <pingc@wacom.com>
>> > ---
>>
>> > =A0drivers/input/touchscreen/wacom_w8001.c | =A0 20 ++++++++++++++=
+-----
>> > =A01 files changed, 15 insertions(+), 5 deletions(-)
>> >
>> > diff --git a/drivers/input/touchscreen/wacom_w8001.c b/drivers/inp=
ut/touchscreen/wacom_w8001.c
>> > index 5cb8449..68dcca0 100644
>> > --- a/drivers/input/touchscreen/wacom_w8001.c
>> > +++ b/drivers/input/touchscreen/wacom_w8001.c
>> > @@ -51,6 +51,10 @@ MODULE_LICENSE("GPL");
>> > =A0#define W8001_PKTLEN_TPCCTL =A0 =A0 =A0 =A011 =A0 =A0 =A0/* con=
trol packet */
>> > =A0#define W8001_PKTLEN_TOUCH2FG =A0 =A0 =A013
>> >
>> > +/* resolution in points/mm */
>> > +#define W8001_PEN_RESOLUTION =A0 =A0100
>> > +#define W8001_TOUCH_RESOLUTION =A010
>> > +
>> > =A0struct w8001_coord {
>> > =A0 =A0 u8 rdy;
>> > =A0 =A0 u8 tsw;
>> > @@ -198,7 +202,7 @@ static void parse_touchquery(u8 *data, struct =
w8001_touch_query *query)
>> > =A0 =A0 =A0 =A0 =A0 =A0 query->y =3D 1024;
>> > =A0 =A0 =A0 =A0 =A0 =A0 if (query->panel_res)
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 query->x =3D query->y =3D =
(1 << query->panel_res);
>> > - =A0 =A0 =A0 =A0 =A0 query->panel_res =3D 10;
>> > + =A0 =A0 =A0 =A0 =A0 query->panel_res =3D W8001_TOUCH_RESOLUTION;
>> > =A0 =A0 }
>> > =A0}
>> >
>> > @@ -394,6 +398,8 @@ static int w8001_setup(struct w8001 *w8001)
>> >
>> > =A0 =A0 =A0 =A0 =A0 =A0 input_set_abs_params(dev, ABS_X, 0, coord.=
x, 0, 0);
>> > =A0 =A0 =A0 =A0 =A0 =A0 input_set_abs_params(dev, ABS_Y, 0, coord.=
y, 0, 0);
>> > + =A0 =A0 =A0 =A0 =A0 input_abs_set_res(dev, ABS_X, W8001_PEN_RESO=
LUTION);
>> > + =A0 =A0 =A0 =A0 =A0 input_abs_set_res(dev, ABS_Y, W8001_PEN_RESO=
LUTION);
>> > =A0 =A0 =A0 =A0 =A0 =A0 input_set_abs_params(dev, ABS_PRESSURE, 0,=
 coord.pen_pressure, 0, 0);
>> > =A0 =A0 =A0 =A0 =A0 =A0 if (coord.tilt_x && coord.tilt_y) {
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_set_abs_params(dev, =
ABS_TILT_X, 0, coord.tilt_x, 0, 0);
>> > @@ -418,15 +424,19 @@ static int w8001_setup(struct w8001 *w8001)
>> > =A0 =A0 =A0 =A0 =A0 =A0 w8001->max_touch_x =3D touch.x;
>> > =A0 =A0 =A0 =A0 =A0 =A0 w8001->max_touch_y =3D touch.y;
>>
>> So max_touch is set here
>>
>> >
>> > - =A0 =A0 =A0 =A0 =A0 /* scale to pen maximum */
>> > + =A0 =A0 =A0 =A0 =A0 /* pen supported */
>> > =A0 =A0 =A0 =A0 =A0 =A0 if (w8001->max_pen_x && w8001->max_pen_y) =
{
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* scale to pen maximum */
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 touch.x =3D w8001->max_pen=
_x;
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 touch.y =3D w8001->max_pen=
_y;
>>
>> And possibly redefined here
>>
>> > + =A0 =A0 =A0 =A0 =A0 } else { /* touch only */
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* set axes with touch data =
*/
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_set_abs_params(dev, AB=
S_X, 0, touch.x, 0, 0);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_set_abs_params(dev, AB=
S_Y, 0, touch.y, 0, 0);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_abs_set_res(dev, ABS_X=
, touch.panel_res);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_abs_set_res(dev, ABS_Y=
, touch.panel_res);
>> > =A0 =A0 =A0 =A0 =A0 =A0 }
>> >
>> > - =A0 =A0 =A0 =A0 =A0 input_set_abs_params(dev, ABS_X, 0, touch.x,=
 0, 0);
>> > - =A0 =A0 =A0 =A0 =A0 input_set_abs_params(dev, ABS_Y, 0, touch.y,=
 0, 0);
>> > -
>> > =A0 =A0 =A0 =A0 =A0 =A0 switch (touch.sensor_id) {
>> > =A0 =A0 =A0 =A0 =A0 =A0 case 0:
>> > =A0 =A0 =A0 =A0 =A0 =A0 case 2:
>>
>> And then just used to set MT later on, which will lead to
>> ABS_MT_POSITION_X values different from ABS_X. This is just getting
>> messier. In fact, the whole setup function is messy, with unclear
>> handling of error paths. Any chance one could simplify the logic
>> involved here? It should be possible to use a single code path for
>> input_set_abs_params() and input_abs_set_res(), for instance.
>>
>
> I have the following for the resolution reporting:


It works for me. Although the end result is the same as the v3 since
params and res have already been set in pen response blok if pen is
supported, it is more straight forward in logical to anyone who tries
to understand the code.

Thank you, Dmitry.

Ping

> Input: wacom_w8001 - report resolution to userland
>
> From: Ping Cheng <pinglinux@gmail.com>
>
> Serial devices send both pen and touch data through the same logical
> port. Since we scaled touch to pen maximum, we use pen resolution
> for touch as well here.
>
> This is under the assumption that pen and touch share the same physic=
al
> surface. In the case when a small physical dimensional difference occ=
urs
> between pen and touch, we assume the tolerance for touch point precis=
ion
> is higher than pen and the difference is within touch point tolerance=
=2E
>
> A per-MT tool based resolution mechanism should be introduced if the
> above assumption does not hold true for the pen and touch devices any
> more.
>
> Signed-off-by: Ping Cheng <pingc@wacom.com>
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> ---
>
> =A0drivers/input/touchscreen/wacom_w8001.c | =A0 13 +++++++++++--
> =A01 files changed, 11 insertions(+), 2 deletions(-)
>
>
> diff --git a/drivers/input/touchscreen/wacom_w8001.c b/drivers/input/=
touchscreen/wacom_w8001.c
> index 5cb8449..c14412e 100644
> --- a/drivers/input/touchscreen/wacom_w8001.c
> +++ b/drivers/input/touchscreen/wacom_w8001.c
> @@ -51,6 +51,10 @@ MODULE_LICENSE("GPL");
> =A0#define W8001_PKTLEN_TPCCTL =A0 =A011 =A0 =A0 =A0/* control packet=
 */
> =A0#define W8001_PKTLEN_TOUCH2FG =A013
>
> +/* resolution in points/mm */
> +#define W8001_PEN_RESOLUTION =A0 =A0100
> +#define W8001_TOUCH_RESOLUTION =A010
> +
> =A0struct w8001_coord {
> =A0 =A0 =A0 =A0u8 rdy;
> =A0 =A0 =A0 =A0u8 tsw;
> @@ -198,7 +202,7 @@ static void parse_touchquery(u8 *data, struct w80=
01_touch_query *query)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0query->y =3D 1024;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (query->panel_res)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0query->x =3D query->y =
=3D (1 << query->panel_res);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 query->panel_res =3D 10;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 query->panel_res =3D W8001_TOUCH_RESOLU=
TION;
> =A0 =A0 =A0 =A0}
> =A0}
>
> @@ -394,6 +398,8 @@ static int w8001_setup(struct w8001 *w8001)
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_set_abs_params(dev, ABS_X, 0, co=
ord.x, 0, 0);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_set_abs_params(dev, ABS_Y, 0, co=
ord.y, 0, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_abs_set_res(dev, ABS_X, W8001_PEN=
_RESOLUTION);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_abs_set_res(dev, ABS_Y, W8001_PEN=
_RESOLUTION);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_set_abs_params(dev, ABS_PRESSURE=
, 0, coord.pen_pressure, 0, 0);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (coord.tilt_x && coord.tilt_y) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_set_abs_params(d=
ev, ABS_TILT_X, 0, coord.tilt_x, 0, 0);
> @@ -418,14 +424,17 @@ static int w8001_setup(struct w8001 *w8001)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0w8001->max_touch_x =3D touch.x;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0w8001->max_touch_y =3D touch.y;
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* scale to pen maximum */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (w8001->max_pen_x && w8001->max_pen=
_y) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* if pen is supported =
scale to pen maximum */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0touch.x =3D w8001->max=
_pen_x;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0touch.y =3D w8001->max=
_pen_y;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 touch.panel_res =3D W80=
01_PEN_RESOLUTION;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_set_abs_params(dev, ABS_X, 0, to=
uch.x, 0, 0);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_set_abs_params(dev, ABS_Y, 0, to=
uch.y, 0, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_abs_set_res(dev, ABS_X, touch.pan=
el_res);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_abs_set_res(dev, ABS_Y, touch.pan=
el_res);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0switch (touch.sensor_id) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case 0:
> --
> Dmitry
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
