Return-Path: <SRS0=DVc3=5G=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB87C4332B
	for <linux-input@archiver.kernel.org>; Sat, 21 Mar 2020 06:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0663620732
	for <linux-input@archiver.kernel.org>; Sat, 21 Mar 2020 06:41:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbgCUGlN (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Sat, 21 Mar 2020 02:41:13 -0400
Received: from smtp03.smtpout.orange.fr ([80.12.242.125]:22841 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727899AbgCUGlN (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 21 Mar 2020 02:41:13 -0400
Received: from localhost.localdomain ([90.126.162.40])
        by mwinf5d06 with ME
        id Guh7220090scBcy03uh8Hr; Sat, 21 Mar 2020 07:41:10 +0100
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 21 Mar 2020 07:41:10 +0100
X-ME-IP: 90.126.162.40
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     jikos@kernel.org, benjamin.tissoires@redhat.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] HID: rmi: Simplify an error handling path in 'rmi_hid_read_block()'
Date:   Sat, 21 Mar 2020 07:40:48 +0100
Message-Id: <20200321064048.15768-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

The 'RMI_READ_REQUEST_PENDING' bit is already cleared in the error handling
path. There is no need to reset it twice.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/hid/hid-rmi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/hid/hid-rmi.c b/drivers/hid/hid-rmi.c
index 9ce22acdfaca..8cffa84c9650 100644
--- a/drivers/hid/hid-rmi.c
+++ b/drivers/hid/hid-rmi.c
@@ -217,7 +217,6 @@ static int rmi_hid_read_block(struct rmi_transport_dev *xport, u16 addr,
 		ret = rmi_write_report(hdev, data->writeReport,
 						data->output_report_size);
 		if (ret != data->output_report_size) {
-			clear_bit(RMI_READ_REQUEST_PENDING, &data->flags);
 			dev_err(&hdev->dev,
 				"failed to write request output report (%d)\n",
 				ret);
-- 
2.20.1

