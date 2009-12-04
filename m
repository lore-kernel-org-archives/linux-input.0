From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 3/9] Input: dm355evm_kbd - switch to using sparse keymap
	library
Date: Thu, 03 Dec 2009 22:12:09 -0800
Message-ID: <20091204061208.28288.16716.stgit@localhost.localdomain>
References: <20091204060701.28288.91430.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20091204060701.28288.91430.stgit@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Herton Ronaldo Krzesinski <herton@mandriva.com.br>, Harald Welte <laforge@gnumonks.org>, Corentin Chary <corentincj@iksaif.net>, Carlos Corbacho <carlos@strangeworlds.co.uk>, Wu Zhangjin <wuzhangjin@gmail.com>, Anisse Astier <anisse@astier.eu>
List-Id: linux-input@vger.kernel.org

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/misc/Kconfig         |    1 
 drivers/input/misc/dm355evm_keys.c |  150 +++++++++++++-----------------------
 2 files changed, 57 insertions(+), 94 deletions(-)

diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index d25ecbb..16ec523 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -282,6 +282,7 @@ config INPUT_RB532_BUTTON
 config INPUT_DM355EVM
 	tristate "TI DaVinci DM355 EVM Keypad and IR Remote"
 	depends on MFD_DM355EVM_MSP
+	select INPUT_SPARSEKMAP
 	help
 	  Supports the pushbuttons and IR remote used with
 	  the DM355 EVM board.
diff --git a/drivers/input/misc/dm355evm_keys.c b/drivers/input/misc/dm355evm_keys.c
index f2b67dc..09a2815 100644
--- a/drivers/input/misc/dm355evm_keys.c
+++ b/drivers/input/misc/dm355evm_keys.c
@@ -11,6 +11,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/input.h>
+#include <linux/input/sparse-keymap.h>
 #include <linux/platform_device.h>
 #include <linux/interrupt.h>
 
@@ -33,12 +34,8 @@ struct dm355evm_keys {
 	int			irq;
 };
 
