From: Wanlong Gao <wanlong.gao@gmail.com>
Subject: [PATCH] drivers:input:free the memory before set it to NULL
Date: Wed, 20 Jul 2011 23:41:36 +0800
Message-ID: <1311176496-10026-1-git-send-email-wanlong.gao@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:49863 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751712Ab1GTPoI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 20 Jul 2011 11:44:08 -0400
Received: by iyb12 with SMTP id 12so292323iyb.19
        for <linux-input@vger.kernel.org>; Wed, 20 Jul 2011 08:44:07 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: sameo@linux.intel.com, linux-input@vger.kernel.org, Wanlong Gao <wanlong.gao@gmail.com>, Wanlong Gao <gaowanlong@cn.fujitsu.com>

The memory of the platform driver data should be freed
before it was set to NULL.

Signed-off-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>
---
 drivers/input/misc/pmic8xxx-pwrkey.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/input/misc/pmic8xxx-pwrkey.c b/drivers/input/misc/pmic8xxx-pwrkey.c
index b3cfb9c..2f3ca73 100644
--- a/drivers/input/misc/pmic8xxx-pwrkey.c
+++ b/drivers/input/misc/pmic8xxx-pwrkey.c
@@ -198,8 +198,8 @@ static int __devexit pmic8xxx_pwrkey_remove(struct platform_device *pdev)
 	free_irq(key_press_irq, pwrkey);
 	free_irq(key_release_irq, pwrkey);
 	input_unregister_device(pwrkey->pwr);
-	platform_set_drvdata(pdev, NULL);
 	kfree(pwrkey);
+	platform_set_drvdata(pdev, NULL);
 
 	return 0;
 }
-- 
1.7.4.1

