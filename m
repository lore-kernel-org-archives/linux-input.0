From: Jason Wessel <jason.wessel@windriver.com>
Subject: Re: [Nouveau] [PATCH] drm/nouveau/kms: Implement KDB debug hooks
 for nouveau KMS.
Date: Tue, 05 Oct 2010 15:56:18 -0500
Message-ID: <4CAB90F2.3090503@windriver.com>
References: <1283335002.2741.5.camel@maxim-laptop> <4C7E3A73.5070503@windriver.com> <1283424363.2736.1.camel@maxim-laptop> <1285119735.5949.5.camel@maxim-laptop> <1285164198.3159.8.camel@maxim-laptop> <1285164387.3159.10.camel@maxim-laptop> <1285175225.2960.10.camel@maxim-laptop> <1285361406.4509.0.camel@maxim-laptop> <4C9D10F3.10105@windriver.com> <1285373672.26629.8.camel@maxim-laptop> <20100925040824.GB25773@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080607040806090009020800"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:59087 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755401Ab0JEU4g (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 5 Oct 2010 16:56:36 -0400
In-Reply-To: <20100925040824.GB25773@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Maxim Levitsky <maximlevitsky@gmail.com>
Cc: Chris Ball <cjb@laptop.org>, kgdb-bugreport@lists.sourceforge.net, linux-input <linux-input@vger.kernel.org>

This is a multi-part message in MIME format.
--------------080607040806090009020800
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On 09/24/2010 11:08 PM, Dmitry Torokhov wrote:
> On Sat, Sep 25, 2010 at 02:14:32AM +0200, Maxim Levitsky wrote:
>   
>> On Fri, 2010-09-24 at 15:58 -0500, Jason Wessel wrote:
>>     
>>> On 09/24/2010 03:50 PM, Maxim Levitsky wrote:
>>>       
>>>>   
>>>>         
>>>>> [Dropped nouveau list, because this is offtopic there]
>>>>>
>>>>> I pretty much got to the bottom of this.
>>>>> There are 2 separate issues:
>>>>>
>>>>>
>>>>> 1. SysRq handler is now a input 'filter', which means that it can 'eat'
>>>>> input events, so they don't show up on input bus.
>>>>> It does so while sysrq key is down.
>>>>> So sysrq and 'g' events never reach the kernel kbd driver and therefore
>>>>> the hack to release them doesn't work.
>>>>>
>>>>> 2. The kbd_clear_keys_helper injects the keyup events alright, but it
>>>>> doesn't inject SYN events, and therefore X evdev driver doesn't pick
>>>>> these injected events untill next SYN event. 
>>>>>
>>>>> This patch makes key release work in expense of showing sysrq key to userspace, which isn't that good,
>>>>> because now Alt+SysRQ causes a screen capture by default.
>>>>> In my opinion the sysrq filter should stay.
>>>>> We should just make kdb hook into atkbd and do the key release there.
>>>>> This should both result in cleaner/more robust code, and make this issue disappear.
>>>>> I'll look at doing that.
>>>>>
>>>>>
>>>>> diff --git a/drivers/char/keyboard.c b/drivers/char/keyboard.c
>>>>> index 0c6c641..7df6af5 100644
>>>>> --- a/drivers/char/keyboard.c
>>>>> +++ b/drivers/char/keyboard.c
>>>>> @@ -368,6 +368,7 @@ static int kbd_clear_keys_helper(struct input_handle *handle, void *data)
>>>>>  {
>>>>>  	unsigned int *keycode = data;
>>>>>  	input_inject_event(handle, EV_KEY, *keycode, 0);
>>>>> +	input_inject_event(handle, EV_SYN, SYN_REPORT, 0);
>>>>>  	return 0;
>>>>>  }
>>>>>           

So I kept this piece, in the 0002 patch which is attached.   I revised
the keyboard/input series at:

http://git.kernel.org/?p=linux/kernel/git/jwessel/linux-2.6-kgdb.git;a=shortlog;h=refs/heads/for_input

>>>>>  
>>>>> diff --git a/drivers/char/sysrq.c b/drivers/char/sysrq.c
>>>>> index ef31bb8..db1eb12 100644
>>>>> --- a/drivers/char/sysrq.c
>>>>> +++ b/drivers/char/sysrq.c
>>>>> @@ -601,7 +601,7 @@ static bool sysrq_filter(struct input_handle *handle, unsigned int type,
>>>>>  	}
>>>>>  
>>>>>  out:
>>>>> -	return sysrq_down;
>>>>> +	return 0;
>>>>>  }
>>>>>           

