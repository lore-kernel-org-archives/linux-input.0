Received: from d.mail.sonic.net (d.mail.sonic.net [64.142.111.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071CB3F86E1;
	Wed,  7 Oct 2026 18:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.142.111.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791399330; cv=none; b=QQNaiyeMsJhkgmgHL1V714J+Zeybgwd72lAeQtwT9Fr06PD1Fghsx8nqbWrneYKuV4ZZ3mBsQVKo63BDW8YpS/SyDFA3yCV968QkvENi9XmvWso4Qc+30/gUTcTgwXV/AW6hlb/uWYckRDrGFCdW7he/yWIpmx7R7ayw82JaI68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791399330; c=relaxed/simple;
	bh=2OsUGW5QipzH5wkM5m8vip1iNaM2tvEQOYd5ugYEOac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ihNDyqBJTHmlD3E1A/hETJD/4W4lQ8mLhzND35Y7eU+opx+O0ke2aOoplJEupRMcg4mcH1/Ck1Dtldw8d/SuanNvJ7C55ct0J3E62h6HHLD44H/UMEW+ZIs6pMxtGJXvxRBIlu+/c7+Pgxzcswx94UZBbGJ14c4dq5I4guP/ghQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=murgatroid.com; spf=pass smtp.mailfrom=murgatroid.com; arc=none smtp.client-ip=64.142.111.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=murgatroid.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=murgatroid.com
Received: from fred.murgatroid.com ([70.134.61.105])
	(authenticated bits=0)
	by d.mail.sonic.net (8.16.1/8.16.1) with ESMTPSA id 697IiP3q011896
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 7 Oct 2026 11:44:26 -0700
Received: from murgatroid.com (shack.murgatroid.com [10.0.0.31])
	by fred.murgatroid.com (Postfix) with SMTP id DD29F2A6038E;
	Wed,  7 Oct 2026 11:44:25 -0700 (PDT)
Received: (nullmailer pid 622492 invoked by uid 1000);
	Wed, 07 Oct 2026 18:44:25 -0000
From: Christopher Hoover <ch@murgatroid.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Lechner <dlechner@baylibre.com>, nuno.sa@analog.com,
        Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christopher Hoover <ch@murgatroid.com>
Subject: [PATCH v2 0/3] iio: hid-sensors: fix shared callbacks in temperature and humidity
Date: Wed,  7 Oct 2026 11:44:20 -0700
Message-ID: <20261007184423.622445-1-ch@murgatroid.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261007072329.27806-1-ch@murgatroid.com>
References: <20261007072329.27806-1-ch@murgatroid.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Sonic-CAuth: UmFuZG9tSVaV/tSEHXISm56HxxKVer7saajs1T7DJkWHX1nlUbXqRkLOwW+nJW4c4wXyMdwZqnlQTKq4uZ51exWhoac8NEXdzK/Yxh0g6/g=
X-Sonic-ID: C;AJveHn/C8RGmzpcllaD8vQ== M;nhX4Hn/C8RGmzpcllaD8vQ==
X-Spam-Flag: Unknown
X-Sonic-Spam-Details: not scanned (too big) by cerberusd

hid-sensor-temperature and hid-sensor-humidity share one static
struct hid_sensor_hub_callbacks across instances and overwrite its pdev
on every probe.  With two temperature sensors, reports for one go to
the other's pdev; once that device is removed,
temperature_capture_sample() dereferences NULL.  I hit this on 7.0
with two uhid-created sensors.

Patches 2-3 make the callbacks per instance, as the other HID sensor
drivers do.  Patch 1 makes sensor_hub_remove_callback() take
pdata->lock, as sensor_hub_raw_event() does, so a report racing an
unbind cannot call through the freed callbacks.

Changes in v2:
- New patch 1, for the use-after-free on unbind found by the Sashiko
  review of v1.

Christopher Hoover (3):
  HID: hid-sensor-hub: Synchronize callback removal with raw events
  iio: temperature: hid-sensor-temperature: Use per-instance callbacks
  iio: humidity: hid-sensor-humidity: Use per-instance callbacks

 drivers/hid/hid-sensor-hub.c                     | 12 ++++++++++--
 drivers/iio/humidity/hid-sensor-humidity.c       | 12 +++++-------
 drivers/iio/temperature/hid-sensor-temperature.c | 12 +++++-------
 3 files changed, 20 insertions(+), 16 deletions(-)


base-commit: 9ee8306121495d2a25aa5d1bfd519f2748786b83
-- 
2.43.0

