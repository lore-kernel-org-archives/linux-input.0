From: Tim Schumacher <timschumi@gmx.de>
Subject: [PATCH resend] Input: iforce - Add the Saitek R440 Force Wheel
Date: Wed, 12 Jun 2019 16:09:03 +0200
Message-ID: <20190612140903.20058-1-timschumi@gmx.de>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com, timschumi@gmx.de
List-Id: linux-input@vger.kernel.org

Signed-off-by: Tim Schumacher <timschumi@gmx.de>
=2D--
Please note that I do NOT own this device.

I'm adding this based on the fact that this is an iforce-based
device and that the Windows driver for the R440 works for the
Logitech WingMan Formula Force after replacing the device/vendor
IDs (I got the vendor/device IDs from there as well).

Please don't add this patch if adding devices based on that is
not ok.

This patch is a resend of the patch I sent back in November,
which apparently went unnoticed.
=2D--
 drivers/input/joystick/iforce/iforce-main.c | 1 +
 drivers/input/joystick/iforce/iforce-usb.c  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/input/joystick/iforce/iforce-main.c b/drivers/input/j=
oystick/iforce/iforce-main.c
index 55f5b7bb4cac..e000e7d5b4c1 100644
=2D-- a/drivers/input/joystick/iforce/iforce-main.c
+++ b/drivers/input/joystick/iforce/iforce-main.c
@@ -55,6 +55,7 @@ static struct iforce_device iforce_device[] =3D {
 	{ 0x05ef, 0x8888, "AVB Top Shot Force Feedback Racing Wheel",	btn_wheel,=
 abs_wheel, ff_iforce }, //?
 	{ 0x061c, 0xc0a4, "ACT LABS Force RS",                          btn_whee=
l, abs_wheel, ff_iforce }, //?
 	{ 0x061c, 0xc084, "ACT LABS Force RS",				btn_wheel, abs_wheel, ff_iforc=
e },
+	{ 0x06a3, 0xff04, "Saitek R440 Force Wheel",			btn_wheel, abs_wheel, ff_=
iforce }, //?
 	{ 0x06f8, 0x0001, "Guillemot Race Leader Force Feedback",	btn_wheel, abs=
_wheel, ff_iforce }, //?
 	{ 0x06f8, 0x0001, "Guillemot Jet Leader Force Feedback",	btn_joystick, a=
bs_joystick_rudder, ff_iforce },
 	{ 0x06f8, 0x0004, "Guillemot Force Feedback Racing Wheel",	btn_wheel, ab=
s_wheel, ff_iforce }, //?
diff --git a/drivers/input/joystick/iforce/iforce-usb.c b/drivers/input/jo=
ystick/iforce/iforce-usb.c
index f1569ae8381b..afbcd1a522d4 100644
=2D-- a/drivers/input/joystick/iforce/iforce-usb.c
+++ b/drivers/input/joystick/iforce/iforce-usb.c
@@ -202,6 +202,7 @@ static const struct usb_device_id iforce_usb_ids[] =3D=
 {
 	{ USB_DEVICE(0x05ef, 0x8888) },		/* AVB Top Shot FFB Racing Wheel */
 	{ USB_DEVICE(0x061c, 0xc0a4) },         /* ACT LABS Force RS */
 	{ USB_DEVICE(0x061c, 0xc084) },         /* ACT LABS Force RS */
+	{ USB_DEVICE(0x06a3, 0xff04) },		/* Saitek R440 Force Wheel */
 	{ USB_DEVICE(0x06f8, 0x0001) },		/* Guillemot Race Leader Force Feedback=
 */
 	{ USB_DEVICE(0x06f8, 0x0003) },		/* Guillemot Jet Leader Force Feedback =
*/
 	{ USB_DEVICE(0x06f8, 0x0004) },		/* Guillemot Force Feedback Racing Whee=
l */
=2D-
2.22.0
