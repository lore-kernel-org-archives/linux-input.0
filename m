From: akpm@linux-foundation.org
Subject: [patch 13/22] input: allow certain EV_ABS events to bypass all filtering
Date: Wed, 04 Mar 2009 11:59:02 -0800
Message-ID: <200903041959.n24Jx2Zv028443@imap1.linux-foundation.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:40916 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753691AbZCDT7g (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 4 Mar 2009 14:59:36 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dtor@mail.ru
Cc: linux-input@vger.kernel.org, akpm@linux-foundation.org, rydberg@euromail.se

From: Henrik Rydberg <rydberg@euromail.se>

With the upcoming multi-touch interface as an example, there is a need to
make certain that all reported events actually get passed to the event
handler.  This patch equips the input core with the ability to bypass all
filtering for certain EV_ABS events.

Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dtor@mail.ru>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/input/input.c |   23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff -puN drivers/input/input.c~input-allow-certain-ev_abs-events-to-bypass-all-filtering drivers/input/input.c
--- a/drivers/input/input.c~input-allow-certain-ev_abs-events-to-bypass-all-filtering
+++ a/drivers/input/input.c
@@ -29,6 +29,13 @@ MODULE_LICENSE("GPL");
 
 #define INPUT_DEVICES	256
 
+/*
+ * EV_ABS events which should not be cached are listed here.
+ */
+static __initdata unsigned int input_abs_bypass_init_data[] = {
+	0
+};
+
 static LIST_HEAD(input_dev_list);
 static LIST_HEAD(input_handler_list);
 
@@ -42,6 +49,8 @@ static DEFINE_MUTEX(input_mutex);
 
 static struct input_handler *input_table[8];
 
+static unsigned long input_abs_bypass[BITS_TO_LONGS(ABS_CNT)];
+
 static inline int is_event_supported(unsigned int code,
 				     unsigned long *bm, unsigned int max)
 {
@@ -192,6 +201,11 @@ static void input_handle_event(struct in
 	case EV_ABS:
 		if (is_event_supported(code, dev->absbit, ABS_MAX)) {
 
+			if (test_bit(code, input_abs_bypass)) {
+				disposition = INPUT_PASS_TO_HANDLERS;
+				break;
+			}
+
 			value = input_defuzz_abs_event(value,
 					dev->abs[code], dev->absfuzz[code]);
 
@@ -1635,10 +1649,19 @@ static const struct file_operations inpu
 	.open = input_open_file,
 };
 
+static void __init input_init_abs_bypass()
+{
+	const unsigned int *p;
+	for (p = input_abs_bypass_init_data; *p; p++)
+		input_abs_bypass[BIT_WORD(*p)] |= BIT_MASK(*p);
+}
+
 static int __init input_init(void)
 {
 	int err;
 
+	input_init_abs_bypass();
+
 	err = class_register(&input_class);
 	if (err) {
 		printk(KERN_ERR "input: unable to register input_dev class\n");
_
