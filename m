Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF993A8730;
	Wed, 10 Jun 2026 08:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781080161; cv=none; b=mehlFlRAMrroqz8FOgf8/I0EEk2G2oExJetE/Gd3VMziSHk0p88P+9Y/R+otMTdNU5MITxLNbCpblLjjKEA9F6U3TYKWx4idXUTlkzS1rnrmsvmXyIrLrDi7n4vaTJKUuzE8wEsVD6U/SACNBurocBUqPOiQn+DkRmX33r2iUW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781080161; c=relaxed/simple;
	bh=ZpyspbBfeW0Q+8UiMvhtWzEpFQz4ZoVqMdM61L0YykY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WwXGbONg8zaZxRDfzFQUN8uL+XsVatZa3j75S3nSzhJDAhLdPiNf3340Tz5eZoan13AHHJbOWln43aQfht0ddjz2ba8L9bLQqPgMMZmTAyemF8kv6t/FqnwaVYdU1Ox+hom+AHR8Dcza+R62uQeGLjyxRhnp/RAGZcJShvZc+ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CC7J/tTY; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CC7J/tTY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781080161; x=1812616161;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZpyspbBfeW0Q+8UiMvhtWzEpFQz4ZoVqMdM61L0YykY=;
  b=CC7J/tTYLQdtYg05OChhqKI6SpqAdC00SsMiD27T5wLl+51ip/hwBs60
   Imy8iMub4nKHqNze5p+MMieoJgYL04ca/c0BTLAKyY5p0a/3fgNB33fox
   xUzmkEITOGE+Bn62epr14BfHv9v5JNi/cGk4z+vggV1FrSRFrOnYymFzx
   zDFr2PJ5Bm2XH4DHkqI1foSgI3FuvXycugT4H0zbiRYbNvitye/+MuqkV
   n8YLfbIxeaIpVwn2ZkfGfolrGD5UhP1CX5031XkOHZReZf1Pd8OKV6PQK
   7sr+Wh6SKuwuYusDvQM1YFbbxk6jn6JUFs08i0DOq6XILyJ97dylfZG/p
   w==;
X-CSE-ConnectionGUID: QlH+Elj8Qly1u09BsbwxlA==
X-CSE-MsgGUID: ugjDxvbqT9OP98TubpHaeg==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="93255327"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="93255327"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 01:29:20 -0700
X-CSE-ConnectionGUID: oQOZQ3DJQkCpEL06+HbOXw==
X-CSE-MsgGUID: UOT7/AYKTdSzuQGThKDm0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="250043171"
Received: from lixuzha-desk.sh.intel.com ([10.239.146.169])
  by orviesa003.jf.intel.com with ESMTP; 10 Jun 2026 01:29:18 -0700
From: Zhang Lixu <lixu.zhang@intel.com>
To: Jiri Kosina <jikos@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lixu.zhang@intel.com
Subject: [PATCH 2/2] iio: hid-sensor-rotation: Fix stale or zero output when reading raw values
Date: Wed, 10 Jun 2026 16:29:10 +0800
Message-ID: <20260610082911.157232-3-lixu.zhang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610082911.157232-1-lixu.zhang@intel.com>
References: <20260610082911.157232-1-lixu.zhang@intel.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When reading the raw quaternion attribute (in_rot_quaternion_raw), the
driver currently returns either all zeros (if the sensor was never enabled)
or stale data (if the sensor was previously enabled) because it reads from
the internal buffer without explicitly requesting a new sample from the
sensor.

To fix this, power up the sensor, call sensor_hub_input_attr_read_values()
to issue a synchronous GET_REPORT and receive the full quaternion data
directly into a local buffer, then decode the four components.

Signed-off-by: Zhang Lixu <lixu.zhang@intel.com>
---
 drivers/iio/orientation/hid-sensor-rotation.c | 40 ++++++++++++++++++-
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/orientation/hid-sensor-rotation.c b/drivers/iio/orientation/hid-sensor-rotation.c
index 4a11e45550991..1c6f02374f3ce 100644
--- a/drivers/iio/orientation/hid-sensor-rotation.c
+++ b/drivers/iio/orientation/hid-sensor-rotation.c
@@ -86,6 +86,13 @@ static int dev_rot_read_raw(struct iio_dev *indio_dev,
 				long mask)
 {
 	struct dev_rot_state *rot_state = iio_priv(indio_dev);
+	struct hid_sensor_hub_device *hsdev = rot_state->common_attributes.hsdev;
+	struct hid_sensor_hub_attribute_info *info = &rot_state->quaternion;
+	u32 usage_id = HID_USAGE_SENSOR_ORIENT_QUATERNION;
+	union {
+		s16 val16[4];
+		s32 val32[4];
+	} raw_buf;
 	int ret_type;
 	int i;
 
@@ -95,8 +102,37 @@ static int dev_rot_read_raw(struct iio_dev *indio_dev,
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
 		if (size >= 4) {
-			for (i = 0; i < 4; ++i)
-				vals[i] = rot_state->scan.sampled_vals[i];
+			if (info->size <= 0 || info->size > sizeof(raw_buf))
+				return -EINVAL;
+
+			hid_sensor_power_state(&rot_state->common_attributes, true);
+
+			ret_type = sensor_hub_input_attr_read_values(hsdev,
+								     hsdev->usage,
+								     usage_id,
+								     info->report_id,
+								     SENSOR_HUB_SYNC,
+								     info->size,
+								     (u8 *)&raw_buf);
+
+			hid_sensor_power_state(&rot_state->common_attributes, false);
+
+			if (ret_type < 0)
+				return ret_type;
+
+			switch (info->size) {
+			case sizeof(raw_buf.val16):
+				for (i = 0; i < ARRAY_SIZE(raw_buf.val16); i++)
+					vals[i] = raw_buf.val16[i];
+				break;
+			case sizeof(raw_buf.val32):
+				for (i = 0; i < ARRAY_SIZE(raw_buf.val32); i++)
+					vals[i] = raw_buf.val32[i];
+				break;
+			default:
+				return -EINVAL;
+			}
+
 			ret_type = IIO_VAL_INT_MULTIPLE;
 			*val_len =  4;
 		} else
-- 
2.43.0

