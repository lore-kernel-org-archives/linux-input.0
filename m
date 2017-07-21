From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Subject: [PATCH v3 01/16] input: goldfish: Fix multitouch event handling
Date: Fri, 21 Jul 2017 16:08:59 +0200
Message-ID: <1500646206-2436-2-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1500646206-2436-1-git-send-email-aleksandar.markovic@rt-rk.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1500646206-2436-1-git-send-email-aleksandar.markovic@rt-rk.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mips@linux-mips.org
Cc: Lingfeng Yang <lfy@google.com>, Miodrag Dinic <miodrag.dinic@imgtec.com>, Goran Ferenc <goran.ferenc@imgtec.com>, Aleksandar Markovic <aleksandar.markovic@imgtec.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Douglas Leung <douglas.leung@imgtec.com>, Henrik Rydberg <rydberg@bitmath.org>, James Hogan <james.hogan@imgtec.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Paul Burton <paul.burton@imgtec.com>, Petar Jovanovic <petar.jovanovic@imgtec.com>, Raghu Gandham <raghu.gandham@imgtec.com>
List-Id: linux-input@vger.kernel.org

From: Lingfeng Yang <lfy@google.com>

Register Goldfish Events device properly as a multitouch device,
and send SYN_REPORT event in appropriate cases only.

If SYN_REPORT is sent on every single multitouch event, it breaks
the multitouch. The multitouch becomes janky and having to click
2-3 times to do stuff (plus randomly activating notification bars
when not clicking). If these SYN_REPORT events are supreessed,
multitouch will work fine, plus the events will have a protocol
that looks nice.

In addition, Goldfish Events device needs to be registerd as a
multitouch device by issuing input_mt_init_slots. Otherwise,
input_handle_abs_event in drivers/input/input.c will silently drop
all ABS_MT_SLOT events, causing touches with more than one finger
not to work properly.

Signed-off-by: Lingfeng Yang <lfy@google.com>
Signed-off-by: Miodrag Dinic <miodrag.dinic@imgtec.com>
Signed-off-by: Goran Ferenc <goran.ferenc@imgtec.com>
Signed-off-by: Aleksandar Markovic <aleksandar.markovic@imgtec.com>
---
 drivers/input/keyboard/goldfish_events.c | 35 +++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/goldfish_events.c b/drivers/input/keyboard/goldfish_events.c
index f6e643b..bc3e8b3 100644
--- a/drivers/input/keyboard/goldfish_events.c
+++ b/drivers/input/keyboard/goldfish_events.c
@@ -17,6 +17,7 @@
 #include <linux/interrupt.h>
 #include <linux/types.h>
 #include <linux/input.h>
+#include <linux/input/mt.h>
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
@@ -24,6 +25,8 @@
 #include <linux/io.h>
 #include <linux/acpi.h>
 
+#define GOLDFISH_MAX_FINGERS 5
+
 enum {
 	REG_READ        = 0x00,
 	REG_SET_PAGE    = 0x00,
@@ -52,7 +55,22 @@ static irqreturn_t events_interrupt(int irq, void *dev_id)
 	value = __raw_readl(edev->addr + REG_READ);
 
 	input_event(edev->input, type, code, value);
-	input_sync(edev->input);
+
+	/*
+	 * Send an extra (EV_SYN, SYN_REPORT, 0x0) event only if a key
+	 * was pressed. Some keyboard device drivers may only send the
+	 * EV_KEY event and not the EV_SYN event.
+	 *
+	 * Note that sending an extra SYN_REPORT is not necessary nor
+	 * correct protocol with other devices such as touchscreens,
+	 * which will send their own SYN_REPORTs when sufficient event
+	 * event information has been collected (for example, in case
+	 * touchscreens, when pressure and X/Y coordinates have been
+	 * received). Hence, we will only send this extra SYN_REPORT
+	 * if type == EV_KEY.
+	 */
+	if (type == EV_KEY)
+		input_sync(edev->input);
 	return IRQ_HANDLED;
 }
 
@@ -155,6 +173,21 @@ static int events_probe(struct platform_device *pdev)
 	input_dev->name = edev->name;
 	input_dev->id.bustype = BUS_HOST;
 
+	/*
+	 * Set the Goldfish Device to be multitouch.
+	 *
+	 * In the Ranchu kernel, there is multitouch-specific code for
+	 * handling ABS_MT_SLOT events (see file drivers/input/input.c,
+	 * function input_handle_abs_event). If we do not issue
+	 * input_mt_init_slots, the kernel will filter out needed
+	 * ABS_MT_SLOT events when we touch the screen in more than one
+	 * place, preventing multitouch with more than one finger from
+	 * working.
+	 */
+	error = input_mt_init_slots(input_dev, GOLDFISH_MAX_FINGERS, 0);
+	if (error)
+		return error;
+
 	events_import_bits(edev, input_dev->evbit, EV_SYN, EV_MAX);
 	events_import_bits(edev, input_dev->keybit, EV_KEY, KEY_MAX);
 	events_import_bits(edev, input_dev->relbit, EV_REL, REL_MAX);
-- 
2.7.4
