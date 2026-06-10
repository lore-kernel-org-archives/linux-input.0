Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369AB21B9F6;
	Wed, 10 Jun 2026 08:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781080156; cv=none; b=TIpTyp6Ut0HrVqreaEmg2848jkSM9begT7binLfDG2XwFteeSN1RnewH1VsxWdFEA7Zl8aZE+FBqdgSswysagZSMAIar4g2zU4TG0cGmz97as5Qrn5pVT/vLrdx9rBgaw9SyrIByZ6WhcgA+i12Px8VAO65RJnMjpvXQo5NFIQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781080156; c=relaxed/simple;
	bh=SlxX4GHRBsvQro5I2+VwI3J9BMgQtLJR/xJ/6xGPdoU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dHtIfxFHGmw8dnQcnTfYNJXtuQmIpLX3FBKY66Frvhr1V37qxAXiSqOeijXzC6MJ6V+Hv7sD4aQGnJn51WIR4S90aJSPu4xPjKl3xXJHgQV9iciiY/D9VBGf/rSUmQaROdAeJPcAzK0/9yXtbBp41mplITBfXeJmTdw662AJ2RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dcStlRUD; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dcStlRUD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781080155; x=1812616155;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SlxX4GHRBsvQro5I2+VwI3J9BMgQtLJR/xJ/6xGPdoU=;
  b=dcStlRUDr99sytlOcfZXGLxfYBiYGlD1MKZdJbyv4t5jwMPsmFKvUgoJ
   wxEDlqI74gkjQeK+CgkRLaqcnJIWlV5IVOHdU/aXigLly47JGKIXuRsSH
   h7mtqhcMRJJ45OYUI///G/OI1X0cOqkiYlSeo2yB76Byl6SIsjGY4LTVy
   fg/S1Gq7hXtilAfy9Jr8AU+09+ZvDIwWUgwGbQG5OKMOkhKVxKr9aqwP0
   RN178MyL5fSjoWVxWV3YVkm5qayfNwY7kB8ecHwSHUriIdX/Zg8I8MXcE
   MmSaV5wIS7W3FzC66hWPNv4TpMs2zOwqmen27b0DknAitbKHbGACI1Gbb
   g==;
X-CSE-ConnectionGUID: 45dBYXu0R+SrJ2COqiCCkQ==
X-CSE-MsgGUID: X2J9e5RhSfWhJ7F3leu8Ug==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="93255310"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="93255310"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 01:29:15 -0700
X-CSE-ConnectionGUID: UI01S6LFRP20r8gEzRLDSw==
X-CSE-MsgGUID: TXl4jO/BRMSWfxVzDZ2NNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="250043137"
Received: from lixuzha-desk.sh.intel.com ([10.239.146.169])
  by orviesa003.jf.intel.com with ESMTP; 10 Jun 2026 01:29:12 -0700
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
Subject: [PATCH 0/2] HID: iio: Fix stale or zero quaternion reads with multi-byte read helper
Date: Wed, 10 Jun 2026 16:29:08 +0800
Message-ID: <20260610082911.157232-1-lixu.zhang@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When reading in_rot_quaternion_raw from hid-sensor-rotation, the driver
returns either all zeros (if the sensor was never enabled) or stale data
(if previously enabled), because it reads from an internal buffer without
requesting a fresh sample from the device.

This series fixes the issue in two steps:

1. Add sensor_hub_input_attr_read_values() to the HID sensor hub core.
   Unlike sensor_hub_input_attr_get_raw_value(), which is limited to a
   single 32-bit value, the new helper accepts a caller-provided buffer
   and accumulates incoming input report data until the buffer is full.
   The two code paths are distinguished in sensor_hub_raw_event() by
   pending.max_raw_size being non-zero, preserving backward compatibility.

2. Switch hid-sensor-rotation to use the new helper for raw quaternion
   reads. It now powers up the sensor, issues a synchronous GET_REPORT,
   and receives all four quaternion components directly into a local
   buffer before decoding them, eliminating stale or zero output.

Srinivas Pandruvada (1):
  HID: sensor-hub: Add sensor_hub_input_attr_read_values() for
    multi-byte reads

Zhang Lixu (1):
  iio: hid-sensor-rotation: Fix stale or zero output when reading raw
    values

 drivers/hid/hid-sensor-hub.c                  | 77 +++++++++++++++++--
 drivers/iio/orientation/hid-sensor-rotation.c | 40 +++++++++-
 include/linux/hid-sensor-hub.h                | 25 ++++++
 3 files changed, 134 insertions(+), 8 deletions(-)


base-commit: 49e02880ec0a8c378e811bc9d85da188d7c6204c
-- 
2.43.0

