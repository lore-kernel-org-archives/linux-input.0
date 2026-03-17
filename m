Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7AEE37FF5E;
	Tue, 17 Mar 2026 05:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773726874; cv=none; b=NHuwjBuCmA/8U9tunC5RbY+qi8Gz7dAeqZXpIu24oPC7A2hoA6+cbgIQuKFSnYyF3R8QGT9Unp42hrJRXJnyZw3ly2hRq5wviq8sMhIU9ylxNap1eOEzNydpY42LpK+656D9PeERzZS2QfptX29GPO6D0SiXenDggVP6cdYgOTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773726874; c=relaxed/simple;
	bh=JvASpdbVbLawsoFO6OCgZwFbSSLHa/sMWtS839/ghaw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oSJa3JjWfQKTlxqi8zoKkrAZlgOTGeIjUI4DSICn7i3Xfm3NmJ3njLx+YFSJ1B13ZxwgcDatr6a8OVD+OonvFDfn47m5dEZsJ2KGdxYop6l+UIivrMMcqZJgrSRZseaJOCcr7AL+YgAMs7mCddZ/DaXJgc38LQ2mnk5c8re0U44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M5pKVZHl; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M5pKVZHl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773726872; x=1805262872;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JvASpdbVbLawsoFO6OCgZwFbSSLHa/sMWtS839/ghaw=;
  b=M5pKVZHlJvI5mMqL8Jq9sWgvXqZxhfvjmwEcYV/pwEqaTuKc8TDpaF0Z
   TW+qXHR2CrodJyICeAq+YXZOBRltpShMOaimpHMAG3U6s366FDNIAIus1
   895rRTXbDBSrIObAFAPgolHXCOH2yOTkKTCZddeSFCpRrRrc4GfaHp4SW
   rA73edcqZIlWLIovxh/T0ZCVWlqZVTMeBcT9svB/klC2j3MRhZFnHOLaE
   6hk6UIzU8U4LaJGGHzPROy6y2GxzE9EmmoFka9xKjjOqUyQ6dkCOKufmY
   qZ6zOc0CarKDO+WMm3VJYlgUR4wdWVi1Rn89UYRjUv33WSQHw2o//H5R6
   g==;
X-CSE-ConnectionGUID: W9YAgpSbSku7+4ko7qQHiQ==
X-CSE-MsgGUID: q3hvjbSNTY2W3zmHOINReg==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="85447336"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="85447336"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 22:54:32 -0700
X-CSE-ConnectionGUID: CI/R3Mv1ThKLahrrCr1ebg==
X-CSE-MsgGUID: SUlMbpRsRzqGwqRt0e1Hvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="221391269"
Received: from shsensorbuild.sh.intel.com ([10.239.132.250])
  by orviesa010.jf.intel.com with ESMTP; 16 Mar 2026 22:54:30 -0700
From: Even Xu <even.xu@intel.com>
To: bentiss@kernel.org,
	jikos@kernel.org
Cc: srinivas.pandruvada@linux.intel.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Even Xu <even.xu@intel.com>
Subject: [PATCH 1/2] Hid: Intel-thc-hid: Intel-quicki2c: Add NVL Device IDs
Date: Tue, 17 Mar 2026 13:56:28 +0800
Message-Id: <20260317055629.3877299-2-even.xu@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20260317055629.3877299-1-even.xu@intel.com>
References: <20260317055629.3877299-1-even.xu@intel.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Nova Lake THC QuickI2C device IDs to support list.

Signed-off-by: Even Xu <even.xu@intel.com>
---
 drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c | 7 +++++++
 drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-dev.h | 4 ++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c b/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
index f178017352ba..46d3e9a01999 100644
--- a/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
+++ b/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
@@ -26,6 +26,11 @@ static struct quicki2c_ddata ptl_ddata = {
 	.max_interrupt_delay = MAX_RX_INTERRUPT_DELAY,
 };
 
+static struct quicki2c_ddata nvl_ddata = {
+	.max_detect_size = MAX_RX_DETECT_SIZE_NVL,
+	.max_interrupt_delay = MAX_RX_INTERRUPT_DELAY,
+};
+
 /* THC QuickI2C ACPI method to get device properties */
 /* HIDI2C device method */
 static guid_t i2c_hid_guid =
@@ -1032,6 +1037,8 @@ static const struct pci_device_id quicki2c_pci_tbl[] = {
 	{ PCI_DEVICE_DATA(INTEL, THC_PTL_U_DEVICE_ID_I2C_PORT2, &ptl_ddata) },
 	{ PCI_DEVICE_DATA(INTEL, THC_WCL_DEVICE_ID_I2C_PORT1, &ptl_ddata) },
 	{ PCI_DEVICE_DATA(INTEL, THC_WCL_DEVICE_ID_I2C_PORT2, &ptl_ddata) },
+	{ PCI_DEVICE_DATA(INTEL, THC_NVL_H_DEVICE_ID_I2C_PORT1, &nvl_ddata) },
+	{ PCI_DEVICE_DATA(INTEL, THC_NVL_H_DEVICE_ID_I2C_PORT2, &nvl_ddata) },
 	{ }
 };
 MODULE_DEVICE_TABLE(pci, quicki2c_pci_tbl);
diff --git a/drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-dev.h b/drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-dev.h
index 33a1e3db1cb2..61dbdece59a1 100644
--- a/drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-dev.h
+++ b/drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-dev.h
@@ -15,6 +15,8 @@
 #define PCI_DEVICE_ID_INTEL_THC_PTL_U_DEVICE_ID_I2C_PORT2	0xE44A
 #define PCI_DEVICE_ID_INTEL_THC_WCL_DEVICE_ID_I2C_PORT1 	0x4D48
 #define PCI_DEVICE_ID_INTEL_THC_WCL_DEVICE_ID_I2C_PORT2 	0x4D4A
+#define PCI_DEVICE_ID_INTEL_THC_NVL_H_DEVICE_ID_I2C_PORT1	0xD348
+#define PCI_DEVICE_ID_INTEL_THC_NVL_H_DEVICE_ID_I2C_PORT2	0xD34A
 
 /* Packet size value, the unit is 16 bytes */
 #define MAX_PACKET_SIZE_VALUE_LNL			256
@@ -40,6 +42,8 @@
 
 /* PTL Max packet size detection capability is 255 Bytes */
 #define MAX_RX_DETECT_SIZE_PTL			255
+/* NVL Max packet size detection capability is 64K Bytes */
+#define MAX_RX_DETECT_SIZE_NVL			65535
 /* Max interrupt delay capability is 2.56ms */
 #define MAX_RX_INTERRUPT_DELAY			256
 
-- 
2.40.1

