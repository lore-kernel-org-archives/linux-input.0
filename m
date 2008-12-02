From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: [PATCH] input: strict_strtoul takes unsigned long
Date: Mon, 01 Dec 2008 16:04:20 -0800
Message-ID: <1228176260.5482.12.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.171]:14843 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751446AbYLBAEX (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 1 Dec 2008 19:04:23 -0500
Received: by wf-out-1314.google.com with SMTP id 27so2897168wfd.4
        for <linux-input@vger.kernel.org>; Mon, 01 Dec 2008 16:04:22 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-input <linux-input@vger.kernel.org>, Joe Rouvier <joe@rouvier.org>

Fix sparse warning introduced by:
commit 160f1fef7e52e974489b3c70fbd4e094c06965c2 Input: convert drivers to use strict_strtoul()

Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
---
Just noticed this while fixing the lock annotation patch.

 drivers/input/touchscreen/ads7846.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index 77ac820..f695b0b 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -472,7 +472,7 @@ static ssize_t ads7846_disable_store(struct device *dev,
 				     const char *buf, size_t count)
 {
 	struct ads7846 *ts = dev_get_drvdata(dev);
-	long i;
+	unsigned long i;
 
 	if (strict_strtoul(buf, 10, &i))
 		return -EINVAL;
-- 
1.6.1.rc1.262.gb6810



