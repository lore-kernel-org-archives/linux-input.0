Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794254397;
	b=v2Bh/5fSwyAyv7jbreIM8F71VUQOgVgWad0n6+C7oL4mur7TR1IN+SA17gt7ch4YXpqF
	 f4/mvghEE3P88g+DP1lZWh4rspxUds09RPxNjwWoIgj52bCQOlF2kJEE1ybNFFv/n0OCY
	 a5PScMu2G2bQ/jKw2wWjsNt/BFuEgQx2xCEV9WpD72hsM6q8lyhQnmS+iLP1VrTyxQf7O
	 rfQyDrBPkJnC9fwWzBodrmqLGqH3rZ4SUQ+p+/x8LEQuXUDZbq4MidXgBTC+BFUnZ5nS2
	 xzIegOaGIdfsjPcMPUe7VqU0m5LqlKc3MvJnMSCqy1Rt5JigyE02Stew4nhDqYQorMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794254397;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=SW1CoRkE6U47FinSXm/2xPQR4qDSnYMTgrgfBs8a6iU=;
	b=pVQoxbbqxMMz4lvJ4UFGGsUrHcDkyIonBOUj29WTE+W70mKT1o9F50MgnD5tNIFaDZe6
	 E6O77ZthElsdkrsX/QSymIY9YN+PJ94EEVr+3prXmugEePSW2qrHlBVTZZSfU1OChMTOe
	 JQMN6FXg2GQa9qd/wtvnwCBUkEChmZ/EDDeYg8G6kZAFHd6WNUnHHDLm3FWkgezmWbCvU
	 6l4fUfHorJc1GYMlbJ2GzYxefe2CfWKBdGoKbeWH+oFwk//B2/GN/M2K56GtXIlJTq8TQ
	 WYUFn2WY1FLeIPXF37ukMbcZIpsQldVhRwlMuBAZYWk3e8utOL2xsroTfcxRSp/8Nzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VFDQqSKU;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B056B606A338;
	Mon,  9 Nov 2026 19:59:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B056B606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VFDQqSKU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794254397; x=1825790397;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8qM7IyejF4IOl+P19zAtB4IIbubd4qIRjSrQxYtvk6A=;
  b=VFDQqSKUPEKMTzmCSyp4yCBtXitCtRT2mn/b9iTXZwRzPtwNo1WWbG/U
   piOpK+QwcnxrFCsEQdRT2L1PytLdU7oy+iKLRoDwkDmP0OSuOEypCJEh9
   yflWK4K+xyk8oPA1Pi/7L9Gq/wN4R00AwQe7lm+hVJ2sk8BB9Ch0w02Yn
   sk7ZiqoVIb/Ei847rhXOadrkMovrg3c0sNRx+q3An8qUQu2/t0hXo5IO0
   fup9mXEnNRWVJpkuFpErngAyJny3bjf1Z1O39CSRqBA9sXvmHx7GRniHv
   //HeNf2yOzMZeGSaNtiT0VkXAcACK43OwnA3U6+nPnjrLQB31iPHdPN+V
   A==;
X-CSE-ConnectionGUID: MiocjVPuR62+7w92hZXgcg==
X-CSE-MsgGUID: 6c9/HRlaRMa1vglA6My9Ug==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="2986569"
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="2986569"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 11:59:55 -0800
X-CSE-ConnectionGUID: KNOt6EXRRxKPZofpk88FZw==
X-CSE-MsgGUID: 03hkGu00T0qTtXlUOed4rA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="8090664"
Received: from spandruv-desk.jf.intel.com ([10.54.55.20])
  by fmviesa005.fm.intel.com with ESMTP; 09 Nov 2026 11:59:54 -0800
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
Subject: [PATCH v3 4/7] HID: sensor: custom: Fix state lifetime during removal
Date: Mon,  9 Nov 2026 11:59:46 -0800
Message-ID: <20261109195949.384888-5-srinivas.pandruvada@linux.intel.com>
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
Reported-by: Semyon Maryasin <simeon@maryasin.name>
Closes: https://lore.kernel.org/all/CAM2dg7ewfVJSP4rFyhkCB1Rmd1+X56sAg=eUdbPthG2xrLqwQQ@mail.gmail.com/
Tested-by: Semyon Maryasin <simeon@maryasin.name>
Tested-by: Zhang Lixu <lixu.zhang@intel.com>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/hid/hid-sensor-custom.c | 81 +++++++++++++++++++++++----------
 1 file changed, 56 insertions(+), 25 deletions(-)

diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-sensor-custom.c
index ec7734e8e4a6..59381f8bfa82 100644
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
@@ -978,7 +1004,7 @@ static int hid_sensor_custom_probe(struct platform_device *pdev)
 	int ret;
 	const struct hid_sensor_custom_match *match;
 
-	sensor_inst = devm_kzalloc_obj(&pdev->dev, *sensor_inst);
+	sensor_inst = kzalloc_obj(*sensor_inst);
 	if (!sensor_inst)
 		return -ENOMEM;
 
@@ -988,6 +1014,7 @@ static int hid_sensor_custom_probe(struct platform_device *pdev)
 	sensor_inst->hsdev = hsdev;
 	sensor_inst->pdev = pdev;
 	mutex_init(&sensor_inst->mutex);
+	kref_init(&sensor_inst->ref);
 	platform_set_drvdata(pdev, sensor_inst);
 
 	ret = hid_sensor_custom_get_known(hsdev, &match);
@@ -999,7 +1026,7 @@ static int hid_sensor_custom_probe(struct platform_device *pdev)
 		if (ret) {
 			dev_err(&pdev->dev,
 				"register_platform_device failed\n");
-			return ret;
+			goto err_put;
 		}
 
 		return 0;
@@ -1009,7 +1036,7 @@ static int hid_sensor_custom_probe(struct platform_device *pdev)
 					   &sensor_inst->callbacks);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "callback reg failed\n");
-		return ret;
+		goto err_put;
 	}
 
 	ret = hid_sensor_custom_add_attributes(sensor_inst);
@@ -1034,6 +1061,8 @@ static int hid_sensor_custom_probe(struct platform_device *pdev)
 	hid_sensor_custom_remove_attributes(sensor_inst);
 err_remove_callback:
 	sensor_hub_remove_callback(hsdev, hsdev->usage);
+err_put:
+	kref_put(&sensor_inst->ref, hid_sensor_custom_free);
 
 	return ret;
 }
@@ -1045,9 +1074,10 @@ static void hid_sensor_custom_remove(struct platform_device *pdev)
 
 	if (sensor_inst->custom_pdev) {
 		platform_device_unregister(sensor_inst->custom_pdev);
-		return;
+		goto out;
 	}
 
+	sensor_hub_remove_callback(hsdev, hsdev->usage);
 	hid_sensor_custom_dev_if_remove(sensor_inst);
 	/* Remove enable_sensor first as it uses fields via power_state/report_state. */
 	sysfs_remove_group(&sensor_inst->pdev->dev.kobj,
@@ -1060,7 +1090,8 @@ static void hid_sensor_custom_remove(struct platform_device *pdev)
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

