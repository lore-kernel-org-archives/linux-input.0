From: Arjun Sreedharan <arjun024@gmail.com>
Subject: [PATCH] remove explicit devm_kfree
Date: Fri, 15 Aug 2014 20:56:05 +0530
Message-ID: <1408116365-3013-1-git-send-email-arjun024@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:42377 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750884AbaHOP0X (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 15 Aug 2014 11:26:23 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: lejun.zhu@linux.intel.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Memory allocated with devm_kzalloc() is freed automatically when device
out of scope.

Signed-off-by: Arjun Sreedharan <arjun024@gmail.com>
---
 drivers/input/misc/soc_button_array.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/input/misc/soc_button_array.c b/drivers/input/misc/soc_button_array.c
index 5a6334b..123e59f 100644
--- a/drivers/input/misc/soc_button_array.c
+++ b/drivers/input/misc/soc_button_array.c
@@ -131,7 +131,6 @@ soc_button_device_create(struct pnp_dev *pdev,
 err_free_pdev:
 	platform_device_put(pd);
 err_free_mem:
-	devm_kfree(&pdev->dev, gpio_keys_pdata);
 	return ERR_PTR(error);
 }
 
-- 
1.7.11.7

