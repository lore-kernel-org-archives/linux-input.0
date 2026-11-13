Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794560563;
	b=g9Soz4250BfMqf68jnYtg3W0mbL8deOzABI84eET5LPsSEOqbGyM71drYc4yCC/MphdF
	 2U1T/VuWtCPjzyHCiambx5AEzXEHZg6U1lvx95EUofPYanDV0vI5SP2dpoVQDGS7gTp7i
	 rINXvPZfGP4vGh5zfVSUn7Y0fpHOv4ozKLzF3S2xPU62iGG7W3nPV6A9b720XDcP76Tu/
	 mYBP0dzBwqutsV2ZJkooeYgHqY9bjj+hPXgbza4DLyTcm2tuNYJNi/8Sqw1oayQDtqAIS
	 YYU2n+HLJBYZmQgPouBaAo8raaC2mB7uAm1x2R0lLiKMwxi4Fg95Zh2MJYpmqxk4cfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794560563;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ahsgv2wAySqVQliAB8Kc3mUySg+XitoYtH+2V1k0eiU=;
	b=3dPNEMvI4OMY+is8ucMCL1Jw/QV4bBi7FFPzA+i/KkMPJvuG2/ZVSoBZfeB4uHGXpU1f
	 DPS8U1XlGPsC/ZXWdbRzCMzkPuvO4oMykQnwPfv8ALYrjymr7xBm3rufyuSbUvoV3GnKH
	 XZIf/ny7bgfFWmr/99E/DVv7FsaQ8BXA4wh6H5rQA2qu9fVuSrdkjdUvuUVWLj6lYe5SZ
	 pcmA2CB4qcz9AVH0YKwBtmjcfMXQRi21KEYxxTPJB4B+p9np3aRwuihaJWQ28AImme3Cx
	 sgsz6avrPIw6mLn8kfnqy4sio8LJGca/NhMPmGfQEqevRlLWJTEOVco3AcqQ5KGwsGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PBFCvrt5;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA87606A327
	for <linux-input@vger.kernel.org>; Fri, 13 Nov 2026 09:02:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5EA87606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PBFCvrt5
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-3791619605cso1591557eec.0
        for <linux-input@vger.kernel.org>; Fri, 13 Nov 2026 01:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794560562; x=1795165362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ahsgv2wAySqVQliAB8Kc3mUySg+XitoYtH+2V1k0eiU=;
        b=PBFCvrt5jDqH6kNo6nFcPYHgIrBbbVklswI+CnppOfcnR22W8TlYpgj/QA2VgL+twc
         ik+XMt0OtCPmW2Q20xOPuckRnmcDwC0mvrm+UbuKHxfTGYnGagYkvNgav7afydDPLg7o
         5H3ijTL/FLUEQ1nZ7eA9lpAnmfemTCbb2hPpGiqlhdKOaA5hP/Bt4xaU6K3cG7ohmyYW
         Tp5K99zK57R+PFV7jjSgfpYZK3Elgqm4NJe6MEqhDQXZwg3FjUaRvjFx0Z9zll/O1EPw
         t3GIVeuPCZ5lJtQ1gZ3JUgoj3KUAf2O8JfwOx+6FrZLqhBtzgwXuvcBslrWX2J6BGDw9
         3hbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794560562; x=1795165362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ahsgv2wAySqVQliAB8Kc3mUySg+XitoYtH+2V1k0eiU=;
        b=OOs/s+XlQxsTPO1sh2Yo1F1tqZTe18WWafwtSaAtCLzyqRoKfoHwnGRbxMnL8B7VkR
         HGj1FyIMGjXEQ+M0Byi3uvXXhjbVon6IR9aRKWCvG6H87CHF8CuB6vrvYu+kYBwUajR3
         eCSyySx0j4oBzX41C65KeqKYQ3Y8OZ6NtlvEn1fMSSuybe8GWx7KhHLaBA3gX4WV13hd
         zsSvADkaJPkbhJE4w6sFab2+JBZLd8pcwjvUbHi41YdfLiOWENVyU1a0iydYGvLLinl0
         nnyGsImVfHGQuNNzLEVEzLn0ifNlDGIICHvny0qd+bfS7d3NfiaEY3GtDkJZtDbbwWrp
         ydIw==
