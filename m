From: zengzhaoxiu@163.com
Subject: [PATCH v2 18/30] input: use parity16 in ams_delta_serio
Date: Wed,  6 Apr 2016 17:45:26 +0800
Message-ID: <1459935926-7802-1-git-send-email-zengzhaoxiu@163.com>
References: <57031D9D.801@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from m50-132.163.com ([123.125.50.132]:41399 "EHLO m50-132.163.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932367AbcDFJpp (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 6 Apr 2016 05:45:45 -0400
In-Reply-To: <57031D9D.801@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>

From: Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>

Signed-off-by: Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>
---
 drivers/input/serio/ams_delta_serio.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/input/serio/ams_delta_serio.c b/drivers/input/serio/ams_delta_serio.c
index 45887e3..85459b3 100644
--- a/drivers/input/serio/ams_delta_serio.c
+++ b/drivers/input/serio/ams_delta_serio.c
@@ -48,13 +48,9 @@ static int check_data(int data)
 				data);
 		return SERIO_FRAME;
 	}
-	/* calculate the parity */
-	for (i = 1; i < 10; i++) {
-		if (data & (1 << i))
-			parity++;
-	}
 	/* it should be odd */
-	if (!(parity & 0x01)) {
+	parity = parity16(data & 0x3fe);
+	if (!parity) {
 		dev_warn(&ams_delta_serio->dev,
 				"paritiy check failed, data=0x%X parity=0x%X\n",
 				data, parity);
-- 
2.5.0


