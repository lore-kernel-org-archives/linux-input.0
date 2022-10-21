Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D69C433FE
	for <linux-input@archiver.kernel.org>; Fri, 21 Oct 2022 08:57:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbiJUI5k (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 21 Oct 2022 04:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbiJUI5i (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 21 Oct 2022 04:57:38 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B62250EC0;
        Fri, 21 Oct 2022 01:57:35 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R741e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VSikoqm_1666342652;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VSikoqm_1666342652)
          by smtp.aliyun-inc.com;
          Fri, 21 Oct 2022 16:57:33 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     gupt21@gmail.com
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-i2c@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next RESEND] HID: mcp2221: Remove unneeded semicolon
Date:   Fri, 21 Oct 2022 16:57:27 +0800
Message-Id: <20221021085727.118133-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

./drivers/hid/hid-mcp2221.c:1019:3-4: Unneeded semicolon

Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=2485
Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/hid/hid-mcp2221.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-mcp2221.c b/drivers/hid/hid-mcp2221.c
index b3eaf170f0ec..9287730aab27 100644
--- a/drivers/hid/hid-mcp2221.c
+++ b/drivers/hid/hid-mcp2221.c
@@ -1019,7 +1019,7 @@ static int mcp_iio_channels(struct mcp2221 *mcp)
 			break;
 		default:
 			continue;
-		};
+		}
 
 		chan->type = IIO_VOLTAGE;
 		chan->indexed = 1;
-- 
2.20.1.7.g153144c

