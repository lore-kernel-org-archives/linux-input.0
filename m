From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH] HID: wacom: fix Intuos wireless report id issue
Date: Mon, 26 Oct 2015 14:29:12 -0700
Message-ID: <1445894952-3495-1-git-send-email-pingc@wacom.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:36102 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752677AbbJZV3U (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 26 Oct 2015 17:29:20 -0400
Received: by pacfv9 with SMTP id fv9so208133901pac.3
        for <linux-input@vger.kernel.org>; Mon, 26 Oct 2015 14:29:20 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: kosina@suse.cz, dlbrewe@hotmail.com, Ping Cheng <pingc@wacom.com>

Intuos Pen in wireless mode does not have the same report id (2) as
when it is in USB mode (17).

This patch also moves WIRELESS next to REMOTE in type enum so we
can group devices with similar features easily.

Reported-by: Dale Brewe <dlbrewe@hotmail.com>
Tested-by: Dale Brewe <dlbrewe@hotmail.com>
Signed-off-by: Ping Cheng <pingc@wacom.com>
---
 drivers/hid/wacom_sys.c | 2 +-
 drivers/hid/wacom_wac.c | 1 -
 drivers/hid/wacom_wac.h | 2 +-
 3 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 125e9d5..b4de325 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -432,7 +432,7 @@ static int wacom_query_tablet_data(struct hid_device *hdev,
 			return wacom_set_device_mode(hdev, 2, 2, 2);
 		}
 	} else if (features->device_type & WACOM_DEVICETYPE_PEN) {
-		if (features->type <= BAMBOO_PT && features->type != WIRELESS) {
+		if (features->type <= BAMBOO_PT) {
 			return wacom_set_device_mode(hdev, 2, 2, 2);
 		}
 	}
diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 7b37848..453da6d 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -2066,7 +2066,6 @@ static int wacom_bpt_irq(struct wacom_wac *wacom, size_t len)
 	struct wacom_features *features = &wacom->features;
 
 	if ((features->type == INTUOSHT2) &&
-	    (wacom->data[0] == WACOM_REPORT_INTUOS_PEN) &&
 	    (features->device_type & WACOM_DEVICETYPE_PEN))
 		return wacom_intuos_irq(wacom);
 	else if (len == WACOM_PKGLEN_BBTOUCH)
diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
index 95ee92b..d9e9515 100644
--- a/drivers/hid/wacom_wac.h
+++ b/drivers/hid/wacom_wac.h
@@ -129,7 +129,6 @@ enum {
 	WACOM_BEE,
 	WACOM_13HD,
 	WACOM_MO,
-	WIRELESS,
 	BAMBOO_PEN,
 	INTUOSHT,
 	INTUOSHT2,
@@ -138,6 +137,7 @@ enum {
 	WACOM_24HDT,
 	WACOM_27QHDT,
 	BAMBOO_PAD,
+	WIRELESS,
 	REMOTE,
 	TABLETPC,   /* add new TPC below */
 	TABLETPCE,
-- 
1.9.1

