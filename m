From: Bojan Prtvar <prtvar.b@gmail.com>
Subject: [PATCH 2/2] HID: kfree() NULL pointer cleanup
Date: Thu,  4 Aug 2011 22:43:46 +0200
Message-ID: <1312490626-14838-1-git-send-email-prtvar.b@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:59698 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753234Ab1HDUn7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 4 Aug 2011 16:43:59 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Bojan Prtvar <prtvar.b@gmail.com>

Checking for NULL pointers before kfree() is redundant.

Signed-off-by: Bojan Prtvar <prtvar.b@gmail.com>
---
 drivers/hid/hid-zydacron.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-zydacron.c b/drivers/hid/hid-zydacron.c
index e903715..1ad85f2 100644
--- a/drivers/hid/hid-zydacron.c
+++ b/drivers/hid/hid-zydacron.c
@@ -201,9 +201,7 @@ static void zc_remove(struct hid_device *hdev)
 	struct zc_device *zc = hid_get_drvdata(hdev);
 
 	hid_hw_stop(hdev);
-
-	if (NULL != zc)
-		kfree(zc);
+	kfree(zc);
 }
 
 static const struct hid_device_id zc_devices[] = {
-- 
1.7.1

