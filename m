From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] HID: picolcd: Fix build error due to redefinition of
 'picolcd_debug_raw_event'
Date: Tue, 11 Sep 2012 20:29:53 +0800
Message-ID: <1347366593.7690.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:44478 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751172Ab2IKMaC (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 11 Sep 2012 08:30:02 -0400
Received: by oago6 with SMTP id o6so190286oag.19
        for <linux-input@vger.kernel.org>; Tue, 11 Sep 2012 05:30:01 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Bruno =?ISO-8859-1?Q?Pr=E9mont?= <bonbons@linux-vserver.org>, linux-input@vger.kernel.org

Current code missed the definition for picolcd_debug_raw_event, but add
definition for picolcd_debug_raw_event twice.

This patch fixes below build error:
  CC [M]  drivers/hid/hid-picolcd_core.o
In file included from drivers/hid/hid-picolcd_core.c:34:0:
drivers/hid/hid-picolcd.h:176:20: error: redefinition of 'picolcd_debug_raw_event'
drivers/hid/hid-picolcd.h:162:20: note: previous definition of 'picolcd_debug_raw_event' was here
make[2]: *** [drivers/hid/hid-picolcd_core.o] Error 1
make[1]: *** [drivers/hid] Error 2
make: *** [drivers] Error 2

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 drivers/hid/hid-picolcd.h |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-picolcd.h b/drivers/hid/hid-picolcd.h
index 240eb1c..020cef6 100644
--- a/drivers/hid/hid-picolcd.h
+++ b/drivers/hid/hid-picolcd.h
@@ -159,6 +159,10 @@ void picolcd_init_devfs(struct picolcd_data *data,
 
 void picolcd_exit_devfs(struct picolcd_data *data);
 #else
+static inline void picolcd_debug_out_report(struct picolcd_data *data,
+		struct hid_device *hdev, struct hid_report *report)
+{
+}
 static inline void picolcd_debug_raw_event(struct picolcd_data *data,
 		struct hid_device *hdev, struct hid_report *report,
 		u8 *raw_data, int size)
@@ -173,11 +177,6 @@ static inline void picolcd_init_devfs(struct picolcd_data *data,
 static inline void picolcd_exit_devfs(struct picolcd_data *data)
 {
 }
-static inline void picolcd_debug_raw_event(struct picolcd_data *data,
-		struct hid_device *hdev, struct hid_report *report,
-		u8 *raw_data, int size)
-{
-}
 #endif /* CONFIG_DEBUG_FS */
 
 
-- 
1.7.9.5



