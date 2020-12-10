Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19284C4361B
	for <linux-input@archiver.kernel.org>; Thu, 10 Dec 2020 14:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE56A23B85
	for <linux-input@archiver.kernel.org>; Thu, 10 Dec 2020 14:00:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389801AbgLJOAN (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 10 Dec 2020 09:00:13 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9155 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731316AbgLJOAN (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 10 Dec 2020 09:00:13 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CsFrX3sD6z15ZQ8;
        Thu, 10 Dec 2020 21:58:52 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Thu, 10 Dec 2020 21:59:15 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <nick@shmanahar.org>, <dmitry.torokhov@gmail.com>,
        <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH -next] input/touchscreen: simplify the return expression of mxt_send_bootloader_cmd()
Date:   Thu, 10 Dec 2020 21:59:43 +0800
Message-ID: <20201210135943.1612-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.138.68]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Simplify the return expression.

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index b6f75367a284..664fd940c06e 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -606,7 +606,6 @@ static int mxt_check_bootloader(struct mxt_data *data, unsigned int state,
 
 static int mxt_send_bootloader_cmd(struct mxt_data *data, bool unlock)
 {
-	int ret;
 	u8 buf[2];
 
 	if (unlock) {
@@ -617,11 +616,7 @@ static int mxt_send_bootloader_cmd(struct mxt_data *data, bool unlock)
 		buf[1] = 0x01;
 	}
 
-	ret = mxt_bootloader_write(data, buf, 2);
-	if (ret)
-		return ret;
-
-	return 0;
+	return mxt_bootloader_write(data, buf, 2);
 }
 
 static int __mxt_read_reg(struct i2c_client *client,
-- 
2.22.0

