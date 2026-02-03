Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE6220F08C
	for <linux-input@vger.kernel.org>; Tue,  3 Feb 2026 00:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770080113; cv=none; b=YQPhiwIV3WyESuC4TPORYjUn9eZqAM5dW/taLchhjaiQ0N0Yu8zRWTUzYihD9zgv+f2CyciF0bXTcvtKGoTvwM16NkWCfHY5PyjIl/fk356bVgFyOj4Ow7B+sdqCphV+EOfXworj+EnlaWXKlYznvdpUmTmMHv7smFaOEZ9KI0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770080113; c=relaxed/simple;
	bh=Bo0r578Iy/CPHJOrWkyehcoxyvpYcdEd1cV5fMnMTgg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=am5TzvKXOgGEondKXwMnuSLbjn2CHvEbm4/+8ZunU9I5TUt20hoTySN4zdDSzSJwWhjuffmPXsSrcsQMiqQOi9ptAq8HUgyOrVCNRInvV0DARjjG4anDtaXYCPN6rx52dHYvKhRlsJUb380RaOeWnfJNzTHsKW70C9DDfpxngcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MtM9Unjx; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MtM9Unjx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770080111; x=1801616111;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Bo0r578Iy/CPHJOrWkyehcoxyvpYcdEd1cV5fMnMTgg=;
  b=MtM9UnjxIGcUAr/gSo+E7BGuuYeN1msbEK5CFNVQ7hVhbVrtI4jDqeTy
   OgSamjtjkLAneq/MSdK7uxs0CtQbShPKFH2jtEwzG9MaizMndmr5dZfs0
   tNk/QccXC5jNELb8DARC2pS2HOKMP3xcHnQHKwBsa8/t5wnAcKl8fxUEF
   qOgbP4XfwBIoPSiZXsU38j1yumss2lZFT4dGlAI7USP/vdXiL8NtfA1Hy
   OtzsPuM1VEobS7B9VW5VsD1HhdGbAv8JJTfzCFSA89A7XidR5qmuuqu6e
   Xdb3bGe/w7zIUKihzCG4LM+vN52t/sVvvch6t2LxltoyQoNi0IOQLX/rA
   g==;
X-CSE-ConnectionGUID: Wj5mrDQSReOabraqcL3Cew==
X-CSE-MsgGUID: t/8SiXAlS6OWs8Rym1yp2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11690"; a="70451270"
X-IronPort-AV: E=Sophos;i="6.21,269,1763452800"; 
   d="scan'208";a="70451270"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2026 16:55:10 -0800
X-CSE-ConnectionGUID: WFMREI9KTKK7MhazJQrORw==
X-CSE-MsgGUID: f87gC7M6RfWi2XkwMsaejg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,269,1763452800"; 
   d="scan'208";a="247280908"
Received: from lixuzha-desk1.sh.intel.com ([10.239.153.157])
  by orviesa001.jf.intel.com with ESMTP; 02 Feb 2026 16:55:08 -0800
From: Zhang Lixu <lixu.zhang@intel.com>
To: linux-input@vger.kernel.org,
	srinivas.pandruvada@linux.intel.com,
	jikos@kernel.org,
	benjamin.tissoires@redhat.com
Cc: lixu.zhang@intel.com,
	andriy.shevchenko@intel.com,
	selina.wang@intel.com
Subject: [PATCH] HID: intel-ish-hid: ipc: Add Nova Lake-H/S PCI device IDs
Date: Tue,  3 Feb 2026 08:55:07 +0800
Message-ID: <20260203005507.44430-1-lixu.zhang@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add device IDs of Nova Lake-H and Nova Lake-S into ishtp support list.

Signed-off-by: Zhang Lixu <lixu.zhang@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/hid/intel-ish-hid/ipc/hw-ish.h  |  2 ++
 drivers/hid/intel-ish-hid/ipc/pci-ish.c | 12 ++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/hid/intel-ish-hid/ipc/hw-ish.h b/drivers/hid/intel-ish-hid/ipc/hw-ish.h
index fa5d68c363134..27389971b96cc 100644
--- a/drivers/hid/intel-ish-hid/ipc/hw-ish.h
+++ b/drivers/hid/intel-ish-hid/ipc/hw-ish.h
@@ -39,6 +39,8 @@
 #define PCI_DEVICE_ID_INTEL_ISH_PTL_H		0xE345
 #define PCI_DEVICE_ID_INTEL_ISH_PTL_P		0xE445
 #define PCI_DEVICE_ID_INTEL_ISH_WCL		0x4D45
+#define PCI_DEVICE_ID_INTEL_ISH_NVL_H		0xD354
+#define PCI_DEVICE_ID_INTEL_ISH_NVL_S		0x6E78
 
 #define	REVISION_ID_CHT_A0	0x6
 #define	REVISION_ID_CHT_Ax_SI	0x0
diff --git a/drivers/hid/intel-ish-hid/ipc/pci-ish.c b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
index 1612e8cb23f0c..ed3405c05e73c 100644
--- a/drivers/hid/intel-ish-hid/ipc/pci-ish.c
+++ b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
@@ -28,11 +28,15 @@ enum ishtp_driver_data_index {
 	ISHTP_DRIVER_DATA_LNL_M,
 	ISHTP_DRIVER_DATA_PTL,
 	ISHTP_DRIVER_DATA_WCL,
+	ISHTP_DRIVER_DATA_NVL_H,
+	ISHTP_DRIVER_DATA_NVL_S,
 };
 
 #define ISH_FW_GEN_LNL_M "lnlm"
 #define ISH_FW_GEN_PTL "ptl"
 #define ISH_FW_GEN_WCL "wcl"
+#define ISH_FW_GEN_NVL_H "nvlh"
+#define ISH_FW_GEN_NVL_S "nvls"
 
 #define ISH_FIRMWARE_PATH(gen) "intel/ish/ish_" gen ".bin"
 #define ISH_FIRMWARE_PATH_ALL "intel/ish/ish_*.bin"
@@ -47,6 +51,12 @@ static struct ishtp_driver_data ishtp_driver_data[] = {
 	[ISHTP_DRIVER_DATA_WCL] = {
 		.fw_generation = ISH_FW_GEN_WCL,
 	},
+	[ISHTP_DRIVER_DATA_NVL_H] = {
+		.fw_generation = ISH_FW_GEN_NVL_H,
+	},
+	[ISHTP_DRIVER_DATA_NVL_S] = {
+		.fw_generation = ISH_FW_GEN_NVL_S,
+	},
 };
 
 static const struct pci_device_id ish_pci_tbl[] = {
@@ -76,6 +86,8 @@ static const struct pci_device_id ish_pci_tbl[] = {
 	{PCI_DEVICE_DATA(INTEL, ISH_PTL_H, ISHTP_DRIVER_DATA_PTL)},
 	{PCI_DEVICE_DATA(INTEL, ISH_PTL_P, ISHTP_DRIVER_DATA_PTL)},
 	{PCI_DEVICE_DATA(INTEL, ISH_WCL, ISHTP_DRIVER_DATA_WCL)},
+	{PCI_DEVICE_DATA(INTEL, ISH_NVL_H, ISHTP_DRIVER_DATA_NVL_H)},
+	{PCI_DEVICE_DATA(INTEL, ISH_NVL_S, ISHTP_DRIVER_DATA_NVL_S)},
 	{}
 };
 MODULE_DEVICE_TABLE(pci, ish_pci_tbl);

base-commit: 193579fe01389bc21aff0051d13f24e8ea95b47d
-- 
2.43.0

