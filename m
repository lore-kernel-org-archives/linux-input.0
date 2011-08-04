From: Bojan Prtvar <prtvar.b@gmail.com>
Subject: [PATCH 1/2] HID: kfree() NULL pointer cleanup
Date: Thu,  4 Aug 2011 22:42:54 +0200
Message-ID: <1312490574-14804-1-git-send-email-prtvar.b@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:42194 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752876Ab1HDUn2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 4 Aug 2011 16:43:28 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Bojan Prtvar <prtvar.b@gmail.com>

Checking for NULL pointers before kfree() is redundant.

Signed-off-by: Bojan Prtvar <prtvar.b@gmail.com>
---
 drivers/hid/hid-prodikeys.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-prodikeys.c b/drivers/hid/hid-prodikeys.c
index 158b389..62f95d4 100644
--- a/drivers/hid/hid-prodikeys.c
+++ b/drivers/hid/hid-prodikeys.c
@@ -849,9 +849,7 @@ static int pk_probe(struct hid_device *hdev, const struct hid_device_id *id)
 err_stop:
 	hid_hw_stop(hdev);
 err_free:
-	if (pm != NULL)
-		kfree(pm);
-
+	kfree(pm);
 	kfree(pk);
 	return ret;
 }
-- 
1.7.1

