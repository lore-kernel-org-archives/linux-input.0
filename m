From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH] HID: alps: fix stick device not working after resume
Date: Mon, 19 Sep 2016 15:41:39 +0800
Message-ID: <20160919074139.2551-1-kai.heng.feng@canonical.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:38658 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936521AbcISHlu (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 19 Sep 2016 03:41:50 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jikos@kernel.org
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, masaki.ota@jp.alps.com, kai.heng.feng@canonical.com

The stick device does not work after resume, add U1_SP_ABS_MODE flag can
make the device work after resume.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/hid/hid-alps.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-alps.c b/drivers/hid/hid-alps.c
index 048befd..390f8d3 100644
--- a/drivers/hid/hid-alps.c
+++ b/drivers/hid/hid-alps.c
@@ -244,13 +244,13 @@ static int alps_raw_event(struct hid_device *hdev,
 static int alps_post_reset(struct hid_device *hdev)
 {
 	return u1_read_write_register(hdev, ADDRESS_U1_DEV_CTRL_1,
-				NULL, U1_TP_ABS_MODE, false);
+				NULL, U1_TP_ABS_MODE | U1_SP_ABS_MODE, false);
 }
 
 static int alps_post_resume(struct hid_device *hdev)
 {
 	return u1_read_write_register(hdev, ADDRESS_U1_DEV_CTRL_1,
-				NULL, U1_TP_ABS_MODE, false);
+				NULL, U1_TP_ABS_MODE | U1_SP_ABS_MODE, false);
 }
 #endif /* CONFIG_PM */
 
-- 
2.9.3

