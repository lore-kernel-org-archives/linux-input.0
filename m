Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794254397;
	b=ShviOHO/4fljc/THEojV+VvBnLb18fFpfOylMKTIM3YpwEbptDZASsd9TOnq9zUB3uP1
	 mM8+ySuR7vCvVusPMKDHZQpB78HIy7IDyV+/z0LqlPNjJNL52qzWs1+v9Tzk38Sfbh6yu
	 Lol7lY1+0WwA+oLyLdzE4MtjsxVcwtpmfvywgwEor3GzvmIlesEottH1NC5REnn1/nVdl
	 9xcIH5ZcLbbgQOze/pIF2n/vKUAQczy1q/dAaavR9w19xq7dMEx8DDg8gkcdVheAVnG3S
	 n4WHAOChh7Bi4M0+yRCNo4PBnHAUDTfBxWChy8twQ+n9w4o9uePtl1g+UKehb2rBVsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794254397;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=KkjxROtZGcpOs9yDqQwozKXxS84Xt6CkTq01+bNqnoU=;
	b=ZhCRFUqbqyXiGS7XsimUrGaUQVdAfQUoNWc/2Cll/5Yi9TUQLkBK8XAsTGL7FQVcQ9GE
	 iTad3OUzK96IzbJAtfGTfltcrLVSUu6CXFRcpiEp60Q54TOvJmIxWlkH//jyhPG8z7cBw
	 xW2MOPQrzmsoxjyHROsyTi8OakkiR1WeJ4cnRUmeUrRqSiNN6cVaChWWH1WWFiSzzIXlT
	 D4faUhJmGtez/iqh3qkaGigRrUPWVdGLSY9mpyL3g+wtqBUeVZuauoQc7BU1AjYbMlJY0
	 YnQEcGpp7q2r2u0UAODXqlV1PN/6OgoVlDPGgpCnQu7sYfC3junmgyk9M0cNjoTVMjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SKqbRhq6;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DEC60A260D;
	Mon,  9 Nov 2026 19:59:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80DEC60A260D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SKqbRhq6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794254397; x=1825790397;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xl34rX/XR+yWfIv+R+WT5yRxSY8wgQ56yx9iiyV5/vI=;
  b=SKqbRhq6BJ/kRoNTugNWHh0dDQDqxrtxDoXi7WnS1xgR6/DNznoLkZBv
   R/FHHBXCqmjjgkTXOOpyPLTsqjuaJGp0wT/l2+Kl0+QHTpXwS6JRQqWAr
   EoMyrdvd974Ip80EFUUfNiOoza33YT8cVyX3mhQVCw0MRYXyfrhOdV+Mo
   EQVA0wZvqN8yuLWGfKeOdIzCWwD+Acx4PdDyRxMb3vSpaiBRws7jTZA8E
   XwY9la4St7iiTytHSV6umG6QZwNBAapO+XTIY6nCrMFXvP7bFHCGVGti5
   11QA17Y8DqlfcfhauiGD7t6CvCinAqTaTvaPpDDBDctLu+4Sp2gzHa9iQ
   g==;
X-CSE-ConnectionGUID: 2KsdJ6OmQH+ic62rkDJQmA==
X-CSE-MsgGUID: yV5QuYFCTq2IjCKueDgbew==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="2986565"
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="2986565"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 11:59:55 -0800
X-CSE-ConnectionGUID: 254DfokBTRORpOC8TQYHHA==
X-CSE-MsgGUID: J85itryhTZidsFThP9NwZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="8090661"
Received: from spandruv-desk.jf.intel.com ([10.54.55.20])
  by fmviesa005.fm.intel.com with ESMTP; 09 Nov 2026 11:59:54 -0800
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jikos@kernel.org,
	jic23@kernel.org,
	bentiss@kernel.org
Cc: linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	simeon@maryasin.name,
	lixu.zhang@intel.com,
	crofts@kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v3 3/7] HID: sensor: custom: Disable sensor before hub close on removal
Date: Mon,  9 Nov 2026 11:59:45 -0800
Message-ID: <20261109195949.384888-4-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261109195949.384888-1-srinivas.pandruvada@linux.intel.com>
References: <20261109195949.384888-1-srinivas.pandruvada@linux.intel.com>
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

When removing an enabled sensor, set its power and reporting states to
off before closing the hub. Keep the field descriptors alive until the
state update has completed, and release the hub's open reference.

Fixes: 4a7de0519df5 ("HID: sensor: Custom and Generic sensor support")
Reported-by: Semyon Maryasin <simeon@maryasin.name>
Closes: https://lore.kernel.org/all/CAM2dg7ewfVJSP4rFyhkCB1Rmd1+X56sAg=eUdbPthG2xrLqwQQ@mail.gmail.com/
Reviewed-by: Joshua Crofts <crofts@kernel.org>
Tested-by: Semyon Maryasin <simeon@maryasin.name>
Tested-by: Zhang Lixu <lixu.zhang@intel.com>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/hid/hid-sensor-custom.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-sensor-custom.c
index 3a65da64fd2a..ec7734e8e4a6 100644
--- a/drivers/hid/hid-sensor-custom.c
+++ b/drivers/hid/hid-sensor-custom.c
@@ -1052,6 +1052,13 @@ static void hid_sensor_custom_remove(struct platform_device *pdev)
 	/* Remove enable_sensor first as it uses fields via power_state/report_state. */
 	sysfs_remove_group(&sensor_inst->pdev->dev.kobj,
 			   &enable_sensor_attr_group);
+	mutex_lock(&sensor_inst->mutex);
+	if (sensor_inst->enable) {
+		set_power_report_state(sensor_inst, false);
+		sensor_hub_device_close(hsdev);
+		sensor_inst->enable = false;
+	}
+	mutex_unlock(&sensor_inst->mutex);
 	hid_sensor_custom_remove_attributes(sensor_inst);
 	sensor_hub_remove_callback(hsdev, hsdev->usage);
 }
-- 
2.56.0

