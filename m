Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DF3368269;
	Fri, 30 Jan 2026 05:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769751314; cv=none; b=vCSbT+HjChrg/UQI3wOU9m4nQKEFw4CHq1UZD32GEAnQ9ZG1ukLHBpPYYmiOcY7/08jxBHVA8lir6mtbkII+o8PwnHtmN1T4Fn6VVud56YfQ+lMdX0xP0r9nXhwXe28B++dEeh4QBKffHBHUi92UJTsmTisSFmshRohIMCTTAEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769751314; c=relaxed/simple;
	bh=yQtrIZYMGBOPGh7ijILbyFvEjfTD1GYQwagRe1+arKg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=USJbX2mlpVT+QClR3dPqrsuv3QMg1+TV2XXP+txFcfr+sCmoEk0PQnF/RvJFanOxgvItATpnO9+fX6wU8/OOk+qQJ7/jB+vZG8L7bhoGJJVX5gHJRYXldZdq3Nc3Rsxa+LpHZFntKvlrP8wM+piA4zT+09DVGhbKhLGRwEe768M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CQGz/6FI; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CQGz/6FI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769751312; x=1801287312;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yQtrIZYMGBOPGh7ijILbyFvEjfTD1GYQwagRe1+arKg=;
  b=CQGz/6FIaMopG0GS0PCA8FS4m41XhXLP9rY00WWTACPCeFwFR0gRZPlc
   eJzMxrUr6aOLff7yYUNni7kCVkoWeFvjVgHzj5BPkj0Kjwq6Zym4GTTGi
   zbKG7TDvhp/WMJZrZnrsyf8DI0Pv6vYk1UfxfHozP3PgjmBrP9Mj8ADNA
   amWIawn8W5habCI+pc7mT6L1Ul6TeuYQbd0lC8Dpc4Wpil5u7omD3SSCn
   8qLD04REBSZn1YQ+WUEGV5XudjGP1rrqQOzRsApMW2IoGmilrEixIMD+l
   yDHg6gm1QzVYunm78mUqlil8HsoSEdjtIhkhbqjjodXF5P2nKCpAmucrq
   Q==;
X-CSE-ConnectionGUID: P49OQL1OS6GiNzkArHbAOw==
X-CSE-MsgGUID: vhx4z03ESGOcjua2KtOvpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11686"; a="71037075"
X-IronPort-AV: E=Sophos;i="6.21,262,1763452800"; 
   d="scan'208";a="71037075"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 21:35:11 -0800
X-CSE-ConnectionGUID: USzaDlz4Sxa8Wyuy+pzygw==
X-CSE-MsgGUID: CS5WtFbwQLCVBxZbbc5yVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,262,1763452800"; 
   d="scan'208";a="213298766"
Received: from linryan-mobl2.gar.corp.intel.com (HELO linryan-mobl2.intel.com) ([10.246.105.132])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 21:35:09 -0800
From: Ryan Lin <ryan.lin@intel.com>
To: linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	srinivas.pandruvada@linux.intel.com,
	lixu.zhang@intel.com
Cc: Ryan Lin <ryan.lin@intel.com>
Subject: [PATCH v2] HID: intel-ish-hid: fix NULL-ptr-deref in ishtp_bus_remove_all_clients
Date: Fri, 30 Jan 2026 13:34:56 +0800
Message-Id: <20260130053456.4971-1-ryan.lin@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During a warm reset flow, the cl->device pointer may be NULL if the
reset occurs while clients are still being enumerated. Accessing
cl->device->reference_count without a NULL check leads to a kernel panic.

This issue was identified during multi-unit warm reboot stress clycles.
Add a defensive NULL check for cl->device to ensure stability under
such intensive testing conditions.

KASAN: null-ptr-deref in range [0000000000000000-0000000000000007]
Workqueue: ish_fw_update_wq fw_reset_work_fn

Call Trace:
 ishtp_bus_remove_all_clients+0xbe/0x130 [intel_ishtp]
 ishtp_reset_handler+0x85/0x1a0 [intel_ishtp]
 fw_reset_work_fn+0x8a/0xc0 [intel_ish_ipc]

Fixes: 3703f53b99e4a ("HID: intel_ish-hid: ISH Transport layer")
Signed-off-by: Ryan Lin <ryan.lin@intel.com>
---
 drivers/hid/intel-ish-hid/ishtp/bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/intel-ish-hid/ishtp/bus.c b/drivers/hid/intel-ish-hid/ishtp/bus.c
index c3915f3a060e..b890fbf97a75 100644
--- a/drivers/hid/intel-ish-hid/ishtp/bus.c
+++ b/drivers/hid/intel-ish-hid/ishtp/bus.c
@@ -730,7 +730,7 @@ void ishtp_bus_remove_all_clients(struct ishtp_device *ishtp_dev,
 	spin_lock_irqsave(&ishtp_dev->cl_list_lock, flags);
 	list_for_each_entry(cl, &ishtp_dev->cl_list, link) {
 		cl->state = ISHTP_CL_DISCONNECTED;
-		if (warm_reset && cl->device->reference_count)
+		if (warm_reset && cl->device && cl->device->reference_count)
 			continue;
 
 		/*
-- 
2.34.1

