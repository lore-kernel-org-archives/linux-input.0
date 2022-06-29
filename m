Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4582AC43334
	for <linux-input@archiver.kernel.org>; Wed, 29 Jun 2022 05:47:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbiF2Fq6 (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 29 Jun 2022 01:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiF2Fq6 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 29 Jun 2022 01:46:58 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C3F9A2A253;
        Tue, 28 Jun 2022 22:46:56 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id DB1B31E80D11;
        Wed, 29 Jun 2022 13:45:44 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id p620UYKZsPNG; Wed, 29 Jun 2022 13:45:42 +0800 (CST)
Received: from localhost.localdomain (unknown [180.167.10.98])
        (Authenticated sender: jiaming@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id DD9D91E80CDC;
        Wed, 29 Jun 2022 13:45:41 +0800 (CST)
From:   Zhang Jiaming <jiaming@nfschina.com>
To:     jikos@kernel.org, benjamin.tissoires@redhat.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        liqiong@nfschina.com, renyu@nfschina.com,
        Zhang Jiaming <jiaming@nfschina.com>
Subject: [PATCH] HID: Fix a spelling mistake
Date:   Wed, 29 Jun 2022 13:46:24 +0800
Message-Id: <20220629054624.21330-1-jiaming@nfschina.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Change 'accross' to 'across'.

Signed-off-by: Zhang Jiaming <jiaming@nfschina.com>
---
 drivers/hid/hid-appleir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-appleir.c b/drivers/hid/hid-appleir.c
index 8deded185725..d84d69e52c15 100644
--- a/drivers/hid/hid-appleir.c
+++ b/drivers/hid/hid-appleir.c
@@ -117,7 +117,7 @@ struct appleir {
 static int get_key(int data)
 {
 	/*
-	 * The key is coded accross bits 2..9:
+	 * The key is coded across bits 2..9:
 	 *
 	 * 0x00 or 0x01 (        )	key:  0		-> KEY_RESERVED
 	 * 0x02 or 0x03 (  menu  )	key:  1		-> KEY_MENU
-- 
2.34.1

