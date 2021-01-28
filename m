Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B8CC433E0
	for <linux-input@archiver.kernel.org>; Thu, 28 Jan 2021 22:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35C3D64DED
	for <linux-input@archiver.kernel.org>; Thu, 28 Jan 2021 22:43:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbhA1Wn2 (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 28 Jan 2021 17:43:28 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11618 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231509AbhA1Wmr (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 28 Jan 2021 17:42:47 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DRb5k6HKyz1612N;
        Fri, 29 Jan 2021 06:40:26 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.203.74) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.498.0; Fri, 29 Jan 2021 06:41:34 +0800
From:   Barry Song <song.bao.hua@hisilicon.com>
To:     <tglx@linutronix.de>, <dmitry.torokhov@gmail.com>,
        <maz@kernel.org>, <gregkh@linuxfoundation.org>,
        <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <linuxarm@openeuler.org>, Barry Song <song.bao.hua@hisilicon.com>
Subject: [PATCH v4 09/12] Input: wm831x-ts - request_irq by IRQF_NO_AUTOEN and remove disable_irq
Date:   Fri, 29 Jan 2021 11:35:35 +1300
Message-ID: <20210128223538.20272-10-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20210128223538.20272-1-song.bao.hua@hisilicon.com>
References: <20210128223538.20272-1-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.126.203.74]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

disable_irq() after request_irq() still has a time gap in which
interrupts can come. request_irq() with IRQF_NO_AUTOEN flag will
disable IRQ auto-enable because of requesting.

Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
 drivers/input/touchscreen/wm831x-ts.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/wm831x-ts.c b/drivers/input/touchscreen/wm831x-ts.c
index bb1699e0d3c7..319f57fb9af5 100644
--- a/drivers/input/touchscreen/wm831x-ts.c
+++ b/drivers/input/touchscreen/wm831x-ts.c
@@ -317,14 +317,13 @@ static int wm831x_ts_probe(struct platform_device *pdev)
 
 	error = request_threaded_irq(wm831x_ts->data_irq,
 				     NULL, wm831x_ts_data_irq,
-				     irqf | IRQF_ONESHOT,
+				     irqf | IRQF_ONESHOT | IRQF_NO_AUTOEN,
 				     "Touchscreen data", wm831x_ts);
 	if (error) {
 		dev_err(&pdev->dev, "Failed to request data IRQ %d: %d\n",
 			wm831x_ts->data_irq, error);
 		goto err_alloc;
 	}
-	disable_irq(wm831x_ts->data_irq);
 
 	if (pdata && pdata->pd_irqf)
 		irqf = pdata->pd_irqf;
-- 
2.25.1