I took some time to look more closely at the problem, and I believe we
still want to filter out all these input events.

>   
>> The right solution in my opinion is to make atkbd register with kgdb and
>> provide to it, the polling keyboard IO services, and also take care of
>> releasing the keys as soon as debug mode is entered or exited.
>>     
>
> Disagree. We may support different keyboard devices with kdb or use one
> keyboard (USB) to drop into debugger and then switch to atkbd...
>
> I think we need to move Jason's code from drivers/char/keyboard.c to
> drivers/char/sysrq.c and have it track keys that have been kept pressed
> before entering sysrq mode and release them when leaving the mode.
>
> We also need to teach sysrq that some handlers need resetting of the
> keyboard state.
>
>   

I found the root of the problem was the low level keyboard bit mask
getting out of sync in the input layer.   Perhaps Dmitry can have a look
at the 3rd patch in the series, which addresses the problem.  

I also put these patches into kgdb-next.

I believe it fixes the problems Maxim encountered, or at least the
problems I observed independently with stuck keys and the lack of the
ability to correctly use alt-PrintScreen.

If you are willing Maxim, can you give these patches a go?

Thanks,
Jason.

--------------080607040806090009020800
Content-Type: text/x-diff;
 name="0001-keyboard-kgdboc-Allow-key-release-on-kernel-resume.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0001-keyboard-kgdboc-Allow-key-release-on-kernel-resume.patc";
 filename*1="h"

>From ed6fb201ca864e977c6a4fcf345014fd1d4ebed4 Mon Sep 17 00:00:00 2001
From: Jason Wessel <jason.wessel@windriver.com>
Date: Sun, 26 Sep 2010 06:33:36 -0500
Subject: [PATCH 1/3] keyboard,kgdboc: Allow key release on kernel resume

When using a keyboard with kdb, a hook point to free all the
keystrokes is required for resuming kernel operations.

This is mainly because there is no way to force the end user to hold
down the original keys that were pressed prior to entering kdb when
resuming the kernel.

The kgdboc driver will call kbd_dbg_clear_keys() just prior to
resuming the kernel execution which will schedule a callback to clear
any keys which were depressed prior to the entering the kernel
debugger.

CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC: Greg Kroah-Hartman <gregkh@suse.de>
CC: linux-input@vger.kernel.org
Signed-off-by: Jason Wessel <jason.wessel@windriver.com>
---
 drivers/char/keyboard.c  |   37 +++++++++++++++++++++++++++++++++++++
 drivers/serial/kgdboc.c  |   13 +++++++++++++
 include/linux/kbd_kern.h |    1 +
 3 files changed, 51 insertions(+), 0 deletions(-)

diff --git a/drivers/char/keyboard.c b/drivers/char/keyboard.c
index a7ca752..0c6c641 100644
--- a/drivers/char/keyboard.c
+++ b/drivers/char/keyboard.c
@@ -363,6 +363,43 @@ static void to_utf8(struct vc_data *vc, uint c)
 	}
 }
 
