From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 3/4] tty/vt/keyboard: reset the LEDs state at each console change
Date: Fri, 27 Jan 2017 18:13:17 +0100
Message-ID: <20170127171318.2596-4-benjamin.tissoires@redhat.com>
References: <20170127171318.2596-1-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170127171318.2596-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

When switching between consoles, the LEDs state is correctly
assigned, as long as the kernel manages the console.
When switching back from Gnome, the VT is not aware of the
current state of the LEDs. So if Gnome changes them, the
kernel still bellieves they are off, and it won't turn them
off when switching to a new TTY.

To keep the LEDs status in sync with the actual modifiers,
simply force a reset of the LEDs when we detect a vt change.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/tty/vt/keyboard.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index ca1d614..410b21e 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -137,6 +137,8 @@ static unsigned char ledioctl;
 static bool caps_as_controlllock;
 static bool task_caps_as_controlllock;
 
+static int saved_cur_kbd_console = -1;
+
 /*
  * Notifier list for console keyboard events
  */
@@ -1482,6 +1484,12 @@ static void kbd_event(struct input_handle *handle, unsigned int event_type,
 	/* We are called with interrupts disabled, just take the lock */
 	spin_lock(&kbd_event_lock);
 
+	/* reset the led state on console switch */
+	if (saved_cur_kbd_console != fg_console) {
+		ledstate = -1U;
+		saved_cur_kbd_console = fg_console;
+	}
+
 	if (event_type == EV_MSC && event_code == MSC_RAW && HW_RAW(handle->dev))
 		kbd_rawcode(value);
 	if (event_type == EV_KEY)
-- 
2.9.3
