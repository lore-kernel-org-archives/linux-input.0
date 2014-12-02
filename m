From: Karl Dahlke <eklhad@comcast.net>
Subject: [PATCH] input/speaker: additional clicks and tones for future accessibility
Date: Tue, 02 Dec 2014 00:17:40 -0500
Message-ID: <20141102001740.eklhad@comcast.net>
Reply-To: Karl Dahlke <eklhad@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from resqmta-ch2-07v.sys.comcast.net ([69.252.207.39]:55370 "EHLO
	resqmta-ch2-07v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751060AbaLBFZw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 2 Dec 2014 00:25:52 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, vojtech@ucw.cz
Cc: linux-input@vger.kernel.org

From: Karl Dahlke <eklhad@gmail.com>

Add clicks, tones, and tone sequences to the pc speaker.

The speaker driver can play a tone at a specified frequency,
or the standard control G bell,
which is a special case of TONE at 1000 hz 0.1 seconds.
Add kd_mkpulse() to generate a soft click.
This is introduced to support accessibility modules and adapters in the future.
It is a means to an end.
With this function in place, a module can easily provide soft clicks,
i.e. audible feedback, whenever a key is depressed,
or when that keystroke is echoed on screen.
This allows a blind user, for example, to have rapid feedback while typing,
even if he is, at the same time, listening to text that is already on screen.
It is faster and more convenient than having characters echoed verbally.
And it works all the time, even if speech or braille is not working
for whatever reason.

Also add the function kd_mknotes,
which plays a series of tones in the background.
Of course this can already be done with kd_mksound and timers,
but why should everyone reinvent the wheel?
It is better to write the function once, properly, in the kernel,
and let modules use it thereafter.
Again, this is a means to an end.
Accessibility modules can generate rapid sequences of notes
to indicate various conditions, sometimes error conditions,
especially if speech or braille is not working.
These notes may be the only feedback the user has to diagnose the problem.
This may be useful to other developers in other situations as well.

Finally add kd_mksteps to run something like a chromatic scale,
from one frequency to another in specified steps.
The half-tone scale, with a step of 6%, starting at middle C, is approximately
kd_mksteps(260, 530, 6, 150);

Signed-off-by: Karl Dahlke <eklhad@gmail.com>

---
Built and tested on 3.17.4, the latest stable kernel.

--- a/drivers/input/misc/pcspkr.c	2014-12-02 00:10:43.970435660 -0500
+++ b/drivers/input/misc/pcspkr.c	2014-12-02 00:10:43.974436209 -0500
@@ -18,6 +18,8 @@
 #include <linux/input.h>
 #include <linux/platform_device.h>
 #include <linux/timex.h>
+#include <linux/delay.h>
+
 #include <asm/io.h>
 
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
@@ -25,25 +27,26 @@ MODULE_DESCRIPTION("PC Speaker beeper dr
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:pcspkr");
 
-static int pcspkr_event(struct input_dev *dev, unsigned int type, unsigned int code, int value)
+/* Toggle the speaker, but not if a tone is sounding */
+static void speaker_toggle(void)
 {
-	unsigned int count = 0;
+	char c;
 	unsigned long flags;
 
-	if (type != EV_SND)
-		return -1;
-
-	switch (code) {
-		case SND_BELL: if (value) value = 1000;
-		case SND_TONE: break;
-		default: return -1;
+	raw_spin_lock_irqsave(&i8253_lock, flags);
+	c = inb_p(0x61);
+	if ((c&3) != 3) {
+		c &= 0xfe;
+		c ^= 2; /* toggle */
+		outb(c, 0x61);
 	}
+	raw_spin_unlock_irqrestore(&i8253_lock, flags);
+}
 
-	if (value > 20 && value < 32767)
-		count = PIT_TICK_RATE / value;
-
+static void speaker_sing(unsigned int count)
+{
+	unsigned long flags;
 	raw_spin_lock_irqsave(&i8253_lock, flags);
-
 	if (count) {
 		/* set command for counter 2, 2 byte write */
 		outb_p(0xB6, 0x43);
@@ -56,8 +59,44 @@ static int pcspkr_event(struct input_dev
 		/* disable counter 2 */
 		outb(inb_p(0x61) & 0xFC, 0x61);
 	}
-
 	raw_spin_unlock_irqrestore(&i8253_lock, flags);
+}
+
+static int pcspkr_event(struct input_dev *dev, unsigned int type, unsigned int code, int value)
+{
+	unsigned int count;
+
+	if (type != EV_SND)
+		return -1;
+
+	switch (code) {
+	case SND_BELL:
+		if (value)
+			value = 1000;
+		/* fall through */
+
+	case SND_TONE:
+		count = 0;
+		if (value > 20 && value < 32767)
+			count = PIT_TICK_RATE / value;
+		speaker_sing(count);
+		break;
+
+	case SND_PULSE:
+		/* Don't hold the cpu for more than 1ms */
+		/* no reason for a pulse to ever be longer than that. */
+		if (value > 1000)
+			value = 1000;
+		/* if a pulse is too short it can't be heard anyways. */
+		if (value < 20)
+			break;
+		speaker_toggle();
+		udelay(value);
+		speaker_toggle();
+		break;
+
+	default: return -1;
+	}
 
 	return 0;
 }
@@ -80,7 +119,8 @@ static int pcspkr_probe(struct platform_
 	pcspkr_dev->dev.parent = &dev->dev;
 
 	pcspkr_dev->evbit[0] = BIT_MASK(EV_SND);
-	pcspkr_dev->sndbit[0] = BIT_MASK(SND_BELL) | BIT_MASK(SND_TONE);
+	pcspkr_dev->sndbit[0] = BIT_MASK(SND_BELL) | BIT_MASK(SND_TONE) |
+		BIT_MASK(SND_PULSE);
 	pcspkr_dev->event = pcspkr_event;
 
 	err = input_register_device(pcspkr_dev);
--- a/drivers/tty/vt/keyboard.c	2014-12-02 00:10:43.978436759 -0500
+++ b/drivers/tty/vt/keyboard.c	2014-12-02 00:10:43.982437308 -0500
@@ -261,6 +261,213 @@ void kd_mksound(unsigned int hz, unsigne
 }
 EXPORT_SYMBOL(kd_mksound);
 
+static int kd_pulse_helper(struct input_handle *handle, void *data)
+{
+	unsigned int *width = data;
+	struct input_dev *dev = handle->dev;
+
+	if (*width == 0)
+		return 0;
+
+	if (test_bit(EV_SND, dev->evbit)) {
+		if (test_bit(SND_PULSE, dev->sndbit)) {
+			input_inject_event(handle, EV_SND, SND_PULSE, *width);
+			return 0;
+		}
+	}
+
+	return 0;
+}
+
+/* the width of the pulse is in microseconds, must be between 20 and 1000 */
+void kd_mkpulse(unsigned int width)
+{
+	input_handler_for_each_handle(&kbd_handler, &width, kd_pulse_helper);
+}
+EXPORT_SYMBOL(kd_mkpulse);
+
+/*
+ * Push notes onto a sound fifo and play them via an asynchronous thread.
+ * kd_mksound is a single tone, but kd_mknotes is a series of notes.
+ * this is used primarily by the accessibility modules, to sound
+ * various alerts and conditions for blind users.
+ * This is particularly helpful when the adapter is not working,
+ * for whatever reason.  These functions are central to the kernel,
+ * and do not depend on sound cards, loadable modules, etc.
+ * These notes can also alert a system administrator to conditions
+ * that warrant immediate attention.
+ * Each note is specified by 2 shorts.  The first is the frequency in hurtz,
+ * and the second is the duration in hundredths of a second.
+ * A frequency of -1 is a rest.
+ * A frequency of 0 ends the list of notes.
+ */
+
+#define SF_LEN 64		/* length of sound fifo */
+static short sf_fifo[SF_LEN];
+static int sf_head, sf_tail;
+static DEFINE_RAW_SPINLOCK(soundfifo_lock);
+
+/* Pop the next sound out of the sound fifo. */
+static void pop_soundfifo(unsigned long);
+static DEFINE_TIMER(kd_mknotes_timer, pop_soundfifo, 0, 0);
+static void pop_soundfifo(unsigned long notUsed)
+{
+	unsigned long flags;
+	int freq, duration;
+	int i;
+	long jifpause;
+
+	raw_spin_lock_irqsave(&soundfifo_lock, flags);
+
+	i = sf_tail;
+	if (i == sf_head) {
+		freq = 0;
+		duration = 0;
+	} else {
+		freq = sf_fifo[i];
+		duration = sf_fifo[i + 1];
+		i += 2;
+		if (i == SF_LEN)
+			i = 0;
+		sf_tail = i;
+	}
+
+	raw_spin_unlock_irqrestore(&soundfifo_lock, flags);
+
+	if (freq == 0) {
+		/* turn off singing speaker */
+		kd_nosound(0);
+		return;
+	}
+
+	jifpause = msecs_to_jiffies(duration);
+	/* not sure of the rounding, if duration < HZ */
+	if (jifpause == 0)
+		jifpause = 1;
+	mod_timer(&kd_mknotes_timer, jiffies + jifpause);
+
+	if (freq < 0) {
+		/* This is a rest between notes */
+		kd_nosound(0);
+	} else {
+		input_handler_for_each_handle(&kbd_handler, &freq,
+		kd_sound_helper);
+	}
+}
+
+/* Push a string of notes into the sound fifo. */
+void kd_mknotes(const short *p)
+{
+	int i;
+	bool wake = false;
+	unsigned long flags;
+
+	if (*p == 0)
+		return; /* empty list */
+
+	raw_spin_lock_irqsave(&soundfifo_lock, flags);
+
+	i = sf_head;
+	if (i == sf_tail)
+		wake = true;
+
+	/* Copy shorts into the fifo, until the terminating zero. */
+	while (*p) {
+		sf_fifo[i++] = *p++;
+		sf_fifo[i++] = (*p++) * 10;
+		if (i == SF_LEN)
+			i = 0;	/* wrap around */
+		if (i == sf_tail) {
+			/* fifo is full */
+			goto done;
+		}
+		sf_head = i;
+	}
+
+	/* try to add on a rest, to carry the last note through */
+	sf_fifo[i++] = -1;
+	sf_fifo[i++] = 10;
+	if (i == SF_LEN)
+		i = 0;	/* wrap around */
+	if (i != sf_tail)
+		sf_head = i;
+
+done:
+	raw_spin_unlock_irqrestore(&soundfifo_lock, flags);
+
+	/* first sound,  get things started. */
+	if (wake)
+		pop_soundfifo(0);
+}
+EXPORT_SYMBOL(kd_mknotes);
+
+/* Push an ascending or descending sequence of notes into the sound fifo.
+ * Step is a geometric factor on frequency, increase by x percent.
+ * 100% goes up by octaves, -50% goes down by octaves.
+ * 12% is a wholetone scale, while 6% is a chromatic scale.
+ * Duration is in milliseconds, for very fast frequency sweeps.  But this
+ * is based on jiffies timing, so is subject to the resolution of HZ. */
+void kd_mksteps(int f1, int f2, int step, int duration)
+{
+	int i;
+	bool wake = false;
+	unsigned long flags;
+
+	/* are the parameters in range? */
+	if (step != (char)step)
+		return;
+	if (duration <= 0 || duration > 2000)
+		return;
+	if (f1 < 50 || f1 > 8000)
+		return;
+	if (f2 < 50 || f2 > 8000)
+		return;
+
+	/* avoid infinite loops */
+	if (step == 0 ||
+	(f1 < f2 && step < 0) ||
+	(f1 > f2 && step > 0))
+		return;
+
+	raw_spin_lock_irqsave(&soundfifo_lock, flags);
+
+	i = sf_head;
+	if (i == sf_tail)
+		wake = true;
+
+	/* Copy shorts into the fifo, until start reaches end */
+	while ((step > 0 && f1 < f2) || (step < 0 && f1 > f2)) {
+		sf_fifo[i++] = f1;
+		sf_fifo[i++] = duration;
+		if (i == SF_LEN)
+			i = 0;	/* wrap around */
+		if (i == sf_tail) {
+			/* fifo is full */
+			goto done;
+		}
+		sf_head = i;
+		f1 = f1 * (100+step) / 100;
+		if (f1 < 50 || f1 > 8000)
+			break;
+	}
+
+	/* try to add on a rest, to carry the last note through */
+	sf_fifo[i++] = -1;
+	sf_fifo[i++] = 10;
+	if (i == SF_LEN)
+		i = 0;	/* wrap around */
+	if (i != sf_tail)
+		sf_head = i;
+
+done:
+	raw_spin_unlock_irqrestore(&soundfifo_lock, flags);
+
+	/* first sound,  get things started. */
+	if (wake)
+		pop_soundfifo(0);
+}
+EXPORT_SYMBOL(kd_mksteps);
+
 /*
  * Setting the keyboard rate.
  */
--- a/include/linux/vt_kern.h	2014-12-02 00:10:43.987437995 -0500
+++ b/include/linux/vt_kern.h	2014-12-02 00:10:43.990438407 -0500
@@ -28,6 +28,9 @@
 #endif
 
 extern void kd_mksound(unsigned int hz, unsigned int ticks);
+extern void kd_mkpulse(unsigned int width);
+extern void kd_mknotes(const short *p);
+extern void kd_mksteps(int freq1, int freq2, int step, int duration);
 extern int kbd_rate(struct kbd_repeat *rep);
 extern int fg_console, last_console, want_console;
 
--- a/include/uapi/linux/input.h	2014-12-02 00:10:43.994438956 -0500
+++ b/include/uapi/linux/input.h	2014-12-02 00:10:43.998439505 -0500
@@ -934,6 +934,7 @@ struct input_keymap_entry {
 #define SND_CLICK		0x00
 #define SND_BELL		0x01
 #define SND_TONE		0x02
+#define SND_PULSE		0x03
 #define SND_MAX			0x07
 #define SND_CNT			(SND_MAX+1)
 
