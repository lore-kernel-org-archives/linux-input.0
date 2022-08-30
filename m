Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FCECC0502A
	for <linux-input@archiver.kernel.org>; Tue, 30 Aug 2022 11:40:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbiH3Lk4 (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 30 Aug 2022 07:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbiH3Lkh (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 30 Aug 2022 07:40:37 -0400
Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [217.70.178.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC8967458;
        Tue, 30 Aug 2022 04:39:14 -0700 (PDT)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id 6277620000B;
        Tue, 30 Aug 2022 11:39:11 +0000 (UTC)
From:   Bastien Nocera <hadess@hadess.net>
To:     linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "Peter F . Patel-Schneider" <pfpschneider@gmail.com>,
        =?UTF-8?q?Filipe=20La=C3=ADns?= <lains@riseup.net>,
        Nestor Lopez Casado <nlopezcasad@logitech.com>
Subject: [v3 3/5] HID: logitech-hidpp: Remove special-casing of Bluetooth devices
Date:   Tue, 30 Aug 2022 13:39:05 +0200
Message-Id: <20220830113907.4886-3-hadess@hadess.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220830113907.4886-1-hadess@hadess.net>
References: <20220830113907.4886-1-hadess@hadess.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Now that all the Logitech Bluetooth devices are probed for HID++
support, remove the handling of those 2 devices without any quirks, as
they're duplicates.

Signed-off-by: Bastien Nocera <hadess@hadess.net>
---
 drivers/hid/hid-logitech-hidpp.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 641c897bf714..98ebedb73d98 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -4350,13 +4350,9 @@ static const struct hid_device_id hidpp_devices[] = {
 	{ /* MX5500 keyboard over Bluetooth */
 	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb30b),
 	  .driver_data = HIDPP_QUIRK_HIDPP_CONSUMER_VENDOR_KEYS },
-	{ /* M-RCQ142 V470 Cordless Laser Mouse over Bluetooth */
-	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb008) },
 	{ /* MX Master mouse over Bluetooth */
 	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb012),
 	  .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
-	{ /* MX Ergo trackball over Bluetooth */
-	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb01d) },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb01e),
 	  .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
 	{ /* MX Master 3 mouse over Bluetooth */
-- 
2.37.2

