Return-Path: <SRS0=PhcK=CZ=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F7DC433E2
	for <linux-input@archiver.kernel.org>; Wed, 16 Sep 2020 18:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61AE820731
	for <linux-input@archiver.kernel.org>; Wed, 16 Sep 2020 18:20:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbgIPSUN (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 16 Sep 2020 14:20:13 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:39502 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727884AbgIPSUH (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 16 Sep 2020 14:20:07 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 7C7D42608B7E41CB1877;
        Wed, 16 Sep 2020 22:20:57 +0800 (CST)
Received: from localhost (10.174.179.108) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Wed, 16 Sep 2020
 22:20:49 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <dmitry.torokhov@gmail.com>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <andi@etezian.org>,
        <javier@osg.samsung.com>, <robh@kernel.org>
CC:     <linux-input@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] Input: stmfts - Fix a & vs && typo
Date:   Wed, 16 Sep 2020 22:19:41 +0800
Message-ID: <20200916141941.16684-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.108]
X-CFilter-Loop: Reflected
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

In stmfts_sysfs_hover_enable_write(), we should check
value and sdata->hover_enabled is all true.

Fixes: 78bcac7b2ae1 ("Input: add support for the STMicroelectronics FingerTip touchscreen")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/input/touchscreen/stmfts.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/stmfts.c b/drivers/input/touchscreen/stmfts.c
index df946869d4cd..9a64e1dbc04a 100644
--- a/drivers/input/touchscreen/stmfts.c
+++ b/drivers/input/touchscreen/stmfts.c
@@ -479,7 +479,7 @@ static ssize_t stmfts_sysfs_hover_enable_write(struct device *dev,
 
 	mutex_lock(&sdata->mutex);
 
-	if (value & sdata->hover_enabled)
+	if (value && sdata->hover_enabled)
 		goto out;
 
 	if (sdata->running)
-- 
2.17.1

