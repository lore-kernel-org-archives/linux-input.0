From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH] hid: thingm: simplify debug output code
Date: Sun, 19 Jun 2016 15:46:02 +0200
Message-ID: <fafa8814-1e61-1560-c44d-6c31c576fec2@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34849 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750720AbcFSNqL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 19 Jun 2016 09:46:11 -0400
Received: by mail-wm0-f67.google.com with SMTP id a66so3023657wme.2
        for <linux-input@vger.kernel.org>; Sun, 19 Jun 2016 06:46:10 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org

Kernel printf format %*ph allows to print small buffers up to 64 bytes.
Make use of it to simplify the debug output code.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/hid/hid-thingm.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-thingm.c b/drivers/hid/hid-thingm.c
index 9ad9c6e..9b4fec4 100644
--- a/drivers/hid/hid-thingm.c
+++ b/drivers/hid/hid-thingm.c
@@ -73,9 +73,7 @@ static int thingm_send(struct thingm_device *tdev, u8 buf[REPORT_SIZE])
 {
 	int ret;
 
-	hid_dbg(tdev->hdev, "-> %d %c %02hhx %02hhx %02hhx %02hhx %02hhx %02hhx %02hhx\n",
-			buf[0], buf[1], buf[2], buf[3], buf[4],
-			buf[5], buf[6], buf[7], buf[8]);
+	hid_dbg(tdev->hdev, "-> %d %c %7ph\n", buf[0], buf[1], &buf[2]);
 
 	mutex_lock(&tdev->lock);
 
@@ -110,9 +108,7 @@ static int thingm_recv(struct thingm_device *tdev, u8 buf[REPORT_SIZE])
 
 	ret = 0;
 
-	hid_dbg(tdev->hdev, "<- %d %c %02hhx %02hhx %02hhx %02hhx %02hhx %02hhx %02hhx\n",
-			buf[0], buf[1], buf[2], buf[3], buf[4],
-			buf[5], buf[6], buf[7], buf[8]);
+	hid_dbg(tdev->hdev, "<- %d %c %7ph\n", buf[0], buf[1], &buf[2]);
 err:
 	mutex_unlock(&tdev->lock);
 	return ret;
-- 
2.9.0

