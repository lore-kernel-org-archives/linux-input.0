Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 861D3C433DB
	for <linux-input@archiver.kernel.org>; Tue,  2 Feb 2021 08:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2617064F0C
	for <linux-input@archiver.kernel.org>; Tue,  2 Feb 2021 08:22:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232573AbhBBIUA (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 2 Feb 2021 03:20:00 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:39295 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231718AbhBBIT5 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 2 Feb 2021 03:19:57 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UNfe.-m_1612253942;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UNfe.-m_1612253942)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 02 Feb 2021 16:19:09 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] HID: wacom: convert sysfs sprintf/snprintf family to sysfs_emit
Date:   Tue,  2 Feb 2021 16:19:00 +0800
Message-Id: <1612253940-19396-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Fix the following coccicheck warning:

./drivers/hid/wacom_sys.c:1828:8-16: WARNING: use scnprintf or sprintf.

Reported-by: Abaci Robot<abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/hid/wacom_sys.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index aa9e488..8328ef1 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -1825,7 +1825,7 @@ static ssize_t wacom_show_speed(struct device *dev,
 	struct hid_device *hdev = to_hid_device(dev);
 	struct wacom *wacom = hid_get_drvdata(hdev);
 
-	return snprintf(buf, PAGE_SIZE, "%i\n", wacom->wacom_wac.bt_high_speed);
+	return sysfs_emit(buf, "%i\n", wacom->wacom_wac.bt_high_speed);
 }
 
 static ssize_t wacom_store_speed(struct device *dev,
-- 
1.8.3.1

