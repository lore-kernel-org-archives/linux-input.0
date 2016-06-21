From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 2/4] HID: hid-led: add support for reading from LED devices
Date: Tue, 21 Jun 2016 21:48:46 +0200
Message-ID: <e927a050-8f2a-dad6-27fe-21faadfc3c52@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:34485 "EHLO
	mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751803AbcFUTvE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Jun 2016 15:51:04 -0400
Received: by mail-lf0-f66.google.com with SMTP id l184so6472878lfl.1
        for <linux-input@vger.kernel.org>; Tue, 21 Jun 2016 12:51:03 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org

Add support for reading data from LED devices.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/hid/hid-led.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/hid/hid-led.c b/drivers/hid/hid-led.c
index d5d8d94..4075f09 100644
--- a/drivers/hid/hid-led.c
+++ b/drivers/hid/hid-led.c
@@ -115,6 +115,35 @@ static int hidled_send(struct hidled_device *ldev, __u8 *buf)
 	return ret == ldev->config->report_size ? 0 : -EMSGSIZE;
 }
 
+/* reading data is supported for report type RAW_REQUEST only */
+static int hidled_recv(struct hidled_device *ldev, __u8 *buf)
+{
+	int ret;
+
+	if (ldev->config->report_type != RAW_REQUEST)
+		return -EINVAL;
+
+	buf[0] = ldev->config->report_id;
+
+	mutex_lock(&ldev->lock);
+
+	ret = hid_hw_raw_request(ldev->hdev, buf[0], buf,
+				 ldev->config->report_size,
+				 HID_FEATURE_REPORT,
+				 HID_REQ_SET_REPORT);
+	if (ret < 0)
+		goto err;
+
+	ret = hid_hw_raw_request(ldev->hdev, buf[0], buf,
+				 ldev->config->report_size,
+				 HID_FEATURE_REPORT,
+				 HID_REQ_GET_REPORT);
+err:
+	mutex_unlock(&ldev->lock);
+
+	return ret < 0 ? ret : 0;
+}
+
 static u8 riso_kagaku_index(struct hidled_rgb *rgb)
 {
 	enum led_brightness r, g, b;
-- 
2.9.0

