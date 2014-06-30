From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 15/15] Input - wacom: keep wacom_ids ordered
Date: Mon, 30 Jun 2014 17:26:26 -0400
Message-ID: <1404163586-29582-16-git-send-email-benjamin.tissoires@redhat.com>
References: <1404163586-29582-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1404163586-29582-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Ping Cheng <pinglinux@gmail.com>, Jason Gerecke <killertofu@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linuxwacom-devel@lists.sourceforge.net
List-Id: linux-input@vger.kernel.org

No Functional changes, just some reordering.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/input/tablet/wacom_wac.c | 75 ++++++++++++++++++++--------------------
 1 file changed, 37 insertions(+), 38 deletions(-)

diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index 15b0132..de033d5 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -2418,6 +2418,7 @@ static const struct wacom_features wacom_features_0x0309 =
 
 const struct hid_device_id wacom_ids[] = {
 	{ USB_DEVICE_WACOM(0x00) },
+	{ USB_DEVICE_WACOM(0x03) },
 	{ USB_DEVICE_WACOM(0x10) },
 	{ USB_DEVICE_WACOM(0x11) },
 	{ USB_DEVICE_WACOM(0x12) },
@@ -2428,20 +2429,16 @@ const struct hid_device_id wacom_ids[] = {
 	{ USB_DEVICE_WACOM(0x17) },
 	{ USB_DEVICE_WACOM(0x18) },
 	{ USB_DEVICE_WACOM(0x19) },
-	{ USB_DEVICE_WACOM(0x60) },
-	{ USB_DEVICE_WACOM(0x61) },
-	{ USB_DEVICE_WACOM(0x62) },
-	{ USB_DEVICE_WACOM(0x63) },
-	{ USB_DEVICE_WACOM(0x64) },
-	{ USB_DEVICE_WACOM(0x65) },
-	{ USB_DEVICE_WACOM(0x69) },
-	{ USB_DEVICE_WACOM(0x6A) },
-	{ USB_DEVICE_WACOM(0x6B) },
 	{ USB_DEVICE_WACOM(0x20) },
 	{ USB_DEVICE_WACOM(0x21) },
 	{ USB_DEVICE_WACOM(0x22) },
 	{ USB_DEVICE_WACOM(0x23) },
 	{ USB_DEVICE_WACOM(0x24) },
+	{ USB_DEVICE_WACOM(0x26) },
+	{ USB_DEVICE_WACOM(0x27) },
+	{ USB_DEVICE_WACOM(0x28) },
+	{ USB_DEVICE_WACOM(0x29) },
+	{ USB_DEVICE_WACOM(0x2A) },
 	{ USB_DEVICE_WACOM(0x30) },
 	{ USB_DEVICE_WACOM(0x31) },
 	{ USB_DEVICE_WACOM(0x32) },
@@ -2451,20 +2448,33 @@ const struct hid_device_id wacom_ids[] = {
 	{ USB_DEVICE_WACOM(0x37) },
 	{ USB_DEVICE_WACOM(0x38) },
 	{ USB_DEVICE_WACOM(0x39) },
-	{ USB_DEVICE_WACOM(0xC4) },
-	{ USB_DEVICE_WACOM(0xC0) },
-	{ USB_DEVICE_WACOM(0xC2) },
-	{ USB_DEVICE_WACOM(0x03) },
+	{ USB_DEVICE_WACOM(0x3F) },
 	{ USB_DEVICE_WACOM(0x41) },
 	{ USB_DEVICE_WACOM(0x42) },
 	{ USB_DEVICE_WACOM(0x43) },
 	{ USB_DEVICE_WACOM(0x44) },
 	{ USB_DEVICE_WACOM(0x45) },
+	{ USB_DEVICE_WACOM(0x47) },
 	{ USB_DEVICE_WACOM(0x57) },
 	{ USB_DEVICE_WACOM(0x59) },
-	{ USB_DEVICE_WACOM(0x5D) },
 	{ USB_DEVICE_WACOM(0x5B) },
+	{ USB_DEVICE_WACOM(0x5D) },
 	{ USB_DEVICE_WACOM(0x5E) },
+	{ USB_DEVICE_WACOM(0x60) },
+	{ USB_DEVICE_WACOM(0x61) },
+	{ USB_DEVICE_WACOM(0x62) },
+	{ USB_DEVICE_WACOM(0x63) },
+	{ USB_DEVICE_WACOM(0x64) },
+	{ USB_DEVICE_WACOM(0x65) },
+	{ USB_DEVICE_WACOM(0x69) },
+	{ USB_DEVICE_WACOM(0x6A) },
+	{ USB_DEVICE_WACOM(0x6B) },
+	{ USB_DEVICE_WACOM(0x84) },
+	{ USB_DEVICE_WACOM(0x90) },
+	{ USB_DEVICE_WACOM(0x93) },
+	{ USB_DEVICE_WACOM(0x97) },
+	{ USB_DEVICE_WACOM(0x9A) },
+	{ USB_DEVICE_WACOM(0x9F) },
 	{ USB_DEVICE_WACOM(0xB0) },
 	{ USB_DEVICE_WACOM(0xB1) },
 	{ USB_DEVICE_WACOM(0xB2) },
@@ -2477,17 +2487,14 @@ const struct hid_device_id wacom_ids[] = {
 	{ USB_DEVICE_WACOM(0xBA) },
 	{ USB_DEVICE_WACOM(0xBB) },
 	{ USB_DEVICE_WACOM(0xBC) },
-	{ USB_DEVICE_WACOM(0x26) },
-	{ USB_DEVICE_WACOM(0x27) },
-	{ USB_DEVICE_WACOM(0x28) },
-	{ USB_DEVICE_WACOM(0x29) },
-	{ USB_DEVICE_WACOM(0x2A) },
-	{ USB_DEVICE_WACOM(0x3F) },
+	{ USB_DEVICE_WACOM(0xC0) },
+	{ USB_DEVICE_WACOM(0xC2) },
+	{ USB_DEVICE_WACOM(0xC4) },
 	{ USB_DEVICE_WACOM(0xC5) },
 	{ USB_DEVICE_WACOM(0xC6) },
 	{ USB_DEVICE_WACOM(0xC7) },
+	{ USB_DEVICE_WACOM(0xCC) },
 	{ USB_DEVICE_WACOM(0xCE) },
-	{ USB_DEVICE_WACOM(0x84) },
 	{ USB_DEVICE_WACOM(0xD0) },
 	{ USB_DEVICE_WACOM(0xD1) },
 	{ USB_DEVICE_WACOM(0xD2) },
@@ -2502,13 +2509,6 @@ const struct hid_device_id wacom_ids[] = {
 	{ USB_DEVICE_WACOM(0xDD) },
 	{ USB_DEVICE_WACOM(0xDE) },
 	{ USB_DEVICE_WACOM(0xDF) },
-	{ USB_DEVICE_WACOM(0xF0) },
-	{ USB_DEVICE_WACOM(0xCC) },
-	{ USB_DEVICE_WACOM(0x90) },
-	{ USB_DEVICE_WACOM(0x93) },
-	{ USB_DEVICE_WACOM(0x97) },
-	{ USB_DEVICE_WACOM(0x9A) },
-	{ USB_DEVICE_WACOM(0x9F) },
 	{ USB_DEVICE_WACOM(0xE2) },
 	{ USB_DEVICE_WACOM(0xE3) },
 	{ USB_DEVICE_WACOM(0xE5) },
@@ -2516,6 +2516,12 @@ const struct hid_device_id wacom_ids[] = {
 	{ USB_DEVICE_WACOM(0xEC) },
 	{ USB_DEVICE_WACOM(0xED) },
 	{ USB_DEVICE_WACOM(0xEF) },
+	{ USB_DEVICE_WACOM(0xF0) },
+	{ USB_DEVICE_WACOM(0xF4) },
+	{ USB_DEVICE_WACOM(0xF6) },
+	{ USB_DEVICE_WACOM(0xF8) },
+	{ USB_DEVICE_WACOM(0xFA) },
+	{ USB_DEVICE_WACOM(0xFB) },
 	{ USB_DEVICE_WACOM(0x100) },
 	{ USB_DEVICE_WACOM(0x101) },
 	{ USB_DEVICE_WACOM(0x10D) },
@@ -2526,8 +2532,10 @@ const struct hid_device_id wacom_ids[] = {
 	{ USB_DEVICE_WACOM(0x301) },
 	{ USB_DEVICE_WACOM(0x302) },
 	{ USB_DEVICE_WACOM(0x303) },
-	{ USB_DEVICE_WACOM(0x30E) },
 	{ USB_DEVICE_WACOM(0x304) },
+	{ USB_DEVICE_WACOM(0x307) },
+	{ USB_DEVICE_WACOM(0x309) },
+	{ USB_DEVICE_WACOM(0x30E) },
 	{ USB_DEVICE_WACOM(0x314) },
 	{ USB_DEVICE_WACOM(0x315) },
 	{ USB_DEVICE_WACOM(0x317) },
@@ -2535,15 +2543,6 @@ const struct hid_device_id wacom_ids[] = {
 	{ USB_DEVICE_WACOM(0x4004) },
 	{ USB_DEVICE_WACOM(0x5000) },
 	{ USB_DEVICE_WACOM(0x5002) },
-	{ USB_DEVICE_WACOM(0x47) },
-	{ USB_DEVICE_WACOM(0xF4) },
-	{ USB_DEVICE_WACOM(0xF8) },
-	{ USB_DEVICE_WACOM(0xF6) },
-	{ USB_DEVICE_WACOM(0xFA) },
-	{ USB_DEVICE_WACOM(0xFB) },
-	{ USB_DEVICE_WACOM(0x0307) },
-	{ USB_DEVICE_WACOM(0x0309) },
-	{ USB_DEVICE_LENOVO(0x6004) },
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, wacom_ids);
-- 
2.0.0
