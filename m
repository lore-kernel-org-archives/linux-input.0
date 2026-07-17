Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3EB36212F;
	Fri, 17 Jul 2026 03:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784259434; cv=none; b=rtOmhCwmWplb8jKjXkY+MhKV6O5etjyDNs2+78jofo/91tv5f++6re6qMTDY5BOf4BfU8gzN7g22vmcN+EwJpChyr/X7pou+QQaU1ibgQ6Z9+W27H3qho8e0ER5epccu1SmS5RdrYJVyJwiVm8Hwl/EnNj3vQEmOZwH652uNqv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784259434; c=relaxed/simple;
	bh=kgCpNGy/aoK03ZQpPWxvrHN9QXPDIrua5ms3gs5dA3A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EvNXyIw9oH7hRlcd9D2ph6KLM6RxWKnuVe2KhWie/rnlBMTMmiH9BtPsLBro1lOQTY96+nnUTSYhuKcYsTmYJrJvLhAQHzuZPwnJjQNyPUwYk8QyynHYpn5u8/StNqBJDgt5M40b0EgR0ErPQaoU5GoyPjyfLr4xJqidEVfR/FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kpl4IRR8; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kpl4IRR8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784259432; x=1815795432;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kgCpNGy/aoK03ZQpPWxvrHN9QXPDIrua5ms3gs5dA3A=;
  b=kpl4IRR8dRh9dwQy1rucnK13tR+W6FRPguCpWfaxTdH2S/HpcGiCchDP
   8bEuC58PPDWw5jVeKaY7mAIsd7/bh/BSJrO0dxQELzwBIXzKpY9CJkT5U
   nFY215n/R8M1Vnu5tuIQFo9xmjRwYM0MCKtJ2+S8xKwZ4UovpI/Q1lxAf
   yNRQkKfqrKbz/xpB/SHe4K8sZ41FbJ/UzXE83RmYI9oeT3O74j+ETcMrg
   hQHDeMLbTKLmH+p8EQunXYr3ttEGa7kOPGo80s59gpZoL+bJnBSLTI3dS
   gPy5E2J12j6I17yThBSR3fBarH6nvlhBcZ/ijdK2kGqXqVP1aFXULvK7+
   w==;
X-CSE-ConnectionGUID: zDJFB5t/ShiyeWk/XOQ1hQ==
X-CSE-MsgGUID: KNR3NPssRn+z3BpPg6tNLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="95584086"
X-IronPort-AV: E=Sophos;i="6.25,168,1779174000"; 
   d="scan'208";a="95584086"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 20:37:11 -0700
X-CSE-ConnectionGUID: DY8XB3RLSVifYBIwGiAV8w==
X-CSE-MsgGUID: yUnCb28GRHuemZQs62+jmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,168,1779174000"; 
   d="scan'208";a="260965926"
Received: from shsensorbuild.sh.intel.com ([10.239.132.250])
  by orviesa005.jf.intel.com with ESMTP; 16 Jul 2026 20:37:09 -0700
From: Even Xu <even.xu@intel.com>
To: bentiss@kernel.org,
	jikos@kernel.org
Cc: srinivas.pandruvada@linux.intel.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Even Xu <even.xu@intel.com>
Subject: [PATCH v4 0/3] HID: Intel-thc-hid: Refine error recovery flow
Date: Fri, 17 Jul 2026 11:37:51 +0800
Message-ID: <20260717033754.3689055-1-even.xu@intel.com>
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
v4:
 - Refine cancel_work_sync() flow to reduce race condition of DMA
   operation confliction and reschedule.

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

 .../intel-quicki2c/pci-quicki2c.c             | 66 +++++++++++------
 .../intel-quicki2c/quicki2c-dev.h             |  5 ++
 .../intel-quickspi/pci-quickspi.c             | 71 +++++++++++--------
 .../intel-quickspi/quickspi-dev.h             |  6 ++
 .../intel-thc-hid/intel-thc/intel-thc-dma.c   | 51 +++++++++++++
 .../intel-thc-hid/intel-thc/intel-thc-dma.h   |  1 +
 6 files changed, 149 insertions(+), 51 deletions(-)

-- 
2.43.0

