From: Oliver Neukum <oneukum@suse.com>
Subject: [PATCH] sur40:fix DMA on stack
Date: Tue, 22 Mar 2016 11:26:06 +0100
Message-ID: <1458642366-28447-1-git-send-email-oneukum@suse.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:42807 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756497AbcCVK3A (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 22 Mar 2016 06:29:00 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, floe@butterbrot.org
Cc: Oliver Neukum <oneukum@suse.com>, Oliver Neukum <ONeukum@suse.com>

During the initialisation that driver uses a buffer on the stack
for DMA. That violates the cache coherency rules. The fix is to
allocate the buffer with kmalloc().

Signed-off-by: Oliver Neukum <ONeukum@suse.com>
---
 drivers/input/touchscreen/sur40.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/input/touchscreen/sur40.c b/drivers/input/touchscreen/sur40.c
index d214f22..5581954 100644
--- a/drivers/input/touchscreen/sur40.c
+++ b/drivers/input/touchscreen/sur40.c
@@ -196,29 +196,32 @@ static int sur40_command(struct sur40_state *dev,
 /* Initialization routine, called from sur40_open */
 static int sur40_init(struct sur40_state *dev)
 {
-	int result;
-	u8 buffer[24];
+	int result = -ENOMEM;
+	u8 *buffer;
 
+	buffer = kmalloc(24, GFP_KERNEL);
+	if (!buffer)
+		goto error;
 	/* stupidly replay the original MS driver init sequence */
 	result = sur40_command(dev, SUR40_GET_VERSION, 0x00, buffer, 12);
 	if (result < 0)
-		return result;
+		goto error;
 
 	result = sur40_command(dev, SUR40_GET_VERSION, 0x01, buffer, 12);
 	if (result < 0)
-		return result;
+		goto error;
 
 	result = sur40_command(dev, SUR40_GET_VERSION, 0x02, buffer, 12);
 	if (result < 0)
-		return result;
+		goto error;
 
 	result = sur40_command(dev, SUR40_UNKNOWN2,    0x00, buffer, 24);
 	if (result < 0)
-		return result;
+		goto error;
 
 	result = sur40_command(dev, SUR40_UNKNOWN1,    0x00, buffer,  5);
 	if (result < 0)
-		return result;
+		goto error;
 
 	result = sur40_command(dev, SUR40_GET_VERSION, 0x03, buffer, 12);
 
@@ -226,7 +229,8 @@ static int sur40_init(struct sur40_state *dev)
 	 * Discard the result buffer - no known data inside except
 	 * some version strings, maybe extract these sometime...
 	 */
-
+error:
+	kfree(buffer);
 	return result;
 }
 
-- 
2.1.4

