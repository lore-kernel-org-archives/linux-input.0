From: Roderick Colenbrander <roderick@gaikai.com>
Subject: [PATCH 1/6] HID: sony: Use DS3 MAC address as unique identifier on USB
Date: Fri, 24 Mar 2017 15:17:45 -0700
Message-ID: <20170324221750.19543-2-roderick@gaikai.com>
References: <20170324221750.19543-1-roderick@gaikai.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-it0-f47.google.com ([209.85.214.47]:38768 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754916AbdCXWR5 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 24 Mar 2017 18:17:57 -0400
Received: by mail-it0-f47.google.com with SMTP id y18so3847442itc.1
        for <linux-input@vger.kernel.org>; Fri, 24 Mar 2017 15:17:56 -0700 (PDT)
In-Reply-To: <20170324221750.19543-1-roderick@gaikai.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Simon Wood <simon@mungewell.org>, Frank Praznik <frank.praznik@gmail.com>, Tim Bird <tim.bird@am.sony.com>, Roderick Colenbrander <roderick.colenbrander@sony.com>

From: Roderick Colenbrander <roderick.colenbrander@sony.com>

The DS3 MAC address is reported as a unique identified when
using Bluetooth. For USB there is no unique identifier reported
yet, so use the MAC address.

Signed-off-by: Roderick Colenbrander <roderick.colenbrander@sony.com>
---
 drivers/hid/hid-sony.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index bb124e3..2e14788 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -2400,6 +2400,12 @@ static int sony_check_add(struct sony_sc *sc)
 		 */
 		for (n = 0; n < 6; n++)
 			sc->mac_address[5-n] = buf[4+n];
+
+		snprintf(sc->hdev->uniq, sizeof(sc->hdev->uniq),
+			"%02hhx:%02hhx:%02hhx:%02hhx:%02hhx:%02hhx",
+			sc->mac_address[5], sc->mac_address[4],
+			sc->mac_address[3], sc->mac_address[2],
+			sc->mac_address[1], sc->mac_address[0]);
 	} else {
 		return 0;
 	}
-- 
2.9.3

