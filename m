From: Christoph Fritz <chf.fritz@googlemail.com>
Subject: Re: adp5588-keys datasheet and driver question
Date: Sun, 04 Dec 2011 12:39:40 +0100
Message-ID: <1322998781.3023.17.camel@mars>
References: <1322928007.11453.32.camel@mars>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:33192 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753262Ab1LDLjp (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 4 Dec 2011 06:39:45 -0500
Received: by wgbds13 with SMTP id ds13so4623337wgb.1
        for <linux-input@vger.kernel.org>; Sun, 04 Dec 2011 03:39:44 -0800 (PST)
In-Reply-To: <1322928007.11453.32.camel@mars>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michael Hennerich <michael.hennerich@analog.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, device-drivers-devel@blackfin.uclinux.org, linux-input@vger.kernel.org


forgot to add to commit:
-	unsigned short keycode[ADP5588_KEYMAPSIZE];
+	unsigned short keycode[ADP5588_KEYMAPSIZE + 1];

On Sat, 2011-12-03 at 17:00 +0100, Christoph Fritz wrote:
> Hi Michael,
> 
>  I had a look at the adp5588-keys driver and its datasheet.
> 
> There are some "slips of the pen" in it (adp5588 Rev.b):
>   - Page 8, Table 12, "E4 pressed" refers to binary 1000 instead of 100
>   - Page 17, Table 22, Register Descriptions are mostly wrong
> 
> Another thing I'm curious about is in adp5588_report_events():
> 
> int key = adp5588_read(kpad->client, Key_EVENTA + i);
> int key_val = key & KEY_EV_MASK;
> [...]
> input_report_key(kpad->input, kpad->keycode[key_val - 1], key & KEY_EV_PRESSED);
> 
> Why is there a -1 for key_val?
> 
> Due to lack of hardware and understanding the datasheet, I'm unsure
> about my patch below.
> 
> Thanks,
>    Christoph
> 
---
Subject: [PATCH] Input: adp5588-keys - fix handling of Key A0

This patch removes a -1 subtraction from the device its transmitted key
event register.  This allows correct handling of Key A0 which reports 0.
---
 drivers/input/keyboard/adp5588-keys.c |   12 ++++++------
 include/linux/i2c/adp5588.h           |    1 +
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/input/keyboard/adp5588-keys.c b/drivers/input/keyboard/adp5588-keys.c
index 4a7f534..c0f0276 100644
--- a/drivers/input/keyboard/adp5588-keys.c
+++ b/drivers/input/keyboard/adp5588-keys.c
@@ -43,7 +43,7 @@ struct adp5588_kpad {
 	struct input_dev *input;
 	struct delayed_work work;
 	unsigned long delay;
-	unsigned short keycode[ADP5588_KEYMAPSIZE];
+	unsigned short keycode[ADP5588_KEYMAPSIZE + 1];
 	const struct adp5588_gpi_map *gpimap;
 	unsigned short gpimapsize;
 #ifdef CONFIG_GPIOLIB
@@ -261,8 +261,8 @@ static void adp5588_report_events(struct adp5588_kpad *kpad, int ev_cnt)
 	int i, j;
 
 	for (i = 0; i < ev_cnt; i++) {
-		int key = adp5588_read(kpad->client, Key_EVENTA + i);
-		int key_val = key & KEY_EV_MASK;
+		unsigned int key = adp5588_read(kpad->client, Key_EVENTA + i);
+		unsigned int key_val = key & KEY_EV_MASK;
 
 		if (key_val >= GPI_PIN_BASE && key_val <= GPI_PIN_END) {
 			for (j = 0; j < kpad->gpimapsize; j++) {
@@ -273,9 +273,9 @@ static void adp5588_report_events(struct adp5588_kpad *kpad, int ev_cnt)
 					break;
 				}
 			}
-		} else {
+		} else if (key_val <= ADP5588_KEYMAPSIZE) {
 			input_report_key(kpad->input,
-					 kpad->keycode[key_val - 1],
+					 kpad->keycode[key_val],
 					 key & KEY_EV_PRESSED);
 		}
 	}
@@ -295,7 +295,7 @@ static void adp5588_work(struct work_struct *work)
 
 	if (status & ADP5588_KE_INT) {
 		ev_cnt = adp5588_read(client, KEY_LCK_EC_STAT) & ADP5588_KEC;
-		if (ev_cnt) {
+		if (ev_cnt && ev_cnt <= ADP5588_MAXEVENTS) {
 			adp5588_report_events(kpad, ev_cnt);
 			input_sync(kpad->input);
 		}
diff --git a/include/linux/i2c/adp5588.h b/include/linux/i2c/adp5588.h
index cec17cf..394c07f 100644
--- a/include/linux/i2c/adp5588.h
+++ b/include/linux/i2c/adp5588.h
@@ -103,6 +103,7 @@
 
 /* Put one of these structures in i2c_board_info platform_data */
 
+#define ADP5588_MAXEVENTS	10
 #define ADP5588_KEYMAPSIZE	80
 
 #define GPI_PIN_ROW0 97
-- 
1.7.2.5



