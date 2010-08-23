From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [PATCH 3/3] input: add multitouch slot support to w8001.
Date: Mon, 23 Aug 2010 16:11:56 +0200
Message-ID: <AANLkTi=0dsqZg4kTujfzmspcDeoYHnbnGy9JN4y-OLhY@mail.gmail.com>
References: <1282280135-15942-1-git-send-email-peter.hutterer@who-t.net>
	<1282280135-15942-4-git-send-email-peter.hutterer@who-t.net>
	<4C722ECF.5020706@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:63808 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752708Ab0HWOL6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Aug 2010 10:11:58 -0400
In-Reply-To: <4C722ECF.5020706@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Peter Hutterer <peter.hutterer@who-t.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Aug 23, 2010 at 10:18 AM, Henrik Rydberg <rydberg@euromail.se> =
wrote:
> Hi Peter,
>
> thanks for the patches. Comments inline.
>
>> Some serial wacom devices support two-finger touch. Test for this du=
ring
>
>> init and parse the touch packets accordingly. Touch packets are
>> processed using Protocol B (MT Slots).
>>
>> Note: there are several wacom versions that do touch but not two-fin=
ger
>> touch. These are not catered for here, touch events for these are si=
mply
>> discarded.
>>
>> Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
>> CC: Henrik Rydberg <rydberg@euromail.se>
>> ---
>> =A0drivers/input/touchscreen/wacom_w8001.c | =A0 99 ++++++++++++++++=
++++++++++++++-
>> =A01 files changed, 96 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/input/touchscreen/wacom_w8001.c b/drivers/input=
/touchscreen/wacom_w8001.c
>> index c302cc3..a38a3aa 100644
>> --- a/drivers/input/touchscreen/wacom_w8001.c
>> +++ b/drivers/input/touchscreen/wacom_w8001.c
>> @@ -60,6 +60,17 @@ struct w8001_coord {
>> =A0 =A0 =A0 u8 tilt_y;
>> =A0};
>>
>> +/* touch data packet */
>> +struct w8001_touch {
>> + =A0 =A0 u8 f1_status;
>> + =A0 =A0 u16 f1_x;
>> + =A0 =A0 u16 f1_y;
>> + =A0 =A0 /* only some tablets have 2FG info */
>> + =A0 =A0 u8 f2_status;
>> + =A0 =A0 u16 f2_x;
>> + =A0 =A0 u16 f2_y;
>> +};
>
>
> No pressure information from this device?

No useful pressure/capacity available for this device.

