From: Chris Chiu <chiu@endlessm.com>
Subject: [PATCH 1/2] HID: use macros in IS_INPUT_APPLICATION
Date: Mon,  3 Dec 2018 14:46:20 +0800
Message-ID: <20181203064621.69876-1-chiu@endlessm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jikos@kernel.org, benjamin.tissoires@redhat.com, rydberg@bitmath.org
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux@endlessm.com
List-Id: linux-input@vger.kernel.org

Add missing definition for HID_DG_WHITEBOARD then replace the hid
usage hex with macros for better readibility.

Signed-off-by: Chris Chiu <chiu@endlessm.com>
---
 include/linux/hid.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/linux/hid.h b/include/linux/hid.h
index a355d61940f2..ce5f996c8d3d 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -238,6 +238,7 @@ struct hid_item {
 #define HID_DG_LIGHTPEN		0x000d0003
 #define HID_DG_TOUCHSCREEN	0x000d0004
 #define HID_DG_TOUCHPAD		0x000d0005
+#define HID_DG_WHITEBOARD	0x000d0006
 #define HID_DG_STYLUS		0x000d0020
 #define HID_DG_PUCK		0x000d0021
 #define HID_DG_FINGER		0x000d0022
@@ -836,7 +837,10 @@ static inline bool hid_is_using_ll_driver(struct hid_device *hdev,
 
 /* Applications from HID Usage Tables 4/8/99 Version 1.1 */
 /* We ignore a few input applications that are not widely used */
-#define IS_INPUT_APPLICATION(a) (((a >= 0x00010000) && (a <= 0x00010008)) || (a == 0x00010080) || (a == 0x000c0001) || ((a >= 0x000d0002) && (a <= 0x000d0006)))
+#define IS_INPUT_APPLICATION(a) \
+		(((a >= HID_UP_GENDESK) && (a <= HID_GD_MULTIAXIS)) \
+		|| ((a >= HID_DG_PEN) && (a <= HID_DG_WHITEBOARD)) \
+		|| (a == HID_GD_SYSTEM_CONTROL) || (a == HID_CP_CONSUMER_CONTROL))
 
 /* HID core API */
 
-- 
2.19.1
