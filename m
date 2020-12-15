Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6CD1C4361B
	for <linux-input@archiver.kernel.org>; Tue, 15 Dec 2020 12:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96BCC224D4
	for <linux-input@archiver.kernel.org>; Tue, 15 Dec 2020 12:53:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729267AbgLOMxn (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 15 Dec 2020 07:53:43 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:33434 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728737AbgLOMxi (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 15 Dec 2020 07:53:38 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1kp9p0-00061Q-QI; Tue, 15 Dec 2020 12:52:54 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-usb@vger.kernel.org, linux-input@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] HID: fix spelling mistake in Kconfig "Uninterruptable" -> "Uninterruptible"
Date:   Tue, 15 Dec 2020 12:52:54 +0000
Message-Id: <20201215125254.200436-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in the Kconfig help text. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/hid/usbhid/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/usbhid/Kconfig b/drivers/hid/usbhid/Kconfig
index dcf3a235870f..7c2032f7f44d 100644
--- a/drivers/hid/usbhid/Kconfig
+++ b/drivers/hid/usbhid/Kconfig
@@ -38,7 +38,7 @@ config USB_HIDDEV
 	help
 	  Say Y here if you want to support HID devices (from the USB
 	  specification standpoint) that aren't strictly user interface
-	  devices, like monitor controls and Uninterruptable Power Supplies.
+	  devices, like monitor controls and Uninterruptible Power Supplies.
 
 	  This module supports these devices separately using a separate
 	  event interface on /dev/usb/hiddevX (char 180:96 to 180:111).
-- 
2.29.2

