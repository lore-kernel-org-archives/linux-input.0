From: Michael Schmitz <schmitzmic@gmail.com>
Subject: [PATCH 1/2] input: atakbd.c - fix Atari keymap
Date: Fri,  7 Sep 2018 11:40:42 +1200
Message-ID: <1536277243-3821-2-git-send-email-schmitzmic@gmail.com>
References: <1536277243-3821-1-git-send-email-schmitzmic@gmail.com>
Return-path: <bounce-debian-68k=debian-68k=m.gmane.org@lists.debian.org>
In-Reply-To: <1536277243-3821-1-git-send-email-schmitzmic@gmail.com>
Resent-Message-ID: <R2qX04EfdjH.A.-zH.gsbkbB@bendel>
List-URL: <https://lists.debian.org/debian-68k/>
List-Post: <mailto:debian-68k@lists.debian.org>
List-Help: <mailto:debian-68k-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-68k-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-68k-request@lists.debian.org?subject=unsubscribe>
List-Archive: https://lists.debian.org/msgid-search/1536277243-3821-2-git-send-email-schmitzmic@gmail.com
To: linux-input@vger.kernel.org
Cc: debian-68k@lists.debian.org, linux-m68k@lists.linux-m68k.org, Andreas Schwab <schwab@linux-m68k.org>, Michael Schmitz <schmitzmic@gmail.com>
List-Id: linux-input@vger.kernel.org

From: Andreas Schwab <schwab@linux-m68k.org>

Fix errors in Atari keymap (mostly in keypad, help and undo keys).

Patch provided on debian-68k ML by Andreas Schwab <schwab@linux-m68k.org>,
keymap array size and unhandled scancode limit adjusted to 0x73 by me.

Tested-by: Michael Schmitz <schmitzmic@gmail.com>
Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>

---
 drivers/input/keyboard/atakbd.c |   64 ++++++++++++++++-----------------------
 1 files changed, 26 insertions(+), 38 deletions(-)

diff --git a/drivers/input/keyboard/atakbd.c b/drivers/input/keyboard/atakbd.c
index 6f62da2..e989574 100644
--- a/drivers/input/keyboard/atakbd.c
+++ b/drivers/input/keyboard/atakbd.c
@@ -75,8 +75,7 @@
  */
 
 
-static unsigned char atakbd_keycode[0x72] = {	/* American layout */
-	[0]	 = KEY_GRAVE,
+static unsigned char atakbd_keycode[0x73] = {	/* American layout */
 	[1]	 = KEY_ESC,
 	[2]	 = KEY_1,
 	[3]	 = KEY_2,
@@ -117,9 +116,9 @@
 	[38]	 = KEY_L,
 	[39]	 = KEY_SEMICOLON,
 	[40]	 = KEY_APOSTROPHE,
-	[41]	 = KEY_BACKSLASH,	/* FIXME, '#' */
+	[41]	 = KEY_GRAVE,
 	[42]	 = KEY_LEFTSHIFT,
-	[43]	 = KEY_GRAVE,		/* FIXME: '~' */
+	[43]	 = KEY_BACKSLASH,
 	[44]	 = KEY_Z,
 	[45]	 = KEY_X,
 	[46]	 = KEY_C,
@@ -145,45 +144,34 @@
 	[66]	 = KEY_F8,
 	[67]	 = KEY_F9,
 	[68]	 = KEY_F10,
-	[69]	 = KEY_ESC,
-	[70]	 = KEY_DELETE,
-	[71]	 = KEY_KP7,
-	[72]	 = KEY_KP8,
-	[73]	 = KEY_KP9,
+	[71]	 = KEY_HOME,
+	[72]	 = KEY_UP,
 	[74]	 = KEY_KPMINUS,
-	[75]	 = KEY_KP4,
-	[76]	 = KEY_KP5,
-	[77]	 = KEY_KP6,
+	[75]	 = KEY_LEFT,
+	[77]	 = KEY_RIGHT,
 	[78]	 = KEY_KPPLUS,
-	[79]	 = KEY_KP1,
-	[80]	 = KEY_KP2,
-	[81]	 = KEY_KP3,
-	[82]	 = KEY_KP0,
-	[83]	 = KEY_KPDOT,
-	[90]	 = KEY_KPLEFTPAREN,
-	[91]	 = KEY_KPRIGHTPAREN,
-	[92]	 = KEY_KPASTERISK,	/* FIXME */
-	[93]	 = KEY_KPASTERISK,
-	[94]	 = KEY_KPPLUS,
-	[95]	 = KEY_HELP,
+	[80]	 = KEY_DOWN,
+	[82]	 = KEY_INSERT,
+	[83]	 = KEY_DELETE,
 	[96]	 = KEY_102ND,
-	[97]	 = KEY_KPASTERISK,	/* FIXME */
-	[98]	 = KEY_KPSLASH,
+	[97]	 = KEY_UNDO,
+	[98]	 = KEY_HELP,
 	[99]	 = KEY_KPLEFTPAREN,
 	[100]	 = KEY_KPRIGHTPAREN,
 	[101]	 = KEY_KPSLASH,
 	[102]	 = KEY_KPASTERISK,
-	[103]	 = KEY_UP,
-	[104]	 = KEY_KPASTERISK,	/* FIXME */
-	[105]	 = KEY_LEFT,
-	[106]	 = KEY_RIGHT,
-	[107]	 = KEY_KPASTERISK,	/* FIXME */
-	[108]	 = KEY_DOWN,
-	[109]	 = KEY_KPASTERISK,	/* FIXME */
-	[110]	 = KEY_KPASTERISK,	/* FIXME */
-	[111]	 = KEY_KPASTERISK,	/* FIXME */
-	[112]	 = KEY_KPASTERISK,	/* FIXME */
-	[113]	 = KEY_KPASTERISK	/* FIXME */
+	[103]	 = KEY_KP7,
+	[104]	 = KEY_KP8,
+	[105]	 = KEY_KP9,
+	[106]	 = KEY_KP4,
+	[107]	 = KEY_KP5,
+	[108]	 = KEY_KP6,
+	[109]	 = KEY_KP1,
+	[110]	 = KEY_KP2,
+	[111]	 = KEY_KP3,
+	[112]	 = KEY_KP0,
+	[113]	 = KEY_KPDOT,
+	[114]	 = KEY_KPENTER,
 };
 
 static struct input_dev *atakbd_dev;
@@ -191,7 +179,7 @@
 static void atakbd_interrupt(unsigned char scancode, char down)
 {
 
-	if (scancode < 0x72) {		/* scancodes < 0xf2 are keys */
+	if (scancode < 0x73) {		/* scancodes < 0xf3 are keys */
 
 		// report raw events here?
 
@@ -205,7 +193,7 @@ static void atakbd_interrupt(unsigned char scancode, char down)
 			input_report_key(atakbd_dev, scancode, down);
 			input_sync(atakbd_dev);
 		}
-	} else				/* scancodes >= 0xf2 are mouse data, most likely */
+	} else				/* scancodes >= 0xf3 are mouse data, most likely */
 		printk(KERN_INFO "atakbd: unhandled scancode %x\n", scancode);
 
 	return;
