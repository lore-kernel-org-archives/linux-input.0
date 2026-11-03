Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793671079;
	b=w/3jR/0XyHCWELeCGRDr2eCFnWYqCBE6G4BWN7KwH/OO8pOphJzbi6+eC7ALE1gHHBI3
	 kX2zoLy4VGvclvoEk6G0WQGdcgMZJjMmAOuu74ditwrKKZu1NT9VbiJZsJguSTO+PNPGn
	 rZnsqwCd7+ZMa+TMLnrPemhLOyOp1Amgcfaj7z6WdmVYm1EqGDL46agy/XfUFu9TBwEGk
	 YfsFECoUb+CFaoChqOOZVFRpDZLb9goUWAIv/eIXc81cSNwStBLwkDhu+I6TMXiLPA7Ga
	 VbnlWkuhIDB7hT6XqnNv4VcEMaJuX4ceb/HII61/03rH4JR9SJk8WKwtmL2YmOZCBOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793671079;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=6BMmYkvBaV2UeuFibHBJqJb3Uq5pcYuqhAGBMLexfV0=;
	b=XUK35EAvmGn7/cwiGuzd/ANH9klVE3tyy5apO6i9xL13PR9/tWAxdIp95cZZ13Gqkhwh
	 zO2ETPf9TCVfS21U+whWNxvh7nvuHAyWb7P6H3MBr89KtqPLmpYdkyFo1UC6OJxLrD+vG
	 d/RcBjToYX2QWMGKgKKNH5HyI4p9ZjvEiVssfvZuR+YhNQxAo1r8ieSlgtFcb1EA0AqWd
	 yK1UDNtrWvDl7KjA/cJR3ff/l4ji5cPQBdPFIpHS8q9KI+Sagnvc6nu739LS5zfaZVsqN
	 pi8TPlEcI9nvcSkui5TA51wipv+o7f9oQqlKfooHRyKv2Rl2d7a7tm440IIuvYK8NkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EVRPO2S7;
	arc=none smtp.remote-ip=198.175.65.10
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB151606A324;
	Tue,  3 Nov 2026 01:57:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB151606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EVRPO2S7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793671078; x=1825207078;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uVTQQgSb4OaGSnhsc45KCPvCIIGpGttNQUAXMxI32p4=;
  b=EVRPO2S7teSApMpyCT+gKv60aMoshQ8SwHICX2PPG2NvNSOSpEolPaAh
   Qcyez09uCVTOPTb0+YmqlXMS9qaQgNtjkN+oD2WwejGGuHz6GEvshys4/
   Wxuw0chTD7CsF3N1wniNNa27ocRU4ItxPOL+clH3Up/RkhTWSjEF99iEw
   ESkJPsvHBix3yttiSs8neO/wgLvpprglGRY4giqdQ37NCavWbcJsnNtHO
   ByNC1qYs2PmQYtjVN1YC99EPFQ2tSZHN8O/eVyb5DC1+gTc5XeyBuPYKq
   jzPojp2qlMASf3RhiYWJUlDqL2ZYSN9Zxtfg8GBEiZHXATg2Xx5Bd8sqH
   g==;
X-CSE-ConnectionGUID: daUWwVzuSJW64E+/WaoLtw==
X-CSE-MsgGUID: FMkPV9pmQRW5qmF1Px3YBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2281683"
X-IronPort-AV: E=Sophos;i="6.27,192,1787036400"; 
   d="scan'208";a="2281683"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 17:57:57 -0800
X-CSE-ConnectionGUID: 7cBq2nKuSU2iu7GqQ5tElA==
X-CSE-MsgGUID: nylNPrZUSYOx8mn//wzP0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,192,1787036400"; 
   d="scan'208";a="6350821"
Received: from spandruv-desk.jf.intel.com ([10.54.55.20])
  by orviesa006.jf.intel.com with ESMTP; 02 Nov 2026 17:57:57 -0800
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jikos@kernel.org,
	jic23@kernel.org,
	bentiss@kernel.org
Cc: linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	simeon@maryasin.name,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] HID: sensor-custom: Synchronize misc-device teardown with file lifetime
Date: Mon,  2 Nov 2026 17:57:34 -0800
Message-ID: <20261103015734.578613-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.55.0
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

The HID sensor custom misc device frees its per-sensor state in
remove() while userspace may still hold an open file descriptor. A
reader blocked in read() can remain queued on sensor_inst->wait after the
object has been freed, and a later wakeup races with teardown and
touches stale memory.

