From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC/RFT] Reinject Alt+SysRq when no hotkeys have been pressed
Date: Thu, 11 Nov 2010 00:55:48 -0800
Message-ID: <20101111085548.GF24415@core.coreip.homeip.net>
References: <20101109073416.GA14110@core.coreip.homeip.net>
 <4CDAFCE0.60002@windriver.com>
 <201011101227.51837.dmitry.torokhov@gmail.com>
 <4CDB03F3.3000006@windriver.com>
 <20101111014240.GF2121@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:38412 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757842Ab0KKIz4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 11 Nov 2010 03:55:56 -0500
Received: by iwn10 with SMTP id 10so1901678iwn.19
        for <linux-input@vger.kernel.org>; Thu, 11 Nov 2010 00:55:55 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101111014240.GF2121@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Wessel <jason.wessel@windriver.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Maxim Levitsky <maximlevitsky@gmail.com>

On Wed, Nov 10, 2010 at 05:42:41PM -0800, Dmitry Torokhov wrote:
> On Wed, Nov 10, 2010 at 02:43:31PM -0600, Jason Wessel wrote:
> > On 11/10/2010 02:27 PM, Dmitry Torokhov wrote:
> > > On Wednesday, November 10, 2010 12:13:20 pm Jason Wessel wrote:
> > >> On 11/09/2010 01:34 AM, Dmitry Torokhov wrote:
> > >>> Now that KGDB knows how to release keys that have been pressed when
> > >>> entering the debugger the only issue left is that SysRq handler is too
> > >>> greedy and always swallows Alt+SysRq, causing print screen hotkey to
> > >>> stop working. The solution is to re-inject the key combo when user
> > >>> releases SysRq without pressing any other keys. The patch below does
> > >>> just that and also releases keys that have been pressed before we enter
> > >>> SysRq mode.
> > >>>
> > >>> Note that it depends on a patch to input core that will stop events
> > >>> injected by one input handler from reaching the very same input handler
> > >>> (attached).
> > >>>
> > >>> Comments/testing/suggestion are sought after.
> > >> I applied both patches and tested all the known failures cases I had on
> > >> my list and it looks good, for the non kdb cases.
> > >>
> > >> Tested-by: Jason Wessel <jason.wessel@windriver.com>
> > >>
> > 
> > >> However...  I also tested this with the kdb keyboard release
> > >> patches plus your latest 2 patches and we appear to have an
> > >> incompatibility.  The behavior is that when exiting kdb the print
> > >> screen trigger fires.  I had not had a chance to debug it as of
> > >> yet.
> > >>
> > >
> > > Hmm, let me think...
> > >
> > 
> > So I debugged it.  The key up events are peeled off in linear order
> > with the kdb release key code.
> > 
> > The sequence looks like this
> > 
> > down - alt
> > down - printScr
> > down - g           <-- Enters kdb
> > 
> > The kdb release code simulates the events
> > up - g
> > up - alt
> > up - printScr
> > 
> > That tells me we have something bad about the key events going on, or
> > that we care about release ordering in the release handler.
> > 
> 
> Ah, I see. I bet the shortcut for print screen is actually triggered on
> _release_ and X drivers do not filter release events for which they have
> not seen presses. Oh well...
> 
> Coudl you try sticking somethgin like this into sysrq code?
> 
> 	case KEY_SYSRQ:
> 
> 		if (value == 1 ... ) {
> 			....
> 		}
> 
> 		if (sysrq->active)
> 			clear_bit(KEY_SYSRQ, handle->dev->key);
> 
> 
> This is a bit dirty but sysrq is pretty special anyways...
> 

I think below should handle this.

Thanks.

-- 
Dmitry


Input: sysrq - pass along lone Alt + SysRq

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

When user presses and releases Alt + SysRq without pressing any of the
hot keys re-inject the combination and pass it on to userspace instead
of suppressing it - maybe he or she wanted to take print screen
instead of invoking SysRq handler.

Also pass along release events for keys that have been pressed before
SysRq mode has been invoked so that keys do not appear to be "stuck".

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/tty/sysrq.c |  169 +++++++++++++++++++++++++++++++++++++--------------
 1 files changed, 124 insertions(+), 45 deletions(-)


diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index eaa5d3e..c556ed9 100644
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
@@ -563,53 +563,129 @@ static const unsigned char sysrq_xlate[KEY_MAX + 1] =
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
+
+			/*
+			 * Pretend that sysrq was never pressed at all. This
+			 * is needed to properly handle KGDB which will try
+			 * to release all keys after exiting debugger. If we
+			 * do not clear key bit it KGDB will end up sending
+			 * release events for Alt and SysRq, potentially
+			 * triggering print screen function.
+			 */
+			if (sysrq->active)
+				clear_bit(KEY_SYSRQ, handle->dev->key);
+
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
 
@@ -617,28 +693,28 @@ static int sysrq_connect(struct input_handler *handler,
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
@@ -647,17 +723,20 @@ static int sysrq_connect(struct input_handler *handler,
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
