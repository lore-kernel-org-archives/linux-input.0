Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E6F135A53;
	Wed,  1 Jul 2026 02:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782871451; cv=none; b=b1sB3ye3WIULzSOnju0UmAh0en/7F0TZ59LUrgvOsCRt5V2z1rJ5gqyy337Oz0js7rMa5e2qCFe6oOxhYCl/JdUTm7k7VrPVx/N+PkK8B5prHIKeAG/4cjQ+uDOLGH69fIn/RPivzmVyRd+d28/OT5DKhT/bxOdcfA6lT+e+b/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782871451; c=relaxed/simple;
	bh=pCr/ogT3NMm4i1Rb31y1psS0sAA7i7ybnrnFaiAGaxo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ej/ZCSl3ais8MfyokT5nET6Sh5v4nJdG/MiTKY6X0G5scMS8ChRBDR2iVM0hMvYLG6mkrVdtQWAgNeFK1Xe8G77KSLOHCNQIQX977BzWBvPwQtmyUAaWAcpbr/x64T7TnAPUSdFc8EKRI62zY/x0JG/O1v1YaNubTWaj52OTt8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b+ebNL0P; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b+ebNL0P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782871449; x=1814407449;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pCr/ogT3NMm4i1Rb31y1psS0sAA7i7ybnrnFaiAGaxo=;
  b=b+ebNL0PkNNToPb4mOZggpnyh4i/SvjRxvlHMoTPzaTj3bbI7GkChpmp
   e9u+FheWHKStIS9DSf5abp4dcYI7TyUVwUM1ZDdOQD4UYJ8DrJxbPUIgk
   kWy2NEB1eMzjicyZVtTT/knyqk/Hf39KttTDcPZfXKeSqxpNoTsj/vw9s
   aZLSqu9OyY2X9GyVcV1pkbx5VJohZR8Rfs6Xkm5elDMG4TKPz//K6RrLK
   mGmEOVZA9oLlXkBrgxBolC7KayZyqwZC28N6l38q9fLN21bB+HrAmlCMH
   QckARKwmCs2bcrjJkn8HsSeElqnQ5cdR7rg4Xr5QNX9c7+moeqeA5otN4
   w==;
X-CSE-ConnectionGUID: Z3sriX9lTPKOXzPwEZPgDA==
X-CSE-MsgGUID: 3EXZf67URP6KA457lzjlQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="106386311"
X-IronPort-AV: E=Sophos;i="6.24,235,1774335600"; 
   d="scan'208";a="106386311"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 19:04:08 -0700
X-CSE-ConnectionGUID: 8Kca/6ROS+edgUfNElpjdA==
X-CSE-MsgGUID: P3vcWGB4Rg6KP9eKl8pIeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,235,1774335600"; 
   d="scan'208";a="251997812"
Received: from shsensorbuild.sh.intel.com ([10.239.132.250])
  by orviesa008.jf.intel.com with ESMTP; 30 Jun 2026 19:04:06 -0700
From: Even Xu <even.xu@intel.com>
To: bentiss@kernel.org,
	jikos@kernel.org
Cc: srinivas.pandruvada@linux.intel.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Even Xu <even.xu@intel.com>
Subject: [PATCH 0/3] HID: Intel-thc-hid: Refine error recovery flow
Date: Wed,  1 Jul 2026 10:04:29 +0800
Message-ID: <20260701020432.3774514-1-even.xu@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series refines the fatal error recovery flow for the Intel THC
(Touch Host Controller) subsystem, covering both the QuickI2C and
QuickSPI drivers.

Currently, when a fatal DMA error is detected in the IRQ thread handler,
the recovery is performed inline: the interrupt handler calls
try_recover() directly, which unconfigures and reconfigures the DMA
engine.

This approach has several problems:
1. Recovery runs in the IRQ thread context, which is not ideal for
   potentially slow reset operations.
2. The interrupt is re-enabled before recovery completes, risking an
   interrupt storm if DMA errors persist.
3. The DMA reset logic is open-coded in each protocol driver, leading
   to duplication and divergence over time.

This patch series addresses all of the above:

By adding a new thc_rxdma_reset() API to the THC core layer, QuickI2C
and QuickSPI drivers can call it respectively to refine the recovery
callback.

The synchronous try_recover() call in the IRQ thread is replaced with
schedule_work(), deferring recovery to a workqueue.  Within the work
function:
- The interrupt line is disabled before any DMA manipulation.
- thc_rxdma_reset() is used instead of the open-coded sequence.
- On failure the device is marked DISABLED and the interrupt remains
  off, preventing an interrupt storm.

Even Xu (3):
  HID: Intel-thc-hid: Intel-thc: Add API to reset read DMA
  HID: Intel-thc-hid: Intel-quicki2c: Refine recover callback
  HID: Intel-thc-hid: Intel-quickspi: Refine recover callback

 .../intel-quicki2c/pci-quicki2c.c             | 31 +++++++---------
 .../intel-quicki2c/quicki2c-dev.h             |  2 +
 .../intel-quickspi/pci-quickspi.c             | 37 +++++++------------
 .../intel-quickspi/quickspi-dev.h             |  2 +
 .../intel-thc-hid/intel-thc/intel-thc-dma.c   | 37 +++++++++++++++++++
 .../intel-thc-hid/intel-thc/intel-thc-dma.h   |  1 +
 6 files changed, 68 insertions(+), 42 deletions(-)

-- 
2.43.0

