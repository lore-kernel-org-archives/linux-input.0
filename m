From: Frank Praznik <frank.praznik@gmail.com>
Subject: [PATCH 3/3] hid: sony: Update copyright and add Dualshock 4 rate control note
Date: Thu, 22 Sep 2016 20:18:10 -0400
Message-ID: <1474589890-7141-4-git-send-email-frank.praznik@gmail.com>
References: <1474589890-7141-1-git-send-email-frank.praznik@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:33233 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933536AbcIWASj (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 22 Sep 2016 20:18:39 -0400
Received: by mail-qk0-f193.google.com with SMTP id n66so6240516qkf.0
        for <linux-input@vger.kernel.org>; Thu, 22 Sep 2016 17:18:38 -0700 (PDT)
In-Reply-To: <1474589890-7141-1-git-send-email-frank.praznik@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jikos@kernel.org, benjamin.tissoires@redhat.com, Frank Praznik <frank.praznik@gmail.com>

Update the copyright notice with the current year and add a note
about values for controlling the Dualshock 4 reporting rate.

Processing reports at the default full rate of 1000hz can be too
demanding for some low-power embedded processors so noting
alternate values for people working with this hardware can be useful.

Thanks to Rostislav Pehlivanov for finding these values.

Signed-off-by: Frank Praznik <frank.praznik@gmail.com>
---
 drivers/hid/hid-sony.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 9b96f95..9bf4e36 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -8,7 +8,7 @@
  *  Copyright (c) 2012 David Dillow <dave@thedillows.org>
  *  Copyright (c) 2006-2013 Jiri Kosina
  *  Copyright (c) 2013 Colin Leitner <colin.leitner@gmail.com>
- *  Copyright (c) 2014 Frank Praznik <frank.praznik@gmail.com>
+ *  Copyright (c) 2014-2016 Frank Praznik <frank.praznik@gmail.com>
  */
 
 /*
@@ -1879,6 +1879,17 @@ static void dualshock4_send_output_report(struct sony_sc *sc)
 	u8 *buf = sc->output_report_dmabuf;
 	int offset;
 
+	/*
+	 * NOTE: The buf[1] field of the Bluetooth report controls
+	 * the Dualshock 4 reporting rate.
+	 *
+	 * Known values include:
+	 *
+	 * 0x80 - 1000hz (full speed)
+	 * 0xA0 - 31hz
+	 * 0xB0 - 20hz
+	 * 0xD0 - 66hz
+	 */
 	if (sc->quirks & DUALSHOCK4_CONTROLLER_USB) {
 		memset(buf, 0, DS4_REPORT_0x05_SIZE);
 		buf[0] = 0x05;
-- 
2.7.4

