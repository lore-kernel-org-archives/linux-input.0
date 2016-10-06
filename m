From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH 05/19] HID: wacom: generic: Strip off excessive name prefixing
Date: Thu,  6 Oct 2016 14:22:17 -0700
Message-ID: <20161006212231.31440-6-killertofu@gmail.com>
References: <20161006212231.31440-1-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qk0-f195.google.com ([209.85.220.195]:36468 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935171AbcJFVWt (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 6 Oct 2016 17:22:49 -0400
Received: by mail-qk0-f195.google.com with SMTP id z190so1660593qkc.3
        for <linux-input@vger.kernel.org>; Thu, 06 Oct 2016 14:22:49 -0700 (PDT)
In-Reply-To: <20161006212231.31440-1-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Ping Cheng <pinglinux@gmail.com>, Ping Cheng <ping.cheng@wacom.com>, Aaron Skomra <skomra@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>, Jason Gerecke <killertofu@gmail.com>

The product name received from the string descriptor in the new MobileStudio
Pro line of tablets begins with "Wacom", which leads to unnecessary visual
noise in the device name when appended to the vendor name which also includes
"Wacom". Look for and fix cases like this.

Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
---
 drivers/hid/wacom_sys.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 033cc03..7b9bff2 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -1940,6 +1940,19 @@ static void wacom_update_name(struct wacom *wacom, const char *suffix)
 				/* shift everything including the terminator */
 				memmove(gap, gap+1, strlen(gap));
 			}
+
+			/* strip off excessive prefixing */
+			if (strstr(name, "Wacom Co.,Ltd. Wacom ") == name) {
+				int n = strlen(name);
+				int x = strlen("Wacom Co.,Ltd. ");
+				memmove(name, name+x, n-x+1);
+			}
+			if (strstr(name, "Wacom Co., Ltd. Wacom ") == name) {
+				int n = strlen(name);
+				int x = strlen("Wacom Co., Ltd. ");
+				memmove(name, name+x, n-x+1);
+			}
+
 			/* get rid of trailing whitespace */
 			if (name[strlen(name)-1] == ' ')
 				name[strlen(name)-1] = '\0';
-- 
2.10.0