+#ifdef CONFIG_KDB_KEYBOARD
+static int kbd_clear_keys_helper(struct input_handle *handle, void *data)
+{
+	unsigned int *keycode = data;
+	input_inject_event(handle, EV_KEY, *keycode, 0);
+	return 0;
+}
+
+static void kbd_clear_keys_callback(struct work_struct *dummy)
+{
+	unsigned int i, j, k;
+
+	for (i = 0; i < ARRAY_SIZE(key_down); i++) {
+		if (!key_down[i])
+			continue;
+
+		k = i * BITS_PER_LONG;
+
+		for (j = 0; j < BITS_PER_LONG; j++, k++) {
+			if (!test_bit(k, key_down))
+				continue;
+			input_handler_for_each_handle(&kbd_handler, &k,
+				      kbd_clear_keys_helper);
+		}
+	}
+}
+
+static DECLARE_WORK(kbd_clear_keys_work, kbd_clear_keys_callback);
+
+/* Called to clear any key presses after resuming the kernel. */
+void kbd_dbg_clear_keys(void)
+{
+	schedule_work(&kbd_clear_keys_work);
+}
+EXPORT_SYMBOL_GPL(kbd_dbg_clear_keys);
+#endif /* CONFIG_KDB_KEYBOARD */
+
 /*
  * Called after returning from RAW mode or when changing consoles - recompute
  * shift_down[] and shift_state from key_down[] maybe called when keymap is
diff --git a/drivers/serial/kgdboc.c b/drivers/serial/kgdboc.c
index 39f9a1a..62b6edc 100644
--- a/drivers/serial/kgdboc.c
+++ b/drivers/serial/kgdboc.c
@@ -18,6 +18,7 @@
 #include <linux/tty.h>
 #include <linux/console.h>
 #include <linux/vt_kern.h>
+#include <linux/kbd_kern.h>
 
 #define MAX_CONFIG_LEN		40
 
@@ -37,12 +38,16 @@ static struct tty_driver	*kgdb_tty_driver;
 static int			kgdb_tty_line;
 
 #ifdef CONFIG_KDB_KEYBOARD
+static bool			kgdboc_use_kbd;
+
 static int kgdboc_register_kbd(char **cptr)
 {
+	kgdboc_use_kbd = false;
 	if (strncmp(*cptr, "kbd", 3) == 0) {
 		if (kdb_poll_idx < KDB_POLL_FUNC_MAX) {
 			kdb_poll_funcs[kdb_poll_idx] = kdb_get_kbd_char;
 			kdb_poll_idx++;
+			kgdboc_use_kbd = true;
 			if (cptr[0][3] == ',')
 				*cptr += 4;
 			else
@@ -65,9 +70,16 @@ static void kgdboc_unregister_kbd(void)
 		}
 	}
 }
+
+static inline void kgdboc_clear_kbd(void)
+{
+	if (kgdboc_use_kbd)
+		kbd_dbg_clear_keys(); /* Release all pressed keys */
+}
 #else /* ! CONFIG_KDB_KEYBOARD */
 #define kgdboc_register_kbd(x) 0
 #define kgdboc_unregister_kbd()
+#define kgdboc_clear_kbd()
 #endif /* ! CONFIG_KDB_KEYBOARD */
 
 static int kgdboc_option_setup(char *opt)
@@ -231,6 +243,7 @@ static void kgdboc_post_exp_handler(void)
 		dbg_restore_graphics = 0;
 		con_debug_leave();
 	}
+	kgdboc_clear_kbd();
 }
 
 static struct kgdb_io kgdboc_io_ops = {
diff --git a/include/linux/kbd_kern.h b/include/linux/kbd_kern.h
index 506ad20..ae87c0a 100644
--- a/include/linux/kbd_kern.h
+++ b/include/linux/kbd_kern.h
@@ -144,6 +144,7 @@ struct console;
 int getkeycode(unsigned int scancode);
 int setkeycode(unsigned int scancode, unsigned int keycode);
 void compute_shiftstate(void);
+void kbd_dbg_clear_keys(void);
 
 /* defkeymap.c */
 
-- 
1.6.3.3


--------------080607040806090009020800
Content-Type: text/x-diff;
 name="0002-keyboard-kdb-inject-SYN-events-in-kbd_clear_keys_hel.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0002-keyboard-kdb-inject-SYN-events-in-kbd_clear_keys_hel.pa";
 filename*1="tch"

>From 43eb157cdf4213e8b7792746e7d11afec2309205 Mon Sep 17 00:00:00 2001
From: Maxim Levitsky <maximlevitsky@gmail.com>
Date: Wed, 22 Sep 2010 10:07:05 -0700
Subject: [PATCH 2/3] keyboard,kdb: inject SYN events in kbd_clear_keys_helper

The kbd_clear_keys_helper injects the keyup events alright, but it
doesn't inject SYN events, and therefore X evdev driver doesn't pick
these injected events untill next SYN event.

Signed-off-by: Maxim Levitsky <maximlevitsky@gmail.com>
Signed-off-by: Jason Wessel <jason.wessel@windriver.com>
---
 drivers/char/keyboard.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/char/keyboard.c b/drivers/char/keyboard.c
index 0c6c641..7df6af5 100644
--- a/drivers/char/keyboard.c
+++ b/drivers/char/keyboard.c
@@ -368,6 +368,7 @@ static int kbd_clear_keys_helper(struct input_handle *handle, void *data)
 {
 	unsigned int *keycode = data;
 	input_inject_event(handle, EV_KEY, *keycode, 0);
+	input_inject_event(handle, EV_SYN, SYN_REPORT, 0);
 	return 0;
 }
 
-- 
1.6.3.3


--------------080607040806090009020800
Content-Type: text/x-diff;
 name="0003-sysrq-keyboard-properly-deal-with-alt-sysrq-in-sysrq.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0003-sysrq-keyboard-properly-deal-with-alt-sysrq-in-sysrq.pa";
 filename*1="tch"

>From 33dea0e730e03814f0cd71c604185ba1c7fad51d Mon Sep 17 00:00:00 2001
From: Jason Wessel <jason.wessel@windriver.com>
Date: Tue, 5 Oct 2010 14:38:36 -0500
Subject: [PATCH 3/3] sysrq,keyboard: properly deal with alt-sysrq in sysrq input filter

This patch addresses 2 problems:

1) You should still be able to use alt-PrintScreen to capture a grab
   of a single window when the sysrq filter is active.

