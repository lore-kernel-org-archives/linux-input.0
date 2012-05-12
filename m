From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 1/2] input - wacom : rearrange type enum
Date: Fri, 11 May 2012 18:24:57 -0700
Message-ID: <1336785898-2359-1-git-send-email-pinglinux@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:39283 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757039Ab2ELBZF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 May 2012 21:25:05 -0400
Received: by dady13 with SMTP id y13so3730507dad.19
        for <linux-input@vger.kernel.org>; Fri, 11 May 2012 18:25:05 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Ping Cheng <pinglinux@gmail.com>, Ping Cheng <pingc@wacom.com>

So we can simplify a few type related if statements

Signed-off-by: Ping Cheng <pingc@wacom.com>
---
 drivers/input/tablet/wacom_sys.c |   10 +++-------
 drivers/input/tablet/wacom_wac.c |    6 ++----
 drivers/input/tablet/wacom_wac.h |    6 +++---
 3 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/input/tablet/wacom_sys.c b/drivers/input/tablet/wacom_sys.c
index b3a8bd3..79b5cfb 100644
--- a/drivers/input/tablet/wacom_sys.c
+++ b/drivers/input/tablet/wacom_sys.c
@@ -440,8 +440,7 @@ static int wacom_query_tablet_data(struct usb_interface *intf, struct wacom_feat
 	/* ask to report Wacom data */
 	if (features->device_type == BTN_TOOL_FINGER) {
 		/* if it is an MT Tablet PC touch */
-		if (features->type == TABLETPC2FG ||
-		    features->type == MTSCREEN) {
+		if (features->type > TABLETPC) {
 			do {
 				rep_data[0] = 3;
 				rep_data[1] = 4;
@@ -460,7 +459,7 @@ static int wacom_query_tablet_data(struct usb_interface *intf, struct wacom_feat
 			} while ((error < 0 || rep_data[1] != 4) &&
 				 limit++ < WAC_MSG_RETRIES);
 		}
-	} else if (features->type != TABLETPC &&
+	} else if (features->type <= BAMBOO_PT &&
 		   features->type != WIRELESS &&
 		   features->device_type == BTN_TOOL_PEN) {
 		do {
@@ -510,10 +509,7 @@ static int wacom_retrieve_hid_descriptor(struct usb_interface *intf,
 	}
 
 	/* only devices that support touch need to retrieve the info */
-	if (features->type != TABLETPC &&
-	    features->type != TABLETPC2FG &&
-	    features->type != BAMBOO_PT &&
-	    features->type != MTSCREEN) {
+	if (features->type < BAMBOO_PT) {
 		goto out;
 	}
 
diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index 004bc1b..c40dcb7 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -1317,10 +1317,8 @@ void wacom_setup_device_quirks(struct wacom_features *features)
 	}
 
 	/* these device have multiple inputs */
-	if (features->type == TABLETPC || features->type == TABLETPC2FG ||
-	    features->type == BAMBOO_PT || features->type == WIRELESS ||
-	    (features->type >= INTUOS5S && features->type <= INTUOS5L) ||
-	    features->type == MTSCREEN)
+	if (features->type >= WIRELESS ||
+	    (features->type >= INTUOS5S && features->type <= INTUOS5L))
 		features->quirks |= WACOM_QUIRK_MULTI_INPUT;
 
 	/* quirk for bamboo touch with 2 low res touches */
diff --git a/drivers/input/tablet/wacom_wac.h b/drivers/input/tablet/wacom_wac.h
index 78fbd3f..8708043 100644
--- a/drivers/input/tablet/wacom_wac.h
+++ b/drivers/input/tablet/wacom_wac.h
@@ -62,8 +62,6 @@ enum {
 	PTU,
 	PL,
 	DTU,
-	BAMBOO_PT,
-	WIRELESS,
 	INTUOS,
 	INTUOS3S,
 	INTUOS3,
@@ -79,7 +77,9 @@ enum {
 	CINTIQ,
 	WACOM_BEE,
 	WACOM_MO,
-	TABLETPC,
+	WIRELESS,
+	BAMBOO_PT,
+	TABLETPC,   /* add new TPC below */
 	TABLETPC2FG,
 	MTSCREEN,
 	MAX_TYPE
-- 
1.7.9.5

