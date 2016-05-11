From: zengzhaoxiu@163.com
Subject: [patch V4 17/31] input: use parity16 in ams_delta_serio
Date: Wed, 11 May 2016 17:19:43 +0800
Message-ID: <1462958385-25351-1-git-send-email-zengzhaoxiu@163.com>
References: <1462955158-28394-1-git-send-email-zengzhaoxiu@163.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1462955158-28394-1-git-send-email-zengzhaoxiu@163.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>

Signed-off-by: Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>
Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
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
2.7.4
