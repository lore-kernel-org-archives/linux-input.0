Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794254397;
	b=QwSQVYRQ4r/GDVX29/jqGzJk4jzezxfcFLpnCIac3Cs3z5dyIRzTFOwh8HnlKfzAaoDC
	 osFgsBb0tiZRDHFSfGl+P289Vt4VUQU3WIf2BKZYv8K/OZyfjPs44pHceoDFIeDHkrFl9
	 UlnK2E9ElSBZxj1Xsj6WjfYrZwxSS6w862ecrC31qoiZfePpbtPAHAkg6rS1aPQCj8cGz
	 29Ci+9otwRk1Tj6/5bVLPxDmMt6VkgZ8kyUQ1FKUM/OOuH7Kiv/szXgyG+JMwG6ZAjrOd
	 qHgf/8G+pE0cUqqdnS8AfBa6H79WdMQPYEWeyBYQHl5H2v80U2o2TVrbpZs3B7oFENw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794254397;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0UzDKqfwa2r5ec5KKQ4o/xZNiWi7hkOLFXRYSLKxED4=;
	b=cd/JkaduOVG9hW9Z/nvfvSyZbVc+Ia6xWD4ZHrb2tTPKo2EAzyqlh9IQDNxLoDm0zlyW
	 F7g95uj6wuyHP1ympv/D83K3DY40cObGtqNQfCC7HpaPi/6l8mS04ybY+XPwnh8QMz8+A
	 00xA9Tds0p8U9S4uCywKBCg7eaVBWBG+0rWN8nR6+B+ZLnAgdodMBlKNoJMF9OYAp0N/r
	 qpXvbYa8NCOhrpA7FM1J1OQH1s6MOgkmHnuo7SmcBjXo2q3XplocARAQa5J0eOszpEnHP
	 2/HtStZ5Ta4rhtaEuYdtz1+g9A3b/TqLcvWqZq4R6jP3BQF51st7zMRDzYdXopX4g2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ljC+dDhW;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169E160A261A;
	Mon,  9 Nov 2026 19:59:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 169E160A261A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ljC+dDhW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794254397; x=1825790397;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eGB+AMm9M27mzXD6gpp8FQ6PlvAILaWRGeb3KhEznn8=;
  b=ljC+dDhW+i3hJeYTVVGezC+pr2SJQ+BH8T6IrO8AoWgxmNa2qSTxIY7R
   9+fXEjQ6SelbQpxUIWdMJlz4OLWrcjwsYs1FRJAivy/JXWQDXbx+dGrVv
   cAZbcU9yH5OYuhosXYTj4ulrk6o3smxZksStd2faffKsYKzibsXHeC/Tl
   1QK0g45SUNhwTP0F4Vx+7nz0BiWGHqLIoijwmd1ltFuOtCEUO48J+tY0I
   hBBW1TQBPb6eOeb4vvxNVcdy9oPZhLcsSrIRFENP5kLbnJ1ZxB7sguKFU
   4j2jRKyWHRz2gKPNCRaROwxAaUMoJEIf3ovJpwAcEn7rTX2EIPKzldqmV
   g==;
X-CSE-ConnectionGUID: Me3dij5iSBmKH7YO/lBcHw==
X-CSE-MsgGUID: 9FOToN1mTbKdyrlVxEWFaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="2986572"
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="2986572"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 11:59:55 -0800
X-CSE-ConnectionGUID: tkjdM6/ATdm7hq1w7faPyg==
X-CSE-MsgGUID: 6buMhqDLTjefifzDniS9+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="8090667"
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
Subject: [PATCH v3 5/7] HID: sensor: custom: Serialize misc device reads
Date: Mon,  9 Nov 2026 11:59:47 -0800
Message-ID: <20261109195949.384888-6-srinivas.pandruvada@linux.intel.com>
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

The misc device permits only one open file, but threads sharing that
file can still read concurrently. Serialize readers to preserve the
single-reader assumption of the FIFO while keeping removal independent
of a stalled user copy.

Fixes: 4a7de0519df5 ("HID: sensor: Custom and Generic sensor support")
Reported-by: Semyon Maryasin <simeon@maryasin.name>
Closes: https://lore.kernel.org/all/CAM2dg7ewfVJSP4rFyhkCB1Rmd1+X56sAg=eUdbPthG2xrLqwQQ@mail.gmail.com/
Tested-by: Semyon Maryasin <simeon@maryasin.name>
Tested-by: Zhang Lixu <lixu.zhang@intel.com>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/hid/hid-sensor-custom.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-sensor-custom.c
index 59381f8bfa82..55698dea5b86 100644
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

