Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CBE37FF78;
	Tue, 17 Mar 2026 05:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773726875; cv=none; b=nojVTGlW4XPzQpJsOtcAV1hvLwY2N7ZG6yPTgQ2RIQ7JyUV0V/Pv23OUJocyA/Skk8Ov/PBsgq+xcnKZaOUFWwWp+Mym3lQ9qtmXf8uyZop+d3BhqulyqKFRFmKoWCauEjgykz1vWiVm9VCY7CUgA4oBDVVpQWlc3ZffNesr+d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773726875; c=relaxed/simple;
	bh=hKcAmN5NqVZm104up7pIMMCr9f9cea6aT/Psuz+zAZI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bO/7n4OLtzkB3nML9NXUDBLNZ3ssUYMGWWE4DAPJU9U0oGVB5BL9jPlwsFizsUOU1KIDMiJGwIsjepeiKE/w5tnLxHoC0J2vPT0MWJL0tNRRVqIm4qWVlDzepZUP8ZLZIR3aJeKfHfGg0+/I6ondHku8fG1SPWKHf7ROQJzVvkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jWYDCpGV; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jWYDCpGV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773726874; x=1805262874;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hKcAmN5NqVZm104up7pIMMCr9f9cea6aT/Psuz+zAZI=;
  b=jWYDCpGVFkIcTSPhAjSwTc/v3RdVcWG/IodK5ZHJPLPT3Y/K36bOOXIT
   W+aAFM790l+9UAtxkc5RLL125pClepc0h9jwUehJv8pcXgDi6NqCVxE/F
   H22CC8yIjhSxD9VoO1nbSBF9GFDa30PXwIIMN2TBnS8XziTFYrN46AnYf
   zbWIpC8pEDEHZ3QG9OQXazpWS0LkOe1UGDpD7pVrnmio/XL8rXP1LsMdR
   bFk4LX4iqVFciZ4Lr7EEapk+zWARzlZjovZLSsEuZW0cffj3iImEApUvX
   Gs1HPx9ESBdS3/P3nqOg1/EbF/AuDl5bICXozQ1AYW7S5MVaZsDcDfnUq
   g==;
X-CSE-ConnectionGUID: xLVgqVp4S9igHIsIjRe+lg==
X-CSE-MsgGUID: RqM8NjC1QHydoGLo5ZzuAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="85447339"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="85447339"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 22:54:34 -0700
X-CSE-ConnectionGUID: 7HsUu5h0Q2GLH4qu5b7/JQ==
X-CSE-MsgGUID: 8C9ifHQNSYuBCOXTlECWNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="221391281"
Received: from shsensorbuild.sh.intel.com ([10.239.132.250])
  by orviesa010.jf.intel.com with ESMTP; 16 Mar 2026 22:54:32 -0700
From: Even Xu <even.xu@intel.com>
To: bentiss@kernel.org,
	jikos@kernel.org
Cc: srinivas.pandruvada@linux.intel.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Even Xu <even.xu@intel.com>
Subject: [PATCH 2/2] Hid: Intel-thc-hid: Intel-quickspi: Add NVL Device IDs
Date: Tue, 17 Mar 2026 13:56:29 +0800
Message-Id: <20260317055629.3877299-3-even.xu@intel.com>
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

Add Nova Lake THC QuickSPI device IDs to support list.

Signed-off-by: Even Xu <even.xu@intel.com>
---
 drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c | 6 ++++++
 drivers/hid/intel-thc-hid/intel-quickspi/quickspi-dev.h | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
index ad6bd59963b2..b6a69995692c 100644
--- a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
+++ b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
@@ -37,6 +37,10 @@ struct quickspi_driver_data arl = {
 	.max_packet_size_value = MAX_PACKET_SIZE_VALUE_MTL,
 };
 
+struct quickspi_driver_data nvl = {
+	.max_packet_size_value = MAX_PACKET_SIZE_VALUE_LNL,
+};
+
 /* THC QuickSPI ACPI method to get device properties */
 /* HIDSPI Method: {6e2ac436-0fcf-41af-a265-b32a220dcfab} */
 static guid_t hidspi_guid =
@@ -982,6 +986,8 @@ static const struct pci_device_id quickspi_pci_tbl[] = {
 	{PCI_DEVICE_DATA(INTEL, THC_WCL_DEVICE_ID_SPI_PORT2, &ptl), },
 	{PCI_DEVICE_DATA(INTEL, THC_ARL_DEVICE_ID_SPI_PORT1, &arl), },
 	{PCI_DEVICE_DATA(INTEL, THC_ARL_DEVICE_ID_SPI_PORT2, &arl), },
+	{PCI_DEVICE_DATA(INTEL, THC_NVL_H_DEVICE_ID_SPI_PORT1, &nvl), },
+	{PCI_DEVICE_DATA(INTEL, THC_NVL_H_DEVICE_ID_SPI_PORT2, &nvl), },
 	{}
 };
 MODULE_DEVICE_TABLE(pci, quickspi_pci_tbl);
diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-dev.h b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-dev.h
index c30e1a42eb09..bf5e18f5a5f4 100644
--- a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-dev.h
+++ b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-dev.h
@@ -23,6 +23,8 @@
 #define PCI_DEVICE_ID_INTEL_THC_WCL_DEVICE_ID_SPI_PORT2 	0x4D4B
 #define PCI_DEVICE_ID_INTEL_THC_ARL_DEVICE_ID_SPI_PORT1 	0x7749
 #define PCI_DEVICE_ID_INTEL_THC_ARL_DEVICE_ID_SPI_PORT2 	0x774B
+#define PCI_DEVICE_ID_INTEL_THC_NVL_H_DEVICE_ID_SPI_PORT1	0xD349
+#define PCI_DEVICE_ID_INTEL_THC_NVL_H_DEVICE_ID_SPI_PORT2	0xD34B
 
 /* HIDSPI special ACPI parameters DSM methods */
 #define ACPI_QUICKSPI_REVISION_NUM			2
-- 
2.40.1

