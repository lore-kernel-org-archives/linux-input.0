Return-Path: <SRS0=PdMS=Z7=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F915C43603
	for <linux-input@archiver.kernel.org>; Mon,  9 Dec 2019 03:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69ADF2071A
	for <linux-input@archiver.kernel.org>; Mon,  9 Dec 2019 03:14:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfLIDOc (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Sun, 8 Dec 2019 22:14:32 -0500
Received: from emcscan.emc.com.tw ([192.72.220.5]:12577 "EHLO
        emcscan.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726669AbfLIDOb (ORCPT
        <rfc822;Linux-input@vger.kernel.org>); Sun, 8 Dec 2019 22:14:31 -0500
X-IronPort-AV: E=Sophos;i="5.56,253,1539619200"; 
   d="scan'208";a="33195812"
Received: from unknown (HELO webmail.emc.com.tw) ([192.168.10.1])
  by emcscan.emc.com.tw with ESMTP; 09 Dec 2019 11:14:29 +0800
Received: from 192.168.10.23
        by webmail.emc.com.tw with MailAudit ESMTP Server V5.0(71508:0:AUTH_RELAY)
        (envelope-from <dave.wang@emc.com.tw>); Mon, 09 Dec 2019 11:14:31 +0800 (CST)
Received: from 42.73.254.157
        by webmail.emc.com.tw with Mail2000 ESMTPA Server V7.00(101171:0:AUTH_LOGIN)
        (envelope-from <dave.wang@emc.com.tw>); Mon, 09 Dec 2019 11:14:31 +0800 (CST)
From:   Dave Wang <dave.wang@emc.com.tw>
To:     Linux-input@vger.kernel.org, Linux-kernel@vger.kernel.org,
        Dmitry.torokhov@gmail.com
Cc:     phoenix@emc.com.tw, josh.chen@emc.com.tw, jingle.wu@emc.com.tw,
        kai.heng.feng@canonical.com, "Dave.Wang" <dave.wang@emc.com.tw>
Subject: [PATCH 2/6] Input: elantech - Add the function to get more bytes from register
Date:   Sun,  8 Dec 2019 22:14:26 -0500
Message-Id: <20191209031426.30253-1-dave.wang@emc.com.tw>
X-Mailer: git-send-email 2.17.1
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

From: "Dave.Wang" <dave.wang@emc.com.tw>

Send an Elantech style special command to read three bytes from
register.

Signed-off-by: Dave Wang <dave.wang@emc.com.tw>
---
 drivers/input/mouse/elantech.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index 1f0d914acd78..afb87122b766 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -89,6 +89,24 @@ static int elantech_ps2_command(struct psmouse *psmouse,
 	return rc;
 }
 
+/*
+ * Send an Elantech style special command to read 3 bytes from a register
+ */
+static int elantech_read_reg_params(struct psmouse *psmouse, unsigned char reg,
+				unsigned char *param)
+{
+	int rc = 0;
+
+	if (elantech_ps2_command(psmouse, NULL, ETP_PS2_CUSTOM_COMMAND) ||
+	    elantech_ps2_command(psmouse, NULL, ETP_REGISTER_READWRITE) ||
+	    elantech_ps2_command(psmouse, NULL, ETP_PS2_CUSTOM_COMMAND) ||
+	    elantech_ps2_command(psmouse, NULL, reg) ||
+	    elantech_ps2_command(psmouse, param, PSMOUSE_CMD_GETINFO))
+		rc = -1;
+
+	return rc;
+}
+
 /*
  * Send an Elantech style special command to read a value from a register
  */
-- 
2.17.1

