From: =?UTF-8?q?Michal=20Mal=C3=BD?= <madcatxster@devoid-pointer.net>
Subject: [PATCH 06/24] Port pm8xxx-vibrator to ff-memless-next
Date: Tue, 22 Apr 2014 15:45:56 +0200
Message-ID: <1398174374-9501-7-git-send-email-madcatxster@devoid-pointer.net>
References: <1398174374-9501-1-git-send-email-madcatxster@devoid-pointer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from imap.devoid-pointer.net ([31.31.77.140]:49403 "EHLO
	smtp.devoid-pointer.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756407AbaDVNqa (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 22 Apr 2014 09:46:30 -0400
In-Reply-To: <1398174374-9501-1-git-send-email-madcatxster@devoid-pointer.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, jkosina@suse.cz, elias.vds@gmail.com, anssi.hannula@iki.fi, simon@mungewell.org

Signed-off-by: Michal Mal=C3=BD <madcatxster@devoid-pointer.net>
---
 drivers/input/misc/Kconfig           |  2 +-
 drivers/input/misc/pm8xxx-vibrator.c | 28 +++++++++++++++++++---------
 2 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index 6ba327f..300b5a8 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -108,7 +108,7 @@ config INPUT_PCSPKR
 config INPUT_PM8XXX_VIBRATOR
 	tristate "Qualcomm PM8XXX vibrator support"
 	depends on MFD_PM8XXX
-	select INPUT_FF_MEMLESS
+	select INPUT_FF_MEMLESS_NEXT
 	help
 	  This option enables device driver support for the vibrator
 	  on Qualcomm PM8xxx chip. This driver supports ff-memless interface
diff --git a/drivers/input/misc/pm8xxx-vibrator.c b/drivers/input/misc/=
pm8xxx-vibrator.c
index b88b7cb..6b0e9eb 100644
--- a/drivers/input/misc/pm8xxx-vibrator.c
+++ b/drivers/input/misc/pm8xxx-vibrator.c
@@ -17,6 +17,7 @@
 #include <linux/input.h>
 #include <linux/slab.h>
 #include <linux/regmap.h>
+#include <linux/input/ff-memless-next.h>
=20
 #define VIB_DRV			0x4A
=20
@@ -29,7 +30,7 @@
 #define VIB_MAX_LEVELS		(VIB_MAX_LEVEL_mV - VIB_MIN_LEVEL_mV)
=20
 #define MAX_FF_SPEED		0xff
-
+#define FF_UPDATE_RATE		50
 /**
  * struct pm8xxx_vib - structure to hold vibrator data
  * @vib_input_dev: input device supporting force feedback
@@ -128,14 +129,23 @@ static void pm8xxx_vib_close(struct input_dev *de=
v)
  * Currently this driver supports only rumble effects.
  */
 static int pm8xxx_vib_play_effect(struct input_dev *dev, void *data,
-				  struct ff_effect *effect)
+				  const struct mlnx_command *command)
 {
 	struct pm8xxx_vib *vib =3D input_get_drvdata(dev);
-
-	vib->speed =3D effect->u.rumble.strong_magnitude >> 8;
-	if (!vib->speed)
-		vib->speed =3D effect->u.rumble.weak_magnitude >> 9;
-
+	const struct mlnx_rumble_force *rumble_force =3D &command->u.rumble_f=
orce;
+
+	switch (command->cmd) {
+	case MLNX_START_RUMBLE:
+		vib->speed =3D rumble_force->strong >> 8;
+		if (!vib->speed)
+			vib->speed =3D rumble_force->weak >> 9;
+		break;
+	case MLNX_STOP_RUMBLE:
+		vib->speed =3D 0;
+		break;
+	default:
+		return -EINVAL;
+	}
 	schedule_work(&vib->work);
=20
 	return 0;
@@ -182,8 +192,8 @@ static int pm8xxx_vib_probe(struct platform_device =
*pdev)
 	input_set_drvdata(input_dev, vib);
 	input_set_capability(vib->vib_input_dev, EV_FF, FF_RUMBLE);
=20
-	error =3D input_ff_create_memless(input_dev, NULL,
-					pm8xxx_vib_play_effect);
+	error =3D input_ff_create_mlnx(input_dev, NULL,
+				     pm8xxx_vib_play_effect, FF_UPDATE_RATE);
 	if (error) {
 		dev_err(&pdev->dev,
 			"couldn't register vibrator as FF device\n");
--=20
1.9.2

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
