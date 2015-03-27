From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] input: keypad: tc3589x: localize platform data
Date: Fri, 27 Mar 2015 09:47:44 -0700
Message-ID: <20150327164744.GA17364@dtor-ws>
References: <1426776765-18812-1-git-send-email-linus.walleij@linaro.org>
 <1426776765-18812-2-git-send-email-linus.walleij@linaro.org>
 <20150319163856.GF30732@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:34352 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751061AbbC0Qrt (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 27 Mar 2015 12:47:49 -0400
Content-Disposition: inline
In-Reply-To: <20150319163856.GF30732@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org

On Thu, Mar 19, 2015 at 09:38:56AM -0700, Dmitry Torokhov wrote:
> Hi Linus,
> 
> On Thu, Mar 19, 2015 at 03:52:44PM +0100, Linus Walleij wrote:
> > This driver can only get its platform data from the device tree,
> > and all platforms using it does that. Localize the platform data
> > for the keypad. A later patch will enforce the device tree / OF
> > dependence.
> > 
> > Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > Cc: Lee Jones <lee.jones@linaro.org>
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> > ---
> > Dmitry it would be great if you could ACK this patch so Lee can
> > take it with the other patch through MFD.
> 
> It looks like if you are making this OF-only you can get rid of pdata
> altogether and parse the OF data directly into the keypad. But that can
> be done later.
> 
> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Hmm, just noticed an issue:

> >  
> >  	keypad = kzalloc(sizeof(struct tc_keypad), GFP_KERNEL);
> > +	keypad->board = tc3589x_keypad_of_probe(&pdev->dev);
> > +	if (IS_ERR(keypad->board)) {
> > +		dev_err(&pdev->dev, "invalid keypad platform data\n");
> > +		return PTR_ERR(keypad->board);
> > +	}
> > +
> >  	input = input_allocate_device();
> >  	if (!keypad || !input) {
> >  		dev_err(&pdev->dev, "failed to allocate keypad memory\n");

You slid of prasing right in between memory allocation and checking if
it succeeded, so there is a potential oops and memory leak now.

I want to commit the version of the patch below, holler if you disagree.
Note that I reverted much of plat -> board renames to keep the patch
small.

Thanks.

-- 
Dmitry


Input: tc3589x - localize platform data

From: Linus Walleij <linus.walleij@linaro.org>

This driver can only get its platform data from the device tree, and all
platforms using it do that. Localize the platform data for the keypad. A
later patch will enforce the device tree / OF dependence.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/keyboard/tc3589x-keypad.c |   33 ++++++++++++++++++++++++-------
 include/linux/mfd/tc3589x.h             |   23 ----------------------
 2 files changed, 26 insertions(+), 30 deletions(-)

diff --git a/drivers/input/keyboard/tc3589x-keypad.c b/drivers/input/keyboard/tc3589x-keypad.c
index 5639325..ae90df3 100644
--- a/drivers/input/keyboard/tc3589x-keypad.c
+++ b/drivers/input/keyboard/tc3589x-keypad.c
@@ -70,6 +70,28 @@
 #define TC3589x_KBD_INT_CLR	0x1
 
 /**
+ * struct tc35893_keypad_platform_data - platform specific keypad data
+ * @keymap_data:        matrix scan code table for keycodes
+ * @krow:               mask for available rows, value is 0xFF
+ * @kcol:               mask for available columns, value is 0xFF
+ * @debounce_period:    platform specific debounce time
+ * @settle_time:        platform specific settle down time
+ * @irqtype:            type of interrupt, falling or rising edge
+ * @enable_wakeup:      specifies if keypad event can wake up system from sleep
+ * @no_autorepeat:      flag for auto repetition
+ */
+struct tc3589x_keypad_platform_data {
+	const struct matrix_keymap_data *keymap_data;
+	u8                      krow;
+	u8                      kcol;
+	u8                      debounce_period;
+	u8                      settle_time;
+	unsigned long           irqtype;
+	bool                    enable_wakeup;
+	bool                    no_autorepeat;
+};
+
+/**
  * struct tc_keypad - data structure used by keypad driver
  * @tc3589x:    pointer to tc35893
  * @input:      pointer to input device object
@@ -363,13 +385,10 @@ static int tc3589x_keypad_probe(struct platform_device *pdev)
 	const struct tc3589x_keypad_platform_data *plat;
 	int error, irq;
 
-	plat = tc3589x->pdata->keypad;
-	if (!plat) {
-		plat = tc3589x_keypad_of_probe(&pdev->dev);
-		if (IS_ERR(plat)) {
-			dev_err(&pdev->dev, "invalid keypad platform data\n");
-			return PTR_ERR(plat);
-		}
+	plat = tc3589x_keypad_of_probe(&pdev->dev);
+	if (IS_ERR(plat)) {
+		dev_err(&pdev->dev, "invalid keypad platform data\n");
+		return PTR_ERR(plat);
 	}
 
 	irq = platform_get_irq(pdev, 0);
diff --git a/include/linux/mfd/tc3589x.h b/include/linux/mfd/tc3589x.h
index c203c9c..468c31a 100644
--- a/include/linux/mfd/tc3589x.h
+++ b/include/linux/mfd/tc3589x.h
@@ -140,36 +140,13 @@ extern int tc3589x_set_bits(struct tc3589x *tc3589x, u8 reg, u8 mask, u8 val);
 #define TC_KPD_DEBOUNCE_PERIOD  0xA3
 #define TC_KPD_SETTLE_TIME      0xA3
 
-/**
- * struct tc35893_platform_data - data structure for platform specific data
- * @keymap_data:        matrix scan code table for keycodes
- * @krow:               mask for available rows, value is 0xFF
- * @kcol:               mask for available columns, value is 0xFF
- * @debounce_period:    platform specific debounce time
- * @settle_time:        platform specific settle down time
- * @irqtype:            type of interrupt, falling or rising edge
- * @enable_wakeup:      specifies if keypad event can wake up system from sleep
- * @no_autorepeat:      flag for auto repetition
- */
-struct tc3589x_keypad_platform_data {
-	const struct matrix_keymap_data *keymap_data;
-	u8                      krow;
-	u8                      kcol;
-	u8                      debounce_period;
-	u8                      settle_time;
-	unsigned long           irqtype;
-	bool                    enable_wakeup;
-	bool                    no_autorepeat;
-};
 
 /**
  * struct tc3589x_platform_data - TC3589x platform data
  * @block: bitmask of blocks to enable (use TC3589x_BLOCK_*)
- * @keypad: keypad-specific platform data
  */
 struct tc3589x_platform_data {
 	unsigned int block;
-	const struct tc3589x_keypad_platform_data *keypad;
 };
 
 #endif
