From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH v2 16/17] HID: wiimote: Remove module version number
Date: Thu, 17 Nov 2011 14:12:13 +0100
Message-ID: <1321535534-7950-17-git-send-email-dh.herrmann@googlemail.com>
References: <1321535534-7950-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:44293 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932138Ab1KQNNK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 17 Nov 2011 08:13:10 -0500
Received: by mail-ey0-f174.google.com with SMTP id 27so1873323eye.19
        for <linux-input@vger.kernel.org>; Thu, 17 Nov 2011 05:13:09 -0800 (PST)
In-Reply-To: <1321535534-7950-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, oneukum@suse.de, David Herrmann <dh.herrmann@googlemail.com>

The version number is not needed at all for in-tree drivers. Upstream git is
used to track module versions.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
V2: Remove version number.

 drivers/hid/hid-wiimote-core.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-wiimote-core.c b/drivers/hid/hid-wiimote-core.c
index 745667e..0cb391d 100644
--- a/drivers/hid/hid-wiimote-core.c
+++ b/drivers/hid/hid-wiimote-core.c
@@ -22,8 +22,6 @@
 #include "hid-ids.h"
 #include "hid-wiimote.h"
 
-#define WIIMOTE_VERSION "0.2"
-
 enum wiiproto_keys {
 	WIIPROTO_KEY_LEFT,
 	WIIPROTO_KEY_RIGHT,
@@ -1314,4 +1312,3 @@ module_exit(wiimote_exit);
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("David Herrmann <dh.herrmann@gmail.com>");
 MODULE_DESCRIPTION(WIIMOTE_NAME " Device Driver");
-MODULE_VERSION(WIIMOTE_VERSION);
-- 
1.7.7.3

