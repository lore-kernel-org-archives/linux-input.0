Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795775661;
	b=DLz4pXpo0Uln43xLomy3v9h2xC4Tt9W201WsHCtjt/qEsZWw1OA70mC8UkjqE3QRqQuP
	 H+dRS41/FztIL6U3S3swbWpRaAxqsLziGCx+LzwOofHd6FIft59vPs8HwLyPnaDipttc6
	 VKyO701wvO1EfnwyCGAPdR3cdVzse7Fh4sS73iGmMdHY86NyM+xt9cNWY5UzSjKlYRu4p
	 VSyqZTO6p4vMz/1TrJPy0Mof0WkFSO09sl0rzczSOoxV29LuPTfLqRJ+Qsg51arhek12g
	 WhrJ1B7EgVEW/5oqYe13s3x3ujrq4jHtsEIb923Pc5lXyha1yKWJoWmzTVeZipJg9jw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795775661;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=tMGi+Yl6ZTBHcuv1gt6hp4FC69lLDvL+UUgvj1mnEek=;
	b=wb2GoKP/lEqicmmJ1zfcKz9zWBHz2vHa6aQRutCn7m1zbUgpKawTL/tKYQfTazp7omfV
	 IHPKr+cdAVA+++B1UqJzrPcGNt2o3MYnQq3zseLQH385F5g3yGggxrQFgl0cxn0Pl+F7/
	 7XO18S2dGLj/XDQdupat/5ZiosR3julO8aqoHqJiIu396I4USCu1STgl0Zk7Dg56/L/vy
	 9e9jXK3t07vwNQDRVVr4EnQ8rw8vM7/PUjtBSGEB6sFbj0BUH9b6ZcL/EMdiFJkc440S1
	 /nKsflLYAML0lFgZMYKIiJHyOIMd5fB6nXVVGF9pqv3X6k/gtoXaBZ7aNNq/wrcviFw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HUUebXsU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93950606A31C;
	Fri, 27 Nov 2026 10:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HUUebXsU
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795775660;
	b=mFqZlIs5yspr64knPiPrEc2vVjCJPtUWNPraCWFMtTqOqWI80cykSOXL4TIA8F++NDkL
	 +Ei13jE+9n14PAT/ZNosm699/lNhF5ZXwoDsanXzerTXgqT4wQAYtK2Nf1+Zo5j1ks+5v
	 TL8DQm8h7CVzoleJNToEb42X4rAmrHbiPIPiLHSoZtMwpfP4nyyQz2ORTL3/55cC1OfUZ
	 28x0Ua2DYfzRX08tsq0FEf8m0ikCm2kaLvBcoKjfujeQVEpU4q/yO8V/sC8GqU6+Qif2l
	 plaT4rrww5YDio/P+JRixOcqbvt5Nk+akMU/UTuX4aM+hWQWqH5MBmOIg9bKlcT8GlQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795775660;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=tMGi+Yl6ZTBHcuv1gt6hp4FC69lLDvL+UUgvj1mnEek=;
	b=tNX26NbgzT8twDxCPdfpOiTNspw9n3AaVezAfz5gMHJUr0CUpwi1yu0JfyHIg+y/SSJJ
	 HZnj3T19AA59cfrQ/tY4oXPPdk2RUDfkrJQDTKnkNtX1UXclzQvwUH9SMERLzJLrjG4eU
	 8qvvscjLoMXFeXQl6a0mcmLVq6xMtIWUT5+qjFPDrsXzYdeaMAC/DB4nc92MOHCpb510X
	 qtUeHpmchUal06LCn41vkTSEryqzud4grv8pTxZaGgnQBwLmq2v3e4RR1/NZ1v1w9pQ/Y
	 RX6mwUFx/W02Tnwy4o0rROfz39XuZsD1bZd9C+9nV6Y6JhTfEqLZSAX7xra/ISCKyQw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 4C3451F00898;
	Fri, 27 Nov 2026 10:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795775660;
	bh=tMGi+Yl6ZTBHcuv1gt6hp4FC69lLDvL+UUgvj1mnEek=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=HUUebXsUucma7xm6Ed5DQHvdpMcR1oJYTbPuHTu1iPtuyuXDFsvJRMXSkoz/aL6V4
	 OZqU2BMQDRJcEIUoPlwy8patTOdrJsmHWiMs1fLOLCZfiseNIOYOr/LIiul32ZjZYf
	 j3ErUFkorrLj8a7yfxu/dUKRw7rFdIdH5rfMKm0UhGx6K2xKeB5ULMUwrLzWcj6UkF
	 1UWRNGgpNbHAOepeHK+UP5mBKohWh/x6DJs/h0RowXyI/AUd9ehaQzo1R0/04eDmbZ
	 ue/kI896HHtMMMp3JfICQ2F8n5lFUvj4iVObBbjts5OA9dC/rftcnh6qgf6MuveQ1s
	 g7DCL/a2hkR3A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id C28C14B72B;
	Fri, 27 Nov 2026 10:34:16 +0000 (UTC)
From: Sanjay Chitroda via B4 Relay <devnull+sanjayembeddedse.gmail.com@kernel.org>
Subject: [PATCH v2 0/7] HID: iio: Unify probe-path logging
Date: Fri, 27 Nov 2026 16:03:55 +0530
Message-Id: <20261127-19-oct-hid-iio-unified-print-framework-v2-0-3f476fe1a940@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAJNcCWsC/42OTQ6CMBSEr2K69pm2CBVX3sOwgP7AU2lJW1BDu
 LsFLmAymy+ZzDczCdqjDuR6mInXEwZ0NgE/HojsattqQJWYcMoLRlkJKU5G6FABooPRokGtYPB
 oIxhf9/rt/BMyeRHiLJiRIiNpbPDa4GcT3audw9g8tIzr+troMETnv9uTia29Xcpo/q90YkCBN
 llBVZnnXJW3tq/xdZKuJ9WyLD8rOCJz7gAAAA==
