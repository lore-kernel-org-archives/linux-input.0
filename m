Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793882517;
	b=X1OWEA6tV9pBQnz0E4fw2b9G+EwUtBOlbeefYV+jLPH6O58+Q0c7EeZ1hFbyP2csyD8Y
	 Fx5tphBD74un9j6oEvzQGGCm6tbx1l2MUX7k1gE3rBqoPVX60KpigiK6gVtjcoasuRjww
	 wAdnin6HipShGy6zFhOeI6lZuFztugUtiwOqq+HbIta2Kr1CfW9h1cXaIEDFnyrUunAt5
	 bs0JPFmGThZgWR5VOp35F3z4h0F4U3rNg9IQGezpLaCECrc8d7Dmnn5nveje4hPWBqvH+
	 fRsqwSXlnxf0zo/FO4QGPDsAqRRf29Pv19V1Ova3BfPsiY6vfx0bJQcqVnzS6QbxnoQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793882517;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=l/qbbO7JmGydwZC1EcnpWSgjOEhb2nm2cY0ukEZi4I8=;
	b=tXoM23TkYxdvtRH4M+HUsYsuBKOO5oTEhGTk5v/cQYNErZbL7RgG2FKsX45f2UFC0Ue2
	 AB7FnOMeIrEg1fxsUUFRuCAPe+vQ2H79ckynEUXj5FVNxP6/rHtZ9HkJ1D7eDzVXEz42L
	 unyDb23kwKDnNkbFLT8d/mMc3Tg9tRt2g3uUWdR76sFvoS3Ja9ceETr6j5rCrFFO+UWLD
	 u3f4r4FjKaWAd+oxikZnR+fM5gLeEOyiidm5+MtVEVUfKzCzCNCZVNlgQwUyhG8F/498b
	 1/0IcA6XHoNpUG8juVoIsPRrTXTlGQiNlZ7U8Iy/ZOqSu8WpkyotQ9jYlGnCiiin4zA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G2eGCuSS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38477606A31B;
	Thu,  5 Nov 2026 12:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G2eGCuSS
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793882516;
	b=E9/cZc2eX8yLZ9VM2sn9ufaEwnDv82PmEiy94MK61oyAw+HGvUuFtQIGwFv0C//EeB7Z
	 J8CG7ripLiMaVu3I/ftTgAly9OAG8haJWYSOdj1asuhndiVAwuz5VYP86wgrN41SOrLW7
	 iiiPV4Va04O3pUA0+V1BGtwNiGq+DHcoTqUNMgTNIijFwGM55zz+rxPXPk4mX8xgLNXq3
	 zp1sPQtxxfTtQmp1AU1ikdTYWtEfpDrVymJs4opu6xqX05kVwwEG9dsb0KVJcyYUhpvvc
	 ugN0uv+aKRa/asOF6yTxmp6LWkAxnmttq6J9nuyki/FBa75uxt2H3EcvwsqgqRqsyFA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793882516;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=l/qbbO7JmGydwZC1EcnpWSgjOEhb2nm2cY0ukEZi4I8=;
	b=LUTy9mcN+9b9ZN7ma4kIW4hhK5XOgAuEFK3jGOmzb++HIo1Ycw52R3WEObuhSRy8aANm
	 bUtHV1z9LHnKLEEvezDU9PjRq0gzO2GpzmbTAQ4f4tZF2jGqncy64FMIgYQmsjjATQG1i
	 smcSDIgCvrEj9aWdXizGIRZwLWArVx2H1obJVRlr+1XUsW6lb1adAaTYJcWCWcOXZMa2i
	 esrRaJYg6rUVm7GdeC42kCMwZS8O3PdiKQgBKJhn3iW5YJVl37Qkf2mVfRg0qpI6vVqfc
	 6JJJh2/ADtO+d/oklFm3BZA7p/6mqNKKH9w0YqbBf8sSlKNHLkFoyIAI2YAKbwO0qGg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 2695E1F00919;
	Thu,  5 Nov 2026 12:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793882516;
	bh=l/qbbO7JmGydwZC1EcnpWSgjOEhb2nm2cY0ukEZi4I8=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=G2eGCuSSoMqhnYP4NobzghmClj/6dT1afWN6FB6Bnld6HkffYZ9u3BqWXmtIHMIvz
	 acHY0yrF2JExqJdvGQ1l5scxHWjC+E/wnkLvqfcN3MN2Er7lmWvs9oq7HP1jOi1R0X
	 ZLGl/peDHYslR48F16Y9O+s366DCRhA79ogR9rMq5E9EOqgPWbgsRxr0XTvM1hhXAj
	 vVVjvLu3ISOdEQYd47W5/+l2IigrGCc5G/hj1LjJvEqRNcTLhQ6DNKOoUW8XtRjC3n
	 iXwpZy1kktF7esawCL4H1iu04BB72eQox8FSs02fJ+OniTPQPkEBIdwhmZjrpTNyp3
	 lQ5pvOSalljiA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 770084724A;
	Thu,  5 Nov 2026 12:41:55 +0000 (UTC)
From: Sanjay Chitroda via B4 Relay <devnull+sanjayembeddedse.gmail.com@kernel.org>
Subject: [PATCH 0/5] HID: iio: Unify probe-path logging
Date: Thu, 05 Nov 2026 18:11:42 +0530
Message-Id: <20261105-19-oct-hid-iio-unified-print-framework-v1-0-0b360d9552d9@gmail.com>
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
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIZ57GoC/yXNwQrCMBCE4Vcpe3ahacWoryIearKxo5iUTapC6
 bsbFebyXf5ZKItCMh2bhVSeyEixwmwacuMQr8Lw1dS13c605sB1yRUe4RlIPEcEiOdJEQsHHR7
 ySnrn3u2t3VoTnO2pxiaVgPfv6HT+O8+Xm7jyrdO6fgBS4dcKigAAAA==
X-Change-ID: 20261019-19-oct-hid-iio-unified-print-framework-3c877471fc73
To: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-input@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793882513; l=3071;
 i=sanjayembeddedse@gmail.com; s=20260702; h=from:subject:message-id;
 bh=KUIwC7C4lmG/Hcha3xTeg2sd4BInW8QwNzzTWWfozpA=;
 b=w1TLm6HD6ssb/ttsKDr0UeUvh0swdJPOkFXTyVI2ZLAV41S+CqJuxk6MtDwqzKZG+O5ehR8/N
 NSmC4YFukw9DwdCxexByvcrQrLOiZWCVnbHoEbzQt2xCk9y5Xr1G5CM
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
Sanjay Chitroda (5):
      iio: Remove redundant probe error messages for HID device drivers
      iio: Remove redundant devm_kmemdup() allocation failure messages
      iio: magnetometer: hid-sensor-magn-3d: drop redundant probe error messages
      iio: Use dev_err_probe() in HID IIO device drivers
      iio: add probe error messages to hid humidity and temperature drivers

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
base-commit: 20ce8ef9c9e04cd6c5ae0422e251a9b5936c6b7c
change-id: 20261019-19-oct-hid-iio-unified-print-framework-3c877471fc73

Best regards,
--  
Sanjay Chitroda <sanjayembeddedse@gmail.com>


