Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6042A2620E5;
	Fri, 30 Jan 2026 05:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769750763; cv=none; b=b+/mBmf9UpjfaAGTTnCwH9y2SxE7S+12VYsOJHzrskH9fpCz3//5fQG7e7SFJr5d2eqc9Ff5tpq6JDnr5RYapZc/z9zgeZw/TZmadVxOnfmu/TgK0EMHZxaqRyTopTKdGYijuSTXCaGTZVmS1i+fNV4pGZ/bxjwcJPdAp/vlLTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769750763; c=relaxed/simple;
	bh=yQtrIZYMGBOPGh7ijILbyFvEjfTD1GYQwagRe1+arKg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JjEcGOsFnsmmwQddVAsVo8w0NOy+j8QiyNEonhLuob/BMQGJzPOHLJX+cGroPG7ltFEYzIgPc+DXfT5V+DZ31YKCTLq7MGt2xPta0mzizoHwOBsu+naemFdgRKOZTyuyGzPKv1e5zPm3ld/mwigEvxvzc6enzgaUp8thWjzSVyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=khzVCdJH; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="khzVCdJH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769750762; x=1801286762;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yQtrIZYMGBOPGh7ijILbyFvEjfTD1GYQwagRe1+arKg=;
  b=khzVCdJH32SWvGZBckmDx6YP4LIdqv3Lo1PhpYKcpKGNR2SdmCNdX9d5
   hq7Yz3A7Y94qJBtpPr0DAtFDv7RaKZ46n2hEA5Yzqzl8z9vf+cG4Ju+Po
   iWJ2szhMjJew5NmHzphnLEXzcelYrVcJCP7EHXeB5ClemOS++OYtKKJCW
   tgnLWVwVW2jEIBIftsW8Mf8d7sPSM3tOYQuzwvRG+Dc+7jiPYcUjkUR1l
   QPMfTGv/kZJ4ivRlG1YgEavhuCPNX7QGRHs4uVuR1HdE3zrawlpxjplHa
   7c68mcU/GnDkNLGwdHv5lZEDguJzPg1D4Xj4XYejZS2rYyoAoecG47eKx
   Q==;
X-CSE-ConnectionGUID: InAJN7/fTXyrTZ1CvcVvjw==
X-CSE-MsgGUID: CwZlQsJQQ92QhBL+EjQ2uw==
X-IronPort-AV: E=McAfee;i="6800,10657,11686"; a="70977454"
X-IronPort-AV: E=Sophos;i="6.21,262,1763452800"; 
   d="scan'208";a="70977454"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 21:26:01 -0800
X-CSE-ConnectionGUID: LsRhM8w+QTWksDvbxbZ68g==
X-CSE-MsgGUID: NKClVpYnRUSEA2pql2K0EQ==
X-ExtLoop1: 1
Received: from linryan-mobl2.gar.corp.intel.com (HELO linryan-mobl2.intel.com) ([10.246.105.132])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 21:25:57 -0800
From: Ryan Lin <ryan.lin@intel.com>
To: linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-drivers-review@eclists.intel.com,
	srinivas.pandruvada@linux.intel.com,
	lixu.zhang@intel.com
Cc: Ryan Lin <ryan.lin@intel.com>
Subject: [PATCH] HID: intel-ish-hid: fix NULL-ptr-deref in ishtp_bus_remove_all_clients
Date: Fri, 30 Jan 2026 13:25:44 +0800
Message-Id: <20260130052544.4784-1-ryan.lin@intel.com>
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

