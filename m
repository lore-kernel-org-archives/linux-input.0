Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794254397;
	b=Jw3sqxC7X8qeEF5EjQ9Ie+XGmMaPFhyaOdBUb35mbDEwRP6x2jxOCFKdSOXa/Og3m+Sf
	 yxX6y0v6iMOJMZ93h44ctU3BLFIpHf17+AONu55g97opFlarGgsJ+Cfg9rPdKxUBSCwO/
	 Z+/ZySYz4ifuKQFH2bihwV0/fYxBrU3Z96ENVfHvB/ugd74mDFAQL90Md0DVlNDmlrrEO
	 zuMPNtAcbahvjq+50ShSjwVaJhkAUB9TPOx4aPxR5R7LQmroROvH79tc5DMhwHKtL94C1
	 ASIW9IG7Rk+kfcjpQuInaAqn1kwW4pLGDhvbl3v0ybAmKgvT2uVuJz3gmGMqBSWBssw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794254397;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=E6ZM8eCSRqXyF2S7mN6AOzvccTBTYeL/LvlpvXWk/68=;
	b=WoV7EDtJreHUND+wWqW3Dfqio8QZrSDnbzhCUu9+n7QzI6HbJMuHgObuEsg87a1nZqbu
	 CUl2OVQRjR6GUaVAPUB+k4bvkfA5nI1qED4QwhAybU1rYIQeupMmGez2aB6do+wKWnQjK
	 XEow98CAwjv6m+ACRmTK1Wgcd/g2EyPvEjry9nGfemSsbbvH0JCCDrOcxhbiqHlF7ooC+
	 VpbP0K8NGntZvz2G8EjWbaB0NU+gdzrurXvIgO3tnkl1bBg9tiSuE9QVo+kv6zG07Pkuj
	 bZtL1xTxPQ+ArXOqMtvUOGZOq91ax3708fqGu0t2mwd3GpmhxuDdCJ+l8wdp/CvemAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dBSpOwCn;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B54260A2601;
	Mon,  9 Nov 2026 19:59:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B54260A2601
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dBSpOwCn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794254398; x=1825790398;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YjAQkNgnqiQWrokfZj4Rbpr1oo88Lx7XNyLDorA28hY=;
  b=dBSpOwCnjnWfhhgE99eo+fEYDgDCN0wzqSYjNAWUHQj11BxOy9N+kS1e
   oj7cWYNlyvoTtNxWCt1VH0Nwczy4Xbx7kGKNzkGUnpv1L3HdbmRT7pGQ3
   MzUMeB2JoxjfffASVXbRi71JX0uMTSvtSdVP6epx9ZLh6M4WVXV1v5DLW
   eKRf8pWNAKsrQrKPSdwoud476fYH+plP08G/gnygLAXx3i+jPF7OckjO6
   qNe3Bj+BbuZaQspZRBDqDbuSpeTRc2a1a+ni4bliOBUq1H7ujcMH4qaxd
   ThdhKgA+HlYP12LXPf+45TU34/hv6guqPogltxHK+MyPAdP3wh8acLj+M
   Q==;
X-CSE-ConnectionGUID: 4q3CDqBVSnO1wcVB0nOhWw==
X-CSE-MsgGUID: yR9d7fwOTt25AJ9gX7SrkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="2986575"
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="2986575"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 11:59:56 -0800
X-CSE-ConnectionGUID: QHy/Pq64RHij5bJfWNkYcA==
X-CSE-MsgGUID: HEHWxVx3RfG6LBMqET1oXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="8090670"
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
Subject: [PATCH v3 6/7] HID: sensor: custom: Register enable attribute after misc device
Date: Mon,  9 Nov 2026 11:59:48 -0800
Message-ID: <20261109195949.384888-7-srinivas.pandruvada@linux.intel.com>
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

Register the enable_sensor sysfs group only after misc-device setup
succeeds. This prevents userspace from opening the sensor hub while
probe can still fail, which would otherwise leave the hub open reference
unbalanced on unwind.

Fixes: 4a7de0519df5 ("HID: sensor: Custom and Generic sensor support")
Reported-by: Semyon Maryasin <simeon@maryasin.name>
Closes: https://lore.kernel.org/all/CAM2dg7ewfVJSP4rFyhkCB1Rmd1+X56sAg=eUdbPthG2xrLqwQQ@mail.gmail.com/
Tested-by: Semyon Maryasin <simeon@maryasin.name>
Tested-by: Zhang Lixu <lixu.zhang@intel.com>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/hid/hid-sensor-custom.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-sensor-custom.c
index 55698dea5b86..8a71e86d247b 100644
--- a/drivers/hid/hid-sensor-custom.c
+++ b/drivers/hid/hid-sensor-custom.c
@@ -1059,20 +1059,19 @@ static int hid_sensor_custom_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_remove_callback;
 
-	ret = sysfs_create_group(&sensor_inst->pdev->dev.kobj,
-				 &enable_sensor_attr_group);
+	ret = hid_sensor_custom_dev_if_add(sensor_inst);
 	if (ret)
 		goto err_remove_attributes;
 
-	ret = hid_sensor_custom_dev_if_add(sensor_inst);
+	ret = sysfs_create_group(&sensor_inst->pdev->dev.kobj,
+				 &enable_sensor_attr_group);
 	if (ret)
-		goto err_remove_group;
+		goto err_remove_dev_if;
 
 	return 0;
 
-err_remove_group:
-	sysfs_remove_group(&sensor_inst->pdev->dev.kobj,
-			   &enable_sensor_attr_group);
+err_remove_dev_if:
+	hid_sensor_custom_dev_if_remove(sensor_inst);
 err_remove_attributes:
 	hid_sensor_custom_remove_attributes(sensor_inst);
 err_remove_callback:
-- 
2.56.0

