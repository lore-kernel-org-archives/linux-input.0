Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03EA1C07E9D
	for <linux-input@archiver.kernel.org>; Mon, 26 Sep 2022 14:42:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235192AbiIZOmU (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 26 Sep 2022 10:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233362AbiIZOlc (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 26 Sep 2022 10:41:32 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 209402F657;
        Mon, 26 Sep 2022 06:04:11 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Mbg0X0hhhzpVMD;
        Mon, 26 Sep 2022 19:05:48 +0800 (CST)
Received: from huawei.com (10.67.175.83) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 26 Sep
 2022 19:08:41 +0800
From:   ruanjinjie <ruanjinjie@huawei.com>
To:     <jikos@kernel.org>, <benjamin.tissoires@redhat.com>,
        <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH -next] HID: cmedia: Add __init/__exit annotations to module init/exit funcs
Date:   Mon, 26 Sep 2022 19:04:53 +0800
Message-ID: <20220926110453.1316273-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.175.83]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Add missing __init/__exit annotations to module init/exit funcs

Signed-off-by: ruanjinjie <ruanjinjie@huawei.com>
---
 drivers/hid/hid-cmedia.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-cmedia.c b/drivers/hid/hid-cmedia.c
index cab42047bc99..c5bd14544cdc 100644
--- a/drivers/hid/hid-cmedia.c
+++ b/drivers/hid/hid-cmedia.c
@@ -222,7 +222,7 @@ static struct hid_driver cmhid_hs100b_driver = {
 	.report_fixup = cmhid_hs100b_report_fixup,
 };
 
-static int cmedia_init(void)
+static int __init cmedia_init(void)
 {
 	int ret;
 
@@ -238,7 +238,7 @@ static int cmedia_init(void)
 }
 module_init(cmedia_init);
 
-static void cmedia_exit(void)
+static void __exit cmedia_exit(void)
 {
 		hid_unregister_driver(&cmhid_driver);
 		hid_unregister_driver(&cmhid_hs100b_driver);
-- 
2.25.1

