From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.28-rc6-davinci1 5/6] dm355evm input driver
Date: Wed, 14 Jan 2009 11:38:41 -0800
Message-ID: <200901141138.41623.david-b@pacbell.net>
References: <200812071159.50267.david-b@pacbell.net> <200901130142.57407.david-b@pacbell.net> <20090113213534.ZZRA012@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp122.sbc.mail.sp1.yahoo.com ([69.147.64.95]:26325 "HELO
	smtp122.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752396AbZANTio (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 14 Jan 2009 14:38:44 -0500
In-Reply-To: <20090113213534.ZZRA012@mailhub.coreip.homeip.net>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: davinci-linux-open-source@linux.davincidsp.com, Felipe Balbi <felipebalbi@users.sourceforge.net>, linux-input@vger.kernel.org

On Tuesday 13 January 2009, Dmitry Torokhov wrote:
> > > > +		/* Report press + release ... we can't tell if
> > > > +		 * this is an autorepeat, and we need to guess
> > > > +		 * about the release.
> > > > +		 */
> > > > +		input_report_key(keys->input, keycode, 1);
> > > 
> > > input_sync() is also needed here.
> > > 
> > > > +		input_report_key(keys->input, keycode, 0);
> > > > +	}
> > > > +	input_sync(keys->input);
> > 
> > If so, then the existing input_sync() needs to move up
> > a few lines too ... I had thought that the "sync" was
> > like with a filesystem, where lots of events could be
> > batched, but evidently not.
> > 
> 
> It is and they can. The idea is that userspace accumulates input events
> until it gets the sync event which signals that as full as possible
> hardware state was transmitted. The problem with keys is that if
> userspace really does accumulate events the 2 down/up in succession will
> cancel each other. There are really 2 separate states - button pressed
> and button released which should be accompanied with its own sync. But
> if you were reposting several buttons at once they could all "share" the
> same sync event. Does it make any sense to you?

Yes.  But now I seem to observe a LOT more events.  I suppose that's
partly due to the fuzzy semantics of these events:  they don't encode
"down" or "up".


> So you will be sending an update, right?

Appended is a patchlet addressing your feedback.  What I'll do is
submit this to the DaVinci tree, and send you an all-in-one patch.

- Dave


======= SNIP!
From: David Brownell <dbrownell@users.sourceforge.net>

Address feedback from Dmitry:
 - input_sync() per event
 - maintain dev->keybit when remapping keys
 - since we handle remapping, keycodemax and keycodesize aren't used
 - on probe error, don't input_free_device() unless it registered

Also:
 - avoid reporting excess events
 - more bad-parameter paranoia in the remapping code

The excess event issue is basically that we don't have a way to
distinguish "button press" events from "button release" ones or
autorepeat events, so we should try being a bit smarter about
synthesizing them.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 drivers/input/keyboard/dm355evm_keys.c |   49 ++++++++++++++++++++++++-------
 1 file changed, 39 insertions(+), 10 deletions(-)

--- a/drivers/input/keyboard/dm355evm_keys.c
+++ b/drivers/input/keyboard/dm355evm_keys.c
@@ -28,6 +28,8 @@
  * using a work_struct.  The IRQ is active low, but we use it through
  * the GPIO controller so we can trigger on falling edges.
  *
+ * Note that physically there can only be one of these devices.
+ *
  * This driver was tested with firmware revision A4.
  */
 struct dm355evm_keys {
@@ -120,6 +122,8 @@ static void dm355evm_keys_work(struct wo
 	 * Reading INPUT_LOW decrements the count.
 	 */
 	for (;;) {
+		static u16	last_event;
+
 		u16		event;
 		int		keycode;
 		int		i;
@@ -142,6 +146,23 @@ static void dm355evm_keys_work(struct wo
 		if (event == 0xdead)
 			break;
 
+		/* Press and release a button:  two events, same code.
+		 * Press and hold (autorepeat), then release: N events
+		 * (N > 2), same code.  For RC5 buttons the toggle bits
+		 * distinguish (for example) "1-autorepeat" from "1 1";
+		 * but PCB buttons don't support that bit.
+		 *
+		 * So we must synthesize release events.  We do that by
+		 * mapping events to a press/release event pair; then
+		 * to avoid adding extra events, skip the second event
+		 * of each pair.
+		 */
+		if (event == last_event) {
+			last_event = 0;
+			continue;
+		}
+		last_event = event;
+
 		/* ignore the RC5 toggle bit */
 		event &= ~0x0800;
 
@@ -157,28 +178,38 @@ static void dm355evm_keys_work(struct wo
 			"input event 0x%04x--> keycode %d\n",
 			event, keycode);
 
-		/* Report press + release ... we can't tell if
-		 * this is an autorepeat, and we need to guess
-		 * about the release.
-		 */
+		/* report press + release */
 		input_report_key(keys->input, keycode, 1);
+		input_sync(keys->input);
 		input_report_key(keys->input, keycode, 0);
+		input_sync(keys->input);
 	}
-	input_sync(keys->input);
 }
 
 static int dm355evm_setkeycode(struct input_dev *dev, int index, int keycode)
 {
-	if (index >= ARRAY_SIZE(dm355evm_keys))
+	u16		old_keycode;
+	unsigned	i;
+
+	if (((unsigned)index) >= ARRAY_SIZE(dm355evm_keys))
 		return -EINVAL;
 
+	old_keycode = dm355evm_keys[index].keycode;
 	dm355evm_keys[index].keycode = keycode;
+	set_bit(keycode, dev->keybit);
+
+	for (i = 0; i < ARRAY_SIZE(dm355evm_keys); i++) {
+		if (dm355evm_keys[index].keycode == old_keycode)
+			goto done;
+	}
+	clear_bit(old_keycode, dev->keybit);
+done:
 	return 0;
 }
 
 static int dm355evm_getkeycode(struct input_dev *dev, int index, int *keycode)
 {
-	if (index >= ARRAY_SIZE(dm355evm_keys))
+	if (((unsigned)index) >= ARRAY_SIZE(dm355evm_keys))
 		return -EINVAL;
 
 	return dm355evm_keys[index].keycode;
@@ -219,8 +250,6 @@ static int __devinit dm355evm_keys_probe
 	for (i = 0; i < ARRAY_SIZE(dm355evm_keys); i++)
 		set_bit(dm355evm_keys[i].keycode, input->keybit);
 
-	input->keycodemax = ARRAY_SIZE(dm355evm_keys);
-	input->keycodesize = sizeof(dm355evm_keys[0]);
 	input->keycode = dm355evm_keys;
 	input->setkeycode = dm355evm_setkeycode;
 	input->getkeycode = dm355evm_getkeycode;
@@ -237,7 +266,7 @@ static int __devinit dm355evm_keys_probe
 	/* register */
 	status = input_register_device(input);
 	if (status < 0)
-		goto fail1;
+		goto fail0;
 
 	/* start reporting events */
 	status = request_irq(keys->irq, dm355evm_keys_irq,
