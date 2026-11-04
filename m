Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793823257;
	b=3k7M+Z2J9jDtbSLmk83qcI5qgKVhhPCi+xj+UUpE5exe73Lh6mm47OdzzqXFQOEY9B5v
	 xh0Mm+ORDKLrcL1D3vcKUF1bk+mfeh1HEhI3qU+c5S5RheBLN1ZZXSQ3NwW0DKfdarepa
	 /3pesgI62PUKd6UzKCOLM4TeaXIT2lrGm+s1+WAp3Ef3FWtEy+QZpPsVKcbVBj8l62mu4
	 OY5ipDdhbG5QVyEn9qPrS3OSLuFAM7376c7Lihx1xBh8FdRb0TRPcY9AuCAHP6WhF0MI8
	 gGwQG7+aQaqT9nQH4XOs66YFgPVRrZ18wZ5azBkOaymO7Ty3ziRs32Fo04/q7HbpUqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793823257;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=eqQq8dmGYRRqRQp4yAVUGHseGgWjhCKTxAZeDkjEQtA=;
	b=GBI1Vxw5UQMSRPO05t7dcCPbQIKNH/Bn/gG3GEQi47/M9AAv/rISaJ/IA+eUXQG07O1F
	 dGRn7Nnl7K7t0vVEyFlJhhbXzRebzNY00hL8NFzNMzkGqXzSd9gvYw7q94i/PQ6reqGQI
	 BNJwPx7qylHnJrkjchh01QJFny7wxZyYoEZTwaWjuPVtJeMK8lNNMjIQFJ4Fbt6UdiVzn
	 ASj6Pl0vUMDXktOa9Be48p+m/mh3SeyWJXw3+9QWlxBO2EBi8FSBkaoVWJmqiw+DSYu75
	 5ZtsbLBpt2+vfOO7heHsySDsow+LVU8NIkP4ev884X1NDPrsMppagyUPmIFCS2FmePA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aGFE2jiX;
	arc=none smtp.remote-ip=198.175.65.16
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D735608209A;
	Wed,  4 Nov 2026 20:14:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D735608209A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aGFE2jiX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793823257; x=1825359257;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xFFa7Mt2r5GaMuapKJpyWFY1nzxxk01wrie69D8nK+4=;
  b=aGFE2jiXAy1hzYTKsYr0tZJ46TGunGC+/IuKT7IZBoXIi/RprQJz3Z5m
   f6kxDsqS/QYotXl8Wc1oXrZcrasc33FCEN19X0F2Qyb2oyDJQwyo9ILyL
   EEcPPIzWhXB4cetFSZxhuJhPlPAUlrSVB0Qb37zPAKCidQ87RSvvB198d
   MQtm62EQMQohb/+lD9V4K9CZhqKiFHalhwgI8p+yVIiS7fcgbZjjTDaJY
   WfMNc/hKKzWAH3BLGn9i5eduxCp9PgCaQdaqtm61RJVcwqq5g/gnzt2Mb
   hOxcEtXSC2a8NsNq19xtMfNjTv7N75oVLyyRY4Gp6WzPkNyVhHrCNcIkx
   Q==;
X-CSE-ConnectionGUID: bh1uW6hzRWGdJIsXFcylRg==
X-CSE-MsgGUID: rrZjz6UKStiOzhOrUJHhvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2589130"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2589130"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 12:14:12 -0800
X-CSE-ConnectionGUID: H6GpwAGuTc+imNYfjj3Yig==
X-CSE-MsgGUID: OGouMnahRC6ljNFFa/C3NQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="6925646"
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
Subject: [PATCH v2 6/7] HID: sensor: custom: Register enable attribute after misc device
Date: Wed,  4 Nov 2026 12:14:02 -0800
Message-ID: <20261104201403.2039921-7-srinivas.pandruvada@linux.intel.com>
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

Register the enable_sensor sysfs group only after misc-device setup
succeeds. This prevents userspace from opening the sensor hub while
probe can still fail, which would otherwise leave the hub open reference
unbalanced on unwind.

Fixes: 4a7de0519df5 ("HID: sensor: Custom and Generic sensor support")
Reported-by: Семён Марьясин <simeon@maryasin.name>
Closes: https://lore.kernel.org/all/CAM2dg7ewfVJSP4rFyhkCB1Rmd1+X56sAg=eUdbPthG2xrLqwQQ@mail.gmail.com/
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/hid/hid-sensor-custom.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-sensor-custom.c
index 4f824cadd370..990e653995e1 100644
--- a/drivers/hid/hid-sensor-custom.c
+++ b/drivers/hid/hid-sensor-custom.c
@@ -1059,20 +1059,21 @@ static int hid_sensor_custom_probe(struct platform_device *pdev)
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
+	sensor_hub_remove_callback(hsdev, hsdev->usage);
+	hid_sensor_custom_dev_if_remove(sensor_inst);
+	goto err_remove_attributes;
 err_remove_attributes:
 	hid_sensor_custom_remove_attributes(sensor_inst);
 err_remove_callback:
-- 
2.56.0

