From: Wanlong Gao <wanlong.gao@gmail.com>
Subject: [PATCH] drivers:input:set the device's driver data to NULL when remove
Date: Wed, 20 Jul 2011 23:17:56 +0800
Message-ID: <1311175076-7384-1-git-send-email-wanlong.gao@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:52443 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751244Ab1GTPUK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 20 Jul 2011 11:20:10 -0400
Received: by iwn6 with SMTP id 6so268834iwn.19
        for <linux-input@vger.kernel.org>; Wed, 20 Jul 2011 08:20:09 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: haojian.zhuang@marvell.com, linux-input@vger.kernel.org, Wanlong Gao <wanlong.gao@gmail.com>, Wanlong Gao <gaowanlong@cn.fujitsu.com>

Set the platform driver data ot NULL when the device
88pm860x-onkey is removed, it will be better.

Signed-off-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>
---
 drivers/input/misc/88pm860x_onkey.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/input/misc/88pm860x_onkey.c b/drivers/input/misc/88pm860x_onkey.c
index 3dca3c1..e1feb02 100644
--- a/drivers/input/misc/88pm860x_onkey.c
+++ b/drivers/input/misc/88pm860x_onkey.c
@@ -126,6 +126,9 @@ static int __devexit pm860x_onkey_remove(struct platform_device *pdev)
 	free_irq(info->irq, info);
 	input_unregister_device(info->idev);
 	kfree(info);
+
+	platform_set_drvdata(pdev, NULL);
+
 	return 0;
 }
 
-- 
1.7.4.1

