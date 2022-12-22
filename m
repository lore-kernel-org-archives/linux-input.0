Return-Path: <linux-input-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C1DC4332F
	for <linux-input@archiver.kernel.org>; Thu, 22 Dec 2022 05:10:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234459AbiLVFKy (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 22 Dec 2022 00:10:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbiLVFKw (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 22 Dec 2022 00:10:52 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12268165B2;
        Wed, 21 Dec 2022 21:10:50 -0800 (PST)
From:   Thomas =?utf-8?q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1671685848;
        bh=RIY1KZguWJeqHeg13Dbz3EKLW3n5Yawly4C6fJX/LRo=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=B4KopxcGDKneLhdAvB+atbk/GeTqzo6ATdvLeucyapM3W/3YYRA4GH5o+Aa+jUqvr
         DsyaescBu1lPdwZen5tz3kT2577Fh2cp5C3B75c5tTBQfFMdE6YSMkbudcV3v/42nf
         0mRODCEI7Tom4lYQPSvqzdcZijSAf7VZXJ4NEWcs=
Date:   Thu, 22 Dec 2022 05:10:47 +0000
Subject: [PATCH 4/8] HID: Unexport struct usb_hid_driver
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Message-Id: <20221222-hid-v1-4-f4a6c35487a5@weissschuh.net>
References: <20221222-hid-v1-0-f4a6c35487a5@weissschuh.net>
In-Reply-To: <20221222-hid-v1-0-f4a6c35487a5@weissschuh.net>
To:     Hans de Goede <hdegoede@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        David Rheinsberg <david.rheinsberg@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org,
        Thomas =?utf-8?q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.11.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1671685845; l=1454;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=RIY1KZguWJeqHeg13Dbz3EKLW3n5Yawly4C6fJX/LRo=;
 b=Twlbh9MUsolPC82vCzevu0rgTC04hHdXtPIymvu1dlWN4lhliG2xZcHHYVBpMH7XO1SMuEjKKlp7
 hpKtj9u4C3bfXOpPLVvR2NF9tVYHgzvL6IRNjQZRixgb8yX4EhSl
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

As no external users remain this implementation detail does not need to
be exported anymore.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/hid/usbhid/hid-core.c | 3 +--
 include/linux/hid.h           | 1 -
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index 54b0280d0073..4143bab3380a 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -1318,7 +1318,7 @@ static bool usbhid_may_wakeup(struct hid_device *hid)
 	return device_may_wakeup(&dev->dev);
 }
 
-struct hid_ll_driver usb_hid_driver = {
+static struct hid_ll_driver usb_hid_driver = {
 	.parse = usbhid_parse,
 	.start = usbhid_start,
 	.stop = usbhid_stop,
@@ -1332,7 +1332,6 @@ struct hid_ll_driver usb_hid_driver = {
 	.idle = usbhid_idle,
 	.may_wakeup = usbhid_may_wakeup,
 };
-EXPORT_SYMBOL_GPL(usb_hid_driver);
 
 bool hid_is_usb(const struct hid_device *hdev)
 {
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 7c5fce6a189e..170cad696541 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -856,7 +856,6 @@ struct hid_ll_driver {
 extern struct hid_ll_driver i2c_hid_ll_driver;
 extern struct hid_ll_driver hidp_hid_driver;
 extern struct hid_ll_driver uhid_hid_driver;
-extern struct hid_ll_driver usb_hid_driver;
 
 extern bool hid_is_usb(const struct hid_device *hdev);
 

-- 
2.39.0
