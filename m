Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC5B40B6E2
	for <linux-input@vger.kernel.org>; Wed, 29 Apr 2026 17:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777485568; cv=none; b=ZvlibcG+YnoTy/dkTsDuW6B8iWLDGyaFiikExmqQTEPgr6ogNYtvithtM+iGNGG86hNP7UauSc899QSD3n5cYUWFLz+osHdD4NImCl05txhd8DfHqQxNC/YAFFwYkf42Rm4cRSA0ekhLCbBHlk1vN25OWPxUStXrYBdTp52iUPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777485568; c=relaxed/simple;
	bh=tEsDhzgQpD6z1xtr2AY7zNaS0N4D+izezf7gcFPaDyU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Z9LyL3sZp0gLvAuBSJ2kuhYYmfk4pozM9EIy4Nxq8yq072QcNC2JMk64IrsHbLmIMnuQcSfyEJ4p2WxC4zcbp9vetOc5tKi/kfBCdSLDtBnZGKI1wjpeOs5YSuRIKmuCckcrfj66KHSqcwsTcL9o0enbG2G6YjRRud1IyHfTWU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RQlFvjxk; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RQlFvjxk"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2b24fcc2b5dso538045ad.1
        for <linux-input@vger.kernel.org>; Wed, 29 Apr 2026 10:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777485565; x=1778090365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yeu65uq8O/7w/mHdI25xEp1QrFf/nqZGrBbIfp7wJWk=;
        b=RQlFvjxknSXaGWN4WM3ru+ciqdi8lsdJpP/aIvwFlHTQ+DT4W/qHnPD0xWH27VTaq+
         i85NtLz7L5Pz/bNhyZsSqyR1Ub88WUoa5ektGF0dhP398YKk/452NbPlotDZrEur8qeb
         HqxArWVdrahDErmpvlAKBDJUYJP5tZXaxNP9h9No7yHWNqErbeq1+s0mKVtLAy3lC6i1
         J0nto7XIHnn7GxB5qeml4+nu3trwpMpmE/kU13qDK/Xs0tULo+j9iB3VL8NE9brMYrNh
         XycvaWK5O8jJyrdKRJap39SSPlyWEUeRQYFfXW96vFn3wkGo0u+m72T65ff2QlAuAwXj
         46mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777485565; x=1778090365;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yeu65uq8O/7w/mHdI25xEp1QrFf/nqZGrBbIfp7wJWk=;
        b=aPIuOKM4A3VgvXsGS6hP0zpYy9tCVhWgGruPV7QTHoK+s3koRWwB5l7evfrS+Xj22I
         CdqnzgHKVZIrLHyUVicKmQHq6JeXmhcdWs5rmr20jm37TO0CevJjwWZk3JdseRs+EB0g
         iNIYfsP6wMRgK4kG01gZ5rlpOl5kjsCpKbgxCh7JA8sMCoqlDQNj8/cvtnnqVuMSVaZL
         wyQWq6sVINj/aR+9IBKQ186ZQVQzkf3i+ypFY5iYwKNkpSM2JXufu65Bvcn4DU8jy+/N
         gS+6YKmV3Qyhk48KAa9dFlHsm2PzHp1ijTRi/rTXaxBh228RH3Sm/oS8/Bx/J0sZopB5
         TanA==
X-Forwarded-Encrypted: i=1; AFNElJ97HSsPD/H6+2vzqs6D8BTvqz0bb/efH91tolAyBbvc/QWaBTxHvWH2JOq9Df5+2Hhq6Hc5sm2641R/3w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwB6Y0QwHLQfxuYyKFY31OGHLm2scFzzTkYWq5ljoqa4wZhcU5h
	CN+tv99zGcYNb/pHFtpdu9o3BKRHxjtSy4VIvHcGn8CbTEOvXt7yDBVK
