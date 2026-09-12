Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24AEA1A2545;
	Sat, 12 Sep 2026 05:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789189404; cv=none; b=EWcnptaQQBTDuOH/RlHUl5IdEF7oZ3JJ4Sl8I2PxCNYniQaUJ/uYZ4ONnDnOzoktPfr1LD5FDAV89oCWaEKyP8Ul10R3e63o/MYHZAmkD1je2QQTnZJJ/oCIjl/oacUORQhp02bw36VLTllCpN3zHhrDaoazDpyX7UdTsHR0smY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789189404; c=relaxed/simple;
	bh=iwIbeaoOy2Z0IYNkuRNM/9Cu5DGAWnsyvWcSc24PFl8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ucNgledpKwXuKbwglue0bHlmNJmj/ZIN3LT+TugWifcClWucwgTeYIOnKfZtrZSdOEOXs20xaoUtVd2kCnXd6UBBTXUbr9OK6eoBkjIl12MFkZiOCaFL5shPeNYS4sAgzyk/oz9SbZFzd7v+zIlvpY85WrKM9Xizd/ChkevKVOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tju.edu.cn; spf=pass smtp.mailfrom=tju.edu.cn; dkim=pass (1024-bit key) header.d=tju.edu.cn header.i=@tju.edu.cn header.b=ghDGqI9x; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tju.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tju.edu.cn header.i=@tju.edu.cn header.b="ghDGqI9x"
Received: from tju.edu.cn (gy-adaptive-ssl-proxy-1-entmail-virt204.gy.ntes [183.242.150.9])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4d8066730;
	Sat, 12 Sep 2026 13:03:11 +0800 (GMT+08:00)
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
Subject: [PATCH v2] HID: sensor-hub: Fail unfinished multi-value reads on removal
Date: Sat, 12 Sep 2026 13:02:57 +0800
Message-Id: <20260912050257.837340-1-lhfff@tju.edu.cn>
In-Reply-To: <aqPNDZgMS9K6NT7d@ashevche-desk.local>
References: <aqPNDZgMS9K6NT7d@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa093ff837003a1kunmaa22691e200844
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDGhgZVk4YGRlMT0saTUNOHVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKQ0hVSU9JVUpOS1VCWVdZFhoPEhUdFFlBWU9LSFVCQklOS1
	VKS0tVSkJLQlkG
DKIM-Signature: a=rsa-sha256;
	b=ghDGqI9xAb2WO+ZuDU2+t6YWuEEMd9n2Nu2Oq6+h31rQiAbl02WQ4UBiU66bDRjogrCd5n5jXGhBBTCwMWnCNgY+2JCc2ia8Q7tR0Yb3YFd6db/nt/Xaf+djnhj6Tzz9olvQYyQdRMbKc0uu4HWQF/bMmLMPpDS+ZbeVolYX710=; c=relaxed/relaxed; s=default; d=tju.edu.cn; v=1;
	bh=GlAlyJGl2A6GBSXYGxfVWPEECkF0Qp0mlc7yMZn+CsY=;
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

Publish -ENODEV through pending.raw_size before completing an unfinished
multi-value request, and propagate the error after a successful wait.  A
fully received response already has a positive raw_size and remains
successful; max_raw_size is zero for the separate single-value path.

The Root B-only repair returned -ENODEV with no payload or kernel
diagnostic in 3/3 matching signed-32-bit runs.  The source reproducer,
complete vulnerable and fixed serial logs, result tables, and checksums are
available in [1].

Link: https://github.com/kimaiden1984-boop/linux-kernel-poc-collections/tree/main/cases/hid-sensor-quaternion-root-b-kaslr [1]
Fixes: f784fcea4506 ("HID: sensor-hub: Add sensor_hub_input_attr_read_values() for multi-byte reads")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Yibo Tan <lhfff@tju.edu.cn>
---
Changes in v2:
- Turn the reproducer URL into a Link trailer and cite it from the text.
- Use the reviewer-requested generic LLM assistance trailer.

v1: https://lore.kernel.org/r/20260911092039.234253-1-lhfff@tju.edu.cn/

 drivers/hid/hid-sensor-hub.c   | 7 ++++++-
 include/linux/hid-sensor-hub.h | 2 +-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
index 6470a290ebfc..687f8defa2f0 100644
--- a/drivers/hid/hid-sensor-hub.c
+++ b/drivers/hid/hid-sensor-hub.c
@@ -334,6 +334,8 @@ int sensor_hub_input_attr_read_values(struct hid_sensor_hub_device *hsdev,
 			ret = -ETIMEDOUT;
 		else if (cycles < 0)
 			ret = cycles;
+		else if (hsdev->pending.raw_size < 0)
+			ret = hsdev->pending.raw_size;
 
 		hsdev->pending.status = false;
 	}
@@ -805,8 +807,11 @@ static int sensor_hub_finalize_pending_fn(struct device *dev, void *data)
 {
 	struct hid_sensor_hub_device *hsdev = dev->platform_data;
 
-	if (hsdev->pending.status)
+	if (hsdev->pending.status) {
+		if (hsdev->pending.max_raw_size && !hsdev->pending.raw_size)
+			hsdev->pending.raw_size = -ENODEV;
 		complete(&hsdev->pending.ready);
+	}
 
 	return 0;
 }
diff --git a/include/linux/hid-sensor-hub.h b/include/linux/hid-sensor-hub.h
index ab5cc8db3fbb..4ad53304bb0b 100644
--- a/include/linux/hid-sensor-hub.h
+++ b/include/linux/hid-sensor-hub.h
@@ -41,7 +41,7 @@ struct hid_sensor_hub_attribute_info {
  * @ready:		Completion synchronization data.
  * @usage_id:		Usage id for physical device, e.g. gyro usage id.
  * @attr_usage_id:	Usage Id of a field, e.g. X-axis for a gyro.
- * @raw_size:		Response size for a read request.
+ * @raw_size:		Response size or negative error for a read request.
  * @raw_data:		Place holder for received response.
  * @index:		Current write index into raw_data for multi-byte reads.
  * @max_raw_size:	Total buffer size for multi-byte reads; 0 for single-value reads.
-- 
2.39.5

