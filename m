From: Ludovic Desroches <ludovic.desroches-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Subject: [PATCH 1/4] input: misc: introduce Atmel PTC driver
Date: Fri, 31 Mar 2017 17:22:47 +0200
Message-ID: <20170331152250.12758-2-ludovic.desroches@microchip.com>
References: <20170331152250.12758-1-ludovic.desroches@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170331152250.12758-1-ludovic.desroches-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

From: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>

Signed-off-by: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
---
 drivers/input/misc/Kconfig     |  12 +
 drivers/input/misc/Makefile    |   1 +
 drivers/input/misc/atmel_ptc.c | 651 +++++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/atmel_ptc.h | 355 ++++++++++++++++++++++
 4 files changed, 1019 insertions(+)
 create mode 100644 drivers/input/misc/atmel_ptc.c
 create mode 100644 include/uapi/linux/atmel_ptc.h

diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index 5b6c522..aec7b8f 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -96,6 +96,18 @@ config INPUT_ATMEL_CAPTOUCH
 	  To compile this driver as a module, choose M here: the
 	  module will be called atmel_captouch.
 
+config INPUT_ATMEL_PTC
+	tristate "Atmel PTC Driver"
+	depends on OF || COMPILE_TEST
+	depends on SOC_SAMA5D2
+	help
+	  Say Y to enable support for the Atmel PTC Subsystem.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called atmel_ptc.
+	  If you compile it as a built-in driver, you have to build the
+	  firmware into the kernel or to use an initrd.
+
 config INPUT_BMA150
 	tristate "BMA150/SMB380 acceleration sensor support"
 	depends on I2C
diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
index b10523f..9470ec7 100644
--- a/drivers/input/misc/Makefile
+++ b/drivers/input/misc/Makefile
@@ -18,6 +18,7 @@ obj-$(CONFIG_INPUT_ARIZONA_HAPTICS)	+= arizona-haptics.o
 obj-$(CONFIG_INPUT_ATI_REMOTE2)		+= ati_remote2.o
 obj-$(CONFIG_INPUT_ATLAS_BTNS)		+= atlas_btns.o
 obj-$(CONFIG_INPUT_ATMEL_CAPTOUCH)	+= atmel_captouch.o
+obj-$(CONFIG_INPUT_ATMEL_PTC)		+= atmel_ptc.o
 obj-$(CONFIG_INPUT_BFIN_ROTARY)		+= bfin_rotary.o
 obj-$(CONFIG_INPUT_BMA150)		+= bma150.o
 obj-$(CONFIG_INPUT_CM109)		+= cm109.o
