From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 1/2] Input: tnetv107x-keypad - fix MODULE_ALIAS
Date: Mon, 27 Jun 2011 22:32:48 +0800
Message-ID: <1309185168.29085.0.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:39875 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751152Ab1F0Oc4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 27 Jun 2011 10:32:56 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Cyril Chemparathy <cyril@ti.com>, linux-input@vger.kernel.org

Remove the space between "platform:" prefix and the driver name.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 drivers/input/keyboard/tnetv107x-keypad.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/input/keyboard/tnetv107x-keypad.c b/drivers/input/keyboard/tnetv107x-keypad.c
index c8f097a..1c58681 100644
--- a/drivers/input/keyboard/tnetv107x-keypad.c
+++ b/drivers/input/keyboard/tnetv107x-keypad.c
@@ -337,5 +337,5 @@ module_exit(keypad_exit);
 
 MODULE_AUTHOR("Cyril Chemparathy");
 MODULE_DESCRIPTION("TNETV107X Keypad Driver");
-MODULE_ALIAS("platform: tnetv107x-keypad");
+MODULE_ALIAS("platform:tnetv107x-keypad");
 MODULE_LICENSE("GPL");
-- 
1.7.4.1



