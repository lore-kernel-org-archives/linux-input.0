Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794900978;
	b=hRD6oBIKJdniAfPY4FM5m9Jp3gspxbUCvPAffcUdtsqG4H1gCZyDlMCdWutKGFtHmBcg
	 rmMhodYLu22exN6m6QZvlfC4iztJFhalQEg7bEaROzg4OIWSr/pL8YXTbfsXHhxD8KjWd
	 NKFTM6O5EM9bQGu1UiCBRmi26lNeQaTAiDETfP8/FNqZkEohnNG7wyahF7YlGD3dp4Z8k
	 gqMlIgoupFPCcdThlNL6SN7/U5s1pawm61ESLcZTPoHq/axD91I5oKnNRARr5Gs8d+Rms
	 3kt58RRq0KSuDzsMWAL4z0KotbOA4VDv3a+LGLVmccB4Jf5apKkndUpsB5XZFZTcX4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794900978;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Debian-User;
	bh=nrw47uSI0HEg/guWiwKd6OdECzWVQF3dGL46aHhpXIE=;
	b=STUVOj64B2tMi4JB9I/MUTgmiBdkcRbbKJOaY8Fb9FML1SA+drFbibqqP4TAb3NqKPQH
	 GMrem3FmOoMSHh/c5GHvcxHaGMm0ksExMNYkVAiaJkyr9eF6ePQiFTxbgRj9TVovKmmhv
	 9ZrWcANplCkFmrXeBrdEsYQAkUqDP2c2Vyk5X3zir56whEhG1wWMxSZns//3rRO6get5D
	 3pkBquRwwvjTR83y7T4zzepTpcCOOdaNcukZvlotxRljl6th/xnu8/27x4TO3dQd7qRRN
	 D/VP+YQn7gyqiulIWMbzIEb1RK+ONT/sSpBjfbs4aX8gKwjcHrink94Q41qiJ/+44eQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=uHvZQ0FP;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47377606A335;
	Tue, 17 Nov 2026 07:36:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47377606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=uHvZQ0FP
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=nrw47uSI0HEg/guWiwKd6OdECzWVQF3dGL46aHhpXIE=; b=uHvZQ0FPlwxHXWmQ2KNHqzo6Dl
	JfteALr7LDUUcqSXC1IA9TNIINtqOh6vsezaqGiDmzq+2YYmC8wI79+S040UigaBNl3sM1v8m08B5
	rKlt/YiX2JrnzawWvyCWEum2v7g6OLnOEPoKc3a3ZTVLW2BfprJKx2PQ8P54wqa+I6I5ovanpntYD
	gDDWWC/wSBZF+LUMQwitDnMqh9UCB4dT5imsjQnU1AEzfHE266soIG4h/Vjl7Y7airxdgBTp5i9fM
	dXbXNwsZjAn/e1BWlaLCZNdbHD90B/xFZ67hu3ViCj/QZcGcmGzNrzd/Ige44P5MnG1IdVWypWRwE
	6vt6PUZg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <emfox@debian.org>)
	id 1xTDjg-000NOb-0e;
	Tue, 17 Nov 2026 07:36:12 +0000
From: Emfox Zhou <emfox@debian.org>
To: Even Xu <even.xu@intel.com>,
	Xinpeng Sun <xinpeng.sun@intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/5] HID: intel-thc-hid: intel-ipts: bring up the port
Date: Tue, 17 Nov 2026 15:35:50 +0800
Message-ID: <20261117073554.11557-2-emfox@debian.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261117073554.11557-1-emfox@debian.org>
References: <20261117073554.11557-1-emfox@debian.org>
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
X-Debian-User: emfox

Ports on Tiger Lake, Lakefield, Alder Lake and Raptor Lake can run in
IPTS mode: instead of HIDSPI the port drives the touch controller over
plain SPI, and the controller answers with a 64 byte configuration
block at address zero that carries the vendor and product IDs, the
buffer sizes and the SPI timing it expects.

Add a port driver that does that much: select the SPI port, release the
controller from reset, read the configuration block over the existing
PIO path, apply the timing the controller asked for and enable the
touch engine. Removal puts it back into reset.

