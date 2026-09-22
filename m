Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC41275AEB;
	Tue, 22 Sep 2026 02:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790045660; cv=none; b=e1yJRpD52ewfBqPysUj4R43bE3E8dsyG2dRxdV58JIknbeOQLscFBq1RgUwkTfzrQRzRc2IAU+4DrJil/BM8E0Kd/bLqWqI94xhnKH2Py9YkQoPbHaeUEXfeurOZQ94ek8Kn+7/TZD/XNm9NH2n1u7F1Zvz+whLSoP5/qqhFI28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790045660; c=relaxed/simple;
	bh=4GRMjnsKnazDNkw7HugIFKZH1fi0VJdtxaR0+B+UXjw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qsgNdo1era693NvAg/+I0me96FwfDSOx1g89xGHrHp7x1H7g3z6km2aahJpiVt7bAuRSWl1IEdU6PV8uNeWccsEgRXfsntFSWE/Vm0h2RByIsMSSFhHEW8qZ+UIFaWDgv+vAdj3cogIItfPAUbNl7tPRLI9DO5N7HLrFyC0BSMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ORtYb14b; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ORtYb14b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790045659; x=1821581659;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4GRMjnsKnazDNkw7HugIFKZH1fi0VJdtxaR0+B+UXjw=;
  b=ORtYb14b7zmdO44rtqe4U+viCwQJ4yt6DvSzOMYk+Ryxv480oL0DvynP
   zQgSjshtoupQNvJcDRMex1Obc4G1kqsQD+fSGFqREE+y9mjE7LFsxUdz1
   oU30wTwuVH0teePH1L7uRzy6kVBlVxyu/kvw6PMr6oDTwyvr1Zco+1Z6K
   aKuHeHphjmkMT4SKS2vDkmW11dzEPFtxt7nVFnqAFLzY4uM7VLXYDETSu
   VxgU1d0HDayxPy6NVmbSOvCXW+4B1Yh7+4RDL04jLjzW9LJIPH/TPdvKc
   AlKr+VKFJ5s+IIWkvCzMQNSttqe4/aHKlFGpeMCwGrkqrjg0mO3uyPR3p
   g==;
X-CSE-ConnectionGUID: HdIc3KkkQMK9OhuysK1oMA==
X-CSE-MsgGUID: cJoCD12aSWOrSgp7B+vMvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="93114154"
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="93114154"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 19:54:17 -0700
X-CSE-ConnectionGUID: Li23mi2LRVumUHt4VY82uQ==
X-CSE-MsgGUID: iuT9xLvqRPKuUHIp/NLKbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="280995784"
Received: from shsensorbuild.sh.intel.com ([10.239.132.194])
  by fmviesa005.fm.intel.com with ESMTP; 21 Sep 2026 19:54:16 -0700
From: Even Xu <even.xu@intel.com>
To: bentiss@kernel.org,
	jikos@kernel.org
Cc: srinivas.pandruvada@linux.intel.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Even Xu <even.xu@intel.com>
Subject: [PATCH 0/2] HID: Intel-thc-hid: Use hid_safe_input_report()
Date: Tue, 22 Sep 2026 10:54:35 +0800
Message-ID: <20260922025437.940072-1-even.xu@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch set replace the legacy hid_input_report() with new
hid_safe_input_report() in quicki2c and quickspi drivers.

Even Xu (2):
  HID: Intel-thc-hid: Intel-quicki2c: Use hid_safe_input_report()
  HID: Intel-thc-hid: Intel-quickspi: Use hid_safe_input_report()

 drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c     | 4 +++-
 drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-dev.h     | 2 ++
 drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-hid.c     | 6 ++++--
 drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-hid.h     | 2 +-
 drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c     | 2 ++
 drivers/hid/intel-thc-hid/intel-quickspi/quickspi-dev.h     | 2 ++
 drivers/hid/intel-thc-hid/intel-quickspi/quickspi-hid.c     | 6 ++++--
 drivers/hid/intel-thc-hid/intel-quickspi/quickspi-hid.h     | 2 +-
 .../hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c    | 2 +-
 9 files changed, 20 insertions(+), 8 deletions(-)

-- 
2.43.0

