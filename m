Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE9036EA80;
	Fri,  3 Jul 2026 07:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783065502; cv=none; b=OqZMUhjrjdjrJg/d7s1DQCXexsrh4ne1AbdWG/6/yvmZOK8obE2qZpFoMHII3a3LoZngt3jmi/0ws86PQYc/cgh04unSflYTDDARtiVnR9J+t+Ez6vBL5yzkwRjyame09TRfAfMp3aRM+AoDxVaowY0gxEa9Gcqncf0JiScaNOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783065502; c=relaxed/simple;
	bh=l0Dkp/fhC7K/CNOmvTDOo2aImpGmJMswM78dgo2n5xQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EIjEdJhCYKouFIuDph65xnfN3C8Cpuad6YeQHO3WPLsXces3J15hVKjzXREyeftu4kEXgfr2Ud7jQeQrDpRjtDSDiJrap6L/pH5lR3wB29G9ikgBZQ+gFdByKx4k4MpeqGTI0zL/tj8HcKP6uPVFGxao2pv3biBrLL/HH944t6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FIr4yafn; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FIr4yafn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783065500; x=1814601500;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=l0Dkp/fhC7K/CNOmvTDOo2aImpGmJMswM78dgo2n5xQ=;
  b=FIr4yafnnJAFu21i6etg6bJjjU0ksWjt9kMIB/lBxROdh0qfvmXYRlfZ
   BL0I1/F2bf5ki4TFrCwpNah6vrBrGtUqJyOr7Zg3TFU072ZJSXJcrN/5L
   9CUjGyuBaGbVQ0TQJsC+ATgmxP3EDJRcR0xA9UqjVxytk2SRBLMuBG9de
   XQ1kefv4zYkcYljf3y5CS3EBF8U4WU/cY7Aq8lTQsUg8hkSrM2sAQrPyx
   lA3AnwkFuHrdeyvb37+syZaUEY3U6rX63NlQaQNSflQ766NZEnH3jHu4b
   UWAIkrvFXnSM7RdrZOEqXaBPKg3ia7seVHM90SGznCPkD99KWX0hNvmXm
   w==;
X-CSE-ConnectionGUID: mXBWOJHGT+ihxXp3brbrGA==
X-CSE-MsgGUID: ga0Syf/DTJ2FalDrn7Db3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11835"; a="83682789"
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="83682789"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2026 00:58:19 -0700
X-CSE-ConnectionGUID: SlYHmSRHR4+Rgv0cZXQlpw==
X-CSE-MsgGUID: O01nvE8LRR+a4Mf3wKbQMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="257945992"
Received: from shsensorbuild.sh.intel.com ([10.239.132.250])
  by fmviesa005.fm.intel.com with ESMTP; 03 Jul 2026 00:58:17 -0700
From: Even Xu <even.xu@intel.com>
To: bentiss@kernel.org,
	jikos@kernel.org
Cc: srinivas.pandruvada@linux.intel.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Even Xu <even.xu@intel.com>
Subject: [PATCH v2 0/3] HID: Intel-thc-hid: Refine error recovery flow
Date: Fri,  3 Jul 2026 15:58:55 +0800
Message-ID: <20260703075858.2780398-1-even.xu@intel.com>
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

 .../intel-quicki2c/pci-quicki2c.c             | 42 ++++++++-------
 .../intel-quicki2c/quicki2c-dev.h             |  2 +
 .../intel-quickspi/pci-quickspi.c             | 46 ++++++++---------
 .../intel-quickspi/quickspi-dev.h             |  3 ++
 .../intel-thc-hid/intel-thc/intel-thc-dma.c   | 51 +++++++++++++++++++
 .../intel-thc-hid/intel-thc/intel-thc-dma.h   |  1 +
 6 files changed, 102 insertions(+), 43 deletions(-)

-- 
2.43.0

