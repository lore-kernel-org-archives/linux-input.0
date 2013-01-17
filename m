From: Simon Que <sque@chromium.org>
Subject: [PATCH] hid: Fix uninitialized variable "size" in hid-wiimote-debug
Date: Thu, 17 Jan 2013 11:47:27 -0800
Message-ID: <1358452047-15451-1-git-send-email-sque@chromium.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ia0-f202.google.com ([209.85.210.202]:65098 "EHLO
	mail-ia0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755389Ab3AQUKg (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 17 Jan 2013 15:10:36 -0500
Received: by mail-ia0-f202.google.com with SMTP id p22so186060iad.3
        for <linux-input@vger.kernel.org>; Thu, 17 Jan 2013 12:10:36 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dh.herrmann@googlemail.com, linux-input@vger.kernel.org
Cc: msb@chromium.org, Simon Que <sque@chromium.org>

This variable is initialized conditionally, based on whether a wiimote
call succeeds.  However, the logic is not obvious to the compiler so it
throws a warning.  Eliminate the warning by initializing "size" to 0.

Signed-off-by: Simon Que <sque@chromium.org>
---
 drivers/hid/hid-wiimote-debug.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hid/hid-wiimote-debug.c b/drivers/hid/hid-wiimote-debug.c
index eec3291..90124ff 100644
--- a/drivers/hid/hid-wiimote-debug.c
+++ b/drivers/hid/hid-wiimote-debug.c
@@ -31,7 +31,7 @@ static ssize_t wiidebug_eeprom_read(struct file *f, char __user *u, size_t s,
 	unsigned long flags;
 	ssize_t ret;
 	char buf[16];
-	__u16 size;
+	__u16 size = 0;
 
 	if (s == 0)
 		return -EINVAL;
-- 
1.7.8.6

