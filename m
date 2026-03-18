Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCBF261B8D;
	Wed, 18 Mar 2026 03:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773804226; cv=none; b=r6kFVRNKZ0972pNuwkkt2d6O5ByIt7q904b3j05qd6ofIcnhUNWM6Wzl/zXX1wUJH3DLzpeEdLlHJZyi7GdyoYG4ZA7RTGab/MjmB0cLU+BVqTghGraZ4xm0yy5MHzMwAtoGp9E4EbtScQXIcg5kWCJgxO/PbJ2/azVgcqxd+V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773804226; c=relaxed/simple;
	bh=qrbpSHeYPm+LjbNZ6zUfDknQ+6ygRZYsSq5iCY2KJBY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Y2SoBEMsYPDi6J09k7+42oZFeP9y378KA0f/9mggc7LTzAvVHmfYZ27gUr0VSQdZSJ10GaPArGBhts0b/dKAl6qSwWqLoPTCrLVwiW9OWV7R+PzSXeGXdg/XgXG99y50rtMDZB4tjQJh9tdiuNqto+p6qEHGBCc+Tk3tZfcYJxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h9nq1vlk; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h9nq1vlk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773804225; x=1805340225;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qrbpSHeYPm+LjbNZ6zUfDknQ+6ygRZYsSq5iCY2KJBY=;
  b=h9nq1vlkuJCJAx3kiM60dVDasY5U9RgHV+cpvzw4DeIBZQsLjoCwWCKc
   QXD1o25E8K/cw6mKlQtmbAh55YgzyBBkrzecrJZsIwUyVcccRmdd02GK6
   6kNSxWaEgGz7J9kcumIgwN9sWO/8nuwgQwaVSbhbAppuGuipjFN1+3Xpy
   THMV+2lSNZ+n8xU7vcMESG+LgGKWDNkODgq5e+U5Ib/cRy3UJc0NDpvBL
   vLvdcUuhZMdIrKAkpEFI3YdfytlBNUwBZWFBHYL7ZKU7xMlXshhOGJ/4S
   wn+56hqlZf4Nk1SQyNf+Yksb2o7NbJtUR4JtYr+01VZ6JnOJvJ3hxZqFT
   w==;
X-CSE-ConnectionGUID: VehF1NkLTyGvoe4RYUH9lA==
X-CSE-MsgGUID: QtG20m+TQHq9GYj+eyZRcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="78752414"
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="78752414"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 20:23:44 -0700
X-CSE-ConnectionGUID: YxdEU31lRF+FWxKdBxJcSw==
X-CSE-MsgGUID: VTEkPxEkTI+WTwzhp45PmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="219543225"
Received: from shsensorbuild.sh.intel.com ([10.239.132.250])
  by fmviesa007.fm.intel.com with ESMTP; 17 Mar 2026 20:23:42 -0700
From: Even Xu <even.xu@intel.com>
To: bentiss@kernel.org,
	jikos@kernel.org
Cc: srinivas.pandruvada@linux.intel.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Even Xu <even.xu@intel.com>,
	Rui Zhang <rui1.zhang@intel.com>
Subject: [PATCH] Hid: Intel-thc-hid: Intel-quickspi: Improve power management for touch devices
Date: Wed, 18 Mar 2026 11:25:47 +0800
Message-Id: <20260318032547.839686-1-even.xu@intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enhance power management with two key improvements:
1. Hibernate support: Send POWER_OFF command when entering hibernate
   mode.
2. Conditional sleep commands: Only send POWER_SLEEP/POWER_ON commands
   during system suspend/resume when the touch device is not configured
   as a wake source, preserving Wake-on-Touch (WoT) functionality. This
   ensures proper power states while maintaining expected wake behavior.

Signed-off-by: Even Xu <even.xu@intel.com>
Tested-by: Rui Zhang <rui1.zhang@intel.com>
---
 .../intel-thc-hid/intel-quickspi/pci-quickspi.c  | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
index b6a69995692c..f669235f1883 100644
--- a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
+++ b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
@@ -753,9 +753,11 @@ static int quickspi_suspend(struct device *device)
 	if (!qsdev)
 		return -ENODEV;
 
-	ret = quickspi_set_power(qsdev, HIDSPI_SLEEP);
-	if (ret)
-		return ret;
+	if (!device_may_wakeup(qsdev->dev)) {
+		ret = quickspi_set_power(qsdev, HIDSPI_SLEEP);
+		if (ret)
+			return ret;
+	}
 
 	ret = thc_interrupt_quiesce(qsdev->thc_hw, true);
 	if (ret)
@@ -794,9 +796,8 @@ static int quickspi_resume(struct device *device)
 	if (ret)
 		return ret;
 
-	ret = quickspi_set_power(qsdev, HIDSPI_ON);
-	if (ret)
-		return ret;
+	if (!device_may_wakeup(qsdev->dev))
+		return quickspi_set_power(qsdev, HIDSPI_ON);
 
 	return 0;
 }
@@ -855,6 +856,9 @@ static int quickspi_poweroff(struct device *device)
 	if (!qsdev)
 		return -ENODEV;
 
+	/* Ignore the return value as platform will be poweroff soon */
+	quickspi_set_power(qsdev, HIDSPI_OFF);
+
 	ret = thc_interrupt_quiesce(qsdev->thc_hw, true);
 	if (ret)
 		return ret;
-- 
2.40.1

