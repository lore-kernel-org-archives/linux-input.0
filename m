From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] Input: omap-keypad - remove adjusting of scan delay
Date: Thu, 7 Jan 2016 22:41:14 -0800
Message-ID: <20160108064114.GA30877@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175]:36792 "EHLO
	mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750702AbcAHGlR (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 8 Jan 2016 01:41:17 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@nokia.com>, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, linux-kernel@vger.kernel.org

As of 35f8679f577ae5673a778598bcbe7b45cbec8923 ("Input: omap-keypad -
remove dead check") we no longer declare keypresses as spurious, therefore
we can use constant delay between scans.

Suggested-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/keyboard/omap-keypad.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/input/keyboard/omap-keypad.c b/drivers/input/keyboard/omap-keypad.c
index e0d72c8..d115acf 100644
--- a/drivers/input/keyboard/omap-keypad.c
+++ b/drivers/input/keyboard/omap-keypad.c
@@ -133,7 +133,6 @@ static void omap_kp_tasklet(unsigned long data)
 	unsigned int row_shift = get_count_order(omap_kp_data->cols);
 	unsigned char new_state[8], changed, key_down = 0;
 	int col, row;
-	int spurious = 0;
 
 	/* check for any changes */
 	omap_kp_scan_keypad(omap_kp_data, new_state);
@@ -170,12 +169,9 @@ static void omap_kp_tasklet(unsigned long data)
 	memcpy(keypad_state, new_state, sizeof(keypad_state));
 
 	if (key_down) {
-		int delay = HZ / 20;
 		/* some key is pressed - keep irq disabled and use timer
 		 * to poll the keypad */
-		if (spurious)
-			delay = 2 * HZ;
-		mod_timer(&omap_kp_data->timer, jiffies + delay);
+		mod_timer(&omap_kp_data->timer, jiffies + HZ / 20);
 	} else {
 		/* enable interrupts */
 		omap_writew(0, OMAP1_MPUIO_BASE + OMAP_MPUIO_KBD_MASKIT);
-- 
2.6.0.rc2.230.g3dd15c0


-- 
Dmitry
