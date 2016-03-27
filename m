From: "zhaoxiu.zeng" <zhaoxiu.zeng@gmail.com>
Subject: [PATCH 19/31] input: serio: use parity16 in ams_delta_serio.c
Date: Sun, 27 Mar 2016 15:18:18 +0800
Message-ID: <56F7893A.2040902@gmail.com>
References: <1458788612-4367-1-git-send-email-zhaoxiu.zeng@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36441 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752280AbcC0HSq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 27 Mar 2016 03:18:46 -0400
In-Reply-To: <1458788612-4367-1-git-send-email-zhaoxiu.zeng@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

From: Zeng Zhaoxiu <zhaoxiu.zeng@gmail.com>

Signed-off-by: Zeng Zhaoxiu <zhaoxiu.zeng@gmail.com>
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
2.5.5

