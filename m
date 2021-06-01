Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E446C47080
	for <linux-input@archiver.kernel.org>; Tue,  1 Jun 2021 11:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E2F3613AB
	for <linux-input@archiver.kernel.org>; Tue,  1 Jun 2021 11:05:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233509AbhFALHQ (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 1 Jun 2021 07:07:16 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:46918 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232569AbhFALHN (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 1 Jun 2021 07:07:13 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UawU1dh_1622545524;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UawU1dh_1622545524)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 01 Jun 2021 19:05:30 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, linux-usb@vger.kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] HID: usbhid: hid-pidff: Fix missing error code in hid_pidff_init()
Date:   Tue,  1 Jun 2021 19:05:18 +0800
Message-Id: <1622545518-18949-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

The error code is missing in this code scenario, add the error code
'-EINVAL' to the return value 'error'.

Eliminate the follow smatch warning:

drivers/hid/usbhid/hid-pidff.c:1297 hid_pidff_init() warn: missing error
code 'error'.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/hid/usbhid/hid-pidff.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/usbhid/hid-pidff.c b/drivers/hid/usbhid/hid-pidff.c
index ea126c5..731b49e 100644
--- a/drivers/hid/usbhid/hid-pidff.c
+++ b/drivers/hid/usbhid/hid-pidff.c
@@ -1294,6 +1294,7 @@ int hid_pidff_init(struct hid_device *hid)
 	    pidff->pool[PID_DEVICE_MANAGED_POOL].value[0] == 0) {
 		hid_notice(hid,
 			   "device does not support device managed pool\n");
+		error = -EINVAL;
 		goto fail;
 	}
 
-- 
1.8.3.1

