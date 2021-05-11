Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA8BC433ED
	for <linux-input@archiver.kernel.org>; Tue, 11 May 2021 11:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC9DF6186A
	for <linux-input@archiver.kernel.org>; Tue, 11 May 2021 11:28:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbhEKL3V (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 11 May 2021 07:29:21 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:2630 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbhEKL3V (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 11 May 2021 07:29:21 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FfbG23c23zld41;
        Tue, 11 May 2021 19:26:02 +0800 (CST)
Received: from huawei.com (10.175.103.91) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.498.0; Tue, 11 May 2021
 19:28:09 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jikos@kernel.org>, <benjamin.tissoires@redhat.com>
Subject: [PATCH -next] HID: thrustmaster: Switch to kmemdup() when allocate change_request
Date:   Tue, 11 May 2021 19:30:33 +0800
Message-ID: <20210511113033.3760555-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Use kmemdup() helper instead of open-coding to
simplify the code when allocate change_request.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/hid/hid-thrustmaster.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-thrustmaster.c b/drivers/hid/hid-thrustmaster.c
index f643b1cb112d..cdc7d82ae9ed 100644
--- a/drivers/hid/hid-thrustmaster.c
+++ b/drivers/hid/hid-thrustmaster.c
@@ -311,12 +311,13 @@ static int thrustmaster_probe(struct hid_device *hdev, const struct hid_device_i
 		goto error4;
 	}
 
-	tm_wheel->change_request = kzalloc(sizeof(struct usb_ctrlrequest), GFP_KERNEL);
+	tm_wheel->change_request = kmemdup(&change_request,
+					   sizeof(struct usb_ctrlrequest),
+					   GFP_KERNEL);
 	if (!tm_wheel->change_request) {
 		ret = -ENOMEM;
 		goto error5;
 	}
-	memcpy(tm_wheel->change_request, &change_request, sizeof(struct usb_ctrlrequest));
 
 	tm_wheel->usb_dev = interface_to_usbdev(to_usb_interface(hdev->dev.parent));
 	hid_set_drvdata(hdev, tm_wheel);
-- 
2.25.1

