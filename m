From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] HID: simplify implement() a bit
Date: Wed, 6 Apr 2016 10:19:58 -0700
Message-ID: <20160406171958.GA39482@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f177.google.com ([209.85.192.177]:35317 "EHLO
	mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751310AbcDFRUC (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 6 Apr 2016 13:20:02 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Doug Anderson <dianders@chromium.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

The 'size' variable is not really needed, and we can also shift constant
in the loop body when masking off existing bits.

Also we do not have to us 64 bit calculations if we take an extra
branch.

Suggested-by: Doug Anderson <dianders@chromium.org>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-core.c | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 264cc49..9673dea 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1129,49 +1129,46 @@ EXPORT_SYMBOL_GPL(hid_field_extract);
 static void __implement(u8 *report, unsigned offset, int n, u32 value)
 {
 	unsigned int idx = offset / 8;
-	unsigned int size = offset + n;
 	unsigned int bit_shift = offset % 8;
 	int bits_to_set = 8 - bit_shift;
-	u8 bit_mask = 0xff << bit_shift;
 
 	while (n - bits_to_set >= 0) {
-		report[idx] &= ~bit_mask;
+		report[idx] &= ~(0xff << bit_shift);
 		report[idx] |= value << bit_shift;
 		value >>= bits_to_set;
 		n -= bits_to_set;
 		bits_to_set = 8;
-		bit_mask = 0xff;
 		bit_shift = 0;
 		idx++;
 	}
 
 	/* last nibble */
 	if (n) {
-		if (size % 8)
-			bit_mask &= (1U << (size % 8)) - 1;
-		report[idx] &= ~bit_mask;
-		report[idx] |= (value << bit_shift) & bit_mask;
+		u8 bit_mask = ((1U << n) - 1);
+		report[idx] &= ~(bit_mask << bit_shift);
+		report[idx] |= value << bit_shift;
 	}
 }
 
 static void implement(const struct hid_device *hid, u8 *report,
 		      unsigned offset, unsigned n, u32 value)
 {
-	u64 m;
-
-	if (n > 32) {
+	if (unlikely(n > 32)) {
 		hid_warn(hid, "%s() called with n (%d) > 32! (%s)\n",
 			 __func__, n, current->comm);
 		n = 32;
+	} else if (n < 32) {
+		u32 m = (1U << n) - 1;
+
+		if (unlikely(value > m)) {
+			hid_warn(hid,
+				 "%s() called with too large value %d (n: %d)! (%s)\n",
+				 __func__, value, n, current->comm);
+			WARN_ON(1);
+			value &= m;
+		}
 	}
 
-	m = (1ULL << n) - 1;
-	if (value > m)
-		hid_warn(hid, "%s() called with too large value %d! (%s)\n",
-			 __func__, value, current->comm);
-	WARN_ON(value > m);
-	value &= m;
-
 	__implement(report, offset, n, value);
 }
 
-- 
2.8.0.rc3.226.g39d4020


-- 
Dmitry
