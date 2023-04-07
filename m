Return-Path: <linux-input-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA7EC76196
	for <linux-input@archiver.kernel.org>; Fri,  7 Apr 2023 02:14:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240039AbjDGCOI (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 6 Apr 2023 22:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240009AbjDGCOF (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 6 Apr 2023 22:14:05 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ABFB171C;
        Thu,  6 Apr 2023 19:14:03 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VfUsEV0_1680833625;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VfUsEV0_1680833625)
          by smtp.aliyun-inc.com;
          Fri, 07 Apr 2023 10:14:00 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     dmitry.torokhov@gmail.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH v2] Input: cma3000_d0x - Remove duplicate code
Date:   Fri,  7 Apr 2023 10:13:43 +0800
Message-Id: <20230407021343.63512-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Function input_set_abs_params() has already set EV_ABS bit for us.

drivers/input/misc/cma3000_d0x.c:328 cma3000_init() warn: inconsistent indenting.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=4588
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
Changes in v2:
  -Remove __set_bit(EV_ABS, input_dev->evbit);

 drivers/input/misc/cma3000_d0x.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/input/misc/cma3000_d0x.c b/drivers/input/misc/cma3000_d0x.c
index e6feb73bb52b..1772846708d2 100644
--- a/drivers/input/misc/cma3000_d0x.c
+++ b/drivers/input/misc/cma3000_d0x.c
@@ -325,8 +325,6 @@ struct cma3000_accl_data *cma3000_init(struct device *dev, int irq,
 	input_dev->open = cma3000_open;
 	input_dev->close = cma3000_close;
 
-	 __set_bit(EV_ABS, input_dev->evbit);
-
 	input_set_abs_params(input_dev, ABS_X,
 			-data->g_range, data->g_range, pdata->fuzz_x, 0);
 	input_set_abs_params(input_dev, ABS_Y,
-- 
2.20.1.7.g153144c

