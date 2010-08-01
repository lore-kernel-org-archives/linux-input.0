From: =?ISO-8859-1?Q?=C9ric_Piel?= <E.A.B.Piel@tudelft.nl>
Subject: Re: [PATCH 7/7] elantech: average the two coordinates when 2 fingers
Date: Sun, 01 Aug 2010 13:28:04 +0200
Message-ID: <4C555A44.5050505@tudelft.nl>
References: <4C1FD2B0.1080504@tudelft.nl>	<4C1FD454.4050807@tudelft.nl>	<20100721033655.GA9070@core.coreip.homeip.net>	<4C532009.4020103@tudelft.nl>	<4C533DC3.9070001@euromail.se> <AANLkTi=cEEx-5eQPbRYvMMaECvXKQ+i-e0Eaw_g4JY7=@mail.gmail.com> <4C54ABFE.8050106@tudelft.nl> <4C554058.6080203@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailservice.tudelft.nl ([130.161.131.5]:35776 "EHLO
	mailservice.tudelft.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751921Ab0HAL2B (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 1 Aug 2010 07:28:01 -0400
In-Reply-To: <4C554058.6080203@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Chris Bagwell <chris@cnpbagwell.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Florian Ragwitz <rafl@debian.org>

Op 01-08-10 11:37, Henrik Rydberg schreef:
> On 08/01/2010 01:04 AM, =C9ric Piel wrote:
>=20
> [...]
>=20
>> I've got some fairly new versions of everything, but at least here, =
this
>> is already happening with the X synaptics driver: in practice there =
is
>> not jump at all, which ever finger is reported in doubletap. In
>> doubletap it moves the scrolling axes, and changing to singletap, it
>> resets to the new current position. No jump, both with my old synapt=
ics
>> hardware and with the elantech.
>=20
>=20
> You are right. Jumping does not generally occur in synaptics when the=
 number of
> fingers changes.
>=20
> The overall solution is still not quite satisfactory, since the MT po=
ints
> reported are the lower-left and upper-right corners of a rectangle, i=
nstead of
> the actual touch points. As mentioned in another mail, it would make =
sense to
> add logic to bring this device up to the type A level. If the needed =
logic turns
> out to be equivalent to the type B level, what can you do. :-)
>=20
> How about this as a stab at the MT point problem. The idea here is th=
at
> get_corner_id() returns the rectangle corner which minimizes the chan=
ge in
> motion direction, according to the principle of inertia. For all case=
s,
> position[0] is reported as the ABS_X/Y point.
>=20
> state =3D (num_finger, corner_id, motion_id, position[n])
>=20
> At each touch frame update, do
>=20
> 1. num_finger =3D=3D 1
>=20
> Set
>   position[0] =3D finger-position
>=20
> 2. num_finger =3D=3D 2
>=20
> If last frame was one finger, do
>   Find corner id such that position change is minimized
>     id =3D get_initial_corner_id(position[0], corner-position[id])
>=20
> Else
>   Find temporary motion id
>     mid =3D get_motion_id(position[0], corner-position[corner_id])
>   Find corner id such that motion change is minimized
>     id =3D get_corner_id(corner_id, motion_id, mid)
>=20
> Set
>   corner_id =3D id
>   motion_id =3D get_motion_id(position[0], corner-position[id])
>   position[0] =3D corner-position[id],
>   position[1] =3D corner-position[opposite[id]]
>=20
> Report position[0] and position[1] as MT points
>=20
> Since this is all integer logic, it should be possible to detect moti=
on changes
> as sign changes, such that get_motion_id() and get_corner_id() can be
> implemented as constant arrays.
Hi, I've tried, with a simplified version, and it works!

Basically, I track both coordinates independently, as the rectangle
coordinates are independent anyway. Then I associate to position[0]
always the closest coordinates compared to the previous frame.

It works pretty fine. At least it avoid the jump between one and two
fingers. Of course, when the two fingers become horizontally or
vertically aligned (eg: in a rotation gesture), it's not possible to
differentiate anymore when they dis-align. And I don't think using moti=
on
will help because the hardware tends to report _exactly_ the same value
as soon the two fingers become close (=3D a segment instead of a
rectangle).  Or motion tracking would require a long window of past
frames.

I still think that for the very specific use case of scrolling when
pressing one finger and moving up and dow the other one, reporting the
average works better than the first finger. However, I guess this can b=
e
considered just as a drawback of the ST protocol, and fixed in userspac=
e
by using the MT protocol.

What do you think? Does it look fine to you? Below is the code.

Eric


8<--------------------------------------------------------------------
The elantech hardware is limited when reporting two fingers. It just
reports the minimum and maximum coordinates of the rectangle containing
the fingers.

As multitouch protocol requires at least to report the correct position
of each finger, we track the finger position when there is only one
finger to distinguish which corner of the rectangle corresponds to the
actual position of the fingers. When there are three fingers, only the
minimum position is reported, so we just don't track it and hope the
last tracked position has the most likelihood to be correct.

It works fine, at least as long as the two fingers don't get
horizontally or vertically aligned, after what it's back to random.
This also allows to avoid so "jumps" in the single-touch protocol.

Signed-off-by: =C9ric Piel <eric.piel@tremplin-utc.net>
---
 drivers/input/mouse/elantech.c |   51 ++++++++++++++++++++++++++++++++=
--------
 drivers/input/mouse/elantech.h |    2 +
 2 files changed, 43 insertions(+), 10 deletions(-)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elant=
ech.c
index bb66ae8..a3a3d8d 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -242,6 +242,33 @@ static void elantech_report_absolute_v1(struct psm=
ouse *psmouse)
 	input_sync(dev);
 }
