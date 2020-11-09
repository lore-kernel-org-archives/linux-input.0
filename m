Return-Path: <SRS0=uY0c=EP=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4968AC2D0A3
	for <linux-input@archiver.kernel.org>; Mon,  9 Nov 2020 03:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2568221FE
	for <linux-input@archiver.kernel.org>; Mon,  9 Nov 2020 03:44:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729181AbgKIDoE (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Sun, 8 Nov 2020 22:44:04 -0500
Received: from m176115.mail.qiye.163.com ([59.111.176.115]:14077 "EHLO
        m176115.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728814AbgKIDoD (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Sun, 8 Nov 2020 22:44:03 -0500
Received: from vivo-HP-ProDesk-680-G4-PCI-MT.vivo.xyz (unknown [58.251.74.231])
        by m176115.mail.qiye.163.com (Hmail) with ESMTPA id 85E0E6663C4;
        Mon,  9 Nov 2020 11:44:00 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Wang Qing <wangqing@vivo.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] touchscreen: use kobj_to_dev() API
Date:   Mon,  9 Nov 2020 11:43:54 +0800
Message-Id: <1604893436-20206-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZHU8fTkxLQ01DSkJNVkpNS09DQkhPT0tDT09VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKQ1VLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OhA6CDo5Fj8YNxIpKkIhHhMX
        NgtPFDZVSlVKTUtPQ0JIT09KSE9DVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZTkNV
        SU5KVUxPVUlISllXWQgBWUFKTk1CNwY+
X-HM-Tid: 0a75ab1a7ac99373kuws85e0e6663c4
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Use kobj_to_dev() instead of container_of().

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 drivers/input/touchscreen/ads7846.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index 8fd7fc3..ee74da2
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -481,7 +481,7 @@ SHOW(in1_input, vbatt, vbatt_adjust)
 static umode_t ads7846_is_visible(struct kobject *kobj, struct attribute *attr,
 				  int index)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct ads7846 *ts = dev_get_drvdata(dev);
 
 	if (ts->model == 7843 && index < 2)	/* in0, in1 */
-- 
2.7.4

