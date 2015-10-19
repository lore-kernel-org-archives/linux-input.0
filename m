From: Insu Yun <wuninsu@gmail.com>
Subject: [PATCH] xen: check return value of xenbus_printf
Date: Mon, 19 Oct 2015 14:10:40 +0000
Message-ID: <1445263840-21187-1-git-send-email-wuninsu@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, stefano.stabellini@eu.citrix.com, david.vrabel@citrix.com, wei.liu2@citrix.com, julien.grall@citrix.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: taesoo@gatech.edu, yeongjin.jang@gatech.edu, insu@gatech.edu, changwoo@gatech.edu, Insu Yun <wuninsu@gmail.com>
List-Id: linux-input@vger.kernel.org

Internally, xenbus_printf uses memory allocation, so it can be failed in
memory pressure.Therefore, xenbus_printf's return should be checked
and properly handled.

Signed-off-by: Insu Yun <wuninsu@gmail.com>
---
 drivers/input/misc/xen-kbdfront.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/input/misc/xen-kbdfront.c b/drivers/input/misc/xen-kbdfront.c
index 23d0549..9d465d7 100644
--- a/drivers/input/misc/xen-kbdfront.c
+++ b/drivers/input/misc/xen-kbdfront.c
@@ -129,8 +129,14 @@ static int xenkbd_probe(struct xenbus_device *dev,
 
 	if (xenbus_scanf(XBT_NIL, dev->otherend, "feature-abs-pointer", "%d", &abs) < 0)
 		abs = 0;
-	if (abs)
-		xenbus_printf(XBT_NIL, dev->nodename, "request-abs-pointer", "1");
+	if (abs) {
+		ret = xenbus_printf(XBT_NIL, dev->nodename,
+					"request-abs-pointer", "1");
+		if (ret) {
+			pr_warning("xenkbd: can't request abs-pointer");
+			abs = 0;
+		}
+	}
 
 	/* keyboard */
 	kbd = input_allocate_device();
-- 
1.9.1
