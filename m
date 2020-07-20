Return-Path: <SRS0=Jdnn=A7=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 620FDC433E1
	for <linux-input@archiver.kernel.org>; Mon, 20 Jul 2020 07:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4315D20734
	for <linux-input@archiver.kernel.org>; Mon, 20 Jul 2020 07:35:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbgGTHfM (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 20 Jul 2020 03:35:12 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:45184 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726015AbgGTHfM (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 20 Jul 2020 03:35:12 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 7FDB657DAFAFD591F2F8;
        Mon, 20 Jul 2020 15:35:08 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Mon, 20 Jul 2020 15:35:00 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <dmitry.torokhov@gmail.com>
CC:     <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wangxiongfeng2@huawei.com>
Subject: [PATCH] Input: psmouse: add a newline when printing 'proto' by sysfs
Date:   Mon, 20 Jul 2020 15:38:46 +0800
Message-ID: <20200720073846.120724-1-wangxiongfeng2@huawei.com>
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

When I cat parameter 'proto' by sysfs, it displays as follows. It's
better to add a newline for easy reading.

root@syzkaller:~# cat /sys/module/psmouse/parameters/proto
autoroot@syzkaller:~#

Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
---
 drivers/input/mouse/psmouse-base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
index 527ae0b9a191..0b4a3039f312 100644
--- a/drivers/input/mouse/psmouse-base.c
+++ b/drivers/input/mouse/psmouse-base.c
@@ -2042,7 +2042,7 @@ static int psmouse_get_maxproto(char *buffer, const struct kernel_param *kp)
 {
 	int type = *((unsigned int *)kp->arg);
 
-	return sprintf(buffer, "%s", psmouse_protocol_by_type(type)->name);
+	return sprintf(buffer, "%s\n", psmouse_protocol_by_type(type)->name);
 }
 
 static int __init psmouse_init(void)
-- 
2.20.1