X-Forwarded-Encrypted: i=1; AL+hErE/o8SFaaUsItSTIubU3PaI6h0TTA+aXfESyBkpt30opeq0z2OTnmwdfZlqeMDaUcC1Y+dEc71xezv5lg==@vger.kernel.org
X-Gm-Message-State: APuU4Z+ZobU+gLmtH7a0MVx9jwGo6XEhyGrzbe4QVF83ACxdMcxuL9j/
	N7NxqdW8UHuPK18gj/8sFjQNaOS7vCuK6QQkykAxJSju8YXdjSSOV5t8
X-Gm-Gg: AYBFou3c1bAFEjMc4m3FPE1jQaJdaHFNaKbT4kKXAQGJcxRxn0fKU1E+Cy2oBOuIcoq
	ZzmDzs+0w8FBia/Rx+bdXnjuhI+PNuE7vLHL2DJCkUV/LsyYt/DGUKmB7Xhjx8hxSSGRd6fWqxN
	FzCpFk1bYTxzzQjIPiotLVfe0gd6RZfK8KCoXHfDHOmKueTfb4HvTrYWDo1zuYuS9ux452bWTQn
	nkIEgzpudaYJnaCbxlnjLjdjrdQ7lZKdfEnDDtiNlxkP85K6lhhQs18++pohPcMLcA/eqgXW9z6
	Ldslf4v6EferQQu/W16LRIv+TqWtUxTkYHM0CawfqslVnNbbuFUcosmXr3FNkiHRweR7ZpuNt75
	HKnn3xPGUVq0WZSplqx4KswLeKSRzmAHh+/Pmbj3SzYJNOHiZnby8ToD3lp3kMbx741qtDwjdNW
	RS5c9PeTjbneNCZzazgegzVeHkHy0uDYDKxmRmKiS02HsGjIY/G6Z3TJ0CV1YbjfU2xYqGvVyyj
	yM/2Izfcd1hqErBWP3L5HMLQWkdmwuVqazixPG9AsNJUvUyKbXyHRr/JIi/HnOy4FQaV7TrYfwU
	tNPY7rjwSWmWHv/0/lJ3q8xO6B0B4ktqG0CvEgTORvZVDwBMXFIsFzIH9CJz4+jkMYmWFncplrF
	JVdcn
X-Received: by 2002:a05:693c:20c4:10b0:375:f17a:d691 with SMTP id 5a478bee46e88-379678ea195mr1733532eec.38.1794560562265;
        Fri, 13 Nov 2026 01:02:42 -0800 (PST)
