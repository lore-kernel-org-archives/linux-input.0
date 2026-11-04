Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793823255;
	b=dR+29dxyu50rwtXLSFJvn2LGh+ixjaUSIafy18R+jax2scLf4v4ptrEjjk+2OjOZ9BUW
	 IFMUdHzlbSZH1SSpGaNo2CJahR6Ti2a6Z/jpRR9gXcjGruwXnAtDIItz2fkR+rDR2DG5z
	 6NrMri9zWC8pNerPqpcZooqgBFt9Ett4AOnoySBxSb/oJ/Lsk209rcGhUbXCuLC7iuDE9
	 QEWkyMhYWraPvnojTZqWDWex178yoXT2Nj3xUbnbLHlOa217TKuME7uXZK2ib+kHaLyvG
	 xJtWBuDEMW8FgWO1Kxo3qj5L1yH78pMGM3/trid9BWzdaRfCFbZ8QlrRtaf/QDtqeaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793823255;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=+XhnkO/jaX2+F+V1+b+f12fn6p8V7sKwIgSwZYe9g0E=;
	b=Yln5zvawCuVN6lmlttmnCVBAnYzdf3MVJK1poKwZjPcKndZ9eouzq9SRiaZvEhtlzDHB
	 w9rn/4t+XatsFmBHBP/xPqYfCk3ddFERn9QoGnPq/hBUlKuAiuVm7pNuWGeIjPVKYKwEw
	 +tJUgR1zvvjtL7UX7e6/V7PqHQbWn0HfohfoO1AB592RxYEA1wCZ5e09cERexrVFSrVRF
	 uZ318fVRziIe3y+n9ZZ+6Pq7KFEOYYpAQ2PzAJCfr1y/wv3oaY+Zf1TKZlBOBRuFnp14l
	 aaIs9BTyMwbirdkoR/eGYgKrWNucbYKixDU2vf9DlwSXQh0tAcVFDRCCLjB+esJl0Ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ikOF5zdS;
	arc=none smtp.remote-ip=198.175.65.16
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6E0608176E;
	Wed,  4 Nov 2026 20:14:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF6E0608176E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ikOF5zdS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793823254; x=1825359254;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qpZdBR620/UVypipUZjg/2IHhTj8BgeENBuaCqCsLmM=;
  b=ikOF5zdSzHvb3fi4WcQtoeiPYVIyepMTfGuPoDw3j2yORNtT3ARrIKkz
   15nTmB3zy2VUiwD2+yeNJ6nUUijOd4YQZUSwjSLHQtlhFUWsi0qQKI87n
   2bNGUIL4fE9iMekkdOWiF+mKCqLpG1fbhkGednwqQmWbhgsrOGfmzCKTc
   2qm0R0GjPrhSbseJnxoODl+VLuygpgHMKHhAE68MqArdRb6MOayiDTlyb
   D39vTbowcBpshoMWkO0NToCstLjv17CjXiIVACw/VsshK+XrNoiwOZJ6g
   4NJyed61gazkYe0ej6oFoeYc73r/S38mzwItreqWxVrGClQmBDUKUt+yr
   w==;
X-CSE-ConnectionGUID: lNgV6q9AT8GtxytvpEj59w==
X-CSE-MsgGUID: fu0VXpotRdqhOrbXw4dHVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2589110"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2589110"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 12:14:12 -0800
X-CSE-ConnectionGUID: j31sdCJfQK6focoSXHBxrA==
X-CSE-MsgGUID: DLJmGu9hRciiRyC7aAPSNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="6925627"
Received: from spandruv-desk.jf.intel.com ([10.54.55.20])
  by orviesa009.jf.intel.com with ESMTP; 04 Nov 2026 12:14:09 -0800
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
Subject: [PATCH v2 1/7] HID: sensor: hub: Synchronize callback removal with raw events
Date: Wed,  4 Nov 2026 12:13:57 -0800
Message-ID: <20261104201403.2039921-2-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261104201403.2039921-1-srinivas.pandruvada@linux.intel.com>
References: <20261104201403.2039921-1-srinivas.pandruvada@linux.intel.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Raw-event processing holds pdata->lock across callback lookup and
invocation, and takes dyn_callback_lock during lookup. Removal must
prevent both active callbacks and future lookups before client state can
be released.

Take pdata->lock before dyn_callback_lock, matching raw-event order,
and unlink the callback while holding both locks. This ensures active
raw-event callbacks have finished and prevents future lookups.

Fixes: 401ca24fb34a ("HID: sensors: introduce sensor framework")
Reported-by: Семён Марьясин <simeon@maryasin.name>
Closes: https://lore.kernel.org/all/CAM2dg7ewfVJSP4rFyhkCB1Rmd1+X56sAg=eUdbPthG2xrLqwQQ@mail.gmail.com/
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/hid/hid-sensor-hub.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
index 6470a290ebfc..0c4884c5821f 100644
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

