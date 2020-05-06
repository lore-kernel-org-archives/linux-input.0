Return-Path: <SRS0=RGIC=6U=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A6FC28CBC
	for <linux-input@archiver.kernel.org>; Wed,  6 May 2020 11:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCC352070B
	for <linux-input@archiver.kernel.org>; Wed,  6 May 2020 11:05:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbgEFLFm (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 6 May 2020 07:05:42 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3817 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727959AbgEFLFm (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 6 May 2020 07:05:42 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 677F674154628CBA8447;
        Wed,  6 May 2020 19:05:38 +0800 (CST)
Received: from huawei.com (10.67.174.156) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Wed, 6 May 2020
 19:05:29 +0800
From:   ChenTao <chentao107@huawei.com>
To:     <dmitry.torokhov@gmail.com>
CC:     <robh@kernel.org>, <m.felsch@pengutronix.de>,
        <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chentao107@huawei.com>
Subject: [PATCH -next] input/keyboard/qt1050: fix unsigned comparison with 0
Date:   Wed, 6 May 2020 19:04:45 +0800
Message-ID: <20200506110445.111576-1-chentao107@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.156]
X-CFilter-Loop: Reflected
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Fixes warning because num is u32 and can never be negtative

drivers/input/keyboard/qt1050.c:371:18: warning:
comparison of unsigned expression < 0 is always false [-Wtype-limits]
   if (button.num < 0 || button.num > QT1050_MAX_KEYS - 1)

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: ChenTao <chentao107@huawei.com>
---
 drivers/input/keyboard/qt1050.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/qt1050.c b/drivers/input/keyboard/qt1050.c
index 403060d05c3b..a9ac99f62e39 100644
--- a/drivers/input/keyboard/qt1050.c
+++ b/drivers/input/keyboard/qt1050.c
@@ -368,7 +368,7 @@ static int qt1050_parse_fw(struct qt1050_priv *ts)
 			dev_err(dev, "Button without pad number\n");
 			goto err;
 		}
-		if (button.num < 0 || button.num > QT1050_MAX_KEYS - 1)
+		if (button.num > QT1050_MAX_KEYS - 1)
 			goto err;
 
 		ts->reg_keys |= BIT(button.num);
-- 
2.22.0

