Return-Path: <linux-input-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6374EB64D7
	for <linux-input@archiver.kernel.org>; Tue, 20 Jun 2023 08:50:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbjFTIun (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 20 Jun 2023 04:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231795AbjFTIue (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 20 Jun 2023 04:50:34 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6628C10C1;
        Tue, 20 Jun 2023 01:50:18 -0700 (PDT)
X-GND-Sasl: hadess@hadess.net
X-GND-Sasl: hadess@hadess.net
X-GND-Sasl: hadess@hadess.net
X-GND-Sasl: hadess@hadess.net
X-GND-Sasl: hadess@hadess.net
X-GND-Sasl: hadess@hadess.net
X-GND-Sasl: hadess@hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 440D91C0002;
        Tue, 20 Jun 2023 08:50:15 +0000 (UTC)
From:   Bastien Nocera <hadess@hadess.net>
To:     linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "Peter F . Patel-Schneider" <pfpschneider@gmail.com>,
        =?UTF-8?q?Filipe=20La=C3=ADns?= <lains@riseup.net>,
        Nestor Lopez Casado <nlopezcasad@logitech.com>
Subject: [PATCH] HID: logitech-hidpp: Rename HID++ "internal" error constant
Date:   Tue, 20 Jun 2023 10:50:14 +0200
Message-Id: <20230620085014.542370-1-hadess@hadess.net>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

As per the upstream "hidpp" helpers commit:
"
There has been some confusion about error value 5 but feature specs that
refer to it generally use NOT_ALLOWED.
"

Signed-off-by: Bastien Nocera <hadess@hadess.net>
Link: https://github.com/mrubli2/hidpp/commit/80c3fecfcd89c5efe0f16feabe90a55ddfd25aaa
---
 drivers/hid/hid-logitech-hidpp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 5e1a412fd28f..2dd86c23412b 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -228,7 +228,7 @@ struct hidpp_device {
 #define HIDPP20_ERROR_INVALID_ARGS		0x02
 #define HIDPP20_ERROR_OUT_OF_RANGE		0x03
 #define HIDPP20_ERROR_HW_ERROR			0x04
-#define HIDPP20_ERROR_LOGITECH_INTERNAL		0x05
+#define HIDPP20_ERROR_NOT_ALLOWED		0x05
 #define HIDPP20_ERROR_INVALID_FEATURE_INDEX	0x06
 #define HIDPP20_ERROR_INVALID_FUNCTION_ID	0x07
 #define HIDPP20_ERROR_BUSY			0x08
-- 
2.40.1

