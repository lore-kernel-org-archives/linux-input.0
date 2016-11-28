From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH] HID: change KEY_DATA from 0x275 to 0x277
Date: Mon, 28 Nov 2016 12:49:24 -0800
Message-ID: <1480366164-18706-1-git-send-email-pingc@wacom.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35623 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752677AbcK1Utq (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 28 Nov 2016 15:49:46 -0500
Received: by mail-pf0-f195.google.com with SMTP id i88so6945765pfk.2
        for <linux-input@vger.kernel.org>; Mon, 28 Nov 2016 12:49:46 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, dmitry.torokhov@gmail.com, Ping Cheng <pingc@wacom.com>, Ping Cheng <ping.cheng@wacom.com>

0x275 is used by KEY_FASTREVERSE. Or, was that on purpose to use
the same value as KEY_FASTREVERSE for KEY_DATA?

Signed-off-by: Ping Cheng <ping.cheng@wacom.com>
---
 include/uapi/linux/input-event-codes.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
index d6d071f..3af60ee 100644
--- a/include/uapi/linux/input-event-codes.h
+++ b/include/uapi/linux/input-event-codes.h
@@ -640,7 +640,7 @@
  * Control a data application associated with the currently viewed channel,
  * e.g. teletext or data broadcast application (MHEG, MHP, HbbTV, etc.)
  */
-#define KEY_DATA			0x275
+#define KEY_DATA			0x277
 
 #define BTN_TRIGGER_HAPPY		0x2c0
 #define BTN_TRIGGER_HAPPY1		0x2c0
-- 
2.7.4

