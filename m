From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] intel_mid: Keypad Driver (Current snapshot for reference)
Date: Wed, 09 Feb 2011 09:53:04 +0000
Message-ID: <20110209095151.32388.66409.stgit@bob.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:51587 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751723Ab1BIKVo (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 9 Feb 2011 05:21:44 -0500
Received: from bob.linux.org.uk (earthlight.etchedpixels.co.uk [81.2.110.250])
	by lxorguk.ukuu.org.uk (8.14.4/8.14.1) with ESMTP id p19AKl4t010367
	for <linux-input@vger.kernel.org>; Wed, 9 Feb 2011 10:20:52 GMT
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

From: Zheng Ba <zheng.ba@intel.com>

This is a single patch of the Intel Moorestown keypad driver made up from
the following


Zheng Ba <zheng.ba@intel.com>
	This patch adds the keypad support for the MID platform keypad
	interfaces.

	Changes from Alpha2: solved "CRITICAL" issues marked by Klocwork
		     HSD sighting 3469242

	(some tidying Alan Cox)

Jekyll Lai <jekyll_lai@wistron.com>
	Rewrite keypad driver to keep only one default matrix keymap. Also add
	an interface to pass the platform data via "mrst_keypad_set_pdata."
	Howerver, this keypad controller also provides direct key function.
	That one matrix keymap is not enough in this driver. It's necessary
	that adding another default keymap for direct key. So, there would
	be two default keymaps. One for the keypad matrix; one for direct
	keys.

Alan Cox <alan@linux.intel.com>
	Fix abuse of disable_irq/enable_irq on a shared IRQ line.
	Clean up some problems noted by Dmitry - add a gpio clearing helper
	etc

Kristen Carlson Accardi <kristen@linux.intel.com>
	We already free the gpios in close(), we don't need to free them
		again in remove().
	IRQ will never be negative.
	Switch to using pci_ioremap.
	Add basic power management so we can wake off the keypad interrupt.
	Remove rotary support as no hardware actually needs it.
	Remove direct key handling as this is now handled (better) by gpio-keys.

	Send out the scancode value in addition to the keycode so that
	userspace may use the scancode to remap keys if they want.

	Add PCI passed configuration information:
	Right now the driver programs the number of matrix rows, cols,
	debounce interval, direct key nums and rotary info.  This
	information is passed into the driver from pdata, a new platform
	data structure.  This information should really be programmed
	into the KPC register by firmware, and then read by the driver
	via the pci shim layer.  This patch removes this info from
	the pdata structure and implements the code to read this info from
	the KPC register.  Because firmware doesn't actually behave the
	way it should right now, this patch creates a pci quirk for the
	langwell keypad which programs the KPC register.
	Document the KPC register setting
	Allow input and output GPIO ranges to be separate

Signed-off-by: Zheng Ba <zheng.ba@intel.com>
Signed-off-by: Jekyll Lai <jekyll_lai@wistron.com>
Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 arch/x86/pci/mrst.c                       |   63 ++++
 arch/x86/platform/mrst/mrst.c             |   19 +
 drivers/input/keyboard/Kconfig            |   10 +
 drivers/input/keyboard/Makefile           |    1 
 drivers/input/keyboard/intel_mid_keypad.c |  457 +++++++++++++++++++++++++++++
 include/linux/input/intel_mid_keypad.h    |   29 ++
 6 files changed, 579 insertions(+), 0 deletions(-)
 create mode 100644 drivers/input/keyboard/intel_mid_keypad.c
 create mode 100644 include/linux/input/intel_mid_keypad.h


diff --git a/arch/x86/pci/mrst.c b/arch/x86/pci/mrst.c
index cb29191..c580fcc 100644
--- a/arch/x86/pci/mrst.c
+++ b/arch/x86/pci/mrst.c
@@ -265,3 +265,66 @@ static void __devinit pci_fixed_bar_fixup(struct pci_dev *dev)
 	}
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, PCI_ANY_ID, pci_fixed_bar_fixup);
+
+/*
+ * The Firmware should program the Langwell keypad registers to indicate
+ * system specific configuration.  This quirk can be removed when firmware
+ * actually does this properly.
+ */
+static void __devinit langwell_keypad_fixup(struct pci_dev *dev)
+{
+	void __iomem *base;
+	u32 val;
+
+	base = pci_ioremap_bar(dev, 0);
+
+	if (base == NULL)
+		return;
+
+	val = readl(base);
+
+	/*
+	 * set the KPC register.  Please see the Langwell Docs
+	 * for more detail.
+	 *
+	 * Bit 31: Reserved
+	 * Bit 30: Automatic Scan Bit
+	 * Bit 29: Automatic Scan on Activity bit
+	 * Bit 28:26 : Matrix keypad row number
+	 *		000 == 1, 001 == 2, ... 111 == 8
+	 * Bit 25:23 : Matrix keypad column number
+	 *		000 ==1, 001 == 2, ... 111 == 8
+	 * Bit 22: Matrix Interrupt Bit
+	 * Bit 21: Ignore Multiple Key Press
+	 * Bit 20: Manual Matrix Scan line 7
+	 * Bit 19: Manual Matrix Scan line 6
+	 * Bit 18: Manual Matrix Scan line 5
+	 * Bit 17: Manual Matrix Scan line 4
+	 * Bit 16: Manual Matrix Scan line 3
+	 * Bit 15: Manual Matrix Scan line 2
+	 * Bit 14: Manual Matrix Scan line 1
+	 * Bit 13: Manual Matrix Scan line 0
+	 * Bit 12: Matrix Keypad Enable
+	 * Bit 11: Matrix Interrupt Enable
+	 * Bit 10:9  : Reserved
+	 * Bit 8:6   : Direct Key Number + Roatry encoder sensor input
+	 *		000 == 1, 001 == 2, ... 111 == 8
+	 * Bit 5: Direct Interrupt bit
+	 * Bit 4: Reserved
+	 * Bit 3: Rotary Encoder 1 enable
+	 * Bit 2: Rotary Encoder 0 enable
+	 * Bit 1: Direct Keypad enable
+	 * Bit 0: Direct Keypad Interrupt enable
+	 */
+	if (val == 0)
+		writel(0x3f9ff800, base);
+
+	val = readl(base + 0x24);
+
+	/* set the debounce interval (KPKDI) to 100ms */
+	if (val == 0)
+		writel(100, base + 0x24);
+
+	iounmap(base);
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x0805, langwell_keypad_fixup);
diff --git a/arch/x86/platform/mrst/mrst.c b/arch/x86/platform/mrst/mrst.c
index dea829c..b16c5ae 100644
--- a/arch/x86/platform/mrst/mrst.c
+++ b/arch/x86/platform/mrst/mrst.c
@@ -21,6 +21,7 @@
 #include <linux/i2c/pca953x.h>
 #include <linux/gpio_keys.h>
 #include <linux/input.h>
