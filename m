Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793823256;
	b=lEJI8JQ7VJ7YCRy4Jl8QIlTI+imCVO/DrnpmY51mZGqiuo6p5A52ONdgBSLCL8SBESgg
	 rqZLh3mQaCCETFU10wr/ym01eisKtjl/KRO/oMAPR3kX3dwcMIpP1zbfJ6TqCV3t2RT/x
	 HIQ25TQt+xwCFrxpjUMAWetNCiyd7kNtxjv69oIy0jM4nEONhXjLCeivKkT9LX79yH8fc
	 YfHFjFryNYhago94NpSK+M20pGIMkg2dvfNMaWa++zO/uVpF7e+sU0ACWhud7cnbSFCOD
	 JOJduR2haPW45q/TNrIuYfhZ5XR0+MQoR/qFKLUf0ZN/fr6d5PygnYOXukMsW3FhnEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793823256;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=Flp2RW3p6YelEtHdvk6Y9WoACptIVeFePOgPIHHk9PY=;
	b=yXYBHZal2qxn29EhwHY2Dqsr+V7G5KOpRZWRNqHm60kcfoStYGFLZltzyTSXI0KTVLeO
	 mkh/Oo3Z9GQUy8VnuCm5fHbsEmifmrUiNXpqTCwrBpoRTMXmKMurTbKRm+EUL3L3U/f4u
	 VeQXJDcbIWpaVGjQn8Z2jDI0kERX30Tr/Tua5SE9JVSLpMicn+dLnYpE1Rp9U0SSOJHyP
	 7YPsyKg4DkeG3Ziuwrbz7RuH+8pQiTl3SrjOb3/vCfnstSqMHoKtlqzPPn9wPAVV4Y3oQ
	 EXkWKaw2LpEdw/HHMfMRuWdxodvRigfRNmISfkFb8paZPTEUywC8d8vD1yyCdJFdF1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=a1tVaGpX;
	arc=none smtp.remote-ip=198.175.65.16
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F75E6082081;
	Wed,  4 Nov 2026 20:14:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F75E6082081
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=a1tVaGpX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793823256; x=1825359256;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7qaiFfUZ5uxEJznyeGvEAaeyad2oObqzV9jllpbMsAM=;
  b=a1tVaGpXfD0P45c/QxIdTOUSHuWq2HpisnCRomOUUb3bp6jPm3E5/rCG
   WRa0eRhpbzQCOjTvLKsry/yEvhd/QYTw8vLJ7/tjDYpzyqVaEwTrmZfzw
   Gj6Frh/IMBncI3kKqOx38s5Qt4dnnsehjh+zrNu6C974QeSp/UyNsPpZ8
   bYrMfuVv8AzMbL1TwIQK3QGV7HLoYbocgszz9WnY9+1v9MlY23vh5ha85
   CJ3xSueylEgz6bqriesfldnrhX8prGNm3Et9zAEAgoC+gES7PTfUMWJ0w
   gAQMr11rv01yjHdoVcJAYjsNg0zT7CpKTCU7aWsSFdPnfZ6HTCJDu/Fk2
   Q==;
X-CSE-ConnectionGUID: 8fkpoummRSqbgaKnGoWjhA==
X-CSE-MsgGUID: hpqQQBmDQXq+n2Lha/YlSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2589120"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2589120"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 12:14:12 -0800
X-CSE-ConnectionGUID: BCGBBQo4T/Ol678SnzvMjQ==
X-CSE-MsgGUID: +fRq1Y+tTguMfpqA3YDTYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="6925637"
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
Subject: [PATCH v2 4/7] HID: sensor: custom: Fix state lifetime during removal
Date: Wed,  4 Nov 2026 12:14:00 -0800
Message-ID: <20261104201403.2039921-5-srinivas.pandruvada@linux.intel.com>
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

Open misc device files can outlive platform-device removal. Since the
devm-allocated state can be freed while a reader is queued on its wait
queue, subsequent file operations may access freed memory.

Allocate the state independently of devres and give every open
file a reference to keep the FIFO and state alive after removal.

On removal, mark the device as disconnected and wake readers; make reads
return -ENODEV and polls report hangup and error. Free the FIFO and state
when the final reference is released. Unregister the sensor hub callback
before tearing down the interface so in-flight raw-event processing
finishes before the sensor state can be freed.

