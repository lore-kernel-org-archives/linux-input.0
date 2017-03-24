From: Roderick Colenbrander <roderick@gaikai.com>
Subject: [PATCH 3/6] HID: sony: DS4 use brighter LED colors
Date: Fri, 24 Mar 2017 15:17:47 -0700
Message-ID: <20170324221750.19543-4-roderick@gaikai.com>
References: <20170324221750.19543-1-roderick@gaikai.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-it0-f51.google.com ([209.85.214.51]:33893 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754936AbdCXWR7 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 24 Mar 2017 18:17:59 -0400
Received: by mail-it0-f51.google.com with SMTP id y18so8236750itc.1
        for <linux-input@vger.kernel.org>; Fri, 24 Mar 2017 15:17:58 -0700 (PDT)
In-Reply-To: <20170324221750.19543-1-roderick@gaikai.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Simon Wood <simon@mungewell.org>, Frank Praznik <frank.praznik@gmail.com>, Tim Bird <tim.bird@am.sony.com>, Roderick Colenbrander <roderick.colenbrander@sony.com>

From: Roderick Colenbrander <roderick.colenbrander@sony.com>

These colors are more the default colors normally used on the DS4.
The previous ones were faint and not so noticeable.

Signed-off-by: Roderick Colenbrander <roderick.colenbrander@sony.com>
---
 drivers/hid/hid-sony.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 55b25d7..1149757 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -1628,10 +1628,10 @@ static void dualshock4_set_leds_from_id(struct sony_sc *sc)
 {
 	/* The first 4 color/index entries match what the PS4 assigns */
 	static const u8 color_code[7][3] = {
-			/* Blue   */	{ 0x00, 0x00, 0x01 },
-			/* Red	  */	{ 0x01, 0x00, 0x00 },
-			/* Green  */	{ 0x00, 0x01, 0x00 },
-			/* Pink   */	{ 0x02, 0x00, 0x01 },
+			/* Blue   */	{ 0x00, 0x00, 0x40 },
+			/* Red	  */	{ 0x40, 0x00, 0x00 },
+			/* Green  */	{ 0x00, 0x40, 0x00 },
+			/* Pink   */	{ 0x20, 0x00, 0x20 },
 			/* Orange */	{ 0x02, 0x01, 0x00 },
 			/* Teal   */	{ 0x00, 0x01, 0x01 },
 			/* White  */	{ 0x01, 0x01, 0x01 }
-- 
2.9.3

