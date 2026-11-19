Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795096492;
	b=lZMQceEjVA6fSrU9wy47zqLb6BBlQeVqKPstsickcVNHlLm6R5tb7ru1qmiPdnIdP7vB
	 I1Fx1HMsu+JQJpTGevC4EjEla1P5ukbmHBs4YdyJmLxJpv5Ru7Khw2KGfQGXSoMqYZloV
	 oMFusCD8QEvMQuBQaSXDauwDJSlCOBe37ToXPUDil15DTaPNb73nst5D37XSeRLKMHxmG
	 xmU4LlOuy74tHydfsLzGhKVZzearUeFpZwMpZI02bFdqIJpCunfedPeXtCelLzv/RFCML
	 vebUuxTUR1SL8vvTqYOvmvE4ngahJ/ShPXOzTCQn6M16zXaGDrUOcuFjoR6dFEojyuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795096492;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=FVLTxBVISJSZTdcqGck9MH3oVI2sjRK1JwZItmtgc+g=;
	b=j4/bWAdiEIJ3+UE8Z0fOToVhz2WALolkrCsTp4yrUdnMq42UYs0gVLU6Qk+T2CT/xK4B
	 NshwC31holplGPTAlhkhR4LCCEJLt8/WlAgxqxWvrjFgTva3XsO7nNavRNQpsElCv4xpY
	 fwdhl1dF5GQ1u1O/ifXkOz2tFyS4k/z5g5qKgdlTJeCzm25hljpnxIATtgJIj3Jl2zRH8
	 tskw4dt2h/2xmmxwmTpcFRAPfov7SfaAD/0+AkwKLCS8c7xVhgD0HRvYd8jgjp1t+4wSz
	 dIn3XkFPfaBtsdiRmdzngZAz2HCsDGD51XiDlQPihKyRxNYfxxHNxSmMiVc1WHTnrdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fairphone.com;
	spf=pass smtp.mailfrom=fairphone.com;
	dkim=pass header.d=fairphone.com header.i=@fairphone.com header.a=rsa-sha256 header.s=fair header.b=AyfkW7HB;
	arc=none smtp.remote-ip=209.85.218.48
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2497F606A332
	for <linux-input@vger.kernel.org>; Thu, 19 Nov 2026 13:54:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2497F606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.a=rsa-sha256 header.s=fair header.b=AyfkW7HB
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c50e26763a4so358436066b.1
        for <linux-input@vger.kernel.org>; Thu, 19 Nov 2026 05:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1795096490; x=1795701290; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FVLTxBVISJSZTdcqGck9MH3oVI2sjRK1JwZItmtgc+g=;
        b=AyfkW7HBX56X25rGddvfYfNYljZ14tuK0phJQFsaoq+OOvSGtOv6IfgJK7yziwrrmo
         f/5A9qF6GxRco4VNCNv8Q+pooAEOcQCE5Se4U3Ds4hvS1789ghHhbUYKn4QDXzkEyZKT
         ki9iG8WctytORNfUWmeJHe3XmHuh+3DHA1uoZs0keyC10UqYZPWGHQIKnUEWByXKG8Sa
         lCMA6bXWYXmPEpJ4WbMi7oCK8sx/aFo2C+PbSzgcUP7C7tAg+Qxcgk1/exQbiVNbMeXo
         HidDbMtTHWUYhMgMS8kU9JAo/5IkVrFguI3lattVALqgKL5gPVy1zJVdXcmqkcI94qUQ
         7YRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795096490; x=1795701290;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FVLTxBVISJSZTdcqGck9MH3oVI2sjRK1JwZItmtgc+g=;
        b=yrIAdM91Vxi4LSxpv8dyXfUB5zwSemwxhc9Msv1F318JhfWEnIHVPTerpfuu9MuKBq
         2oeolaBynfSgtlfVcXEJya8sNIUDh9CXzbxLPInnUUwNcSjtLbIsmIgT5K7YS9wHZDdB
         +qU1UnC/WW5mNZPbu3I1DeZTAn+4hoyxzeGmCHykwvwr3cF98uVFb+sODtY8tekKXUpz
         q0MLduKAvJhL3ty4F1B0H9sGfAcxnZvRpnkZqiPjOWNw1z7BXtBj5vZV6kdwYWPMjhsg
         Q2MP+kuv/J6DT0o7Eb0VMgNqWJdeIgbHCF7T+iRjiXDzwkGbpDq2KNnXTrQl7puUWr6X
         Nmfw==
