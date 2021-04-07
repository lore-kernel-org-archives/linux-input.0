Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 860DCC433ED
	for <linux-input@archiver.kernel.org>; Wed,  7 Apr 2021 06:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42A01613B3
	for <linux-input@archiver.kernel.org>; Wed,  7 Apr 2021 06:39:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233205AbhDGGjm (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 7 Apr 2021 02:39:42 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:46630 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231335AbhDGGjk (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 7 Apr 2021 02:39:40 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R551e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UUluIAu_1617777564;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UUluIAu_1617777564)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 07 Apr 2021 14:39:29 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     bonbons@linux-vserver.org
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] HID: picolcd: remove unused variable
Date:   Wed,  7 Apr 2021 14:39:22 +0800
Message-Id: <1617777562-86341-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Fix the following gcc warning:

drivers/hid/hid-picolcd_core.c:332:6: warning: variable ‘ret’ set but
not used [-Wunused-but-set-variable].

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/hid/hid-picolcd_core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-picolcd_core.c b/drivers/hid/hid-picolcd_core.c
index 1b5c632..682c2a2 100644
--- a/drivers/hid/hid-picolcd_core.c
+++ b/drivers/hid/hid-picolcd_core.c
@@ -329,7 +329,6 @@ static int picolcd_raw_event(struct hid_device *hdev,
 {
 	struct picolcd_data *data = hid_get_drvdata(hdev);
 	unsigned long flags;
-	int ret = 0;
 
 	if (!data)
 		return 1;
@@ -342,9 +341,9 @@ static int picolcd_raw_event(struct hid_device *hdev,
 
 	if (report->id == REPORT_KEY_STATE) {
 		if (data->input_keys)
-			ret = picolcd_raw_keypad(data, report, raw_data+1, size-1);
+			picolcd_raw_keypad(data, report, raw_data+1, size-1);
 	} else if (report->id == REPORT_IR_DATA) {
-		ret = picolcd_raw_cir(data, report, raw_data+1, size-1);
+			picolcd_raw_cir(data, report, raw_data+1, size-1);
 	} else {
 		spin_lock_irqsave(&data->lock, flags);
 		/*
-- 
1.8.3.1

