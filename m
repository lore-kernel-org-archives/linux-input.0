From: Gerhard Sittig <gsi@denx.de>
Subject: [PATCH v1 09/12] input: matrix-keypad: add binary column encoding
Date: Fri, 21 Jun 2013 20:09:55 +0200
Message-ID: <1371838198-7327-10-git-send-email-gsi@denx.de>
References: <1371838198-7327-1-git-send-email-gsi@denx.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:40030 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423568Ab3FUSKb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 21 Jun 2013 14:10:31 -0400
In-Reply-To: <1371838198-7327-1-git-send-email-gsi@denx.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, Chao Xie <xiechao.mail@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Sekhar Nori <nsekhar@ti.com>, Tony Lindgren <tony@atomide.com>, Marek Vasut <marek.vasut@gmail.com>, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Ralf Baechle <ralf@linux-mips.org>, Anatolij Gustschin <agust@denx.de>, Detlev Zundel <dzu@denx.de>, Gerhard Sittig <gsi@denx.de>

introduce support to optionally run a binary column address bit pattern
on column GPIO pins in contrast to the formerly assumed one-out-of-N approach

Signed-off-by: Gerhard Sittig <gsi@denx.de>
---
 .../bindings/input/gpio-matrix-keypad.txt          |   46 ++++++++++++++++++--
 drivers/input/keyboard/matrix_keypad.c             |   39 ++++++++++++++++-
 include/linux/input/matrix_keypad.h                |    3 ++
 3 files changed, 83 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/gpio-matrix-keypad.txt b/Documentation/devicetree/bindings/input/gpio-matrix-keypad.txt
index f72d262..75e9e28 100644
--- a/Documentation/devicetree/bindings/input/gpio-matrix-keypad.txt
+++ b/Documentation/devicetree/bindings/input/gpio-matrix-keypad.txt
@@ -57,6 +57,18 @@ information can override the keypad matrix dimension data, e.g. when not
 all of the potentially available physical connections are used to create
 the logical keypad matrix.
 
+The driver assumes that each row and column line of the keypad matrix is
+connected to a specific GPIO pin.  Alternatively column addresses can get
+encoded in binary form to reduce the number of GPIO pins involved, at the
+cost of adding an external decoder which translates the binary pattern of N
+GPIO coloumn pins into one of 2**N column lines of the matrix.  A mere
+circuit of two inverting open collector drivers in series connected to one
+output pin is a special case of this generic decoder approach.  Such a
+decoder may be desirable since it's cheap and protects the SoC from damage
+by unwanted interaction of signals when any combination of multiple keys
+gets pressed, regardless of the software's operating the column GPIO pins.
+The row GPIO pins won't interfere either since they all are inputs.
+
 Required Properties:
 - compatible:		Should be "gpio-matrix-keypad"
 - row-gpios:		List of gpios used as row lines. The gpio specifier
@@ -96,16 +108,21 @@ Optional Properties:
 			behaviour is to actively drive low signals and
 			be passive otherwise (emulates an open collector
 			output driver)
+- col-gpios-binary:	boolean, switches from the 'one GPIO pin for each
+			column' approach to the 'n GPIO pins to address
+			2**n columns' approach (binary encoding of column
+			addresses in contrast to a one-out-of-many pattern
+			for the column GPIO pins)
 - keypad,num-rows:	number of rows in the keypad matrix, overrides the
 			value which gets derived from the number of row
 			GPIO pins, useful when not all lines are in use for
 			interconnects
 - keypad,num-columns:	number of columns in the keypad matrix, overrides
 			the value which gets derived from the number of
-			column GPIO pins, useful when not all lines are in
-			use for interconnects
+			column GPIO pins and their optional encoding, useful
+			when not all lines are in use for interconnects
 
-Example:
+Examples:
 	matrix-keypad {
 		compatible = "gpio-matrix-keypad";
 		debounce-delay-ms = <5>;
@@ -125,3 +142,26 @@ Example:
 				0x0101001C
 				0x0201006C>;
 	};
