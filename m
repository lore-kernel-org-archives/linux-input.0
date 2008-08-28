From: Karl Dahlke <eklhad@comcast.net>
Subject: [PATCH] 2.6.26 pc speaker clicks and chirps
Date: Wed, 27 Aug 2008 20:32:26 -0400
Message-ID: <20080727203226.eklhad@comcast.net>
Reply-To: Karl Dahlke <eklhad@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from qmta09.emeryville.ca.mail.comcast.net ([76.96.30.96]:47217 "EHLO
	QMTA09.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752359AbYH1Aca (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 27 Aug 2008 20:32:30 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, samuel.thibault@ens-lyon.org

Certain modules, e.g. accessibility modules for the blind,
will want to generate more than just tones through the pc speaker.
This patch supports clicks and chirps.
Soft clicks, for instance, provide audio feedback for a blind user
when keys are pressed, or when characters appear on  screen.
I have written modules that make these sounds directly,
by hitting the pc speaker at port 61,
but it would be better if all such sounds were sequestered
in the pcspkr.ko module, and under the same spinlock.

This patch is a necessary prelude to modules that will take
advantage of these sounds.

Signed-off-by: Karl Dahlke eklhad@comcast.net

--- drivers/input/misc/pcspkr.c	2008-08-14 14:41:33.000000000 -0400
+++ drivers/input/misc/pcspkr.c.new	2008-08-14 14:41:33.000000000 -0400
@@ -18,6 +18,7 @@
 #include <linux/input.h>
 #include <linux/platform_device.h>
 #include <asm/io.h>
+#include <asm/delay.h>
 
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
 MODULE_DESCRIPTION("PC Speaker beeper driver");
@@ -32,41 +33,82 @@ MODULE_ALIAS("platform:pcspkr");
 static DEFINE_SPINLOCK(i8253_lock);
 #endif
 
+#define SPEAKER_PORT 0x61
+
 static int pcspkr_event(struct input_dev *dev, unsigned int type, unsigned int code, int value)
 {
 	unsigned int count = 0;
 	unsigned long flags;
+	int retcode = 0;
+	char c;
+	int top, bottom;
+	char step;
 
 	if (type != EV_SND)
 		return -1;
 
+	spin_lock_irqsave(&i8253_lock, flags);
+
 	switch (code) {
 		case SND_BELL: if (value) value = 1000;
-		case SND_TONE: break;
-		default: return -1;
-	}
+		/* fall through */
 
-	if (value > 20 && value < 32767)
-		count = PIT_TICK_RATE / value;
+		case SND_TONE:
+		if (value > 20 && value < 32767)
+			count = PIT_TICK_RATE / value;
+		if (count) {
+			/* enable counter 2 */
+			outb_p(inb_p(SPEAKER_PORT) | 3, SPEAKER_PORT);
+			/* set command for counter 2, 2 byte write */
+			outb_p(0xB6, 0x43);
+			/* select desired HZ */
+			outb_p(count & 0xff, 0x42);
+			outb((count >> 8) & 0xff, 0x42);
+		} else {
+			/* disable counter 2 */
+			outb(inb_p(SPEAKER_PORT) & 0xFC, SPEAKER_PORT);
+		}
+		break;
+
+		case SND_PULSE:
+		/* Don't hold the cpu for more than 2ms */
+		count = ((unsigned)value > 2000 ? 2000 : value);
+		/* canot interrupt a tone with a click */
+		c = inb_p(SPEAKER_PORT);
+		if((c&3) != 3 && count) {
+			c &= 0xfe;
+			c ^= 2; /* toggle */
+			outb(c, SPEAKER_PORT);
+			udelay(count);
+			c ^= 2;
+			outb(c, SPEAKER_PORT);
+		}
+		break;
+
+		case SND_SWOOP:
+		value &= 0x3fffffff;
+		top = value >> 19;
+		bottom = (value >> 8) & 0x7ff;
+		step = value;
+		/* Careful: small steps, or large values of top-bottom will hog the cpu */
+		c = inb_p(SPEAKER_PORT);
+		if((c&3) != 3 && step) {
+			c &= 0xfe;
+			while((step > 0 && top < bottom) || (step < 0 && top > bottom)) {
+				c ^= 2; /* toggle */
+				outb(c, SPEAKER_PORT);
+				udelay(top);
+				top += step;
+			}
+		}
+		break;
 
-	spin_lock_irqsave(&i8253_lock, flags);
-
-	if (count) {
-		/* enable counter 2 */
-		outb_p(inb_p(0x61) | 3, 0x61);
-		/* set command for counter 2, 2 byte write */
-		outb_p(0xB6, 0x43);
-		/* select desired HZ */
-		outb_p(count & 0xff, 0x42);
-		outb((count >> 8) & 0xff, 0x42);
-	} else {
-		/* disable counter 2 */
-		outb(inb_p(0x61) & 0xFC, 0x61);
+		default: retcode = -1;
 	}
 
 	spin_unlock_irqrestore(&i8253_lock, flags);
 
-	return 0;
+	return retcode;
 }
 
 static int __devinit pcspkr_probe(struct platform_device *dev)
@@ -87,7 +129,8 @@ static int __devinit pcspkr_probe(struct
 	pcspkr_dev->dev.parent = &dev->dev;
 
 	pcspkr_dev->evbit[0] = BIT_MASK(EV_SND);
-	pcspkr_dev->sndbit[0] = BIT_MASK(SND_BELL) | BIT_MASK(SND_TONE);
+	pcspkr_dev->sndbit[0] = BIT_MASK(SND_BELL) | BIT_MASK(SND_TONE) |
+		BIT_MASK(SND_PULSE) | BIT_MASK(SND_SWOOP);
 	pcspkr_dev->event = pcspkr_event;
 
 	err = input_register_device(pcspkr_dev);
--- include/linux/input.h	2008-08-14 14:41:33.000000000 -0400
+++ include/linux/input.h.new	2008-08-14 14:41:33.000000000 -0400
@@ -688,6 +688,8 @@ struct input_absinfo {
 #define SND_CLICK		0x00
 #define SND_BELL		0x01
 #define SND_TONE		0x02
+#define SND_PULSE		0x03
+#define SND_SWOOP		0x04
 #define SND_MAX			0x07
 #define SND_CNT			(SND_MAX+1)
 
--- include/linux/vt_kern.h	2008-08-14 14:41:33.000000000 -0400
+++ include/linux/vt_kern.h.new	2008-08-14 14:41:33.000000000 -0400
@@ -25,7 +25,49 @@
 #define BROKEN_GRAPHICS_PROGRAMS 1
 #endif
 
+/*
+ * Generate a tone with the specified frequency and duration.
+ * Frequency is in hertz, and duration is in jiffies.
+ * This function assumes an input device has been loaded which
+ * is capable of generating the tone.
+ * Most PCs use pcspkr.ko, which generates sounds using the in-built toggle
+ * speaker at io 0x61, but other implementations are possible,
+ * such as sending a sine wave to the sound card.
+ */
+
 extern void kd_mksound(unsigned int hz, unsigned int ticks);
+
+/*
+ * Generate a single square wave with the specified duration.
+ * The speaker rises, waits usecs microseconds, and falls.
+ * A typical value is 500 microseconds, which generates a soft audible click.
+ * Accessibility adapters can use this to provide audio feedback for the blind
+ * when keys are pressed, or characters appear on screen.
+ * Timing is precise, below the resolution of jiffies,
+ * so this is often implemented by a busy loop.
+ * Best not to pulse for more than a couple milliseconds.
+ * There is no need to in any case.
+ * pcspkr enforces a limit of 2ms on the duration of the pulse.
+ */
+
+extern void kd_mkpulse(unsigned int usecs);
+
+/*
+ * A swoop is a fast tone that rises or falls in pitch.
+ * The initial and final periods of the wave form are specified,
+ * along with a step, which determines how quickly the frequency changes.
+ * for(count = top; count < bottom; count += step) {
+ *	togle the speaker and delay for count microseconds.
+ * }
+ * Negative step swoops up, positive step swoops down.
+ * This can be used to indicate unusual events, like a kernel alert message
+ * or other error conditions.
+ * Fast swoops sound more like chirps, and can indicate newlines
+ * in the output, or other semi-common events.
+ */
+
+extern void kd_mkswoop(unsigned int top, unsigned int bottom, int step);
+
 extern int kbd_rate(struct kbd_repeat *rep);
 extern int fg_console, last_console, want_console;
 
--- drivers/char/keyboard.c	2008-08-14 14:41:33.000000000 -0400
+++ drivers/char/keyboard.c.new	2008-08-14 14:41:33.000000000 -0400
@@ -263,6 +263,43 @@ void kd_mksound(unsigned int hz, unsigne
 }
 EXPORT_SYMBOL(kd_mksound);
 
+void kd_mkpulse(unsigned int usecs)
+{
+	struct list_head *node;
+
+	list_for_each_prev(node, &kbd_handler.h_list) {
+		struct input_handle *handle = to_handle_h(node);
+		if (test_bit(EV_SND, handle->dev->evbit)) {
+			if (test_bit(SND_PULSE, handle->dev->sndbit)) {
+				input_inject_event(handle, EV_SND, SND_PULSE, usecs);
+				break;
+			}
+		}
+	}
+}
+EXPORT_SYMBOL(kd_mkpulse);
+
+void kd_mkswoop(unsigned int top, unsigned int bottom, int step)
+{
+	struct list_head *node;
+	int value;
+
+	top &= 0x7ff;
+	bottom &= 0x7ff;
+	value = (top << 19) | (bottom << 8) | (step&0xff);
+
+	list_for_each_prev(node, &kbd_handler.h_list) {
+		struct input_handle *handle = to_handle_h(node);
+		if (test_bit(EV_SND, handle->dev->evbit)) {
+			if (test_bit(SND_SWOOP, handle->dev->sndbit)) {
+				input_inject_event(handle, EV_SND, SND_SWOOP, value);
+				break;
+			}
+		}
+	}
+}
+EXPORT_SYMBOL(kd_mkswoop);
+
 /*
  * Setting the keyboard rate.
  */
