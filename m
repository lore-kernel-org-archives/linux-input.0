Return-Path: <linux-input-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E1C1C77B61
	for <linux-input@archiver.kernel.org>; Sun, 16 Apr 2023 07:43:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbjDPHnG (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Sun, 16 Apr 2023 03:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjDPHnF (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 16 Apr 2023 03:43:05 -0400
Received: from hust.edu.cn (unknown [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B68139;
        Sun, 16 Apr 2023 00:43:03 -0700 (PDT)
Received: from amy-vm.localdomain ([10.12.183.232])
        (user=yejunyan@hust.edu.cn mech=LOGIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 33G7fDSE027706-33G7fDSF027706
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Sun, 16 Apr 2023 15:41:19 +0800
From:   Junyan Ye <yejunyan@hust.edu.cn>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        David Herrmann <dh.herrmann@gmail.com>
Cc:     hust-os-kernel-patches@googlegroups.com,
        Junyan Ye <yejunyan@hust.edu.cn>,
        Dongliang Mu <dzm91@hust.edu.cn>,
        Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] hid: hid-core: Adjust indentation in hid_add_device
Date:   Sun, 16 Apr 2023 15:38:44 +0800
Message-Id: <20230416073844.43093-1-yejunyan@hust.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-FEAS-AUTH-USER: yejunyan@hust.edu.cn
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Smatch reported:
drivers/hid/hid-core.c:2750 hid_add_device() warn: inconsistent indenting

There is an extra space before the if statement and its braces.

Fix this warning by removing the whitespace to conform to the coding style.

Fixes: 3c86726cfe38 ("HID: make .raw_request mandatory")
Signed-off-by: Junyan Ye <yejunyan@hust.edu.cn>
Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
---
 drivers/hid/hid-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 22623eb4f72f..80fc2eed6383 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2747,10 +2747,10 @@ int hid_add_device(struct hid_device *hdev)
 	/*
 	 * Check for the mandatory transport channel.
 	 */
-	 if (!hdev->ll_driver->raw_request) {
+	if (!hdev->ll_driver->raw_request) {
 		hid_err(hdev, "transport driver missing .raw_request()\n");
 		return -EINVAL;
-	 }
+	}
 
 	/*
 	 * Read the device report descriptor once and use as template
-- 
2.25.1

