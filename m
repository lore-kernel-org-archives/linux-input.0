From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH] HID: core: don't use negative operands when shift
Date: Wed,  7 Jan 2015 01:17:15 +0200
Message-ID: <1420586235-27660-1-git-send-email-andy.shevchenko@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from gw02.mail.saunalahti.fi ([195.197.172.116]:57884 "EHLO
	gw02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750807AbbAFXZE (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 6 Jan 2015 18:25:04 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>

The recent C standard in 6.5.7 paragraph 4 defines that operands for
bitwise shift operators should be non-negative, otherwise it's an
undefined behaviour.

Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/hid/hid-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index f2a4879..99307f0 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1027,7 +1027,7 @@ static s32 snto32(__u32 value, unsigned n)
 	case 16: return ((__s16)value);
 	case 32: return ((__s32)value);
 	}
-	return value & (1 << (n - 1)) ? value | (-1 << n) : value;
+	return value & (1 << (n - 1)) ? value | (~0U << n) : value;
 }
 
 s32 hid_snto32(__u32 value, unsigned n)
-- 
1.8.3.101.g727a46b

