From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 2/2] Input: tnetv107x-ts - fix MODULE_ALIAS
Date: Mon, 27 Jun 2011 22:33:57 +0800
Message-ID: <1309185237.29085.1.camel@phoenix>
References: <1309185168.29085.0.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:64677 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751096Ab1F0OeC (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 27 Jun 2011 10:34:02 -0400
In-Reply-To: <1309185168.29085.0.camel@phoenix>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Cyril Chemparathy <cyril@ti.com>, linux-input@vger.kernel.org

Remove the space between "platform:" prefix and the driver name.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 drivers/input/touchscreen/tnetv107x-ts.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/input/touchscreen/tnetv107x-ts.c b/drivers/input/touchscreen/tnetv107x-ts.c
index 22a3411..089b0a0 100644
--- a/drivers/input/touchscreen/tnetv107x-ts.c
+++ b/drivers/input/touchscreen/tnetv107x-ts.c
@@ -393,5 +393,5 @@ module_exit(tsc_exit);
 
 MODULE_AUTHOR("Cyril Chemparathy");
 MODULE_DESCRIPTION("TNETV107X Touchscreen Driver");
-MODULE_ALIAS("platform: tnetv107x-ts");
+MODULE_ALIAS("platform:tnetv107x-ts");
 MODULE_LICENSE("GPL");
-- 
1.7.4.1



