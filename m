Received: from c.mail.sonic.net (c.mail.sonic.net [64.142.111.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC3D3B4E80;
	Wed,  7 Oct 2026 07:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.142.111.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791358489; cv=none; b=j8vAeh3cgqqDMyOJ8+HZ//o8nuUP/n9lCG7r3g9SbjelLQmngyVawk1NZj3LUmTW+qIdMpGtXcSjJqBHDPAZ9CyaASywB+CN3xhOlBx9anYaNtcHIvUqzvycsGOaiqfT+vC+BmHcjQgHVZIQqY1IZ38Hy+ZoN8/kcP/DTCziMG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791358489; c=relaxed/simple;
	bh=+RKMOtfk8ifPgvPqhNOL5WGSL7XpTraxLurwMmoiQaI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lISWWNuJs8qtDCMRD6HrzS4vJRL9k0IUZr1QhAawKnCUxiM9dDJyfDimSvgyEwVgwR9LWPtDsBmp8KF7taBmhbiq0Jil3Ag7IkUdQLfIYFqeUIJrwIjjInHRvcytIWk+6G8tFNUgd+nVhhbprCf/qZHj5k9fOoqD2Y2EoW40qvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=murgatroid.com; spf=pass smtp.mailfrom=murgatroid.com; arc=none smtp.client-ip=64.142.111.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=murgatroid.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=murgatroid.com
Received: from fred.murgatroid.com ([70.134.61.105])
	(authenticated bits=0)
	by c.mail.sonic.net (8.16.1/8.16.1) with ESMTPSA id 6977O5eF013374
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 7 Oct 2026 00:24:05 -0700
Received: from murgatroid.com (shack.murgatroid.com [10.0.0.31])
	by fred.murgatroid.com (Postfix) with SMTP id 6BAD72A60489;
	Wed,  7 Oct 2026 00:24:05 -0700 (PDT)
Received: (nullmailer pid 28261 invoked by uid 1000);
	Wed, 07 Oct 2026 07:24:05 -0000
From: Christopher Hoover <ch@murgatroid.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christopher Hoover <ch@murgatroid.com>
Subject: [PATCH 0/2] iio: hid-sensors: fix shared callbacks in temperature and humidity
Date: Wed,  7 Oct 2026 00:23:27 -0700
Message-ID: <20261007072329.27806-1-ch@murgatroid.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Sonic-CAuth: UmFuZG9tSVb+n1sQSWkhqhSBoUTP48kpw39is/gh/+JX6J0+bAzpHk5gXcB/UZiZoGphFR0sKN1VaQJH1vPKkxgJLeGe+NTbYDUkyggnCo4=
X-Sonic-ID: C;qr79EyDC8RGmKfEWvTXIBA== M;xB8PFCDC8RGmKfEWvTXIBA==
X-Spam-Flag: Unknown
X-Sonic-Spam-Details: not scanned (too big) by cerberusd

hid-sensor-temperature and hid-sensor-humidity keep a single static
struct hid_sensor_hub_callbacks for all of their instances and
overwrite its pdev on every probe.  The other HID sensor drivers keep
theirs per instance.  With two temperature sensors, input reports for
one are delivered with the other's platform device; once that device
is removed, platform_get_drvdata() returns NULL and
temperature_capture_sample() dereferences it:

  BUG: kernel NULL pointer dereference, address: 00000000000003a8
  RIP: 0010:temperature_capture_sample+0xd/0x50 [hid_sensor_temperature]
  Call Trace:
   sensor_hub_raw_event+0x3fc/0x7a0 [hid_sensor_hub]
   __hid_input_report+0x140/0x230 [hid]
   hid_safe_input_report+0x14/0x30 [hid]
   uhid_char_write+0x1f6/0x340 [uhid]

The oops happens with the hub's spinlock held, so the hub's removal
then hangs until reboot.

I hit this with a userspace daemon that presents a USB thermometer as
a HID temperature sensor through uhid: creating a second uhid sensor
and destroying it while the first keeps sending input reports
reproduced it twice on 7.0. 

The patches move the callbacks into each driver's state, as
hid-sensor-accel-3d does.  Humidity has the same code but I have not
reproduced it there.

Not addressed here: sensor_hub_raw_event() looks up the callback under
dyn_callback_lock and calls it under pdata->lock, while
sensor_hub_remove_callback() takes only dyn_callback_lock, so a
report racing a remove can still reach a callback whose driver is
going away.  That predates this series.

Christopher Hoover (2):
  iio: temperature: hid-sensor-temperature: Use per-instance callbacks
  iio: humidity: hid-sensor-humidity: Use per-instance callbacks

 drivers/iio/humidity/hid-sensor-humidity.c       | 12 +++++-------
 drivers/iio/temperature/hid-sensor-temperature.c | 12 +++++-------
 2 files changed, 10 insertions(+), 14 deletions(-)


base-commit: 9ee8306121495d2a25aa5d1bfd519f2748786b83
-- 
2.43.0