-/* These initial keycodes can be remapped by dm355evm_setkeycode(). */
-static struct {
-	u16	event;
-	u16	keycode;
-} dm355evm_keys[] = {
-
+/* These initial keycodes can be remapped */
+static const struct key_entry dm355evm_keys[] = {
 	/*
 	 * Pushbuttons on the EVM board ... note that the labels for these
 	 * are SW10/SW11/etc on the PC board.  The left/right orientation
@@ -47,11 +44,11 @@ static struct {
 	 * is to the right.  (That is, rotate the board counter-clockwise
 	 * by 90 degrees from the SW10/etc and "DM355 EVM" labels.)
 	 */
-	{ 0x00d8, KEY_OK, },		/* SW12 */
-	{ 0x00b8, KEY_UP, },		/* SW13 */
-	{ 0x00e8, KEY_DOWN, },		/* SW11 */
-	{ 0x0078, KEY_LEFT, },		/* SW14 */
-	{ 0x00f0, KEY_RIGHT, },		/* SW10 */
+	{ KE_KEY, 0x00d8, { KEY_OK } },		/* SW12 */
+	{ KE_KEY, 0x00b8, { KEY_UP } },		/* SW13 */
+	{ KE_KEY, 0x00e8, { KEY_DOWN } },	/* SW11 */
+	{ KE_KEY, 0x0078, { KEY_LEFT } },	/* SW14 */
+	{ KE_KEY, 0x00f0, { KEY_RIGHT } },	/* SW10 */
 
 	/*
 	 * IR buttons ... codes assigned to match the universal remote
@@ -65,35 +62,35 @@ static struct {
 	 * RC5 codes are 14 bits, with two start bits (0x3 prefix)
 	 * and a toggle bit (masked out below).
 	 */
-	{ 0x300c, KEY_POWER, },		/* NOTE: docs omit this */
-	{ 0x3000, KEY_NUMERIC_0, },
-	{ 0x3001, KEY_NUMERIC_1, },
-	{ 0x3002, KEY_NUMERIC_2, },
-	{ 0x3003, KEY_NUMERIC_3, },
-	{ 0x3004, KEY_NUMERIC_4, },
-	{ 0x3005, KEY_NUMERIC_5, },
-	{ 0x3006, KEY_NUMERIC_6, },
-	{ 0x3007, KEY_NUMERIC_7, },
-	{ 0x3008, KEY_NUMERIC_8, },
-	{ 0x3009, KEY_NUMERIC_9, },
-	{ 0x3022, KEY_ENTER, },
-	{ 0x30ec, KEY_MODE, },		/* "tv/vcr/..." */
-	{ 0x300f, KEY_SELECT, },	/* "info" */
-	{ 0x3020, KEY_CHANNELUP, },	/* "up" */
-	{ 0x302e, KEY_MENU, },		/* "in/out" */
-	{ 0x3011, KEY_VOLUMEDOWN, },	/* "left" */
-	{ 0x300d, KEY_MUTE, },		/* "ok" */
-	{ 0x3010, KEY_VOLUMEUP, },	/* "right" */
-	{ 0x301e, KEY_SUBTITLE, },	/* "cc" */
-	{ 0x3021, KEY_CHANNELDOWN, },	/* "down" */
-	{ 0x3022, KEY_PREVIOUS, },
-	{ 0x3026, KEY_SLEEP, },
-	{ 0x3172, KEY_REWIND, },	/* NOTE: docs wrongly say 0x30ca */
-	{ 0x3175, KEY_PLAY, },
-	{ 0x3174, KEY_FASTFORWARD, },
-	{ 0x3177, KEY_RECORD, },
-	{ 0x3176, KEY_STOP, },
-	{ 0x3169, KEY_PAUSE, },
+	{ KE_KEY, 0x300c, { KEY_POWER } },	/* NOTE: docs omit this */
+	{ KE_KEY, 0x3000, { KEY_NUMERIC_0 } },
+	{ KE_KEY, 0x3001, { KEY_NUMERIC_1 } },
+	{ KE_KEY, 0x3002, { KEY_NUMERIC_2 } },
+	{ KE_KEY, 0x3003, { KEY_NUMERIC_3 } },
+	{ KE_KEY, 0x3004, { KEY_NUMERIC_4 } },
+	{ KE_KEY, 0x3005, { KEY_NUMERIC_5 } },
+	{ KE_KEY, 0x3006, { KEY_NUMERIC_6 } },
+	{ KE_KEY, 0x3007, { KEY_NUMERIC_7 } },
+	{ KE_KEY, 0x3008, { KEY_NUMERIC_8 } },
+	{ KE_KEY, 0x3009, { KEY_NUMERIC_9 } },
+	{ KE_KEY, 0x3022, { KEY_ENTER } },
+	{ KE_KEY, 0x30ec, { KEY_MODE } },	/* "tv/vcr/..." */
+	{ KE_KEY, 0x300f, { KEY_SELECT } },	/* "info" */
+	{ KE_KEY, 0x3020, { KEY_CHANNELUP } },	/* "up" */
+	{ KE_KEY, 0x302e, { KEY_MENU } },	/* "in/out" */
+	{ KE_KEY, 0x3011, { KEY_VOLUMEDOWN } },	/* "left" */
+	{ KE_KEY, 0x300d, { KEY_MUTE } },	/* "ok" */
+	{ KE_KEY, 0x3010, { KEY_VOLUMEUP } },	/* "right" */
+	{ KE_KEY, 0x301e, { KEY_SUBTITLE } },	/* "cc" */
+	{ KE_KEY, 0x3021, { KEY_CHANNELDOWN } },/* "down" */
+	{ KE_KEY, 0x3022, { KEY_PREVIOUS } },
+	{ KE_KEY, 0x3026, { KEY_SLEEP } },
+	{ KE_KEY, 0x3172, { KEY_REWIND } },	/* NOTE: docs wrongly say 0x30ca */
+	{ KE_KEY, 0x3175, { KEY_PLAY } },
+	{ KE_KEY, 0x3174, { KEY_FASTFORWARD } },
+	{ KE_KEY, 0x3177, { KEY_RECORD } },
+	{ KE_KEY, 0x3176, { KEY_STOP } },
+	{ KE_KEY, 0x3169, { KEY_PAUSE } },
 };
 
 /*
@@ -105,19 +102,18 @@ static struct {
  */
 static irqreturn_t dm355evm_keys_irq(int irq, void *_keys)
 {
-	struct dm355evm_keys	*keys = _keys;
-	int			status;
+	static u16 last_event;
+	struct dm355evm_keys *keys = _keys;
+	struct key_entry *ke;
+	unsigned int keycode;
+	int status;
+	u16 event;
 
 	/* For simplicity we ignore INPUT_COUNT and just read
 	 * events until we get the "queue empty" indicator.
 	 * Reading INPUT_LOW decrements the count.
 	 */
 	for (;;) {
-		static u16	last_event;
-		u16		event;
-		int		keycode;
-		int		i;
-
 		status = dm355evm_msp_read(DM355EVM_MSP_INPUT_HIGH);
 		if (status < 0) {
 			dev_dbg(keys->dev, "input high err %d\n",
@@ -156,14 +152,9 @@ static irqreturn_t dm355evm_keys_irq(int irq, void *_keys)
 		/* ignore the RC5 toggle bit */
 		event &= ~0x0800;
 
-		/* find the key, or leave it as unknown */
-		keycode = KEY_UNKNOWN;
-		for (i = 0; i < ARRAY_SIZE(dm355evm_keys); i++) {
-			if (dm355evm_keys[i].event != event)
-				continue;
-			keycode = dm355evm_keys[i].keycode;
-			break;
-		}
+		/* find the key, or report it as unknown */
+		ke = sparse_keymap_entry_from_scancode(keys->input, event);
+		keycode = ke ? ke->keycode : KEY_UNKNOWN;
 		dev_dbg(keys->dev,
 			"input event 0x%04x--> keycode %d\n",
 			event, keycode);
@@ -174,36 +165,8 @@ static irqreturn_t dm355evm_keys_irq(int irq, void *_keys)
 		input_report_key(keys->input, keycode, 0);
 		input_sync(keys->input);
 	}
-	return IRQ_HANDLED;
-}
 
-static int dm355evm_setkeycode(struct input_dev *dev, int index, int keycode)
-{
-	u16		old_keycode;
-	unsigned	i;
-
-	if (((unsigned)index) >= ARRAY_SIZE(dm355evm_keys))
-		return -EINVAL;
-
-	old_keycode = dm355evm_keys[index].keycode;
-	dm355evm_keys[index].keycode = keycode;
-	set_bit(keycode, dev->keybit);
-
-	for (i = 0; i < ARRAY_SIZE(dm355evm_keys); i++) {
-		if (dm355evm_keys[index].keycode == old_keycode)
-			goto done;
-	}
-	clear_bit(old_keycode, dev->keybit);
-done:
-	return 0;
-}
-
-static int dm355evm_getkeycode(struct input_dev *dev, int index, int *keycode)
-{
-	if (((unsigned)index) >= ARRAY_SIZE(dm355evm_keys))
-		return -EINVAL;
-
-	return dm355evm_keys[index].keycode;
+	return IRQ_HANDLED;
 }
 
 /*----------------------------------------------------------------------*/
@@ -213,7 +176,6 @@ static int __devinit dm355evm_keys_probe(struct platform_device *pdev)
 	struct dm355evm_keys	*keys;
 	struct input_dev	*input;
 	int			status;
-	int			i;
 
 	/* allocate instance struct and input dev */
 	keys = kzalloc(sizeof *keys, GFP_KERNEL);
@@ -242,31 +204,30 @@ static int __devinit dm355evm_keys_probe(struct platform_device *pdev)
 	input->id.product = 0x0355;
 	input->id.version = dm355evm_msp_read(DM355EVM_MSP_FIRMREV);
 
-	input->evbit[0] = BIT(EV_KEY);
-	for (i = 0; i < ARRAY_SIZE(dm355evm_keys); i++)
-		__set_bit(dm355evm_keys[i].keycode, input->keybit);
-
-	input->setkeycode = dm355evm_setkeycode;
-	input->getkeycode = dm355evm_getkeycode;
+	status = sparse_keymap_setup(input, dm355evm_keys, NULL);
+	if (status)
+		goto fail1;
 
 	/* REVISIT:  flush the event queue? */
 
 	status = request_threaded_irq(keys->irq, NULL, dm355evm_keys_irq,
 			IRQF_TRIGGER_FALLING, dev_name(&pdev->dev), keys);
 	if (status < 0)
-		goto fail1;
+		goto fail2;
 
 	/* register */
 	status = input_register_device(input);
 	if (status < 0)
-		goto fail2;
+		goto fail3;
 
 	platform_set_drvdata(pdev, keys);
 
 	return 0;
 
-fail2:
+fail3:
 	free_irq(keys->irq, keys);
+fail2:
+	sparse_keymap_free(input);
 fail1:
 	input_free_device(input);
 	kfree(keys);
@@ -280,6 +241,7 @@ static int __devexit dm355evm_keys_remove(struct platform_device *pdev)
 	struct dm355evm_keys	*keys = platform_get_drvdata(pdev);
 
 	free_irq(keys->irq, keys);
+	sparse_keymap_free(keys->input);
 	input_unregister_device(keys->input);
 	kfree(keys);
 

