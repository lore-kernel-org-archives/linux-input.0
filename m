From: Benson Leung <bleung@chromium.org>
Subject: [PATCH] Input: elan_i2c - Fix typos for validpage_count
Date: Wed, 26 Aug 2015 11:19:31 -0700
Message-ID: <1440613171-20549-1-git-send-email-bleung@chromium.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:36316 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752306AbbHZSTs (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 26 Aug 2015 14:19:48 -0400
Received: by pacgr6 with SMTP id gr6so16383675pac.3
        for <linux-input@vger.kernel.org>; Wed, 26 Aug 2015 11:19:48 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, dusonlin@emc.com.tw, michele.curti@gmail.com
Cc: bleung@chromium.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Search for "vaildpage_count" and replace with "validpage_count".

Signed-off-by: Benson Leung <bleung@chromium.org>
---
 drivers/input/mouse/elan_i2c_core.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
index bbdaedc..d4a38ca 100644
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -84,7 +84,7 @@ struct elan_tp_data {
 	int			pressure_adjustment;
 	u8			mode;
 	u8			ic_type;
-	u16			fw_vaildpage_count;
+	u16			fw_validpage_count;
 	u16			fw_signature_address;
 
 	bool			irq_wake;
@@ -94,28 +94,28 @@ struct elan_tp_data {
 	bool			baseline_ready;
 };
 
-static int elan_get_fwinfo(u8 ic_type, u16 *vaildpage_count,
+static int elan_get_fwinfo(u8 ic_type, u16 *validpage_count,
 			   u16 *signature_address)
 {
 	switch(ic_type) {
 	case 0x08:
-		*vaildpage_count = 512;
+		*validpage_count = 512;
 		break;
 	case 0x09:
-		*vaildpage_count = 768;
+		*validpage_count = 768;
 		break;
 	case 0x0D:
-		*vaildpage_count = 896;
+		*validpage_count = 896;
 		break;
 	default:
 		/* unknown ic type clear value */
-		*vaildpage_count = 0;
+		*validpage_count = 0;
 		*signature_address = 0;
 		return -ENXIO;
 	}
 
 	*signature_address =
-		(*vaildpage_count * ETP_FW_PAGE_SIZE) - ETP_FW_SIGNATURE_SIZE;
+		(*validpage_count * ETP_FW_PAGE_SIZE) - ETP_FW_SIGNATURE_SIZE;
 
 	return 0;
 }
@@ -264,7 +264,7 @@ static int elan_query_device_info(struct elan_tp_data *data)
 	if (error)
 		return error;
 
-	error = elan_get_fwinfo(data->ic_type, &data->fw_vaildpage_count,
+	error = elan_get_fwinfo(data->ic_type, &data->fw_validpage_count,
 				&data->fw_signature_address);
 	if (error) {
 		dev_err(&data->client->dev,
@@ -356,7 +356,7 @@ static int __elan_update_firmware(struct elan_tp_data *data,
 	iap_start_addr = get_unaligned_le16(&fw->data[ETP_IAP_START_ADDR * 2]);
 
 	boot_page_count = (iap_start_addr * 2) / ETP_FW_PAGE_SIZE;
-	for (i = boot_page_count; i < data->fw_vaildpage_count; i++) {
+	for (i = boot_page_count; i < data->fw_validpage_count; i++) {
 		u16 checksum = 0;
 		const u8 *page = &fw->data[i * ETP_FW_PAGE_SIZE];
 
-- 
2.5.0.457.gab17608

