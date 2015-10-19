From: Insu Yun <wuninsu@gmail.com>
Subject: [PATCH] xen: check return value of xenbus_printf
Date: Mon, 19 Oct 2015 16:02:51 +0000
Message-ID: <1445270571-23890-1-git-send-email-wuninsu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yk0-f170.google.com ([209.85.160.170]:36287 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750985AbbJSQBe (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 19 Oct 2015 12:01:34 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, wei.liu2@citrix.com, david.vrabel@citrix.com, stefano.stabellini@eu.citrix.com, julien.grall@citrix.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: taesoo@gatech.edu, yeongjin.jang@gatech.edu, insu@gatech.edu, changwoo@gatech.edu, Insu Yun <wuninsu@gmail.com>

Signed-off-by: Insu Yun <wuninsu@gmail.com>
---
 drivers/input/misc/xen-kbdfront.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/input/misc/xen-kbdfront.c b/drivers/input/misc/xen-kbdfront.c
index 23d0549..0a9ad2cf 100644
--- a/drivers/input/misc/xen-kbdfront.c
+++ b/drivers/input/misc/xen-kbdfront.c
@@ -129,8 +129,14 @@ static int xenkbd_probe(struct xenbus_device *dev,
 
 	if (xenbus_scanf(XBT_NIL, dev->otherend, "feature-abs-pointer", "%d", &abs) < 0)
 		abs = 0;
-	if (abs)
-		xenbus_printf(XBT_NIL, dev->nodename, "request-abs-pointer", "1");
+	if (abs) {
+		ret = xenbus_printf(XBT_NIL, dev->nodename,
+				    "request-abs-pointer", "1");
+		if (ret) {
+			pr_warning("xenkbd: can't request abs-pointer");
+			abs = 0;
+		}
+	}
 
 	/* keyboard */
 	kbd = input_allocate_device();
-- 
1.9.1

