From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 1/4] input: wacom - use BTN_TOOL_FINGER to indicate touch device type
Date: Fri, 16 Dec 2011 16:36:59 -0800
Message-ID: <1324082219-32686-1-git-send-email-pinglinux@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:59961 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750963Ab1LQAfM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 16 Dec 2011 19:35:12 -0500
Received: by iaeh11 with SMTP id h11so5096129iae.19
        for <linux-input@vger.kernel.org>; Fri, 16 Dec 2011 16:35:11 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Ping Cheng <pinglinux@gmail.com>, Ping Cheng <pingc@wacom.com>

Signed-off-by: Ping Cheng <pingc@wacom.com>
---
 drivers/input/tablet/wacom_sys.c |    6 +-----
 drivers/input/tablet/wacom_wac.c |    4 ++--
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/input/tablet/wacom_sys.c b/drivers/input/tablet/wacom_sys.c
index 7e63183..c9588ee 100644
--- a/drivers/input/tablet/wacom_sys.c
+++ b/drivers/input/tablet/wacom_sys.c
@@ -176,7 +176,7 @@ static int wacom_parse_logical_collection(unsigned char *report,
 
 		/* Logical collection is only used by 3rd gen Bamboo Touch */
 		features->pktlen = WACOM_PKGLEN_BBTOUCH3;
-		features->device_type = BTN_TOOL_DOUBLETAP;
+		features->device_type = BTN_TOOL_FINGER;
 
 		/*
 		 * Stylus and Touch have same active area
@@ -286,12 +286,10 @@ static int wacom_parse_hid(struct usb_interface *intf,
 						if (features->type == TABLETPC2FG) {
 							/* need to reset back */
 							features->pktlen = WACOM_PKGLEN_TPC2FG;
-							features->device_type = BTN_TOOL_DOUBLETAP;
 						}
 						if (features->type == BAMBOO_PT) {
 							/* need to reset back */
 							features->pktlen = WACOM_PKGLEN_BBTOUCH;
-							features->device_type = BTN_TOOL_DOUBLETAP;
 							features->x_phy =
 								get_unaligned_le16(&report[i + 5]);
 							features->x_max =
@@ -325,7 +323,6 @@ static int wacom_parse_hid(struct usb_interface *intf,
 						if (features->type == TABLETPC2FG) {
 							/* need to reset back */
 							features->pktlen = WACOM_PKGLEN_TPC2FG;
-							features->device_type = BTN_TOOL_DOUBLETAP;
 							features->y_max =
 								get_unaligned_le16(&report[i + 3]);
 							features->y_phy =
@@ -334,7 +331,6 @@ static int wacom_parse_hid(struct usb_interface *intf,
 						} else if (features->type == BAMBOO_PT) {
 							/* need to reset back */
 							features->pktlen = WACOM_PKGLEN_BBTOUCH;
-							features->device_type = BTN_TOOL_DOUBLETAP;
 							features->y_phy =
 								get_unaligned_le16(&report[i + 3]);
 							features->y_max =
diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index a22e778..e18f362 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -1317,7 +1317,7 @@ void wacom_setup_input_capabilities(struct input_dev *input_dev,
 		break;
 
 	case TABLETPC2FG:
-		if (features->device_type == BTN_TOOL_DOUBLETAP) {
+		if (features->device_type == BTN_TOOL_FINGER) {
 
 			input_mt_init_slots(input_dev, 2);
 			input_set_abs_params(input_dev, ABS_MT_TOOL_TYPE,
@@ -1366,7 +1366,7 @@ void wacom_setup_input_capabilities(struct input_dev *input_dev,
 
 		__set_bit(INPUT_PROP_POINTER, input_dev->propbit);
 
-		if (features->device_type == BTN_TOOL_DOUBLETAP) {
+		if (features->device_type == BTN_TOOL_FINGER) {
 			__set_bit(BTN_LEFT, input_dev->keybit);
 			__set_bit(BTN_FORWARD, input_dev->keybit);
 			__set_bit(BTN_BACK, input_dev->keybit);
-- 
1.7.6.4

