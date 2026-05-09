Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F5A38F64F
	for <linux-input@vger.kernel.org>; Sat,  9 May 2026 10:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778321449; cv=none; b=U4N3gzUN6kQ+OdPeo8OULfxFTEs5nSNPAKWylVLhgkLgymW+OiG0jfknPt0ooauBVZr/e61isMAszb9nIZ7ZxH8zyWGTCKryJzhXNAez+MovC3ldu37JHc8snbdBK6hpi9IZ/CuYAsAej6k7D0mku1nB8GndxllKTzvfGsYgOP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778321449; c=relaxed/simple;
	bh=imSvFWSPZJsqCiaQAvqUUX1olJ0U+Qq55nTAqb4f6so=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gn9ngTXrGi6JyyGy1uwmeS4DQzrC2CZcPMPNPZinnP2jVx9L2L5LrX47pfdF7is8zJeTB8fZ1vTbNvTyzsJDAyr19aqwyCeYAtH6+N5Y6Wr6MlZInJ8rCn0xLLtOkeaxb2NTmEYNmIwcakSkVshJGNHv+X/j8pjY6ROSE6kgYlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bXhPJbQ9; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bXhPJbQ9"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2b788a98557so21029275ad.2
        for <linux-input@vger.kernel.org>; Sat, 09 May 2026 03:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778321447; x=1778926247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+lxJoYEZ8Ybj1lGvfbGDkfOWzh5gi1tYExfj34Qe4aQ=;
        b=bXhPJbQ9ABV5nUnB3V4Gw5ZLWYEHb6z1lTo+Yz0xOvfVZafaDxaLMwEQsmN7qU7e7e
         0SJFA6l161siKg7VuLz/Xk8qkFyTfFjRoNa65jpEo0vDKdDeRzUssNAzdvWxdwmpjS2P
         Ezd43ymwIVfzB5D1YEdLxhTRNZWSvUDFnhG89x2i+dFzAH7G70Oir08aeDeb70nj3kXU
         eFKDLI2NCQMWitKGZtxH3KuVYaWvd9/7kfXegwETINSRqVXSkekRQm7h2ol63ZU65SyB
         WixLJ/atnLY/1qbFkFygs5n1a5kLbyBmAbypK3ZA30vgxQhYCch2FAJeC0MTbVsgX3vc
         UE7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778321447; x=1778926247;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+lxJoYEZ8Ybj1lGvfbGDkfOWzh5gi1tYExfj34Qe4aQ=;
        b=H3SrQyE2A92xAoE4Zu/ycZ1+WdQOv9Km3LbMFTWgv2zIBqcdSQ8YRt34lYWVyiNqVj
         CnUVuYhiIUZz5OC+wDQLxA6e71NFEZsp8tIoin7QocJc+elPLfuhNzNkpQkDJ1zGXEC9
         toeuW1/UtoKdoM1ZMa1CNZophcuW6pdFwioHp92WOiWci+aS75ItLP/sPfyfVepFv51x
         SkmTSzOVhTLnm29YUu/6VVVI/IKPgG8FAIsuV+DaDDg9oE6k0BYKyOJOLx5OYdXOZ7pD
         Qt9yuCL8U174DI9R2UGf2xyc/ecmgbEF+DJsdQ2f7pcp0HwA42wDyPtVq+weAQkr/uPL
         hVbQ==
X-Forwarded-Encrypted: i=1; AFNElJ/zEgHsVu0N/YqqYDBWunMzbWxGITtbd0mfotHQ3JMc5LZo+bZCNiYwEzzbzTDbRKsQ074VQsC7G3sIcQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwxjF7JGeCTqubu/Tc7056I4lLkXlJ3SZ6DXR1fZ0Mc7C57G1Y7
	qcJ5WUxgWJS8XtCvdC7o7ftnfdlRf9KFnEMLT6PMsFVKQ1aReOe5SHl5
