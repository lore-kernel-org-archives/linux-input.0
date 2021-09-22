Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F788C433EF
	for <linux-input@archiver.kernel.org>; Wed, 22 Sep 2021 12:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49020611B0
	for <linux-input@archiver.kernel.org>; Wed, 22 Sep 2021 12:52:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236191AbhIVMyK (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 22 Sep 2021 08:54:10 -0400
Received: from mx22.baidu.com ([220.181.50.185]:48992 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236139AbhIVMyK (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 22 Sep 2021 08:54:10 -0400
Received: from BC-Mail-Ex06.internal.baidu.com (unknown [172.31.51.46])
        by Forcepoint Email with ESMTPS id 27417892826210F49DB4;
        Wed, 22 Sep 2021 20:52:37 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex06.internal.baidu.com (172.31.51.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Wed, 22 Sep 2021 20:52:36 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Wed, 22 Sep 2021 20:52:36 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <caihuoqing@baidu.com>
CC:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] Input: raydium_i2c_ts - Make use of the helper function devm_add_action_or_reset()
Date:   Wed, 22 Sep 2021 20:52:11 +0800
Message-ID: <20210922125212.95-3-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210922125212.95-1-caihuoqing@baidu.com>
References: <20210922125212.95-1-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BC-Mail-Ex21.internal.baidu.com (172.31.51.15) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

The helper function devm_add_action_or_reset() will internally
call devm_add_action(), and if devm_add_action() fails then it will
execute the action mentioned and return the error code. So
use devm_add_action_or_reset() instead of devm_add_action()
to simplify the error handling, reduce the code.

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
 drivers/input/touchscreen/raydium_i2c_ts.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/raydium_i2c_ts.c b/drivers/input/touchscreen/raydium_i2c_ts.c
index 92c48d8e35a4..ded77904ce87 100644
--- a/drivers/input/touchscreen/raydium_i2c_ts.c
+++ b/drivers/input/touchscreen/raydium_i2c_ts.c
@@ -1118,11 +1118,10 @@ static int raydium_i2c_probe(struct i2c_client *client,
 	if (error)
 		return error;
 
-	error = devm_add_action(&client->dev, raydium_i2c_power_off, ts);
+	error = devm_add_action_or_reset(&client->dev, raydium_i2c_power_off, ts);
 	if (error) {
 		dev_err(&client->dev,
 			"failed to install power off action: %d\n", error);
-		raydium_i2c_power_off(ts);
 		return error;
 	}
 
-- 
2.25.1

