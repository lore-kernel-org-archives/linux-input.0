Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F57A3BE146;
	Mon, 27 Jul 2026 03:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785121356; cv=none; b=SSVESgQNBs++27n29oej1NgHyvawDD2UP1K5OpOwcqA0Xjdu0ZG9Ffcyy3pp1FRSCbQ0MUyQDDTWM4ewhZtf14hCLPcO0czDPCyG+r5T0EwsGefGFArTUs24875BH4QGtrmZUNXZFq+qeDmtdabQIzM9cHZpVQ4PeFfNFDRS0vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785121356; c=relaxed/simple;
	bh=2RtydDQ5LyilB9NLGKPpXV/OCvHJ7xnVGi8TRUr0mjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gXlGX0zmVmzguBhA4Cru18kkKBzCRIgcJcUiizXHAtM+Uaez1X86wM+hsfE0Y7YJDBX+XAZ/BKHW1GdaqZnnJQ3oAZlFwHksKp9qO8p1r8PBuRPbOyVU9mLZ+tOK29o3qD4JsBhJPMv860d0TPGRLpcgHxDY8NF/T5z/SFZQKlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=elg4RUQc; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="elg4RUQc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785121354; x=1816657354;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2RtydDQ5LyilB9NLGKPpXV/OCvHJ7xnVGi8TRUr0mjw=;
  b=elg4RUQcitmOtoITyf3s4CWehTfM88JliJZgYHU2uXyVs25hizENCPKU
   HnZJFk8M6eXHkxF1p1M9HwBQtKjngQwpbevexV08C5iE/QFKmVMXsYHiW
   57Csq2zjbFGlXcD9ELh0kmau7y+OvdVsNPEi+K4BKrZ2zxpTT/wpDRE3S
   JYXTWTBsSCFeSYYKovQfCyOFLrNOnwhLpEfzKgNSgUqwWRcDOOsJUey7J
   rRbVgzfzvLe/jNx9ZONyUk4AhOg8ZfUGzvytYezm+6iiyHXWXu6Atm6Gz
   tiaE/h5/bxxzUKIzMxVRsoQ0+guirKSkG5Z6sdn6lTJcbxOdaai7LeD0X
   g==;
X-CSE-ConnectionGUID: pAZ7lY5hRfC6AbzDttkaRQ==
X-CSE-MsgGUID: SelHHCZZS+m+tMs9VfQ8ZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11857"; a="97200400"
X-IronPort-AV: E=Sophos;i="6.25,187,1779174000"; 
   d="scan'208";a="97200400"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2026 20:02:33 -0700
X-CSE-ConnectionGUID: VQ2X9a98SmOjNV4fE24g3w==
X-CSE-MsgGUID: XbzUO4VyRbGVYN4YxnrD8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,187,1779174000"; 
   d="scan'208";a="255365091"
Received: from shsensorbuild.sh.intel.com ([10.239.132.250])
  by fmviesa010.fm.intel.com with ESMTP; 26 Jul 2026 20:02:32 -0700
From: Even Xu <even.xu@intel.com>
To: bentiss@kernel.org,
	jikos@kernel.org
Cc: srinivas.pandruvada@linux.intel.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Even Xu <even.xu@intel.com>
Subject: [PATCH 1/2] HID: Intel-thc-hid: Intel-thc: Refactor I2C bus configuration with unified config structure
Date: Mon, 27 Jul 2026 11:03:09 +0800
Message-ID: <20260727030310.3850984-2-even.xu@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260727030310.3850984-1-even.xu@intel.com>
References: <20260727030310.3850984-1-even.xu@intel.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a new struct thc_i2c_config to consolidate all configurable
I2C bus parameters into a single structure for better maintainability
and extensibility.

Changes include:
- Add struct thc_i2c_config to encapsulate I2C bus parameters
- Rename thc_i2c_subip_set_speed() to thc_i2c_subip_bus_config() to
  better reflect its expanded functionality
- Update thc_i2c_subip_bus_config() to accept struct thc_i2c_config
  parameter for comprehensive I2C parameter configuration
- Modify thc_i2c_subip_init() to use struct thc_i2c_config and call
  thc_i2c_subip_bus_config() for complete bus initialization

This refactoring improves code organization and unifies I2C configuration
parameters.

Signed-off-by: Even Xu <even.xu@intel.com>
---
 .../intel-thc-hid/intel-thc/intel-thc-dev.c   | 69 ++++++++++++-------
 .../intel-thc-hid/intel-thc/intel-thc-dev.h   | 23 ++++++-
 .../intel-thc-hid/intel-thc/intel-thc-hw.h    |  3 +
 3 files changed, 68 insertions(+), 27 deletions(-)

