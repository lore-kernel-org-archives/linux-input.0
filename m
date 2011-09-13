From: Christian Gmeiner <christian.gmeiner@gmail.com>
Subject: [PATCH 3/3] TSC-40: Improve EEPROM error handling
Date: Tue, 13 Sep 2011 10:18:41 +0200
Message-ID: <CAH9NwWcH3LyQ4D3eEXKRF78EC5eCt4C_N956L6oEHEjhujybow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yi0-f46.google.com ([209.85.218.46]:40204 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753596Ab1IMI0o (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 13 Sep 2011 04:26:44 -0400
Received: by yie30 with SMTP id 30so238603yie.19
        for <linux-input@vger.kernel.org>; Tue, 13 Sep 2011 01:26:44 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: bigeasy@linutronix.de

>From 30b11594207afd8a3075d3115678cd7013d380d8 Mon Sep 17 00:00:00 2001
From: Christian Gmeiner <christian.gmeiner@gmail.com>
Date: Wed, 7 Sep 2011 14:29:10 +0200
Subject: [PATCH 3/3] TSC40: Improve EEPROM error handling

It could happen that the internal EEPROM does not contain any
calibration data and as a result of this the driver will fail.
With this patch we simply ignore an empty EEPROM, as the touch
controller runs in 'Coordinate data mode' (raw data).

Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
---
drivers/input/touchscreen/tsc40.c |   21 +++++++++++++++++----
1 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/input/touchscreen/tsc40.c
b/drivers/input/touchscreen/tsc40.c
index b73ef2f..d914522 100644
--- a/drivers/input/touchscreen/tsc40.c
+++ b/drivers/input/touchscreen/tsc40.c
@@ -49,7 +49,6 @@ struct tsc_ser {

 #define RESPONSE_ACK   0x06
#define RESPONSE_NAK    0x15
-#define NACK_DETAIL_NT (1 << 3)

 #define ID_EPROM_UNUSED        (1 << 7)

@@ -96,11 +95,25 @@ static void handle_reset(struct serio *serio,
unsigned char data)

       /* NAK + EEPROM available */
       if (ptsc->idx == 1) {
-               if (!(data & NACK_DETAIL_NT)) {
+               if (data & (1 << 0)) {
+                       dev_warn(&serio->dev, "EEPROM data empty\n");
+                       state_after_reset(ptsc, 1);
+                       return;
+               } else if (data & (1 << 1)) {
+                       dev_warn(&serio->dev, "EEPROM data abnormal\n");
                       state_after_reset(ptsc, 0);
                       return;
-               }
-               state_after_reset(ptsc, 0);
+               } else if (data & (1 << 2)) {
+                       dev_warn(&serio->dev, "EEPROM write error\n");
+                       state_after_reset(ptsc, 0);
+                       return;
+               } else if (data & (1 << 3)) {
+                       dev_warn(&serio->dev, "Touch screen not connected\n");
+                       state_after_reset(ptsc, 0);
+                       return;
+               } else
+                       BUG_ON(1);
+
               return;
       }

--
1.7.4.1
