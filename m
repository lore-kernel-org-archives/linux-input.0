Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 847C8C433E0
	for <linux-input@archiver.kernel.org>; Mon, 15 Feb 2021 16:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56BDE64E05
	for <linux-input@archiver.kernel.org>; Mon, 15 Feb 2021 16:41:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbhBOQln (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 15 Feb 2021 11:41:43 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:53128 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231750AbhBOQkL (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 15 Feb 2021 11:40:11 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1lBguA-0000kD-2y; Mon, 15 Feb 2021 16:39:22 +0000
From:   Colin King <colin.king@canonical.com>
To:     Roderick Colenbrander <roderick.colenbrander@sony.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        =?UTF-8?q?Barnab=C3=A1s=20P=C5=91cze?= <pobrn@protonmail.com>,
        linux-input@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] HID: playstation: fix array size comparison (off-by-one)
Date:   Mon, 15 Feb 2021 16:39:21 +0000
Message-Id: <20210215163921.84283-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The comparison of value with the array size ps_gamepad_hat_mapping
appears to be off-by-one. Fix this by using >= rather than > for the
size comparison.

Addresses-Coverity: ("Out-of-bounds read")
Fixes: bc2e15a9a022 ("HID: playstation: initial DualSense USB support.")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/hid/hid-playstation.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-playstation.c b/drivers/hid/hid-playstation.c
index 408b651174cf..568a3a067c88 100644
--- a/drivers/hid/hid-playstation.c
+++ b/drivers/hid/hid-playstation.c
@@ -1064,7 +1064,7 @@ static int dualsense_parse_report(struct ps_device *ps_dev, struct hid_report *r
 	input_report_abs(ds->gamepad, ABS_RZ, ds_report->rz);
 
 	value = ds_report->buttons[0] & DS_BUTTONS0_HAT_SWITCH;
-	if (value > ARRAY_SIZE(ps_gamepad_hat_mapping))
+	if (value >= ARRAY_SIZE(ps_gamepad_hat_mapping))
 		value = 8; /* center */
 	input_report_abs(ds->gamepad, ABS_HAT0X, ps_gamepad_hat_mapping[value].x);
 	input_report_abs(ds->gamepad, ABS_HAT0Y, ps_gamepad_hat_mapping[value].y);
-- 
2.30.0

