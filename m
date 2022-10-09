Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C967C433F5
	for <linux-input@archiver.kernel.org>; Sun,  9 Oct 2022 02:55:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiJICzX (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Sat, 8 Oct 2022 22:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiJICzV (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Sat, 8 Oct 2022 22:55:21 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3096629CBE
        for <linux-input@vger.kernel.org>; Sat,  8 Oct 2022 19:55:20 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MlRPW6V38zVhrq;
        Sun,  9 Oct 2022 10:50:55 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 9 Oct 2022 10:55:17 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Sun, 9 Oct
 2022 10:55:17 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-input@vger.kernel.org>
CC:     <samuel@sholland.org>, <dmitry.torokhov@gmail.com>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next] Input: pinephone-keyboard - fix error return code in ppkb_probe()
Date:   Sun, 9 Oct 2022 10:54:59 +0800
Message-ID: <20221009025459.38193-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Fix error return code when devm_request_threaded_irq() fails in ppkb_probe().

Fixes: 0f8ef9709408 ("Input: pinephone-keyboard - add PinePhone keyboard driver")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/input/keyboard/pinephone-keyboard.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/keyboard/pinephone-keyboard.c b/drivers/input/keyboard/pinephone-keyboard.c
index c1b291428f36..06ff614dbb88 100644
--- a/drivers/input/keyboard/pinephone-keyboard.c
+++ b/drivers/input/keyboard/pinephone-keyboard.c
@@ -440,8 +440,8 @@ static int ppkb_probe(struct i2c_client *client)
 	ret = devm_request_threaded_irq(dev, client->irq, NULL, ppkb_irq_thread,
 					IRQF_ONESHOT, client->name, client);
 	if (ret) {
-		dev_err(dev, "Failed to request IRQ: %d\n", error);
-		return error;
+		dev_err(dev, "Failed to request IRQ: %d\n", ret);
+		return ret;
 	}
 
 	return 0;
-- 
2.25.1

