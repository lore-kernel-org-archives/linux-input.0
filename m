Return-Path: <SRS0=Jdnn=A7=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD72C433DF
	for <linux-input@archiver.kernel.org>; Mon, 20 Jul 2020 09:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44AF02080D
	for <linux-input@archiver.kernel.org>; Mon, 20 Jul 2020 09:18:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbgGTJSO (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 20 Jul 2020 05:18:14 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7794 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727120AbgGTJSO (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 20 Jul 2020 05:18:14 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 02B1134C9AB3778AA8DC;
        Mon, 20 Jul 2020 17:18:12 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Mon, 20 Jul 2020 17:18:02 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <syrjala@sci.fi>, <dmitry.torokhov@gmail.com>
CC:     <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wangxiongfeng2@huawei.com>
Subject: [PATCH] Input: ati_remote2 - add missing newlines when printing module parameters
Date:   Mon, 20 Jul 2020 17:21:48 +0800
Message-ID: <20200720092148.9320-1-wangxiongfeng2@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

When I cat some module parameters by sysfs, it displays as follows. It's
better to add a newline for easy reading.

root@syzkaller:~# cat /sys/module/ati_remote2/parameters/mode_mask
0x1froot@syzkaller:~# cat /sys/module/ati_remote2/parameters/channel_mask
0xffffroot@syzkaller:~#

Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
---
 drivers/input/misc/ati_remote2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/misc/ati_remote2.c b/drivers/input/misc/ati_remote2.c
index 305f0160506a..8a36d78fed63 100644
--- a/drivers/input/misc/ati_remote2.c
+++ b/drivers/input/misc/ati_remote2.c
@@ -68,7 +68,7 @@ static int ati_remote2_get_channel_mask(char *buffer,
 {
 	pr_debug("%s()\n", __func__);
 
-	return sprintf(buffer, "0x%04x", *(unsigned int *)kp->arg);
+	return sprintf(buffer, "0x%04x\n", *(unsigned int *)kp->arg);
 }
 
 static int ati_remote2_set_mode_mask(const char *val,
@@ -84,7 +84,7 @@ static int ati_remote2_get_mode_mask(char *buffer,
 {
 	pr_debug("%s()\n", __func__);
 
-	return sprintf(buffer, "0x%02x", *(unsigned int *)kp->arg);
+	return sprintf(buffer, "0x%02x\n", *(unsigned int *)kp->arg);
 }
 
 static unsigned int channel_mask = ATI_REMOTE2_MAX_CHANNEL_MASK;
-- 
2.20.1

