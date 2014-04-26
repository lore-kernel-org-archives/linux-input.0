From: =?UTF-8?q?Michal=20Mal=C3=BD?= <madcatxster@devoid-pointer.net>
Subject: [PATCH v3 07/24] hid: Port hid-axff to ff-memless-next
Date: Sat, 26 Apr 2014 13:57:44 +0200
Message-ID: <1398513696-12626-8-git-send-email-madcatxster@devoid-pointer.net>
References: <1398513696-12626-1-git-send-email-madcatxster@devoid-pointer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1398513696-12626-1-git-send-email-madcatxster@devoid-pointer.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, jkosina@suse.cz, elias.vds@gmail.com, anssi.hannula@iki.fi, simon@mungewell.org, =?UTF-8?q?Michal=20Mal=C3=BD?= <madcatxster@devoid-pointer.net>
List-Id: linux-input@vger.kernel.org

Port hid-axff to ff-memless-next

Signed-off-by: Michal Mal=C3=BD <madcatxster@devoid-pointer.net>
---
 drivers/hid/Kconfig    |  2 +-
 drivers/hid/hid-axff.c | 32 +++++++++++++++++++++++---------
 2 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 7af9d0b..e076627 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -106,7 +106,7 @@ config HID_ACRUX
 config HID_ACRUX_FF
 	bool "ACRUX force feedback support"
 	depends on HID_ACRUX
-	select INPUT_FF_MEMLESS
+	select INPUT_FF_MEMLESS_NEXT
 	---help---
 	Say Y here if you want to enable force feedback support for ACRUX
 	game controllers.
diff --git a/drivers/hid/hid-axff.c b/drivers/hid/hid-axff.c
index a594e47..7fbfcbc 100644
--- a/drivers/hid/hid-axff.c
+++ b/drivers/hid/hid-axff.c
@@ -31,31 +31,45 @@
 #include <linux/slab.h>
 #include <linux/hid.h>
 #include <linux/module.h>
+#include <linux/input/ff-memless-next.h>
=20
 #include "hid-ids.h"
=20
+#define FF_UPDATE_RATE 50
 #ifdef CONFIG_HID_ACRUX_FF
=20
 struct axff_device {
 	struct hid_report *report;
 };
=20
-static int axff_play(struct input_dev *dev, void *data, struct ff_effe=
ct *effect)
+static int axff_play(struct input_dev *dev, void *data,
+		     const struct mlnx_effect_command *command)
 {
 	struct hid_device *hid =3D input_get_drvdata(dev);
 	struct axff_device *axff =3D data;
 	struct hid_report *report =3D axff->report;
+	const struct mlnx_rumble_force *rumble_force =3D &command->u.rumble_f=
orce;
 	int field_count =3D 0;
 	int left, right;
 	int i, j;
=20
-	left =3D effect->u.rumble.strong_magnitude;
-	right =3D effect->u.rumble.weak_magnitude;
-
-	dbg_hid("called with 0x%04x 0x%04x", left, right);
-
-	left =3D left * 0xff / 0xffff;
-	right =3D right * 0xff / 0xffff;
+	switch (command->cmd) {
+	case MLNX_START_RUMBLE:
+		left =3D rumble_force->strong;
+		right =3D rumble_force->weak;
+
+		dbg_hid("called with 0x%04x 0x%04x", left, right);
+
+		left =3D left * 0xff / 0xffff;
+		right =3D right * 0xff / 0xffff;
+		break;
+	case MLNX_STOP_RUMBLE:
+		left =3D 0;
+		right =3D 0;
+		break;
+	default:
+		return -EINVAL;
+	}
=20
 	for (i =3D 0; i < report->maxfield; i++) {
 		for (j =3D 0; j < report->field[i]->report_count; j++) {
@@ -107,7 +121,7 @@ static int axff_init(struct hid_device *hid)
=20
 	set_bit(FF_RUMBLE, dev->ffbit);
=20
-	error =3D input_ff_create_memless(dev, axff, axff_play);
+	error =3D input_ff_create_mlnx(dev, axff, axff_play, FF_UPDATE_RATE);
 	if (error)
 		goto err_free_mem;
=20
--=20
1.9.2
