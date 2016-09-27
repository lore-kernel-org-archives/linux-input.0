From: Colin King <colin.king@canonical.com>
Subject: [PATCH] HID: add missing \n to end of dev_warn messages
Date: Tue, 27 Sep 2016 11:58:44 -0700
Message-ID: <20160927185844.14659-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:38621 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750899AbcI0S6v (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 27 Sep 2016 14:58:51 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trival fix, dev_warn messages are missing a \n, so add it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 include/linux/hid.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/hid.h b/include/linux/hid.h
index 75b66ec..b2ec827 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -837,7 +837,7 @@ __u32 hid_field_extract(const struct hid_device *hid, __u8 *report,
  */
 static inline void hid_device_io_start(struct hid_device *hid) {
 	if (hid->io_started) {
-		dev_warn(&hid->dev, "io already started");
+		dev_warn(&hid->dev, "io already started\n");
 		return;
 	}
 	hid->io_started = true;
@@ -857,7 +857,7 @@ static inline void hid_device_io_start(struct hid_device *hid) {
  */
 static inline void hid_device_io_stop(struct hid_device *hid) {
 	if (!hid->io_started) {
-		dev_warn(&hid->dev, "io already stopped");
+		dev_warn(&hid->dev, "io already stopped\n");
 		return;
 	}
 	hid->io_started = false;
-- 
2.9.3

