Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794254397;
	b=g/QdASxNaMoCA81hopDBewQJNroSPk779LGLncYTGV5HbLkawwvrefJQa++tVyX6t7Nz
	 kOKqX4Gx/BUZ3nIL075wbUa8aZG9BlUKwuiIwTzmnFJuO120uT5FWwuv0JGdWPIwZUD1M
	 cWeqnZfPcGxxoA6fg41xNtB8oC8M7u+GNtvEDvar+wImCp5+Dnoxzw5Y5aV1OjukoaAbT
	 +9KM4WdpSCFqofQ8ZlqzC0rSXByokCF3XVABDuDVTptKhsa1gw7egahyllpps56o/hWMz
	 7/5k27eUwW7hSCMiKDLqwQBFP6vv7ZaCU9Ws5IHtzGEUemsPAEvkgDPY89a28saFLdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794254397;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=QQbHee+Nm/vWzn4Wj20Cf7+RfTca8c4wLg/g+T/SLXg=;
	b=qJDpF4e4EJD5ZCli9N43xX6JA+Yhd5zyREyQRfK7to1HOXFMaCBOzkTwYkC1EsYfTfDk
	 oNShYfvLyTUCulChZgkY8mN0jrRXQMseoK+mSbfhwjnRanDcTpN/eVqB5rdyd3/18bYn9
	 ynqscJqtiuIzWmqWgXSZPCDkov7qPvVul93e7Qe+7EolT0GQ0MBBB8whDLRzJqudCSTk4
	 S+I3jtOOxh1k32q8sz2UZ5iW8fo9Z4RejNK3ZmET8600K4ubgu45NZKLv7QHyn1yqrc5Y
	 QeqA6U8OyeC2ENSnDrGb9bheHmfo2OklMdOZ+RbpPfJwq6oWJbB1XWHxxL3Ry+biKqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fW3HY1F1;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2938606A31C;
	Mon,  9 Nov 2026 19:59:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2938606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fW3HY1F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794254396; x=1825790396;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pqHXzbOhYuRGj/Bl13+tRoGNuTsjBjBqO7+I+0basQ4=;
  b=fW3HY1F1+8QI3oLJ2aTZoir4ns4RuVrOl5xNIF9cZkvznlbpfW8QQs9G
   lgDJDlqYdoKvpDA21BSFatMNNCYBWvZIpgVWW7pPkmEzg2B9/g+2YoY7R
   oyQ5AQEcO6LWog1FYeMg6KZ3NeBg7hwshiPMj6uqRkrUM7XRd9KkUjkYi
   uRIi6cyHT6X+ejKyCb7YPbyj1V8NUj08we+xgtZNLyPU/zeeFvmWv3FO/
   LH5NIc7+qQQyhX8oZ84CVTpkpdgp/qpVvg7rYUWTI6u+O1qskDAzMfnSt
   2oU9OsqEP2NFOQCRZvHtMEhreFgxaNkLJ9+CpuhmqCnBN8rpXOQWHJ/Mg
   w==;
X-CSE-ConnectionGUID: 8nnLC8T+TAq/br4S2g/Ocg==
X-CSE-MsgGUID: eabRaVcfQN+Z2EQWZRGCtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="2986559"
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="2986559"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 11:59:54 -0800
X-CSE-ConnectionGUID: MNYuWUt4Qq++68v0QJ94gw==
X-CSE-MsgGUID: 8pAMkb8tRu+PJqHfW5sNVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="8090655"
Received: from spandruv-desk.jf.intel.com ([10.54.55.20])
  by fmviesa005.fm.intel.com with ESMTP; 09 Nov 2026 11:59:53 -0800
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
Subject: [PATCH v3 1/7] HID: sensor-hub: Synchronize callback removal with raw events
Date: Mon,  9 Nov 2026 11:59:43 -0800
Message-ID: <20261109195949.384888-2-srinivas.pandruvada@linux.intel.com>
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

Raw-event processing holds pdata->lock across callback lookup and
invocation, and takes dyn_callback_lock during lookup. Removal must
prevent both active callbacks and future lookups before client state can
be released.

Take pdata->lock before dyn_callback_lock, matching raw-event order,
and unlink the callback while holding both locks. This ensures active
raw-event callbacks have finished and prevents future lookups.

Fixes: 401ca24fb34a ("HID: sensors: introduce sensor framework")
Reported-by: Semyon Maryasin <simeon@maryasin.name>
Closes: https://lore.kernel.org/all/CAM2dg7ewfVJSP4rFyhkCB1Rmd1+X56sAg=eUdbPthG2xrLqwQQ@mail.gmail.com/
Reviewed-by: Joshua Crofts <crofts@kernel.org>
Tested-by: Semyon Maryasin <simeon@maryasin.name>
Tested-by: Zhang Lixu <lixu.zhang@intel.com>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/hid/hid-sensor-hub.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
index 81c8e723f9ba..98ae5352e2b6 100644
--- a/drivers/hid/hid-sensor-hub.c
+++ b/drivers/hid/hid-sensor-hub.c
@@ -173,7 +173,9 @@ int sensor_hub_remove_callback(struct hid_sensor_hub_device *hsdev,
 	struct sensor_hub_data *pdata = hid_get_drvdata(hsdev->hdev);
 	unsigned long flags;
 
-	spin_lock_irqsave(&pdata->dyn_callback_lock, flags);
+	/* Serialize callback removal with raw-event callback execution. */
+	spin_lock_irqsave(&pdata->lock, flags);
+	spin_lock(&pdata->dyn_callback_lock);
 	list_for_each_entry(callback, &pdata->dyn_callback_list, list)
 		if (callback->usage_id == usage_id &&
 						callback->hsdev == hsdev) {
@@ -181,7 +183,8 @@ int sensor_hub_remove_callback(struct hid_sensor_hub_device *hsdev,
 			kfree(callback);
 			break;
 		}
-	spin_unlock_irqrestore(&pdata->dyn_callback_lock, flags);
+	spin_unlock(&pdata->dyn_callback_lock);
+	spin_unlock_irqrestore(&pdata->lock, flags);
 
 	return 0;
 }
-- 
2.56.0

