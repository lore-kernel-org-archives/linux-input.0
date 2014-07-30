From: Frank Praznik <frank.praznik@oh.rr.com>
Subject: [PATCH] hid: sony: Default initialize all elements of the LED max_brightness array to 1.
Date: Tue, 29 Jul 2014 19:55:48 -0700
Message-ID: <1406688948-33348-1-git-send-email-frank.praznik@oh.rr.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.225]:35527 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751895AbaG3C5Y (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 29 Jul 2014 22:57:24 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, Frank Praznik <frank.praznik@oh.rr.com>

Previously only the first element of the array was initialized to 1
leading to potential incorrect max brightness values for the LEDs
on the Dualshock 3 and buzzer controllers.

Use a designated initializer to initialize the whole array to the
correct value.

Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>
---

This patch is against jikos/hid.git/for-3.16/upstream-fixes
It applies cleanly against for-3.17/sony as well

This error never created any noticeable effects since the max value was
set to LED_FULL by the led initialization code if it was 0 and it was
clamped to 1 in the led setting code if the user tried to set a higher
value. This fix is needed in the interest of correctness though.

 drivers/hid/hid-sony.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 2259eaa..e435223 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -1307,7 +1307,7 @@ static int sony_leds_init(struct sony_sc *sc)
 	static const char * const ds4_name_str[] = { "red", "green", "blue",
 						  "global" };
 	__u8 initial_values[MAX_LEDS] = { 0 };
-	__u8 max_brightness[MAX_LEDS] = { 1 };
+	__u8 max_brightness[MAX_LEDS] = { [0 ... (MAX_LEDS - 1)] = 1 };
 	__u8 use_hw_blink[MAX_LEDS] = { 0 };
 
 	BUG_ON(!(sc->quirks & SONY_LED_SUPPORT));
-- 
1.9.1

