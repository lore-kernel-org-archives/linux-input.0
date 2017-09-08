From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] HID: i2c-hid: allocate hid buffers for real worst case
Date: Fri, 8 Sep 2017 10:55:27 -0700
Message-ID: <20170908175527.GA19720@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35813 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932336AbdIHRzb (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 8 Sep 2017 13:55:31 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Guenter Roeck <groeck@chromium.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

From: Adrian Salido <salidoa@google.com>

The buffer allocation is not currently accounting for an extra byte for
the report id. This can cause an out of bounds access in function
i2c_hid_set_or_send_report() with reportID > 15.

Signed-off-by: Guenter Roeck <groeck@chromium.org>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/i2c-hid/i2c-hid.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
index 77396145d2d0..9145c2129a96 100644
--- a/drivers/hid/i2c-hid/i2c-hid.c
+++ b/drivers/hid/i2c-hid/i2c-hid.c
@@ -543,7 +543,8 @@ static int i2c_hid_alloc_buffers(struct i2c_hid *ihid, size_t report_size)
 {
 	/* the worst case is computed from the set_report command with a
 	 * reportID > 15 and the maximum report length */
-	int args_len = sizeof(__u8) + /* optional ReportID byte */
+	int args_len = sizeof(__u8) + /* ReportID */
+		       sizeof(__u8) + /* optional ReportID byte */
 		       sizeof(__u16) + /* data register */
 		       sizeof(__u16) + /* size of the report */
 		       report_size; /* report */
-- 
2.14.1.581.gf28d330327-goog


-- 
Dmitry
