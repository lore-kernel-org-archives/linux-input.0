Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5AD480334
	for <linux-input@vger.kernel.org>; Mon, 14 Sep 2026 14:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789396683; cv=none; b=Py+A8Udhw1D+XRuOg7hA9K0yZsP8D3jMTxrDr2aMCiym6nlvJz1E8QemTDh03erQy05KkyOdkucdfgb9BNXi8dz4zkUFKDTlABE3n5fpXcZMlIqupCu+kWG9iiZYuTdrvtQu12EvqbBiBUVvklgrw/BalQgEqnLQ8MvZ9mSPvek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789396683; c=relaxed/simple;
	bh=R8HMyG74GTZZIJYnO5x6qyzsre52OWjx9/X0m2tQaHE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dwOgYjqKDq8l1mrvAZClu+ZeI6YQ0ebAD1h71h81xwzIfDb+BBnLnbJOTQkteEXqkzXRdenDyDtQqf5QQdbkm+TLekkFIWe48achBmB5krwg+C9NmmIUcM7b3EGEIFFT0I9fMuh6rmpEbtwJ6ZRmYS6MdpKZ9UPmsk+ju1KqQyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=25Tc8fJj; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="25Tc8fJj"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f705536so498484266b.1
        for <linux-input@vger.kernel.org>; Mon, 14 Sep 2026 07:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1789396678; x=1790001478; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9Y80xprHvLU1i4rrjoeS9+U5T5BtPeDbPLJ+nJ7nOJc=;
        b=25Tc8fJj7Z81XvQOdrmasYFEjXI/4aXTfcldvcTHt9YHkvQ1RlBmN92x1pgBps6+1b
         9ue7gGK9/Qyqph4jI2BsIhn6ZDzCoZ2zYPNXSd7Zs9CiDhRy2pLrE/DYx2ZcIE1mvkx+
         NC5DQXomBijbAGFpmyQDgVtMOpcWh+1HRB1rk1coWnsCHDFYoHSG++SERbdUOg6ogJpo
         bKq0zGov153HVOaGyTRnIbaiS4dQNv/bnDFyM5LIdF4rhAPKn1zXYKZNBSYiQeYdl7hB
         kGJrOU8EuCYvDbcrCWTloBhr3Mtegroclq8E2I/Y+Mrdsxv4diT8LXHczD0Gpwe1JuN0
         OYAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789396678; x=1790001478;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9Y80xprHvLU1i4rrjoeS9+U5T5BtPeDbPLJ+nJ7nOJc=;
        b=W7n5GgQrrTvzLSd8z0OT4Ik5M8O2HWC0etQrgCNw8rBkKacVcLB2+2c15fVoSchqZg
         niTPwOo+TgQEzyjRV1iC7yAEAb5ab7UO33F3BxTuNfcqSmSmv25+Cs50RKckYi9ums8+
         60+G9f7n/lzhRK8AXw0EcLVuZmyvNACNMya2HkYE23WY6fbN8raJ5SyFfGwJ+r7o51FS
         zUsJRR/eQjI2jv85aFeHs6R7sNT4us2irbFumyJltiaUh7UrKx0PjwjO57rNUyP3QhcU
         OYKVyuuu3dZ0sAvq4CvuiCl89Kie+TaaDkbVqGFN1rZ52NnL9RwfMdCZ7Y7dZPXWJnQ2
         kbRA==
X-Gm-Message-State: AFuF++nV8/e5ZTIDu5azzmJtBay0nfRon5GObB4HZwVa+vix76VYGyJd
	9o9QjucK51FKCZt6/b9T5w/0Cwurf8u0KsVDooLuiqpnfnFhWGsLURUHDBsZtPH74b0=
X-Gm-Gg: AYBFou2OUdCSNG3ibD/AU6ePaeOTU1WFtcXbubDLAWusIBXYblB98gZ66Ig7KaWOpp7
	l3JCGgDxR/6hfyQ8E1EAGYkxumPZmOR4Nl4QKzyjAV2CTjRKx1P0694aUx+UGR7vheGoJnoDM87
	U5WzjFXKq8Pnu9ARf2T1zB4p3KpG1DoTCeKhQzlnIRRmmoLpXS8V+c70xrfLb9Cu0iewp0Ar2U9
	GEfL+4zx/zQq0t+I15d/kRgy2+3H1UaOwueoVagblq7zhPhUJ2VhOG3HYJftsMCeY71EZZLroa7
	88EaB0QdRGI0u43vbt94uynEevnlxWad/1GlVVRYvWeNS5cxigD5UvrA0B7iJdUzttCRMwv3Seg
	Zt70ejuxShALegS9rE3wTP8EPYFRmAbYN75glrwHdyQY2idQCo+/yCoTXb+V5LQu7V1JyJz5PsY
	2sRp8Rfyo1f3cMQYxjMAoMAvsu9yoDJ7s32hUDsdGs04cR7YjlA1WeTOl1aoLvF1znOUN11hxc/
	LD5xTBGk1cgowfYWeSoLJzaVcnqn8Vvl9FzbGn+kBFZOg0E/N00WULrPA==
