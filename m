Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA58AC433E0
	for <linux-input@archiver.kernel.org>; Wed,  3 Feb 2021 02:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A944464E35
	for <linux-input@archiver.kernel.org>; Wed,  3 Feb 2021 02:31:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbhBCCbd (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 2 Feb 2021 21:31:33 -0500
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:55973 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229690AbhBCCbc (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 2 Feb 2021 21:31:32 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UNjXwzX_1612319445;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UNjXwzX_1612319445)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 03 Feb 2021 10:30:45 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     dmitry.torokhov@gmail.com
Cc:     rydberg@bitmath.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] Input: remove unneeded semicolon
Date:   Wed,  3 Feb 2021 10:30:43 +0800
Message-Id: <1612319443-115831-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Eliminate the following coccicheck warning:
./drivers/input/touchscreen/zinitix.c:164:31-32: Unneeded semicolon

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/input/touchscreen/zinitix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/zinitix.c b/drivers/input/touchscreen/zinitix.c
index a3e3adb..f64d881 100644
--- a/drivers/input/touchscreen/zinitix.c
+++ b/drivers/input/touchscreen/zinitix.c
@@ -161,7 +161,7 @@ static int zinitix_read_data(struct i2c_client *client,
 
 	ret = i2c_master_recv(client, (u8 *)values, length);
 	if (ret != length)
-		return ret < 0 ? ret : -EIO; ;
+		return ret < 0 ? ret : -EIO;
 
 	return 0;
 }
-- 
1.8.3.1

