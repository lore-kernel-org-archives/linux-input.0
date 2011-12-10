From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH] Input: i8042-io - fix up region handling on MIPS
Date: Sat, 10 Dec 2011 23:02:07 +0200
Message-ID: <1323550927-26309-1-git-send-email-aaro.koskinen@iki.fi>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from filtteri2.pp.htv.fi ([213.243.153.185]:60886 "EHLO
	filtteri2.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751416Ab1LJVC3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 10 Dec 2011 16:02:29 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

i8042_platform_init() skips reguest_region() on MIPS, but in
i8042_platform_exit() release_region() is still called. Fix this by
reserving the region also on MIPS.

The patch eliminates the following error message seen on MIPS:

[    2.112000] Trying to free nonexistent resource <0000000000000060-000000000000006f>

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 drivers/input/serio/i8042-io.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/input/serio/i8042-io.h b/drivers/input/serio/i8042-io.h
index 5d48bb6..a5eed2a 100644
--- a/drivers/input/serio/i8042-io.h
+++ b/drivers/input/serio/i8042-io.h
@@ -76,7 +76,7 @@ static inline int i8042_platform_init(void)
 	if (check_legacy_ioport(I8042_DATA_REG))
 		return -ENODEV;
 #endif
-#if !defined(__sh__) && !defined(__alpha__) && !defined(__mips__)
+#if !defined(__sh__) && !defined(__alpha__)
 	if (!request_region(I8042_DATA_REG, 16, "i8042"))
 		return -EBUSY;
 #endif
-- 
1.7.2.5

