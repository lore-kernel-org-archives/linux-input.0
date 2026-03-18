Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEDA24A07C;
	Wed, 18 Mar 2026 03:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773804011; cv=none; b=jQQKK4Xouxp4aMbS+LGOQ7dpQQYBdY3U12pOFhzfbSpdKfK63Mp0L2Fjbty8JIbTdet8fNR864m6umrtol5lXqdmrX9w/KD3s+riOb2vO5pnDNQfuFQSnDpGuLqYmzEH2TwLNTFOV4o/FRRBSqlNZGAO20BLjBm7ItU1xrbfQao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773804011; c=relaxed/simple;
	bh=VmLPwBqssgUTXS8YPPqjSjEVD+zdZLydkpn1jHU8WLE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TCb+TDPCvEk4fIM7IzNlNFuC/z4ueIORQNfplqYOgWaLD2/3MCj3MXx4y08xBEP5x6MWyLoamJwnVSgWLUa4tevzdSErEXbcKoe+kfdfZdzhWF2NX06Ny0FN9oFKjT1CELGV2rDxwlcs2wY9SIPWnMoezTGk9Y244A0ndsA2vB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gICI4Asn; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gICI4Asn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773804003; x=1805340003;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VmLPwBqssgUTXS8YPPqjSjEVD+zdZLydkpn1jHU8WLE=;
  b=gICI4AsnCaKhbsaXp1zf8n3QNKSwsBT21D3DSvklaYwdDYJhZmzd0Ynn
   WzTxRblDNmeg1WQbKBzE45d1tWvbZ8K75wdhiNmPEO0KU+VuWzws94rpv
   E390s2z3+EUSbtWMeTrnguJ7+SPefiuk3p1I1MvZvia8q5bGt6ATRPbQP
   lr0eweReEPrxkJShE3xD7JJA/yQTZcinxnTcSn4m7FROqQArrMNlsHGYZ
   9SGsmm1UW0/TyGONMka85uTNdy7az2u/Jxx3TmDDjAyPr9NZavN/ftSc0
   tHjUhhb4ZHk1kGPocrt9O1zxYIS+ALhCdfdtOeWGmUseOKSTZyilrJYKD
   Q==;
X-CSE-ConnectionGUID: YnXZpsQXTYGvHBmKc/8n/A==
X-CSE-MsgGUID: q4kPUMkwRSWi+tgh2shpHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="74030717"
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="74030717"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 20:20:02 -0700
X-CSE-ConnectionGUID: jGuN20YjRUuCOmDsnem/3A==
X-CSE-MsgGUID: pDptuVDVSOyeGAFRyZSAbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="226611243"
Received: from shsensorbuild.sh.intel.com ([10.239.132.250])
  by orviesa003.jf.intel.com with ESMTP; 17 Mar 2026 20:20:01 -0700
From: Even Xu <even.xu@intel.com>
To: bentiss@kernel.org,
	jikos@kernel.org
Cc: srinivas.pandruvada@linux.intel.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Even Xu <even.xu@intel.com>,
	Rui Zhang <rui1.zhang@intel.com>
Subject: [PATCH] Hid: Intel-thc-hid: Intel-thc: Add more frequency support for SPI
Date: Wed, 18 Mar 2026 11:22:04 +0800
Message-Id: <20260318032204.835621-1-even.xu@intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Nova Lake platform enhances THC with half divider capability for
clock division, allowing more granular frequency control for the THC
SPI port.

Supported frequencies include 50MHz (125MHz/2.5), 35MHz (125MHz/3.5),
and 10MHz (125MHz/8/1.5).

Signed-off-by: Even Xu <even.xu@intel.com>
Tested-by: Rui Zhang <rui1.zhang@intel.com>
---
 .../intel-thc-hid/intel-thc/intel-thc-dev.c   | 47 +++++++++++++++++++
 .../intel-thc-hid/intel-thc/intel-thc-hw.h    |  4 ++
 2 files changed, 51 insertions(+)

