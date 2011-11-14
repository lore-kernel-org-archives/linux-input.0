From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4/6] Input: ucb1400_ts - drop inline annotations
Date: Mon, 14 Nov 2011 00:36:09 -0800
Message-ID: <1321259771-10925-4-git-send-email-dmitry.torokhov@gmail.com>
References: <1321259771-10925-1-git-send-email-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:41283 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753390Ab1KNIgT (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Nov 2011 03:36:19 -0500
Received: by gyc15 with SMTP id 15so4644489gyc.19
        for <linux-input@vger.kernel.org>; Mon, 14 Nov 2011 00:36:18 -0800 (PST)
In-Reply-To: <1321259771-10925-1-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Marek Vasut <marek.vasut@gmail.com>

Let compiler figure out which ones makes most sense to inline.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---
 drivers/input/touchscreen/ucb1400_ts.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/input/touchscreen/ucb1400_ts.c b/drivers/input/touchscreen/ucb1400_ts.c
index db525ac..5c6b7b3 100644
--- a/drivers/input/touchscreen/ucb1400_ts.c
+++ b/drivers/input/touchscreen/ucb1400_ts.c
@@ -35,7 +35,7 @@ static int ts_delay = 55; /* us */
 static int ts_delay_pressure;	/* us */
 
 /* Switch to interrupt mode. */
-static inline void ucb1400_ts_mode_int(struct snd_ac97 *ac97)
+static void ucb1400_ts_mode_int(struct snd_ac97 *ac97)
 {
 	ucb1400_reg_write(ac97, UCB_TS_CR,
 			UCB_TS_CR_TSMX_POW | UCB_TS_CR_TSPX_POW |
@@ -47,7 +47,7 @@ static inline void ucb1400_ts_mode_int(struct snd_ac97 *ac97)
  * Switch to pressure mode, and read pressure.  We don't need to wait
  * here, since both plates are being driven.
  */
-static inline unsigned int ucb1400_ts_read_pressure(struct ucb1400_ts *ucb)
+static unsigned int ucb1400_ts_read_pressure(struct ucb1400_ts *ucb)
 {
 	ucb1400_reg_write(ucb->ac97, UCB_TS_CR,
 			UCB_TS_CR_TSMX_POW | UCB_TS_CR_TSPX_POW |
@@ -63,7 +63,7 @@ static inline unsigned int ucb1400_ts_read_pressure(struct ucb1400_ts *ucb)
  * gives a faster response time.  Even so, we need to wait about 55us
  * for things to stabilise.
  */
-static inline unsigned int ucb1400_ts_read_xpos(struct ucb1400_ts *ucb)
+static unsigned int ucb1400_ts_read_xpos(struct ucb1400_ts *ucb)
 {
 	ucb1400_reg_write(ucb->ac97, UCB_TS_CR,
 			UCB_TS_CR_TSMX_GND | UCB_TS_CR_TSPX_POW |
@@ -86,7 +86,7 @@ static inline unsigned int ucb1400_ts_read_xpos(struct ucb1400_ts *ucb)
  * gives a faster response time.  Even so, we need to wait about 55us
  * for things to stabilise.
  */
-static inline unsigned int ucb1400_ts_read_ypos(struct ucb1400_ts *ucb)
+static int ucb1400_ts_read_ypos(struct ucb1400_ts *ucb)
 {
 	ucb1400_reg_write(ucb->ac97, UCB_TS_CR,
 			UCB_TS_CR_TSMY_GND | UCB_TS_CR_TSPY_POW |
@@ -107,7 +107,7 @@ static inline unsigned int ucb1400_ts_read_ypos(struct ucb1400_ts *ucb)
  * Switch to X plate resistance mode.  Set MX to ground, PX to
  * supply.  Measure current.
  */
-static inline unsigned int ucb1400_ts_read_xres(struct ucb1400_ts *ucb)
+static unsigned int ucb1400_ts_read_xres(struct ucb1400_ts *ucb)
 {
 	ucb1400_reg_write(ucb->ac97, UCB_TS_CR,
 			UCB_TS_CR_TSMX_GND | UCB_TS_CR_TSPX_POW |
@@ -119,7 +119,7 @@ static inline unsigned int ucb1400_ts_read_xres(struct ucb1400_ts *ucb)
  * Switch to Y plate resistance mode.  Set MY to ground, PY to
  * supply.  Measure current.
  */
-static inline unsigned int ucb1400_ts_read_yres(struct ucb1400_ts *ucb)
+static unsigned int ucb1400_ts_read_yres(struct ucb1400_ts *ucb)
 {
 	ucb1400_reg_write(ucb->ac97, UCB_TS_CR,
 			UCB_TS_CR_TSMY_GND | UCB_TS_CR_TSPY_POW |
@@ -127,21 +127,21 @@ static inline unsigned int ucb1400_ts_read_yres(struct ucb1400_ts *ucb)
 	return ucb1400_adc_read(ucb->ac97, 0, adcsync);
 }
 
-static inline int ucb1400_ts_pen_up(struct snd_ac97 *ac97)
+static int ucb1400_ts_pen_up(struct snd_ac97 *ac97)
 {
 	unsigned short val = ucb1400_reg_read(ac97, UCB_TS_CR);
 
 	return val & (UCB_TS_CR_TSPX_LOW | UCB_TS_CR_TSMX_LOW);
 }
 
-static inline void ucb1400_ts_irq_enable(struct snd_ac97 *ac97)
+static void ucb1400_ts_irq_enable(struct snd_ac97 *ac97)
 {
 	ucb1400_reg_write(ac97, UCB_IE_CLEAR, UCB_IE_TSPX);
 	ucb1400_reg_write(ac97, UCB_IE_CLEAR, 0);
 	ucb1400_reg_write(ac97, UCB_IE_FAL, UCB_IE_TSPX);
 }
 
-static inline void ucb1400_ts_irq_disable(struct snd_ac97 *ac97)
+static void ucb1400_ts_irq_disable(struct snd_ac97 *ac97)
 {
 	ucb1400_reg_write(ac97, UCB_IE_FAL, 0);
 }
-- 
1.7.6.4