X-Change-ID: 20261019-19-oct-hid-iio-unified-print-framework-3c877471fc73
To: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-input@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sanjay Chitroda <sanjayembeddedse@gmail.com>, 
 Joshua Crofts <crofts@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795775655; l=3783;
 i=sanjayembeddedse@gmail.com; s=20260702; h=from:subject:message-id;
 bh=bpNV8vBzENgP8GtCrU3v7oWc2k9XQlhvPB2UVdV3Xh8=;
 b=CbUH6/t9LfnZL7SYM7siPLQuJzPYug4GGTM2/cUjHt7j7sKOfcQ3f5a2hPrTWNFudMgHMVCiT
 bfDEaIJ2agLATa5lb8CW9zlWUxXNs0EFAUwAC8VdCKNcTqq45MSW6gO
X-Developer-Key: i=sanjayembeddedse@gmail.com; a=ed25519;
 pk=PcneEFtkmY+Ldl+KmOTpB/Q/HDsqko6Fb0/Z/5cuycI=
X-Endpoint-Received: by B4 Relay for sanjayembeddedse@gmail.com/20260702
 with auth_id=848
X-Original-From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Reply-To: sanjayembeddedse@gmail.com

This series provides consistent support for logs in probe() path for
HID IIO drivers with suggestion and input from Jonathan.

This is followup series on top of multiple sub-series submitted for HID
IIO device drivers which included fixes, devm support, cleanup and using
preferred kernel coding style. This series adopts a common logging
approach throughout the HID IIO device drivers in probe path.

The result is more consistent error reporting and improved
maintainability across the HID IIO subsystem for following drivers:
find drivers/iio/ -name "*hid*.c"
drivers/iio/orientation/hid-sensor-rotation.c
drivers/iio/orientation/hid-sensor-incl-3d.c
drivers/iio/gyro/hid-sensor-gyro-3d.c
drivers/iio/pressure/hid-sensor-press.c
drivers/iio/temperature/hid-sensor-temperature.c
drivers/iio/common/hid-sensors/hid-sensor-trigger.c
drivers/iio/common/hid-sensors/hid-sensor-attributes.c
drivers/iio/humidity/hid-sensor-humidity.c
drivers/iio/light/hid-sensor-prox.c
drivers/iio/light/hid-sensor-als.c
drivers/iio/magnetometer/hid-sensor-magn-3d.c
drivers/iio/position/hid-sensor-custom-intel-hinge.c
drivers/iio/accel/hid-sensor-accel-3d.c

Additionally, I have kept changes specific to logical diff instead of
driver specific and covered all HID IIO device drivers.

Testing:
  - Compiled with W=1 for each patch in series
PS:
- Sashiko reported an issue in a different driver and noted that it is not
  introduced by this series. I have taken this feedback into account and
  will address the actual issue in a separate series focus on that driver.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
Changes in v2:
- Following suggestion of Joshua, remove the comparison and change the
  checks to `if (ret)` as respective devm_*() API `return 0` on success.
- Link to v1: https://patch.msgid.link/20261105-19-oct-hid-iio-unified-print-framework-v1-0-0b360d9552d9@gmail.com

To: Jiri Kosina <jikos@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: David Lechner <dlechner@baylibre.com>
To: Nuno Sá <nuno.sa@analog.com>
To: Andy Shevchenko <andy@kernel.org>
Cc: linux-input@vger.kernel.org
Cc: linux-iio@vger.kernel.org

---
Sanjay Chitroda (7):
      iio: Remove redundant probe error messages for HID device drivers
      iio: Remove redundant devm_kmemdup() allocation failure messages
      iio: magnetometer: hid-sensor-magn-3d: drop redundant probe error messages
      iio: Use dev_err_probe() in HID IIO device drivers
      iio: add probe error messages to hid humidity and temperature drivers
      iio: Simplify trigger setup error checks
      iio: Simplify callback registration error checks

 drivers/iio/accel/hid-sensor-accel-3d.c            | 27 +++++---------
 drivers/iio/gyro/hid-sensor-gyro-3d.c              | 24 ++++---------
 drivers/iio/humidity/hid-sensor-humidity.c         |  4 +--
 drivers/iio/light/hid-sensor-als.c                 | 20 ++++-------
 drivers/iio/light/hid-sensor-prox.c                | 20 ++++-------
 drivers/iio/magnetometer/hid-sensor-magn-3d.c      | 41 ++++++----------------
 drivers/iio/orientation/hid-sensor-incl-3d.c       | 24 ++++---------
 drivers/iio/orientation/hid-sensor-rotation.c      | 20 ++++-------
 .../iio/position/hid-sensor-custom-intel-hinge.c   | 20 ++++-------
 drivers/iio/pressure/hid-sensor-press.c            | 24 ++++---------
 drivers/iio/temperature/hid-sensor-temperature.c   |  4 +--
 11 files changed, 69 insertions(+), 159 deletions(-)
---
base-commit: 39508411b82d4dc29dd245bb471ec9ecc1111c9d
change-id: 20261019-19-oct-hid-iio-unified-print-framework-3c877471fc73

Best regards,
--  
Sanjay Chitroda <sanjayembeddedse@gmail.com>


