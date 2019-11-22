Return-Path: <SRS0=Zkgr=ZO=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6476FC432C3
	for <linux-input@archiver.kernel.org>; Fri, 22 Nov 2019 08:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 472832070A
	for <linux-input@archiver.kernel.org>; Fri, 22 Nov 2019 08:26:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbfKVI0h (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 22 Nov 2019 03:26:37 -0500
Received: from esa3.mentor.iphmx.com ([68.232.137.180]:4485 "EHLO
        esa3.mentor.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbfKVI0f (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 22 Nov 2019 03:26:35 -0500
IronPort-SDR: X8nzEv9CkszHrMqWs2Cn5Wt66os8qBWEgXHc5S4D/fXg03w4QsHvgzsD39ltMDSJQax6tKXORU
 Jm9G4N3OL9d/59dprwMTMvDedSqS2YIIB+mv8TqIDvdNW9v9Cgxzmkp2rhNg82IPsayIRy/Q6M
 uk+zRyckdLj7vLgM0ZGkkcbZ7RqhqJA6VAeiHnoEwLtkO22DcUntkVPMhgpiMu7urOl7WyZkZ/
 w8mGZdea4NBM5iLVlcgPnPn3UpdrE0voxAI/i3ta3vwH74AcDAhlbtiw1a3r8kIsrcV238iQ9O
 u80=
X-IronPort-AV: E=Sophos;i="5.69,229,1571731200"; 
   d="scan'208";a="43419509"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
  by esa3.mentor.iphmx.com with ESMTP; 22 Nov 2019 00:26:35 -0800
IronPort-SDR: eMBpF+qqcc94Gu8//rsvd4oNWAT7u58kxzZJNGumGQxAFgxz9ba562TU+xg19KPcX+20yuVW3y
 e+RudaxAMODHwxU/XIRi/VJCjT2BC78p7yqkpPkC/KPZNcuPTlnlJ5v/YOkznyutbRWXMS9h5X
 9+alIxLLKJe+xL/or3QebaCj+faUNBYqXmNvwHJe7CFBl+TKccspjIcR1Y6vHrSyDK+2L+sDa4
 3A0B8e7cY3tj2u6njJfHIN7nwvYBPasljQMBesPSvhSVqqiMN7tKtgCBPJv2eBbkjrC7/oXanM
 whA=
From:   Jiada Wang <jiada_wang@mentor.com>
To:     <jikos@kernel.org>, <benjamin.tissoires@redhat.com>,
        <rydberg@bitmath.org>, <dmitry.torokhov@gmail.com>,
        <nick@shmanahar.org>
CC:     <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <erosca@de.adit-jv.com>, <Andrew_Gabbasov@mentor.com>,
        <jiada_wang@mentor.com>
Subject: [PATCH v6 40/48] Input: Atmel: improve error handling in mxt_update_cfg()
Date:   Fri, 22 Nov 2019 17:23:54 +0900
Message-ID: <20191122082402.18173-41-jiada_wang@mentor.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191122082402.18173-1-jiada_wang@mentor.com>
References: <20191122082402.18173-1-jiada_wang@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

From: Deepak Das <deepak_das@mentor.com>

mxt_update_cfg() failed to propagate the error
code from mxt_init_t7_power_cfg() so return the error code.

Signed-off-by: Deepak Das <deepak_das@mentor.com>
Signed-off-by: George G. Davis <george_davis@mentor.com>
Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 110c966e7f3a..92af95bd4eed 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -2186,7 +2186,9 @@ static int mxt_update_cfg(struct mxt_data *data, const struct firmware *fw)
 	dev_info(dev, "Config successfully updated\n");
 
 	/* T7 config may have changed */
-	mxt_init_t7_power_cfg(data);
+	ret = mxt_init_t7_power_cfg(data);
+	if (ret)
+		dev_warn(dev, "Power Config failed to update\n");
 
 release_mem:
 	kfree(cfg.mem);
-- 
2.17.1

