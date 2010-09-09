From: chris@cnpbagwell.com
Subject: [PATCH 1/4] input: wacom - Request tablet data for Bamboo Pens
Date: Wed,  8 Sep 2010 23:02:29 -0500
Message-ID: <1284004952-12701-2-git-send-email-chris@cnpbagwell.com>
References: <1284004952-12701-1-git-send-email-chris@cnpbagwell.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:57346 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750856Ab0IIECo (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 9 Sep 2010 00:02:44 -0400
Received: by gwj17 with SMTP id 17so426044gwj.19
        for <linux-input@vger.kernel.org>; Wed, 08 Sep 2010 21:02:43 -0700 (PDT)
In-Reply-To: <1284004952-12701-1-git-send-email-chris@cnpbagwell.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, pingc@wacom.com
Cc: Chris Bagwell <chris@cnpbagwell.com>

From: Chris Bagwell <chris@cnpbagwell.com>

Bamboo P&T need to use second form of usb_set_report() to
ask to report tablet data.

With previous addition of Bamboo Touch, BTN_TOOL_TRIPLETAP is now used
for both TABLETPC2FG and BAMBOO_PT types.  So reduced check to
match type=TABLETPC2FG.

This change shows redundant check for !TABLETPC2FG in else statement.

Signed-off-by: Chris Bagwell <chris@cnpbagwell.com>
---
 drivers/input/tablet/wacom_sys.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/input/tablet/wacom_sys.c b/drivers/input/tablet/wacom_sys.c
index fc6fd53..1e3af29 100644
--- a/drivers/input/tablet/wacom_sys.c
+++ b/drivers/input/tablet/wacom_sys.c
@@ -319,8 +319,9 @@ static int wacom_query_tablet_data(struct usb_interface *intf, struct wacom_feat
 	if (!rep_data)
 		return error;
 
-	/* ask to report tablet data if it is 2FGT or not a Tablet PC */
-	if (features->device_type == BTN_TOOL_TRIPLETAP) {
+	/* ask to report tablet data if it is 2FGT Tablet PC or
+	 * not a Tablet PC */
+	if (features->type == TABLETPC2FG) {
 		do {
 			rep_data[0] = 3;
 			rep_data[1] = 4;
@@ -332,7 +333,7 @@ static int wacom_query_tablet_data(struct usb_interface *intf, struct wacom_feat
 					WAC_HID_FEATURE_REPORT, report_id,
 					rep_data, 3);
 		} while ((error < 0 || rep_data[1] != 4) && limit++ < 5);
-	} else if (features->type != TABLETPC && features->type != TABLETPC2FG) {
+	} else if (features->type != TABLETPC) {
 		do {
 			rep_data[0] = 2;
 			rep_data[1] = 2;
@@ -364,7 +365,7 @@ static int wacom_retrieve_hid_descriptor(struct usb_interface *intf,
 	features->pressure_fuzz = 0;
 	features->distance_fuzz = 0;
 
-	/* only Tablet PCs need to retrieve the info */
+	/* only Tablet PCs and Bamboo P&T need to retrieve the info */
 	if ((features->type != TABLETPC) && (features->type != TABLETPC2FG) &&
 	    (features->type != BAMBOO_PT))
 		goto out;
-- 
1.7.2.2

