Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE33D2C326D
	for <linux-input@vger.kernel.org>; Fri, 17 Apr 2026 23:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776466852; cv=none; b=a2GITyOF/IGNbQI3IElu7FoPTYBjlEYR6/htRfJEsuee+DdMBZXlG3MF1/dgjLTuJrfuqo55qHDeZSIjWg46khGyd3PzyLyjtHT421T/ePDkmXovxWlkN5InKw1+LLI4FZuPwAZrrBEl6OZBJc6hEPxOL71a6wYacyQyFN/pk3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776466852; c=relaxed/simple;
	bh=tnH/tm354C2LHKU1HohnWm2cykJvmp+fjPzvH4K81Zc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Y5uHa7NhBlRyUEgkKVWRMX23GlqlmWIcEAr4NAcFRW01WVZufRDxMuCu1kCBlcuEOLr8Bb5uTz/NTuOTXH82X/XjOHTof2fv+2iRq5PKatwdDyjlRqhGLqk7xVdcuSOXr8mypr2QHXE6DNVov7QQ4/n301UJ4d0RK++SC7ijDXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br; spf=pass smtp.mailfrom=ime.usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=Q5osMVK0; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="Q5osMVK0"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2c15849aa2cso1632701eec.0
        for <linux-input@vger.kernel.org>; Fri, 17 Apr 2026 16:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1776466848; x=1777071648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SaOUMlV4k+LOLbYB+ezceMJb46TNU8NlhAFEDoc0KOk=;
        b=Q5osMVK0q0lfzpYjPcCF/oIxpX9traB2iOmJwoUAAsjlRl9PMS1o0q+uhdoMmL8zjL
         NS8S4LXdpHzaUZfF4auEYaupSEJwzfBTooLG12VH7vfgFdKVQTamrlocTOhdmxasloUq
         /us9v77PfQBBgfvc0DjFzgW02Igmzkk99cvDrH5sfZYLlpxRDT8cqnamNy6BdOjhrQYt
         BwlMRxnuUSQgpl1fxuLAlLGb81GColIjWiVY1Y8AMeFSxWzxq/zo9tJWQJusjN8U58ZC
         ZjhII/M1f+7SbuNO45AFXCcpYqBxT44tBgTDw6KD/PNWOc32u8KvZ9AF4DUqj1jQcQRp
         4Vsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776466848; x=1777071648;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SaOUMlV4k+LOLbYB+ezceMJb46TNU8NlhAFEDoc0KOk=;
        b=q6USvk8YnYAT8Xg+gR6Clx8sd+9495bfwL5ryXFoQf0WFZI80hFUs4uZMhZrreoC4x
         Pn0Y0VXicI5bNRzoEsWyXpXFmQW6or/YueHHazef2zZAC7843xr6hgQw4/+Yqp306cKz
         X+lQyIGNUt4FCj+1lToRHsqDoCGIrnJWLdOWO6rlENwLz06HQmvR2+QphrAS7kNOX2wp
         OUWOljbazkFD5zRh1MTTPdKYSlBgt+DaV8mtQQ5GEvLpCmjd7yY61vtfwS+LVCkXTJMP
         osFNWDgO0j0Mn1z7flCd2B9Akf1xlERk/aiPpJpgdSyNrwhzYzGpn5QFTVOVAYWpW+dV
         wBzQ==
X-Forwarded-Encrypted: i=1; AFNElJ/BOmPHNAN0gEwB9yz0MeiyiBY/QFDwQuR99JnFHh0CNOPEDAYjDr+rohqnhmjhPJIy9OP+zCaHPTHkwA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyfVzDCrWS+7ChCwTPInLW1L/U4D942bhmMRtWZY5jT8cfVvRje
	6iSZracCFUZULsHxHqke7Z4iUPa2G0z8l1fMWezM8n1IpegGWkxF0OW5FYZYYK7BDz8=
