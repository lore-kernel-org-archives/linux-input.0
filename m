From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] HID: core: don't use negative operands when shift
Date: Tue, 13 Jun 2017 12:22:22 +0300
Message-ID: <20170613092222.4073-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:61948 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752266AbdFMJWz (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 13 Jun 2017 05:22:55 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>

From: Andy Shevchenko <andy.shevchenko@gmail.com>

The recent C standard in 6.5.7 paragraph 4 defines that operands for
bitwise shift operators should be non-negative, otherwise it's an
undefined behaviour.

Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/hid/hid-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 5f87dbe28336..73416fef983e 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1046,7 +1046,7 @@ static s32 snto32(__u32 value, unsigned n)
 	case 16: return ((__s16)value);
 	case 32: return ((__s32)value);
 	}
-	return value & (1 << (n - 1)) ? value | (-1 << n) : value;
+	return value & (1 << (n - 1)) ? value | (~0U << n) : value;
 }
 
 s32 hid_snto32(__u32 value, unsigned n)
-- 
2.11.0

