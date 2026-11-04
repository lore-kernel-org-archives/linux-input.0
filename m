Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793823256;
	b=dDL8B4Aj93nvGAwiZ2ZnLXyrMumzC7PygARHxRypa/b7sRMYDKSBlpR+ZkuU7bX/W2nB
	 A+RKpDMkkYCVfaf/ZjBVryoXn8EBuen9mctoREEUsmUNgrJ0+L4k+o5C0epcLhEiXRq0h
	 7ZLIVmXJMP2DI1hmwLxoI5K+zAY5cotvbxWu5636kQ6TncZ8ucWIUmhieKbbReb4ew3Sz
	 o5xaK0Qc1DWKwFHj3FjYpbzemfCRZgHVpAUAy58qK58hmaKJwQCvNJhHdKV3LXscrkKfA
	 FYwnh1yj1dv2IohygM+NqjJfsLBVqoMY++A/6+lXctu9W7hTdi+M3DSYMgvXJuX1P/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793823256;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=DXRtStgff2NhPeEvi9r/HYumLTPpIAEJNyO2psSLMlc=;
	b=35P9NH10RAyTclv0/PM34v9HIzS+dJNqsIYBGu7OYuBAH+X1SO83W4Rap7hd81pIsNr4
	 n9abHiDp0lv2IAiyLgQ/8juHbDGp7dFC4uMCNnvSK+HGf/S1eUON91eh6lIPQ1rViinzz
	 uCSkVRFNNEYRU2hMveCMT3U3aFqHRBsn+waoLWe7DBoAfzrpqadr29H2W1764SJKDtdV3
	 p2rdahbr55qzAwYNHN3ahQ0AZTKuONbqTaJcGl6lhYf/9d9b8nifjZ49sCCs9HRQ8zO6m
	 4w5hd/EYX0NmsIrVs9pmsumpbP8+Vr5qKGnZApsbvcK7ahfwHCd7LkSjghkvt02OoGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=j1ET+RsG;
	arc=none smtp.remote-ip=198.175.65.16
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5703E6082094;
	Wed,  4 Nov 2026 20:14:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5703E6082094
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=j1ET+RsG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793823257; x=1825359257;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9FqH/MH0ZFOtybQUlNdiLpOfaIWTS4J5aHgzdABr5Rw=;
  b=j1ET+RsG5RUJsD5lDxL1rQXvVPYyeAii+wPK75QymakBkEH1yFEtx6B/
   jXM0kYAmRWSPRztUIMNVcQnalO77bixbz6CmKBJ1IlHrTLdxiD86dRzKM
   k3xu2CsHyfMP9W1/ZRdyt1hE5S5zZ5Uidd9dMOedaSWis16rTB5zQ+8Y6
   pBoDDGfaljxZ69Vf0SVFecRm9XLC8W8ky9oU8uagjcIQGw8q4lnadjHTS
   hcm1c94DMW6QITAXyj0bfv7ZvOb3jxixvaHIPcWXG9CF1GXYx56E/gvRH
   2cZVFVQpJWMGuu1tcsI/INd2CPv6Bg5dtByRNE3KdxEpfy77B1EKNKSZD
   Q==;
X-CSE-ConnectionGUID: uW14ovm+QRik7xN1TNCJ2A==
X-CSE-MsgGUID: OTrAieCqRb6ZdsKmRQ+Q7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2589132"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2589132"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 12:14:12 -0800
X-CSE-ConnectionGUID: SSlMe7nYTUGT++4kgzGxxA==
X-CSE-MsgGUID: muVZCKvcRCSev61Bv+OLkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="6925649"
Received: from spandruv-desk.jf.intel.com ([10.54.55.20])
  by orviesa009.jf.intel.com with ESMTP; 04 Nov 2026 12:14:10 -0800
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
Subject: [PATCH v2 7/7] HID: sensor: hub: Remove clients before stopping hardware
Date: Wed,  4 Nov 2026 12:14:03 -0800
Message-ID: <20261104201403.2039921-8-srinivas.pandruvada@linux.intel.com>
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
Reported-by: Семён Марьясин <simeon@maryasin.name>
Closes: https://lore.kernel.org/all/CAM2dg7ewfVJSP4rFyhkCB1Rmd1+X56sAg=eUdbPthG2xrLqwQQ@mail.gmail.com/
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/hid/hid-sensor-hub.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
index 0c4884c5821f..e9d6eb3b3831 100644
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
@@ -806,7 +807,14 @@ static int sensor_hub_probe(struct hid_device *hdev,
 
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
@@ -820,8 +828,6 @@ static void sensor_hub_remove(struct hid_device *hdev)
 	unsigned long flags;
 
 	hid_dbg(hdev, " hardware removed\n");
-	hid_hw_close(hdev);
-	hid_hw_stop(hdev);
 
 	spin_lock_irqsave(&data->lock, flags);
 	device_for_each_child(&hdev->dev, NULL,
@@ -829,6 +835,14 @@ static void sensor_hub_remove(struct hid_device *hdev)
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

