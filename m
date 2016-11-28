From: Aniroop Mathur <a.mathur@samsung.com>
Subject: [PATCH] Input: joystick: gf2k - change msleep to usleep_range for small msecs
Date: Tue, 29 Nov 2016 01:11:49 +0530
Message-ID: <1480362109-4818-1-git-send-email-a.mathur@samsung.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33932 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754911AbcK1TcQ (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 28 Nov 2016 14:32:16 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: vojtech@ucw.cz, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: s.samuel@samsung.com, r.mahale@samsung.com, aniroop.mathur@gmail.com, Aniroop Mathur <a.mathur@samsung.com>

msleep(1~20) may not do what the caller intends, and will often sleep longer.
(~20 ms actual sleep for any value given in the 1~20ms range)
This is not the desired behaviour for many cases like device resume time,
device suspend time, device enable time, connection time, probe time,
loops, retry logic, etc
msleep is built on jiffies / legacy timers which are not precise whereas
usleep_range is build on top of hrtimers so the wakeups are precise.
Thus, change msleep to usleep_range for precise wakeups.

For example:
On a machine with tick rate / HZ as 100, msleep(4) will make the process to
sleep for a minimum period of 10 ms whereas usleep_range(4000, 4100) will make
sure that the process does not sleep for more than 4100 us or 4.1ms

Signed-off-by: Aniroop Mathur <a.mathur@samsung.com>
---
 drivers/input/joystick/gf2k.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/input/joystick/gf2k.c b/drivers/input/joystick/gf2k.c
index 0f519db..e9d5095 100644
--- a/drivers/input/joystick/gf2k.c
+++ b/drivers/input/joystick/gf2k.c
@@ -42,7 +42,7 @@ MODULE_LICENSE("GPL");
 
 #define GF2K_START		400	/* The time we wait for the first bit [400 us] */
 #define GF2K_STROBE		40	/* The time we wait for the first bit [40 us] */
-#define GF2K_TIMEOUT		4	/* Wait for everything to settle [4 ms] */
+#define GF2K_TIMEOUT		4000	/* Wait for everything to settle [4000 us] */
 #define GF2K_LENGTH		80	/* Max number of triplets in a packet */
 
 /*
@@ -138,7 +138,7 @@ static void gf2k_trigger_seq(struct gameport *gameport, short *seq)
 	i = 0;
         do {
 		gameport_trigger(gameport);
-		t = gameport_time(gameport, GF2K_TIMEOUT * 1000);
+		t = gameport_time(gameport, GF2K_TIMEOUT);
 		while ((gameport_read(gameport) & 1) && t) t--;
                 udelay(seq[i]);
         } while (seq[++i]);
@@ -259,11 +259,11 @@ static int gf2k_connect(struct gameport *gameport, struct gameport_driver *drv)
 
 	gf2k_trigger_seq(gameport, gf2k_seq_reset);
 
-	msleep(GF2K_TIMEOUT);
+	usleep_range(GF2K_TIMEOUT, GF2K_TIMEOUT + 100);
 
 	gf2k_trigger_seq(gameport, gf2k_seq_digital);
 
-	msleep(GF2K_TIMEOUT);
+	usleep_range(GF2K_TIMEOUT, GF2K_TIMEOUT + 100);
 
 	if (gf2k_read_packet(gameport, GF2K_LENGTH, data) < 12) {
 		err = -ENODEV;
-- 
2.6.2

