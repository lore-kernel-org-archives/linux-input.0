From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 1/2] input - wacom: Clean up device type code
Date: Wed, 31 Oct 2012 10:39:11 -0700
Message-ID: <1351705151-14360-1-git-send-email-pingc@wacom.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:64618 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965385Ab2JaRjX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 31 Oct 2012 13:39:23 -0400
Received: by mail-da0-f46.google.com with SMTP id n41so742983dak.19
        for <linux-input@vger.kernel.org>; Wed, 31 Oct 2012 10:39:23 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, Ping Cheng <pingc@wacom.com>, Ping Cheng <pinglinux@gmail.com>

Use switch instead of if statement to verify device types

Signed-off-by: Ping Cheng <pinglinux@gmail.com>
---
 drivers/input/tablet/wacom_sys.c |   53 +++++++++++++++++++++++++++-----------
 1 file changed, 38 insertions(+), 15 deletions(-)

diff --git a/drivers/input/tablet/wacom_sys.c b/drivers/input/tablet/wacom_sys.c
index 858ad44..67442f4 100644
--- a/drivers/input/tablet/wacom_sys.c
+++ b/drivers/input/tablet/wacom_sys.c
@@ -386,23 +386,36 @@ static int wacom_parse_hid(struct usb_interface *intf,
 				if (usage == WCM_DESKTOP) {
 					if (finger) {
 						features->device_type = BTN_TOOL_FINGER;
-						if (features->type == TABLETPC2FG) {
-							/* need to reset back */
+
+						switch (features->type) {
+						case TABLETPC2FG:
 							features->pktlen = WACOM_PKGLEN_TPC2FG;
-						}
+							break;
 
-						if (features->type == MTSCREEN || features->type == WACOM_24HDT)
+						case MTSCREEN:
+						case WACOM_24HDT:
 							features->pktlen = WACOM_PKGLEN_MTOUCH;
+							break;
 
-						if (features->type == BAMBOO_PT) {
-							/* need to reset back */
+						case BAMBOO_PT:
 							features->pktlen = WACOM_PKGLEN_BBTOUCH;
+							break;
+
+						default:
+							features->pktlen = WACOM_PKGLEN_GRAPHIRE;
+							break;
+						}
+
+						switch (features->type) {
+						case BAMBOO_PT:
 							features->x_phy =
 								get_unaligned_le16(&report[i + 5]);
 							features->x_max =
 								get_unaligned_le16(&report[i + 8]);
 							i += 15;
-						} else if (features->type == WACOM_24HDT) {
+							break;
+
+						case WACOM_24HDT:
 							features->x_max =
 								get_unaligned_le16(&report[i + 3]);
 							features->x_phy =
@@ -410,7 +423,9 @@ static int wacom_parse_hid(struct usb_interface *intf,
 							features->unit = report[i - 1];
 							features->unitExpo = report[i - 3];
 							i += 12;
-						} else {
+							break;
+
+						default:
 							features->x_max =
 								get_unaligned_le16(&report[i + 3]);
 							features->x_phy =
@@ -418,10 +433,11 @@ static int wacom_parse_hid(struct usb_interface *intf,
 							features->unit = report[i + 9];
 							features->unitExpo = report[i + 11];
 							i += 12;
+							break;
 						}
 					} else if (pen) {
 						/* penabled only accepts exact bytes of data */
-						if (features->type == TABLETPC2FG)
+						if (features->type >= TABLETPC)
 							features->pktlen = WACOM_PKGLEN_GRAPHIRE;
 						features->device_type = BTN_TOOL_PEN;
 						features->x_max =
@@ -434,32 +450,39 @@ static int wacom_parse_hid(struct usb_interface *intf,
 			case HID_USAGE_Y:
 				if (usage == WCM_DESKTOP) {
 					if (finger) {
-						int type = features->type;
-
-						if (type == TABLETPC2FG || type == MTSCREEN) {
+						switch (features->type) {
+						case TABLETPC2FG:
+						case MTSCREEN:
 							features->y_max =
 								get_unaligned_le16(&report[i + 3]);
 							features->y_phy =
 								get_unaligned_le16(&report[i + 6]);
 							i += 7;
-						} else if (type == WACOM_24HDT) {
+							break;
+
+						case WACOM_24HDT:
 							features->y_max =
 								get_unaligned_le16(&report[i + 3]);
 							features->y_phy =
 								get_unaligned_le16(&report[i - 2]);
 							i += 7;
-						} else if (type == BAMBOO_PT) {
+							break;
+
+						case BAMBOO_PT:
 							features->y_phy =
 								get_unaligned_le16(&report[i + 3]);
 							features->y_max =
 								get_unaligned_le16(&report[i + 6]);
 							i += 12;
-						} else {
+							break;
+
+						default:
 							features->y_max =
 								features->x_max;
 							features->y_phy =
 								get_unaligned_le16(&report[i + 3]);
 							i += 4;
+							break;
 						}
 					} else if (pen) {
 						features->y_max =
-- 
1.7.9.5

