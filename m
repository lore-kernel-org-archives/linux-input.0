Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6557F3B9D9C
	for <linux-input@vger.kernel.org>; Tue, 28 Apr 2026 07:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777360582; cv=none; b=uX3jBBCGEbmF21xrkAob1IN40X7LrEHWfSEekCUxL2hnFZHN+HnQrWPsrC1TBnpsY+eJkVAkfJUc9+otrw7j06ZEMJksmiAWo3sA/yTSRMY1tMDK2nLrYnWZOS3QqlZT+/ng73J9F7+WTl9l5MM+W0yEzGncLZ7XAJwDALHI7S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777360582; c=relaxed/simple;
	bh=vnQVADDxQ0ttdYZpf97F0FvwlAmDKtuJ+IcyZBRg7gc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=G6IEAAB6yIYUiFNbd8Z5rosFQiRjpaObEoHqUHe60+RVpzDgDFgBvLtv1DEyP+MBVdhDjKCfIkS+JyQfQWECyaCbnoEGYaZjVKKt6F8bdA9PvfUm9dIuCmY9yOiNr+xTnrvgw7ustkl+CIyP6dhnyC/ppWBcbZHY4EzTyEfEQZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IaUrad+H; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IaUrad+H"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c795f441ff7so7643793a12.2
        for <linux-input@vger.kernel.org>; Tue, 28 Apr 2026 00:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777360580; x=1777965380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VzVQi/4uRerG6QDvEL4eh9INtxekMjFaRMwVGPZBDjw=;
        b=IaUrad+HtrmT3IuwKqnF4KABvAgmBt4T+2G6fOaJmBmqjdTF0ZBJTSy46eIBoUaONF
         ZMr04A5m07U/MCJIQxhpM+t0kbWcvRC/F/g6x4HEsH7QqDwuY+HbTmyK8HkmHhdT6w8k
         9k+ICUsU3fX/y5bDUG4DFL+0hsNIsY8P5+jpIH3P2sAqIw5Dmg2kqTBOYRsL/wB7ZHme
         OIhbSEY7NcjkM2fOntrtKyK+8Bm/cgzPn7c5rnvFUA9HXk+TubXUqegTyeTyXWSuk6Xb
         5ExKhbPBy8KGYIEFyFT1XB8ibbp4mqqdcHubdg7cgvf1NjcMbqh9aauonHV7cWxFi4qw
         5WYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777360580; x=1777965380;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VzVQi/4uRerG6QDvEL4eh9INtxekMjFaRMwVGPZBDjw=;
        b=gIbjg06p2n47cNxVkpTEkB31Hl0zevYbd7r/oKuRf4yJvxTtZgqFreG4t9TT4iTV40
         qtLp1nBu7V32UgQxk+ZAEbD0K4pVnvEjXAtZKL6qpXqjwzGwiwuea6h8vTkHvDKrWEQ2
         1Cmbdba+IgCm6ZEt5OH0xhRR7HwkuImg0iWgDO+AwT5nLEbd/pKG9QqdJXS0Cp3oSE1C
         4bdGTT/J/VZT0fw/0yF0hoNNVqG4AX3MzdIivU7xMJemVlpGBwiqhcihabn+JqGhcLvC
         Ux7eh9/3ikKQChko30S7bIvWlBBIooQt4RiEs4xo08SdYTbpH3lKp1AYeGnF6zRzjDiv
         i0NA==
X-Forwarded-Encrypted: i=1; AFNElJ+2WR0ZwOO2uOWLfIGZGt+HPQa6J79RR88NLDYNTzBo6hhyG8ddudCgQthAtvGkraUzrH23dOuUxE3kyQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzVyw88jhsPk5NMpgbytPvCm87X91oOvsd/XxJ60GC6OP+438e/
	N85T5DZVY4TGG4us6FcF5Mf3WPjpK7PpL4SzcREhoq05Md/f6DIsqxWC
