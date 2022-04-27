Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3892C433F5
	for <linux-input@archiver.kernel.org>; Wed, 27 Apr 2022 00:49:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356493AbiD0Aw0 (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 26 Apr 2022 20:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347338AbiD0AwU (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 26 Apr 2022 20:52:20 -0400
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23FA5F8CE;
        Tue, 26 Apr 2022 17:49:10 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R511e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VBPajTW_1651020547;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VBPajTW_1651020547)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 27 Apr 2022 08:49:08 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     dmitry.torokhov@gmail.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] Input: Remove unnecessary print function dev_err()
Date:   Wed, 27 Apr 2022 08:49:06 +0800
Message-Id: <20220427004906.129893-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

The print function dev_err() is redundant because
platform_get_irq() already prints an error.

Eliminate the follow coccicheck warning:
./drivers/input/joystick/sensehat-joystick.c:102:2-9: line 102 is
redundant because platform_get_irq() already prints an error

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/input/joystick/sensehat-joystick.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/input/joystick/sensehat-joystick.c b/drivers/input/joystick/sensehat-joystick.c
index 5ad1fe4ff496..a84df39d3b2f 100644
--- a/drivers/input/joystick/sensehat-joystick.c
+++ b/drivers/input/joystick/sensehat-joystick.c
@@ -98,10 +98,8 @@ static int sensehat_joystick_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "Could not retrieve interrupt request");
+	if (irq < 0)
 		return irq;
-	}
 
 	error = devm_request_threaded_irq(&pdev->dev, irq,
 					  NULL, sensehat_joystick_report,
-- 
2.20.1.7.g153144c

