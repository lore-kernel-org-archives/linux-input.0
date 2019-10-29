Return-Path: <SRS0=VlPx=YW=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E30ECA9EC3
	for <linux-input@archiver.kernel.org>; Tue, 29 Oct 2019 07:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EEB02086D
	for <linux-input@archiver.kernel.org>; Tue, 29 Oct 2019 07:23:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729348AbfJ2HXI (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 29 Oct 2019 03:23:08 -0400
Received: from esa4.mentor.iphmx.com ([68.232.137.252]:27330 "EHLO
        esa4.mentor.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728365AbfJ2HXI (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 29 Oct 2019 03:23:08 -0400
IronPort-SDR: yAq6ABk4qt15wBPQwWCS9ROvcuttM+3PXDRZ+HXmMeT9KxUBy2FHIycxxm8c3SIbELn4nHJ8lo
 jY2xRIS39YYYSG81lRqcQ/hD96KWAWOY/RnaoU/PnXAYlJEKBK04N1QZcZwBfNycZqdn683bBw
 6NOKQ/9lu7Ay4LAe0S/OCjdXa0u7j067wxXd1WS9CWDTFSBNH4H4vfh5antjjmrz3Nrcwm+EPI
 2ES7fLnCFJEgH+JjvCofEV1SXYFHUwr6Fal/7CXVNedneU6oH3JzmonJDwQ++iRCIz7AQqeMfx
 hvQ=
X-IronPort-AV: E=Sophos;i="5.68,243,1569312000"; 
   d="scan'208";a="42697363"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
  by esa4.mentor.iphmx.com with ESMTP; 28 Oct 2019 23:23:07 -0800
IronPort-SDR: sXPGs2Ndl2P+enHZB2dnITg/gGG/xDmsOREZ81pPSBYKNbcDdF7JjXw1ZxrnSJ2XKs6DRxqFL4
 y+z2ZL0BXYQ9YeY1vEAovNed2t2rO5FeGrnIq1FkaRjaGls5x+VUyi68Wf7CGa9apzz7pC0CKg
 SevqZRpNAGIcK4+/Hsd1UwGnkRmgnEw7vaNsQkrrRABHed/iIfuRMR/wKyX1007A5tVyKvdVf1
 ZW2f8C6p0GAqqJ9RcCr4omhYEObzFFD1vGQoQJPiDN57y7P1qrZQPoxPRFFfzQ16Lt+tG4vRg/
 0vc=
From:   Jiada Wang <jiada_wang@mentor.com>
To:     <jikos@kernel.org>, <benjamin.tissoires@redhat.com>,
        <rydberg@bitmath.org>, <dmitry.torokhov@gmail.com>
CC:     <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jiada_wang@mentor.com>, <erosca@de.adit-jv.com>,
        <Andrew_Gabbasov@mentor.com>
Subject: [PATCH v4 48/48] Input: atmel_mxt_ts - Fix compilation warning
Date:   Tue, 29 Oct 2019 16:20:10 +0900
Message-ID: <20191029072010.8492-49-jiada_wang@mentor.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191029072010.8492-1-jiada_wang@mentor.com>
References: <20191029072010.8492-1-jiada_wang@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

fix "make W=1" compilation warnings from Atmel driver
as per the compilation logs.

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index f89382343c08..5cf303371103 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -2049,7 +2049,7 @@ static int mxt_prepare_cfg_mem(struct mxt_data *data, struct mxt_cfg *cfg)
 
 			byte_offset = reg + i - cfg->start_ofs;
 
-			if (byte_offset >= 0 && byte_offset < cfg->mem_size) {
+			if (byte_offset < cfg->mem_size) {
 				*(cfg->mem + byte_offset) = val;
 			} else {
 				dev_err(dev, "Bad object: reg:%d, T%d, ofs=%d\n",
-- 
2.17.1