Three things are not obvious from the register names:

  - The bulk data window is at 0x1000, not at zero, and has to be set
    before the DMA engines run: they write there, and left unset they
    write into the configuration block, where the controller drops the
    frames without reporting an error.

  - Quiescing gates the whole data path, not only the interrupt. The
    port stays quiesced while the block is read and the timing applied,
    and is released only once that is done.

  - The edge detect bit belongs to the interrupt setup, but is set
    here: the first configuration read is unreliable without it.

Meteor Lake and newer IDs are deliberately absent: those ports are
already claimed by the HIDSPI driver.

Signed-off-by: Emfox Zhou <emfox@debian.org>
---
 drivers/hid/intel-thc-hid/Kconfig             |  14 +
 drivers/hid/intel-thc-hid/Makefile            |   4 +
 drivers/hid/intel-thc-hid/intel-ipts/ipts.c   | 240 ++++++++++++++++++
 drivers/hid/intel-thc-hid/intel-ipts/ipts.h   | 119 +++++++++
 .../hid/intel-thc-hid/intel-ipts/pci-ipts.c   | 125 +++++++++
 5 files changed, 502 insertions(+)
 create mode 100644 drivers/hid/intel-thc-hid/intel-ipts/ipts.c
 create mode 100644 drivers/hid/intel-thc-hid/intel-ipts/ipts.h
 create mode 100644 drivers/hid/intel-thc-hid/intel-ipts/pci-ipts.c

diff --git a/drivers/hid/intel-thc-hid/Kconfig b/drivers/hid/intel-thc-hid/Kconfig
index 9d74e53b8..3df645f34 100644
--- a/drivers/hid/intel-thc-hid/Kconfig
+++ b/drivers/hid/intel-thc-hid/Kconfig
@@ -40,4 +40,18 @@ config INTEL_QUICKI2C
 
 	  Say Y/M here if you want to support Intel QuickI2C. If unsure, say N.
 
+config INTEL_IPTS
+	tristate "Intel Touch Host Controller IPTS mode"
+	depends on INTEL_THC_HID
+	help
+	  Support for THC ports in IPTS mode. Instead of HIDSPI these ports
+	  drive the touch controller over plain SPI and carry its reports in a
+	  private framing. This driver brings such a port up, reads the
+	  controller's configuration block and exposes the reports as a HID
+	  device, so that a decoder in user space can turn them into input
+	  events.
+
+	  Say Y/M here if you have an Intel touch controller that runs in IPTS
+	  mode. If unsure, say N.
+
 endmenu
diff --git a/drivers/hid/intel-thc-hid/Makefile b/drivers/hid/intel-thc-hid/Makefile
index f1182253b..049009592 100644
--- a/drivers/hid/intel-thc-hid/Makefile
+++ b/drivers/hid/intel-thc-hid/Makefile
@@ -20,4 +20,8 @@ intel-quicki2c-objs += intel-quicki2c/pci-quicki2c.o
 intel-quicki2c-objs += intel-quicki2c/quicki2c-hid.o
 intel-quicki2c-objs += intel-quicki2c/quicki2c-protocol.o
 
+obj-$(CONFIG_INTEL_IPTS) += intel-ipts.o
+intel-ipts-objs += intel-ipts/pci-ipts.o
+intel-ipts-objs += intel-ipts/ipts.o
+
 ccflags-y += -I $(src)/intel-thc
