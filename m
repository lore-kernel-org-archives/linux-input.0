From: =?UTF-8?q?Michal=20Mal=C3=BD?= <madcatxster@devoid-pointer.net>
Subject: [PATCH v3 03/24] input: Port twl4030-vibra to ff-memless-next
Date: Sat, 26 Apr 2014 13:57:40 +0200
Message-ID: <1398513696-12626-4-git-send-email-madcatxster@devoid-pointer.net>
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

Port twl4030-vibra to ff-memless-next

Signed-off-by: Michal Mal=C3=BD <madcatxster@devoid-pointer.net>
---
 drivers/input/misc/Kconfig         |  2 +-
 drivers/input/misc/twl4030-vibra.c | 31 +++++++++++++++++++++++++-----=
-
 2 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index f669cc7..817156f 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -407,7 +407,7 @@ config INPUT_TWL4030_VIBRA
 	tristate "Support for TWL4030 Vibrator"
 	depends on TWL4030_CORE
 	select MFD_TWL4030_AUDIO
-	select INPUT_FF_MEMLESS
+	select INPUT_FF_MEMLESS_NEXT
 	help
 	  This option enables support for TWL4030 Vibrator Driver.
=20
diff --git a/drivers/input/misc/twl4030-vibra.c b/drivers/input/misc/tw=
l4030-vibra.c
index 960ef2a..5274ad2 100644
--- a/drivers/input/misc/twl4030-vibra.c
+++ b/drivers/input/misc/twl4030-vibra.c
@@ -32,9 +32,11 @@
 #include <linux/mfd/twl4030-audio.h>
 #include <linux/input.h>
 #include <linux/slab.h>
+#include <linux/input/ff-memless-next.h>
=20
 /* MODULE ID2 */
 #define LEDEN		0x00
+#define FF_UPDATE_RATE	50
=20
 /* ForceFeedback */
 #define EFFECT_DIR_180_DEG	0x8000 /* range is 0 - 0xFFFF */
@@ -134,14 +136,31 @@ static void vibra_play_work(struct work_struct *w=
ork)
 /*** Input/ForceFeedback ***/
=20
 static int vibra_play(struct input_dev *input, void *data,
-		      struct ff_effect *effect)
+		      const struct mlnx_effect_command *command)
 {
 	struct vibra_info *info =3D input_get_drvdata(input);
+	const struct mlnx_rumble_force *rumble_force =3D &command->u.rumble_f=
orce;
+
+	switch (command->cmd) {
+	case MLNX_START_RUMBLE:
+		if (command->u.rumble_force.strong) {
+			info->speed =3D rumble_force->strong >> 8;
+			info->direction =3D rumble_force->strong_dir < EFFECT_DIR_180_DEG ?
+					  0 : 1;
+		} else {
+			info->speed =3D rumble_force->weak >> 9;
+			info->direction =3D rumble_force->weak_dir < EFFECT_DIR_180_DEG ?
+					  0 : 1;
+		}
+		break;
+	case MLNX_STOP_RUMBLE:
+		info->speed =3D 0;
+		info->direction =3D 0;
+		break;
+	default:
+		return -EINVAL;
+	}
=20
-	info->speed =3D effect->u.rumble.strong_magnitude >> 8;
-	if (!info->speed)
-		info->speed =3D effect->u.rumble.weak_magnitude >> 9;
-	info->direction =3D effect->direction < EFFECT_DIR_180_DEG ? 0 : 1;
 	schedule_work(&info->play_work);
 	return 0;
 }
@@ -227,7 +246,7 @@ static int twl4030_vibra_probe(struct platform_devi=
ce *pdev)
 	info->input_dev->close =3D twl4030_vibra_close;
 	__set_bit(FF_RUMBLE, info->input_dev->ffbit);
=20
-	ret =3D input_ff_create_memless(info->input_dev, NULL, vibra_play);
+	ret =3D input_ff_create_mlnx(info->input_dev, NULL, vibra_play, FF_UP=
DATE_RATE);
 	if (ret < 0) {
 		dev_dbg(&pdev->dev, "couldn't register vibrator to FF\n");
 		return ret;
--=20
1.9.2
