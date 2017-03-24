From: Roderick Colenbrander <roderick@gaikai.com>
Subject: [PATCH 4/6] HID: sony: Set proper bit flags on DS4 output report
Date: Fri, 24 Mar 2017 15:17:48 -0700
Message-ID: <20170324221750.19543-5-roderick@gaikai.com>
References: <20170324221750.19543-1-roderick@gaikai.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-it0-f47.google.com ([209.85.214.47]:36231 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754936AbdCXWSB (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 24 Mar 2017 18:18:01 -0400
Received: by mail-it0-f47.google.com with SMTP id w124so22701102itb.1
        for <linux-input@vger.kernel.org>; Fri, 24 Mar 2017 15:18:00 -0700 (PDT)
In-Reply-To: <20170324221750.19543-1-roderick@gaikai.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Simon Wood <simon@mungewell.org>, Frank Praznik <frank.praznik@gmail.com>, Tim Bird <tim.bird@am.sony.com>, Roderick Colenbrander <roderick.colenbrander@sony.com>

From: Roderick Colenbrander <roderick.colenbrander@sony.com>

Only set bit flags for the portions of the DS4 output report
for which we have data.

Signed-off-by: Roderick Colenbrander <roderick.colenbrander@sony.com>
---
 drivers/hid/hid-sony.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 1149757..2429c0e 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -1998,13 +1998,13 @@ static void dualshock4_send_output_report(struct sony_sc *sc)
 	if (sc->quirks & (DUALSHOCK4_CONTROLLER_USB | DUALSHOCK4_DONGLE)) {
 		memset(buf, 0, DS4_OUTPUT_REPORT_0x05_SIZE);
 		buf[0] = 0x05;
-		buf[1] = 0xFF;
+		buf[1] = 0x07; /* blink + LEDs + motor */
 		offset = 4;
 	} else {
 		memset(buf, 0, DS4_OUTPUT_REPORT_0x11_SIZE);
 		buf[0] = 0x11;
 		buf[1] = 0xC0; /* HID + CRC */
-		buf[3] = 0x0F;
+		buf[3] = 0x07; /* blink + LEDs + motor */
 		offset = 6;
 	}
 
-- 
2.9.3

