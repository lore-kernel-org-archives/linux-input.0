Return-Path: <linux-input-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF4EC6FD1F
	for <linux-input@archiver.kernel.org>; Wed, 22 Mar 2023 06:45:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjCVGpp (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 22 Mar 2023 02:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbjCVGpQ (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 22 Mar 2023 02:45:16 -0400
Received: from out199-16.us.a.mail.aliyun.com (out199-16.us.a.mail.aliyun.com [47.90.199.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FFEB5C13E;
        Tue, 21 Mar 2023 23:44:28 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VePcMQh_1679467323;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VePcMQh_1679467323)
          by smtp.aliyun-inc.com;
          Wed, 22 Mar 2023 14:42:07 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     dmitry.torokhov@gmail.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] Input: cma3000_d0x - Clean up some inconsistent indenting
Date:   Wed, 22 Mar 2023 14:41:58 +0800
Message-Id: <20230322064158.4043-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

No functional modification involved.

drivers/input/misc/cma3000_d0x.c:328 cma3000_init() warn: inconsistent indenting.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=4588
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/input/misc/cma3000_d0x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/misc/cma3000_d0x.c b/drivers/input/misc/cma3000_d0x.c
index e6feb73bb52b..c444a44e4576 100644
--- a/drivers/input/misc/cma3000_d0x.c
+++ b/drivers/input/misc/cma3000_d0x.c
@@ -325,7 +325,7 @@ struct cma3000_accl_data *cma3000_init(struct device *dev, int irq,
 	input_dev->open = cma3000_open;
 	input_dev->close = cma3000_close;
 
-	 __set_bit(EV_ABS, input_dev->evbit);
+	__set_bit(EV_ABS, input_dev->evbit);
 
 	input_set_abs_params(input_dev, ABS_X,
 			-data->g_range, data->g_range, pdata->fuzz_x, 0);
-- 
2.20.1.7.g153144c

