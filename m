Return-Path: <SRS0=QjMs=BP=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D248C433DF
	for <linux-input@archiver.kernel.org>; Wed,  5 Aug 2020 16:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4053A22CF7
	for <linux-input@archiver.kernel.org>; Wed,  5 Aug 2020 16:37:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbgHEQgv (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 5 Aug 2020 12:36:51 -0400
Received: from mail.ispras.ru ([83.149.199.84]:43470 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727066AbgHEQe6 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 5 Aug 2020 12:34:58 -0400
Received: from hellwig.intra.ispras.ru (unknown [10.10.2.182])
        by mail.ispras.ru (Postfix) with ESMTPS id 11CDD40A204E;
        Wed,  5 Aug 2020 12:48:41 +0000 (UTC)
From:   Evgeny Novikov <novikov@ispras.ru>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Evgeny Novikov <novikov@ispras.ru>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: [PATCH] HID: u2fzero: handle errors of u2fzero_fill_in_urb() in probe
Date:   Wed,  5 Aug 2020 15:48:40 +0300
Message-Id: <20200805124840.6893-1-novikov@ispras.ru>
X-Mailer: git-send-email 2.16.4
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

u2fzero_probe() does not handle errors of u2fzero_fill_in_urb(). The
patch fixes that.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Evgeny Novikov <novikov@ispras.ru>
---
 drivers/hid/hid-u2fzero.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-u2fzero.c b/drivers/hid/hid-u2fzero.c
index 95e0807878c7..0632f6c3aa66 100644
--- a/drivers/hid/hid-u2fzero.c
+++ b/drivers/hid/hid-u2fzero.c
@@ -315,7 +315,11 @@ static int u2fzero_probe(struct hid_device *hdev,
 	if (ret)
 		return ret;
 
-	u2fzero_fill_in_urb(dev);
+	ret = u2fzero_fill_in_urb(dev);
+	if (ret) {
+		hid_hw_stop(hdev);
+		return ret;
+	}
 
 	dev->present = true;
 
-- 
2.26.2

