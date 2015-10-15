From: Insu Yun <wuninsu@gmail.com>
Subject: [PATCH] xen: check return value of xenbus_printf
Date: Thu, 15 Oct 2015 12:25:15 -0400
Message-ID: <1444926315-29106-1-git-send-email-wuninsu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yk0-f195.google.com ([209.85.160.195]:33364 "EHLO
	mail-yk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752486AbbJOQZA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 15 Oct 2015 12:25:00 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, david.vrabel@citrix.com, wei.liu2@citrix.com, julien.grall@citrix.com, stefano.stabellini@eu.citrix.com, huaixin.chx@alibaba-inc.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: taesoo@gatech.edu, yeongjin.jang@gatech.edu, insu@gatech.edu, Insu Yun <wuninsu@gmail.com>

Internally, xenbus_printf uses memory allocation, so it can be failed in
memory pressure.Therefore, xenbus_printf's return should be checked 
and properly handled.

Signed-off-by: Insu Yun <wuninsu@gmail.com>
---
 drivers/input/misc/xen-kbdfront.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/input/misc/xen-kbdfront.c b/drivers/input/misc/xen-kbdfront.c
index 23d0549..a3b0940 100644
--- a/drivers/input/misc/xen-kbdfront.c
+++ b/drivers/input/misc/xen-kbdfront.c
@@ -129,8 +129,11 @@ static int xenkbd_probe(struct xenbus_device *dev,
 
 	if (xenbus_scanf(XBT_NIL, dev->otherend, "feature-abs-pointer", "%d", &abs) < 0)
 		abs = 0;
-	if (abs)
-		xenbus_printf(XBT_NIL, dev->nodename, "request-abs-pointer", "1");
+	if (abs) {
+		ret = xenbus_printf(XBT_NIL, dev->nodename, "request-abs-pointer", "1");
+		if (ret)
+			pr_warning("xenkbd: can't request abs-pointer");
+  }
 
 	/* keyboard */
 	kbd = input_allocate_device();
-- 
1.9.1