X-Gm-Gg: AeBDiesQ4Lmg4bLJeK3N2xKAgnagaUUXnh1Vwm4GGV+tdkWm9t5MbBcXcmaMmhTRSnn
	NmDUaOZwka+yMpwPwgsVnFvNVi0GvP+2iG+6gt6JDsu15dgT/ZY1wzPGcWwhK1+b24OdFi2LEBX
	kV7Ib4lJVl5BMOMHyr4/3njvmWn3MhvZLaZuC45O3KC2COZz+MNn5o0Nndh42FP+NAaWcgYZPtm
	X4M350Qtkkg/45SvH5BwDgO1DuLp2taKBoUaaDuZ2O9NGiU3Q+tNv+Au6YJpwy19QdTYqeRx3uO
	OC8RiqfPOwTnDgRdzb8OV0/f8081FmlvvJWqsfIHo6pA4Nsb5XShpYHdoElh8/jYQuB0AyRbhro
	cKDtI4kXCM3OK8r+ldAKNeodSDIQwUd2yErTpNUX5vlXSWYPpQWudyDQQUvERIl6sVFEo6GEzlT
	MlNbB9ldrK/qkpW+WyZoALtgdVicxUBV9VzdVb42SQxJSASrSz7Dnkvkmi8ZM=
X-Received: by 2002:a05:6a21:6da2:b0:3a2:f14a:4275 with SMTP id adf61e73a8af0-3a39c062af9mr2437037637.6.1777360579637;
        Tue, 28 Apr 2026 00:16:19 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834daf5705fsm1987335b3a.42.2026.04.28.00.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 00:16:19 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: jikos@kernel.org,
	jic23@kernel.org,
	srinivas.pandruvada@linux.intel.com
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	sakari.ailus@linux.intel.com,
	sanjayembeddedse@gmail.com,
	linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 00/10] iio: drop redundant iio_dev argument from hid_sensor_remove_trigger()
Date: Tue, 28 Apr 2026 12:46:03 +0530
Message-Id: <20260428071613.1134053-1-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

The iio_dev argument has been unused since buffer cleanup moved out of
hid_sensor_remove_trigger(). All required resources are tracked via
hid_sensor_common, making the extra argument redundant and allowing
future devm conversion.

This is a mechanical change with no functional impact.

Testing:
  - Compiled with W=1
  - Build-tested on QEMU x86_64

Feedback and reviews are very welcome.

Thanks,
Sanjay Chitroda

Sanjay Chitroda (10):
  iio: hid-sensors: drop redundant iio_dev argument
  iio: orientation: adapt to hid_sensor_remove_trigger() API change
  iio: gyro: adapt to hid_sensor_remove_trigger() API change
  iio: pressure: adapt to hid_sensor_remove_trigger() API change
  iio: temperature: adapt to hid_sensor_remove_trigger() API change
  iio: humidity: adapt to hid_sensor_remove_trigger() API change
  iio: light: adapt to hid_sensor_remove_trigger() API change
  iio: magnetometer: adapt to hid_sensor_remove_trigger() API change
  iio: position: adapt to hid_sensor_remove_trigger() API change
  iio: accel: adapt to hid_sensor_remove_trigger() API change

 drivers/iio/accel/hid-sensor-accel-3d.c              | 4 ++--
 drivers/iio/common/hid-sensors/hid-sensor-trigger.c  | 3 +--
 drivers/iio/common/hid-sensors/hid-sensor-trigger.h  | 3 +--
 drivers/iio/gyro/hid-sensor-gyro-3d.c                | 4 ++--
 drivers/iio/humidity/hid-sensor-humidity.c           | 4 ++--
 drivers/iio/light/hid-sensor-als.c                   | 4 ++--
 drivers/iio/light/hid-sensor-prox.c                  | 4 ++--
 drivers/iio/magnetometer/hid-sensor-magn-3d.c        | 4 ++--
 drivers/iio/orientation/hid-sensor-incl-3d.c         | 4 ++--
 drivers/iio/orientation/hid-sensor-rotation.c        | 4 ++--
 drivers/iio/position/hid-sensor-custom-intel-hinge.c | 4 ++--
 drivers/iio/pressure/hid-sensor-press.c              | 4 ++--
 drivers/iio/temperature/hid-sensor-temperature.c     | 4 ++--
 13 files changed, 24 insertions(+), 26 deletions(-)


base-commit: eade2b843d9b1f668fc1775f15611bb0a1999cd9
-- 
2.34.1

