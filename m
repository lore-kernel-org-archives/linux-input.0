From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/1] Input: max8997_haptic - Check return value of regulator_enable
Date: Fri, 30 May 2014 16:06:13 +0530
Message-ID: <1401446173-21981-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:64869 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932170AbaE3Kij (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 30 May 2014 06:38:39 -0400
Received: by mail-pd0-f171.google.com with SMTP id y13so822361pdi.2
        for <linux-input@vger.kernel.org>; Fri, 30 May 2014 03:38:38 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, sachin.kamat@linaro.org, Donggeun Kim <dg77.kim@samsung.com>

=46ixes the following warning:
drivers/input/misc/max8997_haptic.c:185:19: warning: ignoring return va=
lue of =E2=80=98regulator_enable=E2=80=99, declared with attribute warn=
_unused_result [-Wunused-result]

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Donggeun Kim <dg77.kim@samsung.com>
---
 drivers/input/misc/max8997_haptic.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/input/misc/max8997_haptic.c b/drivers/input/misc/m=
ax8997_haptic.c
index 1fea5484941f..4f4c34e135f5 100644
--- a/drivers/input/misc/max8997_haptic.c
+++ b/drivers/input/misc/max8997_haptic.c
@@ -182,7 +182,11 @@ static void max8997_haptic_enable(struct max8997_h=
aptic *chip)
=20
 	if (!chip->enabled) {
 		chip->enabled =3D true;
-		regulator_enable(chip->regulator);
+		error =3D regulator_enable(chip->regulator);
+		if (error) {
+			dev_err(chip->dev, "Failed to enable regulator");
+			goto out;
+		}
 		max8997_haptic_configure(chip);
 		if (chip->mode =3D=3D MAX8997_EXTERNAL_MODE)
 			pwm_enable(chip->pwm);
--=20
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