diff --git a/drivers/hid/intel-thc-hid/intel-ipts/ipts.c b/drivers/hid/intel-thc-hid/intel-ipts/ipts.c
new file mode 100644
index 000000000..696a33d17
--- /dev/null
+++ b/drivers/hid/intel-thc-hid/intel-ipts/ipts.c
@@ -0,0 +1,240 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Transport for THC ports in IPTS mode: plain SPI with a private framing.
+ */
+
+#include <linux/delay.h>
+#include <linux/math.h>
+#include <linux/regmap.h>
+#include <linux/string.h>
+
+#include "intel-thc-hw.h"
+#include "ipts.h"
+
+/* Bulk transfers have no address phase, so the SPI opcode is zero. */
+#define THC_IPTS_SPI_OPCODE		0
+
+/* Slowest clock the core can program, used until the controller is read. */
+#define THC_IPTS_BOOT_SPI_HZ		THC_IPTS_SPI_MIN_HZ
+
+/* Time the controller needs after reset before it answers on the bus. */
+#define THC_IPTS_BOOT_MS		100
+
+static int thc_ipts_read_cfg(struct thc_ipts *idev)
+{
+	int ret, try;
+
+	for (try = 0; try < THC_IPTS_CFG_TRIES; try++) {
+		u32 got = 0;
+
+		memset(&idev->cfg, 0, sizeof(idev->cfg));
+		ret = thc_tic_pio_read(idev->thc, 0, THC_IPTS_CFG_SIZE, &got,
+				       (u32 *)&idev->cfg);
+		if (!ret && got == THC_IPTS_CFG_SIZE &&
+		    le32_to_cpu(idev->cfg.device_id) == THC_IPTS_TIC_ID)
+			return 0;
+
+		if (try + 1 < THC_IPTS_CFG_TRIES)
+			msleep(THC_IPTS_CFG_RETRY_MS);
+	}
+
+	dev_err(idev->dev,
+		"controller did not answer, last id 0x%08x, error %d\n",
+		le32_to_cpu(idev->cfg.device_id), ret ?: -EIO);
+
+	return ret ?: -EIO;
+}
+
+/* Reading first keeps the core from warning when the state already matches. */
+static int thc_ipts_quiesce(struct thc_ipts *idev, bool quiesce)
+{
+	u32 ctrl;
+	int ret;
+
+	ret = regmap_read(idev->thc->thc_regmap, THC_M_PRT_CONTROL_OFFSET,
+			  &ctrl);
+	if (ret)
+		return ret;
+
+	if (!!(ctrl & THC_M_PRT_CONTROL_THC_DEVINT_QUIESCE_EN) == quiesce)
+		return 0;
+
+	return thc_interrupt_quiesce(idev->thc, quiesce);
+}
+
+static int thc_ipts_spi_set(struct thc_ipts *idev, u32 hz, u32 mode)
+{
+	int ret;
+
+	/* No multi-packet transfers in this mode, so both sizes stay zero. */
+	ret = thc_spi_read_config(idev->thc, hz, mode, THC_IPTS_SPI_OPCODE, 0);
+	if (ret)
+		return ret;
+
+	return thc_spi_write_config(idev->thc, hz, mode, THC_IPTS_SPI_OPCODE,
+				     0, 0);
+}
+
+/* The core takes the slowest gear that is not above the request. */
+static void thc_ipts_spi_from_cfg(struct thc_ipts *idev, u32 *hz, u32 *mode)
+{
+	u32 cfg = le32_to_cpu(idev->cfg.spi_cfg);
+	u32 div = THC_IPTS_SPI_CLKDIV(cfg);
+
+	if (!div) {
+		dev_warn_once(idev->dev, "controller asks for divisor 0\n");
+		*hz = THC_IPTS_SPI_MIN_HZ;
+	} else {
+		u32 step = THC_IPTS_SPI_BASE_HZ / div;
+
+		if (cfg & THC_IPTS_SPI_CLKDIV8)
+			step /= THC_IPTS_SPI_CLKDIV8_DIV;
+
+		/* Gears compare rounded to 100 Hz: round the same way, or
+		 * divisor 3 falls below the 41 MHz gear.
+		 */
+		*hz = DIV_ROUND_CLOSEST(step, 100) * 100;
+	}
+
+	/*
+	 * THC_IPTS_SPI_MIN_HZ is the slowest gear the core has, so a lower
+	 * request would be refused: run at the floor and keep the port.
+	 */
+	if (*hz < THC_IPTS_SPI_MIN_HZ) {
+		dev_warn_once(idev->dev,
+			      "controller asks for %u Hz, running at %u Hz\n",
+			      *hz, THC_IPTS_SPI_MIN_HZ);
+		*hz = THC_IPTS_SPI_MIN_HZ;
+	}
+
+	if (cfg & THC_IPTS_SPI_QUAD)
+		*mode = THC_QUAD_IO;
+	else if (cfg & THC_IPTS_SPI_DUAL)
+		*mode = THC_DUAL_IO;
+	else
+		*mode = THC_SINGLE_IO;
+}
+
+static int thc_ipts_touch_set(struct thc_ipts *idev, bool enable)
+{
+	u32 touch = le32_to_cpu(idev->cfg.touch_cfg);
+
+	touch &= ~(THC_IPTS_TOUCH_POWER_MASK | THC_IPTS_TOUCH_ENABLE |
+		   THC_IPTS_TOUCH_HID_REPORT);
+	touch |= THC_IPTS_TOUCH_POWER(enable ? THC_IPTS_TOUCH_POWER_ON : 0);
+	if (enable)
+		touch |= THC_IPTS_TOUCH_ENABLE | THC_IPTS_TOUCH_HID_REPORT;
+
+	return thc_tic_pio_write(idev->thc, THC_IPTS_CFG_TOUCH, sizeof(touch),
+				 &touch);
+}
+
+/**
+ * thc_ipts_port_start - bring one port up
+ * @idev: port to start
+ */
+int thc_ipts_port_start(struct thc_ipts *idev)
+{
+	u32 ctrl, hz, mode;
+	int ret;
+
+	ret = thc_ipts_quiesce(idev, true);
+	if (ret)
+		return ret;
+
+	ret = thc_port_select(idev->thc, THC_PORT_TYPE_SPI);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(idev->thc->thc_regmap, THC_M_PRT_CONTROL_OFFSET,
+			  &ctrl);
+	if (ret)
+		return ret;
+	if (!(ctrl & THC_M_PRT_CONTROL_PORT_SUPPORTED))
+		return -ENODEV;
+
+	/* Without this the engines write into the configuration block. */
+	thc_spi_input_output_address_config(idev->thc, 0, THC_IPTS_BULK_ADDR,
+					    THC_IPTS_BULK_ADDR);
+
+	/*
+	 * Firmware may leave the receive engines armed with the PRD base of
+	 * whatever it had mapped. Stop them before the controller starts
+	 * pushing frames again, or those frames land in stale pages.
+	 */
+	thc_dma_unconfigure(idev->thc);
+
+	ret = thc_ipts_spi_set(idev, THC_IPTS_BOOT_SPI_HZ, THC_SINGLE_IO);
+	if (ret)
+		return ret;
+
+	/* The first configuration read is unreliable without edge detect. */
+	thc_int_trigger_type_select(idev->thc, true);
+
+	/*
+	 * Release the controller from reset; it answers only after this.
+	 * Forced: the bit may read as set and the write is still the command.
+	 */
+	ret = regmap_write_bits(idev->thc->thc_regmap, THC_M_PRT_CONTROL_OFFSET,
+				THC_M_PRT_CONTROL_DEVRST,
+				THC_M_PRT_CONTROL_DEVRST);
+	if (ret)
+		return ret;
+
+	msleep(THC_IPTS_BOOT_MS);
+
+	ret = thc_ipts_read_cfg(idev);
+	if (ret)
+		return ret;
+
+	idev->vendor = le16_to_cpu(idev->cfg.vendor);
+	idev->product = le16_to_cpu(idev->cfg.product);
+	idev->max_rx = THC_IPTS_RX_BUF_SIZE(le32_to_cpu(idev->cfg.buf_sizes));
+	idev->max_tx = THC_IPTS_TX_BUF_SIZE(le32_to_cpu(idev->cfg.buf_sizes));
+	/* TX_BUF_SIZE() never goes below 64, so only the rx half can fail. */
+	if (idev->max_rx <= THC_IPTS_RX_HDR_SIZE) {
+		dev_err(idev->dev, "receive buffer of %zu bytes is too small\n",
+			idev->max_rx);
+		return -ENODEV;
+	}
+	thc_ipts_spi_from_cfg(idev, &hz, &mode);
+	ret = thc_ipts_spi_set(idev, hz, mode);
+	if (ret) {
+		dev_warn(idev->dev,
+			 "cannot follow the SPI timing, going slow\n");
+		ret = thc_ipts_spi_set(idev, THC_IPTS_BOOT_SPI_HZ,
+				       THC_SINGLE_IO);
+		if (ret)
+			return ret;
+	} else {
+		dev_dbg(idev->dev, "SPI clock asked for %u Hz, rounded down\n",
+			hz);
+	}
+
+	ret = thc_ipts_quiesce(idev, false);
+	if (ret)
+		return ret;
+
+	ret = thc_ipts_touch_set(idev, true);
+	if (ret)
+		return ret;
+	idev->running = true;
+
+	return 0;
+}
+
+/**
+ * thc_ipts_port_stop - tear one port down
+ * @idev: port to stop
+ */
+void thc_ipts_port_stop(struct thc_ipts *idev)
+{
+	if (idev->running)
+		thc_ipts_touch_set(idev, false);
+
+	idev->running = false;
+	/* Forced: the bit may read as clear and still need the command. */
+	regmap_write_bits(idev->thc->thc_regmap, THC_M_PRT_CONTROL_OFFSET,
+			  THC_M_PRT_CONTROL_DEVRST, 0);
+	thc_ipts_quiesce(idev, true);
+}
diff --git a/drivers/hid/intel-thc-hid/intel-ipts/ipts.h b/drivers/hid/intel-thc-hid/intel-ipts/ipts.h
new file mode 100644
index 000000000..b4ce633fc
--- /dev/null
+++ b/drivers/hid/intel-thc-hid/intel-ipts/ipts.h
@@ -0,0 +1,119 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _THC_IPTS_H_
+#define _THC_IPTS_H_
+
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/build_bug.h>
+#include <linux/device.h>
+#include <linux/interrupt.h>
+#include <linux/types.h>
+
+#include "intel-thc-dev.h"
+
+/* Configuration block the controller keeps at address zero. */
+#define THC_IPTS_CFG_SIZE		64
+#define THC_IPTS_CFG_TOUCH		0x0c
+#define THC_IPTS_TIC_ID		0x43495424	/* "$TIC" */
+
+/* Bulk data window. The DMA engines have to be pointed here, not at zero. */
+#define THC_IPTS_BULK_ADDR		0x1000
+
+#define PCI_DEVICE_ID_INTEL_THC_LKF_PORT1	0x98d0
+#define PCI_DEVICE_ID_INTEL_THC_LKF_PORT2	0x98d1
+#define PCI_DEVICE_ID_INTEL_THC_TGL_LP_PORT1	0xa0d0
+#define PCI_DEVICE_ID_INTEL_THC_TGL_LP_PORT2	0xa0d1
+#define PCI_DEVICE_ID_INTEL_THC_TGL_H_PORT1	0x43d0
+#define PCI_DEVICE_ID_INTEL_THC_TGL_H_PORT2	0x43d1
+#define PCI_DEVICE_ID_INTEL_THC_ADL_S_PORT1	0x7ad8
+#define PCI_DEVICE_ID_INTEL_THC_ADL_S_PORT2	0x7ad9
+#define PCI_DEVICE_ID_INTEL_THC_ADL_P_PORT1	0x51d0
+#define PCI_DEVICE_ID_INTEL_THC_ADL_P_PORT2	0x51d1
+#define PCI_DEVICE_ID_INTEL_THC_ADL_M_PORT1	0x54d0
+#define PCI_DEVICE_ID_INTEL_THC_ADL_M_PORT2	0x54d1
+#define PCI_DEVICE_ID_INTEL_THC_RPL_S_PORT1	0x7a58
+#define PCI_DEVICE_ID_INTEL_THC_RPL_S_PORT2	0x7a59
+
+/* The block fills in while the controller starts, so $TIC is retried. */
+#define THC_IPTS_CFG_TRIES		10
+#define THC_IPTS_CFG_RETRY_MS		100
+
+#define THC_IPTS_CFG_KNOWN		40
+
+/* The block as far as this driver reads it, padded to its full size. */
+struct thc_ipts_cfg {
+	__le32	irq_cause;
+	__le32	error;		/* protocol error flags, not used */
+	__le32	buf_sizes;	/* Rx/Tx sizes, see *_BUF_SIZE() */
+	__le32	touch_cfg;	/* touch engine control, writable */
+	__le32	touch_state;	/* touch engine state, not used */
+	__le32	device_id;	/* THC_IPTS_TIC_ID after a good read */
+	__le32	spi_cfg;
+	__le16	vendor;
+	__le16	product;
+	__le32	revision;
+	__le32	fw_version;
+	u8	rest[THC_IPTS_CFG_SIZE - THC_IPTS_CFG_KNOWN];
+};
+
+static_assert(sizeof(struct thc_ipts_cfg) == THC_IPTS_CFG_SIZE);
+
+/* The core is handed the struct itself, so the offsets are part of the deal. */
+static_assert(offsetof(struct thc_ipts_cfg, buf_sizes) == 0x08);
+static_assert(offsetof(struct thc_ipts_cfg, touch_cfg) == 0x0c);
+static_assert(offsetof(struct thc_ipts_cfg, spi_cfg) == 0x18);
+static_assert(offsetof(struct thc_ipts_cfg, vendor) == 0x1c);
+
+/* Buffer sizes are stored as (size / 64) - 1, Rx in bits 13:0, Tx in 23:14. */
+#define THC_IPTS_DMA_UNIT		64
+#define THC_IPTS_RX_BUF_SIZE(val)	\
+	((size_t)(FIELD_GET(GENMASK(13, 0), (val)) + 1) * THC_IPTS_DMA_UNIT)
+#define THC_IPTS_TX_BUF_SIZE(val)	\
+	((size_t)(FIELD_GET(GENMASK(23, 14), (val)) + 1) * THC_IPTS_DMA_UNIT)
+
+#define THC_IPTS_TOUCH_ENABLE		BIT(0)
+#define THC_IPTS_TOUCH_HID_REPORT	BIT(2)
+#define THC_IPTS_TOUCH_POWER_ON	3
+#define THC_IPTS_TOUCH_POWER_MASK	GENMASK(5, 3)
+#define THC_IPTS_TOUCH_POWER(val)	\
+	FIELD_PREP(THC_IPTS_TOUCH_POWER_MASK, (val))
+
+#define THC_IPTS_SPI_CLKDIV(val)	FIELD_GET(GENMASK(3, 1), (val))
+#define THC_IPTS_SPI_CLKDIV8		BIT(4)
+#define THC_IPTS_SPI_CLKDIV8_DIV	8
+#define THC_IPTS_SPI_DUAL		BIT(6)
+#define THC_IPTS_SPI_QUAD		BIT(7)
+#define THC_IPTS_SPI_BASE_HZ		125000000
+/* Slowest gear in the core's SPI table; anything under it is refused. */
+#define THC_IPTS_SPI_MIN_HZ		7812500
+
+/* Code and length in front of the payload; the long one is inbound. */
+#define THC_IPTS_RX_HDR_SIZE		64
+#define THC_IPTS_TX_HDR_SIZE		8
+
+/**
+ * struct thc_ipts - state of one THC port in IPTS mode
+ * @dev: device used for resources and logging
+ * @thc: shared THC core context
+ * @cfg: configuration block last read from the controller
+ * @vendor: vendor ID the controller reports for its HID device
+ * @product: product ID the controller reports for its HID device
+ * @max_rx: largest frame the controller may send, in bytes
+ * @max_tx: largest frame the driver may send, in bytes
+ * @running: the controller answered and is out of reset
+ */
+struct thc_ipts {
+	struct device		*dev;
+	struct thc_device	*thc;
+	struct thc_ipts_cfg	cfg;
+	u16			vendor;
+	u16			product;
+	size_t			max_rx;
+	size_t			max_tx;
+	bool			running;
+};
+
+int thc_ipts_port_start(struct thc_ipts *idev);
+void thc_ipts_port_stop(struct thc_ipts *idev);
+
+#endif /* _THC_IPTS_H_ */
diff --git a/drivers/hid/intel-thc-hid/intel-ipts/pci-ipts.c b/drivers/hid/intel-thc-hid/intel-ipts/pci-ipts.c
new file mode 100644
index 000000000..48046cd12
--- /dev/null
+++ b/drivers/hid/intel-thc-hid/intel-ipts/pci-ipts.c
@@ -0,0 +1,125 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PCI glue for the Intel Touch Host Controller in IPTS mode. Ports that
+ * the HIDSPI driver already claims are deliberately left out of the ID table.
+ */
+
+#include <linux/dma-mapping.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/workqueue.h>
+
+#include "ipts.h"
+
+static const struct pci_device_id thc_ipts_pci_ids[] = {
+	/* Lakefield */
+	{PCI_DEVICE_DATA(INTEL, THC_LKF_PORT1, NULL)},
+	{PCI_DEVICE_DATA(INTEL, THC_LKF_PORT2, NULL)},
+	/* Tiger Lake */
+	{PCI_DEVICE_DATA(INTEL, THC_TGL_LP_PORT1, NULL)},
+	{PCI_DEVICE_DATA(INTEL, THC_TGL_LP_PORT2, NULL)},
+	{PCI_DEVICE_DATA(INTEL, THC_TGL_H_PORT1, NULL)},
+	{PCI_DEVICE_DATA(INTEL, THC_TGL_H_PORT2, NULL)},
+	/* Alder Lake */
+	{PCI_DEVICE_DATA(INTEL, THC_ADL_S_PORT1, NULL)},
+	{PCI_DEVICE_DATA(INTEL, THC_ADL_S_PORT2, NULL)},
+	{PCI_DEVICE_DATA(INTEL, THC_ADL_P_PORT1, NULL)},
+	{PCI_DEVICE_DATA(INTEL, THC_ADL_P_PORT2, NULL)},
+	{PCI_DEVICE_DATA(INTEL, THC_ADL_M_PORT1, NULL)},
+	{PCI_DEVICE_DATA(INTEL, THC_ADL_M_PORT2, NULL)},
+	/* Raptor Lake */
+	{PCI_DEVICE_DATA(INTEL, THC_RPL_S_PORT1, NULL)},
+	{PCI_DEVICE_DATA(INTEL, THC_RPL_S_PORT2, NULL)},
+	{}
+};
+MODULE_DEVICE_TABLE(pci, thc_ipts_pci_ids);
+
+static int thc_ipts_probe(struct pci_dev *pci, const struct pci_device_id *id)
+{
+	struct thc_ipts *idev;
+	void __iomem *mem;
+	int ret;
+
+	idev = devm_kzalloc_obj(&pci->dev, *idev);
+	if (!idev)
+		return -ENOMEM;
+
+	idev->dev = &pci->dev;
+	pci_set_drvdata(pci, idev);
+
+	ret = pcim_enable_device(pci);
+	if (ret) {
+		dev_err(idev->dev,
+			"cannot enable the PCI function, error %d\n", ret);
+		return ret;
+	}
+
+	pci_set_master(pci);
+
+	mem = pcim_iomap_region(pci, 0, KBUILD_MODNAME);
+	ret = PTR_ERR_OR_ZERO(mem);
+	if (ret) {
+		dev_err(idev->dev, "cannot map the register space, error %d\n",
+			ret);
+		return ret;
+	}
+
+	ret = dma_set_mask_and_coherent(idev->dev, DMA_BIT_MASK(64));
+	if (ret)
+		ret = dma_set_mask_and_coherent(idev->dev, DMA_BIT_MASK(32));
+	if (ret) {
+		dev_err(idev->dev, "no usable DMA configuration, error %d\n",
+			ret);
+		return ret;
+	}
+
+	idev->thc = thc_dev_init(idev->dev, mem);
+	if (IS_ERR(idev->thc))
+		return PTR_ERR(idev->thc);
+
+	ret = thc_ipts_port_start(idev);
+	if (ret) {
+		thc_ipts_port_stop(idev);
+		return ret;
+	}
+
+	dev_info(idev->dev, "controller %04x:%04x rev %u, firmware 0x%08x\n",
+		 idev->vendor, idev->product, le32_to_cpu(idev->cfg.revision),
+		 le32_to_cpu(idev->cfg.fw_version));
+	dev_info(idev->dev, "spi cfg 0x%08x, rx %zu tx %zu bytes\n",
+		 le32_to_cpu(idev->cfg.spi_cfg), idev->max_rx, idev->max_tx);
+
+	return 0;
+}
+
+static void thc_ipts_remove(struct pci_dev *pci)
+{
+	struct thc_ipts *idev = pci_get_drvdata(pci);
+
+	thc_ipts_port_stop(idev);
+	pci_clear_master(pci);
+}
+
+static void thc_ipts_shutdown(struct pci_dev *pci)
+{
+	struct thc_ipts *idev = pci_get_drvdata(pci);
+
+	if (idev)
+		thc_ipts_port_stop(idev);
+}
+
+static struct pci_driver thc_ipts_driver = {
+	.name		= "intel-ipts",
+	.id_table	= thc_ipts_pci_ids,
+	.probe		= thc_ipts_probe,
+	.remove		= thc_ipts_remove,
+	.shutdown	= thc_ipts_shutdown,
+	/* Bring-up waits for the controller, up to a few seconds. */
+	.driver.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+};
+module_pci_driver(thc_ipts_driver);
+
+MODULE_AUTHOR("Emfox Zhou <emfox@debian.org>");
+MODULE_DESCRIPTION("IPTS transport for the Intel Touch Host Controller");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("INTEL_THC");
