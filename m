From: =?UTF-8?B?5buW5bSH5qau?= <kt.liao@emc.com.tw>
Subject: [PATCH] Emit BTN_TOO_FINGER in function input_mt_report_pointer_emulation if touchpad meets hover condition
Date: Wed, 25 May 2016 19:44:57 +0800
Message-ID: <003101d1b67a$dce6e5c0$96b4b140$@emc.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0032_01D1B6BD.EB0A9AF0"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from emcscan.emc.com.tw ([192.72.220.5]:44585 "EHLO
	emcscan.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753510AbcEYLpB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 25 May 2016 07:45:01 -0400
Content-Language: zh-tw
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, zac.hsieh@emc.com.tw, =?UTF-8?B?J+m7g+S4lum1rCDntpPnkIYn?= <phoenix@emc.com.tw>, 'Charles Mooney' <charliemooney@google.com>, 'Agnes Cheng' <agnescheng@google.com>, 'jeff' <jeff.chuang@emc.com.tw>

This is a multipart message in MIME format.

------=_NextPart_000_0032_01D1B6BD.EB0A9AF0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,

Update /input/mouse/input-mt.c
Emit BTN_TOO_FINGER in input_mt_report_pointer_emulation if touchpad =
meets hover condition.

Thanks & BR	KT

-----Original Message-----
From: 'Dmitry Torokhov' [mailto:dmitry.torokhov@gmail.com]=20
Sent: Friday, May 20, 2016 8:52 AM
To: =E5=BB=96=E5=B4=87=E6=A6=AE
Cc: linux-input@vger.kernel.org; linux-kernel@vger.kernel.org; =
zac.hsieh@emc.com.tw; '=E9=BB=83=E4=B8=96=E9=B5=AC =E7=B6=93=E7=90=86'; =
'Charles Mooney'; 'Agnes Cheng'; 'jeff'
Subject: Re: [PATCH] Input: Change BTN_TOOL_FINGER flag when hover event =
trigger

On Tue, May 17, 2016 at 10:20:40PM +0800, =E5=BB=96=E5=B4=87=E6=A6=AE =
wrote:
> Hi Dmitry,
>=20
> I want to confirm my thought for your idea to avoid misunderstanding.
> I think you want to encapsulate " BTN_TOOL_FINGER" in the =
[input_mt_report_pointer_emulation] if hover happen.
> Vendor driver only report "ABS_DISTANCE" and let =
[input_mt_report_pointer_emulation] emit BTN_TOOL_FINGER report without =
change function parameter.
>=20
> Please let me know if my misunderstand about your idea.

Yes, that is correct. Something like this:

diff --git a/drivers/input/input-mt.c b/drivers/input/input-mt.c index =
54fce56..a1bbec9 100644
--- a/drivers/input/input-mt.c
+++ b/drivers/input/input-mt.c
@@ -218,8 +218,23 @@ void input_mt_report_pointer_emulation(struct =
input_dev *dev, bool use_count)
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

--
Dmitry

------=_NextPart_000_0032_01D1B6BD.EB0A9AF0
Content-Type: application/octet-stream;
	name="0001-Input-drivers-input-input-mt.c.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-Input-drivers-input-input-mt.c.patch"

>From 6097f617de49db3592322da66253a1b88090d157 Mon Sep 17 00:00:00 2001=0A=
From: KT Liao <kt.liao@emc.com.tw>=0A=
Date: Wed, 25 May 2016 15:52:09 +0800=0A=
Subject: [PATCH] Input: drivers/input/input-mt.c Emit BTN_TOO_FINGER in=0A=
 function input_mt_report_pointer_emulation if touchpad meets hover =
condition=0A=
 Signed-off-by: KT Liao <kt.liao@emc.com.tw>=0A=
=0A=
---=0A=
 drivers/input/input-mt.c | 13 +++++++++++--=0A=
 1 file changed, 11 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/drivers/input/input-mt.c b/drivers/input/input-mt.c=0A=
index 54fce56..486b1ca 100644=0A=
--- a/drivers/input/input-mt.c=0A=
+++ b/drivers/input/input-mt.c=0A=
@@ -218,8 +218,17 @@ void input_mt_report_pointer_emulation(struct =
input_dev *dev, bool use_count)=0A=
 	}=0A=
 =0A=
 	input_event(dev, EV_KEY, BTN_TOUCH, count > 0);=0A=
-	if (use_count)=0A=
-		input_mt_report_finger_count(dev, count);=0A=
+=0A=
+	if (use_count) {=0A=
+		if (count =3D=3D 0 &&=0A=
+		    !test_bit(ABS_MT_DISTANCE, dev->absbit) &&=0A=
+		    test_bit(ABS_DISTANCE, dev->absbit) &&=0A=
+		    input_abs_get_val(dev, ABS_DISTANCE) !=3D 0) {=0A=
+			input_report_key(dev, BTN_TOOL_FINGER, input_abs_get_val(dev, =
ABS_DISTANCE));=0A=
+			count =3D 1;=0A=
+		}=0A=
+ 		input_mt_report_finger_count(dev, count);=0A=
+	}=0A=
 =0A=
 	if (oldest) {=0A=
 		int x =3D input_mt_get_value(oldest, ABS_MT_POSITION_X);=0A=
-- =0A=
2.7.4=0A=
=0A=

------=_NextPart_000_0032_01D1B6BD.EB0A9AF0--

