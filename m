From: =?UTF-8?B?5buW5bSH5qau?= <kt.liao@emc.com.tw>
Subject: RE: [PATCH] Input: Change BTN_TOOL_FINGER flag when hover event trigger
Date: Mon, 23 May 2016 22:28:59 +0800
Message-ID: <000001d1b4ff$71ee0720$55ca1560$@emc.com.tw>
References: <C2DEC699-8A1A-484D-83F2-637F5EF94C7B@emc.com.tw> <006901d1acea$8207d090$861771b0$@emc.com.tw> <00be01d1af65$ec37c290$c4a747b0$@emc.com.tw> <20160516175342.GD12752@dtor-ws> <00c901d1b047$4a2d3ba0$de87b2e0$@emc.com.tw> <20160520005137.GA39923@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160520005137.GA39923@dtor-ws>
Content-Language: zh-tw
Sender: linux-kernel-owner@vger.kernel.org
To: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, zac.hsieh@emc.com.tw, =?UTF-8?B?J+m7g+S4lum1rCDntpPnkIYn?= <phoenix@emc.com.tw>, 'Charles Mooney' <charliemooney@google.com>, 'Agnes Cheng' <agnescheng@google.com>, 'jeff' <jeff.chuang@emc.com.tw>
List-Id: linux-input@vger.kernel.org

Hi Dmitry,

Thanks for your confirmation.

I think the best and simplest way is to add below code to emit BTN_TOOL=
_FINGER if hover condition meets.

input_report_key(dev, BTN_TOOL_FINGER, input_mt_get_value(dev, ABS_DIST=
ANCE));

Is it ok for you?

	if (use_count) {
		if (count =3D=3D 0 &&
		    !test_bit(ABS_MT_DISTANCE, dev->absbit) &&
		    test_bit(ABS_DISTANCE, dev->absbit) &&
		    input_abs_get_val(dev, ABS_DISTANCE) !=3D 0) {

			/* Emit BTN_TOOL_FINGER*/
			input_report_key(dev, BTN_TOOL_FINGER, input_mt_get_value(dev, ABS_D=
ISTANCE));

			count =3D 1;
		}

B.R  KT
-----Original Message-----
=46rom: 'Dmitry Torokhov' [mailto:dmitry.torokhov@gmail.com]=20
Sent: Friday, May 20, 2016 8:52 AM
To: =E5=BB=96=E5=B4=87=E6=A6=AE
Cc: linux-input@vger.kernel.org; linux-kernel@vger.kernel.org; zac.hsie=
h@emc.com.tw; '=E9=BB=83=E4=B8=96=E9=B5=AC =E7=B6=93=E7=90=86'; 'Charle=
s Mooney'; 'Agnes Cheng'; 'jeff'
Subject: Re: [PATCH] Input: Change BTN_TOOL_FINGER flag when hover even=
t trigger

On Tue, May 17, 2016 at 10:20:40PM +0800, =E5=BB=96=E5=B4=87=E6=A6=AE w=
rote:
> Hi Dmitry,
>=20
> I want to confirm my thought for your idea to avoid misunderstanding.
> I think you want to encapsulate " BTN_TOOL_FINGER" in the [input_mt_r=
eport_pointer_emulation] if hover happen.
> Vendor driver only report "ABS_DISTANCE" and let [input_mt_report_poi=
nter_emulation] emit BTN_TOOL_FINGER report without change function par=
ameter.
>=20
> Please let me know if my misunderstand about your idea.

Yes, that is correct. Something like this:

diff --git a/drivers/input/input-mt.c b/drivers/input/input-mt.c index =
54fce56..a1bbec9 100644
--- a/drivers/input/input-mt.c
+++ b/drivers/input/input-mt.c
@@ -218,8 +218,23 @@ void input_mt_report_pointer_emulation(struct inpu=
t_dev *dev, bool use_count)
 	}
=20
 	input_event(dev, EV_KEY, BTN_TOUCH, count > 0);
-	if (use_count)
+
+	if (use_count) {
+		if (count =3D=3D 0 &&
+		    !test_bit(ABS_MT_DISTANCE, dev->absbit) &&
+		    test_bit(ABS_DISTANCE, dev->absbit) &&
+		    input_abs_get_val(dev, ABS_DISTANCE) !=3D 0) {
+			/*
+			 * Force reporting BTN_TOOL_FINGER for devices that
+			 * only report general hover (and not per-contact
+			 * distance) when contact is in proximity but not
+			 * on the surface.
+			 */
+			count =3D 1;
+		}
+
 		input_mt_report_finger_count(dev, count);
+	}
=20
 	if (oldest) {
 		int x =3D input_mt_get_value(oldest, ABS_MT_POSITION_X);
