From: Simon Wood <simon@mungewell.org>
Subject: [Patch-V2 5/6] HID: Add vendor specific usage pages for Logitech G920
Date: Thu, 12 Nov 2015 09:25:34 -0700
Message-ID: <1447345535-2912-6-git-send-email-simon@mungewell.org>
References: <1447345535-2912-1-git-send-email-simon@mungewell.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1447345535-2912-1-git-send-email-simon@mungewell.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Edwin <Edwin@Velds.nl>, =?UTF-8?q?Michal=20Mal=C3=BD?= <madcatxster@devoid-pointer.net>, elias vanderstuyft <elias.vds@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Simon Wood <simon@mungewell.org>
List-Id: linux-input@vger.kernel.org

The Logitech G920 uses a couple of vendor specific usage pages,
which results in incorrect number of axis/buttons being detected.

This patch adds these pages to the 'ignore' list.

Reported-by: Elias Vanderstuyft <elias.vds@gmail.com>
Signed-off-by: Simon Wood <simon@mungewell.org>
---
 drivers/hid/hid-input.c | 4 ++++
 include/linux/hid.h     | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 2ba6bf6..f4eeb6b 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -960,6 +960,10 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 		goto ignore;
 
 	case HID_UP_LOGIVENDOR:
+		/* intentional fallback */
+	case HID_UP_LOGIVENDOR2:
+		/* intentional fallback */
+	case HID_UP_LOGIVENDOR3:
 		goto ignore;
 
 	case HID_UP_PID:
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 251a1d3..a6d7a3f 100644
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
