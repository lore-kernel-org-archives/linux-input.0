Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567873BE642;
	Mon, 27 Jul 2026 03:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785121359; cv=none; b=j/s2ggrbG2G8GL4z4Au0ojE17XWaApDSlhmPGzUVGOlkY+X9f+TtjraLZgL41bTjPeiuiEZD3OeWXCAmjEqwrVUJklXFpHAvs19e7dkbcRSqN/bIdCr92w87o7WMRWghyIY4WaKtwP56q4Gh28LhPfMLFCnaQZc/THNEz/nahVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785121359; c=relaxed/simple;
	bh=F/w9FBc9HhgJUdkB3SlnNy7qFKVA3epIcfF4+EPtq4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PVk22gXxhv1NEXfO/qkpdM7mm6yK+FshZRivpE8ra2F2ANp4egEqlgFQJMoZUgXxxRkiV5vXr2ldtPdm/s69S8Dvgq3BfxffhyG0/OD9HfIUMiff5vwDJl9zRZsUTA9IRv04ZZmjHS3qbQfGM5fEyqISNKjK69k2n33aoDCvJiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ebOu0KIf; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ebOu0KIf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785121357; x=1816657357;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=F/w9FBc9HhgJUdkB3SlnNy7qFKVA3epIcfF4+EPtq4E=;
  b=ebOu0KIf5AG2nyMckey3pdvWxTauGbill4UMjSXJY2i0l3SFPzesrhu/
   It9iZjd17PffmbiLcbnBSCQn8z6bVEwTwduofHmRG1y8Rpaa9dvT8Kk6h
   dHbyqS1WVvqU02+fY9Lq5BBUxoWUb44dd35hjdRRZwmChWk7sqwxv7Pco
   hJjC1/0cznOzjgqUNJOc6P5pPTeXRllmDN98JUPKD1aHhNt1hXnGCaNHq
   h/4qy1Nw8GLiLWk3Et0M2bL/prhwosOLluycsXYM8GMoZze2q0RUFYNAZ
   SM4WjNR6nTl2up8Zl7pPQPj7DpvVt4iPX7BZNE+TpJQSVrNyQLPrLdLy+
   A==;
X-CSE-ConnectionGUID: RgkuBDOHT7e+WAZ5q4ebMw==
X-CSE-MsgGUID: 0n7d/1CRRRa6ZSQkAj0sAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11857"; a="97200406"
X-IronPort-AV: E=Sophos;i="6.25,187,1779174000"; 
   d="scan'208";a="97200406"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2026 20:02:37 -0700
X-CSE-ConnectionGUID: vDgvsPYsRYGSTqJs1SDehw==
X-CSE-MsgGUID: 5pOo+AM2Td+S9LnFMflbIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,187,1779174000"; 
   d="scan'208";a="255365095"
Received: from shsensorbuild.sh.intel.com ([10.239.132.250])
  by fmviesa010.fm.intel.com with ESMTP; 26 Jul 2026 20:02:35 -0700
From: Even Xu <even.xu@intel.com>
To: bentiss@kernel.org,
	jikos@kernel.org
Cc: srinivas.pandruvada@linux.intel.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Even Xu <even.xu@intel.com>
Subject: [PATCH 2/2] HID: Intel-thc-hid: Intel-quicki2c: Support full I2C BUS config parameters
Date: Mon, 27 Jul 2026 11:03:10 +0800
Message-ID: <20260727030310.3850984-3-even.xu@intel.com>
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

Read complete I2C bus configuration parameters from ACPI and passes them
to thc_i2c_subip_init() to properly initialize the THC I2C subip with
platform-specific settings.

This change enhances hardware compatibility by allowing full
platform-specific I2C bus configurations.

Signed-off-by: Even Xu <even.xu@intel.com>
---
 .../intel-quicki2c/pci-quicki2c.c             | 46 ++++++++++---------
 .../intel-quicki2c/quicki2c-dev.h             | 14 ++----
 2 files changed, 29 insertions(+), 31 deletions(-)

