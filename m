Return-Path: <SRS0=3flh=3B=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB31DC33CA9
	for <linux-input@archiver.kernel.org>; Sun, 12 Jan 2020 23:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF81321556
	for <linux-input@archiver.kernel.org>; Sun, 12 Jan 2020 23:50:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387422AbgALXub (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Sun, 12 Jan 2020 18:50:31 -0500
Received: from orion.archlinux.org ([88.198.91.70]:59150 "EHLO
        orion.archlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727323AbgALXub (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 12 Jan 2020 18:50:31 -0500
Received: from orion.archlinux.org (localhost [127.0.0.1])
        by orion.archlinux.org (Postfix) with ESMTP id E4D6B18144FDB0;
        Sun, 12 Jan 2020 23:50:27 +0000 (UTC)
Received: from localhost.localdomain (unknown [IPv6:2001:8a0:f254:2300:dad6:8c60:8394:88da])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: ffy00)
        by orion.archlinux.org (Postfix) with ESMTPSA;
        Sun, 12 Jan 2020 23:50:27 +0000 (UTC)
From:   =?UTF-8?q?Filipe=20La=C3=ADns?= <lains@archlinux.org>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Filipe=20La=C3=ADns?= <lains@archlinux.org>
Subject: [PATCH v2] HID: logitech: drop outdated references to unifying receivers
Date:   Sun, 12 Jan 2020 23:50:09 +0000
Message-Id: <20200112235009.4074405-1-lains@archlinux.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

The hid-logitech-{dj,hidpp} were originally developed for unifying
receivers but since then they have evolved and now support other types
of receivers and devices. This patch adjusts the original descriptions
with this in mind.

Signed-off-by: Filipe Laíns <lains@archlinux.org>
---
 drivers/hid/Kconfig              | 6 +++---
 drivers/hid/hid-logitech-dj.c    | 4 ++--
 drivers/hid/hid-logitech-hidpp.c | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 494a39e74939..56f9f16220e3 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -531,14 +531,14 @@ config HID_LOGITECH
 	Support for Logitech devices that are not fully compliant with HID standard.
 
 config HID_LOGITECH_DJ
-	tristate "Logitech Unifying receivers full support"
+	tristate "Logitech receivers full support"
 	depends on USB_HID
 	depends on HIDRAW
 	depends on HID_LOGITECH
 	select HID_LOGITECH_HIDPP
 	---help---
-	Say Y if you want support for Logitech Unifying receivers and devices.
-	Unifying receivers are capable of pairing up to 6 Logitech compliant
+	Say Y if you want support for Logitech receivers and devices.
+	Logitech receivers are capable of pairing multiple Logitech compliant
 	devices to the same receiver. Without this driver it will be handled by
 	generic USB_HID driver and all incoming events will be multiplexed
 	into a single mouse and a single keyboard device.
diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
index 732380b55b15..cc7fc71d8b05 100644
--- a/drivers/hid/hid-logitech-dj.c
+++ b/drivers/hid/hid-logitech-dj.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- *  HID driver for Logitech Unifying receivers
+ *  HID driver for Logitech receivers
  *
  *  Copyright (c) 2011 Logitech
  */
@@ -701,7 +701,7 @@ static void logi_dj_recv_add_djhid_device(struct dj_receiver_dev *djrcv_dev,
 			type_str, dj_hiddev->product);
 	} else {
 		snprintf(dj_hiddev->name, sizeof(dj_hiddev->name),
-			"Logitech Unifying Device. Wireless PID:%04x",
+			"Logitech Wireless Device PID:%04x",
 			dj_hiddev->product);
 	}
 
diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 39a5ee0aaab0..c04018f8a727 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- *  HIDPP protocol for Logitech Unifying receivers
+ *  HIDPP protocol for Logitech receivers
  *
  *  Copyright (c) 2011 Logitech (c)
  *  Copyright (c) 2012-2013 Google (c)
-- 
2.24.1
