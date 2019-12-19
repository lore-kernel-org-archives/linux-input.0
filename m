Return-Path: <SRS0=rf98=2J=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1726C43603
	for <linux-input@archiver.kernel.org>; Thu, 19 Dec 2019 02:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB109227BF
	for <linux-input@archiver.kernel.org>; Thu, 19 Dec 2019 02:45:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbfLSCp5 (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 18 Dec 2019 21:45:57 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:51948 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726463AbfLSCp5 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 18 Dec 2019 21:45:57 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 4B66DDCBE9980630A15D;
        Thu, 19 Dec 2019 10:45:55 +0800 (CST)
Received: from huawei.com (10.175.127.16) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Thu, 19 Dec 2019
 10:45:48 +0800
From:   Pan Zhang <zhangpan26@huawei.com>
To:     <benjamin.tissoires@redhat.com>, <jikos@kernel.org>,
        <rydberg@bitmath.org>, <zhangpan26@huawei.com>,
        <hushiyuan@huawei.com>
CC:     <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] drivers/hid/hid-multitouch.c: fix a possible null pointer access.
Date:   Thu, 19 Dec 2019 10:45:30 +0800
Message-ID: <1576723530-31381-1-git-send-email-zhangpan26@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.127.16]
X-CFilter-Loop: Reflected
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

1002     if ((quirks & MT_QUIRK_IGNORE_DUPLICATES) && mt) {
1003         struct input_mt_slot *i_slot = &mt->slots[slotnum];
1004 
1005         if (input_mt_is_active(i_slot) &&
1006             input_mt_is_used(mt, i_slot))
1007             return -EAGAIN;
1008     }

We previously assumed 'mt' could be null (see line 1002).

The following situation is similar, so add a judgement.

Signed-off-by: Pan Zhang <zhangpan26@huawei.com>
---
 drivers/hid/hid-multitouch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 3cfeb16..368de81 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -1019,7 +1019,7 @@ static int mt_process_slot(struct mt_device *td, struct input_dev *input,
 		tool = MT_TOOL_DIAL;
 	else if (unlikely(!confidence_state)) {
 		tool = MT_TOOL_PALM;
-		if (!active &&
+		if (!active && mt &&
 		    input_mt_is_active(&mt->slots[slotnum])) {
 			/*
 			 * The non-confidence was reported for
-- 
2.7.4