diff --git a/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c b/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
index 3ccbddfe8e5e..c3c7cf8e4b63 100644
--- a/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
+++ b/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
@@ -175,7 +175,9 @@ static int quicki2c_get_acpi_resources(struct quicki2c_device *qcdev)
 	if (i2c_param.addressing_mode != HIDI2C_ADDRESSING_MODE_7BIT)
 		return -EOPNOTSUPP;
 
-	qcdev->i2c_slave_addr = i2c_param.device_address;
+	qcdev->i2c_config.addr_mode = HIDI2C_ADDRESSING_MODE_7BIT;
+
+	qcdev->i2c_config.target_addr = i2c_param.device_address;
 
 	ret = quicki2c_acpi_get_dsd_property(adev, QUICKI2C_ACPI_METHOD_NAME_ISUB,
 					     ACPI_TYPE_BUFFER, &i2c_config);
@@ -184,24 +186,32 @@ static int quicki2c_get_acpi_resources(struct quicki2c_device *qcdev)
 
 	if (i2c_param.connection_speed > 0 &&
 	    i2c_param.connection_speed <= QUICKI2C_SUBIP_STANDARD_MODE_MAX_SPEED) {
-		qcdev->i2c_speed_mode = THC_I2C_STANDARD;
-		qcdev->i2c_clock_hcnt = i2c_config.SMHX;
-		qcdev->i2c_clock_lcnt = i2c_config.SMLX;
+		qcdev->i2c_config.speed = THC_I2C_STANDARD;
+		qcdev->i2c_config.scl_hcnt = (u32)i2c_config.SMHX;
+		qcdev->i2c_config.scl_lcnt = (u32)i2c_config.SMLX;
+		qcdev->i2c_config.sda_tx_hold = (u32)i2c_config.SMTD;
+		qcdev->i2c_config.sda_rx_hold = (u32)i2c_config.SMRD;
 	} else if (i2c_param.connection_speed > QUICKI2C_SUBIP_STANDARD_MODE_MAX_SPEED &&
 		   i2c_param.connection_speed <= QUICKI2C_SUBIP_FAST_MODE_MAX_SPEED) {
-		qcdev->i2c_speed_mode = THC_I2C_FAST_AND_PLUS;
-		qcdev->i2c_clock_hcnt = i2c_config.FMHX;
-		qcdev->i2c_clock_lcnt = i2c_config.FMLX;
+		qcdev->i2c_config.speed = THC_I2C_FAST_AND_PLUS;
+		qcdev->i2c_config.scl_hcnt = (u32)i2c_config.FMHX;
+		qcdev->i2c_config.scl_lcnt = (u32)i2c_config.FMLX;
+		qcdev->i2c_config.sda_tx_hold = (u32)i2c_config.FMTD;
+		qcdev->i2c_config.sda_rx_hold = (u32)i2c_config.FMRD;
 	} else if (i2c_param.connection_speed > QUICKI2C_SUBIP_FAST_MODE_MAX_SPEED &&
 		   i2c_param.connection_speed <= QUICKI2C_SUBIP_FASTPLUS_MODE_MAX_SPEED) {
-		qcdev->i2c_speed_mode = THC_I2C_FAST_AND_PLUS;
-		qcdev->i2c_clock_hcnt = i2c_config.FPHX;
-		qcdev->i2c_clock_lcnt = i2c_config.FPLX;
+		qcdev->i2c_config.speed = THC_I2C_FAST_AND_PLUS;
+		qcdev->i2c_config.scl_hcnt = (u32)i2c_config.FPHX;
+		qcdev->i2c_config.scl_lcnt = (u32)i2c_config.FPLX;
+		qcdev->i2c_config.sda_tx_hold = (u32)i2c_config.FPTD;
+		qcdev->i2c_config.sda_rx_hold = (u32)i2c_config.FPRD;
 	} else if (i2c_param.connection_speed > QUICKI2C_SUBIP_FASTPLUS_MODE_MAX_SPEED &&
 		   i2c_param.connection_speed <= QUICKI2C_SUBIP_HIGH_SPEED_MODE_MAX_SPEED) {
-		qcdev->i2c_speed_mode = THC_I2C_HIGH_SPEED;
-		qcdev->i2c_clock_hcnt = i2c_config.HMHX;
-		qcdev->i2c_clock_lcnt = i2c_config.HMLX;
+		qcdev->i2c_config.speed = THC_I2C_HIGH_SPEED;
+		qcdev->i2c_config.scl_hcnt = (u32)i2c_config.HMHX;
+		qcdev->i2c_config.scl_lcnt = (u32)i2c_config.HMLX;
+		qcdev->i2c_config.sda_tx_hold = (u32)i2c_config.HMTD;
+		qcdev->i2c_config.sda_rx_hold = (u32)i2c_config.HMRD;
 	} else {
 		return -EOPNOTSUPP;
 	}
