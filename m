From: Jaewon Kim <jaewon02.kim@samsung.com>
Subject: [PATCH] Input: misc: max77693-haptic - fix active state check in
 disable()
Date: Wed, 15 Oct 2014 12:16:18 +0900
Message-ID: <1413342978-30349-1-git-send-email-jaewon02.kim@samsung.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:11148 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755536AbaJODQe (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Oct 2014 23:16:34 -0400
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0NDG001YWUFALB60@mailout1.samsung.com> for
 linux-input@vger.kernel.org; Wed, 15 Oct 2014 12:16:22 +0900 (KST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>, Jaewon Kim <jaewon02.kim@samsung.com>, linux-input@vger.kernel.org

In order to avoid duplicated execution, max77693_haptic_disable()
check disable state. But it was reversed. this patch fix it.

Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
---
 drivers/input/misc/max77693-haptic.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/misc/max77693-haptic.c b/drivers/input/misc/max77693-haptic.c
index d605db4..7b1fde9 100644
--- a/drivers/input/misc/max77693-haptic.c
+++ b/drivers/input/misc/max77693-haptic.c
@@ -152,7 +152,7 @@ static void max77693_haptic_disable(struct max77693_haptic *haptic)
 {
 	int error;
 
-	if (haptic->enabled)
+	if (!haptic->enabled)
 		return;
 
 	error = max77693_haptic_configure(haptic, false);
-- 
1.7.9.5

