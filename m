From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 1/4] tty/vt/keyboard: use defined macros for masks
Date: Fri, 27 Jan 2017 18:13:15 +0100
Message-ID: <20170127171318.2596-2-benjamin.tissoires@redhat.com>
References: <20170127171318.2596-1-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170127171318.2596-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Better using the defined macros to express the bit masks.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/tty/vt/keyboard.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index 3dd6a49..4a3907e 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -1044,9 +1044,9 @@ static int kbd_update_leds_helper(struct input_handle *handle, void *data)
 	unsigned int leds = *(unsigned int *)data;
 
 	if (test_bit(EV_LED, handle->dev->evbit)) {
-		input_inject_event(handle, EV_LED, LED_SCROLLL, !!(leds & 0x01));
-		input_inject_event(handle, EV_LED, LED_NUML,    !!(leds & 0x02));
-		input_inject_event(handle, EV_LED, LED_CAPSL,   !!(leds & 0x04));
+		input_inject_event(handle, EV_LED, LED_SCROLLL, !!(leds & BIT(VC_SCROLLOCK)));
+		input_inject_event(handle, EV_LED, LED_NUML,    !!(leds & BIT(VC_NUMLOCK)));
+		input_inject_event(handle, EV_LED, LED_CAPSL,   !!(leds & BIT(VC_CAPSLOCK)));
 		input_inject_event(handle, EV_SYN, SYN_REPORT, 0);
 	}
 
-- 
2.9.3
