From: =?UTF-8?q?Michal=20Mal=C3=BD?= <madcatxster@devoid-pointer.net>
Subject: [PATCH v2 04/24] input: Port twl6040-vibra to ff-memless-next
Date: Tue, 22 Apr 2014 15:59:49 +0200
Message-ID: <1398175209-9565-5-git-send-email-madcatxster@devoid-pointer.net>
References: <1398175209-9565-1-git-send-email-madcatxster@devoid-pointer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.devoid-pointer.net ([31.31.77.140]:49463 "EHLO
	smtp.devoid-pointer.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756023AbaDVOAW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 22 Apr 2014 10:00:22 -0400
In-Reply-To: <1398175209-9565-1-git-send-email-madcatxster@devoid-pointer.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, jkosina@suse.cz, elias.vds@gmail.com, anssi.hannula@iki.fi, simon@mungewell.org

Port twl6040-vibra to ff-memless-next

Signed-off-by: Michal Mal=C3=BD <madcatxster@devoid-pointer.net>
---
 drivers/input/misc/Kconfig         |  2 +-
 drivers/input/misc/twl6040-vibra.c | 27 ++++++++++++++++++++++-----
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index 1016a1b..91dcae8 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -417,7 +417,7 @@ config INPUT_TWL4030_VIBRA
 config INPUT_TWL6040_VIBRA
 	tristate "Support for TWL6040 Vibrator"
 	depends on TWL6040_CORE
-	select INPUT_FF_MEMLESS
+	select INPUT_FF_MEMLESS_NEXT
 	help
 	  This option enables support for TWL6040 Vibrator Driver.
=20
diff --git a/drivers/input/misc/twl6040-vibra.c b/drivers/input/misc/tw=
l6040-vibra.c
index 77dc23b..7440a74 100644
--- a/drivers/input/misc/twl6040-vibra.c
+++ b/drivers/input/misc/twl6040-vibra.c
@@ -30,12 +30,14 @@
 #include <linux/of.h>
 #include <linux/workqueue.h>
 #include <linux/input.h>
+#include <linux/input/ff-memless-next.h>
 #include <linux/mfd/twl6040.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/regulator/consumer.h>
=20
 #define EFFECT_DIR_180_DEG	0x8000
+#define FF_UPDATE_RATE		50
=20
 /* Recommended modulation index 85% */
 #define TWL6040_VIBRA_MOD	85
@@ -197,9 +199,10 @@ static void vibra_play_work(struct work_struct *wo=
rk)
 }
=20
 static int vibra_play(struct input_dev *input, void *data,
-		      struct ff_effect *effect)
+		      const struct mlnx_effect_command *command)
 {
 	struct vibra_info *info =3D input_get_drvdata(input);
+	const struct mlnx_rumble_force *rumble_force =3D &command->u.rumble_f=
orce;
 	int ret;
=20
 	/* Do not allow effect, while the routing is set to use audio */
@@ -209,9 +212,23 @@ static int vibra_play(struct input_dev *input, voi=
d *data,
 		return -EBUSY;
 	}
=20
-	info->weak_speed =3D effect->u.rumble.weak_magnitude;
-	info->strong_speed =3D effect->u.rumble.strong_magnitude;
-	info->direction =3D effect->direction < EFFECT_DIR_180_DEG ? 1 : -1;
+	switch (command->cmd) {
+	case MLNX_START_RUMBLE:
+		info->weak_speed =3D rumble_force->weak;
+		info->strong_speed =3D rumble_force->strong;
+		if (info->strong_speed >=3D info->weak_speed)
+			info->direction =3D rumble_force->strong_dir < EFFECT_DIR_180_DEG ?=
 1 : -1;
+		else
+			info->direction =3D rumble_force->weak_dir < EFFECT_DIR_180_DEG ? 1=
 : -1;
+		break;
+	case MLNX_STOP_RUMBLE:
+		info->weak_speed =3D 0;
+		info->strong_speed =3D 0;
+		info->direction =3D 1;
+		break;
+	default:
+		return -EINVAL;
+	}
=20
 	ret =3D queue_work(info->workqueue, &info->play_work);
 	if (!ret) {
@@ -367,7 +384,7 @@ static int twl6040_vibra_probe(struct platform_devi=
ce *pdev)
 	info->input_dev->close =3D twl6040_vibra_close;
 	__set_bit(FF_RUMBLE, info->input_dev->ffbit);
=20
-	ret =3D input_ff_create_memless(info->input_dev, NULL, vibra_play);
+	ret =3D input_ff_create_mlnx(info->input_dev, NULL, vibra_play, FF_UP=
DATE_RATE);
 	if (ret < 0) {
 		dev_err(info->dev, "couldn't register vibrator to FF\n");
 		goto err_ialloc;
--=20
1.9.2

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
