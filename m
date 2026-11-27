Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795775674;
	b=QEHTp60rOubjalqQmwlWDm9j8L/cdYVW/dbr44whdvdWS64S2bEhM3xr28JbLOizHNG7
	 JuP892VkfmAtpO+9PLNJQrpjMhQrJTJjgZMZ/pobPKDDXEnyNEocipW6mnqY2rYNx2Xwv
	 ke133ebTvzFkTRZNWvI4R+Rr5PYVbNVbEB3lY5iV1o7jjr3LPcABwSEsPkptCaLYfhchh
	 ANe3VMdqQW+XMcSl9u9mJqXLT5VIRUQAZOsW43D4IogtVT1Y98TiAlOL/0r4USVY+08EZ
	 kdp5K1IqMqJdAhfU2rBj0gM3J1kQMnGs+IqDJhk6T1VRK9h8PgJ1vrPGD1EibwLU7qg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795775674;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Ij3mQ3ClSVA8TNXH+CBSqBM6B2MFef1TZGCDXnJ2u+0=;
	b=Io7RB6V4m7eImXABC4lqwsMZbENdOp7VnvFXu70nBzSFocHbE9OxZ88k9SYgLrKcPZTb
	 RYgOTKlAgQxBFNlVD/PnG2K3rh2KSZHFF+L/mQMQRc51r43KgAykMx3IOT+PjRLEzcQjf
	 ydAoRAoI7uqXP9npghBNEMi2d7wpbP9pkZjfqLi0Qn+C5wGUwPVo/numjB426GoeLNOlw
	 cVTD7O/dtd/2GAHEUnGBOwIhyykkIgV8MYHBC9y3rJl5lVD4hPcaAOzZv2FK9T9pUGMIb
	 2MvT3cCWC2vK0iscZ+d+q4PEr4ilpmoOSE05ZlticDEBsAcMuuNjQolo1a4NbD/2JgQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A9w33v2T;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338DD606A326;
	Fri, 27 Nov 2026 10:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A9w33v2T
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795775673;
	b=KgnO4/u3d5hua0f30Osc0NASDtlu+ZKhrKfCpewNwc6ohF5ZNV74mD6HqD+JZpKiQSLU
	 rucegUD20Xplh/D6unwHjBFhj/LJCbDkxofUBW9SYHO/+O+VMu2lOvxxqqwRnAmmVTzLD
	 NW51TpKAOH1WNKQXTquRX/2dLK+3boUbjTJy5B5D1B6lvQYNYwpyNf5KsYFWT8pry0F7y
	 Ds+6XMqksX0uZEDOIIobA6mKv4w4X0JmLD430vVTxAkFRu5v849OXV1PwB7py5oI+6tph
	 da8d9hFE3AyMeP+Xwpt0K7sB4pXXQpwq1iu3GSsSVUm7CL/UoSp9FTxXT7UO+w2qpHQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795775673;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Ij3mQ3ClSVA8TNXH+CBSqBM6B2MFef1TZGCDXnJ2u+0=;
	b=gPyFjqOu0bCqsGb9grBcrk1xFCnvBYS2IcU7bdU7gKyUtxxuERd4+W1YAYkIj1Q3rSWp
	 ISqfZquAQYP4ZVCgXsFb62JmwPE+kr6G+lOqn+GVZf62aA2+mldMJ5EQY86qvGkvaFJAV
	 Q+X/JjY2zAGqjNlvxDFfij9jIS2QIDvxXjMnoGOYOpv23A8pek+K8vh/34GPIIZwtT8hU
	 mC9Fa8U9sTGtBJWROkIwLTHyKOWTBcDtrZC0XSt7icHoFs8gysoJNmnZLbIJTTBi/xtRr
	 TvOTjWU0HjvKL7KxPvbpPx6IY4QBy1Yf3zoBVKcRlBHWgKXzkkorn78qdXFe3OYthXQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id AFF3F1F0089F;
	Fri, 27 Nov 2026 10:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795775673;
	bh=Ij3mQ3ClSVA8TNXH+CBSqBM6B2MFef1TZGCDXnJ2u+0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=A9w33v2THgiUvEaSxKiR1XkaKj6NuYpaVE9cPjrmdaqtAoiEqwHKqqIGGXTd05RIT
	 APzZ3XW4Lk/y9e25QPRW3hHOQo8FGtO6SXuIRIUxNf62haKpakzvl5wTmB1zqFWc6p
	 665YKceNKGHBKuWjXLVfT3GoSto0pniJfe2XZMlJvpv/8GvD0YzcCJcfgV6qCKgoPo
	 D4mlO43lkIaS0s5Ix0FDejFRSlyOakrFgRb3M2vtLOlWDwxz1YXdi2gD8oMGYbMnaK
	 TAtf/G1CBBP9N6iDYC7viOFeRJ0gmvfmFvt8CiKDvrYdmfT6gupDr/FK7Ds77shCkq
	 gNbGpp/Dhw5rw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 7E01F4B73B;
	Fri, 27 Nov 2026 10:34:17 +0000 (UTC)
