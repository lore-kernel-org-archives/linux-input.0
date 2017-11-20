From: <peter.enderborg@sonym.com>
Subject: [PATCH] Add BTN config for ShuttlePro
Date: Mon, 20 Nov 2017 11:06:14 +0100
Message-ID: <20171120100614.754-1-peter.enderborg@sonym.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from seldsegrel01.sonyericsson.com ([37.139.156.29]:8362 "EHLO
        SELDSEGREL01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751105AbdKTKQU (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 20 Nov 2017 05:16:20 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: Peter Enderborg <peter.enderborg@sony.com>

From: Peter Enderborg <peter.enderborg@sony.com>

ShuttlePro v2 is using 0x10a to 0x10e for generic usage.
Add defines for the buttos 0x10a to 0x10f.

Signed-off-by: Peter Enderborg <peter.enderborg@sony.com>
---
 include/uapi/linux/input-event-codes.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
index 061fa62..b5c4dc9 100644
--- a/include/uapi/linux/input-event-codes.h
+++ b/include/uapi/linux/input-event-codes.h
@@ -350,6 +350,12 @@
 #define BTN_7			0x107
 #define BTN_8			0x108
 #define BTN_9			0x109
+#define BTN_10			0x10a
+#define BTN_11			0x10b
+#define BTN_12			0x10c
+#define BTN_13			0x10d
+#define BTN_14			0x10e
+#define BTN_15			0x10f
 
 #define BTN_MOUSE		0x110
 #define BTN_LEFT		0x110
-- 
2.7.4

