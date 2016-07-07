From: "Jan Beulich" <JBeulich@suse.com>
Subject: [PATCH] xen-kbdfront: prefer xenbus_write() over
 xenbus_printf() where possible
Date: Thu, 07 Jul 2016 01:54:22 -0600
Message-ID: <577E26CE02000078000FBE97@prv-mh.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from prv-mh.provo.novell.com ([137.65.248.74]:39309 "EHLO
	prv-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756266AbcGGHyX convert rfc822-to-8bit (ORCPT
	<rfc822;groupwise-linux-input@vger.kernel.org:6:1>);
	Thu, 7 Jul 2016 03:54:23 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: david.vrabel@citrix.com, xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com, Juergen Gross <JGross@suse.com>, linux-input@vger.kernel.org

... as being the simpler variant.

Signed-off-by: Jan Beulich <jbeulich@suse.com>
---
 drivers/input/misc/xen-kbdfront.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- 4.7-rc6-prefer-xenbus_write.orig/drivers/input/misc/xen-kbdfront.c
+++ 4.7-rc6-prefer-xenbus_write/drivers/input/misc/xen-kbdfront.c
@@ -130,8 +130,8 @@ static int xenkbd_probe(struct xenbus_de
 	if (xenbus_scanf(XBT_NIL, dev->otherend, "feature-abs-pointer", "%d", &abs) < 0)
 		abs = 0;
 	if (abs) {
-		ret = xenbus_printf(XBT_NIL, dev->nodename,
-				    "request-abs-pointer", "1");
+		ret = xenbus_write(XBT_NIL, dev->nodename,
+				   "request-abs-pointer", "1");
 		if (ret) {
 			pr_warning("xenkbd: can't request abs-pointer");
 			abs = 0;
@@ -327,8 +327,8 @@ InitWait:
 		if (ret < 0)
 			val = 0;
 		if (val) {
-			ret = xenbus_printf(XBT_NIL, info->xbdev->nodename,
-					    "request-abs-pointer", "1");
+			ret = xenbus_write(XBT_NIL, info->xbdev->nodename,
+					   "request-abs-pointer", "1");
 			if (ret)
 				pr_warning("xenkbd: can't request abs-pointer");
 		}