X-Gm-Gg: AeBDiesDMJYquK38FlJwB7gB+JkJY2Wi+n4l1pQy83gRHglyDUjVXrJdA7Y9d/4IMMT
	vgOiXgmYaQ+zyFmLOCrkeIFo4JM5qXiQBghhe/7n6YZ4s5uq+LwZ+9th92+NUUkzByQSzsTgIwT
	7CTI7cdp/Ej6T5mbg+1IXk5Vy1JnUl3Bg4hkO2G+gNm+3GgP6wh40S6VSQLfp24p/lSQDIKLCfn
	V/s3pchViDOgSp5LmOej/gY02lshxcw3F76Ll5i2lC2lwX3omvtQLb2/8yGagoQxoqBa1voFTam
	Y2CnynYXNrt0EFgi+SkLiVnnKRNtfd5dn5Ox6Z5vuGEEtmL5Ja+V4V88lG3B6seMrOL89of5d5W
	+EjKHcVIfLr5fOIU0plHoXtp6kCLlDJSlfVhNuQ+u9UraY9VCSKrcQ4xcDwjPa/an1CzyHcfcF8
	nRA4lP6z3iuDbTl1xPpsWLZnoBrqoAYceZRTcSVA==
X-Received: by 2002:a05:7300:d70d:b0:2d3:f3fc:bb6b with SMTP id 5a478bee46e88-2e4646cca96mr2836393eec.1.1776466847775;
        Fri, 17 Apr 2026 16:00:47 -0700 (PDT)
Received: from natalia-pc ([187.116.73.68])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53ccce440sm4117637eec.14.2026.04.17.16.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 16:00:47 -0700 (PDT)
From: =?UTF-8?q?Nat=C3=A1lia=20Salvino=20Andr=C3=A9?= <natalia.andre@ime.usp.br>
To: andy@kernel.org,
	bentiss@kernel.org,
	dlechner@baylibre.com,
	jic23@kernel.org,
	jikos@kernel.org,
	nuno.sa@analog.com,
	srinivas.pandruvada@linux.intel.com
Cc: =?UTF-8?q?Nat=C3=A1lia=20Salvino=20Andr=C3=A9?= <natalia.andre@ime.usp.br>,
	linux-iio@vger.kernel.org,
	linux-input@vger.kernel.org
Subject: [PATCH 0/7] iio: HID: Add helper method hid_sensor_adjust_channel_bit_mask()
Date: Fri, 17 Apr 2026 19:58:43 -0300
Message-ID: <20260417225959.16688-1-natalia.andre@ime.usp.br>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch series introduces a generic helper function to handle channel bit mask adjustments 
for HID sensors. Currently, multiple drivers implement identical logic for this task

Natália Salvino André (7):
  iio: HID: Add helper method hid_sensor_adjust_channel_bit_mask()
  iio: accel: HID: Replace method accel_3d_adjust_channel_bit_mask()
  iio: gyro: HID: Replace method gyro_3d_adjust_channel_bit_mask()
  iio: light: HID: Replace method als_adjust_channel_bit_mask()
  iio: light: HID: Replace method prox_adjust_channel_bit_mask()
  iio: magnetometer: HID: Replace method
    magn_3d_adjust_channel_bit_mask()
  iio: pressure: HID: Replace method press_adjust_channel_bit_mask()

 drivers/iio/accel/hid-sensor-accel-3d.c             | 13 +------------
 .../iio/common/hid-sensors/hid-sensor-attributes.c  | 11 +++++++++++
 drivers/iio/gyro/hid-sensor-gyro-3d.c               | 13 +------------
 drivers/iio/light/hid-sensor-als.c                  | 13 +------------
 drivers/iio/light/hid-sensor-prox.c                 | 13 +------------
 drivers/iio/magnetometer/hid-sensor-magn-3d.c       | 13 +------------
 drivers/iio/pressure/hid-sensor-press.c             | 13 +------------
 include/linux/hid-sensor-hub.h                      |  3 +++
 8 files changed, 20 insertions(+), 72 deletions(-)

-- 
2.51.0

