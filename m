Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17AB3C4338F
	for <linux-input@archiver.kernel.org>; Fri, 20 Aug 2021 16:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4B5560FE8
	for <linux-input@archiver.kernel.org>; Fri, 20 Aug 2021 16:17:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbhHTQRi (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 20 Aug 2021 12:17:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:48826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229564AbhHTQRh (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 20 Aug 2021 12:17:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C42B460720;
        Fri, 20 Aug 2021 16:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629476219;
        bh=TnlZsH5T8IalobGionC0EY3BVtmmtUTG/h0L6aAoDc8=;
        h=From:To:Cc:Subject:Date:From;
        b=jQeceUJ7Rtp27K0xcte1+kJYTHvJ/KkMSUoHgCYr6wHA1I+qnvH1GA1yTI+W5Dh1z
         kyLFei77WPUf2+W5qcC8M4NMR1s5Ds9/L/2cpiuD+V3uu1CuI5H+6cseDbNqeY6s+C
         OWImlxGEja18sOveC4o/WD0m+i5W9+TEqz4/PQBMFhKgxT7gqkGcFoYmQ0z7vG5aNh
         BZH7/6teDEaw7kyjh6q7ZkWpdLfYS+ZFQLe7t8eT70Y0YAj93NlnE6yC4IJ1bMbT3f
         eG3fbqaxZioDD7jngZQvaepa7Z4e6TLAax0JxwT/Ql23laAEnaxGm7KQ8sAgWJqHDE
         qVcMaGYKy8KDw==
From:   Felipe Balbi <balbi@kernel.org>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-input@vger.kernel.org,
        Felipe Balbi <felipe.balbi@microsoft.com>
Subject: [PATCH] HID: core: add TransducerSerialNumber2
Date:   Fri, 20 Aug 2021 19:16:55 +0300
Message-Id: <20210820161655.211583-1-balbi@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

From: Felipe Balbi <felipe.balbi@microsoft.com>

A recent request for change to the HID spec got approved adding support
for another 4-bytes to the Transducer Serial Number. This commit adds
support for the new usage.

https://www.usb.org/sites/default/files/hutrr103-transducerserialnumbermoresignificantbits_0.pdf

Signed-off-by: Felipe Balbi <felipe.balbi@microsoft.com>
---
 drivers/hid/hid-debug.c | 1 +
 drivers/hid/hid-input.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/hid/hid-debug.c b/drivers/hid/hid-debug.c
index fa57d05badf7..e6f18a181eb8 100644
--- a/drivers/hid/hid-debug.c
+++ b/drivers/hid/hid-debug.c
@@ -160,6 +160,7 @@ static const struct hid_usage_entry hid_usage_table[] = {
     {0, 0x59, "ButtonType"},
     {0, 0x5A, "SecondaryBarrelSwitch"},
     {0, 0x5B, "TransducerSerialNumber"},
+    {0, 0x6e, "TransducerSerialNumber2"},
   { 15, 0, "PhysicalInterfaceDevice" },
     {0, 0x00, "Undefined"},
     {0, 0x01, "Physical_Interface_Device"},
diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 4286a51f7f16..82089b59609f 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -873,6 +873,7 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 			break;
 
 		case 0x5b: /* TransducerSerialNumber */
+		case 0x6e: /* TransducerSerialNumber2 */
 			usage->type = EV_MSC;
 			usage->code = MSC_SERIAL;
 			bit = input->mscbit;
-- 
2.32.0

