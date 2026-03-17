Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969D92DCBF3;
	Tue, 17 Mar 2026 05:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773726874; cv=none; b=lSIkkOB9afx9/PEUeIlGIoTP3wTWXSxTSwgqDZWuNqBVVBqS2DR7oKFJ/nREIT6lvhF9cGKXEI3hWaZHeNc6+WXK4aXWUEHdkE30TtPMAD/kAj2VKWW2JW9/NFClvjVQj+o+rxU7EcAaPd6o02OgIChYT9oYZbFvGbq3pvzTTJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773726874; c=relaxed/simple;
	bh=QrWw9zPrh0p8fLpRMWHDMeoKZLSFNj/xYcvhJxOzdFg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bG6W2EYTJZfm+xA7hvox7hdsQrp3aJMSZjqdnKQ45+//gs8YOy/UFzXchI9igk3t7rhIBs+qAfRPea96soYUR9am89Ls5xZX2FcIf1klhEybeW/nbAxgVHc7ASETxYwGc8AHiVO4l3khg31hVV9mRv09lr5Frn+86Z5e7zQcs5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nGV3OPAl; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nGV3OPAl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773726871; x=1805262871;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QrWw9zPrh0p8fLpRMWHDMeoKZLSFNj/xYcvhJxOzdFg=;
  b=nGV3OPAltaXp/k08E7tQqbw1st9JG13jMbvmsNeBAuC1yX6fgZuxn2vT
   s4FaIUtKZ/agGGDmpaS7vuvNN98gKZ3uqXpjuTepq2SRDSTrLhilzKWZu
   WzpvZKPRdwTd+pmGkXSV0gYK9uWsdcnZ/wewuDMh/5NFz7jf6VWAlWrLf
   h0UroRk/CHYeSfZreq+S1V5RkcZmm6Qj2fY26bmZ/c7qgtWXVjogGtXw3
   omnU2FhtAWZzA/e1JRrAaV1jsLVgEa1Vldvz7ADBg1JOsyKZ1eVadKIB8
   jaTzXMdQmUVcESLB0gcv4nO8ok2TqNMFImgf7wJzc2+blfdrWGX5jVYuh
   w==;
X-CSE-ConnectionGUID: KTZFAUDERryJY0BvVKuNOA==
X-CSE-MsgGUID: TdlT1XqtQfuY7PeYidokfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="85447333"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="85447333"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 22:54:30 -0700
X-CSE-ConnectionGUID: dMvU9FdqRY6G9QvAnzQvjA==
X-CSE-MsgGUID: NVF5NWl7QDOsLacLJeNkZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="221391256"
Received: from shsensorbuild.sh.intel.com ([10.239.132.250])
  by orviesa010.jf.intel.com with ESMTP; 16 Mar 2026 22:54:28 -0700
From: Even Xu <even.xu@intel.com>
To: bentiss@kernel.org,
	jikos@kernel.org
Cc: srinivas.pandruvada@linux.intel.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Even Xu <even.xu@intel.com>
Subject: [PATCH 0/2] Add THC Nova Lake device IDs
Date: Tue, 17 Mar 2026 13:56:27 +0800
Message-Id: <20260317055629.3877299-1-even.xu@intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add THC Device IDs for Nova Lake platform.

Even Xu (2):
  Hid: Intel-thc-hid: Intel-quicki2c: Add NVL Device IDs
  Hid: Intel-thc-hid: Intel-quickspi: Add NVL Device IDs

 drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c | 7 +++++++
 drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-dev.h | 4 ++++
 drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c | 6 ++++++
 drivers/hid/intel-thc-hid/intel-quickspi/quickspi-dev.h | 2 ++
 4 files changed, 19 insertions(+)

-- 
2.40.1