+#include <linux/input/intel_mid_keypad.h>
 #include <linux/platform_device.h>
 #include <linux/irq.h>
 #include <linux/module.h>
@@ -809,3 +810,21 @@ static int __init pb_keys_init(void)
 	return 0;
 }
 late_initcall(pb_keys_init);
+
+/*
+ * Mininal initial implementation of the mrst keypad hooks. We need this 
+ * to merge the keypad drivers and can then tweak this for the platforms
+ * that are different
+ */
+
+int mrst_keypad_enabled(void)
+{
+	return 1;
+}
+EXPORT_SYMBOL_GPL(mrst_keypad_enabled);
+
+struct mrst_keypad_platform_data *mrst_keypad_platform_data(void)
+{
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(mrst_keypad_platform_data);
diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index c7a9202..b6beefa 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -324,6 +324,16 @@ config KEYBOARD_IMX
 	  To compile this driver as a module, choose M here: the
 	  module will be called imx_keypad.
 
+config KEYBOARD_INTEL_MID
+	tristate "Intel MID keypad support"
+	depends on GPIO_LANGWELL
+	help
+	  Say Y if you want support for Intel MID keypad devices
+	  depends on GPIO_LANGWELL
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called intel_mid_keypad.
+
 config KEYBOARD_NEWTON
 	tristate "Newton keyboard"
 	select SERIO
diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/Makefile
index 468c627..15eff1b 100644
--- a/drivers/input/keyboard/Makefile
+++ b/drivers/input/keyboard/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_KEYBOARD_ATKBD)		+= atkbd.o
 obj-$(CONFIG_KEYBOARD_BFIN)		+= bf54x-keys.o
 obj-$(CONFIG_KEYBOARD_DAVINCI)		+= davinci_keyscan.o
 obj-$(CONFIG_KEYBOARD_EP93XX)		+= ep93xx_keypad.o
