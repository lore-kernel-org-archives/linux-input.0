From: Colin King <colin.king@canonical.com>
Subject: [PATCH] Input: regulator-haptic: fix spelling mistake: "dveice" -> "device"
Date: Wed, 22 Jun 2016 18:02:29 +0100
Message-ID: <1466614949-23946-1-git-send-email-colin.king@canonical.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:46395 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753144AbcFVRCl (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 22 Jun 2016 13:02:41 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Luis de Bethencourt <luis@debethencourt.com>, linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

trivial fix to spelling mistake

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/input/misc/regulator-haptic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/misc/regulator-haptic.c b/drivers/input/misc/regulator-haptic.c
index a804705..2e8f801 100644
--- a/drivers/input/misc/regulator-haptic.c
+++ b/drivers/input/misc/regulator-haptic.c
@@ -124,7 +124,7 @@ regulator_haptic_parse_dt(struct device *dev, struct regulator_haptic *haptic)
 
 	node = dev->of_node;
 	if(!node) {
-		dev_err(dev, "Missing dveice tree data\n");
+		dev_err(dev, "Missing device tree data\n");
 		return -EINVAL;
 	}
 
-- 
2.8.1