diff --git a/drivers/input/misc/atmel_ptc.c b/drivers/input/misc/atmel_ptc.c
new file mode 100644
index 0000000..44df1bf
--- /dev/null
+++ b/drivers/input/misc/atmel_ptc.c
@@ -0,0 +1,651 @@
+/*
+ * Atmel PTC subsystem driver for SAMA5D2 devices and compatible.
+ *
+ * Copyright (C) 2017 Microchip,
+ *               2017 Ludovic Desroches <ludovic.desroches-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/cdev.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/firmware.h>
+#include <linux/input.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+#include <linux/uaccess.h>
+
+#include <uapi/linux/atmel_ptc.h>
+
+#define ATMEL_QTM_MB_OFFSET	0x4000
+
+/* ----- PPP REGISTERS ----- */
+#define ATMEL_PPP_CONFIG	0x20
+#define ATMEL_PPP_CTRL		0x24
+#define ATMEL_PPP_CMD		0x28
+#define		ATMEL_PPP_CMD_STOP		0x1
+#define		ATMEL_PPP_CMD_RESET		0x2
+#define		ATMEL_PPP_CMD_RESTART		0x3
+#define		ATMEL_PPP_CMD_ABORT		0x4
+#define		ATMEL_PPP_CMD_RUN		0x5
+#define		ATMEL_PPP_CMD_RUN_LOCKED	0x6
+#define		ATMEL_PPP_CMD_RUN_OCD		0x7
+#define		ATMEL_PPP_CMD_UNLOCK		0x8
+#define		ATMEL_PPP_CMD_NMI		0x9
+#define		ATMEL_PPP_CMD_HOST_OCD_RESUME	0xB
+#define ATMEL_PPP_ISR		0x33
+#define		ATMEL_PPP_IRQ_MASK	GENMASK(7, 4)
+#define		ATMEL_PPP_IRQ0		BIT(4)
+#define		ATMEL_PPP_IRQ1		BIT(5)
+#define		ATMEL_PPP_IRQ2		BIT(6)
+#define		ATMEL_PPP_IRQ3		BIT(7)
+#define		ATMEL_PPP_NOTIFY_MASK	GENMASK(3, 0)
+#define		ATMEL_PPP_NOTIFY0	BIT(0)
+#define		ATMEL_PPP_NOTIFY1	BIT(1)
+#define		ATMEL_PPP_NOTIFY2	BIT(2)
+#define		ATMEL_PPP_NOTIFY3	BIT(3)
+#define ATMEL_PPP_IDR		0x34
+#define ATMEL_PPP_IER		0x35
+
+#define PPP_FIRMWARE_NAME	"atmel_ptc.bin"
+#define QTM_CONF_NAME		"atmel_ptc.conf"
+
+#define atmel_ppp_readb(ptc, reg)	readb_relaxed(ptc->ppp_regs + reg)
+#define atmel_ppp_writeb(ptc, reg, val)	writeb_relaxed(val, ptc->ppp_regs + reg)
+#define atmel_ppp_readl(ptc, reg)	readl_relaxed(ptc->ppp_regs + reg)
+#define atmel_ppp_writel(ptc, reg, val)	writel_relaxed(val, ptc->ppp_regs + reg)
+
+#define get_scroller_resolution(ptc, scroller_id) \
+	(1 << (ptc->qtm_mb->scroller_config[i].resol_deadband >> 4))
+
+struct atmel_ptc {
+	void __iomem		*ppp_regs;
+	void __iomem		*firmware;
+	int			irq;
+	uint8_t			imr;
+	volatile struct atmel_qtm_mailbox __iomem	*qtm_mb;
+	struct clk		*clk_per;
+	struct clk		*clk_int_osc;
+	struct clk		*clk_slow;
+	struct device		*dev;
+	struct completion	ppp_ack;
+	unsigned int		button_keycode[ATMEL_PTC_MAX_NODES];
+	struct input_dev	*buttons_input;
+	struct input_dev	*scroller_input[ATMEL_PTC_MAX_SCROLLERS];
+	bool			buttons_registered;
+	bool			scroller_registered[ATMEL_PTC_MAX_SCROLLERS];
+	uint32_t		button_event[ATMEL_PTC_MAX_NODES/32];
+	uint32_t		button_state[ATMEL_PTC_MAX_NODES/32];
+	uint32_t		scroller_event;
+	uint32_t		scroller_state;
+};
+
+static void atmel_ppp_irq_enable(struct atmel_ptc *ptc, uint8_t mask)
+{
+	ptc->imr |= mask;
+	atmel_ppp_writeb(ptc, ATMEL_PPP_IER, mask & ATMEL_PPP_IRQ_MASK);
+}
+
+static void atmel_ppp_irq_disable(struct atmel_ptc *ptc, uint8_t mask)
+{
+	ptc->imr &= ~mask;
+	atmel_ppp_writeb(ptc, ATMEL_PPP_IDR, mask & ATMEL_PPP_IRQ_MASK);
+}
+
+static void atmel_ppp_notify(struct atmel_ptc *ptc, uint8_t mask)
+{
+	if (mask & ATMEL_PPP_NOTIFY_MASK) {
+		uint8_t notify = atmel_ppp_readb(ptc, ATMEL_PPP_ISR)
+			    | (mask & ATMEL_PPP_NOTIFY_MASK);
+
+		atmel_ppp_writeb(ptc, ATMEL_PPP_ISR, notify);
+	}
+}
+
+static void atmel_ppp_irq_pending_clr(struct atmel_ptc *ptc, uint8_t mask)
+{
+	if (mask & ATMEL_PPP_IRQ_MASK) {
+		uint8_t irq = atmel_ppp_readb(ptc, ATMEL_PPP_ISR) & ~mask;
+
+		atmel_ppp_writeb(ptc, ATMEL_PPP_ISR, irq);
+	}
+}
+
+static void atmel_ppp_cmd_send(struct atmel_ptc *ptc, uint32_t cmd)
+{
+	atmel_ppp_writel(ptc, ATMEL_PPP_CMD, cmd);
+}
+
+static void atmel_ppp_irq_scroller_event(struct atmel_ptc *ptc)
+{
+	int i;
+
+	if (!ptc->scroller_event)
+		return;
+
+	for (i = 0; i < ATMEL_PTC_MAX_SCROLLERS; i++) {
+		uint32_t mask = 1 << i;
+		uint8_t status;
+		uint16_t position;
+
+		if (!(ptc->scroller_event & mask))
+			continue;
+
+		status = ptc->qtm_mb->scroller_data[i].status;
+		position = ptc->qtm_mb->scroller_data[i].position;
+
+		if (ptc->qtm_mb->scroller_config[i].type ==
+			    QTM_SCROLLER_TYPE_WHEEL)
+			input_report_abs(ptc->scroller_input[i],
+					 ABS_WHEEL, position);
+		else
+			input_report_abs(ptc->scroller_input[i],
+					 ABS_X, position);
+
+		input_report_key(ptc->scroller_input[i], BTN_TOUCH, status & 0x1);
+		input_sync(ptc->scroller_input[i]);
+	}
+}
+
+static void atmel_ppp_irq_button_event(struct atmel_ptc *ptc)
+{
+	int i, j;
+
+	for (i = 0; i < ATMEL_PTC_MAX_NODES / 32; i++) {
+		if (!ptc->button_event[i])
+			continue;
+
+		for (j = 0; j < 32; j++) {
+			uint32_t mask = 1 << j;
+			uint32_t state = ptc->button_state[i] & mask;
+			unsigned int key_id = i * 32 + j;
+
+			if (!(ptc->button_event[i] & mask))
+				continue;
+
+			input_report_key(ptc->buttons_input,
+					 ptc->button_keycode[key_id], !!state);
+			input_sync(ptc->buttons_input);
+		}
+	}
+}
+
+static void atmel_ppp_irq_touch_event(struct atmel_ptc *ptc)
+{
+	atmel_ppp_irq_scroller_event(ptc);
+	atmel_ppp_irq_button_event(ptc);
+}
+
+static irqreturn_t atmel_ppp_irq_handler(int irq, void *data)
+{
+	struct atmel_ptc *ptc = data;
+	uint32_t isr = atmel_ppp_readb(ptc, ATMEL_PPP_ISR) & ptc->imr;
+
+	/* QTM CMD acknowledgment */
+	if (isr & ATMEL_PPP_IRQ0) {
+		atmel_ppp_irq_disable(ptc, ATMEL_PPP_IRQ0);
+		atmel_ppp_irq_pending_clr(ptc, ATMEL_PPP_IRQ0);
+		complete(&ptc->ppp_ack);
+	}
+	/* QTM touch event */
+	if (isr & ATMEL_PPP_IRQ1) {
+		int i;
+
+		for (i = 0; i < ATMEL_PTC_MAX_NODES / 32; i++) {
+			ptc->button_event[i] = ptc->qtm_mb->touch_events.key_event_id[i];
+			ptc->button_state[i] = ptc->qtm_mb->touch_events.key_enable_state[i];
+		}
+		ptc->scroller_event = ptc->qtm_mb->touch_events.scroller_event_id;
+		ptc->scroller_state = ptc->qtm_mb->touch_events.scroller_event_state;
+
+		atmel_ppp_irq_pending_clr(ptc, ATMEL_PPP_IRQ1);
+
+		atmel_ppp_irq_touch_event(ptc);
+	}
+	/* Debug event */
+	if (isr & ATMEL_PPP_IRQ2) {
+		atmel_ppp_irq_pending_clr(ptc, ATMEL_PPP_IRQ2);
+	}
+
+	return IRQ_HANDLED;
+}
+
+uint32_t atmel_qtm_cmd_send(struct atmel_ptc *ptc, struct atmel_qtm_cmd *cmd)
+{
+	int i, ret;
+
+	dev_dbg(ptc->dev, "%s: cmd=0x%x, addr=0x%x, data=0x%x\n",
+		__func__, cmd->id, cmd->addr, cmd->data);
+
+	ptc->qtm_mb->cmd.id = cmd->id;
+	ptc->qtm_mb->cmd.addr = cmd->addr;
+	ptc->qtm_mb->cmd.data = cmd->data;
+
+	/* Once command performed, we'll get an IRQ. */
+	atmel_ppp_irq_enable(ptc, ATMEL_PPP_IRQ0);
+	/* Notify PPP that we have sent a command. */
+	atmel_ppp_notify(ptc, ATMEL_PPP_NOTIFY0);
+	/* Wait for IRQ from PPP. */
+	wait_for_completion(&ptc->ppp_ack);
+
+	/*
+	 * Register input devices only when QTM is started since we need some
+	 * information from the QTM configuration.
+	 */
+	if (cmd->id == QTM_CMD_RUN) {
+		if (ptc->buttons_input && !ptc->buttons_registered) {
+			ret = input_register_device(ptc->buttons_input);
+			if (ret)
+				dev_err(ptc->dev, "can't register input button device.\n");
+			else
+				ptc->buttons_registered = true;
+		}
+
+		for (i = 0; i < ATMEL_PTC_MAX_SCROLLERS; i++) {
+			struct input_dev *scroller = ptc->scroller_input[i];
+
+			if (!scroller || ptc->scroller_registered[i])
+				continue;
+			if (ptc->qtm_mb->scroller_config[i].type ==
+			    QTM_SCROLLER_TYPE_SLIDER) {
+				unsigned int max = get_scroller_resolution(ptc, i);
+
+				input_set_abs_params(scroller, 0, 0, max, 0, 0);
+			}
+			ret = input_register_device(scroller);
+			if (ret)
+				dev_err(ptc->dev, "can't register input scroller device.\n");
+			else
+				ptc->scroller_registered[i] = true;
+		}
+	}
+
+	return ptc->qtm_mb->cmd.data;
+}
+
+static inline struct atmel_ptc *kobj_to_atmel_ptc(struct kobject *kobj)
+{
+	struct device *dev = kobj_to_dev(kobj);
+
+	return dev->driver_data;
+}
+
+static ssize_t atmel_qtm_mb_read(struct file *filp, struct kobject *kobj,
+				 struct bin_attribute *attr,
+				 char *buf, loff_t off, size_t count)
+{
+	struct atmel_ptc *ptc = kobj_to_atmel_ptc(kobj);
+	char *qtm_mb = (char *)ptc->qtm_mb;
+
+	dev_dbg(ptc->dev, "%s: off=0x%llx, count=%zu\n", __func__, off, count);
+
+	memcpy(buf, qtm_mb + off, count);
+
+	return count;
+}
+
+static ssize_t atmel_qtm_mb_write(struct file *filp, struct kobject *kobj,
+				  struct bin_attribute *attr,
+				  char *buf, loff_t off, size_t count)
+{
+	struct atmel_ptc *ptc = kobj_to_atmel_ptc(kobj);
+	char *qtm_mb = (char *)ptc->qtm_mb;
+
+	dev_dbg(ptc->dev, "%s: off=0x%llx, count=%zu\n", __func__, off, count);
+
+	if (off == 0 && count == sizeof(struct atmel_qtm_cmd))
+		atmel_qtm_cmd_send(ptc, (struct atmel_qtm_cmd *)buf);
+	else
+		memcpy(qtm_mb + off, buf, count);
+
+	return count;
+}
+
+static struct bin_attribute atmel_ptc_qtm_mb_attr = {
+	.attr = {
+		.name = "qtm_mb",
+		.mode = 0644,
+	},
+	.size = sizeof(struct atmel_qtm_mailbox),
+	.read = atmel_qtm_mb_read,
+	.write = atmel_qtm_mb_write,
+};
+
+/*
+ * From QTM MB configuration, we can't retrieve all the information needed
+ * to setup correctly input devices: buttons key codes and slider axis are
+ * missing.
+ */
+static int atmel_ptc_of_parse(struct atmel_ptc *ptc)
+{
+	struct device_node *sensor;
+	bool first_button = true;
+
+	/* Parse sensors. */
+	for_each_child_of_node(ptc->dev->of_node, sensor) {
+		if (!strcmp(sensor->name, "button")) {
+			uint32_t key_id, keycode;
+			struct input_dev *buttons = ptc->buttons_input;
+
+			if (of_property_read_u32(sensor, "reg", &key_id)) {
+				dev_err(ptc->dev, "reg is missing (%s)\n",
+					sensor->full_name);
+				return -EINVAL;
+			}
+
+			if (of_property_read_u32(sensor, "linux,keycode", &keycode)) {
+				dev_err(ptc->dev, "linux,keycode is missing (%s)\n",
+					sensor->full_name);
+				return -EINVAL;
+			}
+			ptc->button_keycode[key_id] = keycode;
+
+			/* All buttons are put together in a keyboard device. */
+			if (first_button) {
+				buttons = devm_input_allocate_device(ptc->dev);
+				if (!buttons)
+					return -ENOMEM;
+				buttons->name = "atmel_ptc_buttons";
+				buttons->dev.parent = ptc->dev;
+				buttons->keycode = ptc->button_keycode;
+				buttons->keycodesize = sizeof(ptc->button_keycode[0]);
+				buttons->keycodemax = ATMEL_PTC_MAX_NODES;
+				ptc->buttons_input = buttons;
+				first_button = false;
+			}
+
+			input_set_capability(buttons, EV_KEY, keycode);
+		} else if (!strcmp(sensor->name, "slider") ||
+			   !strcmp(sensor->name, "wheel")) {
+			uint32_t scroller_id;
+			struct input_dev *scroller;
+
+			if (of_property_read_u32(sensor, "reg", &scroller_id)) {
+				dev_err(ptc->dev, "reg is missing (%s)\n",
+					sensor->full_name);
+				return -EINVAL;
+			}
+
+			if (scroller_id > ATMEL_PTC_MAX_SCROLLERS - 1) {
+				dev_err(ptc->dev, "wrong scroller id (%s)\n",
+					sensor->full_name);
+				return -EINVAL;
+			}
+
+			scroller = devm_input_allocate_device(ptc->dev);
+			if (!scroller)
+				return -ENOMEM;
+
+			scroller->dev.parent = ptc->dev;
+			ptc->scroller_input[scroller_id] = scroller;
+
+			if (!strcmp(sensor->name, "slider")) {
+				scroller->name = "atmel_ptc_slider";
+				input_set_capability(scroller, EV_ABS, ABS_X);
+				input_set_capability(scroller, EV_KEY, BTN_TOUCH);
+			} else {
+				scroller->name = "atmel_ptc_wheel";
+				input_set_capability(scroller, EV_ABS, ABS_WHEEL);
+				input_set_capability(scroller, EV_KEY, BTN_TOUCH);
+			}
+		} else {
+			dev_err(ptc->dev, "%s is not supported\n", sensor->name);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+static void atmel_qtm_conf_callback(const struct firmware *conf, void *context)
+{
+	struct atmel_ptc *ptc = context;
+	unsigned int qtm_conf_size = sizeof(struct atmel_qtm_mailbox)
+		- offsetof(struct atmel_qtm_mailbox, node_group_config);
+	struct atmel_qtm_cmd qtm_cmd;
+	char *dst;
+
+	if (!conf) {
+		dev_err(ptc->dev, "cannot load QTM configuration, "
+			"it has to be set manually.\n");
+		return;
+	}
+
+	if (!conf->size || conf->size != qtm_conf_size) {
+		dev_err(ptc->dev, "incorrect QTM configuration file (size must be %u bytes), "
+			"configuration has to be set manually.\n", qtm_conf_size);
+		return;
+	}
+
+	atmel_ppp_irq_enable(ptc, ATMEL_PPP_IRQ1);
+	atmel_ppp_irq_disable(ptc, ATMEL_PPP_IRQ2 | ATMEL_PPP_IRQ3);
+
+	qtm_cmd.id = QTM_CMD_STOP;
+	atmel_qtm_cmd_send(ptc, &qtm_cmd);
+
+	/* Load QTM configuration. */
+	dst = (char *)ptc->qtm_mb +
+		offsetof(struct atmel_qtm_mailbox, node_group_config);
+	_memcpy_toio(dst, conf->data, qtm_conf_size);
+	release_firmware(conf);
+
+	if (atmel_ptc_of_parse(ptc))
+		dev_err(ptc->dev, "ptc_of_parse failed\n");
+
+	/* Start QTM. */
+	qtm_cmd.id = QTM_CMD_INIT;
+	qtm_cmd.data = ptc->qtm_mb->node_group_config.count;
+	atmel_qtm_cmd_send(ptc, &qtm_cmd);
+	qtm_cmd.id = QTM_CMD_SET_ACQ_MODE_TIMER;
+	qtm_cmd.data = 20;
+	atmel_qtm_cmd_send(ptc, &qtm_cmd);
+	qtm_cmd.id = QTM_CMD_RUN;
+	qtm_cmd.data = ptc->qtm_mb->node_group_config.count;
+	atmel_qtm_cmd_send(ptc, &qtm_cmd);
+}
+
+static void atmel_ppp_fw_callback(const struct firmware *fw, void *context)
+{
+	struct atmel_ptc *ptc = context;
+	int ret;
+	uint32_t firm_version;
+	struct atmel_qtm_cmd cmd;
+
+	if (!fw || !fw->size) {
+		dev_err(ptc->dev, "cannot load firmware.\n");
+		release_firmware(fw);
+		device_release_driver(ptc->dev);
+		return;
+	}
+
+	/* Command sequence to start from a clean state. */
+	atmel_ppp_cmd_send(ptc, ATMEL_PPP_CMD_ABORT);
+	atmel_ppp_irq_pending_clr(ptc, ATMEL_PPP_IRQ_MASK);
+	atmel_ppp_cmd_send(ptc, ATMEL_PPP_CMD_RESET);
+
+	_memcpy_toio(ptc->firmware, fw->data, fw->size);
+	release_firmware(fw);
+
+	atmel_ppp_cmd_send(ptc, ATMEL_PPP_CMD_RUN);
+
+	cmd.id = QTM_CMD_FIRM_VERSION;
+	firm_version = atmel_qtm_cmd_send(ptc, &cmd);
+	dev_info(ptc->dev, "firmware version: %u\n", firm_version);
+
+	/* PPP is running, it's time to load the QTM configuration. */
+	ret = request_firmware_nowait(THIS_MODULE, 1, QTM_CONF_NAME, ptc->dev,
+				      GFP_KERNEL, ptc, atmel_qtm_conf_callback);
+	if (ret)
+		dev_err(ptc->dev, "QTM configuration loading failed.\n");
+}
+
+static int atmel_ptc_probe(struct platform_device *pdev)
+{
+	struct atmel_ptc *ptc;
+	struct resource	*res;
+	void *shared_memory;
+	int ret;
+
+	ptc = devm_kzalloc(&pdev->dev, sizeof(*ptc), GFP_KERNEL);
+	if (!ptc)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, ptc);
+	ptc->dev = &pdev->dev;
+	ptc->dev->driver_data = ptc;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -ENODEV;
+
+	shared_memory = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(shared_memory))
+		return PTR_ERR(shared_memory);
+
+	ptc->firmware = shared_memory;
+	ptc->qtm_mb = shared_memory + ATMEL_QTM_MB_OFFSET;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	if (!res)
+		return -EINVAL;
+
+	ptc->ppp_regs = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(ptc->ppp_regs))
+		return PTR_ERR(ptc->ppp_regs);
+
+	ptc->irq = platform_get_irq(pdev, 0);
+	if (ptc->irq <= 0) {
+		if (!ptc->irq)
+			ptc->irq = -ENXIO;
+
+		return ptc->irq;
+	}
+
+	ptc->clk_per = devm_clk_get(&pdev->dev, "ptc_clk");
+	if (IS_ERR(ptc->clk_per))
+		return PTR_ERR(ptc->clk_per);
+
+	ptc->clk_int_osc = devm_clk_get(&pdev->dev, "ptc_int_osc");
+	if (IS_ERR(ptc->clk_int_osc))
+		return PTR_ERR(ptc->clk_int_osc);
+
+	ptc->clk_slow = devm_clk_get(&pdev->dev, "slow_clk");
+	if (IS_ERR(ptc->clk_slow))
+		return PTR_ERR(ptc->clk_slow);
+
+	ret = devm_request_irq(&pdev->dev, ptc->irq, atmel_ppp_irq_handler, 0,
+			       pdev->dev.driver->name, ptc);
+	if (ret)
+		return ret;
+
+	ret = clk_prepare_enable(ptc->clk_int_osc);
+	if (ret)
+		return ret;
+
+	ret = clk_prepare_enable(ptc->clk_per);
+	if (ret)
+		goto disable_clk_int_osc;
+
+	ret = clk_prepare_enable(ptc->clk_slow);
+	if (ret)
+		goto disable_clk_per;
+
+	/* Needed to avoid unexpected behaviors. */
+	memset(ptc->firmware, 0, ATMEL_QTM_MB_OFFSET + sizeof(*ptc->qtm_mb));
+	ptc->imr = 0;
+	init_completion(&ptc->ppp_ack);
+
+	/*
+	 * Expose a file to give an access to the QTM mailbox to a user space
+	 * application in order to configure it or to send commands.
+	 */
+	ret = sysfs_create_bin_file(&pdev->dev.kobj, &atmel_ptc_qtm_mb_attr);
+	if (ret)
+		goto disable_clk_slow;
+
+	ret = request_firmware_nowait(THIS_MODULE, 1, PPP_FIRMWARE_NAME,
+				      ptc->dev, GFP_KERNEL, ptc,
+				      atmel_ppp_fw_callback);
+	if (ret) {
+		dev_err(&pdev->dev, "firmware loading failed\n");
+		ret = -EPROBE_DEFER;
+		goto remove_qtm_mb;
+	}
+
+	return 0;
+
+remove_qtm_mb:
+	sysfs_remove_bin_file(&pdev->dev.kobj, &atmel_ptc_qtm_mb_attr);
+disable_clk_slow:
+	clk_disable_unprepare(ptc->clk_slow);
+disable_clk_per:
+	clk_disable_unprepare(ptc->clk_per);
+disable_clk_int_osc:
+	clk_disable_unprepare(ptc->clk_int_osc);
+
+	return ret;
+}
+
+static int atmel_ptc_remove(struct platform_device *pdev)
+{
+	struct atmel_ptc *ptc = platform_get_drvdata(pdev);
+	int i;
+
+	if (ptc->buttons_registered)
+		input_unregister_device(ptc->buttons_input);
+
+	for (i = 0; i < ATMEL_PTC_MAX_SCROLLERS; i++) {
+		struct input_dev *scroller = ptc->scroller_input[i];
+
+		if (!scroller || !ptc->scroller_registered[i])
+			continue;
+		input_unregister_device(scroller);
+	}
+
+	sysfs_remove_bin_file(&pdev->dev.kobj, &atmel_ptc_qtm_mb_attr);
+	clk_disable_unprepare(ptc->clk_slow);
+	clk_disable_unprepare(ptc->clk_per);
+	clk_disable_unprepare(ptc->clk_int_osc);
+
+	return 0;
+}
+
+static const struct of_device_id atmel_ptc_dt_match[] = {
+	{
+		.compatible = "atmel,sama5d2-ptc",
+	}, {
+		/* sentinel */
+	}
+};
+MODULE_DEVICE_TABLE(of, atmel_ptc_dt_match);
+
+static struct platform_driver atmel_ptc_driver = {
+	.probe = atmel_ptc_probe,
+	.remove = atmel_ptc_remove,
+	.driver = {
+		.name = "atmel_ptc",
+		.of_match_table = atmel_ptc_dt_match,
+	},
+};
+module_platform_driver(atmel_ptc_driver)
+
+MODULE_AUTHOR("Ludovic Desroches <ludovic.desroches-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>");
+MODULE_DESCRIPTION("Atmel PTC subsystem");
+MODULE_LICENSE("GPL v2");
+MODULE_FIRMWARE(PPP_FIRMWARE_NAME);
+MODULE_FIRMWARE(QTM_CONF_NAME);
diff --git a/include/uapi/linux/atmel_ptc.h b/include/uapi/linux/atmel_ptc.h
new file mode 100644
index 0000000..d15c4df
--- /dev/null
+++ b/include/uapi/linux/atmel_ptc.h
@@ -0,0 +1,355 @@
+/*
+ * Atmel PTC subsystem driver for SAMA5D2 devices and compatible.
+ *
+ * Copyright (C) 2017 Microchip,
+ *               2017 Ludovic Desroches <ludovic.desroches-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#ifndef _LINUX_ATMEL_PTC_H
+#define _LINUX_ATMEL_PTC_H
+
+#ifdef __KERNEL__
+#include <linux/types.h>
+#else
+#include <stdint.h>
+#endif
+
+#define ATMEL_PTC_MAX_NODES	64
+#define ATMEL_PTC_MAX_SCROLLERS	4
+
+enum atmel_qtm_command {
+	QTM_CMD_FIRM_VERSION		= 8,
+	QTM_CMD_ACQ			= 17,
+	QTM_CMD_INIT			= 18,
+	QTM_CMD_RUN			= 19,
+	QTM_CMD_STATUS			= 20,
+	QTM_CMD_STOP			= 21,
+	QTM_CMD_UPDATE_TOUCH_CFG	= 22,
+	QTM_CMD_SET_ACQ_MODE_ON_DEMAND	= 23,
+	QTM_CMD_SET_ACQ_MODE_TIMER	= 24,
+	QTM_CMD_SET_ACQ_MODE_WCOMP	= 25,
+	QTM_CMD_SET_TIMER_INTERVAL	= 26,
+	QTM_CMD_STOP_TIMER		= 27,
+	QTM_CMD_START_TIMER		= 28,
+	QTM_CMD_RESET			= 29,
+};
+
+enum atmel_ptc_type {
+	PTC_TYPE_MUTUAL		= 0x40,
+	PTC_TYPE_SELFCAP	= 0x80,
+};
+
+enum atmel_ptc_scroller_type {
+	QTM_SCROLLER_TYPE_SLIDER,
+	QTM_SCROLLER_TYPE_WHEEL,
+};
+
+enum atmel_ptc_scan {
+	PTC_SCAN_EXTINT_0	= 1,
+	PTC_SCAN_TC2_COMPA	= 2,
+	PTC_SCAN_TC2_OVF	= 3,
+	PTC_SCAN_4MS		= 8,
+	PTC_SCAN_8MS		= 9,
+	PTC_SCAN_16MS		= 10,
+	PTC_SCAN_32MS		= 11,
+	PTC_SCAN_64MS		= 12,
+	PTC_SCAN_128MS		= 13,
+	PTC_SCAN_256MS		= 14,
+};
+
+enum atmel_ptc_cal_charge {
+	PTC_CAL_CHRG_2TAU,
+	PTC_CAL_CHRG_3TAU,
+	PTC_CAL_CHRG_4TAU,
+	PTC_CAL_CHRG_5TAU,
+};
+
+enum atmel_ptc_cal_auto_tune {
+	PTC_CAL_AUTO_TUNE_NONE,
+	PTC_CAL_AUTO_TUNE_RSEL,
+	PTC_CAL_AUTO_TUNE_PRSC,
+	PTC_CAL_AUTO_TUNE_CSD,
+};
+
+enum atmel_qtm_key_state {
+	QTM_KEY_STATE_DISABLE,
+	QTM_KEY_STATE_INIT,
+	QTM_KEY_STATE_CAL,
+	QTM_KEY_STATE_NO_DET,
+	QTM_KEY_STATE_FILT_IN,
+	QTM_KEY_STATE_ANTI_TCH,
+	QTM_KEY_STATE_SUSPEND,
+	QTM_KEY_STATE_DETECT	= 133,
+	QTM_KEY_STATE_FILT_OUT,
+};
+
+/*
+ * PTC acquisition frequency delay setting.
+ *
+ * The PTC acquisition frequency is dependent on the Generic clock
+ * input to PTC and PTC clock prescaler setting. This delay setting
+ * inserts "n" PTC clock cycles between consecutive measurements on
+ * a given sensor, thereby changing the PTC acquisition frequency.
+ * FREQ_HOP_SEL_1 setting inserts 1 PTC clock cycle between consecutive
+ * measurements. FREQ_HOP_SEL_14 setting inserts 14 PTC clock cycles.
+ * Hence, higher delay setting will increase the total time taken for
+ * capacitance measurement on a given sensor as compared to a lower
+ * delay setting.
+ *
+ * A desired setting can be used to avoid noise around the same frequency
+ * as the acquisition frequency.
+ */
+enum atmel_ptc_freq_sel {
+	PTC_FREQ_SEL_0,
+	PTC_FREQ_SEL_1,
+	PTC_FREQ_SEL_2,
+	PTC_FREQ_SEL_3,
+	PTC_FREQ_SEL_4,
+	PTC_FREQ_SEL_5,
+	PTC_FREQ_SEL_6,
+	PTC_FREQ_SEL_7,
+	PTC_FREQ_SEL_8,
+	PTC_FREQ_SEL_9,
+	PTC_FREQ_SEL_10,
+	PTC_FREQ_SEL_11,
+	PTC_FREQ_SEL_12,
+	PTC_FREQ_SEL_13,
+	PTC_FREQ_SEL_14,
+	PTC_FREQ_SEL_15,
+	PTC_FREQ_SEL_SPREAD,
+};
+
+/*
+ * Series resistor setting. For Mutual cap mode, this series
+ * resistor is switched internally on the Y-pin. For Self cap mode,
+ * this series resistor is switched internally on the Sensor pin.
+ */
+enum atmel_ptc_rsel_val {
+	PTC_RSEL_0,
+	PTC_RSEL_20,
+	PTC_RSEL_50,
+	PTC_RSEL_100,
+};
+
+enum atmel_ptc_prsc_div_sel {
+	PTC_PRSC_DIV_1,
+	PTC_PRSC_DIV_2,
+	PTC_PRSC_DIV_4,
+	PTC_PRSC_DIV_8,
+};
+
+enum atmel_ptc_gain {
+	PTC_GAIN_1,
+	PTC_GAIN_2,
+	PTC_GAIN_4,
+	PTC_GAIN_8,
+	PTC_GAIN_16,
+	PTC_GAIN_32,
+};
+
+enum atmel_ptc_filter_level {
+	PTC_FILTER_LEVEL_1,
+	PTC_FILTER_LEVEL_2,
+	PTC_FILTER_LEVEL_4,
+	PTC_FILTER_LEVEL_8,
+	PTC_FILTER_LEVEL_16,
+	PTC_FILTER_LEVEL_32,
+	PTC_FILTER_LEVEL_64,
+};
+
+enum atmel_ptc_aks_group {
+	QTM_KEY_NO_AKS_GROUP,
+	QTM_KEY_AKS_GROUP_1,
+	QTM_KEY_AKS_GROUP_2,
+	QTM_KEY_AKS_GROUP_3,
+	QTM_KEY_AKS_GROUP_4,
+	QTM_KEY_AKS_GROUP_5,
+	QTM_KEY_AKS_GROUP_6,
+	QTM_KEY_AKS_GROUP_7,
+	MAX_QTM_KEY_AKS_GROUP,
+};
+
+enum atmel_ptc_key_hysteresis {
+	QTM_KEY_HYST_50,
+	QTM_KEY_HYST_25,
+	QTM_KEY_HYST_12_5,
+	QTM_KEY_HYST_6_25,
+	MAX_QTM_KEY_HYST,
+};
+
+enum atmel_ptc_key_recal_thr {
+	QTM_KEY_RECAL_THR_100,
+	QTM_KEY_RECAL_THR_50,
+	QTM_KEY_RECAL_THR_25,
+	QTM_KEY_RECAL_THR_12_5,
+	QTM_KEY_RECAL_THR_6_25,
+	MAX_QTM_KEY_RECAL_THR,
+};
+
+/*
+ * Reburst mode:
+ * 0 = none (application calls only)
+ * 1 = Unresolved - i.e. sensors in process of calibration / filter in / filter out and AKS groups
+ * 2 = All keys
+ */
+enum atmel_ptc_key_reburst {
+	QTM_KEY_REBURST_NONE,
+	QTM_KEY_REBURST_UNRESOLVED,
+	QTM_KEY_REBURST_ALL,
+};
+
+struct atmel_qtm_cmd {
+	uint16_t id;
+	uint16_t addr;
+	uint32_t data;
+} __attribute__ ((packed));
+
+struct atmel_qtm_node_group_config {
+	uint16_t count;		/* Number of sensor nodes */
+	uint8_t	ptc_type;	/* Self or mutual sensors */
+	uint8_t	freq_option;	/* SDS or ASDV setting */
+	uint8_t	calib_option;	/* Hardware tuning: XX | TT 3/4/5 Tau | X | XX None/RSEL/PRSC/CSD */
+	uint8_t	unused;
+} __attribute__ ((packed));
+
+struct  atmel_qtm_node_config {
+	uint16_t mask_x;	/* Selects the X Pins for this node (NONE for selfcapacitance configuration) */
+	uint32_t mask_y;	/* Selects the Y Pins for this node */
+	uint8_t	csd;		/* Charge Share Delay */
+	uint8_t	rsel;		/* Resistor */
+	uint8_t	prsc;		/* Prescaler */
+	uint8_t	gain_analog;	/* Analog gain setting (Cint Selection) */
+	uint8_t	gain_digital;	/* Digital gain (Accum / Dec) */
+	uint8_t	oversampling;	/* Accumulator setting */
+} __attribute__ ((packed));
+
+struct atmel_qtm_node_data {
+	uint8_t	status;
+	uint8_t	unused;
+	uint16_t signals;
+	uint16_t comp_caps;
+} __attribute__ ((packed));
+
+struct atmel_qtm_key_config {
+	uint8_t	threshold;	/* Touch detection threshold */
+	uint8_t	hysteresis;	/* Percentage of threshold reduction to exit detect state */
+	uint8_t	aks_group;	/* 0 = None, 1-255 = group number */
+	uint8_t	unused;
+} __attribute__ ((packed));
+
+struct atmel_qtm_key_group_config {
+	uint16_t count;			/* Number of sensors */
+	uint8_t	touch_di;		/* Count in to Detect */
+	uint8_t	max_on_time;		/* Max on duration x 200ms */
+	uint8_t	anti_touch_di;		/* Count in to Anti-touch recal */
+	uint8_t	anti_touch_recal_thr;	/* Anti-touch recal threshold % */
+	uint8_t	touch_drift_rate;	/* One count per <200> ms */
+	uint8_t	anti_touch_drift_rate;	/* One count per <200> ms */
+	uint8_t	drift_hold_time;	/* Drift hold time */
+	uint8_t	reburst_mode;		/* None / Unresolved / All */
+} __attribute__ ((packed));
+
+struct atmel_qtm_key_data {
+	uint8_t	status;			/* Disabled, Off, On, Filter, Cal... */
+	uint8_t	status_counter;		/* State counter */
+	uint16_t node_struct_ptr;	/* Pointer to node struct */
+	uint16_t reference;		/* Reference signal */
+} __attribute__ ((packed));
+
+struct atmel_qtm_auto_scan_config {
+	uint16_t unused;
+	uint16_t node_number;	/* Node Index that will be used */
+	uint8_t	node_threshold;
+	uint8_t	trigger;
+} __attribute__ ((packed));
+
+struct atmel_qtm_scroller_group_config {
+	uint16_t key_data;
+	uint8_t	count;
+	uint8_t	unused;
+} __attribute__ ((packed));
+
+struct atmel_qtm_scroller_config {
+	uint8_t	type;
+	uint8_t	unused;
+	uint16_t key_start;
+	uint8_t	key_count;
+	uint8_t	resol_deadband;
+	uint8_t	position_hysteresis;
+	uint8_t	unused2;
+	uint16_t contact_min_threshold;
+} __attribute__ ((packed));
+
+struct atmel_qtm_scroller_data {
+	uint8_t	status;
+	uint8_t	right_hyst;
+	uint8_t	left_hyst;
+	uint8_t	unused;
+	uint16_t raw_position;
+	uint16_t position;
+	uint16_t contact_size;
+} __attribute__ ((packed));
+
+struct atmel_qtm_fh_autotune_config {
+	uint8_t	count;			/* Number of sensors */
+	uint8_t	num_freqs;
+	uint16_t freq_option_select;
+	uint16_t median_filter_freq;	/* PTC frequencies to be used on the median filter samples */
+	uint8_t	enable_freq_autotune;
+	uint8_t	max_variance_limit;
+	uint8_t	autotune_count_in_limit;
+	uint8_t	unused;
+} __attribute__ ((packed));
+
+struct atmel_qtm_fh_autotune_data {
+	uint8_t	status;			/* Obligatory status byte: Bit 7 = Reburst... */
+	uint8_t	current_freq;		/* PTC Sampling Delay Selection - 0 to 15 PTC CLK cycles */
+	uint16_t filter_buffer;		/* Filter buffer used to store past cycle signal values of sensor */
+	uint16_t acq_node_data;
+	uint16_t freq_tune_count_ins;
+} __attribute__ ((packed));
+
+struct atmel_qtm_fh_freq {
+	uint8_t	freq0;
+	uint8_t	freq1;
+	uint8_t	freq2;
+	uint8_t	unused;
+} __attribute__ ((packed));
+
+struct atmel_qtm_touch_events {
+	uint32_t key_event_id[2];
+	uint32_t key_enable_state[2];
+	uint32_t scroller_event_id;
+	uint32_t scroller_event_state;
+} __attribute__ ((packed));
+
+struct atmel_qtm_mailbox {
+	struct atmel_qtm_cmd			cmd;
+	uint8_t					unused[248];
+	struct atmel_qtm_node_group_config	node_group_config;
+	struct atmel_qtm_node_config		node_config[ATMEL_PTC_MAX_NODES];
+	struct atmel_qtm_node_data		node_data[ATMEL_PTC_MAX_NODES];
+	struct atmel_qtm_key_group_config	key_group_config;
+	struct atmel_qtm_key_config		key_config[ATMEL_PTC_MAX_NODES];
+	struct atmel_qtm_key_data		key_data[ATMEL_PTC_MAX_NODES];
+	struct atmel_qtm_auto_scan_config	auto_scan_config;
+	struct atmel_qtm_scroller_group_config	scroller_group_config;
+	struct atmel_qtm_scroller_config	scroller_config[ATMEL_PTC_MAX_SCROLLERS];
+	struct atmel_qtm_scroller_data		scroller_data[ATMEL_PTC_MAX_SCROLLERS];
+	struct atmel_qtm_fh_autotune_config	fh_autotune_config;
+	struct atmel_qtm_fh_autotune_data	fh_autotune_data;
+	struct atmel_qtm_fh_freq		fh_freq;
+	struct atmel_qtm_touch_events		touch_events;
+} __attribute__ ((packed));
+
+#endif /* _LINUX_ATMEL_PTC_H */
-- 
2.9.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
