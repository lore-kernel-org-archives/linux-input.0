From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 3/7] Input: libps2 - use BIT() for bitmask constants
Date: Fri, 19 Jan 2018 11:41:07 -0800
Message-ID: <20180119194111.185590-4-dmitry.torokhov@gmail.com>
References: <20180119194111.185590-1-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:46798 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756223AbeASTlS (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 19 Jan 2018 14:41:18 -0500
In-Reply-To: <20180119194111.185590-1-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Hans de Goede <hdegoede@redhat.com>, Lyude Paul <lyude@redhat.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Let's explicitly document bit numbers with BIT() macro.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 include/linux/libps2.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/libps2.h b/include/linux/libps2.h
index 365c50b097ded..649295a5ff47d 100644
--- a/include/linux/libps2.h
+++ b/include/linux/libps2.h
@@ -20,11 +20,11 @@
 #define PS2_RET_NAK		0xfe
 #define PS2_RET_ERR		0xfc
 
-#define PS2_FLAG_ACK		1	/* Waiting for ACK/NAK */
-#define PS2_FLAG_CMD		2	/* Waiting for command to finish */
-#define PS2_FLAG_CMD1		4	/* Waiting for the first byte of command response */
-#define PS2_FLAG_WAITID		8	/* Command execiting is GET ID */
-#define PS2_FLAG_NAK		16	/* Last transmission was NAKed */
+#define PS2_FLAG_ACK		BIT(0)	/* Waiting for ACK/NAK */
+#define PS2_FLAG_CMD		BIT(1)	/* Waiting for a command to finish */
+#define PS2_FLAG_CMD1		BIT(2)	/* Waiting for the first byte of command response */
+#define PS2_FLAG_WAITID		BIT(3)	/* Command executing is GET ID */
+#define PS2_FLAG_NAK		BIT(4)	/* Last transmission was NAKed */
 
 struct ps2dev {
 	struct serio *serio;
-- 
2.16.0.rc1.238.g530d649a79-goog