diff --git a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dev.c b/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dev.c
index d8e195189e4b..9a8449428170 100644
--- a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dev.c
+++ b/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dev.c
@@ -1112,12 +1112,15 @@ int thc_port_select(struct thc_device *dev, enum thc_port_type port_type)
 EXPORT_SYMBOL_NS_GPL(thc_port_select, "INTEL_THC");
 
 #define THC_SPI_FREQUENCY_7M	7812500
+#define THC_SPI_FREQUENCY_10M	10416700
 #define THC_SPI_FREQUENCY_15M	15625000
 #define THC_SPI_FREQUENCY_17M	17857100
 #define THC_SPI_FREQUENCY_20M	20833000
 #define THC_SPI_FREQUENCY_25M	25000000
 #define THC_SPI_FREQUENCY_31M	31250000
+#define THC_SPI_FREQUENCY_35M	35714200
 #define THC_SPI_FREQUENCY_41M	41666700
+#define THC_SPI_FREQUENCY_50M	50000000
 
 #define THC_SPI_LOW_FREQUENCY	THC_SPI_FREQUENCY_17M
 
@@ -1125,21 +1128,27 @@ static u8 thc_get_spi_freq_div_val(struct thc_device *dev, u32 spi_freq_val)
 {
 	static const int frequency[] = {
 		THC_SPI_FREQUENCY_7M,
+		THC_SPI_FREQUENCY_10M,
 		THC_SPI_FREQUENCY_15M,
 		THC_SPI_FREQUENCY_17M,
 		THC_SPI_FREQUENCY_20M,
 		THC_SPI_FREQUENCY_25M,
 		THC_SPI_FREQUENCY_31M,
+		THC_SPI_FREQUENCY_35M,
 		THC_SPI_FREQUENCY_41M,
+		THC_SPI_FREQUENCY_50M,
 	};
 	static const u8 frequency_div[] = {
 		THC_SPI_FRQ_DIV_2,
 		THC_SPI_FRQ_DIV_1,
+		THC_SPI_FRQ_DIV_1,
 		THC_SPI_FRQ_DIV_7,
 		THC_SPI_FRQ_DIV_6,
 		THC_SPI_FRQ_DIV_5,
 		THC_SPI_FRQ_DIV_4,
 		THC_SPI_FRQ_DIV_3,
+		THC_SPI_FRQ_DIV_3,
+		THC_SPI_FRQ_DIV_2,
 	};
 	int size = ARRAY_SIZE(frequency);
 	u32 closest_freq;
@@ -1190,6 +1199,25 @@ int thc_spi_read_config(struct thc_device *dev, u32 spi_freq_val,
 	if (spi_freq_val < THC_SPI_LOW_FREQUENCY)
 		is_low_freq = true;
 
+	/* 10M, 35M and 50M CLK need 1.5, 3.5 and 2.5 half divider */
+	if ((freq_div == THC_SPI_FRQ_DIV_2 && spi_freq_val >=  THC_SPI_FREQUENCY_50M) ||
+		(freq_div == THC_SPI_FRQ_DIV_3 && spi_freq_val <  THC_SPI_FREQUENCY_41M) ||
+		(freq_div == THC_SPI_FRQ_DIV_1 && spi_freq_val <  THC_SPI_FREQUENCY_15M)) {
+		regmap_write_bits(dev->thc_regmap, THC_M_PRT_SPI_DUTYC_CFG_OFFSET,
+				  THC_M_PRT_SPI_DUTYC_CFG_SPI_TCRF_HALF_DIV_EN,
+				  THC_M_PRT_SPI_DUTYC_CFG_SPI_TCRF_HALF_DIV_EN);
+
+		regmap_write_bits(dev->thc_regmap, THC_M_PRT_SPARE_REG_OFFSET,
+				  THC_M_PRT_SPARE_REG_SPI_CLK_INV_ENABLE,
+				  THC_M_PRT_SPARE_REG_SPI_CLK_INV_ENABLE);
+	} else {
+		regmap_write_bits(dev->thc_regmap, THC_M_PRT_SPI_DUTYC_CFG_OFFSET,
+				  THC_M_PRT_SPI_DUTYC_CFG_SPI_TCRF_HALF_DIV_EN, 0);
+
+		regmap_write_bits(dev->thc_regmap, THC_M_PRT_SPARE_REG_OFFSET,
+				  THC_M_PRT_SPARE_REG_SPI_CLK_INV_ENABLE, 0);
+	}
+
 	cfg = FIELD_PREP(THC_M_PRT_SPI_CFG_SPI_TCRF, freq_div) |
 	      FIELD_PREP(THC_M_PRT_SPI_CFG_SPI_TRMODE, io_mode) |
 	      (is_low_freq ? THC_M_PRT_SPI_CFG_SPI_LOW_FREQ_EN : 0) |
@@ -1243,6 +1271,25 @@ int thc_spi_write_config(struct thc_device *dev, u32 spi_freq_val,
 	if (spi_freq_val < THC_SPI_LOW_FREQUENCY)
 		is_low_freq = true;
 
+	/* 10M, 35M and 50M CLK need 1.5, 3.5 and 2.5 half divider */
+	if ((freq_div == THC_SPI_FRQ_DIV_2 && spi_freq_val >=  THC_SPI_FREQUENCY_50M) ||
+		(freq_div == THC_SPI_FRQ_DIV_3 && spi_freq_val <  THC_SPI_FREQUENCY_41M) ||
+		(freq_div == THC_SPI_FRQ_DIV_1 && spi_freq_val <  THC_SPI_FREQUENCY_15M)) {
+		regmap_write_bits(dev->thc_regmap, THC_M_PRT_SPI_DUTYC_CFG_OFFSET,
+				  THC_M_PRT_SPI_DUTYC_CFG_SPI_TCWF_HALF_DIV_EN,
+				  THC_M_PRT_SPI_DUTYC_CFG_SPI_TCWF_HALF_DIV_EN);
+
+		regmap_write_bits(dev->thc_regmap, THC_M_PRT_SPARE_REG_OFFSET,
+				  THC_M_PRT_SPARE_REG_SPI_CLK_INV_ENABLE,
+				  THC_M_PRT_SPARE_REG_SPI_CLK_INV_ENABLE);
+	} else {
+		regmap_write_bits(dev->thc_regmap, THC_M_PRT_SPI_DUTYC_CFG_OFFSET,
+				  THC_M_PRT_SPI_DUTYC_CFG_SPI_TCWF_HALF_DIV_EN, 0);
+
+		regmap_write_bits(dev->thc_regmap, THC_M_PRT_SPARE_REG_OFFSET,
+				  THC_M_PRT_SPARE_REG_SPI_CLK_INV_ENABLE, 0);
+	}
+
 	cfg = FIELD_PREP(THC_M_PRT_SPI_CFG_SPI_TCWF, freq_div) |
 	      FIELD_PREP(THC_M_PRT_SPI_CFG_SPI_TWMODE, io_mode) |
 	      (is_low_freq ? THC_M_PRT_SPI_CFG_SPI_LOW_FREQ_EN : 0) |
diff --git a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-hw.h b/drivers/hid/intel-thc-hid/intel-thc/intel-thc-hw.h
index 413730f8e3f7..c6d026686b7a 100644
--- a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-hw.h
+++ b/drivers/hid/intel-thc-hid/intel-thc/intel-thc-hw.h
@@ -643,6 +643,10 @@
 
 #define THC_M_PRT_SPI_DUTYC_CFG_SPI_CSA_CK_DELAY_VAL		GENMASK(3, 0)
 #define THC_M_PRT_SPI_DUTYC_CFG_SPI_CSA_CK_DELAY_EN		BIT(25)
+#define THC_M_PRT_SPI_DUTYC_CFG_SPI_TCRF_HALF_DIV_EN		BIT(30)
+#define THC_M_PRT_SPI_DUTYC_CFG_SPI_TCWF_HALF_DIV_EN		BIT(31)
+
+#define THC_M_PRT_SPARE_REG_SPI_CLK_INV_ENABLE			BIT(2)
 
 /* CS Assertion delay default value */
 #define THC_CSA_CK_DELAY_VAL_DEFAULT		4
-- 
2.40.1