X-Gm-Gg: AeBDieuYH2/NgiyQmsS54f2iHbTruJmN6c4+tPwgXXbSp77FgQLmBUfhIhcQmQrwrPu
	VUaNDj7UNUCEC8l7XwigfV5o6TYCmNtzhTxHVItDnPIiuOxNnJ1Hhpky/UABV/dI+v3u+Wv6lo3
	CQa3nOP2xTDebagp3X7YBJnsCZ1MKIjL7Z0cIz+cP/tX4K+qABMg2NHwt0dy+oNyEj267k22n0B
	aMazR5Oq9pe15jwRZkbNYG59MFk1VKtbetR0JAUUY59hj12PkVRWTZ4rDO5iSsMJQy6rqXnGii+
	3vJQQUBvJF8XNa5HWEW0FHgqfdKeysIWVMDP3YV7ITwJMKtkrwvZ1AcA2BuRX0sGo2mKP6X+VyB
	NhoMoM/MmNR+elTxvQcOE04mtY00bZi2qyLpGMPnhEv5OrY3SErllRghyN2GbkqIkluIAQIgHFu
	gb4qs6FZ/kXeahGcYd5mUP0vhkU+y4bb4EK4h8VXwXXp/uYKUwrPObj7gPlIk=
X-Received: by 2002:a17:903:1a8d:b0:2b2:4e5c:69a9 with SMTP id d9443c01a7336-2b97c3e38damr78911685ad.5.1777485564935;
        Wed, 29 Apr 2026 10:59:24 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b98897edefsm27726805ad.74.2026.04.29.10.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 10:59:24 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: jikos@kernel.org,
	jic23@kernel.org,
	srinivas.pandruvada@linux.intel.com
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	sanjayembeddedse@gmail.com,
	sakari.ailus@linux.intel.com,
	linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] iio: introduce devm_ API for hid sensro setup and cleanup
Date: Wed, 29 Apr 2026 23:29:14 +0530
Message-Id: <20260429175918.2541914-1-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Key highlights:
- Prepare change as pre-requisite for devm conversion for HID IIO
  drivers by removing redundant argument
- Add devm API to setup trigger and clenaup resource using
  devm_add_action_or_reset()
- few sample driver update using devm conversion to auto release resource

changes in v2:
- Following input from Jonathan and Andy, squash initial patch v1
  series in single change as individual change should not break anything
- Add devm API support and two driver using the same
- v1 series -> https://lore.kernel.org/all/20260428071613.1134053-1-sanjayembedded@gmail.com/

Testing:
  - Compiled with W=1
  - Build-tested on QEMU x86_64

Based on further feedback and reviews, I would extend this series to convert all HID IIO driver to use devm_* API.

Thanks,
Sanjay Chitroda

Sanjay Chitroda (4):
  iio: hid-sensors: drop redundant iio_dev argument
  iio: hid-sensors: introduce device managed API
  iio: gyro: drop hid_sensor_remove_trigger() using devm API
  iio: humidity: drop hid_sensor_remove_trigger() using devm API

 drivers/iio/accel/hid-sensor-accel-3d.c       |  4 +--
 .../common/hid-sensors/hid-sensor-trigger.c   | 27 +++++++++++++++++--
 .../common/hid-sensors/hid-sensor-trigger.h   |  5 ++--
 drivers/iio/gyro/hid-sensor-gyro-3d.c         | 10 +++----
 drivers/iio/humidity/hid-sensor-humidity.c    | 10 +++----
 drivers/iio/light/hid-sensor-als.c            |  4 +--
 drivers/iio/light/hid-sensor-prox.c           |  4 +--
 drivers/iio/magnetometer/hid-sensor-magn-3d.c |  4 +--
 drivers/iio/orientation/hid-sensor-incl-3d.c  |  4 +--
 drivers/iio/orientation/hid-sensor-rotation.c |  4 +--
 .../position/hid-sensor-custom-intel-hinge.c  |  4 +--
 drivers/iio/pressure/hid-sensor-press.c       |  4 +--
 .../iio/temperature/hid-sensor-temperature.c  |  4 +--
 13 files changed, 52 insertions(+), 36 deletions(-)


base-commit: eade2b843d9b1f668fc1775f15611bb0a1999cd9
-- 
2.34.1

