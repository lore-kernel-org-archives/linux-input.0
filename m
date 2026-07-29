Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFCE32B99F;
	Wed, 29 Jul 2026 05:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785301260; cv=none; b=gWW2Ax5yjzt3o7K0U7UvCC/Z/u9Af9Auj6bnUjG9JYcJ0cZz3Vyafu+of9z6bT3WSoaXnn4G+8PHUBd/1DicklhFNlROV512MGkwiurduWxU//Ok02gwaC7J3Dlgo4Ttc1LVJMXJceMt8zpAnvakZxNBs2weAXBxxIiTJzqGO2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785301260; c=relaxed/simple;
	bh=t3VD2Lxicsf1yrpKethrujOEsXIRf1ZNzI6sKypV948=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O8xvyG5KTJwSlt/mkW0MOYa1CuVmdtcM/ziXAmm5DMokBE5Ds5XdNff1ZZNqdGq+ket73/7qY9zdCztj6l+iModESVsNgzE88FF3QlEpFYKPW2xd1ZO2KAf1CNFT5Dg0C27e/4PB11sFn8HMK/mya8YLfSsTzfUz3rEdRHXqpmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V+YnoLa5; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V+YnoLa5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785301257; x=1816837257;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=t3VD2Lxicsf1yrpKethrujOEsXIRf1ZNzI6sKypV948=;
  b=V+YnoLa5zO7wVHgI8m22B0lYP2QIlNNf5eRruGOIKf2bqRbcpbWlQdlR
   XmOawFiAir7yRzg2njSi+6Xy9zwbNy3n2L403OzoR7QIRUg4uJCck71IA
   ljipUGaHXpsZ7TChv3Oe2vJRz7dxi6cKbOLN8mESkOsWG3bajcbQXr9vj
   VSo/DdRxRrhrpCHldYHftesSp0imcwT0/YFNBgGW28N+1rEMEffkNCuMr
   spLQFBhb5qqh1fYSeNItHZcxuBtj0ZKGSnToPrT5voA8u8u6AkyGFoUP1
   5uA1RYI2aPQsV2bSeqx25RYtNTC79j0prlmCrgvQYBSS9nnq+65tugRZj
   Q==;
X-CSE-ConnectionGUID: 2C39eNSCTKCRE2qGgRfQCQ==
X-CSE-MsgGUID: Vm1CJSOLRJuXElw7KyyybQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="97056386"
X-IronPort-AV: E=Sophos;i="6.25,191,1779174000"; 
   d="scan'208";a="97056386"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2026 22:00:57 -0700
X-CSE-ConnectionGUID: jft9nkcSQt+4vO6Mlqk7CA==
X-CSE-MsgGUID: VK3khgZtRoaKlFMqmX89Tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,191,1779174000"; 
   d="scan'208";a="284447493"
Received: from shsensorbuild.sh.intel.com ([10.239.132.250])
  by fmviesa001.fm.intel.com with ESMTP; 28 Jul 2026 22:00:54 -0700
From: Even Xu <even.xu@intel.com>
To: bentiss@kernel.org,
	jikos@kernel.org
Cc: srinivas.pandruvada@linux.intel.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hbarnor@chromium.org,
	Even Xu <even.xu@intel.com>
Subject: [PATCH v5 0/3] HID: Intel-thc-hid: Refine error recovery flow
Date: Wed, 29 Jul 2026 13:01:42 +0800
Message-ID: <20260729050145.2272597-1-even.xu@intel.com>
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
v5:
 - Add log message in quicki2c/quickspi driver to indicate driver
   function was disabled when recover failed.

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
 .../intel-quickspi/pci-quickspi.c             | 71 ++++++++++++-------
 .../intel-quickspi/quickspi-dev.h             |  6 ++
 .../intel-thc-hid/intel-thc/intel-thc-dma.c   | 51 +++++++++++++
 .../intel-thc-hid/intel-thc/intel-thc-dma.h   |  1 +
 6 files changed, 151 insertions(+), 49 deletions(-)

-- 
2.43.0

