From: Tolga Cakir <tolga@cevel.net>
Subject: [PATCH] Input: input-event-codes - add keycodes for gaming peripherals
Date: Thu, 24 Dec 2015 22:25:27 +0100
Message-ID: <1450992327-16281-1-git-send-email-tolga@cevel.net>
References: <tolga@cevel.net>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp02.udag.de ([62.146.106.18]:42080 "EHLO smtp02.udag.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751075AbbLXV0c (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 24 Dec 2015 16:26:32 -0500
In-Reply-To: <tolga@cevel.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, Tolga Cakir <tolga@cevel.net>

Gaming peripherals without onboard memory or with switchable software macro,
like Logitech G510 / G700 / G710 / G710+, Microsoft Sidewinder X4 / X6 or
Corsair K90, have many keys in common. This patch adds the most common physical
keys among gaming peripherals, so they can be used by existing and future kernel
modules.

Included are keycodes for profile management, macro recording and macro keys.
While some gaming peripherals have a seperate key for each profile (KEY_M[1-3]),
others have a single key, which loops through profiles (KEY_BANK_SWITCH).

Almost all gaming peripherals only support up to 3 profiles, so KEY_M[1-3]
should be sufficient. For macro keys, KEY_[G1-30] should cover all use cases.
Microsoft Sidewinder X6 has 30 unique macro keys and is followed by the Logitech
G13 with 25 macro keys.

Signed-off-by: Tolga Cakir <tolga@cevel.net>
---
 include/uapi/linux/input-event-codes.h | 37 ++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
index 87cf351..81e1f17 100644
--- a/include/uapi/linux/input-event-codes.h
+++ b/include/uapi/linux/input-event-codes.h
@@ -611,6 +611,43 @@
 #define KEY_KBDINPUTASSIST_ACCEPT		0x264
 #define KEY_KBDINPUTASSIST_CANCEL		0x265
 
+#define KEY_BANK_SWITCH		0x270	/* used by gaming peripherals */
+#define KEY_M1			0x271	/* Profile Management */
+#define KEY_M2			0x272
+#define KEY_M3			0x273
+#define KEY_MR			0x274	/* Macro Record */
+
+#define KEY_G1			0x275	/* Macro Keys */
+#define KEY_G2			0x276
+#define KEY_G3			0x277
+#define KEY_G4			0x278
+#define KEY_G5			0x279
+#define KEY_G6			0x27a
+#define KEY_G7			0x27b
+#define KEY_G8			0x27c
+#define KEY_G9			0x27d
+#define KEY_G10			0x27e
+#define KEY_G11			0x27f
+#define KEY_G12			0x280
+#define KEY_G13			0x281
+#define KEY_G14			0x282
+#define KEY_G15			0x283
+#define KEY_G16			0x284
+#define KEY_G17			0x285
+#define KEY_G18			0x286
+#define KEY_G19			0x287
+#define KEY_G20			0x288
+#define KEY_G21			0x289
+#define KEY_G22			0x28a
+#define KEY_G23			0x28b
+#define KEY_G24			0x28c
+#define KEY_G25			0x28d
+#define KEY_G26			0x28e
+#define KEY_G27			0x28f
+#define KEY_G28			0x290
+#define KEY_G29			0x291
+#define KEY_G30			0x292
+
 #define BTN_TRIGGER_HAPPY		0x2c0
 #define BTN_TRIGGER_HAPPY1		0x2c0
 #define BTN_TRIGGER_HAPPY2		0x2c1
-- 
2.6.4

