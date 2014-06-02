From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH v2 1/1] Input: max8997_haptic - Check return values
Date: Mon,  2 Jun 2014 15:54:03 +0530
Message-ID: <1401704643-27846-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f43.google.com ([209.85.160.43]:63335 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750931AbaFBK0g (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 2 Jun 2014 06:26:36 -0400
Received: by mail-pb0-f43.google.com with SMTP id up15so4075599pbc.16
        for <linux-input@vger.kernel.org>; Mon, 02 Jun 2014 03:26:36 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, sachin.kamat@linaro.org, Donggeun Kim <dg77.kim@samsung.com>

Check the return value of regulator_enable and pwm_enable to
avoid errors.
=46ixes the following warning:
drivers/input/misc/max8997_haptic.c:185:19: warning: ignoring return va=
lue of =E2=80=98regulator_enable=E2=80=99, declared with attribute warn=
_unused_result [-Wunused-result]

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Donggeun Kim <dg77.kim@samsung.com>
---
Changes since v1:
* checked the return value of pwm_enable as suggested by Dmitry.
* Make chip->enabled =3D true only if enablement is
successful.
---
 drivers/input/misc/max8997_haptic.c |   17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/input/misc/max8997_haptic.c b/drivers/input/misc/m=
ax8997_haptic.c
index 1fea5484941f..11f4d84625b3 100644
--- a/drivers/input/misc/max8997_haptic.c
+++ b/drivers/input/misc/max8997_haptic.c
@@ -181,11 +181,20 @@ static void max8997_haptic_enable(struct max8997_=
haptic *chip)
 	}
=20
 	if (!chip->enabled) {
-		chip->enabled =3D true;
-		regulator_enable(chip->regulator);
+		error =3D regulator_enable(chip->regulator);
+		if (error) {
+			dev_err(chip->dev, "Failed to enable regulator\n");
+			goto out;
+		}
 		max8997_haptic_configure(chip);
-		if (chip->mode =3D=3D MAX8997_EXTERNAL_MODE)
-			pwm_enable(chip->pwm);
+		if (chip->mode =3D=3D MAX8997_EXTERNAL_MODE) {
+			error =3D pwm_enable(chip->pwm);
+			if (error) {
+				dev_err(chip->dev, "Failed to enable PWM\n");
+				goto out;
+			}
+		}
+		chip->enabled =3D true;
 	}
=20
 out:
--=20
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
