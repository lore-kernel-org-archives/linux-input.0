From: Simon Wood <simon@mungewell.org>
Subject: [RFC 5/5] HID: Add vendor specific usage pages for Logitech G920
Date: Fri, 23 Oct 2015 11:27:27 -0600
Message-ID: <1445621247-18806-5-git-send-email-simon@mungewell.org>
References: <1445621247-18806-1-git-send-email-simon@mungewell.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445621247-18806-1-git-send-email-simon@mungewell.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Edwin <Edwin@Velds.nl>, =?UTF-8?q?Michal=20Mal=C3=BD?= <madcatxster@devoid-pointer.net>, elias vanderstuyft <elias.vds@gmail.com>, Simon Wood <simon@mungewell.org>
List-Id: linux-input@vger.kernel.org

The Logitech G920 uses a couple of vendor specific usage pages,
which results in incorrect number of axis/buttons being detected.

This patch adds these pages to the 'ignore' list.

Reported-by: Elias Vanderstuyft <elias.vds@gmail.com>
---
 drivers/hid/hid-input.c | 2 +-
 include/linux/hid.h     | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 53aeaf6..c120be5 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -959,7 +959,7 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 		set_bit(EV_REP, input->evbit);
 		goto ignore;
 
-	case HID_UP_LOGIVENDOR:
+	case HID_UP_LOGIVENDOR: case HID_UP_LOGIVENDOR2: case HID_UP_LOGIVENDOR3:
 		goto ignore;
 
 	case HID_UP_PID:
diff --git a/include/linux/hid.h b/include/linux/hid.h
index f17980d..ce1d883 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -168,6 +168,8 @@ struct hid_item {
 #define HID_UP_MSVENDOR		0xff000000
 #define HID_UP_CUSTOM		0x00ff0000
 #define HID_UP_LOGIVENDOR	0xffbc0000
+#define HID_UP_LOGIVENDOR2   0xff090000
+#define HID_UP_LOGIVENDOR3   0xff430000
 #define HID_UP_LNVENDOR		0xffa00000
 #define HID_UP_SENSOR		0x00200000
 
-- 
2.1.4