Received: from fyhsueh.. (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3795378d73dsm6022191eec.2.2026.11.13.01.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 01:02:41 -0800 (PST)
From: Feng-Yi Hsueh <fyhsueh4linux@gmail.com>
To: dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	ychuang3@nuvoton.com,
	schung@nuvoton.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	fyhsueh4linux@gmail.com,
	u.kleine-koenig@baylibre.com
Subject: [PATCH v2 2/2] Input: keyboard: Add Nuvoton MA35D1 keypad driver
Date: Fri, 13 Nov 2026 17:02:29 +0800
Message-ID: <20261113090229.32838-1-fyhsueh4linux@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261113084852.32727-1-fyhsueh4linux@gmail.com>
References: <20261113084852.32727-1-fyhsueh4linux@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the Nuvoton MA35D1 hardware matrix keypad
controller.

The driver handles key press and release interrupts, reports
key events through the Linux input subsystem, and manages
the peripheral clock during device open, close, and system
suspend and resume.

Signed-off-by: Feng-Yi Hsueh <fyhsueh4linux@gmail.com>
---
 drivers/input/keyboard/Kconfig         |  11 +
 drivers/input/keyboard/Makefile        |   1 +
 drivers/input/keyboard/ma35d1_keypad.c | 407 +++++++++++++++++++++++++
 3 files changed, 419 insertions(+)
 create mode 100644 drivers/input/keyboard/ma35d1_keypad.c

diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index d8c64f333462..9bbcbed3d494 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -358,6 +358,17 @@ config KEYBOARD_LPC32XX
 	  To compile this driver as a module, choose M here: the
 	  module will be called lpc32xx-keys.
 
+config KEYBOARD_MA35D1
+	tristate "Nuvoton MA35D1 keypad controller"
+	depends on ARCH_MA35 || COMPILE_TEST
+	select INPUT_MATRIXKMAP
+	help
+	  Say Y here to enable support for the Nuvoton MA35D1
+	  hardware matrix keypad controller.
+
+	  To compile this driver as a module, choose M here.
+	  The module will be called ma35d1_keypad.
+
 config KEYBOARD_MAPLE
 	tristate "Maple bus keyboard"
 	depends on SH_DREAMCAST && MAPLE
diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/Makefile
index 60bb7baf802f..fad34b7afff7 100644
--- a/drivers/input/keyboard/Makefile
+++ b/drivers/input/keyboard/Makefile
@@ -39,6 +39,7 @@ obj-$(CONFIG_KEYBOARD_LM8323)		+= lm8323.o
 obj-$(CONFIG_KEYBOARD_LM8333)		+= lm8333.o
 obj-$(CONFIG_KEYBOARD_LOCOMO)		+= locomokbd.o
 obj-$(CONFIG_KEYBOARD_LPC32XX)		+= lpc32xx-keys.o
+obj-$(CONFIG_KEYBOARD_MA35D1) 		+= ma35d1_keypad.o
 obj-$(CONFIG_KEYBOARD_MAPLE)		+= maple_keyb.o
 obj-$(CONFIG_KEYBOARD_MATRIX)		+= matrix_keypad.o
 obj-$(CONFIG_KEYBOARD_MAX7359)		+= max7359_keypad.o
diff --git a/drivers/input/keyboard/ma35d1_keypad.c b/drivers/input/keyboard/ma35d1_keypad.c
new file mode 100644
index 000000000000..f2d19101c0bb
--- /dev/null
+++ b/drivers/input/keyboard/ma35d1_keypad.c
@@ -0,0 +1,407 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Nuvoton MA35D1 hardware matrix keypad controller
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/clk.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/input.h>
+#include <linux/input/matrix_keypad.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/platform_device.h>
+#include <linux/pm.h>
+#include <linux/property.h>
+#include <linux/types.h>
+
+#define MA35D1_KPI_CONF			0x00
+#define MA35D1_KPI_3KCONF		0x04
+#define MA35D1_KPI_STATUS		0x08
+#define MA35D1_KPI_KEST0		0x10
+#define MA35D1_KPI_KPE0			0x18
+#define MA35D1_KPI_KRE0			0x20
+#define MA35D1_KPI_PRESCALDIV		0x28
+
+#define MA35D1_KPI_KROW			GENMASK(30, 28)
+#define MA35D1_KPI_KCOL			GENMASK(26, 24)
+#define MA35D1_KPI_DBCLKSEL		GENMASK(19, 16)
+#define MA35D1_KPI_PRESCALE		GENMASK(15, 8)
+#define MA35D1_KPI_INTEN		BIT(3)
+#define MA35D1_KPI_RKINTEN		BIT(2)
+#define MA35D1_KPI_PKINTEN		BIT(1)
+#define MA35D1_KPI_ENKP			BIT(0)
+
+#define MA35D1_KPI_RST3KEY		BIT(1)
+#define MA35D1_KPI_PDWAKE		BIT(0)
+#define MA35D1_KPI_IRQ_MASK		GENMASK(4, 0)
+
+#define MA35D1_KPI_MAX_ROWS		8
+#define MA35D1_KPI_MAX_COLS		8
+#define MA35D1_KPI_BANKS		2
+#define MA35D1_KPI_ROWS_PER_BANK	(MA35D1_KPI_MAX_ROWS / MA35D1_KPI_BANKS)
+
+/*
+ * Scan timing, in KPI engine clock cycles.  PRESCALE and PRESCALDIV are
+ * encoded as the count minus one:
+ *
+ *   row scan cycles = (PRESCALE + 1) * (PRESCALDIV + 1) = 2080
+ *   debounce sample cycles = 2^DBCLKSEL = 1024
+ *
+ * With SCANROWD at its reset value (4 cycles) the TRM requires
+ * row scan time > 4 + 2 * 1024 + 3 = 2055 cycles.  These limits are expressed
+ * in cycles and therefore hold at different input rates. The actual scan
+ * and debounce intervals depend on the engine clock rate; boards should
+ * select a rate suitable for their switches (1 MHz has been validated).
+ */
+#define MA35D1_KPI_PRESCALE_VAL		0x40
+#define MA35D1_KPI_DIV_VAL		0x1f
+#define MA35D1_KPI_DEBOUNCE_SEL		10
+
+struct ma35d1_keypad {
+	void __iomem *base;
+	struct clk *clk;
+	struct input_dev *input;
+	unsigned short *keycodes;
+	unsigned int rows;
+	unsigned int cols;
+	unsigned int row_shift;
+	u32 conf;
+	int irq;
+	bool running;	/* protected by input->mutex */
+};
+
+static void ma35d1_keypad_clear_events(struct ma35d1_keypad *keypad)
+{
+	unsigned int bank;
+	u32 press, release;
+
+	for (bank = 0; bank < MA35D1_KPI_BANKS; bank++) {
+		press = readl(keypad->base + MA35D1_KPI_KPE0 + bank * 4);
+		release = readl(keypad->base + MA35D1_KPI_KRE0 + bank * 4);
+		/* The event registers are write-one-to-clear. */
+		if (press)
+			writel(press, keypad->base + MA35D1_KPI_KPE0 + bank * 4);
+		if (release)
+			writel(release, keypad->base + MA35D1_KPI_KRE0 + bank * 4);
+	}
+
+	/* Only these two KPISTATUS flags have W1C semantics. */
+	writel(MA35D1_KPI_RST3KEY | MA35D1_KPI_PDWAKE,
+	       keypad->base + MA35D1_KPI_STATUS);
+}
+
+/* Release software key states when hardware scanning is stopped. */
+static void ma35d1_keypad_release_keys(struct ma35d1_keypad *keypad)
+{
+	struct input_dev *input = keypad->input;
+	unsigned int row, col, scan, code;
+	bool reported = false;
+
+	for (row = 0; row < keypad->rows; row++) {
+		for (col = 0; col < keypad->cols; col++) {
+			scan = MATRIX_SCAN_CODE(row, col, keypad->row_shift);
+			code = keypad->keycodes[scan];
+			if (code == KEY_RESERVED || !test_bit(code, input->key))
+				continue;
+
+			input_event(input, EV_MSC, MSC_SCAN, scan);
+			input_report_key(input, code, 0);
+			reported = true;
+		}
+	}
+
+	if (reported)
+		input_sync(input);
+}
+
+/* Called with input->mutex held (open, PM resume). */
+static int ma35d1_keypad_enable(struct ma35d1_keypad *keypad)
+{
+	int error;
+
+	if (keypad->running)
+		return 0;
+
+	error = clk_prepare_enable(keypad->clk);
+	if (error)
+		return error;
+
+	/* Keep hardware three-key reset disabled for a normal input device. */
+	writel(0, keypad->base + MA35D1_KPI_CONF);
+	writel(0, keypad->base + MA35D1_KPI_3KCONF);
+	writel(MA35D1_KPI_DIV_VAL, keypad->base + MA35D1_KPI_PRESCALDIV);
+	ma35d1_keypad_clear_events(keypad);
+	writel(keypad->conf, keypad->base + MA35D1_KPI_CONF);
+
+	keypad->running = true;
+	enable_irq(keypad->irq);
+
+	return 0;
+}
+
+/* Called with input->mutex held (close, PM suspend). */
+static void ma35d1_keypad_disable(struct ma35d1_keypad *keypad)
+{
+	if (!keypad->running)
+		return;
+
+	/* Wait for the IRQ handler while register access is still clocked. */
+	disable_irq(keypad->irq);
+	writel(0, keypad->base + MA35D1_KPI_CONF);
+	ma35d1_keypad_clear_events(keypad);
+	ma35d1_keypad_release_keys(keypad);
+	clk_disable_unprepare(keypad->clk);
+
+	keypad->running = false;
+}
+
+static int ma35d1_keypad_open(struct input_dev *input)
+{
+	struct ma35d1_keypad *keypad = input_get_drvdata(input);
+
+	return ma35d1_keypad_enable(keypad);
+}
+
+static void ma35d1_keypad_close(struct input_dev *input)
+{
+	struct ma35d1_keypad *keypad = input_get_drvdata(input);
+
+	ma35d1_keypad_disable(keypad);
+}
+
+static void ma35d1_keypad_report(struct ma35d1_keypad *keypad,
+				 unsigned int scan, unsigned short keycode,
+				 bool pressed)
+{
+	input_event(keypad->input, EV_MSC, MSC_SCAN, scan);
+	input_report_key(keypad->input, keycode, pressed);
+}
+
+static irqreturn_t ma35d1_keypad_irq(int irq, void *data)
+{
+	struct ma35d1_keypad *keypad = data;
+	struct input_dev *input = keypad->input;
+	bool reported = false;
+	u32 status, pressed, released, events, state;
+	unsigned int bank, bit, row, col, scan;
+	unsigned short keycode;
+	bool key_is_up;
+
+	status = readl(keypad->base + MA35D1_KPI_STATUS);
+	if (!(status & MA35D1_KPI_IRQ_MASK))
+		return IRQ_NONE;
+
+	for (bank = 0; bank < MA35D1_KPI_BANKS; bank++) {
+		pressed = readl(keypad->base + MA35D1_KPI_KPE0 + bank * 4);
+		released = readl(keypad->base + MA35D1_KPI_KRE0 + bank * 4);
+
+		/* Acknowledge the exact snapshots, not KPISTATUS[4:2]. */
+		if (pressed)
+			writel(pressed, keypad->base + MA35D1_KPI_KPE0 + bank * 4);
+		if (released)
+			writel(released, keypad->base + MA35D1_KPI_KRE0 + bank * 4);
+
+		events = pressed | released;
+		if (!events)
+			continue;
+
+		/* The live state is only needed to order a press/release pair. */
+		state = 0;
+		if (pressed & released)
+			state = readl(keypad->base + MA35D1_KPI_KEST0 + bank * 4);
+
+		while (events) {
+			bit = __ffs(events);
+			events &= ~BIT(bit);
+			row = bank * MA35D1_KPI_ROWS_PER_BANK +
+			      bit / MA35D1_KPI_MAX_COLS;
+			col = bit % MA35D1_KPI_MAX_COLS;
+
+			if (row >= keypad->rows || col >= keypad->cols)
+				continue;
+
+			scan = MATRIX_SCAN_CODE(row, col, keypad->row_shift);
+			keycode = keypad->keycodes[scan];
+			if (keycode == KEY_RESERVED)
+				continue;
+
+			if ((pressed & released) & BIT(bit)) {
+				/*
+				 * Both edges were latched before this interrupt
+				 * was serviced.  KEST is active-low (1 means
+				 * released), so use the final state to order
+				 * them: up -> press then release, down ->
+				 * release then press.  Sync in between so user
+				 * space sees two separate frames.
+				 */
+				key_is_up = !!(state & BIT(bit));
+
+				ma35d1_keypad_report(keypad, scan, keycode,
+						     key_is_up);
+				input_sync(input);
+				ma35d1_keypad_report(keypad, scan, keycode,
+						     !key_is_up);
+			} else {
+				ma35d1_keypad_report(keypad, scan, keycode,
+						     !!(pressed & BIT(bit)));
+			}
+			reported = true;
+		}
+	}
+
+	if (status & (MA35D1_KPI_RST3KEY | MA35D1_KPI_PDWAKE))
+		writel(status & (MA35D1_KPI_RST3KEY | MA35D1_KPI_PDWAKE),
+		       keypad->base + MA35D1_KPI_STATUS);
+
+	if (reported)
+		input_sync(input);
+
+	return IRQ_HANDLED;
+}
+
+static int ma35d1_keypad_suspend(struct device *dev)
+{
+	struct ma35d1_keypad *keypad = dev_get_drvdata(dev);
+	struct input_dev *input = keypad->input;
+
+	guard(mutex)(&input->mutex);
+
+	if (input_device_enabled(input))
+		ma35d1_keypad_disable(keypad);
+
+	return 0;
+}
+
+static int ma35d1_keypad_resume(struct device *dev)
+{
+	struct ma35d1_keypad *keypad = dev_get_drvdata(dev);
+	struct input_dev *input = keypad->input;
+	int error;
+
+	guard(mutex)(&input->mutex);
+
+	if (input_device_enabled(input)) {
+		error = ma35d1_keypad_enable(keypad);
+		if (error)
+			return error;
+	}
+
+	return 0;
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(ma35d1_keypad_pm_ops,
+				ma35d1_keypad_suspend, ma35d1_keypad_resume);
+
+static int ma35d1_keypad_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct ma35d1_keypad *keypad;
+	struct input_dev *input;
+	int error;
+
+	keypad = devm_kzalloc(dev, sizeof(*keypad), GFP_KERNEL);
+	if (!keypad)
+		return -ENOMEM;
+
+	error = matrix_keypad_parse_properties(dev, &keypad->rows, &keypad->cols);
+	if (error)
+		return error;
+
+	/* The controller supports 2x1 up to 8x8 keys (KROW = 0 is reserved). */
+	if (keypad->rows < 2 || keypad->rows > MA35D1_KPI_MAX_ROWS ||
+	    !keypad->cols || keypad->cols > MA35D1_KPI_MAX_COLS)
+		return dev_err_probe(dev, -EINVAL, "invalid keypad geometry\n");
+
+	keypad->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(keypad->base))
+		return PTR_ERR(keypad->base);
+
+	keypad->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(keypad->clk))
+		return dev_err_probe(dev, PTR_ERR(keypad->clk),
+				     "failed to get KPI clock\n");
+
+	keypad->irq = platform_get_irq(pdev, 0);
+	if (keypad->irq < 0)
+		return keypad->irq;
+
+	input = devm_input_allocate_device(dev);
+	if (!input)
+		return -ENOMEM;
+
+	keypad->input = input;
+	keypad->row_shift = get_count_order(keypad->cols);
+	keypad->conf = FIELD_PREP(MA35D1_KPI_KROW, keypad->rows - 1) |
+		       FIELD_PREP(MA35D1_KPI_KCOL, keypad->cols - 1) |
+		       FIELD_PREP(MA35D1_KPI_DBCLKSEL, MA35D1_KPI_DEBOUNCE_SEL) |
+		       FIELD_PREP(MA35D1_KPI_PRESCALE, MA35D1_KPI_PRESCALE_VAL) |
+		       MA35D1_KPI_INTEN | MA35D1_KPI_RKINTEN |
+		       MA35D1_KPI_PKINTEN | MA35D1_KPI_ENKP;
+
+	input->name = "Nuvoton MA35D1 Keypad";
+	input->id.bustype = BUS_HOST;
+	input->open = ma35d1_keypad_open;
+	input->close = ma35d1_keypad_close;
+
+	error = matrix_keypad_build_keymap(NULL, NULL, keypad->rows,
+					   keypad->cols, NULL, input);
+	if (error)
+		return dev_err_probe(dev, error, "failed to build keymap\n");
+
+	keypad->keycodes = input->keycode;
+	input_set_capability(input, EV_MSC, MSC_SCAN);
+	if (device_property_read_bool(dev, "autorepeat"))
+		__set_bit(EV_REP, input->evbit);
+
+	input_set_drvdata(input, keypad);
+	platform_set_drvdata(pdev, keypad);
+
+	/*
+	 * Clear whatever the bootloader left behind before the IRQ can be
+	 * requested.  The clock must run for the registers to be accessible.
+	 */
+	error = clk_prepare_enable(keypad->clk);
+	if (error)
+		return dev_err_probe(dev, error, "failed to enable KPI clock\n");
+
+	writel(0, keypad->base + MA35D1_KPI_CONF);
+	ma35d1_keypad_clear_events(keypad);
+
+	clk_disable_unprepare(keypad->clk);
+
+	/* The IRQ stays disabled while the peripheral clock is gated. */
+	error = devm_request_irq(dev, keypad->irq, ma35d1_keypad_irq,
+				 IRQF_NO_AUTOEN, dev_name(dev), keypad);
+	if (error)
+		return dev_err_probe(dev, error, "failed to request IRQ\n");
+
+	error = input_register_device(input);
+	if (error)
+		return dev_err_probe(dev, error, "failed to register input device\n");
+
+	return 0;
+}
+
+static const struct of_device_id ma35d1_keypad_of_match[] = {
+	{ .compatible = "nuvoton,ma35d1-keypad" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ma35d1_keypad_of_match);
+
+static struct platform_driver ma35d1_keypad_driver = {
+	.probe = ma35d1_keypad_probe,
+	.driver = {
+		.name = "ma35d1-keypad",
+		.of_match_table = ma35d1_keypad_of_match,
+		.pm = pm_sleep_ptr(&ma35d1_keypad_pm_ops),
+	},
+};
+module_platform_driver(ma35d1_keypad_driver);
+
+MODULE_DESCRIPTION("Nuvoton MA35D1 hardware matrix keypad controller");
+MODULE_LICENSE("GPL");
-- 
2.43.0