X-Gm-Message-State: APuU4Z+AKD5v1i6oaTfBf3D6JbuYjs9mu+cZIetxax9ANWi5keL1dUl1
	SjF6K063nQN6ERXoBpmd2XcC8c/fMQdAdWKX2YTtQAAMjBVYB1QOLMERa6AYmg4ZUafck8Eiyn1
	Y+rW+H4o=
X-Gm-Gg: AYBFou1t11/93lsaZjHa5de0YenaEwhfvxEMz6vI7LjjbfGPCPHFRHwPwoZMIOQ6ugx
	VdSmUNA1gDrdGeqaER9RfrBAOms2edqaoMUuDs5U4Z3OgVSDEOFaDgwfyAk0oeqpgS+CzhaUKFO
	xuJJeAMUNuJkxg+++18P8oe506RtspGaNJK2vXtXNG63pyMp7Izud0VWWXbYlj5A75hxLhX/Yvz
	sRhnJEKH4RQTrQKVAfaU/hLNZhskWMX3kMthJlJv+b9FXFerqPaGq8tHbNk5KG/QJbU3s7rJgRf
	YtjHNTo2hG7GR8872K7l2mHaIQdchXKN8uQyCTI0RkqjHENyDrUxDSOAsiAxRGvM5Xz1Gj6isvO
	S+kUhAurOWScGArtnk0hL+TaA+zaFXtb8+WZ9SggaBkNL2TN0R2L8MLBvOZTJ2ePBzuMe+VykX5
	GA7GVP/CtnKtvu50OpqESXdeOjTonZ5I2NZv8tdK0ya6Mm9ic3cG3wOEd0Ie4QuJscoviIcYhum
	3CY5lLeFwuLmS13qfcujweY6nLg7IV4Y4bE3gHB+0in1ApdzOtwRx3Qe59JCGfvIIlVYDSw7gMy
	5dxdZtlKOWNIuZwhQOLDRc3gTZMwDMaiAOpSVzOmFUoOxVo6qwUMkZoto4ELDV1+Fc9tjDdFnsy
	gUUCI1sPdO2I=
X-Received: by 2002:a17:907:c13:b0:c48:1977:e1bf with SMTP id a640c23a62f3a-c510e356423mr479108466b.24.1795096489614;
        Thu, 19 Nov 2026 05:54:49 -0800 (PST)