>
>> +
>> =A0/* touch query reply packet */
>> =A0struct w8001_touch_query {
>> =A0 =A0 =A0 u8 panel_res;
>> @@ -85,8 +96,18 @@ struct w8001 {
>> =A0 =A0 =A0 char phys[32];
>> =A0 =A0 =A0 int type;
>> =A0 =A0 =A0 unsigned int pktlen;
>> + =A0 =A0 unsigned char tracking_id[2];
>> =A0};
>>
>> +static int get_next_tracking_id(void)
>> +{
>> + =A0 =A0 static unsigned char next_tracking_id;
>> + =A0 =A0 next_tracking_id =3D (next_tracking_id + 1) % 256;
>> + =A0 =A0 if (next_tracking_id =3D=3D 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 next_tracking_id =3D 1;
>> + =A0 =A0 return next_tracking_id;
>> +}
>
>
> Zero is part of the valid range from 2.6.36. Can be implemented simpl=
y as
> (tracking_id++ & 0xfff), see recent MT slots patches.
>
>> +
>> =A0static void parse_data(u8 *data, struct w8001_coord *coord)
>> =A0{
>> =A0 =A0 =A0 memset(coord, 0, sizeof(*coord));
>> @@ -111,6 +132,26 @@ static void parse_data(u8 *data, struct w8001_c=
oord *coord)
>> =A0 =A0 =A0 coord->tilt_y =3D data[8] & 0x7F;
>> =A0}
>>
>> +static void parse_touch(u8 *data,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int pktlen, struc=
t w8001_touch *touch)
>> +{
>> + =A0 =A0 memset(touch, 0, sizeof(*touch));
>> +
>> + =A0 =A0 touch->f1_status =3D data[0] & 0x1;
>> + =A0 =A0 touch->f1_x =3D data[1] << 7;
>> + =A0 =A0 touch->f1_x |=3D data[2];
>> + =A0 =A0 touch->f1_y =3D data[3] << 7;
>> + =A0 =A0 touch->f1_y |=3D data[4];
>
>
> What are data[5] and data[6]? Why is f1_x/y split into several lines?
>
>> +
>> + =A0 =A0 if (pktlen >=3D W8001_PKTLEN_TOUCH2FG) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 touch->f2_status =3D (data[0] & 0x2) >> 1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 touch->f2_x =3D data[7] << 7;
>> + =A0 =A0 =A0 =A0 =A0 =A0 touch->f2_x |=3D data[8];
>> + =A0 =A0 =A0 =A0 =A0 =A0 touch->f2_y =3D data[9] << 7;
>> + =A0 =A0 =A0 =A0 =A0 =A0 touch->f2_y |=3D data[10];
>> + =A0 =A0 }
>
>
> What are data[11] and data[12]?
>
> Since all needed information is available here, there seems to be lit=
tle reason
> for the w8001_touch structure. Why not complete the report in this fu=
nction?
>
>> +}
>> +
>> =A0static void parse_touchquery(u8 *data, struct w8001_touch_query *=
query)
>> =A0{
>> =A0 =A0 =A0 memset(query, 0, sizeof(*query));
>> @@ -128,6 +169,46 @@ static void parse_touchquery(u8 *data, struct w=
8001_touch_query *query)
>> =A0 =A0 =A0 query->y |=3D (data[2] >> 3) & 0x3;
>> =A0}
>>
>> +static void w8001_mt_event(struct input_dev *dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int slot, int tid, =
int x, int y)
>> +{
>> + =A0 =A0 input_mt_slot(dev, slot);
>> + =A0 =A0 if (tid !=3D 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(dev, ABS_MT_POSITION_X, x=
);
>> + =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(dev, ABS_MT_POSITION_Y, y=
);
>> + =A0 =A0 }
>> + =A0 =A0 input_report_abs(dev, ABS_MT_TRACKING_ID, tid);
>> + =A0 =A0 input_report_abs(dev, ABS_MT_TOOL_TYPE, MT_TOOL_FINGER);
>> + =A0 =A0 input_mt_sync(dev);
>> +}
>
>> +
>> +static void w8001_track_fingers(struct w8001 *w8001, struct w8001_t=
ouch *touch)
>> +{
>> + =A0 =A0 struct input_dev *dev =3D w8001->dev;
>> +
>> + =A0 =A0 if (touch->f1_status) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!w8001->tracking_id[0])
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 w8001->tracking_id[0] =3D =
get_next_tracking_id();
>> + =A0 =A0 =A0 =A0 =A0 =A0 w8001_mt_event(dev, 0, w8001->tracking_id[=
0],
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0touch->f1_x=
, touch->f1_y);
>> + =A0 =A0 } else if (w8001->tracking_id[0]) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 w8001->tracking_id[0] =3D 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 w8001_mt_event(dev, 0, 0, touch->f1_x, tou=
ch->f1_y);
>> + =A0 =A0 }
>
>> +
>> + =A0 =A0 if (touch->f2_status) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!w8001->tracking_id[1])
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 w8001->tracking_id[1] =3D =
get_next_tracking_id();
>> + =A0 =A0 =A0 =A0 =A0 =A0 w8001_mt_event(dev, 1, w8001->tracking_id[=
1],
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0touch->f2_x=
, touch->f2_y);
>> + =A0 =A0 } else if (w8001->tracking_id[1]) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 w8001->tracking_id[1] =3D 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 w8001_mt_event(dev, 1, 0, touch->f2_x, tou=
ch->f2_y);
>> + =A0 =A0 }
>> +
>> + =A0 =A0 input_sync(dev);
>> +}
>
>
> Apparently, f1 and f2 represent the slots themselves, i.e., the devic=
e uses
> slots internally. Please simplify the logic accordingly. There is an =
example in
> the recent patch for the Bamboo Touch.
>
>> +
>> =A0static void report_pen_events(struct w8001 *w8001, struct w8001_c=
oord *coord)
>> =A0{
>> =A0 =A0 =A0 struct input_dev *dev =3D w8001->dev;
>> @@ -172,6 +253,7 @@ static irqreturn_t w8001_interrupt(struct serio =
*serio,
>> =A0{
>> =A0 =A0 =A0 struct w8001 *w8001 =3D serio_get_drvdata(serio);
>> =A0 =A0 =A0 struct w8001_coord coord;
>> + =A0 =A0 struct w8001_touch touch;
>> =A0 =A0 =A0 unsigned char tmp;
>>
>> =A0 =A0 =A0 w8001->data[w8001->idx] =3D data;
>> @@ -217,10 +299,11 @@ static irqreturn_t w8001_interrupt(struct seri=
o *serio,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 complete(&w8001->cmd_done);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>>
>> + =A0 =A0 /* 2 finger touch packet */
>> =A0 =A0 =A0 case W8001_PKTLEN_TOUCH2FG - 1:
>> - =A0 =A0 =A0 =A0 =A0 =A0 /* ignore two-finger touch packet. */
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (w8001->pktlen =3D=3D w8001->idx)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 w8001->idx =3D 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 w8001->idx =3D 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 parse_touch(w8001->data, w8001->pktlen, &t=
ouch);
>> + =A0 =A0 =A0 =A0 =A0 =A0 w8001_track_fingers(w8001, &touch);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> =A0 =A0 =A0 }
>>
>> @@ -282,6 +365,16 @@ static int w8001_setup(struct w8001 *w8001)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 case 5:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 w8001->pktlen =3D W8001_=
PKTLEN_TOUCH2FG;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_mt_create_slots(dev,=
 2);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_set_abs_params(dev, =
ABS_MT_TRACKING_ID,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 0, 255, 0, 0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_set_abs_params(dev, =
ABS_MT_POSITION_X,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 0, touch.x, 0, 0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_set_abs_params(dev, =
ABS_MT_POSITION_Y,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 0, touch.y, 0, 0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_set_abs_params(dev, =
ABS_MT_TOOL_TYPE,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 0, 0, 0, 0);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 }
>
>
> No information about signal-to-noise ratio (fuzz) for this device?

No.

Ping
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