Synchronize the misc-device teardown with file lifetime before freeing
the per-sensor state. Set a removal flag, reject new opens, wake
blocked waiters, and wait for the last open file to close before
deregistering the misc device and freeing the FIFO. Fail in-flight read()
and poll() operations cleanly once removal is in progress so userspace
cannot access freed memory after the device disappears.

This avoids use-after-free on read(), poll(), release(), and open()
after the HID sensor custom character device has been removed

Reported-by: Семён Марьясин <simeon@maryasin.name>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/hid/hid-sensor-custom.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-sensor-custom.c
index c2b425afd951..c9338ae47050 100644
--- a/drivers/hid/hid-sensor-custom.c
+++ b/drivers/hid/hid-sensor-custom.c
@@ -53,6 +53,14 @@ struct hid_sensor_custom {
 	struct kfifo data_fifo;
 	unsigned long misc_opened;
 	wait_queue_head_t wait;
+	wait_queue_head_t remove_wait;
+	/*
+	 * Shared with the file operations; use READ_ONCE()/WRITE_ONCE() for the
+	 * teardown state. The actual lifetime guarantee comes from misc_opened:
+	 * removal waits for the last fd to close before deregistering the misc
+	 * device and freeing the FIFO.
+	 */
+	bool removing;
 	struct platform_device *custom_pdev;
 };
 
@@ -653,6 +661,9 @@ static ssize_t hid_sensor_custom_read(struct file *file, char __user *buf,
 	sensor_inst = container_of(file->private_data,
 				   struct hid_sensor_custom, custom_dev);
 
+	if (READ_ONCE(sensor_inst->removing))
+		return -ENODEV;
+
 	if (count < sizeof(struct hid_sensor_sample))
 		return -EINVAL;
 
@@ -662,9 +673,12 @@ static ssize_t hid_sensor_custom_read(struct file *file, char __user *buf,
 				return -EAGAIN;
 
 			ret = wait_event_interruptible(sensor_inst->wait,
+				READ_ONCE(sensor_inst->removing) ||
 				!kfifo_is_empty(&sensor_inst->data_fifo));
 			if (ret)
 				return ret;
+			if (READ_ONCE(sensor_inst->removing))
+				return -ENODEV;
 		}
 		ret = kfifo_to_user(&sensor_inst->data_fifo, buf, count,
 				    &copied);
@@ -684,6 +698,7 @@ static int hid_sensor_custom_release(struct inode *inode, struct file *file)
 				   struct hid_sensor_custom, custom_dev);
 
 	clear_bit(0, &sensor_inst->misc_opened);
+	wake_up_all(&sensor_inst->remove_wait);
 
 	return 0;
 }
@@ -694,6 +709,8 @@ static int hid_sensor_custom_open(struct inode *inode, struct file *file)
 
 	sensor_inst = container_of(file->private_data,
 				   struct hid_sensor_custom, custom_dev);
+	if (READ_ONCE(sensor_inst->removing))
+		return -ENODEV;
 	/* We essentially have single reader and writer */
 	if (test_and_set_bit(0, &sensor_inst->misc_opened))
 		return -EBUSY;
@@ -712,6 +729,9 @@ static __poll_t hid_sensor_custom_poll(struct file *file,
 
 	poll_wait(file, &sensor_inst->wait, wait);
 
+	if (READ_ONCE(sensor_inst->removing))
+		return EPOLLERR;
+
 	if (!kfifo_is_empty(&sensor_inst->data_fifo))
 		mask = EPOLLIN | EPOLLRDNORM;
 
@@ -736,6 +756,7 @@ static int hid_sensor_custom_dev_if_add(struct hid_sensor_custom *sensor_inst)
 		return ret;
 
 	init_waitqueue_head(&sensor_inst->wait);
+	init_waitqueue_head(&sensor_inst->remove_wait);
 
 	sensor_inst->custom_dev.minor = MISC_DYNAMIC_MINOR;
 	sensor_inst->custom_dev.name = dev_name(&sensor_inst->pdev->dev);
@@ -751,10 +772,12 @@ static int hid_sensor_custom_dev_if_add(struct hid_sensor_custom *sensor_inst)
 static void hid_sensor_custom_dev_if_remove(struct hid_sensor_custom
 								*sensor_inst)
 {
-	wake_up(&sensor_inst->wait);
+	WRITE_ONCE(sensor_inst->removing, true);
+	wake_up_all(&sensor_inst->wait);
+	wait_event(sensor_inst->remove_wait,
+		   !test_bit(0, &sensor_inst->misc_opened));
 	misc_deregister(&sensor_inst->custom_dev);
 	kfifo_free(&sensor_inst->data_fifo);
-
 }
 
 /*
-- 
2.56.0