Received: from [172.16.220.224] (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c51233c4d02sm106820266b.21.2026.11.19.05.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 05:54:49 -0800 (PST)
From: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
Date: Thu, 19 Nov 2026 14:54:46 +0100
Subject: [PATCH v4 2/4] Input - aw8695: Add driver for AW8695 haptics
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261119-aw8695_haptic_fp4_driver-v4-2-9d107334bdb2@fairphone.com>
References: <20261119-aw8695_haptic_fp4_driver-v4-0-9d107334bdb2@fairphone.com>
In-Reply-To: <20261119-aw8695_haptic_fp4_driver-v4-0-9d107334bdb2@fairphone.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Luca Weiss <luca.weiss@fairphone.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795096488; l=25551;
 i=griffin.kroah@fairphone.com; s=20250804; h=from:subject:message-id;
 bh=e7N5aG6kMUwukKy2+bkEevDEnsIDG7p428Ans/9eHgg=;
 b=Libj1C+0wS6QHxWrvSxfUmlw+prmeTG3rMJu23xfmsPAqiRnBzxjMuemVn6IZ7N0aRGyj1UOn
 q1Xn5MSr18MCIn6v+hxhjJU6XZMP4yALvIqq86KgPmYM/OXqLzerqQE
X-Developer-Key: i=griffin.kroah@fairphone.com; a=ed25519;
 pk=drSBvqKFiR+xucmLWONHSq/wGrW+YvcVtBXFYnYzn8U=

From: Luca Weiss <luca.weiss@fairphone.com>

Add a driver for interfacing with the Awinic AW8695 LRA Haptic Driver.

The chip supports multiple modes of which only RAM mode is implemented.
RTP mode would enable a user to "stream" waveform data but to my
knowledge no such user space API exists in the kernel yet.

We upload a basic sine wave to the chip and play this on request.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
Co-developed-by: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
Signed-off-by: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
---
 drivers/input/misc/Kconfig  |  11 +
 drivers/input/misc/Makefile |   1 +
 drivers/input/misc/aw8695.c | 813 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 825 insertions(+)

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
index 0000000000000000000000000000000000000000..e83bdf029def86f21ba295b7f7c52333ed544d22
--- /dev/null
+++ b/drivers/input/misc/aw8695.c
@@ -0,0 +1,813 @@
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
+#define AW8695_DATDBG				0x39
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
+	bool suspend;
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
+	err = regmap_update_bits(haptics->regmap, AW8695_SYSINTM_REG,
+				 AW8695_SYSINTM_UVLO_OFF, 0);
+	if (err)
+		return err;
+
+	return 0;
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
+	err = aw8695_play_mode(haptics, AW8695_STANDBY_MODE);
+	if (err)
+		return err;
+
+	return 0;
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
+	err = regmap_write(haptics->regmap, AW8695_DATDBG, haptics->level * 0x80 / 0xffff);
+	if (err)
+		return err;
+
+	/* Configure for RAM mode */
+	err = aw8695_play_mode(haptics, AW8695_RAM_MODE);
+	if (err)
+		return err;
+
+	/* Start vibration */
+	err = regmap_update_bits(haptics->regmap, AW8695_GO_REG,
+				 AW8695_GO_ENABLE, AW8695_GO_ENABLE);
+	if (err)
+		return err;
+
+	return 0;
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
+	if (haptics->suspend)
+		return;
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
+	err = regmap_update_bits(haptics->regmap, AW8695_SYSCTRL_REG,
+				 AW8695_SYSCTRL_RAMINIT_EN, 0);
+	if (err)
+		return err;
+
+	return 0;
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
+	err = regmap_write(haptics->regmap, AW8695_BEMF_VTHL_L_REG,
+			   FIELD_GET(AW8695_LOW_MASK, AW8695_BEMF_LOWER_THRESHOLD));
+	if (err)
+		return err;
+
+	return 0;
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
+	err = regmap_update_bits(haptics->regmap, AW8695_SYSCTRL_REG,
+				 AW8695_SYSCTRL_RAMINIT_EN, 0);
+	if (err)
+		return err;
+
+	return 0;
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
+		dev_dbg_ratelimited(dev, "Received playback done interrupt\n");
+
+	err = regmap_read(haptics->regmap, AW8695_DBGSTAT_REG, &read_buf);
+	if (err) {
+		dev_err(dev, "Failed to read DBGSTAT register: %d\n", err);
+		return IRQ_NONE;
+	}
+
+	err = regmap_read(haptics->regmap, AW8695_SYSST_REG, &read_buf);
+	if (err) {
+		dev_err(dev, "Failed to read SYSST register: %d\n", err);
+		return IRQ_NONE;
+	}
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
+	err = devm_request_threaded_irq(dev, client->irq, NULL, aw8695_irq,
+		IRQF_ONESHOT, NULL, haptics);
+	if (err)
+		return dev_err_probe(dev, err, "Failed to request interrupt\n");
+
+	err = input_register_device(haptics->input_dev);
+	if (err)
+		return dev_err_probe(dev, err, "Failed to register input device\n");
+
+	return 0;
+}
+
+static int aw8695_suspend(struct device *dev)
+{
+	struct aw8695_data *haptics = dev_get_drvdata(dev);
+
+	if (haptics->suspend)
+		return 0;
+
+	disable_work_sync(&haptics->play_work);
+	aw8695_stop(haptics);
+	haptics->suspend = true;
+	haptics->level = 0;
+	return 0;
+}
+
+static int aw8695_resume(struct device *dev)
+{
+	struct aw8695_data *haptics = dev_get_drvdata(dev);
+
+	if (!haptics->suspend)
+		return 0;
+
+	enable_work(&haptics->play_work);
+	aw8695_haptic_set_active(haptics);
+	aw8695_play_mode(haptics, AW8695_STANDBY_MODE);
+	haptics->suspend = false;
+	return 0;
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(aw8695_pm_ops,
+				aw8695_suspend,
+				aw8695_resume);
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
+		.pm   = pm_sleep_ptr(&aw8695_pm_ops),
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

