Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793823256;
	b=ZwP45OJCv/hLjcJpNFpbXiClGjDzWdVvLKSZKJEI380Kzk2ikd2H05S5Mbp7IW5qQebq
	 hiEoc03FXyMY583VejdVgfGMB/bzzSXP0yldbcgR+I4Vw2rNF/j1ZOFwHIEqSE9SNhEtV
	 FvSErxnmxsnyP+4aY7Ie0zB2tSB08H8XiVSpZZF2mvI0qoJ8+z8xcWah4iggJjwGKePJA
	 z7O/QzwNnqJnTnBi48eVwcdVWlwFC8HTuuRq6Q19S8owVbUvfoJVtE0q/Xjg/5vhdPUcO
	 P/R4ihz0/wRB712OgFwLnTdVvgtrF1QY6CvurWzLsnfjApojs4lsFtF7OgNbNhBvrXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793823256;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=OgRGvmUx7uk8pVmP19CHmw4IhEOHVOUA7ldfY7DOSxI=;
	b=v5XNKfYr8EIhfiSv9BDct+HeQhUyx4xhxFVO5lDzFlDQETwt+1QlpOedZeNCkKaP6amD
	 752/OxLzb0muEGRuhG6Kd3UJ2EM5bFX1VCRMQ1Qjz/dANARhVntMgjDaSCWBA0WucaJzt
	 ykjQOzTvUuOPXuMcGoYMBvoTykco8bea2gn4nzI0CDZqKGbNvwDRomGkjh1lm5cKE+luA
	 ApUrJbL9hoJU54YxBp3NQap/Lk4CrZrx985KDEkHgg3hPWzqgyA27qlI57gf0Nqf2kpjk
	 Znf2mhXwWOqXLs1uikbgP5zCWq1c3GtSn6EONZGjG393mjPU/ABpP/jkEHGazgbIl1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FPcoxekl;
	arc=none smtp.remote-ip=198.175.65.16
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2D46082086;
	Wed,  4 Nov 2026 20:14:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E2D46082086
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FPcoxekl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793823256; x=1825359256;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rhmx5udTRazYVZoAMNbrpnROGVpbY1SPo6xRqKtKU7I=;
  b=FPcoxeklg43k3pFSPGs3MyMPAPR8IhpMP9PkjZ9Rrog3pgzzH+t4fpBu
   oWnAM611xxLGk8G0t97ymez4ohgd2xMxzA4RRJs2iw/G+SzoJ043xBDBQ
   O0/aVr0Wj/hSuxKQhL1AKTi3+Z8baxXPwvStvVpJ1ZXlf9DKcqISXNT57
   a0OxIBJWf+x308vUZGys1RJvim6r2H21YI7FvcQSxfI6s9WpXijxNpX44
   ju+NIYhh8NXky4nngfFT/CStmKuR79C7CWSnhzf0+PBo/tB/WlqlQYUiU
   KcuwF/7PGk/Itq9r54eGLLR0myKiwr/ORfnaGl6Nb2ln1pndxP3+fFCR5
   A==;
X-CSE-ConnectionGUID: VC57CE0FREmgEFl6v5jSqQ==
X-CSE-MsgGUID: Jy8yC4BMSKiF2pAbDFchEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2589127"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2589127"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 12:14:12 -0800
X-CSE-ConnectionGUID: pJ/gRLe1SSezL5IZREKUaA==
X-CSE-MsgGUID: nUtdDqjySbKMWvzMU0+jSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="6925641"
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
Subject: [PATCH v2 5/7] HID: sensor: custom: Serialize misc device reads
Date: Wed,  4 Nov 2026 12:14:01 -0800
Message-ID: <20261104201403.2039921-6-srinivas.pandruvada@linux.intel.com>
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

The misc device permits only one open file, but threads sharing that
file can still read concurrently. Serialize readers to preserve the
single-reader assumption of the FIFO while keeping removal independent
of a stalled user copy.

Fixes: 4a7de0519df5 ("HID: sensor: Custom and Generic sensor support")
Reported-by: Семён Марьясин <simeon@maryasin.name>
Closes: https://lore.kernel.org/all/CAM2dg7ewfVJSP4rFyhkCB1Rmd1+X56sAg=eUdbPthG2xrLqwQQ@mail.gmail.com/
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/hid/hid-sensor-custom.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-sensor-custom.c
index 2a3b502821c7..4f824cadd370 100644
--- a/drivers/hid/hid-sensor-custom.c
+++ b/drivers/hid/hid-sensor-custom.c
@@ -38,6 +38,7 @@ struct hid_sensor_custom_field {
 
 struct hid_sensor_custom {
 	struct mutex mutex;
+	struct mutex read_mutex;
 	struct kref ref;
 	bool removed;
 	struct platform_device *pdev;
@@ -668,25 +669,39 @@ static ssize_t hid_sensor_custom_read(struct file *file, char __user *buf,
 	if (count < sizeof(struct hid_sensor_sample))
 		return -EINVAL;
 
+	if (file->f_flags & O_NONBLOCK) {
+		if (!mutex_trylock(&sensor_inst->read_mutex))
+			return -EAGAIN;
+	} else {
+		ret = mutex_lock_interruptible(&sensor_inst->read_mutex);
+		if (ret)
+			return ret;
+	}
+
 	for (;;) {
-		if (READ_ONCE(sensor_inst->removed))
-			return -ENODEV;
+		if (READ_ONCE(sensor_inst->removed)) {
+			ret = -ENODEV;
+			break;
+		}
 
 		ret = kfifo_to_user(&sensor_inst->data_fifo, buf, count,
 				    &copied);
 		if (ret || copied)
 			break;
 
-		if (file->f_flags & O_NONBLOCK)
-			return -EAGAIN;
+		if (file->f_flags & O_NONBLOCK) {
+			ret = -EAGAIN;
+			break;
+		}
 
 		ret = wait_event_interruptible(sensor_inst->wait,
 			READ_ONCE(sensor_inst->removed) ||
 			!kfifo_is_empty(&sensor_inst->data_fifo));
 		if (ret)
-			return ret;
+			break;
 	}
 
+	mutex_unlock(&sensor_inst->read_mutex);
 	if (ret)
 		return ret;
 
@@ -1014,6 +1029,7 @@ static int hid_sensor_custom_probe(struct platform_device *pdev)
 	sensor_inst->hsdev = hsdev;
 	sensor_inst->pdev = pdev;
 	mutex_init(&sensor_inst->mutex);
+	mutex_init(&sensor_inst->read_mutex);
 	kref_init(&sensor_inst->ref);
 	platform_set_drvdata(pdev, sensor_inst);
 
-- 
2.56.0

