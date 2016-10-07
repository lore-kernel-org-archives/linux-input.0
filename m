From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH v2 05/18] HID: wacom: generic: Strip off excessive name prefixing
Date: Fri,  7 Oct 2016 15:16:40 -0700
Message-ID: <20161007221653.26941-5-killertofu@gmail.com>
References: <20161006212231.31440-1-killertofu@gmail.com>
 <20161007221653.26941-1-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qk0-f194.google.com ([209.85.220.194]:35571 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757213AbcJGWSB (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 7 Oct 2016 18:18:01 -0400
Received: by mail-qk0-f194.google.com with SMTP id v138so2086873qka.2
        for <linux-input@vger.kernel.org>; Fri, 07 Oct 2016 15:17:11 -0700 (PDT)
In-Reply-To: <20161007221653.26941-1-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Ping Cheng <pinglinux@gmail.com>, Ping Cheng <ping.cheng@wacom.com>, Aaron Skomra <skomra@gmail.com>, Jason Gerecke <killertofu@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

The product name received from the string descriptor in the new MobileStudio
Pro line of tablets begins with "Wacom", which leads to unnecessary visual
noise in the device name when appended to the vendor name which also includes
"Wacom". Look for and fix cases like this.

Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
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

