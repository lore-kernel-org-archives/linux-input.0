Return-Path: <SRS0=PdMS=Z7=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77EF5C43603
	for <linux-input@archiver.kernel.org>; Mon,  9 Dec 2019 03:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5134020663
	for <linux-input@archiver.kernel.org>; Mon,  9 Dec 2019 03:42:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfLIDms (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Sun, 8 Dec 2019 22:42:48 -0500
Received: from emcscan.emc.com.tw ([192.72.220.5]:46123 "EHLO
        emcscan.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbfLIDms (ORCPT
        <rfc822;Linux-input@vger.kernel.org>); Sun, 8 Dec 2019 22:42:48 -0500
X-IronPort-AV: E=Sophos;i="5.56,253,1539619200"; 
   d="scan'208";a="33196523"
Received: from unknown (HELO webmail.emc.com.tw) ([192.168.10.1])
  by emcscan.emc.com.tw with ESMTP; 09 Dec 2019 11:42:47 +0800
Received: from 192.168.10.23
        by webmail.emc.com.tw with MailAudit ESMTP Server V5.0(71508:0:AUTH_RELAY)
        (envelope-from <dave.wang@emc.com.tw>); Mon, 09 Dec 2019 11:42:45 +0800 (CST)
Received: from 42.73.254.157
        by webmail.emc.com.tw with Mail2000 ESMTPA Server V7.00(101176:0:AUTH_LOGIN)
        (envelope-from <dave.wang@emc.com.tw>); Mon, 09 Dec 2019 11:42:45 +0800 (CST)
From:   Dave Wang <dave.wang@emc.com.tw>
To:     Linux-input@vger.kernel.org, Linux-kernel@vger.kernel.org,
        Dmitry.torokhov@gmail.com
Cc:     phoenix@emc.com.tw, josh.chen@emc.com.tw, jingle.wu@emc.com.tw,
        kai.heng.feng@canonical.com, "Dave.Wang" <dave.wang@emc.com.tw>
Subject: [PATCH 5/6] Input: elantech - Transfer the device information from PS/2 to SMBus
Date:   Sun,  8 Dec 2019 22:42:40 -0500
Message-Id: <20191209034240.30450-1-dave.wang@emc.com.tw>
X-Mailer: git-send-email 2.17.1
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

From: "Dave.Wang" <dave.wang@emc.com.tw>

Many commands in SMBus interface cannot be triggered. In order to
get the correct device information, transfer the device information
from PS/2 to SMBus interface for PS/2+SMbus protocol.

Signed-off-by: Dave Wang <dave.wang@emc.com.tw>
---
 drivers/input/mouse/elantech.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index 53d7ff719d76..0392b668cd39 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -1889,12 +1889,28 @@ static int elantech_create_smbus(struct psmouse *psmouse,
 				 struct elantech_device_info *info,
 				 bool leave_breadcrumbs)
 {
-	struct property_entry i2c_props[11] = {};
+	struct property_entry i2c_props[19] = {};
 	struct i2c_board_info smbus_board = {
 		I2C_BOARD_INFO("elan_i2c", 0x15),
 		.flags = I2C_CLIENT_HOST_NOTIFY,
 	};
 	unsigned int idx = 0;
+	u16 product_id, ic_type;
+	u8 sm_version, fw_version, iap_version;
+
+	if (info->pattern > 0) {
+		product_id = get_unaligned_be16(info->samples);
+		sm_version = info->bus;
+		ic_type = get_unaligned_be16(info->ic_body);
+		fw_version = info->ic_body[2];
+		iap_version = info->iap_version[2];
+	} else {
+		product_id = info->samples[1];
+		sm_version = info->samples[0];
+		ic_type = (info->fw_version & 0x0f0000) >> 16;
+		fw_version = info->fw_version & 0x0000ff;
+		iap_version = 0x00;
+	}
 
 	smbus_board.properties = i2c_props;
 
@@ -1906,6 +1922,22 @@ static int elantech_create_smbus(struct psmouse *psmouse,
 						   info->x_min);
 	i2c_props[idx++] = PROPERTY_ENTRY_U32("touchscreen-min-y",
 						   info->y_min);
+	i2c_props[idx++] = PROPERTY_ENTRY_U16("elan,product_id",
+							product_id);
+	i2c_props[idx++] = PROPERTY_ENTRY_U8("elan,sm_version",
+							sm_version);
+	i2c_props[idx++] = PROPERTY_ENTRY_U16("elan,ic_type",
+							ic_type);
+	i2c_props[idx++] = PROPERTY_ENTRY_U8("elan,fw_version",
+							fw_version);
+	i2c_props[idx++] = PROPERTY_ENTRY_U16("elan,fw_checksum",
+			info->fw_checksum[0] << 8 | info->fw_checksum[1]);
+	i2c_props[idx++] = PROPERTY_ENTRY_U16("elan,iap_checksum",
+			info->iap_checksum[0] << 8 | info->iap_checksum[1]);
+	i2c_props[idx++] = PROPERTY_ENTRY_U8("elan,iap_version",
+							iap_version);
+	i2c_props[idx++] = PROPERTY_ENTRY_U8("elan,pattern",
+							info->pattern);
 	if (info->x_res)
 		i2c_props[idx++] = PROPERTY_ENTRY_U32("touchscreen-x-mm",
 						      (info->x_max + 1) / info->x_res);
-- 
2.17.1

