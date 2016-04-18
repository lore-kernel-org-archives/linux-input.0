From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH 4/5] input: twl6040-vibra: ignore return value of schedule_work
Date: Mon, 18 Apr 2016 21:55:40 +0200
Message-ID: <91f044c37473f3563790743bf6e66ac7f3d2661c.1461009340.git.hns@goldelico.com>
References: <cover.1461009340.git.hns@goldelico.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.217]:12062 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751363AbcDRTzt (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 18 Apr 2016 15:55:49 -0400
In-Reply-To: <cover.1461009340.git.hns@goldelico.com>
In-Reply-To: <cover.1461009340.git.hns@goldelico.com>
References: <cover.1461009340.git.hns@goldelico.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Fabio Estevam <fabio.estevam@freescale.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@pyra-handheld.com, letux-kernel@openphoenux.org

returning ret is wrong. And checking for an error as well. User space
may call multiple times until the work is really scheduled.

twl4030-vibra.c also ignores the return value.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/input/misc/twl6040-vibra.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/input/misc/twl6040-vibra.c b/drivers/input/misc/twl6040-vibra.c
index 3805129..69c5940 100644
--- a/drivers/input/misc/twl6040-vibra.c
+++ b/drivers/input/misc/twl6040-vibra.c
@@ -212,11 +212,7 @@ static int vibra_play(struct input_dev *input, void *data,
 	info->strong_speed = effect->u.rumble.strong_magnitude;
 	info->direction = effect->direction < EFFECT_DIR_180_DEG ? 1 : -1;
 
-	ret = schedule_work(&info->play_work);
-	if (!ret) {
-		dev_info(&input->dev, "work is already on queue\n");
-		return ret;
-	}
+	schedule_work(&info->play_work);
 
 	return 0;
 }
-- 
2.7.3

