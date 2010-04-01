From: Mauro Carvalho Chehab <mchehab@redhat.com>
Subject: [PATCH 05/15] V4L/DVB: ir-core: add two functions to report
 keyup/keydown events
Date: Thu, 1 Apr 2010 14:56:32 -0300
Message-ID: <20100401145632.374ec6c9@pedra>
References: <cover.1270142346.git.mchehab@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <cover.1270142346.git.mchehab@redhat.com>
Sender: linux-media-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Linux Media Mailing List <linux-media@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Signed-off-by: Mauro Carvalho Chehab <mchehab@redhat.com>

diff --git a/drivers/media/IR/ir-keytable.c b/drivers/media/IR/ir-keytable.c
index 2d9ba84..ab60730 100644
--- a/drivers/media/IR/ir-keytable.c
+++ b/drivers/media/IR/ir-keytable.c
@@ -364,7 +364,7 @@ static int ir_setkeycode(struct input_dev *dev,
  *
  * This routine is used by the input routines when a key is pressed at the
  * IR. The scancode is received and needs to be converted into a keycode.
- * If the key is not found, it returns KEY_UNKNOWN. Otherwise, returns the
+ * If the key is not found, it returns KEY_RESERVED. Otherwise, returns the
  * corresponding keycode from the table.
  */
 u32 ir_g_keycode_from_table(struct input_dev *dev, u32 scancode)
@@ -391,6 +391,61 @@ u32 ir_g_keycode_from_table(struct input_dev *dev, u32 scancode)
 EXPORT_SYMBOL_GPL(ir_g_keycode_from_table);
 
 /**
+ * ir_keyup() - generates input event to cleanup a key press
+ * @input_dev:	the struct input_dev descriptor of the device
+ *
+ * This routine is used by the input routines when a key is pressed at the
+ * IR. It reports a keyup input event via input_report_key().
+ */
+void ir_keyup(struct input_dev *dev)
+{
+	struct ir_input_dev *ir = input_get_drvdata(dev);
+
+	if (!ir->keypressed)
+		return;
+
+	input_report_key(dev, ir->keycode, 0);
+	input_sync(dev);
+	ir->keypressed = 0;
+}
+EXPORT_SYMBOL_GPL(ir_keyup);
+
+/**
+ * ir_keydown() - generates input event for a key press
+ * @input_dev:	the struct input_dev descriptor of the device
+ * @scancode:	the scancode that we're seeking
+ *
+ * This routine is used by the input routines when a key is pressed at the
+ * IR. It gets the keycode for a scancode and reports an input event via
+ * input_report_key().
+ */
+void ir_keydown(struct input_dev *dev, int scancode)
+{
+	struct ir_input_dev *ir = input_get_drvdata(dev);
+
+	u32 keycode = ir_g_keycode_from_table(dev, scancode);
+
+	/* If already sent a keydown, do a keyup */
+	if (ir->keypressed)
+		ir_keyup(dev);
+
+	if (KEY_RESERVED == keycode)
+		return;
+
+	ir->keycode = keycode;
+	ir->keypressed = 1;
+
+	IR_dprintk(1, "%s: key down event, key 0x%04x, scancode 0x%04x\n",
+		dev->name, keycode, scancode);
+
+	input_report_key(dev, ir->keycode, 1);
+	input_sync(dev);
+
+}
+EXPORT_SYMBOL_GPL(ir_keydown);
+
+
+/**
  * ir_input_register() - sets the IR keycode table and add the handlers
  *			    for keymap table get/set
  * @input_dev:	the struct input_dev descriptor of the device
diff --git a/include/media/ir-core.h b/include/media/ir-core.h
index 369969d..198fd61 100644
--- a/include/media/ir-core.h
+++ b/include/media/ir-core.h
@@ -72,6 +72,10 @@ struct ir_input_dev {
 	unsigned long			devno;		/* device number */
 	const struct ir_dev_props	*props;		/* Device properties */
 	struct ir_raw_event_ctrl	*raw;		/* for raw pulse/space events */
+
+	/* key info - needed by IR keycode handlers */
+	u32				keycode;	/* linux key code */
+	int				keypressed;	/* current state */
 };
 
 #define to_ir_input_dev(_attr) container_of(_attr, struct ir_input_dev, attr)
-- 
1.6.6.1
