From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH 01/19] HID: wacom: Update vendor-defined usage names to better match standards
Date: Thu,  6 Oct 2016 14:22:13 -0700
Message-ID: <20161006212231.31440-2-killertofu@gmail.com>
References: <20161006212231.31440-1-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qt0-f193.google.com ([209.85.216.193]:35251 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935071AbcJFVWn (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 6 Oct 2016 17:22:43 -0400
Received: by mail-qt0-f193.google.com with SMTP id g49so834719qtc.2
        for <linux-input@vger.kernel.org>; Thu, 06 Oct 2016 14:22:43 -0700 (PDT)
In-Reply-To: <20161006212231.31440-1-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Ping Cheng <pinglinux@gmail.com>, Ping Cheng <ping.cheng@wacom.com>, Aaron Skomra <skomra@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>, Jason Gerecke <killertofu@gmail.com>

Our loose use of "pen" and "digitizer" in the naming of several of our
vendor-defined usages may be a source of confusion given that the terms
have specific meaning within the HID specification. "Pen" specifically
refers to "an integrated display that allows the use of a stylus" (e.g.
something like a tablet PC or Cintiq) wheras "Digitizer" is a better
fit for opaque tablets like an Intuos.

While we're at it, go ahead and rename the definitions to make them more
distinct and better match up with the convention used by HID (e.g. the use
of '_UP_' for usage pages) and make them more distinct.

Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
---
 drivers/hid/wacom_sys.c | 12 ++++++------
 drivers/hid/wacom_wac.c |  2 +-
 drivers/hid/wacom_wac.h | 17 +++++++++--------
 3 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 5e7a564..773fa11 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -159,18 +159,18 @@ static void wacom_feature_mapping(struct hid_device *hdev,
 
 	case HID_UP_DIGITIZER:
 		if (field->report->id == 0x0B &&
-		    (field->application == WACOM_G9_DIGITIZER ||
-		     field->application == WACOM_G11_DIGITIZER)) {
+		    (field->application == WACOM_HID_G9_PEN ||
+		     field->application == WACOM_HID_G11_PEN)) {
 			wacom->wacom_wac.mode_report = field->report->id;
 			wacom->wacom_wac.mode_value = 0;
 		}
 		break;
 
-	case WACOM_G9_PAGE:
-	case WACOM_G11_PAGE:
+	case WACOM_HID_UP_G9:
+	case WACOM_HID_UP_G11:
 		if (field->report->id == 0x03 &&
-		    (field->application == WACOM_G9_TOUCHSCREEN ||
-		     field->application == WACOM_G11_TOUCHSCREEN)) {
+		    (field->application == WACOM_HID_G9_TOUCHSCREEN ||
+		     field->application == WACOM_HID_G11_TOUCHSCREEN)) {
 			wacom->wacom_wac.mode_report = field->report->id;
 			wacom->wacom_wac.mode_value = 0;
 		}
diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index a48ed4e..e09830c 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -2458,7 +2458,7 @@ void wacom_setup_device_quirks(struct wacom *wacom)
 	/*
 	 * Raw Wacom-mode pen and touch events both come from interface
 	 * 0, whose HID descriptor has an application usage of 0xFF0D
-	 * (i.e., WACOM_VENDORDEFINED_PEN). We route pen packets back
+	 * (i.e., WACOM_HID_WD_DIGITIZER). We route pen packets back
 	 * out through the HID_GENERIC device created for interface 1,
 	 * so rewrite this one to be of type WACOM_DEVICETYPE_TOUCH.
 	 */
diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
index de5d1ad..3592186 100644
--- a/drivers/hid/wacom_wac.h
+++ b/drivers/hid/wacom_wac.h
@@ -84,20 +84,21 @@
 #define WACOM_DEVICETYPE_WL_MONITOR     0x0008
 #define WACOM_DEVICETYPE_DIRECT         0x0010
 
-#define WACOM_VENDORDEFINED_PEN		0xff0d0001
-#define WACOM_G9_PAGE			0xff090000
-#define WACOM_G9_DIGITIZER		(WACOM_G9_PAGE | 0x02)
-#define WACOM_G9_TOUCHSCREEN		(WACOM_G9_PAGE | 0x11)
-#define WACOM_G11_PAGE			0xff110000
-#define WACOM_G11_DIGITIZER		(WACOM_G11_PAGE | 0x02)
-#define WACOM_G11_TOUCHSCREEN		(WACOM_G11_PAGE | 0x11)
+#define WACOM_HID_UP_WACOMDIGITIZER     0xff0d0000
+#define WACOM_HID_WD_DIGITIZER          (WACOM_HID_UP_WACOMDIGITIZER | 0x01)
+#define WACOM_HID_UP_G9                 0xff090000
+#define WACOM_HID_G9_PEN                (WACOM_HID_UP_G9 | 0x02)
+#define WACOM_HID_G9_TOUCHSCREEN        (WACOM_HID_UP_G9 | 0x11)
+#define WACOM_HID_UP_G11                0xff110000
+#define WACOM_HID_G11_PEN               (WACOM_HID_UP_G11 | 0x02)
+#define WACOM_HID_G11_TOUCHSCREEN       (WACOM_HID_UP_G11 | 0x11)
 
 #define WACOM_PEN_FIELD(f)	(((f)->logical == HID_DG_STYLUS) || \
 				 ((f)->physical == HID_DG_STYLUS) || \
 				 ((f)->physical == HID_DG_PEN) || \
 				 ((f)->application == HID_DG_PEN) || \
 				 ((f)->application == HID_DG_DIGITIZER) || \
-				 ((f)->application == WACOM_VENDORDEFINED_PEN))
+				 ((f)->application == WACOM_HID_WD_DIGITIZER))
 #define WACOM_FINGER_FIELD(f)	(((f)->logical == HID_DG_FINGER) || \
 				 ((f)->physical == HID_DG_FINGER) || \
 				 ((f)->application == HID_DG_TOUCHSCREEN))
-- 
2.10.0

