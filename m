From: Shiraz Hashim <shiraz.hashim@st.com>
Subject: [PATCH 1/6] input/spear-keyboard: fix disable device_init_wakeup in remove
Date: Mon, 2 Jul 2012 12:20:09 +0530
Message-ID: <1341211814-15173-1-git-send-email-shiraz.hashim@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eu1sys200aog114.obsmtp.com ([207.126.144.137]:39296 "EHLO
	eu1sys200aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750963Ab2GBGua (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 2 Jul 2012 02:50:30 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: spear-devel@list.st.com, linux-input@vger.kernel.org, Vipul Kumar Samar <vipulkumar.samar@st.com>

From: Vipul Kumar Samar <vipulkumar.samar@st.com>

This patch is to disable device wakeup while removing keyboard.

Signed-off-by: Vipul Kumar Samar <vipulkumar.samar@st.com>
---
 drivers/input/keyboard/spear-keyboard.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/spear-keyboard.c b/drivers/input/keyboard/spear-keyboard.c
index 605d3d2..67d9afb 100644
--- a/drivers/input/keyboard/spear-keyboard.c
+++ b/drivers/input/keyboard/spear-keyboard.c
@@ -303,7 +303,7 @@ static int __devexit spear_kbd_remove(struct platform_device *pdev)
 	release_mem_region(kbd->res->start, resource_size(kbd->res));
 	kfree(kbd);
 
-	device_init_wakeup(&pdev->dev, 1);
+	device_init_wakeup(&pdev->dev, 0);
 	platform_set_drvdata(pdev, NULL);
 
 	return 0;
-- 
1.7.10

