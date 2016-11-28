From: Aniroop Mathur <a.mathur@samsung.com>
Subject: [PATCH] Input: joystick: sidewinder - change msleep to usleep_range for small msecs
Date: Tue, 29 Nov 2016 01:08:22 +0530
Message-ID: <1480361902-4671-1-git-send-email-a.mathur@samsung.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35183 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754600AbcK1T2z (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 28 Nov 2016 14:28:55 -0500
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
On a machine with tick rate / HZ as 100, msleep(6) will make the process to
sleep for a minimum period of 10 ms whereas usleep_range(6000, 6100) will make
sure that the process does not sleep for more than 6100 us or 6.1ms

Signed-off-by: Aniroop Mathur <a.mathur@samsung.com>
---
 drivers/input/joystick/sidewinder.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/input/joystick/sidewinder.c b/drivers/input/joystick/sidewinder.c
index 4a95b22..e5a1292 100644
--- a/drivers/input/joystick/sidewinder.c
+++ b/drivers/input/joystick/sidewinder.c
@@ -50,7 +50,7 @@ MODULE_LICENSE("GPL");
 
 #define SW_START	600	/* The time we wait for the first bit [600 us] */
 #define SW_STROBE	60	/* Max time per bit [60 us] */
-#define SW_TIMEOUT	6	/* Wait for everything to settle [6 ms] */
+#define SW_TIMEOUT	6000	/* Wait for everything to settle [6000 us] */
 #define SW_KICK		45	/* Wait after A0 fall till kick [45 us] */
 #define SW_END		8	/* Number of bits before end of packet to kick */
 #define SW_FAIL		16	/* Number of packet read errors to fail and reinitialize */
@@ -139,7 +139,7 @@ static int sw_read_packet(struct gameport *gameport, unsigned char *buf, int len
 	unsigned char pending, u, v;
 
 	i = -id;						/* Don't care about data, only want ID */
-	timeout = id ? gameport_time(gameport, SW_TIMEOUT * 1000) : 0; /* Set up global timeout for ID packet */
+	timeout = id ? gameport_time(gameport, SW_TIMEOUT) : 0; /* Set up global timeout for ID packet */
 	kick = id ? gameport_time(gameport, SW_KICK) : 0;	/* Set up kick timeout for ID packet */
 	start = gameport_time(gameport, SW_START);
 	strobe = gameport_time(gameport, SW_STROBE);
@@ -248,7 +248,7 @@ static void sw_init_digital(struct gameport *gameport)
 	i = 0;
         do {
                 gameport_trigger(gameport);			/* Trigger */
-		t = gameport_time(gameport, SW_TIMEOUT * 1000);
+		t = gameport_time(gameport, SW_TIMEOUT);
 		while ((gameport_read(gameport) & 1) && t) t--;	/* Wait for axis to fall back to 0 */
                 udelay(seq[i]);					/* Delay magic time */
         } while (seq[++i]);
@@ -483,13 +483,13 @@ static int sw_read(struct sw *sw)
 		" - reinitializing joystick.\n", sw->gameport->phys);
 
 	if (!i && sw->type == SW_ID_3DP) {					/* 3D Pro can be in analog mode */
-		mdelay(3 * SW_TIMEOUT);
+		mdelay(3 * (SW_TIMEOUT / 1000));
 		sw_init_digital(sw->gameport);
 	}
 
-	mdelay(SW_TIMEOUT);
+	mdelay(SW_TIMEOUT / 1000);
 	i = sw_read_packet(sw->gameport, buf, SW_LENGTH, 0);			/* Read normal data packet */
-	mdelay(SW_TIMEOUT);
+	mdelay(SW_TIMEOUT / 1000);
 	sw_read_packet(sw->gameport, buf, SW_LENGTH, i);			/* Read ID packet, this initializes the stick */
 
 	sw->fail = SW_FAIL;
@@ -616,14 +616,14 @@ static int sw_connect(struct gameport *gameport, struct gameport_driver *drv)
 		gameport->phys, gameport->io, gameport->speed);
 
 	i = sw_read_packet(gameport, buf, SW_LENGTH, 0);		/* Read normal packet */
-	msleep(SW_TIMEOUT);
+	usleep_range(SW_TIMEOUT, SW_TIMEOUT + 100);
 	dbg("Init 1: Mode %d. Length %d.", m , i);
 
 	if (!i) {							/* No data. 3d Pro analog mode? */
 		sw_init_digital(gameport);				/* Switch to digital */
-		msleep(SW_TIMEOUT);
+		usleep_range(SW_TIMEOUT, SW_TIMEOUT + 100);
 		i = sw_read_packet(gameport, buf, SW_LENGTH, 0);	/* Retry reading packet */
-		msleep(SW_TIMEOUT);
+		usleep_range(SW_TIMEOUT, SW_TIMEOUT + 100);
 		dbg("Init 1b: Length %d.", i);
 		if (!i) {						/* No data -> FAIL */
 			err = -ENODEV;
@@ -636,7 +636,7 @@ static int sw_connect(struct gameport *gameport, struct gameport_driver *drv)
 	dbg("Init 2: Mode %d. ID Length %d.", m, j);
 
 	if (j <= 0) {							/* Read ID failed. Happens in 1-bit mode on PP */
-		msleep(SW_TIMEOUT);
+		usleep_range(SW_TIMEOUT, SW_TIMEOUT + 100);
 		i = sw_read_packet(gameport, buf, SW_LENGTH, 0);	/* Retry reading packet */
 		m |= sw_guess_mode(buf, i);
 		dbg("Init 2b: Mode %d. Length %d.", m, i);
@@ -644,7 +644,7 @@ static int sw_connect(struct gameport *gameport, struct gameport_driver *drv)
 			err = -ENODEV;
 			goto fail2;
 		}
-		msleep(SW_TIMEOUT);
+		usleep_range(SW_TIMEOUT, SW_TIMEOUT + 100);
 		j = sw_read_packet(gameport, idbuf, SW_LENGTH, i);	/* Retry reading ID */
 		dbg("Init 2c: ID Length %d.", j);
 	}
@@ -655,7 +655,7 @@ static int sw_connect(struct gameport *gameport, struct gameport_driver *drv)
 
 	do {
 		k--;
-		msleep(SW_TIMEOUT);
+		usleep_range(SW_TIMEOUT, SW_TIMEOUT + 100);
 		i = sw_read_packet(gameport, buf, SW_LENGTH, 0);	/* Read data packet */
 		dbg("Init 3: Mode %d. Length %d. Last %d. Tries %d.", m, i, l, k);
 
-- 
2.6.2

