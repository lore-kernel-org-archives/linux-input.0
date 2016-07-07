From: "Jan Beulich" <JBeulich@suse.com>
Subject: [PATCH] xen-kbdfront: correct return value checks on
 xenbus_scanf()
Date: Thu, 07 Jul 2016 01:53:40 -0600
Message-ID: <577E26A402000078000FBE93@prv-mh.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from prv-mh.provo.novell.com ([137.65.248.74]:33983 "EHLO
	prv-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751106AbcGGHxl convert rfc822-to-8bit (ORCPT
	<rfc822;groupwise-linux-input@vger.kernel.org:6:1>);
	Thu, 7 Jul 2016 03:53:41 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: david.vrabel@citrix.com, xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com, Juergen Gross <JGross@suse.com>, linux-input@vger.kernel.org

Only a positive return value indicates success.

Signed-off-by: Jan Beulich <jbeulich@suse.com>
---
 drivers/input/misc/xen-kbdfront.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- 4.7-rc6-xenbus_scanf.orig/drivers/input/misc/xen-kbdfront.c
+++ 4.7-rc6-xenbus_scanf/drivers/input/misc/xen-kbdfront.c
@@ -127,7 +127,8 @@ static int xenkbd_probe(struct xenbus_de
 	if (!info->page)
 		goto error_nomem;
 
-	if (xenbus_scanf(XBT_NIL, dev->otherend, "feature-abs-pointer", "%d", &abs) < 0)
+	if (xenbus_scanf(XBT_NIL, dev->otherend,
+			 "feature-abs-pointer", "%d", &abs) <= 0)
 		abs = 0;
 	if (abs) {
 		ret = xenbus_printf(XBT_NIL, dev->nodename,
@@ -324,7 +325,7 @@ static void xenkbd_backend_changed(struc
 InitWait:
 		ret = xenbus_scanf(XBT_NIL, info->xbdev->otherend,
 				   "feature-abs-pointer", "%d", &val);
-		if (ret < 0)
+		if (ret <= 0)
 			val = 0;
 		if (val) {
 			ret = xenbus_printf(XBT_NIL, info->xbdev->nodename,



