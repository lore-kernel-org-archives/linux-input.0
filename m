From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [RFC/RFT] Reinject Alt+SysRq when no hotkeys have been pressed
Date: Mon, 8 Nov 2010 23:34:16 -0800
Message-ID: <20101109073416.GA14110@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="BXVAT5kNtrzKuDFl"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:62775 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752320Ab0KIHeX (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Nov 2010 02:34:23 -0500
Received: by gyh4 with SMTP id 4so4065345gyh.19
        for <linux-input@vger.kernel.org>; Mon, 08 Nov 2010 23:34:23 -0800 (PST)
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linux Input <linux-input@vger.kernel.org>
Cc: Maxim Levitsky <maximlevitsky@gmail.com>, Jason Wessel <jason.wessel@windriver.com>


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Now that KGDB knows how to release keys that have been pressed when
entering the debugger the only issue left is that SysRq handler is too
greedy and always swallows Alt+SysRq, causing print screen hotkey to
stop working. The solution is to re-inject the key combo when user
releases SysRq without pressing any other keys. The patch below does
just that and also releases keys that have been pressed before we enter
SysRq mode.

Note that it depends on a patch to input core that will stop events
injected by one input handler from reaching the very same input handler
(attached).

Comments/testing/suggestion are sought after.

Thanks.

-- 
Dmitry

Input: sysrq - pass along lone Alt + SysRq

When user presses and releases Alt + SysRq without pressing any of the
hot keys re-inject the combination and pass it on to userspace instead
of suppressing it - maybe he or she wanted to take print screen
instead of invoking SysRq handler.

Also pass along release events for keys that have been pressed before
SysRq mode has been invoked so that keys do not appear to be "stuck".

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/tty/sysrq.c |  157 ++++++++++++++++++++++++++++++++++++---------------
 1 files changed, 112 insertions(+), 45 deletions(-)


diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index eaa5d3e..277941b 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -554,7 +554,7 @@ EXPORT_SYMBOL(handle_sysrq);
 #ifdef CONFIG_INPUT
 
 /* Simple translation table for the SysRq keys */
-static const unsigned char sysrq_xlate[KEY_MAX + 1] =
+static const unsigned char sysrq_xlate[KEY_CNT] =
         "\000\0331234567890-=\177\t"                    /* 0x00 - 0x0f */
         "qwertyuiop[]\r\000as"                          /* 0x10 - 0x1f */
         "dfghjkl;'`\000\\zxcv"                          /* 0x20 - 0x2f */
@@ -563,53 +563,117 @@ static const unsigned char sysrq_xlate[KEY_MAX + 1] =
         "230\177\000\000\213\214\000\000\000\000\000\000\000\000\000\000" /* 0x50 - 0x5f */
         "\r\000/";                                      /* 0x60 - 0x6f */
 
-static bool sysrq_down;
-static int sysrq_alt_use;
-static int sysrq_alt;
-static DEFINE_SPINLOCK(sysrq_event_lock);
+struct sysrq_state {
+	struct input_handle handle;
+	struct work_struct reinject_work;
+	unsigned long key_down[BITS_TO_LONGS(KEY_CNT)];
+	unsigned int alt;
+	unsigned int alt_use;
+	bool active;
+	bool need_reinject;
+};
+
+static void sysrq_reinject_alt_sysrq(struct work_struct *work)
+{
+	struct sysrq_state *sysrq =
+			container_of(work, struct sysrq_state, reinject_work);
+	struct input_handle *handle = &sysrq->handle;
+	unsigned int alt_code = sysrq->alt_use;
+
+	if (sysrq->need_reinject) {
+		/* Simulate press and release of Alt + SysRq */
+		input_inject_event(handle, EV_KEY, alt_code, 1);
+		input_inject_event(handle, EV_KEY, KEY_SYSRQ, 1);
+		input_inject_event(handle, EV_SYN, SYN_REPORT, 1);
+
+		input_inject_event(handle, EV_KEY, KEY_SYSRQ, 0);
+		input_inject_event(handle, EV_KEY, alt_code, 0);
+		input_inject_event(handle, EV_SYN, SYN_REPORT, 1);
+	}
+}
 
-static bool sysrq_filter(struct input_handle *handle, unsigned int type,
-		         unsigned int code, int value)
+static bool sysrq_filter(struct input_handle *handle,
+			 unsigned int type, unsigned int code, int value)
 {
+	struct sysrq_state *sysrq = handle->private;
+	bool was_active = sysrq->active;
 	bool suppress;
 
-	/* We are called with interrupts disabled, just take the lock */
-	spin_lock(&sysrq_event_lock);
+	switch (type) {
 
-	if (type != EV_KEY)
-		goto out;
+	case EV_SYN:
+		suppress = false;
+		break;
 
-	switch (code) {
+	case EV_KEY:
+		switch (code) {
 
-	case KEY_LEFTALT:
-	case KEY_RIGHTALT:
-		if (value)
-			sysrq_alt = code;
-		else {
-			if (sysrq_down && code == sysrq_alt_use)
-				sysrq_down = false;
+		case KEY_LEFTALT:
+		case KEY_RIGHTALT:
+			if (!value) {
+				/* One of ALTs is being released */
+				if (sysrq->active && code == sysrq->alt_use)
+					sysrq->active = false;
 
-			sysrq_alt = 0;
+				sysrq->alt = KEY_RESERVED;
+
+			} else if (value != 2) {
+				sysrq->alt = code;
+				sysrq->need_reinject = false;
+			}
+			break;
+
+		case KEY_SYSRQ:
+			if (value == 1 && sysrq->alt != KEY_RESERVED) {
+				sysrq->active = true;
+				sysrq->alt_use = sysrq->alt;
+				/*
+				 * If nothing else will be pressed we'll need
+				 * to * re-inject Alt-SysRq keysroke.
+				 */
+				sysrq->need_reinject = true;
+			}
+			break;
+
+		default:
+			if (sysrq->active && value && value != 2) {
+				sysrq->need_reinject = false;
+				__handle_sysrq(sysrq_xlate[code], true);
+			}
+			break;
 		}
-		break;
 
-	case KEY_SYSRQ:
-		if (value == 1 && sysrq_alt) {
-			sysrq_down = true;
-			sysrq_alt_use = sysrq_alt;
+		suppress = sysrq->active;
+
+		if (!sysrq->active) {
+			/*
+			 * If we are not suppressing key presses keep track of
+			 * keyboard state so we can release keys that have been
+			 * pressed before entering SysRq mode.
+			 */
+			if (value)
+				set_bit(code, sysrq->key_down);
+			else
+				clear_bit(code, sysrq->key_down);
+
+			if (was_active)
+				schedule_work(&sysrq->reinject_work);
+
+		} else if (value == 0 &&
+			   test_and_clear_bit(code, sysrq->key_down)) {
+			/*
+			 * Pass on release events for keys that was pressed before
+			 * entering SysRq mode.
+			 */
+			suppress = false;
 		}
 		break;
 
 	default:
-		if (sysrq_down && value && value != 2)
-			__handle_sysrq(sysrq_xlate[code], true);
+		suppress = sysrq->active;
 		break;
 	}
 
-out:
-	suppress = sysrq_down;
-	spin_unlock(&sysrq_event_lock);
-
 	return suppress;
 }
 
@@ -617,28 +681,28 @@ static int sysrq_connect(struct input_handler *handler,
 			 struct input_dev *dev,
 			 const struct input_device_id *id)
 {
-	struct input_handle *handle;
+	struct sysrq_state *sysrq;
 	int error;
 
-	sysrq_down = false;
-	sysrq_alt = 0;
-
-	handle = kzalloc(sizeof(struct input_handle), GFP_KERNEL);
-	if (!handle)
+	sysrq = kzalloc(sizeof(struct sysrq_state), GFP_KERNEL);
+	if (!sysrq)
 		return -ENOMEM;
 
-	handle->dev = dev;
-	handle->handler = handler;
-	handle->name = "sysrq";
+	INIT_WORK(&sysrq->reinject_work, sysrq_reinject_alt_sysrq);
+
+	sysrq->handle.dev = dev;
+	sysrq->handle.handler = handler;
+	sysrq->handle.name = "sysrq";
+	sysrq->handle.private = sysrq;
 
-	error = input_register_handle(handle);
+	error = input_register_handle(&sysrq->handle);
 	if (error) {
 		pr_err("Failed to register input sysrq handler, error %d\n",
 			error);
 		goto err_free;
 	}
 
-	error = input_open_device(handle);
+	error = input_open_device(&sysrq->handle);
 	if (error) {
 		pr_err("Failed to open input device, error %d\n", error);
 		goto err_unregister;
@@ -647,17 +711,20 @@ static int sysrq_connect(struct input_handler *handler,
 	return 0;
 
  err_unregister:
-	input_unregister_handle(handle);
+	input_unregister_handle(&sysrq->handle);
  err_free:
-	kfree(handle);
+	kfree(sysrq);
 	return error;
 }
 
 static void sysrq_disconnect(struct input_handle *handle)
 {
+	struct sysrq_state *sysrq = handle->private;
+
 	input_close_device(handle);
+	cancel_work_sync(&sysrq->reinject_work);
 	input_unregister_handle(handle);
-	kfree(handle);
+	kfree(sysrq);
 }
 
 /*

--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="input-filter-bypass.patch"

Input: do not pass injected events back to the originating handler

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Sometimes input handlers (as opposed to input devices) have a need to
inject (or re-inject) events back into input core. For example sysrq
filter may want to inject previously suppressed Alt-SysRq so that user
can take a screen print. In this case we do not want to pass such events
back to the same same handler that injected them to avoid loops.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/input.c |   37 ++++++++++++++++++++++++++-----------
 1 files changed, 26 insertions(+), 11 deletions(-)


diff --git a/drivers/input/input.c b/drivers/input/input.c
index 75bed63..7f26ca6 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -74,6 +74,7 @@ static int input_defuzz_abs_event(int value, int old_val, int fuzz)
  * dev->event_lock held and interrupts disabled.
  */
 static void input_pass_event(struct input_dev *dev,
+			     struct input_handler *src_handler,
 			     unsigned int type, unsigned int code, int value)
 {
 	struct input_handler *handler;
@@ -92,6 +93,15 @@ static void input_pass_event(struct input_dev *dev,
 				continue;
 
 			handler = handle->handler;
+
+			/*
+			 * If this is the handler that injected this
+			 * particular event we want to skip it to avoid
+			 * filters firing again and again.
+			 */
+			if (handler == src_handler)
+				continue;
+
 			if (!handler->filter) {
 				if (filtered)
 					break;
@@ -121,7 +131,7 @@ static void input_repeat_key(unsigned long data)
 	if (test_bit(dev->repeat_key, dev->key) &&
 	    is_event_supported(dev->repeat_key, dev->keybit, KEY_MAX)) {
 
-		input_pass_event(dev, EV_KEY, dev->repeat_key, 2);
+		input_pass_event(dev, NULL, EV_KEY, dev->repeat_key, 2);
 
 		if (dev->sync) {
 			/*
@@ -130,7 +140,7 @@ static void input_repeat_key(unsigned long data)
 			 * Otherwise assume that the driver will send
 			 * SYN_REPORT once it's done.
 			 */
-			input_pass_event(dev, EV_SYN, SYN_REPORT, 1);
+			input_pass_event(dev, NULL, EV_SYN, SYN_REPORT, 1);
 		}
 
 		if (dev->rep[REP_PERIOD])
@@ -163,6 +173,7 @@ static void input_stop_autorepeat(struct input_dev *dev)
 #define INPUT_PASS_TO_ALL	(INPUT_PASS_TO_HANDLERS | INPUT_PASS_TO_DEVICE)
 
 static int input_handle_abs_event(struct input_dev *dev,
+				  struct input_handler *src_handler,
 				  unsigned int code, int *pval)
 {
 	bool is_mt_event;
@@ -206,13 +217,15 @@ static int input_handle_abs_event(struct input_dev *dev,
 	/* Flush pending "slot" event */
 	if (is_mt_event && dev->slot != input_abs_get_val(dev, ABS_MT_SLOT)) {
 		input_abs_set_val(dev, ABS_MT_SLOT, dev->slot);
-		input_pass_event(dev, EV_ABS, ABS_MT_SLOT, dev->slot);
+		input_pass_event(dev, src_handler,
+				 EV_ABS, ABS_MT_SLOT, dev->slot);
 	}
 
 	return INPUT_PASS_TO_HANDLERS;
 }
 
 static void input_handle_event(struct input_dev *dev,
+			       struct input_handler *src_handler,
 			       unsigned int type, unsigned int code, int value)
 {
 	int disposition = INPUT_IGNORE_EVENT;
@@ -265,7 +278,8 @@ static void input_handle_event(struct input_dev *dev,
 
 	case EV_ABS:
 		if (is_event_supported(code, dev->absbit, ABS_MAX))
-			disposition = input_handle_abs_event(dev, code, &value);
+			disposition = input_handle_abs_event(dev, src_handler,
+							     code, &value);
 
 		break;
 
@@ -323,7 +337,7 @@ static void input_handle_event(struct input_dev *dev,
 		dev->event(dev, type, code, value);
 
 	if (disposition & INPUT_PASS_TO_HANDLERS)
-		input_pass_event(dev, type, code, value);
+		input_pass_event(dev, src_handler, type, code, value);
 }
 
 /**
@@ -352,7 +366,7 @@ void input_event(struct input_dev *dev,
 
 		spin_lock_irqsave(&dev->event_lock, flags);
 		add_input_randomness(type, code, value);
-		input_handle_event(dev, type, code, value);
+		input_handle_event(dev, NULL, type, code, value);
 		spin_unlock_irqrestore(&dev->event_lock, flags);
 	}
 }
@@ -382,7 +396,8 @@ void input_inject_event(struct input_handle *handle,
 		rcu_read_lock();
 		grab = rcu_dereference(dev->grab);
 		if (!grab || grab == handle)
-			input_handle_event(dev, type, code, value);
+			input_handle_event(dev, handle->handler,
+					   type, code, value);
 		rcu_read_unlock();
 
 		spin_unlock_irqrestore(&dev->event_lock, flags);
@@ -595,10 +610,10 @@ static void input_dev_release_keys(struct input_dev *dev)
 		for (code = 0; code <= KEY_MAX; code++) {
 			if (is_event_supported(code, dev->keybit, KEY_MAX) &&
 			    __test_and_clear_bit(code, dev->key)) {
-				input_pass_event(dev, EV_KEY, code, 0);
+				input_pass_event(dev, NULL, EV_KEY, code, 0);
 			}
 		}
-		input_pass_event(dev, EV_SYN, SYN_REPORT, 1);
+		input_pass_event(dev, NULL, EV_SYN, SYN_REPORT, 1);
 	}
 }
 
@@ -873,9 +888,9 @@ int input_set_keycode(struct input_dev *dev,
 	    !is_event_supported(old_keycode, dev->keybit, KEY_MAX) &&
 	    __test_and_clear_bit(old_keycode, dev->key)) {
 
-		input_pass_event(dev, EV_KEY, old_keycode, 0);
+		input_pass_event(dev, NULL, EV_KEY, old_keycode, 0);
 		if (dev->sync)
-			input_pass_event(dev, EV_SYN, SYN_REPORT, 1);
+			input_pass_event(dev, NULL, EV_SYN, SYN_REPORT, 1);
 	}
 
  out:

--BXVAT5kNtrzKuDFl--
