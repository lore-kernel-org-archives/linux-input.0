From: Alan <alan@linux.intel.com>
Subject: [PATCH 3/3] goldfish: multitouch: no extra EV_SYN
Date: Fri, 26 Feb 2016 18:50:21 +0000
Message-ID: <20160226185007.3539.83946.stgit@localhost.localdomain>
References: <20160226184908.3539.48691.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:54662 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422988AbcBZSu3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 26 Feb 2016 13:50:29 -0500
In-Reply-To: <20160226184908.3539.48691.stgit@localhost.localdomain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org

From: Lingfeng Yang <lfy@google.com>

If we send SYN_REPORT on every single multi-touch event, it breaks the
multi-touch.

The multi-touch becomes jerky and you have to click 2-3 times to do things
while randomly activating notification bars when not clicking.

If we suppress these SYN_REPORTS, multi-touch will work fine and the events
will have a protocol that looks nice.

We need to register Goldfish Events as a multi-touch device by issuing
input_mt_init_slots, otherwise input_handle_abs_event in drivers/input/input.c
will silently drop all ABS_MT_SLOT events, causing touches of more than one
finger to fail.

Signed-off-by: Lingfeng Yang <lfy@google.com>
Signed-off-by: Jin Qian <jinqian@android.com>
Signed-off-by: Alan Cox <alan@linux.intel.com>
---
 drivers/input/keyboard/goldfish_events.c |   30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/goldfish_events.c b/drivers/input/keyboard/goldfish_events.c
index c7e308a..c0d77b7 100644
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
@@ -52,7 +55,23 @@ static irqreturn_t events_interrupt(int irq, void *dev_id)
 	value = __raw_readl(edev->addr + REG_READ);
 
 	input_event(edev->input, type, code, value);
-	input_sync(edev->input);
+	/*
+	 * Send an extra (EV_SYN, SYN_REPORT, 0x0) event
+	 * if a key was pressed. Some keyboard device
+	 * drivers may only send the EV_KEY event and
+	 * not EV_SYN.
+	 * Note that sending an extra SYN_REPORT is not
+	 * necessary nor correct protocol with other
+	 * devices such as touchscreens, which will send
+	 * their own SYN_REPORT's when sufficient event
+	 * information has been collected (e.g., for
+	 * touchscreens, when pressure and X/Y coordinates
+	 * have been received). Hence, we will only send
+	 * this extra SYN_REPORT if type == EV_KEY.
+	 */
+	if (type == EV_KEY)
+		input_sync(edev->input);
+
 	return IRQ_HANDLED;
 }
 
@@ -154,6 +173,15 @@ static int events_probe(struct platform_device *pdev)
 
 	input_dev->name = edev->name;
 	input_dev->id.bustype = BUS_HOST;
+	/*
+	 * Set the Goldfish Device to be multi-touch.
+	 * If we do not issue input_mt_init_slots,
+	 * the kernel will filter out needed ABS_MT_SLOT
+	 * events when we touch the screen in more than one place,
+	 * preventing multi-touch with more than one finger from working.
+	 * See drivers/input/input.c:input_handle_abs_event.
+	 */
+	input_mt_init_slots(input_dev, GOLDFISH_MAX_FINGERS, 0);
 
 	events_import_bits(edev, input_dev->evbit, EV_SYN, EV_MAX);
 	events_import_bits(edev, input_dev->keybit, EV_KEY, KEY_MAX);

