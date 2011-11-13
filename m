From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 01/16] HID: wiimote: Rename driver to allow multiple source files
Date: Sun, 13 Nov 2011 14:27:04 +0100
Message-ID: <1321190839-3517-2-git-send-email-dh.herrmann@googlemail.com>
References: <1321190839-3517-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:43554 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752296Ab1KMN15 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 13 Nov 2011 08:27:57 -0500
Received: by bke11 with SMTP id 11so4910956bke.19
        for <linux-input@vger.kernel.org>; Sun, 13 Nov 2011 05:27:56 -0800 (PST)
In-Reply-To: <1321190839-3517-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, David Herrmann <dh.herrmann@googlemail.com>

Extension and sound support for the wiimote are quite complex and will be
implemented in separate source files. Hence rename the current driver to "-core"
suffix so multiple files can be linked into this module.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 drivers/hid/Makefile                              |    2 ++
 drivers/hid/{hid-wiimote.c => hid-wiimote-core.c} |    0
 2 files changed, 2 insertions(+), 0 deletions(-)
 rename drivers/hid/{hid-wiimote.c => hid-wiimote-core.c} (100%)

diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index 0a0a38e..07e750a 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -25,6 +25,8 @@ ifdef CONFIG_LOGIWII_FF
 	hid-logitech-y	+= hid-lg4ff.o
 endif
 
+hid-wiimote-y		:= hid-wiimote-core.o
+
 obj-$(CONFIG_HID_A4TECH)	+= hid-a4tech.o
 obj-$(CONFIG_HID_ACRUX)		+= hid-axff.o
 obj-$(CONFIG_HID_APPLE)		+= hid-apple.o
diff --git a/drivers/hid/hid-wiimote.c b/drivers/hid/hid-wiimote-core.c
similarity index 100%
rename from drivers/hid/hid-wiimote.c
rename to drivers/hid/hid-wiimote-core.c
-- 
1.7.7.3

