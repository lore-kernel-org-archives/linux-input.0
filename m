Return-Path: <linux-input-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50913C77B73
	for <linux-input@archiver.kernel.org>; Wed, 31 May 2023 08:24:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234595AbjEaIYg (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 31 May 2023 04:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234862AbjEaIYe (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 31 May 2023 04:24:34 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D3BBE;
        Wed, 31 May 2023 01:24:32 -0700 (PDT)
X-GND-Sasl: hadess@hadess.net
X-GND-Sasl: hadess@hadess.net
X-GND-Sasl: hadess@hadess.net
X-GND-Sasl: hadess@hadess.net
X-GND-Sasl: hadess@hadess.net
X-GND-Sasl: hadess@hadess.net
X-GND-Sasl: hadess@hadess.net
X-GND-Sasl: hadess@hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 219601BF20B;
        Wed, 31 May 2023 08:24:28 +0000 (UTC)
From:   Bastien Nocera <hadess@hadess.net>
To:     linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "Peter F . Patel-Schneider" <pfpschneider@gmail.com>,
        =?UTF-8?q?Filipe=20La=C3=ADns?= <lains@riseup.net>,
        Nestor Lopez Casado <nlopezcasad@logitech.com>,
        Mark Lord <mlord@pobox.com>
Subject: [PATCH] HID: logitech-hidpp: Handle timeout differently from busy
Date:   Wed, 31 May 2023 10:24:28 +0200
Message-Id: <20230531082428.21763-1-hadess@hadess.net>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

If an attempt at contacting a receiver or a device fails because the
receiver or device never responds, don't restart the communication, only
restart it if the receiver or device answers that it's busy, as originally
intended.

This was the behaviour on communication timeout before commit 586e8fede795
("HID: logitech-hidpp: Retry commands when device is busy").

This fixes some overly long waits in a critical path on boot, when
checking whether the device is connected by getting its HID++ version.

Signed-off-by: Bastien Nocera <hadess@hadess.net>
Suggested-by: Mark Lord <mlord@pobox.com>
Fixes: 586e8fede795 ("HID: logitech-hidpp: Retry commands when device is busy")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=217412
---
 drivers/hid/hid-logitech-hidpp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 0fcfd85fea0f..2246044b1639 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -314,6 +314,7 @@ static int hidpp_send_message_sync(struct hidpp_device *hidpp,
 			dbg_hid("%s:timeout waiting for response\n", __func__);
 			memset(response, 0, sizeof(struct hidpp_report));
 			ret = -ETIMEDOUT;
+			goto exit;
 		}
 
 		if (response->report_id == REPORT_ID_HIDPP_SHORT &&
-- 
2.40.1

