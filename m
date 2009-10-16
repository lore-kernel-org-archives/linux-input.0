From: Roel Kluin <roel.kluin@gmail.com>
Subject: [PATCH] hp_sdc_rtc: Fix test in hp_sdc_rtc_read_rt()
Date: Fri, 16 Oct 2009 18:12:39 +0200
Message-ID: <4AD89B77.6070303@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ew0-f208.google.com ([209.85.219.208]:48836 "EHLO
	mail-ew0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752463AbZJPQDj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 16 Oct 2009 12:03:39 -0400
Received: by ewy4 with SMTP id 4so1733807ewy.37
        for <linux-input@vger.kernel.org>; Fri, 16 Oct 2009 09:03:01 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Dmitry Torokhov <dtor@mail.ru>, linux-input@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

If left unsigned the hp_sdc_rtc_read_i8042timer() return value will not
be checked correctly.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
diff --git a/drivers/input/misc/hp_sdc_rtc.c b/drivers/input/misc/hp_sdc_rtc.c
index 216a559..ea821b5 100644
--- a/drivers/input/misc/hp_sdc_rtc.c
+++ b/drivers/input/misc/hp_sdc_rtc.c
@@ -209,7 +209,7 @@ static inline int hp_sdc_rtc_read_rt(struct timeval *res) {
 
 /* Read the i8042 fast handshake timer */
 static inline int hp_sdc_rtc_read_fhs(struct timeval *res) {
-	uint64_t raw;
+	int64_t raw;
 	unsigned int tenms;
 
 	raw = hp_sdc_rtc_read_i8042timer(HP_SDC_CMD_LOAD_FHS, 2);