X-Received: by 2002:a17:907:d19:b0:c26:1648:a066 with SMTP id a640c23a62f3a-c29b874c902mr181830566b.33.1789396677472;
        Mon, 14 Sep 2026 07:37:57 -0700 (PDT)
Received: from [172.16.220.224] (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c29660b29a7sm449634266b.43.2026.09.14.07.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 07:37:57 -0700 (PDT)
From: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
Date: Mon, 14 Sep 2026 16:37:48 +0200
Subject: [PATCH 2/3] Input - aw8695: Add driver for AW8695 haptics
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-aw8695_haptic_fp4_driver-v1-2-156f7549149a@fairphone.com>
References: <20260914-aw8695_haptic_fp4_driver-v1-0-156f7549149a@fairphone.com>
In-Reply-To: <20260914-aw8695_haptic_fp4_driver-v1-0-156f7549149a@fairphone.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Luca Weiss <luca.weiss@fairphone.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789396675; l=24688;
 i=griffin.kroah@fairphone.com; s=20250804; h=from:subject:message-id;
 bh=/LZ335e1bauDw6miSQQe/ZpcqQWSL8CRqgmZYoM2EYU=;
 b=FsTiu0FYYvh8HS1jkuFV5a0YSZc8PFByMRdmaFk/DskCu6salI9cgxj9czVdJwUpJagbQ69/L
 3cT7C1VIuOKAs2d3i1b/9oYoEXWFu9enOhflRGc5fGQqc4ZCFOTfnF1
X-Developer-Key: i=griffin.kroah@fairphone.com; a=ed25519;
 pk=drSBvqKFiR+xucmLWONHSq/wGrW+YvcVtBXFYnYzn8U=

From: Luca Weiss <luca.weiss@fairphone.com>

Add a driver for interfacing with the Awinic AW8695 LRA Haptic Driver.

The chip supports multiple modes of which only RAM mode is implemented.
RTP mode would enable a user to "stream" waveform data but to my
knowledge no such user space API exists in the kernel yet.

We upload a basic sine wave to the chip and play this on request.

Co-developed-by: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
Signed-off-by: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/input/misc/Kconfig  |  11 +
 drivers/input/misc/Makefile |   1 +
 drivers/input/misc/aw8695.c | 753 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 765 insertions(+)

diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index 1f6c57dba030813c248c068eda26ca1842271cb2..8bc0fdc1a7bc4c1fb1bea69ed08dcd6002a7d5fe 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -137,6 +137,17 @@ config INPUT_AW86927
 	  To compile this driver as a module, choose M here: the
 	  module will be called aw86927.
 
+config INPUT_AW8695
+	tristate "Awinic AW8695 haptics support"
+	depends on INPUT && I2C
+	select INPUT_FF_MEMLESS
+	select REGMAP_I2C
+	help
+	  Say Y to enable support for the Awinic AW8695 haptics driver.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called aw8695.
+
 config INPUT_BBNSM_PWRKEY
 	tristate "NXP BBNSM Power Key Driver"
 	depends on ARCH_MXC || COMPILE_TEST
diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
index 2281d6803fce92e54a05c2c4f57ee7f7ea7ef2b8..25fb845125f9bee5b808d3f3b8ee74b9e89af5f5 100644
--- a/drivers/input/misc/Makefile
+++ b/drivers/input/misc/Makefile
@@ -23,6 +23,7 @@ obj-$(CONFIG_INPUT_ATI_REMOTE2)		+= ati_remote2.o
 obj-$(CONFIG_INPUT_ATLAS_BTNS)		+= atlas_btns.o
 obj-$(CONFIG_INPUT_ATMEL_CAPTOUCH)	+= atmel_captouch.o
 obj-$(CONFIG_INPUT_AW86927)		+= aw86927.o
+obj-$(CONFIG_INPUT_AW8695)		+= aw8695.o
 obj-$(CONFIG_INPUT_BBNSM_PWRKEY)	+= nxp-bbnsm-pwrkey.o
 obj-$(CONFIG_INPUT_BMA150)		+= bma150.o
 obj-$(CONFIG_INPUT_CM109)		+= cm109.o
diff --git a/drivers/input/misc/aw8695.c b/drivers/input/misc/aw8695.c
new file mode 100644
index 0000000000000000000000000000000000000000..ea72562a7c2a7c4ab82e535a9cce2224623b5ffa
--- /dev/null
+++ b/drivers/input/misc/aw8695.c
@@ -0,0 +1,753 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2026 Luca Weiss <luca.weiss@fairphone.com>
+ * Copyright (C) 2026 Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
+ *
+ * Partially based on vendor driver:
+ *   Copyright (c) 2018 AWINIC Technology CO., LTD
+ */
+
+#include <linux/bitfield.h>
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/i2c.h>
+#include <linux/input.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+
+#define AW8695_CHIPID				0x95
+#define AW8695_RESET				0xaa
+/* Default of BASE_ADDR* registers */
+#define AW8695_RAM_BASE_ADDR			0x800
+
+#define AW8695_HIGH_MASK			GENMASK(15, 8)
+#define AW8695_LOW_MASK				GENMASK(7, 0)
+
+/* Chip ID */
+#define AW8695_ID_REG				0x00
+
+/* System Status */
+#define AW8695_SYSST_REG			0x01
+
+/* System Interrupt */
+#define AW8695_SYSINT_REG			0x02
+#define AW8695_SYSINT_BSTERRI			BIT(7)
+#define AW8695_SYSINT_OVI			BIT(6)
+#define AW8695_SYSINT_UVLI			BIT(5)
+#define AW8695_SYSINT_FF_AEI			BIT(4)
+#define AW8695_SYSINT_FF_AFI			BIT(3)
+#define AW8695_SYSINT_OCDI			BIT(2)
+#define AW8695_SYSINT_OTI			BIT(1)
+#define AW8695_SYSINT_DONEI			BIT(0)
+
+/* System Interrupt Mask */
+#define AW8695_SYSINTM_REG			0x03
+#define AW8695_SYSINTM_BSTERR_OFF		BIT(7)
+#define AW8695_SYSINTM_OV_OFF			BIT(6)
+#define AW8695_SYSINTM_UVLO_OFF			BIT(5)
+#define AW8695_SYSINTM_OCD_OFF			BIT(2)
+#define AW8695_SYSINTM_OT_OFF			BIT(1)
+
+/* System Control */
+#define AW8695_SYSCTRL_REG			0x04
+#define AW8695_SYSCTRL_RAMINIT_EN		BIT(5)
+
+#define AW8695_SYSCTRL_PLAY_MODE_MASK		GENMASK(3, 2)
+#define AW8695_SYSCTRL_PLAY_MODE_RAM		(0)
+
+#define AW8695_SYSCTRL_BST_MODE_MASK		GENMASK(1, 1)
+#define AW8695_SYSCTRL_BST_MODE_BYPASS		(0)
+
+#define AW8695_SYSCTRL_WORK_MODE_MASK		GENMASK(0, 0)
+#define AW8695_SYSCTRL_STANDBY			(1)
+#define AW8695_SYSCTRL_ACTIVE			(0)
+
+/* Process Control */
+#define AW8695_GO_REG				0x05
+#define AW8695_GO_ENABLE			BIT(0)
+
+/* Waveform #1 */
+#define AW8695_WAVSEQ1_REG			0x07
+
+/* Waveform #2 */
+#define AW8695_WAVSEQ2_REG			0x08
+
+/* Waveform Loop #1 */
+#define AW8695_WAVLOOP1_REG			0x0f
+#define AW8695_WAVLOOP1_SEQ1_MASK		GENMASK(7, 4)
+#define AW8695_WAVLOOP1_SEQ2_MASK		GENMASK(3, 0)
+
+#define AW8695_WAVLOOP_INFINITE			0xf
+
+/* Debug Control */
+#define AW8695_DBGCTRL_REG				0x20
+#define AW8695_DBGCTRL_INT_MODE_MASK		GENMASK(2, 2)
+#define AW8695_DBGCTRL_INT_MODE_EDGE		(1)
+
+/* PWM Output Protect Configuration */
+#define AW8695_PWMPRC_REG			0x2d
+#define AW8695_PWMPRC_PRC_ENABLE		BIT(7)
+
+/* PWM Debug */
+#define AW8695_PWMDBG_REG			0x2e
+#define AW8695_PWMDBG_PWM_MODE_MASK		GENMASK(6, 5)
+#define AW8695_PWMDBG_PWM_24K			(2)
+
+/* Debug Status */
+#define AW8695_DBGSTAT_REG			0x30
+
+/* Boost Debug #1 */
+#define AW8695_BSTDBG1_REG			0x31
+#define AW8695_BSTDBG1_DEFAULT			0x30
+
+/* Boost Debug #2 */
+#define AW8695_BSTDBG2_REG			0x32
+#define AW8695_BSTDBG2_DEFAULT			0xeb
+
+/* Boost Debug #3 */
+#define AW8695_BSTDBG3_REG			0x33
+#define AW8695_BSTDBG3_DEFAULT			0xd4
+
+/* Boost Config */
+#define AW8695_BSTCFG_REG			0x34
+#define AW8695_BSTCFG_PEAKCUR_MASK		GENMASK(2, 0)
+#define AW8695_BSTCFG_PEAKCUR_2A		(1)
+
+#define AW8695_ANADBG_REG			0x35
+#define AW8695_ANADBG_IOC_MASK			GENMASK(3, 2)
+#define AW8695_ANADBG_IOC_4P65A			(3)
+
+/* Waveform Protect Level */
+#define AW8695_PRLVL_REG			0x3e
+#define AW8695_PRLVL_PR_ENABLE			BIT(7)
+
+/* SRAM Address 0xhigh */
+#define AW8695_RAMADDRH_REG			0x40
+
+/* SRAM Address 0xlow */
+#define AW8695_RAMADDRL_REG			0x41
+
+/* SRAM Data */
+#define AW8695_RAMDATA_REG			0x42
+
+#define AW8695_GLB_STATE_REG			0x46
+
+#define AW8695_BST_AUTO_REG			0x47
+#define AW8695_BST_AUTO_BST_AUTOSW_MASK		GENMASK(2, 2)
+#define AW8695_BST_AUTO_BST_MANUAL_BOOST	(0)
+
+#define AW8695_TSET_REG				0x4d
+#define AW8695_TSET_DEFAULT			0x12
+
+#define AW8695_R_SPARE_REG			0x5d
+#define Aw8695_R_SPARE_DEFAULT			0x68
+
+/* Detection Control */
+#define AW8695_DETCTRL_REG			0x5f
+#define AW8695_DETCTRL_PROTECT_MASK		GENMASK(5, 5)
+#define AW8695_DETCTRL_PROTECT_NO_ACTION	(1)
+#define AW8695_DETCTRL_DIAG_GO_ENABLE		BIT(0)
+
+/* ADC Test */
+#define AW8695_ADCTEST_REG			0x66
+#define AW8695_ADCTEST_VBAT_MODE_MASK		GENMASK(6, 6)
+#define AW8695_ADCTEST_VBAT_HW_COMP		(1)
+
+#define AW8695_BEMF_VTHH_H_REG			0x74
+
+#define AW8695_BEMF_VTHH_L_REG			0x75
+
+#define AW8695_BEMF_VTHL_H_REG			0x76
+
+#define AW8695_BEMF_VTHL_L_REG			0x77
+
+#define AW8695_MAX_REG				0x7f
+
+#define AW8695_BEMF_UPPER_THRESHOLD		0x1008
+#define AW8695_BEMF_LOWER_THRESHOLD		0x3f8
+
+enum aw8695_work_mode {
+	AW8695_STANDBY_MODE,
+	AW8695_RAM_MODE,
+};
+
+struct aw8695_data {
+	struct input_dev *input_dev;
+	struct i2c_client *client;
+	struct regmap *regmap;
+	struct gpio_desc *reset_gpio;
+	u16 level;
+	struct work_struct play_work;
+};
+
+/*
+ * Sine wave representing the magnitude of the drive to be used.
+ * Data is encoded in two's complement.
+ *   round(84 * sin(x / 16.25))
+ */
+static const u8 aw8695_sine_waveform[] = {
+	0x00, 0x05, 0x0a, 0x0f, 0x14, 0x19, 0x1e, 0x23, 0x28, 0x2c, 0x30, 0x35,
+	0x39, 0x3c, 0x40, 0x43, 0x46, 0x49, 0x4b, 0x4d, 0x4f, 0x51, 0x52, 0x53,
+	0x54, 0x54, 0x54, 0x54, 0x53, 0x52, 0x51, 0x4f, 0x4d, 0x4b, 0x49, 0x46,
+	0x43, 0x40, 0x3c, 0x39, 0x35, 0x31, 0x2c, 0x28, 0x23, 0x1f, 0x1a, 0x15,
+	0x10, 0x0b, 0x05, 0x00, 0xfb, 0xf6, 0xf1, 0xec, 0xe7, 0xe2, 0xdd, 0xd9,
+	0xd4, 0xd0, 0xcc, 0xc8, 0xc4, 0xc0, 0xbd, 0xba, 0xb7, 0xb5, 0xb3, 0xb1,
+	0xaf, 0xae, 0xad, 0xac, 0xac, 0xac, 0xac, 0xad, 0xae, 0xaf, 0xb1, 0xb2,
+	0xb5, 0xb7, 0xba, 0xbd, 0xc0, 0xc3, 0xc7, 0xcb, 0xcf, 0xd3, 0xd8, 0xdc,
+	0xe1, 0xe6, 0xeb, 0xf0, 0xf5, 0xfa
+};
+
+/*
+ * Header that gets written to AW8695 SRAM that describes the available
+ * waveforms being transferred afterwards.
+ *
+ * @version: waveform library version
+ * @start_address: start address of waveform in SRAM
+ * @end_address: end address of waveform in SRAM
+ */
+struct aw8695_sram_waveform_header {
+	u8 version;
+	__be16 start_address;
+	__be16 end_address;
+} __packed;
+
+static const struct aw8695_sram_waveform_header sram_waveform_header = {
+	.version = 0x01,
+	.start_address = cpu_to_be16(AW8695_RAM_BASE_ADDR +
+		sizeof(struct aw8695_sram_waveform_header)),
+	.end_address = cpu_to_be16(AW8695_RAM_BASE_ADDR +
+		sizeof(struct aw8695_sram_waveform_header) +
+		ARRAY_SIZE(aw8695_sine_waveform) - 1),
+};
+
+static int aw8695_interrupt_clear(struct aw8695_data *haptics)
+{
+	unsigned int read_buf;
+
+	/* Clear UVLI bit by reading register */
+	return regmap_read(haptics->regmap, AW8695_SYSINT_REG, &read_buf);
+}
+
+static int aw8695_haptic_set_active(struct aw8695_data *haptics)
+{
+	int err;
+
+	err = regmap_update_bits(haptics->regmap, AW8695_SYSCTRL_REG,
+				 AW8695_SYSCTRL_WORK_MODE_MASK,
+				 FIELD_PREP(AW8695_SYSCTRL_WORK_MODE_MASK,
+					    AW8695_SYSCTRL_ACTIVE));
+	if (err)
+		return err;
+
+	err = aw8695_interrupt_clear(haptics);
+	if (err)
+		return err;
+
+	return regmap_update_bits(haptics->regmap, AW8695_SYSINTM_REG,
+				  AW8695_SYSINTM_UVLO_OFF, 0);
+}
+
+static int aw8695_play_mode(struct aw8695_data *haptics,
+				 enum aw8695_work_mode mode)
+{
+	struct device *dev = &haptics->client->dev;
+	int err;
+
+	switch (mode) {
+	case AW8695_STANDBY_MODE:
+		err = regmap_update_bits(haptics->regmap, AW8695_SYSINTM_REG,
+					 AW8695_SYSINTM_UVLO_OFF, AW8695_SYSINTM_UVLO_OFF);
+		if (err)
+			return err;
+
+		return regmap_update_bits(haptics->regmap, AW8695_SYSCTRL_REG,
+					  AW8695_SYSCTRL_WORK_MODE_MASK,
+					  FIELD_PREP(AW8695_SYSCTRL_WORK_MODE_MASK,
+						     AW8695_SYSCTRL_STANDBY));
+	case AW8695_RAM_MODE:
+		err = regmap_update_bits(haptics->regmap, AW8695_SYSCTRL_REG,
+					 AW8695_SYSCTRL_PLAY_MODE_MASK,
+					 FIELD_PREP(AW8695_SYSCTRL_PLAY_MODE_MASK,
+						    AW8695_SYSCTRL_PLAY_MODE_RAM));
+		if (err)
+			return err;
+
+		err = regmap_update_bits(haptics->regmap, AW8695_SYSCTRL_REG,
+					 AW8695_SYSCTRL_BST_MODE_MASK,
+					 FIELD_PREP(AW8695_SYSCTRL_BST_MODE_MASK,
+						    AW8695_SYSCTRL_BST_MODE_BYPASS));
+		if (err)
+			return err;
+
+		return aw8695_haptic_set_active(haptics);
+	default:
+		dev_err(dev, "Unhandled mode: %d\n", mode);
+		return -EINVAL;
+	}
+}
+
+static int aw8695_haptics_play(struct input_dev *dev, void *data,
+			       struct ff_effect *effect)
+{
+	struct aw8695_data *haptics = input_get_drvdata(dev);
+	int level;
+
+	level = effect->u.rumble.strong_magnitude;
+	if (!level)
+		level = effect->u.rumble.weak_magnitude;
+
+	if (haptics->level == level)
+		return 0;
+
+	haptics->level = level;
+	schedule_work(&haptics->play_work);
+
+	return 0;
+}
+
+static void aw8695_hw_reset(struct aw8695_data *haptics)
+{
+	gpiod_set_value_cansleep(haptics->reset_gpio, 1);
+
+	usleep_range(1000, 2000);
+
+	gpiod_set_value_cansleep(haptics->reset_gpio, 0);
+
+	usleep_range(3500, 4000);
+}
+
+static int aw8695_stop(struct aw8695_data *haptics)
+{
+	int err;
+	unsigned int read_buf;
+	struct device *dev = &haptics->client->dev;
+
+	err = regmap_update_bits(haptics->regmap, AW8695_GO_REG,
+				 AW8695_GO_ENABLE, 0);
+	if (err)
+		return err;
+
+	err = regmap_read_poll_timeout(haptics->regmap, AW8695_GLB_STATE_REG, read_buf,
+			(read_buf & 0x0f) == 0, 2000, 2000 * 100);
+	if (err) {
+		dev_err(dev, "Did not enter standby: %d\n	Trying to force it...\n", err);
+		err = aw8695_play_mode(haptics, AW8695_STANDBY_MODE);
+		return err;
+	}
+
+	return aw8695_play_mode(haptics, AW8695_STANDBY_MODE);
+}
+
+static int aw8695_play_sine(struct aw8695_data *haptics)
+{
+	int err;
+
+	err = aw8695_stop(haptics);
+	if (err)
+		return err;
+
+	/*
+	 * Configure for waveform #1 to be played infinitely,
+	 * and waveform #2 to not be played.
+	 */
+	err = regmap_write(haptics->regmap, AW8695_WAVSEQ1_REG, 0x1);
+	if (err)
+		return err;
+
+	err = regmap_write(haptics->regmap, AW8695_WAVSEQ2_REG, 0x0);
+	if (err)
+		return err;
+
+	err = regmap_write(haptics->regmap, AW8695_WAVLOOP1_REG,
+			   FIELD_PREP(AW8695_WAVLOOP1_SEQ1_MASK,
+				      AW8695_WAVLOOP_INFINITE) |
+			   FIELD_PREP(AW8695_WAVLOOP1_SEQ2_MASK, 0));
+	if (err)
+		return err;
+
+	/* Configure for RAM mode */
+	err = aw8695_play_mode(haptics, AW8695_RAM_MODE);
+	if (err)
+		return err;
+
+	/* Start vibration */
+	return regmap_update_bits(haptics->regmap, AW8695_GO_REG,
+				  AW8695_GO_ENABLE, AW8695_GO_ENABLE);
+}
+
+static void aw8695_close(struct input_dev *input)
+{
+	struct aw8695_data *haptics = input_get_drvdata(input);
+	struct device *dev = &haptics->client->dev;
+	int err;
+
+	cancel_work_sync(&haptics->play_work);
+	err = aw8695_stop(haptics);
+	if (err)
+		dev_err(dev, "Failed to stop haptics: %d\n", err);
+}
+
+static void aw8695_haptics_play_work(struct work_struct *work)
+{
+	struct aw8695_data *haptics =
+		container_of(work, struct aw8695_data, play_work);
+	struct device *dev = &haptics->client->dev;
+	int err;
+
+	if (haptics->level)
+		err = aw8695_play_sine(haptics);
+	else
+		err = aw8695_stop(haptics);
+
+	if (err)
+		dev_err(dev, "Failed to execute work command: %d\n", err);
+}
+
+static int aw8695_haptic_offset_calibration(struct aw8695_data *haptics)
+{
+	unsigned int read_buf;
+	int err;
+
+	err = regmap_update_bits(haptics->regmap, AW8695_SYSCTRL_REG,
+				 AW8695_SYSCTRL_RAMINIT_EN,
+				 AW8695_SYSCTRL_RAMINIT_EN);
+	if (err)
+		return err;
+
+	err = regmap_update_bits(haptics->regmap, AW8695_DETCTRL_REG,
+				 AW8695_DETCTRL_DIAG_GO_ENABLE,
+				 AW8695_DETCTRL_DIAG_GO_ENABLE);
+	if (err)
+		return err;
+
+	err = regmap_read_poll_timeout(haptics->regmap, AW8695_DETCTRL_REG, read_buf,
+			(read_buf & AW8695_DETCTRL_DIAG_GO_ENABLE) == 0, 10000, 10000 * 50);
+	if (err)
+		return err;
+
+	return regmap_update_bits(haptics->regmap, AW8695_SYSCTRL_REG,
+				  AW8695_SYSCTRL_RAMINIT_EN, 0);
+}
+
+static int aw8695_init(struct aw8695_data *haptics)
+{
+	int err;
+	unsigned int read_buf;
+	struct device *dev = &haptics->client->dev;
+
+	aw8695_hw_reset(haptics);
+
+	err = regmap_read(haptics->regmap, AW8695_ID_REG, &read_buf);
+	if (err) {
+		dev_err(dev, "Failed to read ID register: %d\n", err);
+		return err;
+	}
+
+	if (read_buf != AW8695_CHIPID) {
+		dev_err(dev, "Chip ID mismatch: expected %x, got %x\n",
+			AW8695_CHIPID, read_buf);
+		return -ENODEV;
+	}
+
+	err = regmap_write(haptics->regmap, AW8695_ID_REG, AW8695_RESET);
+	if (err) {
+		dev_err(dev, "Failed to reset: %d\n", err);
+		return err;
+	}
+
+	/* Wait ~1ms after reset */
+	usleep_range(1000, 1500);
+
+	/* Clear UVLI bit by reading register */
+	err = aw8695_interrupt_clear(haptics);
+	if (err) {
+		dev_err(dev, "Failed to clear interrupt: %d\n", err);
+		return err;
+	}
+
+	/* Set interrupt mode to edge */
+	err = regmap_update_bits(haptics->regmap, AW8695_DBGCTRL_REG,
+				 AW8695_DBGCTRL_INT_MODE_MASK,
+				 FIELD_PREP(AW8695_DBGCTRL_INT_MODE_MASK,
+					    AW8695_DBGCTRL_INT_MODE_EDGE));
+	if (err) {
+		dev_err(dev, "Failed to set interrupt mode: %d\n", err);
+		return err;
+	}
+
+	/* Configure interrupts */
+	err = regmap_update_bits(haptics->regmap, AW8695_SYSINTM_REG,
+				 AW8695_SYSINTM_BSTERR_OFF | AW8695_SYSINTM_OV_OFF |
+				 AW8695_SYSINTM_UVLO_OFF | AW8695_SYSINTM_OCD_OFF |
+				 AW8695_SYSINTM_OT_OFF,
+				 AW8695_SYSINTM_BSTERR_OFF);
+	if (err)
+		return err;
+
+	err = aw8695_play_mode(haptics, AW8695_STANDBY_MODE);
+	if (err)
+		return err;
+
+	err = regmap_update_bits(haptics->regmap, AW8695_PWMDBG_REG,
+				 AW8695_PWMDBG_PWM_MODE_MASK,
+				 FIELD_PREP(AW8695_PWMDBG_PWM_MODE_MASK,
+					    AW8695_PWMDBG_PWM_24K));
+	if (err)
+		return err;
+
+	err = regmap_write(haptics->regmap, AW8695_BSTDBG1_REG, AW8695_BSTDBG1_DEFAULT);
+	if (err)
+		return err;
+	err = regmap_write(haptics->regmap, AW8695_BSTDBG2_REG, AW8695_BSTDBG2_DEFAULT);
+	if (err)
+		return err;
+	err = regmap_write(haptics->regmap, AW8695_BSTDBG3_REG, AW8695_BSTDBG3_DEFAULT);
+	if (err)
+		return err;
+	err = regmap_write(haptics->regmap, AW8695_TSET_REG, AW8695_TSET_DEFAULT);
+	if (err)
+		return err;
+	err = regmap_write(haptics->regmap, AW8695_R_SPARE_REG, Aw8695_R_SPARE_DEFAULT);
+	if (err)
+		return err;
+
+	err = regmap_update_bits(haptics->regmap, AW8695_ANADBG_REG,
+				 AW8695_ANADBG_IOC_MASK,
+				 FIELD_PREP(AW8695_ANADBG_IOC_MASK,
+					    AW8695_ANADBG_IOC_4P65A));
+	if (err)
+		return err;
+
+	/* Set boost peak current */
+	err = regmap_update_bits(haptics->regmap, AW8695_BSTCFG_REG,
+				 AW8695_BSTCFG_PEAKCUR_MASK,
+				 FIELD_PREP(AW8695_BSTCFG_PEAKCUR_MASK,
+					    AW8695_BSTCFG_PEAKCUR_2A));
+	if (err)
+		return err;
+
+	/* Adjust motorprotect config */
+	err = regmap_update_bits(haptics->regmap, AW8695_DETCTRL_REG,
+				 AW8695_DETCTRL_PROTECT_MASK,
+				 FIELD_PREP(AW8695_DETCTRL_PROTECT_MASK,
+					    AW8695_DETCTRL_PROTECT_NO_ACTION));
+	if (err)
+		return err;
+	err = regmap_update_bits(haptics->regmap, AW8695_PWMPRC_REG,
+				 AW8695_PWMPRC_PRC_ENABLE, 0);
+	if (err)
+		return err;
+	err = regmap_update_bits(haptics->regmap, AW8695_PRLVL_REG,
+				 AW8695_PRLVL_PR_ENABLE, 0);
+	if (err)
+		return err;
+
+	/* Adjust auto boost config */
+	err = regmap_update_bits(haptics->regmap, AW8695_BST_AUTO_REG,
+				 AW8695_BST_AUTO_BST_AUTOSW_MASK,
+				 FIELD_PREP(AW8695_BST_AUTO_BST_AUTOSW_MASK,
+					    AW8695_BST_AUTO_BST_MANUAL_BOOST));
+	if (err)
+		return err;
+
+	err = aw8695_haptic_offset_calibration(haptics);
+	if (err)
+		return err;
+
+	/* Set vbat compensation mode */
+	err = regmap_update_bits(haptics->regmap, AW8695_ADCTEST_REG,
+				 AW8695_ADCTEST_VBAT_MODE_MASK,
+				 FIELD_PREP(AW8695_ADCTEST_VBAT_MODE_MASK,
+					    AW8695_ADCTEST_VBAT_HW_COMP));
+	if (err)
+		return err;
+
+	/* bemf config */
+	err = regmap_write(haptics->regmap, AW8695_BEMF_VTHH_H_REG,
+			   FIELD_GET(AW8695_HIGH_MASK, AW8695_BEMF_UPPER_THRESHOLD));
+	if (err)
+		return err;
+	err = regmap_write(haptics->regmap, AW8695_BEMF_VTHH_L_REG,
+			   FIELD_GET(AW8695_LOW_MASK, AW8695_BEMF_UPPER_THRESHOLD));
+	if (err)
+		return err;
+	err = regmap_write(haptics->regmap, AW8695_BEMF_VTHL_H_REG,
+			   FIELD_GET(AW8695_HIGH_MASK, AW8695_BEMF_LOWER_THRESHOLD));
+	if (err)
+		return err;
+	return regmap_write(haptics->regmap, AW8695_BEMF_VTHL_L_REG,
+			    FIELD_GET(AW8695_LOW_MASK, AW8695_BEMF_LOWER_THRESHOLD));
+}
+
+static int aw8695_ram_init(struct aw8695_data *haptics)
+{
+	int err;
+
+	/* Enable SRAM init */
+	err = regmap_update_bits(haptics->regmap, AW8695_SYSCTRL_REG,
+				 AW8695_SYSCTRL_RAMINIT_EN, AW8695_SYSCTRL_RAMINIT_EN);
+	if (err)
+		return err;
+
+	/* Set RAMDATA write address */
+	err = regmap_write(haptics->regmap, AW8695_RAMADDRH_REG,
+			   FIELD_GET(AW8695_HIGH_MASK, AW8695_RAM_BASE_ADDR));
+	if (err)
+		return err;
+	err = regmap_write(haptics->regmap, AW8695_RAMADDRL_REG,
+			   FIELD_GET(AW8695_LOW_MASK, AW8695_RAM_BASE_ADDR));
+	if (err)
+		return err;
+
+	err = regmap_noinc_write(haptics->regmap, AW8695_RAMDATA_REG,
+				 &sram_waveform_header, sizeof(sram_waveform_header));
+	if (err)
+		return err;
+
+	err = regmap_noinc_write(haptics->regmap, AW8695_RAMDATA_REG,
+				  aw8695_sine_waveform, ARRAY_SIZE(aw8695_sine_waveform));
+	if (err)
+		return err;
+
+	/* Disable SRAM init */
+	return regmap_update_bits(haptics->regmap, AW8695_SYSCTRL_REG,
+				  AW8695_SYSCTRL_RAMINIT_EN, 0);
+}
+
+static irqreturn_t aw8695_irq(int irq, void *data)
+{
+	struct aw8695_data *haptics = data;
+	struct device *dev = &haptics->client->dev;
+	unsigned int read_buf;
+	int err;
+
+	err = regmap_read(haptics->regmap, AW8695_SYSINT_REG, &read_buf);
+	if (err) {
+		dev_err(dev, "Failed to read SYSINT register: %d\n", err);
+		return IRQ_NONE;
+	}
+	dev_dbg(dev, "Interrupt: SYSINT=0x%x\n", read_buf);
+
+	if (read_buf & AW8695_SYSINT_BSTERRI)
+		dev_err(dev, "Received boost short circuit protection or over-voltage protection interrupt!\n");
+	if (read_buf & AW8695_SYSINT_OVI)
+		dev_err(dev, "Received wave data overflow or DPWM DC error interrupt!\n");
+	if (read_buf & AW8695_SYSINT_UVLI)
+		dev_err(dev, "Received under voltage lock out interrupt!\n");
+	if (read_buf & AW8695_SYSINT_OCDI)
+		dev_err(dev, "Received over current interrupt!\n");
+	if (read_buf & AW8695_SYSINT_OTI)
+		dev_err(dev, "Received over temperature interrupt!\n");
+
+	if (read_buf & AW8695_SYSINT_DONEI)
+		dev_dbg(dev, "Received playback done interrupt\n");
+	/* FIFO mode is not (yet) implemented in this driver */
+	if (read_buf & AW8695_SYSINT_FF_AEI)
+		dev_dbg(dev, "Received FIFO almost empty interrupt\n");
+	if (read_buf & AW8695_SYSINT_FF_AFI)
+		dev_dbg(dev, "Received FIFO almost full interrupt\n");
+
+	err = regmap_read(haptics->regmap, AW8695_DBGSTAT_REG, &read_buf);
+	if (err) {
+		dev_err(dev, "Failed to read DBGSTAT register: %d\n", err);
+		return IRQ_NONE;
+	}
+	dev_dbg(dev, "Interrupt: DBGSTAT=0x%x\n", read_buf);
+
+	err = regmap_read(haptics->regmap, AW8695_SYSST_REG, &read_buf);
+	if (err) {
+		dev_err(dev, "Failed to read SYSST register: %d\n", err);
+		return IRQ_NONE;
+	}
+	dev_dbg(dev, "Interrupt: SYSST=0x%x\n", read_buf);
+
+	return IRQ_HANDLED;
+}
+
+static const struct regmap_config aw8695_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+
+	.max_register = AW8695_MAX_REG,
+	.cache_type = REGCACHE_NONE,
+};
+
+static int aw8695_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct aw8695_data *haptics;
+	int err;
+
+	haptics = devm_kzalloc(dev, sizeof(*haptics), GFP_KERNEL);
+	if (!haptics)
+		return -ENOMEM;
+
+	haptics->client = client;
+	i2c_set_clientdata(client, haptics);
+
+	haptics->regmap = devm_regmap_init_i2c(client, &aw8695_regmap_config);
+	if (IS_ERR(haptics->regmap))
+		return dev_err_probe(dev, PTR_ERR(haptics->regmap),
+				     "Failed to allocate register map\n");
+
+	haptics->input_dev = devm_input_allocate_device(dev);
+	if (!haptics->input_dev)
+		return -ENOMEM;
+
+	haptics->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(haptics->reset_gpio))
+		return dev_err_probe(dev, PTR_ERR(haptics->reset_gpio),
+				     "Failed to get reset gpio\n");
+
+	err = devm_request_threaded_irq(dev, client->irq, NULL, aw8695_irq,
+		IRQF_ONESHOT, NULL, haptics);
+	if (err)
+		return dev_err_probe(dev, err, "Failed to request interrupt\n");
+
+	INIT_WORK(&haptics->play_work, aw8695_haptics_play_work);
+
+	haptics->input_dev->name = "aw8695";
+	haptics->input_dev->close = aw8695_close;
+
+	input_set_drvdata(haptics->input_dev, haptics);
+	input_set_capability(haptics->input_dev, EV_FF, FF_RUMBLE);
+
+	err = input_ff_create_memless(haptics->input_dev, NULL,
+				      aw8695_haptics_play);
+	if (err)
+		return dev_err_probe(dev, err, "Failed to create FF dev\n");
+
+	err = aw8695_init(haptics);
+	if (err)
+		return dev_err_probe(dev, err, "Failed to init aw8695\n");
+
+	err = aw8695_ram_init(haptics);
+	if (err)
+		return dev_err_probe(dev, err, "Failed to init aw8695 sram\n");
+
+	err = input_register_device(haptics->input_dev);
+	if (err)
+		return dev_err_probe(dev, err, "Failed to register input device\n");
+
+	return 0;
+}
+
+static const struct of_device_id aw8695_of_id[] = {
+	{ .compatible = "awinic,aw8695", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, aw8695_of_id);
+
+static struct i2c_driver aw8695_driver = {
+	.driver = {
+		.name = "aw8695",
+		.of_match_table = aw8695_of_id,
+	},
+	.probe = aw8695_probe,
+};
+
+module_i2c_driver(aw8695_driver);
+
+MODULE_AUTHOR("Luca Weiss <luca.weiss@fairphone.com>");
+MODULE_DESCRIPTION("AW8695 LRA Haptic Driver");
+MODULE_LICENSE("GPL");

-- 
2.43.0

