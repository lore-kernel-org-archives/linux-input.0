Received: from d.mail.sonic.net (d.mail.sonic.net [64.142.111.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E193603FB;
	Mon, 19 Oct 2026 02:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.142.111.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792377922; cv=none; b=RPcpjPV8ksuiKuP52GKtOGmmqOD3+P8ZpfLT632sy345VUvkLm3CfWvk6XiJBqU3dx13iTxYWYjl0z2j8t45AtOr3jS0sDeUwoOsa0rwg+tzYl4ujVlzA/ITdLYxuRwfsQuAkGXFb2PZ30bEwzCr4q3hv+rpY6PVdvd4421SxcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792377922; c=relaxed/simple;
	bh=ko+JGTjp7mTaARtqQFqvDE/nTK1gym8IXTXVIWmAkHM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=riw6SWnlWGqfh9zYCLbd8KP73b2BifJLRXZcG40h90GliFmdDux7lTd2nvtQ+fsdO1G7zqWw7ryYasyk/XsIb+q5X7YkxMqB1lyPm8rD9u7eC46Bvy1OE0WkT65QuV6oxNOf6aCeiMoE9H8vHmbMhblmNOdTaUHoH3TeNp3ZJOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=murgatroid.com; spf=pass smtp.mailfrom=murgatroid.com; arc=none smtp.client-ip=64.142.111.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=murgatroid.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=murgatroid.com
Received: from fred.murgatroid.com ([70.134.61.105])
	(authenticated bits=0)
	by d.mail.sonic.net (8.16.1/8.16.1) with ESMTPSA id 69J2YKNB024946
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Sun, 18 Oct 2026 19:34:21 -0700
Received: from murgatroid.com (unknown [10.0.1.185])
	by fred.murgatroid.com (Postfix) with SMTP id 8C2F62A60342;
	Sun, 18 Oct 2026 19:34:20 -0700 (PDT)
Received: (nullmailer pid 83994 invoked by uid 1000);
	Mon, 19 Oct 2026 02:34:20 -0000
From: Christopher Hoover <ch@murgatroid.com>
To: Jonathan Cameron <jic23@kernel.org>, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <bentiss@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Lixu Zhang <lixu.zhang@intel.com>,
        Joshua Crofts <joshua.crofts1@gmail.com>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christopher Hoover <ch@murgatroid.com>
Subject: [PATCH v3 0/3] iio: hid-sensors: fix shared callbacks in temperature and humidity
Date: Sun, 18 Oct 2026 19:34:17 -0700
Message-ID: <20261019023420.83976-1-ch@murgatroid.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Sonic-CAuth: UmFuZG9tSVbszKTpAkp3Xy9YqIfCNSUiFtyjadJInhKnLi6vgV/FoJ0s90hdMalILyt090eEpaJBRVwuC8A5cW0LiZdQ/RgejWCDMC61kRU=
X-Sonic-ID: C;YIvWlmXL8RGMPLCPAMRQ2g== M;ysv5lmXL8RGMPLCPAMRQ2g==
X-Spam-Flag: Unknown
X-Sonic-Spam-Details: not scanned (too big) by cerberusd

hid-sensor-temperature and hid-sensor-humidity share one static
struct hid_sensor_hub_callbacks across instances and overwrite its pdev
on every probe. With two temperature sensors, reports for one go to
the other's pdev; once that device is removed,
temperature_capture_sample() dereferences NULL. I hit this on 7.0
with two uhid-created sensors.

Patches 2-3 make the callbacks per instance, as the other HID sensor
drivers do. Patch 1 makes sensor_hub_remove_callback() take
pdata->lock, as sensor_hub_raw_event() does, so a report racing an
unbind cannot call through the freed callbacks.

Changes in v3:
- Patches 2-3: set the callbacks with one compound literal (Jonathan).
- Kept Joshua's Reviewed-by on all three; patches 2-3 changed only in
  style.
- Rebased onto v7.3.
- Sent as a new thread, not a reply to v2.

Changes in v2:
- New patch 1, for the use-after-free on unbind found by the Sashiko
  review of v1.

v2: https://lore.kernel.org/all/20261007184423.622445-1-ch@murgatroid.com/

Christopher Hoover (3):
  HID: hid-sensor-hub: Synchronize callback removal with raw events
  iio: temperature: hid-sensor-temperature: Use per-instance callbacks
  iio: humidity: hid-sensor-humidity: Use per-instance callbacks

 drivers/hid/hid-sensor-hub.c                     | 12 ++++++++++--
 drivers/iio/humidity/hid-sensor-humidity.c       | 14 +++++++-------
 drivers/iio/temperature/hid-sensor-temperature.c | 14 +++++++-------
 3 files changed, 24 insertions(+), 16 deletions(-)


base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
-- 
2.53.0