diff --git a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dev.c b/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dev.c
index 9a8449428170..7b4a58e1416d 100644
--- a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dev.c
+++ b/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dev.c
@@ -1422,14 +1422,25 @@ static int thc_i2c_subip_pio_write(struct thc_device *dev, const u32 address,
 #define I2C_SUBIP_DMA_TDLR_DEFAULT	7
 #define I2C_SUBIP_DMA_RDLR_DEFAULT	7
 
-static int thc_i2c_subip_set_speed(struct thc_device *dev, const u32 speed,
-				   const u32 hcnt, const u32 lcnt)
+static int thc_i2c_subip_bus_config(struct thc_device *dev, const struct thc_i2c_config *i2c_config)
 {
 	u32 hcnt_offset, lcnt_offset;
-	u32 val;
+	u32 read_size = sizeof(u32);
+	u32 val = 0;
 	int ret;
 
-	switch (speed) {
+	ret = thc_i2c_subip_pio_read(dev, THC_I2C_IC_TAR_OFFSET, &read_size, &val);
+	if (ret < 0)
+		return ret;
+
+	val &= ~(THC_I2C_IC_TAR_IC_TAR | THC_I2C_IC_TAR_IC_10BITADDR_MASTER);
+	val |= FIELD_PREP(THC_I2C_IC_TAR_IC_10BITADDR_MASTER, i2c_config->addr_mode);
+	val |= FIELD_PREP(THC_I2C_IC_TAR_IC_TAR, i2c_config->target_addr);
+	ret = thc_i2c_subip_pio_write(dev, THC_I2C_IC_TAR_OFFSET, sizeof(u32), &val);
+	if (ret < 0)
+		return ret;
+
+	switch (i2c_config->speed) {
 	case THC_I2C_STANDARD:
 		hcnt_offset = THC_I2C_IC_SS_SCL_HCNT_OFFSET;
 		lcnt_offset = THC_I2C_IC_SS_SCL_LCNT_OFFSET;
@@ -1446,25 +1457,43 @@ static int thc_i2c_subip_set_speed(struct thc_device *dev, const u32 speed,
 		break;
 
 	default:
-		dev_err_once(dev->dev, "Unsupported i2c speed %d\n", speed);
+		dev_err_once(dev->dev, "Unsupported i2c speed %d\n", i2c_config->speed);
 		ret = -EINVAL;
 		return ret;
 	}
 
-	ret = thc_i2c_subip_pio_write(dev, hcnt_offset, sizeof(u32), &hcnt);
+	ret = thc_i2c_subip_pio_write(dev, hcnt_offset, sizeof(u32), &i2c_config->scl_hcnt);
 	if (ret < 0)
 		return ret;
 
-	ret = thc_i2c_subip_pio_write(dev, lcnt_offset, sizeof(u32), &lcnt);
+	ret = thc_i2c_subip_pio_write(dev, lcnt_offset, sizeof(u32), &i2c_config->scl_lcnt);
 	if (ret < 0)
 		return ret;
 
 	val = I2C_SUBIP_CON_DEFAULT & ~THC_I2C_IC_CON_SPEED;
-	val |= FIELD_PREP(THC_I2C_IC_CON_SPEED, speed);
+	val |= FIELD_PREP(THC_I2C_IC_CON_SPEED, i2c_config->speed);
 	ret = thc_i2c_subip_pio_write(dev, THC_I2C_IC_CON_OFFSET, sizeof(u32), &val);
 	if (ret < 0)
 		return ret;
 
+	ret = thc_i2c_subip_pio_read(dev, THC_I2C_IC_SDA_HOLD_OFFSET, &read_size, &val);
+	if (ret < 0)
+		return ret;
+
+	if (i2c_config->sda_tx_hold) {
+		val &= ~THC_I2C_IC_SDA_HOLD_IC_SDA_TX_HOLD;
+		val |= FIELD_PREP(THC_I2C_IC_SDA_HOLD_IC_SDA_TX_HOLD, i2c_config->sda_tx_hold);
+	}
+
+	if (i2c_config->sda_rx_hold) {
+		val &= ~THC_I2C_IC_SDA_HOLD_IC_SDA_RX_HOLD;
+		val |= FIELD_PREP(THC_I2C_IC_SDA_HOLD_IC_SDA_RX_HOLD, i2c_config->sda_rx_hold);
+	}
+
+	ret = thc_i2c_subip_pio_write(dev, THC_I2C_IC_SDA_HOLD_OFFSET, sizeof(u32), &val);
+	if (ret < 0)
+		return ret;
+
 	return 0;
 }
 
@@ -1474,6 +1503,7 @@ static u32 i2c_subip_regs[] = {
 	THC_I2C_IC_INTR_MASK_OFFSET,
 	THC_I2C_IC_RX_TL_OFFSET,
 	THC_I2C_IC_TX_TL_OFFSET,
+	THC_I2C_IC_SDA_HOLD_OFFSET,
 	THC_I2C_IC_DMA_CR_OFFSET,
 	THC_I2C_IC_DMA_TDLR_OFFSET,
 	THC_I2C_IC_DMA_RDLR_OFFSET,
@@ -1490,20 +1520,19 @@ static u32 i2c_subip_regs[] = {
  * thc_i2c_subip_init - Initialize and configure THC I2C subsystem
  *
  * @dev: The pointer of THC private device context
- * @target_address: Slave address of touch device (TIC)
- * @speed: I2C bus frequency speed mode
- * @hcnt: I2C clock SCL high count
- * @lcnt: I2C clock SCL low count
+ * @i2c_config: The pointer of THC I2C bus configure structure
  *
  * Return: 0 on success, other error codes on failed.
  */
-int thc_i2c_subip_init(struct thc_device *dev, const u32 target_address,
-		       const u32 speed, const u32 hcnt, const u32 lcnt)
+int thc_i2c_subip_init(struct thc_device *dev, const struct thc_i2c_config *i2c_config)
 {
 	u32 read_size = sizeof(u32);
 	u32 val;
 	int ret;
 
+	if (!dev || !i2c_config)
+		return -EINVAL;
+
 	ret = thc_i2c_subip_pio_read(dev, THC_I2C_IC_ENABLE_OFFSET, &read_size, &val);
 	if (ret < 0)
 		return ret;
@@ -1513,17 +1542,7 @@ int thc_i2c_subip_init(struct thc_device *dev, const u32 target_address,
 	if (ret < 0)
 		return ret;
 
-	ret = thc_i2c_subip_pio_read(dev, THC_I2C_IC_TAR_OFFSET, &read_size, &val);
-	if (ret < 0)
-		return ret;
-
-	val &= ~THC_I2C_IC_TAR_IC_TAR;
-	val |= FIELD_PREP(THC_I2C_IC_TAR_IC_TAR, target_address);
-	ret = thc_i2c_subip_pio_write(dev, THC_I2C_IC_TAR_OFFSET, sizeof(u32), &val);
-	if (ret < 0)
-		return ret;
-
-	ret = thc_i2c_subip_set_speed(dev, speed, hcnt, lcnt);
+	ret = thc_i2c_subip_bus_config(dev, i2c_config);
 	if (ret < 0)
 		return ret;
 
diff --git a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dev.h b/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dev.h
index 0db435335e24..be8a9605d02f 100644
--- a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dev.h
+++ b/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dev.h
@@ -49,6 +49,26 @@ enum thc_int_type {
 	THC_UNKNOWN_INT
 };
 
+/**
+ * struct thc_i2c_config - THC I2C bus configuration
+ * @target_addr: Slave address of touch device (TIC)
+ * @addr_mode: Slave address mode of touch device (TIC), 7bit or 10bit
+ * @speed: I2C bus frequency speed mode
+ * @scl_hcnt: I2C clock SCL high count
+ * @scl_lcnt: I2C clock SCL low count
+ * @sda_tx_hold: I2C Data SDA transmit hold period
+ * @sda_rx_hold: I2C Data SDA receive hold period
+ */
+struct thc_i2c_config {
+	u16 target_addr;
+	u8  addr_mode;
+	u32 speed;
+	u32 scl_hcnt;
+	u32 scl_lcnt;
+	u32 sda_tx_hold;
+	u32 sda_rx_hold;
+};
+
 /**
  * struct thc_device - THC private device struct
  * @thc_regmap: MMIO regmap structure for accessing THC registers
@@ -121,8 +141,7 @@ int thc_spi_write_config(struct thc_device *dev, u32 spi_freq_val,
 			 u32 io_mode, u32 opcode, u32 spi_wr_mps, u32 perf_limit);
 void thc_spi_input_output_address_config(struct thc_device *dev, u32 input_hdr_addr,
 					 u32 input_bdy_addr, u32 output_addr);
-int thc_i2c_subip_init(struct thc_device *dev, const u32 target_address,
-		       const u32 speed, const u32 hcnt, const u32 lcnt);
+int thc_i2c_subip_init(struct thc_device *dev, const struct thc_i2c_config *i2c_config);
 int thc_i2c_subip_regs_save(struct thc_device *dev);
 int thc_i2c_subip_regs_restore(struct thc_device *dev);
 int thc_i2c_set_rx_max_size(struct thc_device *dev, u32 max_rx_size);
diff --git a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-hw.h b/drivers/hid/intel-thc-hid/intel-thc/intel-thc-hw.h
index c6d026686b7a..a21222543ce4 100644
--- a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-hw.h
+++ b/drivers/hid/intel-thc-hid/intel-thc/intel-thc-hw.h
@@ -887,4 +887,7 @@ enum THC_I2C_SPEED_MODE {
 #define THC_I2C_IC_DMA_CR_RDMAE				BIT(0)
 #define THC_I2C_IC_DMA_CR_TDMAE				BIT(1)
 
+#define THC_I2C_IC_SDA_HOLD_IC_SDA_TX_HOLD		GENMASK(15, 0)
+#define THC_I2C_IC_SDA_HOLD_IC_SDA_RX_HOLD		GENMASK(23, 16)
+
 #endif /* _INTEL_THC_HW_H_  */
-- 
2.43.0

