From: Michal =?ISO-8859-1?Q?Mal=FD?= <madcatxster@devoid-pointer.net>
Subject: [PATCH 05/24] Port max8997_haptic to ff-memless-next
Date: Wed, 09 Apr 2014 13:17:10 +0200
Message-ID: <3882714.y6Chz3cmQm@sigyn>
References: <1609685.QRL9N9sQvX@sigyn>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from prifuk.cz ([31.31.77.140]:52586 "EHLO devoid-pointer.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932482AbaDILRO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 9 Apr 2014 07:17:14 -0400
In-Reply-To: <1609685.QRL9N9sQvX@sigyn>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, jkosina@suse.cz
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Elias Vanderstuyft <elias.vds@gmail.com>

Port max8997_haptic to ff-memless-next

Signed-off-by: Michal Mal=FD <madcatxster@devoid-pointer.net>
---
 drivers/input/misc/Kconfig          |  2 +-
 drivers/input/misc/max8997_haptic.c | 25 +++++++++++++++++++------
 2 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index 91dcae8..6ba327f 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -157,7 +157,7 @@ config INPUT_MAX8925_ONKEY
 config INPUT_MAX8997_HAPTIC
 	tristate "MAXIM MAX8997 haptic controller support"
 	depends on PWM && HAVE_PWM && MFD_MAX8997
-	select INPUT_FF_MEMLESS
+	select INPUT_FF_MEMLESS_NEXT
 	help
 	  This option enables device driver support for the haptic controller
 	  on MAXIM MAX8997 chip. This driver supports ff-memless interface
diff --git a/drivers/input/misc/max8997_haptic.c b/drivers/input/misc/m=
ax8997_haptic.c
index 1fea548..029ac8b 100644
--- a/drivers/input/misc/max8997_haptic.c
+++ b/drivers/input/misc/max8997_haptic.c
@@ -31,6 +31,7 @@
 #include <linux/mfd/max8997-private.h>
 #include <linux/mfd/max8997.h>
 #include <linux/regulator/consumer.h>
+#include <linux/input/ff-memless-next.h>
=20
 /* Haptic configuration 2 register */
 #define MAX8997_MOTOR_TYPE_SHIFT	7
@@ -43,6 +44,8 @@
 #define MAX8997_SIG_DUTY_SHIFT		2
 #define MAX8997_PWM_DUTY_SHIFT		0
=20
+#define FF_UPDATE_RATE 50
+
 struct max8997_haptic {
 	struct device *dev;
 	struct i2c_client *client;
@@ -219,13 +222,23 @@ static void max8997_haptic_play_effect_work(struc=
t work_struct *work)
 }
=20
 static int max8997_haptic_play_effect(struct input_dev *dev, void *dat=
a,
-				  struct ff_effect *effect)
+				  const struct mlnx_effect_command *command)
 {
 	struct max8997_haptic *chip =3D input_get_drvdata(dev);
+	const struct mlnx_rumble_force *rumble_force =3D &command->u.rumble_f=
orce;
=20
-	chip->level =3D effect->u.rumble.strong_magnitude;
-	if (!chip->level)
-		chip->level =3D effect->u.rumble.weak_magnitude;
+	switch (command->cmd) {
+	case MLNX_START_RUMBLE:
+		chip->level =3D rumble_force->strong;
+		if (!chip->level)
+			chip->level =3D rumble_force->weak;
+		break;
+	case MLNX_STOP_RUMBLE:
+		chip->level =3D 0;
+		break;
+	default:
+		return -EINVAL;
+	}
=20
 	schedule_work(&chip->work);
=20
@@ -319,8 +332,8 @@ static int max8997_haptic_probe(struct platform_dev=
ice *pdev)
 	input_set_drvdata(input_dev, chip);
 	input_set_capability(input_dev, EV_FF, FF_RUMBLE);
=20
-	error =3D input_ff_create_memless(input_dev, NULL,
-				max8997_haptic_play_effect);
+	error =3D input_ff_create_mlnx(input_dev, NULL,
+				max8997_haptic_play_effect, FF_UPDATE_RATE);
 	if (error) {
 		dev_err(&pdev->dev,
 			"unable to create FF device, error: %d\n",
--=20
1.9.1


--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