From: Sanjay Chitroda via B4 Relay <devnull+sanjayembeddedse.gmail.com@kernel.org>
Date: Fri, 27 Nov 2026 16:04:00 +0530
Subject: [PATCH v2 5/7] iio: add probe error messages to hid humidity and
 temperature drivers
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
Message-Id: <20261127-19-oct-hid-iio-unified-print-framework-v2-5-3f476fe1a940@gmail.com>
References: <20261127-19-oct-hid-iio-unified-print-framework-v2-0-3f476fe1a940@gmail.com>
In-Reply-To: <20261127-19-oct-hid-iio-unified-print-framework-v2-0-3f476fe1a940@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-input@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795775655; l=2747;
 i=sanjayembeddedse@gmail.com; s=20260702; h=from:subject:message-id;
 bh=ZN+WHoqE9qU2ewu4pc1p2V/3TtyK73/jGZBLtNQtK8w=;
 b=dB/qKhcUNlC1QUpZbrpr9ulUu09qcXXAYyfTb90k97kqd0YbfgkOJP+ogvbZZRQt2lkj9XH9p
 wTmE7pJTrTyDnuozWdykqgjHc8QCFL7SuES4GqDSaW/FEkmK7y0+0pQ
X-Developer-Key: i=sanjayembeddedse@gmail.com; a=ed25519;
 pk=PcneEFtkmY+Ldl+KmOTpB/Q/HDsqko6Fb0/Z/5cuycI=
X-Endpoint-Received: by B4 Relay for sanjayembeddedse@gmail.com/20260702
 with auth_id=848
X-Original-From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Reply-To: sanjayembeddedse@gmail.com
Content-Transfer-Encoding: 7bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

hid_sensor_parse_common_attributes() and the driver-specific
*_parse_report() helpers may fail during probe without emitting any
diagnostic information. Add error messages for these failure paths so
that probe failures can be more easily identified from kernel logs,
while preserving the original error codes.

This also improves consistency with other HID IIO drivers that provide
probe-time diagnostics.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/humidity/hid-sensor-humidity.c       | 4 ++--
 drivers/iio/temperature/hid-sensor-temperature.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/humidity/hid-sensor-humidity.c b/drivers/iio/humidity/hid-sensor-humidity.c
index 95dc4c4726f2..388a7b02fa1d 100644
--- a/drivers/iio/humidity/hid-sensor-humidity.c
+++ b/drivers/iio/humidity/hid-sensor-humidity.c
@@ -210,7 +210,7 @@ static int hid_humidity_probe(struct platform_device *pdev)
 					humidity_sensitivity_addresses,
 					ARRAY_SIZE(humidity_sensitivity_addresses));
 	if (ret)
-		return ret;
+		return dev_err_probe(dev, ret, "failed to setup common attributes\n");
 
 	humid_chans = devm_kmemdup(&pdev->dev, humidity_channels,
 				   sizeof(humidity_channels), GFP_KERNEL);
@@ -220,7 +220,7 @@ static int hid_humidity_probe(struct platform_device *pdev)
 	ret = humidity_parse_report(pdev, hsdev, humid_chans,
 				    HID_USAGE_SENSOR_HUMIDITY, humid_st);
 	if (ret)
-		return ret;
+		return dev_err_probe(dev, ret, "failed to setup attributes\n");
 
 	indio_dev->channels = humid_chans;
 	indio_dev->num_channels = ARRAY_SIZE(humidity_channels);
diff --git a/drivers/iio/temperature/hid-sensor-temperature.c b/drivers/iio/temperature/hid-sensor-temperature.c
index 6c112b444627..ef657c1cb043 100644
--- a/drivers/iio/temperature/hid-sensor-temperature.c
+++ b/drivers/iio/temperature/hid-sensor-temperature.c
@@ -207,7 +207,7 @@ static int hid_temperature_probe(struct platform_device *pdev)
 					temperature_sensitivity_addresses,
 					ARRAY_SIZE(temperature_sensitivity_addresses));
 	if (ret)
-		return ret;
+		return dev_err_probe(dev, ret, "failed to setup common attributes\n");
 
 	temp_chans = devm_kmemdup(&pdev->dev, temperature_channels,
 				  sizeof(temperature_channels), GFP_KERNEL);
@@ -217,7 +217,7 @@ static int hid_temperature_probe(struct platform_device *pdev)
 	ret = temperature_parse_report(pdev, hsdev, temp_chans,
 				       HID_USAGE_SENSOR_TEMPERATURE, temp_st);
 	if (ret)
-		return ret;
+		return dev_err_probe(dev, ret, "failed to setup attributes\n");
 
 	indio_dev->channels = temp_chans;
 	indio_dev->num_channels = ARRAY_SIZE(temperature_channels);

-- 
2.34.1


