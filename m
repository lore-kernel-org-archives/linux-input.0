From: Frieder Schrempf <frieder.schrempf@exceet.de>
Subject: [PATCH v4 3/3] input: pwm-beeper: add devicetree bindings to set volume levels
Date: Thu, 16 Feb 2017 22:08:30 +0100
Message-ID: <bd85ff40e5c06a3404e3bc400762ee5ee1f1dedd.1487278130.git.frieder.schrempf@exceet.de>
References: <cover.1484838551.git.frieder.schrempf@exceet.de> <cover.1487278130.git.frieder.schrempf@exceet.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.exceet.ch ([77.245.33.226]:10511 "EHLO smtp.exceet.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932975AbdBPVLI (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 16 Feb 2017 16:11:08 -0500
In-Reply-To: <cover.1487278130.git.frieder.schrempf@exceet.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: robh@kernel.org
Cc: dmitry.torokhov@gmail.com, david@lechnology.com, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, luis@debethencourt.com, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Frieder Schrempf <frieder.schrempf@exceet.de>

This patch adds the devicetree bindings to set the volume levels
and the default volume level.

Signed-off-by: Frieder Schrempf <frieder.schrempf@exceet.de>
---
Changes in v4:
 - use generic device properties instead of dt properties

 drivers/input/misc/pwm-beeper.c | 63 ++++++++++++++++++++++++++++-------------
 1 file changed, 44 insertions(+), 19 deletions(-)

diff --git a/drivers/input/misc/pwm-beeper.c b/drivers/input/misc/pwm-beeper.c
index e29904e..6fe54de 100644
--- a/drivers/input/misc/pwm-beeper.c
+++ b/drivers/input/misc/pwm-beeper.c
@@ -154,8 +154,9 @@ static int pwm_beeper_probe(struct platform_device *pdev)
 {
 	unsigned long pwm_id = (unsigned long)dev_get_platdata(&pdev->dev);
 	struct pwm_beeper *beeper;
-	int error;
-	size_t size;
+	int error, length;
+	size_t size;
+	u32 value;
 
 	beeper = kzalloc(sizeof(*beeper), GFP_KERNEL);
 	if (!beeper)
@@ -181,23 +182,47 @@ static int pwm_beeper_probe(struct platform_device *pdev)
 
 	INIT_WORK(&beeper->work, pwm_beeper_work);
 
-	beeper->max_volume = 4;
-
-	size = sizeof(*beeper->volume_levels) *
-		(beeper->max_volume + 1);
-
-	beeper->volume_levels = devm_kzalloc(&(pdev->dev), size,
-		GFP_KERNEL);
-	if (!beeper->volume_levels)
-		return -ENOMEM;
-
-	beeper->volume_levels[0] = 0;
-	beeper->volume_levels[1] = 8;
-	beeper->volume_levels[2] = 20;
-	beeper->volume_levels[3] = 40;
-	beeper->volume_levels[4] = 500;
-
-	beeper->volume = beeper->max_volume;
+	/* determine the number of volume levels */
+	length = device_property_read_u32_array(&pdev->dev, "volume-levels", NULL, 0);
+	if (length <= 0) {
+		dev_dbg(&pdev->dev, "no volume levels specified, using max volume\n");
+		beeper->max_volume_level = 1;
+	} else
+		beeper->max_volume_level = length;
+
+	/* read volume levels from DT property */
+	if (beeper->max_volume_level > 0) {
+		size_t size = sizeof(*beeper->volume_levels) *
+			beeper->max_volume_level;
+
+		beeper->volume_levels = devm_kzalloc(&(pdev->dev), size,
+			GFP_KERNEL);
+		if (!beeper->volume_levels)
+			return -ENOMEM;
+
+		if (length > 0) {
+			error = device_property_read_u32_array(&pdev->dev, "volume-levels",
+						beeper->volume_levels,
+						beeper->max_volume_level);
+
+			if (error < 0)
+				return error;
+
+			error = device_property_read_u32(&pdev->dev, "default-volume-level",
+						   &value);
+
+			if (error < 0) {
+				dev_dbg(&pdev->dev, "no default volume specified, using max volume\n");
+				value = beeper->max_volume_level - 1;
+			}
+		} else {
+			beeper->volume_levels[0] = 500;
+			value = 0;
+		}
+
+		beeper->volume = value;
+		beeper->max_volume_level--;
+	}
 
 	beeper->input = input_allocate_device();
 	if (!beeper->input) {
-- 
2.7.4

