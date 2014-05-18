From: Christian Engelmayer <cengelma@gmx.at>
Subject: [PATCH] Input: ims-pcu - fix uninitialized use of 'error' in ims_pcu_buffers_alloc()
Date: Sun, 18 May 2014 23:41:18 +0200
Message-ID: <1400449278-14513-1-git-send-email-cengelma@gmx.at>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.19]:55293 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751894AbaERVlw (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 18 May 2014 17:41:52 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, andrew.smirnov@gmail.com, linux-kernel@vger.kernel.org, Christian Engelmayer <cengelma@gmx.at>

In case allocation via usb_alloc_coherent() fails in ims_pcu_buffers_alloc(),
the function jumps to the exit path without initializing local variable
'error' that is used as return value. Detected by Coverity - CID 1016531.

Signed-off-by: Christian Engelmayer <cengelma@gmx.at>
---
This is an allocation function and all currently coded error scenarios
result in -ENOMEM. Thus it would be possible to eliminate 'error' at all and
always return -ENOMEM in the error path.

Compile tested. Applies against branch next in tree
git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git
---
 drivers/input/misc/ims-pcu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/misc/ims-pcu.c b/drivers/input/misc/ims-pcu.c
index 5a73639..719410f 100644
--- a/drivers/input/misc/ims-pcu.c
+++ b/drivers/input/misc/ims-pcu.c
@@ -1566,6 +1566,7 @@ static int ims_pcu_buffers_alloc(struct ims_pcu *pcu)
 	if (!pcu->urb_ctrl_buf) {
 		dev_err(pcu->dev,
 			"Failed to allocate memory for read buffer\n");
+		error = -ENOMEM;
 		goto err_free_urb_out_buf;
 	}
 
-- 
1.9.1

