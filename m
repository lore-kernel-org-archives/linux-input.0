From: =?UTF-8?q?Michal=20Mal=C3=BD?= <madcatxster@devoid-pointer.net>
Subject: [PATCH 10/24] Port hid-gaff to ff-memless-next
Date: Tue, 22 Apr 2014 15:46:00 +0200
Message-ID: <1398174374-9501-11-git-send-email-madcatxster@devoid-pointer.net>
References: <1398174374-9501-1-git-send-email-madcatxster@devoid-pointer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1398174374-9501-1-git-send-email-madcatxster@devoid-pointer.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, jkosina@suse.cz, elias.vds@gmail.com, anssi.hannula@iki.fi, simon@mungewell.org
List-Id: linux-input@vger.kernel.org

Signed-off-by: Michal Mal=C3=BD <madcatxster@devoid-pointer.net>
---
 drivers/hid/Kconfig    |  2 +-
 drivers/hid/hid-gaff.c | 32 +++++++++++++++++++++++---------
 2 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 0ba1962..24b336e 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -656,7 +656,7 @@ config HID_GREENASIA
 config GREENASIA_FF
 	bool "GreenAsia (Product ID 0x12) force feedback support"
 	depends on HID_GREENASIA
-	select INPUT_FF_MEMLESS
+	select INPUT_FF_MEMLESS_NEXT
 	---help---
 	Say Y here if you have a GreenAsia (Product ID 0x12) based game contr=
oller
 	(like MANTA Warrior MM816 and SpeedLink Strike2 SL-6635) or adapter
diff --git a/drivers/hid/hid-gaff.c b/drivers/hid/hid-gaff.c
index 2d8cead..f2f70c1 100644
--- a/drivers/hid/hid-gaff.c
+++ b/drivers/hid/hid-gaff.c
@@ -31,8 +31,11 @@
 #include <linux/slab.h>
 #include <linux/hid.h>
 #include <linux/module.h>
+#include <linux/input/ff-memless-next.h>
 #include "hid-ids.h"
=20
+#define FF_UPDATE_RATE 50
+
 #ifdef CONFIG_GREENASIA_FF
=20
 struct gaff_device {
@@ -40,19 +43,30 @@ struct gaff_device {
 };
=20
 static int hid_gaff_play(struct input_dev *dev, void *data,
-			 struct ff_effect *effect)
+			 const struct mlnx_effect_command *command)
 {
 	struct hid_device *hid =3D input_get_drvdata(dev);
 	struct gaff_device *gaff =3D data;
+	const struct mlnx_rumble_force *rumble_force =3D &command->u.rumble_f=
orce;
 	int left, right;
=20
-	left =3D effect->u.rumble.strong_magnitude;
-	right =3D effect->u.rumble.weak_magnitude;
-
-	dbg_hid("called with 0x%04x 0x%04x", left, right);
-
-	left =3D left * 0xfe / 0xffff;
-	right =3D right * 0xfe / 0xffff;
+	switch (command->cmd) {
+	case MLNX_START_RUMBLE:
+		left =3D rumble_force->strong;
+		right =3D rumble_force->weak;
+
+		dbg_hid("called with 0x%04x 0x%04x", left, right);
+
+		left =3D left * 0xfe / 0xffff;
+		right =3D right * 0xfe / 0xffff;
+		break;
+	case MLNX_STOP_RUMBLE:
+		left =3D 0;
+		right =3D 0;
+		break;
+	default:
+		return -EINVAL;
+	}
=20
 	gaff->report->field[0]->value[0] =3D 0x51;
 	gaff->report->field[0]->value[1] =3D 0x0;
@@ -109,7 +123,7 @@ static int gaff_init(struct hid_device *hid)
=20
 	set_bit(FF_RUMBLE, dev->ffbit);
=20
-	error =3D input_ff_create_memless(dev, gaff, hid_gaff_play);
+	error =3D input_ff_create_mlnx(dev, gaff, hid_gaff_play, FF_UPDATE_RA=
TE);
 	if (error) {
 		kfree(gaff);
 		return error;
--=20
1.9.2