=20
+
+static void track_one_finger(struct elantech_data *etd, int x, int y)
+{
+	etd->prev_x =3D x;
+	etd->prev_y =3D y;
+}
+
+static void find_closest_and_swap(int *ref, int *a, int *b)
+{
+	int diff_a =3D abs(*ref - *a);
+	int diff_b =3D abs(*ref - *b);
+	int tmp;
+	if (diff_b < diff_a) {
+		tmp =3D *a;
+		*a =3D *b;
+		*b =3D tmp;
+	}
+	*ref =3D *a;
+}
+
+static void track_two_fingers(struct elantech_data *etd, int *x1, int =
*y1, int *x2, int *y2)
+{
+	find_closest_and_swap(&etd->prev_x, x1, x2);
+	find_closest_and_swap(&etd->prev_y, y1, y2);
+}
+
+
 /*
  * Interpret complete data packets and report absolute mode input even=
ts for
  * hardware version 2. (6 byte packets)
@@ -284,6 +311,8 @@ static void elantech_report_absolute_v2(struct psmo=
use *psmouse)
=20
 		input_report_abs(dev, ABS_X, x1);
 		input_report_abs(dev, ABS_Y, y1);
+		if (fingers =3D=3D 1)
+			track_one_finger(etd, x1, y1);
=20
 		pres =3D (packet[1] & 0xf0) | ((packet[4] & 0xf0) >> 4);
 		width =3D ((packet[0] & 0x30) >> 2) | ((packet[3] & 0x30) >> 4);
@@ -296,29 +325,31 @@ static void elantech_report_absolute_v2(struct ps=
mouse *psmouse)
 		 * byte 0:  .   .  ay8 ax8  .   .   .   .
 		 * byte 1: ax7 ax6 ax5 ax4 ax3 ax2 ax1 ax0
 		 */
-		x1 =3D ((packet[0] & 0x10) << 4) | packet[1];
+		x1 =3D (((packet[0] & 0x10) << 4) | packet[1]) << 2;
 		/* byte 2: ay7 ay6 ay5 ay4 ay3 ay2 ay1 ay0 */
-		y1 =3D ETP_2FT_YMAX - (((packet[0] & 0x20) << 3) | packet[2]);
+		y1 =3D (ETP_2FT_YMAX - (((packet[0] & 0x20) << 3) | packet[2])) << 2=
;
 		/*
 		 * byte 3:  .   .  by8 bx8  .   .   .   .
 		 * byte 4: bx7 bx6 bx5 bx4 bx3 bx2 bx1 bx0
 		 */
-		x2 =3D ((packet[3] & 0x10) << 4) | packet[4];
+		x2 =3D (((packet[3] & 0x10) << 4) | packet[4]) << 2;
 		/* byte 5: by7 by8 by5 by4 by3 by2 by1 by0 */
-		y2 =3D ETP_2FT_YMAX - (((packet[3] & 0x20) << 3) | packet[5]);
+		y2 =3D (ETP_2FT_YMAX - (((packet[3] & 0x20) << 3) | packet[5])) << 2=
;
+
+		track_two_fingers(etd, &x1, &y1, &x2, &y2);
 		/* Multitouch */
-		input_report_abs(dev, ABS_MT_POSITION_X, x1 << 2);
-		input_report_abs(dev, ABS_MT_POSITION_Y, y1 << 2);
+		input_report_abs(dev, ABS_MT_POSITION_X, x1);
+		input_report_abs(dev, ABS_MT_POSITION_Y, y1);
 		input_mt_sync(dev);
-		input_report_abs(dev, ABS_MT_POSITION_X, x2 << 2);
-		input_report_abs(dev, ABS_MT_POSITION_Y, y2 << 2);
+		input_report_abs(dev, ABS_MT_POSITION_X, x2);
+		input_report_abs(dev, ABS_MT_POSITION_Y, y2);
 		input_mt_sync(dev);
 		/*
 		 * For compatibility with non-multitouch userspace apps
 		 * report the average of both coordinates and scale up.
 		 */
-		input_report_abs(dev, ABS_X, (x1 + x2) << 1);
-		input_report_abs(dev, ABS_Y, (y1 + y2) << 1);
+		input_report_abs(dev, ABS_X, (x1 + x2) >> 1);
+		input_report_abs(dev, ABS_Y, (y1 + y2) >> 1);
 		/*
 		 * For compatibility with the proprietary X Elantech driver
 		 * report both coordinates as hat coordinates
diff --git a/drivers/input/mouse/elantech.h b/drivers/input/mouse/elant=
ech.h
index f6e3be5..fa9a6b4 100644
--- a/drivers/input/mouse/elantech.h
+++ b/drivers/input/mouse/elantech.h
@@ -111,6 +111,8 @@ struct elantech_data {
 	unsigned char hw_version;
 	unsigned int  fw_version;
 	unsigned char parity[256];
+	unsigned int prev_x;
+	unsigned int prev_y;
 };
=20
 enum paritycheck_types {
--=20
1.7.2.1



--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
