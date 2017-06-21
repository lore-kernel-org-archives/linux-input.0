From: Wang Yafei <wangyafei@goodix.com>
Subject: [PATCH] Nothing changed
Date: Wed, 21 Jun 2017 11:50:43 +0800
Message-ID: <20170621035043.GA6481@andrew-dell>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from Mailgw01.goodix.com ([58.250.26.195]:2226 "EHLO
        barracuda.goodix.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751135AbdFUDuw (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 20 Jun 2017 23:50:52 -0400
Received: from mail.goodix.com (sz-excas01.goodix.com [192.168.0.135]) by barracuda.goodix.com with ESMTP id ITOOJUwLsB44589c for <linux-input@vger.kernel.org>; Wed, 21 Jun 2017 11:50:45 +0800 (CST)
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
Cc: linux-input@vger.kernel.org, wangyafei@goodix.com

please ignore this mail

Signed-off-by: Wang Yafei <wangyafei@goodix.com>
---
 drivers/input/touchscreen/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
index d9408c0..0bbeb0d 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -6,6 +6,7 @@
 
 wm97xx-ts-y := wm97xx-core.o
 
+
 obj-$(CONFIG_TOUCHSCREEN_GOODIX_GTX5)	+= goodix-ts-sunrise/
 obj-$(CONFIG_TOUCHSCREEN_PROPERTIES)	+= of_touchscreen.o
 obj-$(CONFIG_TOUCHSCREEN_88PM860X)	+= 88pm860x-ts.o
-- 
2.7.4

