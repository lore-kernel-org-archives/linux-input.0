Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112BD2D47F1;
	Tue, 22 Sep 2026 02:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790045188; cv=none; b=RPeLAF9Lgu4WBk9yf9+KkJ6w0nanoeAoNtwCejZ31rDs9jodThe+GSqXyvFaQTEXII9tukG+GUPPSkOnSJ7T+z71zoHQcoaDZNXXPrUIXr6iIC46/Ku1ftv7uoeRtjpKIBLOD4wB1MS98vFWLluk2wRbb1/7KhqaFnmkSzlKzH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790045188; c=relaxed/simple;
	bh=OhxmPCqC9/TdGXS3ReTmdiTavBipeRxPdc1rtd3HUE8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BKhtRt0mtr/sZ8PdyQl9eQdfnJFwtGB/JGhYoMMBwTcKDjt7JHV8G7iVaEhNQKoHOFaDkhwa25DuC6JJVaJuyTdfWAVSJcWLBhk3O5A4dsSjzJb9Mm1oqkcgFPQdquE6zMAA9xupODTj8Xgr1Uqu9QApDfAEFdjF6fbYVLPbpHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mezy66vS; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mezy66vS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790045186; x=1821581186;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OhxmPCqC9/TdGXS3ReTmdiTavBipeRxPdc1rtd3HUE8=;
  b=Mezy66vSJHsk5tM0t5ezqSn05f++5F5+BYPSlV9Ao+b6wTq+XAXuR+iS
   hSwVSkUlWsO2Q1rVxL4IfSCRFRN0P3eKgVA2W9ip2SGShbMHr3WuuPRkh
   xinNeMT1hnDDJ6/GNlM9jN+TcrzzIi8y14tLAlV3kL+LQY54ooMe/HlYd
   6gwEj+qwo3r8jyddOfaUd0XYon0A7GyT3dt9ax9B1unVRraRSf+5pfsm4
   PJjYY5oF2pEyhZDoZd2ZLX2zBPTE3TYH70AAevokOyXeDrAcafX48BxCy
   3Inhi81wBHTbsqGFOoHC6d8CaF89lq8NynF5ihsy1jb/O9t692cmB6T22
   w==;
X-CSE-ConnectionGUID: LObRjeimQLKm8XpUJ/5tCA==
X-CSE-MsgGUID: ZIiuaSAWR7yGQwuSlkD11w==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="90476358"
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="90476358"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 19:46:25 -0700
X-CSE-ConnectionGUID: UVMYDN3cTY2KxUMeJHfmIQ==
X-CSE-MsgGUID: xZo1MYAwQe+XGVXJLimO1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="272123764"
Received: from shsensorbuild.sh.intel.com ([10.239.132.194])
  by fmviesa010.fm.intel.com with ESMTP; 21 Sep 2026 19:46:23 -0700
From: Even Xu <even.xu@intel.com>
To: bentiss@kernel.org,
	jikos@kernel.org
Cc: srinivas.pandruvada@linux.intel.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Even Xu <even.xu@intel.com>
Subject: [PATCH 0/2] HID: Intel-thc-hid: Fix potential buffer overflow
Date: Tue, 22 Sep 2026 10:46:36 +0800
Message-ID: <20260922024638.932865-1-even.xu@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch set allocate enough space for both the payload and the
packet header for quicki2c and quickspi input and output buffers to 
prevent a buffer overflow when the payload reaches its maximum size,
as their sizes are currently calculated from the payload length only.

Even Xu (2):
  HID: Intel-thc-hid: Intel-quicki2c: Fix buffer overflow
  HID: Intel-thc-hid: Intel-quickspi: Fix buffer overflow

 drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c | 6 ++++--
 drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c | 3 ++-
 2 files changed, 6 insertions(+), 3 deletions(-)

-- 
2.43.0

