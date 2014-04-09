From: Michal =?ISO-8859-1?Q?Mal=FD?= <madcatxster@devoid-pointer.net>
Subject: [PATCH 14/24] Port hid-pl to ff-memless-next
Date: Wed, 09 Apr 2014 13:25:40 +0200
Message-ID: <2115571.hUK9cKBMaT@sigyn>
References: <1609685.QRL9N9sQvX@sigyn>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1609685.QRL9N9sQvX@sigyn>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, jkosina@suse.cz
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Elias Vanderstuyft <elias.vds@gmail.com>
List-Id: linux-input@vger.kernel.org

Port hid-pl to ff-memless-next

Signed-off-by: Michal Mal=FD <madcatxster@devoid-pointer.net>
---
 drivers/hid/Kconfig  |  2 +-
 drivers/hid/hid-pl.c | 38 ++++++++++++++++++++++++++------------
 2 files changed, 27 insertions(+), 13 deletions(-)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 6f2941a..87a02cc 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -500,7 +500,7 @@ config HID_PANTHERLORD
 config PANTHERLORD_FF
 	bool "Pantherlord force feedback support"
 	depends on HID_PANTHERLORD
-	select INPUT_FF_MEMLESS
+	select INPUT_FF_MEMLESS_NEXT
 	---help---
 	  Say Y here if you have a PantherLord/GreenAsia based game controlle=
r
 	  or adapter and want to enable force feedback support for it.
diff --git a/drivers/hid/hid-pl.c b/drivers/hid/hid-pl.c
index 2dcd7d9..9b539d5 100644
--- a/drivers/hid/hid-pl.c
+++ b/drivers/hid/hid-pl.c
@@ -44,9 +44,12 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/hid.h>
+#include <linux/input/ff-memless-next.h>
=20
 #include "hid-ids.h"
=20
+#define FF_UPDATE_RATE 50
+
 #ifdef CONFIG_PANTHERLORD_FF
=20
 struct plff_device {
@@ -57,24 +60,35 @@ struct plff_device {
 };
=20
 static int hid_plff_play(struct input_dev *dev, void *data,
-			 struct ff_effect *effect)
+			 const struct mlnx_effect_command *command)
 {
 	struct hid_device *hid =3D input_get_drvdata(dev);
 	struct plff_device *plff =3D data;
+	const struct mlnx_rumble_force *rumble_force =3D &command->u.rumble_f=
orce;
 	int left, right;
=20
-	left =3D effect->u.rumble.strong_magnitude;
-	right =3D effect->u.rumble.weak_magnitude;
-	debug("called with 0x%04x 0x%04x", left, right);
-
-	left =3D left * plff->maxval / 0xffff;
-	right =3D right * plff->maxval / 0xffff;
+	switch (command->cmd) {
+	case MLNX_START_RUMBLE:
+		left =3D rumble_force->strong;
+		right =3D rumble_force->weak;
+		debug("called with 0x%04x 0x%04x", left, right);
+
+		left =3D left * plff->maxval / 0xffff;
+		right =3D right * plff->maxval / 0xffff;
+
+		*plff->strong =3D left;
+		*plff->weak =3D right;
+		debug("running with 0x%02x 0x%02x", left, right);
+		break;
+	case MLNX_STOP_RUMBLE:
+		*plff->strong =3D 0;
+		*plff->weak =3D 0;
+		break;
+	default:
+		return -EINVAL;
+	}
=20
-	*plff->strong =3D left;
-	*plff->weak =3D right;
-	debug("running with 0x%02x 0x%02x", left, right);
 	hid_hw_request(hid, plff->report, HID_REQ_SET_REPORT);
-
 	return 0;
 }
=20
@@ -160,7 +174,7 @@ static int plff_init(struct hid_device *hid)
=20
 		set_bit(FF_RUMBLE, dev->ffbit);
=20
-		error =3D input_ff_create_memless(dev, plff, hid_plff_play);
+		error =3D input_ff_create_mlnx(dev, plff, hid_plff_play, FF_UPDATE_R=
ATE);
 		if (error) {
 			kfree(plff);
 			return error;
--=20
1.9.1
