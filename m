Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7040AC2D0A3
	for <linux-input@archiver.kernel.org>; Tue, 10 Nov 2020 03:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13964206CB
	for <linux-input@archiver.kernel.org>; Tue, 10 Nov 2020 03:15:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729243AbgKJDPx (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 9 Nov 2020 22:15:53 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7510 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728607AbgKJDPw (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Mon, 9 Nov 2020 22:15:52 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CVY0H3js5zhhK1;
        Tue, 10 Nov 2020 11:15:43 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Tue, 10 Nov 2020 11:15:41 +0800
From:   Jing Xiangfeng <jingxiangfeng@huawei.com>
To:     <srinivas.pandruvada@linux.intel.com>, <jikos@kernel.org>,
        <benjamin.tissoires@redhat.com>
CC:     <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jingxiangfeng@huawei.com>
Subject: [PATCH] HID: intel-ish-hid: Remove unnecessary assignment to variable rv
Date:   Tue, 10 Nov 2020 11:20:49 +0800
Message-ID: <20201110032049.187404-1-jingxiangfeng@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

This assignment to rv is unused in an error path. So remove it.

Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
---
 drivers/hid/intel-ish-hid/ishtp-hid.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/intel-ish-hid/ishtp-hid.c b/drivers/hid/intel-ish-hid/ishtp-hid.c
index b8aae69ad15d..393bed0abee9 100644
--- a/drivers/hid/intel-ish-hid/ishtp-hid.c
+++ b/drivers/hid/intel-ish-hid/ishtp-hid.c
@@ -211,10 +211,8 @@ int ishtp_hid_probe(unsigned int cur_hid_dev,
 	struct ishtp_hid_data *hid_data;
 
 	hid = hid_allocate_device();
-	if (IS_ERR(hid)) {
-		rv = PTR_ERR(hid);
-		return	-ENOMEM;
-	}
+	if (IS_ERR(hid))
+		return PTR_ERR(hid);
 
 	hid_data = kzalloc(sizeof(*hid_data), GFP_KERNEL);
 	if (!hid_data) {
-- 
2.17.1

