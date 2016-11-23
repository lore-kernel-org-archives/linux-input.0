From: Roderick Colenbrander <roderick@gaikai.com>
Subject: [PATCH 5/8] HID: sony: Use DS4 MAC address as unique identifier on USB
Date: Wed, 23 Nov 2016 14:07:10 -0800
Message-ID: <1479938833-26424-6-git-send-email-roderick@gaikai.com>
References: <1479938833-26424-1-git-send-email-roderick@gaikai.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f175.google.com ([209.85.161.175]:36817 "EHLO
        mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934049AbcKWWIQ (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 23 Nov 2016 17:08:16 -0500
Received: by mail-yw0-f175.google.com with SMTP id a10so23615946ywa.3
        for <linux-input@vger.kernel.org>; Wed, 23 Nov 2016 14:08:15 -0800 (PST)
In-Reply-To: <1479938833-26424-1-git-send-email-roderick@gaikai.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Simon Wood <simon@mungewell.org>, Frank Praznik <frank.praznik@gmail.com>, Tim Bird <tim.bird@am.sony.com>, Roderick Colenbrander <roderick.colenbrander@sony.com>

From: Roderick Colenbrander <roderick.colenbrander@sony.com>

The DS4 MAC address is reported as a unique identified when
using Bluetooth. For USB there is no unique identifier reported
yet, so use the MAC address.

Signed-off-by: Roderick Colenbrander <roderick.colenbrander@sony.com>
---
 drivers/hid/hid-sony.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index c391907..ea5b045 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -2190,6 +2190,12 @@ static int sony_check_add(struct sony_sc *sc)
 		}
 
 		memcpy(sc->mac_address, &buf[1], sizeof(sc->mac_address));
+
+		snprintf(sc->hdev->uniq, sizeof(sc->hdev->uniq),
+			"%02hhx:%02hhx:%02hhx:%02hhx:%02hhx:%02hhx",
+			sc->mac_address[5], sc->mac_address[4],
+			sc->mac_address[3], sc->mac_address[2],
+			sc->mac_address[1], sc->mac_address[0]);
 	} else if ((sc->quirks & SIXAXIS_CONTROLLER_USB) ||
 			(sc->quirks & NAVIGATION_CONTROLLER_USB)) {
 		buf = kmalloc(SIXAXIS_REPORT_0xF2_SIZE, GFP_KERNEL);
-- 
2.7.4

