Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794817637;
	b=K9gtHkSfzjPGoo0TEYaKw0nxrpb5qEY6nR0xaJCjkwrnMdNR3PuhR3nWa8pEEEy01um+
	 fhv0JxzH8WH8WOt9FWZsYOUVqQPqEVuaIo/+vTAz3ViDaG/z6xJdWCsa85lEi8jfKv0ul
	 ylbEh14GB+Vtfro3GXKf/wJfEAjcOzM3O6wdqcfjbi55BFfVKV5t4O9gH/bqIeTu+9gEZ
	 /y3voZR3D+YRhWvCTscn3Cb47MSUgoXlQP1+jzc3gzmH8Z8tir8OlmgWGj4KDbK7MfBGb
	 iOn3rPvdvusaktiW0lz+b0gxNwsE3+6bbHUBfkhbajq4Rrf+a4Bpj6FlEjJaAetpvvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794817637;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=tmjwHiOmu9GPSSk2ZDHnTlJGBmHZypOBwQsqC13ROik=;
	b=dZ3yHbdVgo76Pg+hzQeLXWnAgTT5Sv12cP54F1DgdGNY0t5jIGVyCrNQ6EB4UsQcmB9H
	 sTvXp6ls6BntXD/HP/5TQ07hbt+Kwcfi90n52ozjRIG+UJxObis7H1gXy4MhajH4eDN4M
	 HidJMaMXyb6PM9BVy9Tx9r7Z3TEpeF/cvgDeHy0p5jUm8C33PV74ADFOnECVsJFTudgRq
	 y9T9MNBK/nSuPMT5Ns+ZWw8kd5oIcwVS7y+Mwy2BGteYAjioIfzvP20kaWkGHg1KOCDlw
	 E3V0DAwk5l/uX3gQKAUlCx7ky0IGZLcLcuWd8ErDnN0XKPveqo0CpeaTlwpFqyPUIEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CpMZ6XPJ;
	arc=none smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF33E606A32A;
	Mon, 16 Nov 2026 08:27:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF33E606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CpMZ6XPJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794817637; x=1826353637;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ppYcIUSdR5dny3eTGmqMIaSA5HDnjVFnpZaSYGrTAGQ=;
  b=CpMZ6XPJPd2xIiXnuEcEBZqGyv+lHjf8fObcaUewN8Sbtv/Uv52P6OMJ
   q7nsFDlK2BcB4eQ7/D5ZAEMwSDr9msTgRr5zYcyBciAZ4YHy9P31dyd/7
   5Zlt6OgLXaWx6DnSUYRtxUIHErJ581JdV8vusfv7JG+FHWnZ0YUKm2rMP
   t5rLr5HyflW+2OJ6bD7dpb5dzZ+6qrFCM/smUo+o9vJaAgZreIAcCyJKN
   ElwbbY6bYJPk37+KPtGOSmCbpS9BqDChi1up4annANj/x9O8xvZ8J1lIr
   /DsrFYHmLXb6IQ41f8NlQKCdyWIgVawI6uNlRul4ePhvOm4HGH634nQW6
   w==;
X-CSE-ConnectionGUID: MiosAqLcTJ6zxueZM3NQ6A==
X-CSE-MsgGUID: Bu7NqYE2SLmzPTIlG/f55g==
X-IronPort-AV: E=McAfee;i="6800,10657,11967"; a="3436294"
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="3436294"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 00:27:09 -0800
X-CSE-ConnectionGUID: i7f7Z2oUTQmKkmvhvfS8vQ==
X-CSE-MsgGUID: I+HDneWgR+q9VbgjIv1e3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="9293404"
Received: from shsensorbuild.sh.intel.com ([10.239.132.194])
  by orviesa008.jf.intel.com with ESMTP; 16 Nov 2026 00:27:04 -0800
From: Even Xu <even.xu@intel.com>
To: bentiss@kernel.org,
	jikos@kernel.org
Cc: srinivas.pandruvada@linux.intel.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Even Xu <even.xu@intel.com>
Subject: [PATCH 0/4] Fix potential THC DMA issues
Date: Mon, 16 Nov 2026 16:27:56 +0800
Message-ID: <20261116082805.3986615-1-even.xu@intel.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch set fix two potential THC DMA issues:
1. THC DMA buffers are rounded up to a 4 KB boundary, but callers may
allocate smaller receive buffers. Checking a frame against the DMA
capacity alone does not protect the destination when do DMA buffer
copying.

2. thc_swdma_read_start() quiesces device interrupts, stops RXDMA and
temporarily disables the I2C special controls. If reading the response
of a completed SWDMA transfer fails, thc_swdma_read_safe() skips
thc_swdma_read_completion(), leaving RXDMA stopped and the saved I2C
controls unrestored. Normal input processing can no longer resume. 

The fixes are:
1. Add thc_rxdma_read_safe() and thc_swdma_read_safe() with an explicit
destination capacity to check both the DMA capacity and the supplied
size before copying. 

2. Call thc_swdma_read_completion() even when reading the completed
response fails, so RXDMA and the saved I2C controls can be restored.


Even Xu (4):
  HID: Intel-thc-hid: Intel-thc: Add safe DMA read interfaces
  HID: Intel-thc-hid: Intel-quickspi: Use safe RXDMA reads
  HID: Intel-thc-hid: Intel-quicki2c: Use safe DMA reads
  HID: Intel-thc-hid: Intel-thc: Restore RXDMA after SWDMA operation
    errors

 .../intel-quicki2c/pci-quicki2c.c             |   9 +-
 .../intel-quicki2c/quicki2c-protocol.c        |   7 +-
 .../intel-quickspi/pci-quickspi.c             |  12 +-
 .../intel-quickspi/quickspi-dev.h             |   7 ++
 .../intel-thc-hid/intel-thc/intel-thc-dma.c   | 103 ++++++++++++++----
 .../intel-thc-hid/intel-thc/intel-thc-dma.h   |   6 +
 6 files changed, 115 insertions(+), 29 deletions(-)

-- 
2.43.0