+obj-$(CONFIG_KEYBOARD_INTEL_MID)	+= intel_mid_keypad.o
 obj-$(CONFIG_KEYBOARD_GPIO)		+= gpio_keys.o
 obj-$(CONFIG_KEYBOARD_GPIO_POLLED)	+= gpio_keys_polled.o
 obj-$(CONFIG_KEYBOARD_TCA6416)		+= tca6416-keypad.o
diff --git a/drivers/input/keyboard/intel_mid_keypad.c b/drivers/input/keyboard/intel_mid_keypad.c
new file mode 100644
index 0000000..867458a
--- /dev/null
+++ b/drivers/input/keyboard/intel_mid_keypad.c
@@ -0,0 +1,457 @@
+/*
+ * Driver for the matrix keypad controller on MID platform.
+ *
+ * Copyright (c) 2009-2011 Intel Corporation.
+ * Created:	Sep 18, 2008
+ * Updated:	May 14, 2010
+ * Copyright (C) 2011 Jekyll Lai, Wistron <jekyll_lai@wistron.com>
+ *
+ * Based on pxa27x_keypad.c by Rodolfo Giometti <giometti@linux.it>
+ * pxa27x_keypad.c is based on a previous implementation by Kevin O'Connor
+ * <kevin_at_keconnor.net> and Alex Osborne <bobofdoom@gmail.com> and
+ * on some suggestions by Nicolas Pitre <nico@cam.org>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin St - Fifth Floor, Boston, MA 02110-1301 USA.
+ *
+ */
+
+#define DRV_NAME	"mrst_keypad"
+#define DRV_VERSION	"1.4"
+#define MRST_KEYPAD_DRIVER_NAME   DRV_NAME " " DRV_VERSION
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/input.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/gpio.h>
+#include <linux/input/intel_mid_keypad.h>
+
+/*
+ * Keypad Controller registers
+ */
+#define KPC             0x0000 /* Keypad Control register */
+#define KPAS            0x0010 /* Keypad Automatic Scan register */
+
+#define KPC_MI          (0x1 << 22)  /* Matrix interrupt bit */
+
+/* Keypad Automatic Scan Multiple Key Presser register 0-3 */
+#define KPASMKP0        0x0014
+#define KPASMKP1        0x0018
+#define KPASMKP2        0x001C
+#define KPASMKP3        0x0020
+#define KPKDI           0x0024
+
+#define KPAS_SO         (0x1 << 31)
+#define KPAS_MUKP(n)	(((n) >> 26) & 0x1f)
+#define KPAS_RP(n)	(((n) >> 4) & 0xf)
+#define KPAS_CP(n)	((n) & 0xf)
+#define KPASMKP_MKC_MASK	(0xff)
+
+#define	KEYPAD_MATRIX_GPIO_IN_PIN	24
+#define	KEYPAD_MATRIX_GPIO_OUT_PIN	32
+
+#define keypad_readl(off)	readl(keypad->mmio_base + (off))
+#define keypad_writel(off, v)	writel((v), keypad->mmio_base + (off))
+
+#define MAX_MATRIX_KEY_NUM	(8 * 8)
+#define MAX_MATRIX_KEY_COLS	(8)
+
+static unsigned int mrst_default_keymap[] = {
+	KEY(0, 0, KEY_1),
+	KEY(0, 1, KEY_8),
+	KEY(0, 2, KEY_T),
+	KEY(0, 3, KEY_S),
+	KEY(0, 4, KEY_L),
+	KEY(0, 5, KEY_N),
+
+	KEY(1, 0, KEY_2),
+	KEY(1, 1, KEY_9),
+	KEY(1, 2, KEY_Y),
+	KEY(1, 3, KEY_D),
+	KEY(1, 4, KEY_BACKSPACE),
+	KEY(1, 5, KEY_M),
+
+	KEY(2, 0, KEY_3),
+	KEY(2, 1, KEY_0),
+	KEY(2, 2, KEY_U),
+	KEY(2, 3, KEY_F),
+	KEY(2, 4, KEY_Z),
+	KEY(2, 5, KEY_F23),
+
+	KEY(3, 0, KEY_4),
+	KEY(3, 1, KEY_Q),
+	KEY(3, 2, KEY_I),
+	KEY(3, 3, KEY_G),
+	KEY(3, 4, KEY_X),
+	KEY(3, 5, KEY_F24),
+
+	KEY(4, 0, KEY_5),
+	KEY(4, 1, KEY_W),
+	KEY(4, 2, KEY_O),
+	KEY(4, 3, KEY_H),
+	KEY(4, 4, KEY_C),
+	KEY(4, 5, KEY_COMMA),
+
+	KEY(5, 0, KEY_6),
+	KEY(5, 1, KEY_E),
+	KEY(5, 2, KEY_P),
+	KEY(5, 3, KEY_J),
+	KEY(5, 4, KEY_V),
+	KEY(5, 5, KEY_DOT),
+
+	KEY(6, 0, KEY_7),
+	KEY(6, 1, KEY_R),
+	KEY(6, 2, KEY_A),
+	KEY(6, 3, KEY_K),
+	KEY(6, 4, KEY_B),
+	KEY(6, 5, KEY_SPACE),
+
+	KEY(7, 0, KEY_LEFTSHIFT),
+	KEY(7, 1, KEY_RIGHTALT),
+	KEY(7, 2, KEY_ENTER),
+};
+
+static const struct matrix_keymap_data mrst_default_keymap_data = {
+	.keymap = mrst_default_keymap,
+	.keymap_size = ARRAY_SIZE(mrst_default_keymap),
+};
+
+struct mrst_keypad {
+	struct input_dev *input_dev;
+	void __iomem *mmio_base;
+	unsigned int irq;
+
+	unsigned int	matrix_key_rows;
+	unsigned int	matrix_key_cols;
+	unsigned int	row_shift;
+
+	const struct matrix_keymap_data *keymap_data;
+
+	/* state row bits of each column scan */
+	uint32_t matrix_key_state[MAX_MATRIX_KEY_COLS];
+
+	unsigned short keycode[MAX_MATRIX_KEY_NUM];
+};
+
+static void mrst_keypad_build_keycode(struct mrst_keypad *keypad)
+{
+	struct input_dev *input_dev = keypad->input_dev;
+	const struct matrix_keymap_data *keymap_data;
+	struct mrst_keypad_platform_data *pdata;
+
+	keymap_data = &mrst_default_keymap_data;
+
+	pdata = mrst_keypad_platform_data();
+
+	if (pdata)
+		keymap_data = pdata->keymap_data;
+
+	matrix_keypad_build_keymap(keymap_data, keypad->row_shift,
+		 input_dev->keycode, input_dev->keybit);
+}
+
+static void mrst_keypad_scan_matrix(struct mrst_keypad *keypad)
+{
+	int row, col, code, num_keys_pressed = 0;
+	uint32_t new_state[MAX_MATRIX_KEY_COLS];
+	uint32_t kpas = keypad_readl(KPAS);
+
+	num_keys_pressed = KPAS_MUKP(kpas);
+
+	memset(new_state, 0, sizeof(new_state));
+
+	if (num_keys_pressed == 1) {
+		col = KPAS_CP(kpas);
+		row = KPAS_RP(kpas);
+
+		if (row < 0 || col < 0)
+			return;
+
+		new_state[col] = (1 << row);
+	} else if (num_keys_pressed > 1) {
+		uint32_t kpasmkp0 = keypad_readl(KPASMKP0);
+		uint32_t kpasmkp1 = keypad_readl(KPASMKP1);
+		uint32_t kpasmkp2 = keypad_readl(KPASMKP2);
+		uint32_t kpasmkp3 = keypad_readl(KPASMKP3);
+
+		new_state[0] = kpasmkp0 & KPASMKP_MKC_MASK;
+		new_state[1] = (kpasmkp0 >> 16) & KPASMKP_MKC_MASK;
+		new_state[2] = kpasmkp1 & KPASMKP_MKC_MASK;
+		new_state[3] = (kpasmkp1 >> 16) & KPASMKP_MKC_MASK;
+		new_state[4] = kpasmkp2 & KPASMKP_MKC_MASK;
+		new_state[5] = (kpasmkp2 >> 16) & KPASMKP_MKC_MASK;
+		new_state[6] = kpasmkp3 & KPASMKP_MKC_MASK;
+		new_state[7] = (kpasmkp3 >> 16) & KPASMKP_MKC_MASK;
+	}
+
+	for (col = 0; col < keypad->matrix_key_cols; col++) {
+		uint32_t bits_changed;
+
+		bits_changed = keypad->matrix_key_state[col] ^ new_state[col];
+		if (bits_changed == 0)
+			continue;
+
+		for (row = 0; row < keypad->matrix_key_rows; row++) {
+			if ((bits_changed & (1 << row)) == 0)
+				continue;
+
+			code = MATRIX_SCAN_CODE(row, col, keypad->row_shift);
+			input_event(keypad->input_dev, EV_MSC, MSC_SCAN, code);
+			input_report_key(keypad->input_dev,
+				keypad->keycode[code],
+				new_state[col] & (1 << row));
+		}
+	}
+	input_sync(keypad->input_dev);
+	memcpy(keypad->matrix_key_state, new_state, sizeof(new_state));
+}
+
+static irqreturn_t mrst_keypad_irq_handler(int irq, void *dev_id)
+{
+	struct mrst_keypad *keypad = dev_id;
+	unsigned long kpc = keypad_readl(KPC);
+
+	if (kpc & KPC_MI)
+		mrst_keypad_scan_matrix(keypad);
+
+	return IRQ_HANDLED;
+}
+
+
+static void mrst_keypad_gpio_free(struct mrst_keypad *keypad)
+{
+	int in_pins = KEYPAD_MATRIX_GPIO_IN_PIN + keypad->matrix_key_rows;
+	int out_pins = KEYPAD_MATRIX_GPIO_OUT_PIN + keypad->matrix_key_cols;
+	int i;
+
+	/* free occupied pins */
+	for (i = KEYPAD_MATRIX_GPIO_IN_PIN; i < in_pins; i++)
+		gpio_free(i);
+	for (i = KEYPAD_MATRIX_GPIO_OUT_PIN; i < out_pins; i++)
+ 		gpio_free(i);
+}
+
+static int mrst_keypad_gpio_init(struct mrst_keypad *keypad)
+{
+	int i, err;
+	int in_pins = KEYPAD_MATRIX_GPIO_IN_PIN + keypad->matrix_key_rows;
+	int out_pins = KEYPAD_MATRIX_GPIO_OUT_PIN + keypad->matrix_key_cols;
+
+	/* explicitely tell which pins have been occupied... */
+	for (i = KEYPAD_MATRIX_GPIO_IN_PIN; i < in_pins; i++) {
+		err = gpio_request(i, NULL);
+
+		if (err) {
+			pr_err(DRV_NAME "GPIO pin %d failed to request.\n", i);
+			goto err_free_rows;
+		}
+
+		gpio_direction_input(i);
+	}
+
+	for (i = KEYPAD_MATRIX_GPIO_OUT_PIN; i < out_pins; i++) {
+		err = gpio_request(i, NULL);
+
+		if (err) {
+			pr_err(DRV_NAME "GPIO pin %d failed to request.\n", i);
+			goto err_free_cols;
+		}
+
+		gpio_direction_output(i, 1);
+	}
+
+	return 0;
+
+err_free_cols:
+	while (--i >= KEYPAD_MATRIX_GPIO_OUT_PIN)
+		gpio_free(i);
+
+	i = in_pins;
+
+err_free_rows:
+	while (--i >= KEYPAD_MATRIX_GPIO_IN_PIN)
+		gpio_free(i);
+
+	return err;
+}
+
+static int __devinit mrst_keypad_probe(struct pci_dev *pdev,
+			const struct pci_device_id *ent)
+{
+	struct mrst_keypad *keypad;
+	struct input_dev *input_dev;
+	int error;
+	u32 kpc;
+
+	/* Check with the firmware if the keypad is enabled */
+	if (!mrst_keypad_enabled())
+		return 0;
+
+	error = pci_enable_device(pdev);
+	if (error || pdev->irq == 0) {
+		dev_err(&pdev->dev, "failed to enable device/get irq\n");
+		return -ENXIO;
+	}
+
+	keypad = kzalloc(sizeof(struct mrst_keypad), GFP_KERNEL);
+	input_dev = input_allocate_device();
+	if (!keypad || !input_dev) {
+		dev_err(&pdev->dev, "failed to allocate driver data\n");
+		error = -ENOMEM;
+		goto failed_free_mem;
+	}
+
+	keypad->input_dev = input_dev;
+	keypad->irq = pdev->irq;
+
+	error = pci_request_regions(pdev, DRV_NAME);
+	if (error) {
+		dev_err(&pdev->dev, "failed to request I/O memory\n");
+		goto failed_free_mem;
+	}
+
+	keypad->mmio_base = pci_ioremap_bar(pdev, 0);
+	if (!keypad->mmio_base) {
+		dev_err(&pdev->dev, "failed to remap I/O memory\n");
+		error = -ENXIO;
+		goto failed_free_mem_region;
+	}
+
+	kpc = keypad_readl(KPC);
+	keypad->matrix_key_rows = ((kpc >> 26) & 0x7) + 1;
+	keypad->matrix_key_cols = ((kpc >> 23) & 0x7) + 1;
+	keypad->row_shift = get_count_order(keypad->matrix_key_cols);
+
+	input_dev->name = pci_name(pdev);
+	input_dev->id.bustype = BUS_PCI;
+	input_dev->dev.parent = &pdev->dev;
+	input_set_drvdata(input_dev, keypad);
+
+	input_dev->keycode = keypad->keycode;
+	input_dev->keycodesize = sizeof(unsigned int);
+	input_dev->keycodemax = keypad->matrix_key_rows << keypad->row_shift;
+
+	input_dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_REP) |
+		BIT_MASK(EV_REL);
+
+	input_set_capability(input_dev, EV_MSC, MSC_SCAN);
+
+	mrst_keypad_build_keycode(keypad);
+
+	error = mrst_keypad_gpio_init(keypad);
+	if (error)
+		goto failed_free_iounmap;
+
+	/* Register the input device */
+	error = input_register_device(input_dev);
+	if (error) {
+		dev_err(&pdev->dev, "failed to register input device\n");
+		goto failed_free_gpio;
+	}
+
+	error = request_irq(pdev->irq, mrst_keypad_irq_handler, IRQF_SHARED,
+		pci_name(pdev), keypad);
+	if (error) {
+		dev_err(&pdev->dev, "failed to request keyboard IRQ\n");
+		goto failed_free_input;
+	}
+	pci_set_drvdata(pdev, keypad);
+	return 0;
+
+failed_free_input:
+	input_unregister_device(input_dev);
+	input_dev = NULL;
+failed_free_gpio:
+	mrst_keypad_gpio_free(keypad);
+failed_free_iounmap:
+	iounmap(keypad->mmio_base);
+failed_free_mem_region:
+	pci_release_regions(pdev);
+failed_free_mem:
+	if (input_dev)
+		input_free_device(input_dev);
+	kfree(keypad);
+
+	return error;
+}
+
+static void __devexit mrst_keypad_remove(struct pci_dev *pdev)
+{
+	struct mrst_keypad *keypad = pci_get_drvdata(pdev);
+
+	free_irq(pdev->irq, keypad);
+
+	input_unregister_device(keypad->input_dev);
+	mrst_keypad_gpio_free(keypad);
+	iounmap(keypad->mmio_base);
+	pci_release_regions(pdev);
+	pci_set_drvdata(pdev, NULL);
+	kfree(keypad);
+}
+
+static const struct pci_device_id keypad_pci_tbl[] = {
+	{0x8086, 0x0805, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{0,}
+};
+MODULE_DEVICE_TABLE(pci, keypad_pci_tbl);
+
+#ifdef CONFIG_PM
+static int mrst_keypad_suspend(struct pci_dev *pdev, pm_message_t state)
+{
+	if (device_may_wakeup(&pdev->dev))
+		enable_irq_wake(pdev->irq);
+
+	return 0;
+}
+
+static int mrst_keypad_resume(struct pci_dev *pdev)
+{
+	if (device_may_wakeup(&pdev->dev))
+		disable_irq_wake(pdev->irq);
+
+	return 0;
+}
+#endif
+
+static struct pci_driver mrst_keypad_driver = {
+	.name		= DRV_NAME,
+	.id_table	= keypad_pci_tbl,
+	.probe		= mrst_keypad_probe,
+	.remove		= __devexit_p(mrst_keypad_remove),
+#ifdef CONFIG_PM
+	.suspend	= mrst_keypad_suspend,
+	.resume		= mrst_keypad_resume,
+#endif /* CONFIG_PM */
+};
+
+static int __init mrst_keypad_init(void)
+{
+	return pci_register_driver(&mrst_keypad_driver);
+}
+
+static void __exit mrst_keypad_exit(void)
+{
+	pci_unregister_driver(&mrst_keypad_driver);
+}
+
+module_init(mrst_keypad_init);
+module_exit(mrst_keypad_exit);
+
+MODULE_DESCRIPTION("MRST Keypad Controller Driver");
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Intel Corp, Jekyll Lai <jekyll_lai@wistron.com>");
diff --git a/include/linux/input/intel_mid_keypad.h b/include/linux/input/intel_mid_keypad.h
new file mode 100644
index 0000000..7a41bfc
--- /dev/null
+++ b/include/linux/input/intel_mid_keypad.h
@@ -0,0 +1,29 @@
+/*
+ * Copyright (C) 2010 Jekyll Lai, Wistron <jekyll_lai@wistron.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ *
+ */
+
+#include <linux/platform_device.h>
+#include <linux/input/matrix_keypad.h>
+
+struct mrst_keypad_platform_data {
+	const struct matrix_keymap_data *keymap_data;
+};
+
+extern int mrst_keypad_enabled(void);
+extern struct mrst_keypad_platform_data *mrst_keypad_platform_data(void);
+