Fixes: 4a7de0519df5 ("HID: sensor: Custom and Generic sensor support")
Reported-by: Семён Марьясин <simeon@maryasin.name>
Closes: https://lore.kernel.org/all/CAM2dg7ewfVJSP4rFyhkCB1Rmd1+X56sAg=eUdbPthG2xrLqwQQ@mail.gmail.com/
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/hid/hid-sensor-custom.c | 82 ++++++++++++++++++++++-----------
 1 file changed, 56 insertions(+), 26 deletions(-)

diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-sensor-custom.c
index 8375697b459d..2a3b502821c7 100644
--- a/drivers/hid/hid-sensor-custom.c
+++ b/drivers/hid/hid-sensor-custom.c
@@ -11,6 +11,7 @@
 #include <linux/init.h>
 #include <linux/miscdevice.h>
 #include <linux/kfifo.h>
+#include <linux/kref.h>
 #include <linux/sched.h>
 #include <linux/wait.h>
 #include <linux/poll.h>
@@ -37,6 +38,8 @@ struct hid_sensor_custom_field {
 
 struct hid_sensor_custom {
 	struct mutex mutex;
+	struct kref ref;
+	bool removed;
 	struct platform_device *pdev;
 	struct hid_sensor_hub_device *hsdev;
 	struct hid_sensor_hub_callbacks callbacks;
@@ -643,6 +646,15 @@ static void hid_sensor_custom_remove_attributes(struct hid_sensor_custom *
 	kfree(sensor_inst->fields);
 }
 
+static void hid_sensor_custom_free(struct kref *ref)
+{
+	struct hid_sensor_custom *sensor_inst =
+		container_of(ref, struct hid_sensor_custom, ref);
+
+	kfifo_free(&sensor_inst->data_fifo);
+	kfree(sensor_inst);
+}
+
 static ssize_t hid_sensor_custom_read(struct file *file, char __user *buf,
 				      size_t count, loff_t *f_ps)
 {
@@ -656,22 +668,27 @@ static ssize_t hid_sensor_custom_read(struct file *file, char __user *buf,
 	if (count < sizeof(struct hid_sensor_sample))
 		return -EINVAL;
 
-	do {
-		if (kfifo_is_empty(&sensor_inst->data_fifo)) {
-			if (file->f_flags & O_NONBLOCK)
-				return -EAGAIN;
+	for (;;) {
+		if (READ_ONCE(sensor_inst->removed))
+			return -ENODEV;
 
-			ret = wait_event_interruptible(sensor_inst->wait,
-				!kfifo_is_empty(&sensor_inst->data_fifo));
-			if (ret)
-				return ret;
-		}
 		ret = kfifo_to_user(&sensor_inst->data_fifo, buf, count,
 				    &copied);
+		if (ret || copied)
+			break;
+
+		if (file->f_flags & O_NONBLOCK)
+			return -EAGAIN;
+
+		ret = wait_event_interruptible(sensor_inst->wait,
+			READ_ONCE(sensor_inst->removed) ||
+			!kfifo_is_empty(&sensor_inst->data_fifo));
 		if (ret)
 			return ret;
+	}
 
-	} while (copied == 0);
+	if (ret)
+		return ret;
 
 	return copied;
 }
@@ -684,6 +701,7 @@ static int hid_sensor_custom_release(struct inode *inode, struct file *file)
 				   struct hid_sensor_custom, custom_dev);
 
 	clear_bit(0, &sensor_inst->misc_opened);
+	kref_put(&sensor_inst->ref, hid_sensor_custom_free);
 
 	return 0;
 }
@@ -691,14 +709,25 @@ static int hid_sensor_custom_release(struct inode *inode, struct file *file)
 static int hid_sensor_custom_open(struct inode *inode, struct file *file)
 {
 	struct hid_sensor_custom *sensor_inst;
+	int ret;
 
 	sensor_inst = container_of(file->private_data,
 				   struct hid_sensor_custom, custom_dev);
+	if (READ_ONCE(sensor_inst->removed))
+		return -ENODEV;
+
 	/* We essentially have single reader and writer */
 	if (test_and_set_bit(0, &sensor_inst->misc_opened))
 		return -EBUSY;
 
-	return stream_open(inode, file);
+	kref_get(&sensor_inst->ref);
+	ret = stream_open(inode, file);
+	if (ret) {
+		clear_bit(0, &sensor_inst->misc_opened);
+		kref_put(&sensor_inst->ref, hid_sensor_custom_free);
+	}
+
+	return ret;
 }
 
 static __poll_t hid_sensor_custom_poll(struct file *file,
@@ -712,6 +741,9 @@ static __poll_t hid_sensor_custom_poll(struct file *file,
 
 	poll_wait(file, &sensor_inst->wait, wait);
 
+	if (READ_ONCE(sensor_inst->removed))
+		return EPOLLHUP | EPOLLERR;
+
 	if (!kfifo_is_empty(&sensor_inst->data_fifo))
 		mask = EPOLLIN | EPOLLRDNORM;
 
@@ -741,21 +773,15 @@ static int hid_sensor_custom_dev_if_add(struct hid_sensor_custom *sensor_inst)
 	sensor_inst->custom_dev.minor = MISC_DYNAMIC_MINOR;
 	sensor_inst->custom_dev.name = dev_name(&sensor_inst->pdev->dev);
 	sensor_inst->custom_dev.fops = &hid_sensor_custom_fops;
-	ret = misc_register(&sensor_inst->custom_dev);
-	if (ret) {
-		kfifo_free(&sensor_inst->data_fifo);
-		return ret;
-	}
-	return 0;
+	return misc_register(&sensor_inst->custom_dev);
 }
 
 static void hid_sensor_custom_dev_if_remove(struct hid_sensor_custom
 								*sensor_inst)
 {
-	wake_up(&sensor_inst->wait);
+	WRITE_ONCE(sensor_inst->removed, true);
+	wake_up_interruptible_all(&sensor_inst->wait);
 	misc_deregister(&sensor_inst->custom_dev);
-	kfifo_free(&sensor_inst->data_fifo);
-
 }
 
 /*
@@ -978,8 +1004,7 @@ static int hid_sensor_custom_probe(struct platform_device *pdev)
 	int ret;
 	const struct hid_sensor_custom_match *match;
 
-	sensor_inst = devm_kzalloc(&pdev->dev, sizeof(*sensor_inst),
-				   GFP_KERNEL);
+	sensor_inst = kzalloc_obj(*sensor_inst);
 	if (!sensor_inst)
 		return -ENOMEM;
 
@@ -989,6 +1014,7 @@ static int hid_sensor_custom_probe(struct platform_device *pdev)
 	sensor_inst->hsdev = hsdev;
 	sensor_inst->pdev = pdev;
 	mutex_init(&sensor_inst->mutex);
+	kref_init(&sensor_inst->ref);
 	platform_set_drvdata(pdev, sensor_inst);
 
 	ret = hid_sensor_custom_get_known(hsdev, &match);
@@ -1000,7 +1026,7 @@ static int hid_sensor_custom_probe(struct platform_device *pdev)
 		if (ret) {
 			dev_err(&pdev->dev,
 				"register_platform_device failed\n");
-			return ret;
+			goto err_free;
 		}
 
 		return 0;
@@ -1010,7 +1036,7 @@ static int hid_sensor_custom_probe(struct platform_device *pdev)
 					   &sensor_inst->callbacks);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "callback reg failed\n");
-		return ret;
+		goto err_free;
 	}
 
 	ret = hid_sensor_custom_add_attributes(sensor_inst);
@@ -1035,6 +1061,8 @@ static int hid_sensor_custom_probe(struct platform_device *pdev)
 	hid_sensor_custom_remove_attributes(sensor_inst);
 err_remove_callback:
 	sensor_hub_remove_callback(hsdev, hsdev->usage);
+err_free:
+	kref_put(&sensor_inst->ref, hid_sensor_custom_free);
 
 	return ret;
 }
@@ -1046,9 +1074,10 @@ static void hid_sensor_custom_remove(struct platform_device *pdev)
 
 	if (sensor_inst->custom_pdev) {
 		platform_device_unregister(sensor_inst->custom_pdev);
-		return;
+		goto out;
 	}
 
+	sensor_hub_remove_callback(hsdev, hsdev->usage);
 	hid_sensor_custom_dev_if_remove(sensor_inst);
 	/* Remove enable_sensor first as it uses fields via power_state/report_state. */
 	sysfs_remove_group(&sensor_inst->pdev->dev.kobj,
@@ -1061,7 +1090,8 @@ static void hid_sensor_custom_remove(struct platform_device *pdev)
 	}
 	mutex_unlock(&sensor_inst->mutex);
 	hid_sensor_custom_remove_attributes(sensor_inst);
-	sensor_hub_remove_callback(hsdev, hsdev->usage);
+out:
+	kref_put(&sensor_inst->ref, hid_sensor_custom_free);
 }
 
 static const struct platform_device_id hid_sensor_custom_ids[] = {
-- 
2.56.0

