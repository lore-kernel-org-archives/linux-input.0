Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96203C76A0;
	Sun, 13 Sep 2026 07:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789284619; cv=none; b=Vn2X2872YjVYAcYH8lZnOEDiPbdB3OzBeNcvpvYWIP5cD8WFbgG0dq4JLtGHrcvCDed48kQnKghcd3FKQ8qDin02RAh4r7gsyV7rqWEP5BgrDnbGoduf2Q9t3xKHCiYyv74feVioDFTbVDv26DDZa6gBulW3Xb54PYk+/ri0sgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789284619; c=relaxed/simple;
	bh=TpqVzo2DTkrFsu7AVjSuMNrBMWmGf9jtyfmpKyJsU4s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DcNfcMj2ninOemTyQBbQulkTuYnsJ+qgDt4lv95+zUrn6d+GRMs5gjc/d/RLd6cHGxpr6KIIoEXLk8S+QxDC/LB31YluG3TEW2nzO75b6G5tsJcE+ImwxLLbzyFkBmsKLnl6BVz9HoMD6HnRlu9RRhcK5peSL+CNyDsGGMJDnu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tju.edu.cn; spf=pass smtp.mailfrom=tju.edu.cn; dkim=pass (1024-bit key) header.d=tju.edu.cn header.i=@tju.edu.cn header.b=GEllg5+1; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tju.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tju.edu.cn header.i=@tju.edu.cn header.b="GEllg5+1"
Received: from tju.edu.cn (gy-adaptive-ssl-proxy-1-entmail-virt204.gy.ntes [183.242.150.9])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4d8de8fc7;
	Sun, 13 Sep 2026 15:30:05 +0800 (GMT+08:00)
From: Yibo Tan <lhfff@tju.edu.cn>
To: Jiri Kosina <jikos@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
	Zhang Lixu <lixu.zhang@intel.com>,
	linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] HID: sensor-hub: Fail unfinished multi-value reads on removal
Date: Sun, 13 Sep 2026 15:29:10 +0800
Message-Id: <20260913072910.1944300-1-lhfff@tju.edu.cn>
In-Reply-To: <20260913045411.5e2f5b25@jic23-hlaptop>
References: <20260913045411.5e2f5b25@jic23-hlaptop>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa099ac5e8703a1kunm85375de823f704
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCQ0IYVk1OSxlNT0saGBhJQlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKQ0hVSU9JVUpOS1VCWVdZFhoPEhUdFFlBWU9LSFVCQklOS1
	VKS0tVSkJLQlkG
DKIM-Signature: a=rsa-sha256;
	b=GEllg5+1FVY6o/h9Pi21e85mx+UIqhnBzE367+q31NEzrMe59B3Kfu/fQTgt0x53EiMHJ5mcOO/VCKM5ZC8Yv0CtQSPrWnJb5pcM6erm3fpAWnIlEfbBxyGm5XORJ3kp1EC1kHp7dyHFFAQmWtW5TnizYMKhKIwOnane/g7pBnI=; c=relaxed/relaxed; s=default; d=tju.edu.cn; v=1;
	bh=QSZsVbNoTcCvQfcn9iwLW7lOgjG/mRI2Ni84Xy5CgFI=;
	h=date:mime-version:subject:message-id:from;

sensor_hub_remove() completes pending reads after stopping the HID device,
but does not record why they completed.  A successful completion wait
therefore returns zero even if no complete input report was received.
Multi-value IIO callers then format their untouched automatic buffer as a
successful result.

With a valid four-element signed 32-bit quaternion report descriptor, an
unprivileged reader received all 16 bytes of the untouched buffer.  Across
11 independent KASLR-enabled boots, four reads exposed exact pointers to
dev_rot_channels or dev_sysfs_ops.  Subtracting the matching link-time
symbol address recovered the kernel KASLR slide in all four cases.

The reader ran as UID/GID 65534 with no effective capabilities through the
mode-0644 IIO attribute.  The test used a privileged UHID broker to create
and remove the provider; it does not demonstrate unprivileged provider
removal.

Mark a pending request as shut down before completing it from the removal
path, and return -ENODEV from a multi-value read that observes the marker
after a successful wait.  Let removal win even if a response raced with
teardown, since the device is no longer available.

The Root B-only repair returned -ENODEV with no payload or kernel
diagnostic in 3/3 matching signed-32-bit runs.  The source reproducer,
complete vulnerable and fixed serial logs, result tables, and checksums are
available in [1].

Link: https://github.com/kimaiden1984-boop/linux-kernel-poc-collections/tree/main/cases/hid-sensor-quaternion-root-b-kaslr [1]
Fixes: f784fcea4506 ("HID: sensor-hub: Add sensor_hub_input_attr_read_values() for multi-byte reads")
Cc: stable@vger.kernel.org
Suggested-by: Jonathan Cameron <jic23@kernel.org>
Assisted-by: LLM
Signed-off-by: Yibo Tan <lhfff@tju.edu.cn>
---
Changes in v3:
- Replace the raw_size error sentinel with a dedicated teardown flag, as
  suggested by Jonathan Cameron.
- Let teardown win if it races with a completed response.

v2: https://lore.kernel.org/r/20260912050257.837340-1-lhfff@tju.edu.cn/

 drivers/hid/hid-sensor-hub.c   | 6 +++++-
 include/linux/hid-sensor-hub.h | 2 ++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
index 6470a290ebfc..a9bd72218c07 100644
--- a/drivers/hid/hid-sensor-hub.c
+++ b/drivers/hid/hid-sensor-hub.c
@@ -334,6 +334,8 @@ int sensor_hub_input_attr_read_values(struct hid_sensor_hub_device *hsdev,
 			ret = -ETIMEDOUT;
 		else if (cycles < 0)
 			ret = cycles;
+		else if (hsdev->pending.shutdown)
+			ret = -ENODEV;
 
 		hsdev->pending.status = false;
 	}
@@ -805,8 +807,10 @@ static int sensor_hub_finalize_pending_fn(struct device *dev, void *data)
 {
 	struct hid_sensor_hub_device *hsdev = dev->platform_data;
 
-	if (hsdev->pending.status)
+	if (hsdev->pending.status) {
+		hsdev->pending.shutdown = true;
 		complete(&hsdev->pending.ready);
+	}
 
 	return 0;
 }
diff --git a/include/linux/hid-sensor-hub.h b/include/linux/hid-sensor-hub.h
index ab5cc8db3fbb..5aecf4474183 100644
--- a/include/linux/hid-sensor-hub.h
+++ b/include/linux/hid-sensor-hub.h
@@ -38,6 +38,7 @@ struct hid_sensor_hub_attribute_info {
 /**
  * struct sensor_hub_pending - Synchronous read pending information
  * @status:		Pending status true/false.
+ * @shutdown:		The device is being removed.
  * @ready:		Completion synchronization data.
  * @usage_id:		Usage id for physical device, e.g. gyro usage id.
  * @attr_usage_id:	Usage Id of a field, e.g. X-axis for a gyro.
@@ -48,6 +49,7 @@ struct hid_sensor_hub_attribute_info {
  */
 struct sensor_hub_pending {
 	bool status;
+	bool shutdown;
 	struct completion ready;
 	u32 usage_id;
 	u32 attr_usage_id;
-- 
2.39.5