+
+	matrix_keypad {
+		compatible = "gpio-matrix-keypad";
+		debounce-delay-ms = <5>;
+		col-scan-delay-us = <1>;
+		col-switch-delay-ms = <20>;
+
+		col-gpios-binary;
+		col-gpios-pushpull;
+		col-gpios = <&gpio_pic 1 0>;
+
+		row-gpios-activelow;
+		row-gpios = <&gpio_pic 2 0
+			     &gpio_pic 3 0
+			     &gpio_pic 4 0>;
+
+		linux,keymap = <0x0000006e
+				0x01000067
+				0x02000066
+				0x00010069
+				0x0101006c
+				0x0201006a>;
+	}
diff --git a/drivers/input/keyboard/matrix_keypad.c b/drivers/input/keyboard/matrix_keypad.c
index 30b7faf..c015f0d 100644
--- a/drivers/input/keyboard/matrix_keypad.c
+++ b/drivers/input/keyboard/matrix_keypad.c
@@ -47,7 +47,9 @@ struct matrix_keypad {
 /*
  * this routine controls a physical column pin which the keypad matrix
  * is connected to, and takes care of the pin's polarity as well as its
- * mode of operation (fully driven push/pull, or emulated open drain)
+ * mode of operation (fully driven push/pull, or emulated open drain),
+ * optional encoding of column address information is taken care of by
+ * the caller
  *
  * former comment before introduction of optional push/pull behaviour:
  * <cite>
@@ -88,13 +90,30 @@ static void __activate_col_pin(const struct matrix_keypad_platform_data *pdata,
  * makes sure that the "scan delay" is applied upon activation of the
  * column (the delay between activating the column and reading rows)
  *
+ * optional encoding of logical column address information and its
+ * mapping to column GPIO pin levels is taken care of as well
+ *
  * the caller ensures that this routine need not de-activate other
  * columns when dealing with the column specified for the invocation
  */
 static void activate_col(const struct matrix_keypad_platform_data *pdata,
 			 int col, bool on)
 {
-	__activate_col_pin(pdata, col, on);
+	int bit, lvl;
+
+	if (!pdata->col_gpios_binary_encoded) {
+		/* one-out-of-N approach, just setup the one pin */
+		__activate_col_pin(pdata, col, on);
+	} else if (on) {
+		/* setup the address bit pattern on all column pins */
+		for (bit = 0; bit < pdata->num_col_gpios; bit++) {
+			lvl = (col & (1 << bit)) ? 1 : 0;
+			__activate_col_pin(pdata, bit, lvl);
+		}
+	} else {
+		/* binary column encoding has no concept of "deselection" */
+		/* EMPTY */
+	}
 
 	if (on && pdata->col_scan_delay_us)
 		udelay(pdata->col_scan_delay_us);
@@ -105,12 +124,20 @@ static void activate_col(const struct matrix_keypad_platform_data *pdata,
  * matrix, or re-activates all columns at the same time after the scan
  * is complete, to make changes in the key press state trigger the
  * condition to re-scan the matrix
+ *
+ * this routine does not apply to the "binary encoded column addresses"
+ * approach, which has no concept of de-selecting columns, and cannot
+ * select multiple columns at the same time; the periodic column switch
+ * work routine takes care of detecting status changes in this mode
  */
 static void activate_all_cols(const struct matrix_keypad_platform_data *pdata,
 			      bool on)
 {
 	int col;
 
+	if (pdata->col_gpios_binary_encoded)
+		return;
+
 	for (col = 0; col < pdata->num_matrix_cols; col++)
 		__activate_col_pin(pdata, col, on);
 }
@@ -623,6 +650,8 @@ matrix_keypad_parse_dt(struct device *dev)
 	}
 	if (of_get_property(np, "col-gpios-pushpull", NULL))
 		pdata->col_gpios_push_pull = true;
+	if (of_get_property(np, "col-gpios-binary", NULL))
+		pdata->col_gpios_binary_encoded = true;
 
 	/* get delay and interval timing specs */
 	of_property_read_u32(np, "debounce-delay-ms", &pdata->debounce_ms);
@@ -630,6 +659,10 @@ matrix_keypad_parse_dt(struct device *dev)
 			     &pdata->col_scan_delay_us);
 	of_property_read_u32(np, "col-switch-delay-ms",
 			     &pdata->col_switch_delay_ms);
+	if (pdata->col_gpios_binary_encoded && !pdata->col_switch_delay_ms) {
+		dev_err(dev, "binary mode needs a column switch delay\n");
+		return ERR_PTR(-EINVAL);
+	}
 
 	/* get the individual row and column GPIO pins */
 	gpios = devm_kzalloc(dev,
@@ -658,6 +691,8 @@ matrix_keypad_parse_dt(struct device *dev)
 	 */
 	pdata->num_matrix_rows = pdata->num_row_gpios;
 	pdata->num_matrix_cols = pdata->num_col_gpios;
+	if (pdata->col_gpios_binary_encoded)
+		pdata->num_matrix_cols = 1 << pdata->num_col_gpios;
 	err = matrix_keypad_parse_of_params(dev,
 					    &pdata->num_matrix_rows,
 					    &pdata->num_matrix_cols);
diff --git a/include/linux/input/matrix_keypad.h b/include/linux/input/matrix_keypad.h
index 1398d23..82db84a 100644
--- a/include/linux/input/matrix_keypad.h
+++ b/include/linux/input/matrix_keypad.h
@@ -55,6 +55,8 @@ struct matrix_keymap_data {
  * @col_gpios_active_low: polarity of column gpio pins
  * @col_gpios_push_pull: whether column gpio pins emulate open drain
  *	behaviour or fully drive pin levels to either direction
+ * @col_gpios_binary_encoded: whether column gpio pins carry 1-of-N or
+ *	binary encoded column address information
  * @wakeup: controls whether the device should be set up as wakeup
  *	source
  * @no_autorepeat: disable key autorepeat
@@ -89,6 +91,7 @@ struct matrix_keypad_platform_data {
 	bool		row_gpios_active_low;
 	bool		col_gpios_active_low;
 	bool		col_gpios_push_pull;
+	bool		col_gpios_binary_encoded;
 	bool		wakeup;
 	bool		no_autorepeat;
 };
-- 
1.7.10.4

