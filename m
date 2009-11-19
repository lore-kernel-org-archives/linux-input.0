From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] Input: keyboard - add locking around event handling
Date: Wed, 18 Nov 2009 23:13:15 -0800
Message-ID: <20091119071315.GD3010@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:64363 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752108AbZKSHNO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 19 Nov 2009 02:13:14 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linux Input <linux-input@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>

Keyboard input handler is multiplexing events form all keyboard-like
devices in the system. Because of that per-device lock provided by
input core is not enough to prevent clashes in ked_event() and we
need our own lock to ensure that only one thread at a time executing
kbd_event().

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/char/keyboard.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)


diff --git a/drivers/char/keyboard.c b/drivers/char/keyboard.c
index ce2ab67..e095ff3 100644
--- a/drivers/char/keyboard.c
+++ b/drivers/char/keyboard.c
@@ -130,6 +130,7 @@ int shift_state = 0;
  */
 
 static struct input_handler kbd_handler;
+static DEFINE_SPINLOCK(kbd_event_lock);
 static unsigned long key_down[BITS_TO_LONGS(KEY_CNT)];	/* keyboard key bitmap */
 static unsigned char shift_down[NR_SHIFT];		/* shift state counters.. */
 static int dead_key_next;
@@ -1304,11 +1305,16 @@ static void kbd_keycode(unsigned int keycode, int down, int hw_raw)
 static void kbd_event(struct input_handle *handle, unsigned int event_type,
 		      unsigned int event_code, int value)
 {
+	/* We are called with interrupts disabled */
+	spin_lock(&kbd_event_lock);
+
 	if (event_type == EV_MSC && event_code == MSC_RAW && HW_RAW(handle->dev))
 		kbd_rawcode(value);
 	if (event_type == EV_KEY)
 		kbd_keycode(event_code, value, HW_RAW(handle->dev));
 
+	spin_unlock(&kbd_event_lock);
+
 	tasklet_schedule(&keyboard_tasklet);
 	do_poke_blanked_console = 1;
 	schedule_console_callback();
-- 
Dmitry
