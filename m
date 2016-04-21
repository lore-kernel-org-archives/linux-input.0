From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v2 3/4] Input: twl6040-vibra - do not reparent to grandparent
Date: Thu, 21 Apr 2016 13:43:49 +0200
Message-ID: <beec1481d138da719264083d4c1102451e63d788.1461239029.git.hns@goldelico.com>
References: <cover.1461239029.git.hns@goldelico.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.160]:10436 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751485AbcDULoB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 21 Apr 2016 07:44:01 -0400
In-Reply-To: <cover.1461239029.git.hns@goldelico.com>
In-Reply-To: <cover.1461239029.git.hns@goldelico.com>
References: <cover.1461239029.git.hns@goldelico.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Fabio Estevam <fabio.estevam@freescale.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@pyra-handheld.com, letux-kernel@openphoenux.org

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

---
 drivers/input/misc/twl6040-vibra.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/input/misc/twl6040-vibra.c b/drivers/input/misc/twl6040-vibra.c
index f7e0d17..f4384b7 100644
--- a/drivers/input/misc/twl6040-vibra.c
+++ b/drivers/input/misc/twl6040-vibra.c
@@ -347,7 +347,6 @@ static int twl6040_vibra_probe(struct platform_device *pdev)
 
 	info->input_dev->name = "twl6040:vibrator";
 	info->input_dev->id.version = 1;
-	info->input_dev->dev.parent = pdev->dev.parent;
 	info->input_dev->close = twl6040_vibra_close;
 	__set_bit(FF_RUMBLE, info->input_dev->ffbit);
 
-- 
2.7.3

