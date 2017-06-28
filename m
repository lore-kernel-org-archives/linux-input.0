From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] Input: introduce KEY_ASSISTANT
Date: Wed, 28 Jun 2017 16:32:41 -0700
Message-ID: <20170628233241.GA20352@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34089 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751545AbdF1Xco (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 28 Jun 2017 19:32:44 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

This adds a new keycode to allow users invoke a context-aware desktop
assistant application.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 include/uapi/linux/input-event-codes.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
index f5a8d96e1e09..179891074b3c 100644
--- a/include/uapi/linux/input-event-codes.h
+++ b/include/uapi/linux/input-event-codes.h
@@ -600,6 +600,7 @@
 #define KEY_APPSELECT		0x244	/* AL Select Task/Application */
 #define KEY_SCREENSAVER		0x245	/* AL Screen Saver */
 #define KEY_VOICECOMMAND		0x246	/* Listening Voice Command */
+#define KEY_ASSISTANT		0x247	/* AL Context-aware desktop assistant */
 
 #define KEY_BRIGHTNESS_MIN		0x250	/* Set Brightness to Minimum */
 #define KEY_BRIGHTNESS_MAX		0x251	/* Set Brightness to Maximum */
-- 
2.13.2.725.g09c95d1e9-goog


-- 
Dmitry
