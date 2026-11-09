Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794254398;
	b=Gzt8v3QNynZIfoAYcrRlJY/XMN/tXZyJmsz3cARrkJE8+ik64GG9pOf3wjEOtO29D0Kb
	 brsQMEH0Nl+vKu+IvYkJLPGI0gIhZ5dsyZnD3uylcFGa0P8OQUAA+7dGxr0eGjv28ZQOi
	 oLIqA4HyioNbjR6jH9ppQljA56KjBVMDfuRzExKTM5H77bJFBRQvEPcbQ7kk75P7Ktx9k
	 TGltvw2pl+jtUlPteErdTesZNsAtxRHnBkiV6GFG5oC98/3oFoX6Me14tu1jitVHy1iNb
	 2ehGqdijqrwwRZ+QxuqgMeI8gsMmtzsFrVcvziP9mQGObBf8AgP3HPFFvxskIcgx6/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794254398;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0+/fQ8RhUk0g3NV9tDrsYd5xAskBmzsDwmui/QUKhtQ=;
	b=mnC5n5KyNYAZC89dFA3MmDm4ROiEmGqQxmzglST1/03ib1AscGNBEQUgdtdWyNbtaF/7
	 1eNqhjp9oaDY+1MGl4C0raPVUdavOadBgchsUEK+6/XPWilelFrHXln/mRSyVaOtuqIRC
	 VWsiSsL0FcA8iCpSgTHZeGDu2dbP0cjFbWmfM2vTtTVetK8Wl/fY5jx8mYFkhyGeF61T6
	 MFO+N3HU7pZX/BJvBK2eK4iKpW42sHv6dEUIs1o/6zWE2wrO4ZUsgM8LE7kq5xQfEEM/m
	 yfTAAIORrQ/byBfraRPLkmKmU5puYhs4NcL/HEcGACtGqfgfYPPKNMrDVEBRrfnMGDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cNSd1RKM;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B435660A2625;
	Mon,  9 Nov 2026 19:59:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B435660A2625
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cNSd1RKM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794254398; x=1825790398;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=43FdOYVYaLYdH/YhTJIRaOkpMw1ayW6UOOxfrtGVnBs=;
  b=cNSd1RKM76b2Wb7SKuNy33KBPf3pPZ0Ez3QqlJIP7yZw0650K0dP1QCH
   L0TQ7T21xldvzXXP6nsk1YQ2MOXo4okcpuUxQ0B7njkDj5bKys8jQu8nQ
   r08TvBRIrmOPFLsF/BogNOKWYyZUeGZmpX5j7GRwls5BYftQnPy9cRiG0
   pzExkdHy8XyJcIDuLuPq+joUbkPayFRbp+uAUZJ52a1KqccbpOINBQBQ0
   QDHhwMRcMMJG4kxghcimwjaa4CiB/j1lZwONIIWujUB7mNbmmfZGpTqvn
   9j/L2CviDrTT5S93FzCsM5KT3z3NrS7/cKYXXS1CdQEz2fsCnJmFfs2co
   w==;
X-CSE-ConnectionGUID: V3K/FNLjS1WIPrh63EbQsA==
X-CSE-MsgGUID: vkDjejxZRCmeTRJyYSexWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="2986578"
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="2986578"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 11:59:56 -0800
X-CSE-ConnectionGUID: DfcKyMnsQIK8wm4oa8xNWw==
X-CSE-MsgGUID: lYQLSib2TlWtrKqHFGTYhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="8090673"
Received: from spandruv-desk.jf.intel.com ([10.54.55.20])
  by fmviesa005.fm.intel.com with ESMTP; 09 Nov 2026 11:59:55 -0800
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
Subject: [PATCH v3 7/7] HID: sensor-hub: Remove clients before stopping hardware
Date: Mon,  9 Nov 2026 11:59:49 -0800
Message-ID: <20261109195949.384888-8-srinivas.pandruvada@linux.intel.com>
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

Remove MFD clients before stopping the HID hardware so their close calls
remain valid. Runtime-PM teardown may cancel a pending autosuspend without
running the client suspend callback, leaving hub references after child
removal.

Clients share one HID open while ref_cnt is nonzero. After removing the
children, drain any remaining references and call hid_hw_close() once if
the count is nonzero. Then stop the HID hardware. This avoids both a
leaked open and the underflow caused by an unconditional close.

The pending-request walk runs before hid_hw_stop() disconnects HID-core
children such as hidraw. Skip non-platform children and platform children
without sensor-hub data before checking pending request state.

Fixes: 1df3a401154a ("HID: Delay opening HID device")
Reported-by: Semyon Maryasin <simeon@maryasin.name>
Closes: https://lore.kernel.org/all/CAM2dg7ewfVJSP4rFyhkCB1Rmd1+X56sAg=eUdbPthG2xrLqwQQ@mail.gmail.com/
Tested-by: Semyon Maryasin <simeon@maryasin.name>
Tested-by: Zhang Lixu <lixu.zhang@intel.com>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/hid/hid-sensor-hub.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
index 98ae5352e2b6..2a7f2475171f 100644
--- a/drivers/hid/hid-sensor-hub.c
+++ b/drivers/hid/hid-sensor-hub.c
@@ -10,6 +10,7 @@
 #include <linux/slab.h>
 #include <linux/mfd/core.h>
 #include <linux/list.h>
+#include <linux/platform_device.h>
 #include <linux/hid-sensor-ids.h>
 #include <linux/hid-sensor-hub.h>
 #include "hid-ids.h"
@@ -803,7 +804,14 @@ static int sensor_hub_probe(struct hid_device *hdev,
 
 static int sensor_hub_finalize_pending_fn(struct device *dev, void *data)
 {
-	struct hid_sensor_hub_device *hsdev = dev->platform_data;
+	struct hid_sensor_hub_device *hsdev;
+
+	if (!dev_is_platform(dev))
+		return 0;
+
+	hsdev = to_platform_device(dev)->dev.platform_data;
+	if (!hsdev)
+		return 0;
 
 	if (hsdev->pending.status)
 		complete(&hsdev->pending.ready);
@@ -817,8 +825,6 @@ static void sensor_hub_remove(struct hid_device *hdev)
 	unsigned long flags;
 
 	hid_dbg(hdev, " hardware removed\n");
-	hid_hw_close(hdev);
-	hid_hw_stop(hdev);
 
 	spin_lock_irqsave(&data->lock, flags);
 	device_for_each_child(&hdev->dev, NULL,
@@ -826,6 +832,14 @@ static void sensor_hub_remove(struct hid_device *hdev)
 	spin_unlock_irqrestore(&data->lock, flags);
 
 	mfd_remove_devices(&hdev->dev);
+	/* Clients share one HID open; release it if references remain. */
+	mutex_lock(&data->mutex);
+	if (data->ref_cnt) {
+		data->ref_cnt = 0;
+		hid_hw_close(hdev);
+	}
+	mutex_unlock(&data->mutex);
+	hid_hw_stop(hdev);
 	mutex_destroy(&data->mutex);
 }
 
-- 
2.56.0

