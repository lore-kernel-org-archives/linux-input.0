Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F9817BCA;
	Mon,  2 Feb 2026 03:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770001213; cv=none; b=sBkFX98BWbFDv5m8fvdL/fv/9ALaCAloakz1dGnPCZflmQgARvH9UIe6qkH87MwSdqnKclvcBGbE8zgBkmyajkZBeKeLqv3oXdEudt/VfmoOHVHBTAMcGHcrf982NQAo4MDBOrajkwS1qR0ovgbY8c5L1OnmBANx7RvpmySXvAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770001213; c=relaxed/simple;
	bh=ttTeOsbgScD9AvSw4VopOYg2+kxH3+zJvDgoa0v1BFE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NDIsZmyHAnIxFhmEslCAoSHrCwLsYvPgiCoZMdI097od5aoldlhw059qcoFDRSm+RRHiZ5Zx+w+v1iebMnSuheyvCD1v+QOl5j3jFwEU7gJ1rcOozij+ixdiZRHr3QuZ3kQAz9LDLWlKLkFLGkmMY9c9zZVEn0FFnm12bPU/l5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H57cqFem; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H57cqFem"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770001212; x=1801537212;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ttTeOsbgScD9AvSw4VopOYg2+kxH3+zJvDgoa0v1BFE=;
  b=H57cqFemXGfCeNLpSXFtiQNkqiIXCOylwOsCIT+HRUCevhvhsAW9+OJN
   zTYTgKvPZdzt6PFNP6FKehC2FCSlQXLGpeO7aNerQgMwoaLDhg4+FlJ7s
   j7Xdn1xCGZJHmYKDu2BcBnZypOaGIe21yWpUQtuG36pkbxVCLdHazALDg
   7xe0JrVW2TbaAJh35PDM6frNNl2HBukK3NxP/T+4vIi4DpILF+301md0d
   W+MjKYb187weQFkg+BBRkBhGKF+mjHWT15Y+vivkOA323JHIoyIxUNAHL
   7SPS0O1SZdsGBD6TvA0At1JPuPmBf46Ls/yhhrBmbuQCCnGcx7jeetwd6
   g==;
X-CSE-ConnectionGUID: Y9+1ezvuTTSdrgqm6M9kIg==
X-CSE-MsgGUID: L2PtQPZOQLm/hg2evX4OCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11689"; a="70876653"
X-IronPort-AV: E=Sophos;i="6.21,267,1763452800"; 
   d="scan'208";a="70876653"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2026 19:00:11 -0800
X-CSE-ConnectionGUID: dvHeGQ3aRdWfYMGKCTceqA==
X-CSE-MsgGUID: mhF80V7jSkO5P3wCCEpEkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,267,1763452800"; 
   d="scan'208";a="209476350"
Received: from shsensorbuild.sh.intel.com ([10.239.132.250])
  by orviesa007.jf.intel.com with ESMTP; 01 Feb 2026 19:00:08 -0800
From: Even Xu <even.xu@intel.com>
To: bentiss@kernel.org,
	jikos@kernel.org
Cc: srinivas.pandruvada@linux.intel.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Even Xu <even.xu@intel.com>,
	Rui Zhang <rui1.zhang@intel.com>
Subject: [PATCH] HID: Intel-thc-hid: Intel-thc: Fix wrong register fields updating
Date: Mon,  2 Feb 2026 11:01:44 +0800
Message-Id: <20260202030144.967964-1-even.xu@intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clear the target bit fields in register before setting new values. This
ensures proper field updates by removing any existing bits that might
interfere with the new configuration.

Fixes: 22da60f0304b ("HID: Intel-thc-hid: Intel-thc: Introduce interrupt delay control")
Fixes: 45e92a093099 ("HID: Intel-thc-hid: Intel-thc: Introduce max input size control")
Signed-off-by: Even Xu <even.xu@intel.com>
Tested-by: Rui Zhang <rui1.zhang@intel.com>
---
 drivers/hid/intel-thc-hid/intel-thc/intel-thc-dev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dev.c b/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dev.c
index 7e220a4c5ded..d8e195189e4b 100644
--- a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dev.c
+++ b/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dev.c
@@ -1597,6 +1597,7 @@ int thc_i2c_set_rx_max_size(struct thc_device *dev, u32 max_rx_size)
 	if (ret)
 		return ret;
 
+	val = val & ~THC_M_PRT_SPI_ICRRD_OPCODE_I2C_MAX_SIZE;
 	val |= FIELD_PREP(THC_M_PRT_SPI_ICRRD_OPCODE_I2C_MAX_SIZE, max_rx_size);
 
 	ret = regmap_write(dev->thc_regmap, THC_M_PRT_SPI_ICRRD_OPCODE_OFFSET, val);
@@ -1667,6 +1668,7 @@ int thc_i2c_set_rx_int_delay(struct thc_device *dev, u32 delay_us)
 		return ret;
 
 	/* THC hardware counts at 10us unit */
+	val = val & ~THC_M_PRT_SPI_ICRRD_OPCODE_I2C_INTERVAL;
 	val |= FIELD_PREP(THC_M_PRT_SPI_ICRRD_OPCODE_I2C_INTERVAL, DIV_ROUND_UP(delay_us, 10));
 
 	ret = regmap_write(dev->thc_regmap, THC_M_PRT_SPI_ICRRD_OPCODE_OFFSET, val);
-- 
2.40.1

