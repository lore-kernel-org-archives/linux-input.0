Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793823256;
	b=dER7h7coqv1O8IQNydeRmU601N9ddKEMbs5s/qdRaV2iF0nTOOn0yNJ3scMlNUS6GD8w
	 CcoqBtk5kpz/LoAwQ9428Xb61uqFRRyGrSHKNCwtvynYtjwQKhMNC6aUg47+gaY9hvBRT
	 FTVyfY1hBGNdsf5RNaaA8rDrtqioKr1FrY2znj4Szt2IiIvlflTc5AifThfbyIO6VTq2f
	 sn/yQg2YnZiXtDYn4v7mIIlshhkKwGeNM1pTdx4ZzeoYmhZKt2EVoBOzo3PsETI7R4mu0
	 MepBldOZMFvMSn2Nun0TfLm4vqVvbYQw5bywdJlLg6n+ohxBkqbwobxdace9fOkd6sQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793823256;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=SJxTff1cMl7QHSZKQBQyxRfAMcM0E6EFnbRLNF1w36k=;
	b=wyAbYFYWEnz+kwizxbO8IMdD0TTQ/TWW7PxfvrApi/bSweTZ5c3Jjaj++F3vY+7HGxnM
	 oF3VkLpuhWYFWuyFDZMwzg0b89ys6JFe5/1OmXdZ8PN/pI639PtaXxzRXGxhhZch7GXqG
	 GCIk1kytsllJ9ey4T9zQLJ3fpjfq3TNVZnbMT2G8Dqlcu7JvfkuIduis68y2OFzHUee4L
	 sO1pOyEz1l2BLNf+ouyymoxKIoGRZok8kMPlsAxZs5h5aSuo+gD4vAcxBTeghc0H38fUh
	 3sVZJj1YIqQgkexGyqm0PQisw1L+RoppiJEK07YL3HScn3eKrYejta+LJjJyDU+J8hQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SL8QvN5e;
	arc=none smtp.remote-ip=198.175.65.16
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA165608208E;
	Wed,  4 Nov 2026 20:14:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA165608208E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SL8QvN5e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793823256; x=1825359256;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=in0N51fR+aemM5cbXmGXf2Ms35YjLvsrUGcBRLxHtNA=;
  b=SL8QvN5ebnH8+0Vq6qzse7jE+Aer+ZpihLCpOazOMAMXn9N3Xk2ylyWn
   6AprAulkiI3jhyTnKT1hsjFxh3sw0HyUm8eQaG7CHcSxVF8B0jqXvpAWx
   +SQ7d2vcKfUq/tU2P9HWiNgkN1HgqUE8My4/tpf8Qg4mBGcgcts7gAXnK
   IA3Dj2SEJlqpcyfF8m921DnDbrL3S9imiRfL2ff4WwRgHxeGgOD5IxCE9
   v02aLxkBx6seNjFvtD4sR/WRwC8AJbH0MrW/oERWnNWO6aAiYV0ZFUaZN
   Cl2aDGzOkrfHPoBNEZzbG9OXP5+dgYT0KU1NllPq4mI/qYw92qaqrp8eN
   g==;
X-CSE-ConnectionGUID: ZFLrl+CdSOGa68XpChZ2Xw==
X-CSE-MsgGUID: ew+2uCqVSPO4hrKhGF2Npg==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2589117"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2589117"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 12:14:12 -0800
X-CSE-ConnectionGUID: ssh/SjEeRbymSkJgDHWq+Q==
X-CSE-MsgGUID: azW72UW1Q+C6QehY/NGk5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="6925634"
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
Subject: [PATCH v2 3/7] HID: sensor: custom: Disable sensor before hub close on removal
Date: Wed,  4 Nov 2026 12:13:59 -0800
Message-ID: <20261104201403.2039921-4-srinivas.pandruvada@linux.intel.com>
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

When removing an enabled sensor, set its power and reporting states to
off before closing the hub. Keep the field descriptors alive until the
state update has completed, and release the hub's open reference.

Fixes: 4a7de0519df5 ("HID: sensor: Custom and Generic sensor support")
Reported-by: Семён Марьясин <simeon@maryasin.name>
Closes: https://lore.kernel.org/all/CAM2dg7ewfVJSP4rFyhkCB1Rmd1+X56sAg=eUdbPthG2xrLqwQQ@mail.gmail.com/
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/hid/hid-sensor-custom.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-sensor-custom.c
index 72e5639cb1d9..8375697b459d 100644
--- a/drivers/hid/hid-sensor-custom.c
+++ b/drivers/hid/hid-sensor-custom.c
@@ -1053,6 +1053,13 @@ static void hid_sensor_custom_remove(struct platform_device *pdev)
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