X-Gm-Gg: Acq92OG9W4wd/ZIgQ0zOuL456N1wIW2YcvCXXHfNBCacNtsOysHBfcHPZY1Zss3k1ai
	BmAvNvxbHOKEkmEq89E5Ndf033lZm1a8ekfUkHKzVHR5IeRwE0kKoOve918Y2mWaei3qYmK0sGw
	MVcu4b9Ghl9YrfwYW4VJSri3cHs+1V7U2LoymxGnbirzGvAH4Fzv3J+W/3T0gmg0NcEwTYAqjln
	alCKrRLYNJD9dScbhzEvFx1cg6Hj6FoUw8JAvjcFNFxZKgXkBkio/Z6tiNVuhyuy88uhnvcLDKw
	t0JRFw9ObuMXPnWKqL/qcbaV0AMisSHC3DOrnUN8U8itWb8lP5ecUTmukfZXGU+DKGXhJm8znFh
	BrqMos3AyLyWebQFibZ18kixQlgHB0UipjijWRmsiFNNFWWxeStq7FWafHfR3hXVVRNhSSBCGpD
	x78/Y/mIebTIKijySzrNQOs9cXHW4EbixoU+dWYhOIYMvBUkTL
X-Received: by 2002:a17:902:d50e:b0:2b7:a1ff:b239 with SMTP id d9443c01a7336-2baf0d27e04mr61363515ad.14.1778321447037;
        Sat, 09 May 2026 03:10:47 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e83084sm47335365ad.61.2026.05.09.03.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 03:10:46 -0700 (PDT)
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
Subject: [PATCH v3 0/9] iio: introduce devm_ API for hid sensro setup and cleanup
Date: Sat,  9 May 2026 15:40:31 +0530
Message-Id: <20260509101040.791404-1-sanjayembedded@gmail.com>
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
- few cleanup and prepratory changes before updating driver for devm_
- few sample driver update using devm conversion to auto release resource

changes in v3:
- Added cleanup and prepratory changes before adding devm_ API
  conversion based on self review: 0002, 0004, 0006, 0007 and 0008
- Address andy's review comment on commit message and coding style
- v2 series -> https://lore.kernel.org/all/20260429175918.2541914-1-sanjayembedded@gmail.com/
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


Sanjay Chitroda (9):
  iio: hid-sensors: drop redundant iio_dev argument
  iio: hid-sensors: cleanup codestyle warning
  iio: hid-sensors: introduce device managed API
  iio: gyro: hid-sensor-gyro-3d: cleanup codestyle warning
  iio: gyro: hid-sensor-gyro-3d: drop hid_sensor_remove_trigger() using
    devm API
  iio: humidity: hid-sensor-humidity: cleanup codestyle check
  iio: humidity: hid-sensor-humidity: use common device for devres
  iio: humidity: hid-sensor-humidity: use local struct device
  iio: humidity: hid-sensor-humidity: drop hid_sensor_remove_trigger()
    using devm API

 drivers/iio/accel/hid-sensor-accel-3d.c       |  4 +-
 .../common/hid-sensors/hid-sensor-trigger.c   | 24 +++++++-
 .../common/hid-sensors/hid-sensor-trigger.h   |  5 +-
 drivers/iio/gyro/hid-sensor-gyro-3d.c         | 16 ++---
 drivers/iio/humidity/hid-sensor-humidity.c    | 61 +++++++++----------
 drivers/iio/light/hid-sensor-als.c            |  4 +-
 drivers/iio/light/hid-sensor-prox.c           |  4 +-
 drivers/iio/magnetometer/hid-sensor-magn-3d.c |  4 +-
 drivers/iio/orientation/hid-sensor-incl-3d.c  |  4 +-
 drivers/iio/orientation/hid-sensor-rotation.c |  4 +-
 .../position/hid-sensor-custom-intel-hinge.c  |  4 +-
 drivers/iio/pressure/hid-sensor-press.c       |  4 +-
 .../iio/temperature/hid-sensor-temperature.c  |  4 +-
 13 files changed, 78 insertions(+), 64 deletions(-)


base-commit: 39b80c5c9830d12d2d6531059001301c4265322a
-- 
2.34.1

