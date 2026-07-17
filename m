Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5865131282F;
	Fri, 17 Jul 2026 03:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784260527; cv=none; b=PbDAdq+AsKa/KQ4KyRFrfVbMIFFk8qm/l1SMy0Jbx/M2TRUBeJaeILzS5Hr437Z74Dq26abDVf+dyfqbKkYBBc4hBTathe1w+x4+CMJ6D/jXOtqxpahQa7VnzB/beKSOj03o4/FB3F4ycDIQYTYwlI4ILAj8GCTU2xj/va3+BKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784260527; c=relaxed/simple;
	bh=kgCpNGy/aoK03ZQpPWxvrHN9QXPDIrua5ms3gs5dA3A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iHExqF6+FLln7MOqdHrJ/3MO+8V4Uj5Rs/q64pTq10Inm53yk+33GDAhCb2SFNQrj4G02aoIJxk8FTtcsAxuaoRB4KNix2StU0pNVPgX8NskQrpCE4OAJqD3E2iEu/TYepPXucNcsV+0vK3njgyOha/012whxFkapjlLHr4dmzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kObgY2Te; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kObgY2Te"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784260525; x=1815796525;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kgCpNGy/aoK03ZQpPWxvrHN9QXPDIrua5ms3gs5dA3A=;
  b=kObgY2Te+7nTGWZyvyBeCnFpH9ztxk0f3fgws7bAjYyXW2gIpiEwU2i9
   mdvZVlF7Fls4+wJWksszoxAofCwQFEkp+CoXymsO+JS3Ij0BsKsN4PL/8
   +k3gX9RWJUY+AsTXeXHhw+xBWDv0fqt5ylZAXhO76NfVRIblKPLPKqBvg
   GLUNtw4y1k640AkgwdMrWH8O05oaZykmNiYxHe0JlOv5Y8cvJAUcMNGLi
   Ts3ku0KjznOpe2rQ5FLM+l6AqnyDn+jVuLKIMKr1tJEZwFXoDXDtKjWIK
   t4S4mWWizkfTU/P9134DMVE/yEEgCjBjnhHVEnLX6gdcepkgVOsiMu/Ed
   w==;
X-CSE-ConnectionGUID: n2Caz+SeSFixhaygf8hNiw==
X-CSE-MsgGUID: 2SMxD7SHSYaoq1VuGlaibQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="84808734"
X-IronPort-AV: E=Sophos;i="6.25,168,1779174000"; 
   d="scan'208";a="84808734"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 20:55:25 -0700
X-CSE-ConnectionGUID: beinNAcNRdqUAfSWZJKjvQ==
X-CSE-MsgGUID: MgPbg7iHQzq891IctB9YYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,168,1779174000"; 
   d="scan'208";a="254029641"
Received: from shsensorbuild.sh.intel.com ([10.239.132.250])
  by fmviesa008.fm.intel.com with ESMTP; 16 Jul 2026 20:55:23 -0700
From: Even Xu <even.xu@intel.com>
To: bentiss@kernel.org,
	jikos@kernel.org
Cc: srinivas.pandruvada@linux.intel.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Even Xu <even.xu@intel.com>
Subject: [PATCH RESEND v4 0/3] HID: Intel-thc-hid: Refine error recovery flow
Date: Fri, 17 Jul 2026 11:56:06 +0800
Message-ID: <20260717035609.3874015-1-even.xu@intel.com>
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

