From: Zhang Jiejing <jiejing.zhang@freescale.com>
Subject: [PATCH] input: max11801_ts - correct license statement.
Date: Thu, 18 Aug 2011 18:26:42 +0800
Message-ID: <1313663202-30271-1-git-send-email-jiejing.zhang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch1ehsobe002.messaging.microsoft.com ([216.32.181.182]:22832
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755432Ab1HRKZg (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 18 Aug 2011 06:25:36 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Zhang Jiejing <jiejing.zhang@freescale.com>, linux-input@vger.kernel.org

From: Jiejing Zhang <jiejing.zhang@freescale.com>

This patch is aim to correct the license of this driver.
The orignal statement is not align to the derived driver.
This driver correct the license statement.

Signed-off-by: Jiejing Zhang <jiejing.zhang@freescale.com>
---
 drivers/input/touchscreen/max11801_ts.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/max11801_ts.c b/drivers/input/touchscreen/max11801_ts.c
index 4f2713d..58764a1 100644
--- a/drivers/input/touchscreen/max11801_ts.c
+++ b/drivers/input/touchscreen/max11801_ts.c
@@ -7,9 +7,10 @@
  *
  * Based on mcs5000_ts.c
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License.
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
  */
 
 /*
-- 
1.7.4.1


