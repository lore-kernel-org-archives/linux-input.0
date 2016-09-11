From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] HID: alps: Fix memory leak
Date: Sun, 11 Sep 2016 12:09:01 +0800
Message-ID: <1473566941-25149-1-git-send-email-axel.lin@ingics.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33728 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750758AbcIKEJj (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 11 Sep 2016 00:09:39 -0400
Received: by mail-pf0-f194.google.com with SMTP id 128so6193358pfb.0
        for <linux-input@vger.kernel.org>; Sat, 10 Sep 2016 21:09:39 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Masaki Ota <masaki.ota@jp.alps.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, Axel Lin <axel.lin@ingics.com>

A kfree(readbuf) call was missed if hid_hw_raw_request() fails, fix it.
Also avoid mixing direct return with goto in the error paths.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/hid/hid-alps.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-alps.c b/drivers/hid/hid-alps.c
index 048befd..2808da9 100644
--- a/drivers/hid/hid-alps.c
+++ b/drivers/hid/hid-alps.c
@@ -139,8 +139,8 @@ static int u1_read_write_register(struct hid_device *hdev, u32 address,
 	if (read_flag) {
 		readbuf = kzalloc(U1_FEATURE_REPORT_LEN, GFP_KERNEL);
 		if (!readbuf) {
-			kfree(input);
-			return -ENOMEM;
+			ret = -ENOMEM;
+			goto exit;
 		}
 
 		ret = hid_hw_raw_request(hdev, U1_FEATURE_REPORT_ID, readbuf,
@@ -149,6 +149,7 @@ static int u1_read_write_register(struct hid_device *hdev, u32 address,
 
 		if (ret < 0) {
 			dev_err(&hdev->dev, "failed read register (%d)\n", ret);
+			kfree(readbuf);
 			goto exit;
 		}
 
-- 
2.7.4

