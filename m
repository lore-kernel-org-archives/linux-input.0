Return-Path: <linux-input-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C54CC636D6
	for <linux-input@archiver.kernel.org>; Fri,  3 Feb 2023 10:19:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233384AbjBCKS7 (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 3 Feb 2023 05:18:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233121AbjBCKSY (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 3 Feb 2023 05:18:24 -0500
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB8CF2D7E;
        Fri,  3 Feb 2023 02:18:08 -0800 (PST)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id C32271C0007;
        Fri,  3 Feb 2023 10:18:01 +0000 (UTC)
From:   Bastien Nocera <hadess@hadess.net>
To:     linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "Peter F . Patel-Schneider" <pfpschneider@gmail.com>,
        =?UTF-8?q?Filipe=20La=C3=ADns?= <lains@riseup.net>,
        Nestor Lopez Casado <nlopezcasad@logitech.com>,
        Tobias Klausmann <klausman@schwarzvogel.de>,
        stable@vger.kernel.org
Subject: [PATCH] HID: logitech: Disable hi-res scrolling on USB
Date:   Fri,  3 Feb 2023 11:18:00 +0100
Message-Id: <20230203101800.139380-1-hadess@hadess.net>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On some Logitech mice, such as the G903, and possibly the G403, the HID
events are generated on a different interface to the HID++ one.

If we enable hi-res through the HID++ interface, the HID interface
wouldn't know anything about it, and handle the events as if they were
regular scroll events, making the mouse unusable.

Disable hi-res scrolling on those devices until we implement scroll
events through HID++.

Signed-off-by: Bastien Nocera <hadess@hadess.net>
Tested-by: Tobias Klausmann <klausman@schwarzvogel.de>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=216885
Fixes: 908d325e1665 ("HID: logitech-hidpp: Detect hi-res scrolling support")
Cc: stable@vger.kernel.org
---
 drivers/hid/hid-logitech-hidpp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index abf2c95e4d0b..9c1ee8e91e0c 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -3978,7 +3978,8 @@ static void hidpp_connect_event(struct hidpp_device *hidpp)
 	}
 
 	hidpp_initialize_battery(hidpp);
-	hidpp_initialize_hires_scroll(hidpp);
+	if (!hid_is_usb(hidpp->hid_dev))
+		hidpp_initialize_hires_scroll(hidpp);
 
 	/* forward current battery state */
 	if (hidpp->capabilities & HIDPP_CAPABILITY_HIDPP10_BATTERY) {
-- 
2.39.1

