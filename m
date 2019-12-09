Return-Path: <SRS0=PdMS=Z7=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 888E4C43603
	for <linux-input@archiver.kernel.org>; Mon,  9 Dec 2019 03:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 631DB20663
	for <linux-input@archiver.kernel.org>; Mon,  9 Dec 2019 03:43:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbfLIDnU (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Sun, 8 Dec 2019 22:43:20 -0500
Received: from emcscan.emc.com.tw ([192.72.220.5]:44940 "EHLO
        emcscan.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbfLIDnR (ORCPT
        <rfc822;Linux-input@vger.kernel.org>); Sun, 8 Dec 2019 22:43:17 -0500
X-IronPort-AV: E=Sophos;i="5.56,253,1539619200"; 
   d="scan'208";a="33196541"
Received: from unknown (HELO webmail.emc.com.tw) ([192.168.10.1])
  by emcscan.emc.com.tw with ESMTP; 09 Dec 2019 11:43:14 +0800
Received: from 192.168.10.23
        by webmail.emc.com.tw with MailAudit ESMTP Server V5.0(71485:0:AUTH_RELAY)
        (envelope-from <dave.wang@emc.com.tw>); Mon, 09 Dec 2019 11:43:14 +0800 (CST)
Received: from 42.73.254.157
        by webmail.emc.com.tw with Mail2000 ESMTPA Server V7.00(101170:0:AUTH_LOGIN)
        (envelope-from <dave.wang@emc.com.tw>); Mon, 09 Dec 2019 11:43:12 +0800 (CST)
From:   Dave Wang <dave.wang@emc.com.tw>
To:     Linux-input@vger.kernel.org, Linux-kernel@vger.kernel.org,
        Dmitry.torokhov@gmail.com
Cc:     phoenix@emc.com.tw, josh.chen@emc.com.tw, jingle.wu@emc.com.tw,
        kai.heng.feng@canonical.com, "Dave.Wang" <dave.wang@emc.com.tw>
Subject: [PATCH 6/6] Input: elantech - Add the flag which will also use host notify
Date:   Sun,  8 Dec 2019 22:43:07 -0500
Message-Id: <20191209034307.30504-1-dave.wang@emc.com.tw>
X-Mailer: git-send-email 2.17.1
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

From: "Dave.Wang" <dave.wang@emc.com.tw>

Add the flag which will also use host notify technique in SMBus
interface.

Signed-off-by: Dave Wang <dave.wang@emc.com.tw>
---
 drivers/input/mouse/elantech.c | 1 +
 drivers/input/mouse/elantech.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index 0392b668cd39..3422710f4100 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -2022,6 +2022,7 @@ static bool elantech_use_host_notify(struct psmouse *psmouse,
 	case ETP_BUS_SMB_HST_NTFY_ONLY:
 		/* fall-through  */
 	case ETP_BUS_PS2_SMB_HST_NTFY:
+	case ETP_BUS_AMD_SMB_ALERT:
 		return true;
 	default:
 		psmouse_dbg(psmouse,
diff --git a/drivers/input/mouse/elantech.h b/drivers/input/mouse/elantech.h
index a633ffa0eb07..3b35ebb56607 100644
--- a/drivers/input/mouse/elantech.h
+++ b/drivers/input/mouse/elantech.h
@@ -115,6 +115,7 @@
 #define ETP_BUS_SMB_HST_NTFY_ONLY	2
 #define ETP_BUS_PS2_SMB_ALERT		3
 #define ETP_BUS_PS2_SMB_HST_NTFY	4
+#define ETP_BUS_AMD_SMB_ALERT		6
 
 /*
  * New ICs are either using SMBus Host Notify or just plain PS2.
-- 
2.17.1

