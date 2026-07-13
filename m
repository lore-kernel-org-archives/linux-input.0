Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2E4217F33;
	Mon, 13 Jul 2026 03:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783911818; cv=none; b=G//gLL+mpZaj1LsYfcSl6TioI/USH8D07lF14kxtUip1CgWT4LxHLmpNHomkXP+G9+iyT8Mkx2Q845b29VqZE6HcK5nChiwp8V2donPQ7x9LUPEHnkTF2CzD1tdo1yAyHIOOY+ueKRtX47K3TtmprOhIcPAl4nX2ZvzuhRr0xnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783911818; c=relaxed/simple;
	bh=DJuJEZMdbEd5ZaB717woqcvMHmE95jwJ8MbaLRevHQE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nIi+b7vNkNPzbkbo/aeH6H1nwyewQeYFlKNxlDkQ/pA0RkL7hPhqcV+Fk03ASToDhxhwtQKdFYlh2cYOEPUDFME3am4UwKNx0Q0bP0x8+0H80AeX/ks1eWad9CH0xQyIq7GKdRdMi+MjG+UlnOTnJtljgIIqfYlFjbgf4WpdmIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eDgePyqs; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eDgePyqs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783911817; x=1815447817;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DJuJEZMdbEd5ZaB717woqcvMHmE95jwJ8MbaLRevHQE=;
  b=eDgePyqsFHboAHcbUx68PD0DQtJLy3ppuNhGWRxhY3/6DD9guoaEuodW
   1QQRaRSliA4KCNLXfGTWWu8c7vGOJsrfNMarf9RSOpK0A7R63OEQxo8Cn
   1foL1OVNRu1DsB7WsnHwIjLWC2N4pSFuhOeqcDCWEBrGTHP+MRFp/ibl7
   DhGBv05k1En6TDXK3u9wdCLn5pLdVu985RwIBeIOZb6bXajPQCmdMeXHv
   cEY91RoBpXS3OV2xBTQXt0tpAf1GbfeSbGH/l9KMl6pTtDIapRJKnEEJc
   Kh9Mf+AAp/l9ofWYlPXfJyDpmCR9Z1A8oPZTiIU4ZNh2XG7vDhw0sC5iX
   A==;
X-CSE-ConnectionGUID: gF1+jOs/RKOpdLrSgIFwAw==
X-CSE-MsgGUID: 5WsLdtXZTM+K+NlXLYRMQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="87060298"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="87060298"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2026 20:03:36 -0700
X-CSE-ConnectionGUID: E44rxykrTbu/Z6gzjT3Rjg==
X-CSE-MsgGUID: 2LOKlTVQQw+Ws+B2rpxcyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="255499233"
Received: from shsensorbuild.sh.intel.com ([10.239.132.250])
  by orviesa007.jf.intel.com with ESMTP; 12 Jul 2026 20:03:35 -0700
From: Even Xu <even.xu@intel.com>
To: bentiss@kernel.org,
	jikos@kernel.org
Cc: srinivas.pandruvada@linux.intel.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Even Xu <even.xu@intel.com>
Subject: [PATCH v3 0/3] HID: Intel-thc-hid: Refine error recovery flow
Date: Mon, 13 Jul 2026 11:04:09 +0800
Message-ID: <20260713030412.2531933-1-even.xu@intel.com>
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

Change log:
v3:
 - Quiesce external interrupt and disable THC internal interrupt in
   remove() and shutdown() callback before cancel_work_sync().

v2:
 - Use dev_err() instead of dev_err_once() so repeated failures during
   recurring recovery are not silently suppressed.
 - Pause both RxDMA channels via thc_wait_for_dma_pause() before calling
   thc_dma_unconfigure() to ensure the DMA engines are inactive before
   clearing PRD base addresses, preventing potential IOMMU faults or
   memory corruption.
 - Hold a runtime PM reference inside try_recover() to prevent the
   device from suspending while the work accesses hardware registers.
 - Add cancel_work_sync() in quicki2c_remove() and quicki2c_shutdown()
   to prevent use-after-free if recovery work is still queued at teardown.
 - Only re-enable the interrupt in the IRQ thread handler when no recovery
   is needed; the work function handles re-enabling after successful reset,
   avoiding an interrupt storm from the uncleared hardware error state.



Even Xu (3):
  HID: Intel-thc-hid: Intel-thc: Add API to reset read DMA
  HID: Intel-thc-hid: Intel-quicki2c: Refine recover callback
  HID: Intel-thc-hid: Intel-quickspi: Refine recover callback

 .../intel-quicki2c/pci-quicki2c.c             | 49 ++++++++++-------
 .../intel-quicki2c/quicki2c-dev.h             |  2 +
 .../intel-quickspi/pci-quickspi.c             | 53 ++++++++++---------
 .../intel-quickspi/quickspi-dev.h             |  3 ++
 .../intel-thc-hid/intel-thc/intel-thc-dma.c   | 51 ++++++++++++++++++
 .../intel-thc-hid/intel-thc/intel-thc-dma.h   |  1 +
 6 files changed, 116 insertions(+), 43 deletions(-)

-- 
2.43.0