@@ -415,10 +425,7 @@ static struct quicki2c_device *quicki2c_dev_init(struct pci_dev *pdev, void __io
 		return ERR_PTR(ret);
 	}
 
-	ret = thc_i2c_subip_init(qcdev->thc_hw, qcdev->i2c_slave_addr,
-				 qcdev->i2c_speed_mode,
-				 qcdev->i2c_clock_hcnt,
-				 qcdev->i2c_clock_lcnt);
+	ret = thc_i2c_subip_init(qcdev->thc_hw, &qcdev->i2c_config);
 	if (ret)
 		return ERR_PTR(ret);
 
@@ -978,10 +985,7 @@ static int quicki2c_restore(struct device *device)
 	if (ret)
 		return ret;
 
-	ret = thc_i2c_subip_init(qcdev->thc_hw, qcdev->i2c_slave_addr,
-				 qcdev->i2c_speed_mode,
-				 qcdev->i2c_clock_hcnt,
-				 qcdev->i2c_clock_lcnt);
+	ret = thc_i2c_subip_init(qcdev->thc_hw, &qcdev->i2c_config);
 	if (ret)
 		return ret;
 
diff --git a/drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-dev.h b/drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-dev.h
index d72565de67b9..6d25a846153e 100644
--- a/drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-dev.h
+++ b/drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-dev.h
@@ -7,6 +7,8 @@
 #include <linux/hid-over-i2c.h>
 #include <linux/workqueue.h>
 
+#include "intel-thc-dev.h"
+
 #define PCI_DEVICE_ID_INTEL_THC_LNL_DEVICE_ID_I2C_PORT1		0xA848
 #define PCI_DEVICE_ID_INTEL_THC_LNL_DEVICE_ID_I2C_PORT2		0xA84A
 #define PCI_DEVICE_ID_INTEL_THC_PTL_H_DEVICE_ID_I2C_PORT1	0xE348
@@ -159,7 +161,6 @@ struct quicki2c_ddata {
 
 struct device;
 struct pci_dev;
-struct thc_device;
 struct hid_device;
 struct acpi_device;
 
@@ -174,13 +175,10 @@ struct acpi_device;
  * @state: THC I2C device state
  * @mem_addr: MMIO memory address
  * @dev_desc: Device descriptor for HIDI2C protocol
- * @i2c_slave_addr: HIDI2C device slave address
+ * @i2c_config: I2C bus configuration
  * @hid_desc_addr: Register address for retrieve HID device descriptor
  * @active_ltr_val: THC active LTR value
  * @low_power_ltr_val: THC low power LTR value
- * @i2c_speed_mode: 0 - standard mode, 1 - fast mode, 2 - fast mode plus
- * @i2c_clock_hcnt: I2C CLK high period time (unit in cycle count)
- * @i2c_clock_lcnt: I2C CLK low period time (unit in cycle count)
  * @report_descriptor: Store a copy of device report descriptor
  * @input_buf: Store a copy of latest input report data
  * @report_buf: Store a copy of latest input/output report packet from set/get feature
@@ -206,16 +204,12 @@ struct quicki2c_device {
 	void __iomem *mem_addr;
 
 	struct hidi2c_dev_descriptor dev_desc;
-	u8 i2c_slave_addr;
+	struct thc_i2c_config i2c_config;
 	u16 hid_desc_addr;
 
 	u32 active_ltr_val;
 	u32 low_power_ltr_val;
 
-	u32 i2c_speed_mode;
-	u32 i2c_clock_hcnt;
-	u32 i2c_clock_lcnt;
-
 	u8 *report_descriptor;
 	u8 *input_buf;
 	u8 *report_buf;
-- 
2.43.0

