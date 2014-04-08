From: Elias Vanderstuyft <elias.vds@gmail.com>
Subject: [PATCH] HID: lg2ff: add rumble magnitude clamping quirk
Date: Tue,  8 Apr 2014 15:06:07 +0200
Message-ID: <1396962367-6469-1-git-send-email-elias.vds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Elias Vanderstuyft <elias.vds@gmail.com>, Edgar Simo-Serra <bobbens@gmail.com>, =?UTF-8?q?Michal=20Mal=C3=BD?= <madcatxster@devoid-pointer.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

If a magnitude in the output report is lower than 2, i.e. 1 or 0,
the corresponding rumble motor shakes irregularly,
instead of being turned (almost) off like when magnitude 2 is used.
On the other hand, if a magnitude is higher than 0xfd, i.e 0xfe or 0xff=
,
the corresponding rumble motor shakes irregularly with a rotation speed
lower than when magnitude 0xfd is used.
=46rom 0x02 to 0xfd, the device behaves well:
a monotonic increase of rotation speed.
This applies to both weak and strong rumble motor types.

This patch fixes this issue by clamping magnitudes from 0x02 to 0xfd.

This behaviour is observed on the Formula Vibration wheel (ca04).
However it's not present on the Wingman Rumblepad (c20a) device,
yet the clamping has no effect on the haptic side,
so that special case handling is not needed.
Discussion on http://www.spinics.net/lists/linux-input/msg30711.html

Note: The same thing appears to happen in the Windows Logitech driver,
      except the max clamping bound is not 0xfd, but 0xfe.
      Experimentally, I proved this to be wrong.

Tested-by: Hendrik Iben <hendrik_iben@web.de>
Signed-off-by: Elias Vanderstuyft <elias.vds@gmail.com>
Cc: Edgar Simo-Serra <bobbens@gmail.com>
Cc: Michal Mal=C3=BD <madcatxster@devoid-pointer.net>
Cc: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/hid/hid-lg2ff.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/hid/hid-lg2ff.c b/drivers/hid/hid-lg2ff.c
index 0e3fb1a..e180e1e 100644
--- a/drivers/hid/hid-lg2ff.c
+++ b/drivers/hid/hid-lg2ff.c
@@ -38,12 +38,17 @@ static int play_effect(struct input_dev *dev, void =
*data,
 	struct lg2ff_device *lg2ff =3D data;
 	int weak, strong;
=20
+#define CLAMP_QUIRK(x) do { if (x < 2) x =3D 2; else if (x > 0xfd) x =3D=
 0xfd; } \
+			while (0)
+
 	strong =3D effect->u.rumble.strong_magnitude;
 	weak =3D effect->u.rumble.weak_magnitude;
=20
 	if (weak || strong) {
 		weak =3D weak * 0xff / 0xffff;
 		strong =3D strong * 0xff / 0xffff;
+		CLAMP_QUIRK(weak);
+		CLAMP_QUIRK(strong);
=20
 		lg2ff->report->field[0]->value[0] =3D 0x51;
 		lg2ff->report->field[0]->value[2] =3D weak;
--=20
1.8.3.1
