From: Simon Que <sque@chromium.org>
Subject: [PATCH v2] hid: Fix uninitialized variable "size" in hid-wiimote-debug
Date: Thu, 17 Jan 2013 13:02:52 -0800
Message-ID: <1358456572-22851-1-git-send-email-sque@chromium.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oa0-f74.google.com ([209.85.219.74]:64258 "EHLO
	mail-oa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751814Ab3AQVDG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 17 Jan 2013 16:03:06 -0500
Received: by mail-oa0-f74.google.com with SMTP id k14so783326oag.3
        for <linux-input@vger.kernel.org>; Thu, 17 Jan 2013 13:03:05 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz, dh.herrmann@googlemail.com, linux-input@vger.kernel.org
Cc: msb@chromium.org, Simon Que <sque@chromium.org>

This variable is initialized conditionally, based on whether a wiimote
call succeeds.  However, the logic is not obvious to the compiler so it
throws a warning.  Eliminate the warning by initializing "size" to 0.

The warning is:
files/drivers/hid/hid-wiimote-debug.c:69:18: warning: 'size' may be used
uninitialized in this function [-Wmaybe-uninitialized]

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