2) The sysrq filter should reset the low level key mask so that future
   key presses will not show up as a repeated key.  The problem was
   that when you executed alt-sysrq g and then resumed the kernel, you
   would have to press 'g' twice to get it working again.

CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC: Greg Kroah-Hartman <gregkh@suse.de>
CC: linux-input@vger.kernel.org
Reported-by: Maxim Levitsky <maximlevitsky@gmail.com>
Signed-off-by: Jason Wessel <jason.wessel@windriver.com>
---
 drivers/char/sysrq.c |   64 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 61 insertions(+), 3 deletions(-)

diff --git a/drivers/char/sysrq.c b/drivers/char/sysrq.c
index ef31bb8..9b97aad 100644
--- a/drivers/char/sysrq.c
+++ b/drivers/char/sysrq.c
@@ -566,6 +566,57 @@ static const unsigned char sysrq_xlate[KEY_MAX + 1] =
 static bool sysrq_down;
 static int sysrq_alt_use;
 static int sysrq_alt;
+static bool sysrq_kbd_triggered;
+
+/*
+ * This function was a copy of input_pass_event but modified to allow
+ * by-passing a specific filter, to allow for injected events without
+ * filter recursion.
+ */
+static void input_pass_event_ignore(struct input_dev *dev,
+			     unsigned int type, unsigned int code, int value,
+			     struct input_handle *ignore_handle)
+{
+	struct input_handler *handler;
+	struct input_handle *handle;
+
+	rcu_read_lock();
+
+	handle = rcu_dereference(dev->grab);
+	if (handle)
+		handle->handler->event(handle, type, code, value);
+	else {
+		bool filtered = false;
+
+		list_for_each_entry_rcu(handle, &dev->h_list, d_node) {
+			if (!handle->open || handle == ignore_handle)
+				continue;
+			handler = handle->handler;
+			if (!handler->filter) {
+				if (filtered)
+					break;
+
+				handler->event(handle, type, code, value);
+
+			} else if (handler->filter(handle, type, code, value))
+				filtered = true;
+		}
+	}
+
+	rcu_read_unlock();
+}
+
+/*
+ * Pass along alt-print_screen, if there was no sysrq processing by
+ * sending a key press down and then passing the key up event.
+ */
+static void simulate_alt_sysrq(struct input_handle *handle)
+{
+	input_pass_event_ignore(handle->dev, EV_KEY, KEY_SYSRQ, 1, handle);
+	input_pass_event_ignore(handle->dev, EV_SYN, SYN_REPORT, 0, handle);
+	input_pass_event_ignore(handle->dev, EV_KEY, KEY_SYSRQ, 0, handle);
+	input_pass_event_ignore(handle->dev, EV_SYN, SYN_REPORT, 0, handle);
+}
 
 static bool sysrq_filter(struct input_handle *handle, unsigned int type,
 		         unsigned int code, int value)
@@ -580,9 +631,11 @@ static bool sysrq_filter(struct input_handle *handle, unsigned int type,
 		if (value)
 			sysrq_alt = code;
 		else {
-			if (sysrq_down && code == sysrq_alt_use)
+			if (sysrq_down && code == sysrq_alt_use) {
 				sysrq_down = false;
-
+				if (!sysrq_kbd_triggered)
+					simulate_alt_sysrq(handle);
+			}
 			sysrq_alt = 0;
 		}
 		break;
@@ -590,13 +643,18 @@ static bool sysrq_filter(struct input_handle *handle, unsigned int type,
 	case KEY_SYSRQ:
 		if (value == 1 && sysrq_alt) {
 			sysrq_down = true;
+			sysrq_kbd_triggered = false;
 			sysrq_alt_use = sysrq_alt;
 		}
 		break;
 
 	default:
-		if (sysrq_down && value && value != 2)
+		if (sysrq_down && value && value != 2 && !sysrq_kbd_triggered) {
+			sysrq_kbd_triggered = true;
 			__handle_sysrq(sysrq_xlate[code], true);
+			/* Clear any handled keys from being flagged as a repeated stroke */
+			__clear_bit(code, handle->dev->key);
+		}
 		break;
 	}
 
-- 
1.6.3.3


--------------080607040806090009020800--
