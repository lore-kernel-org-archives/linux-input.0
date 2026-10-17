Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13EB23EA83
	for <linux-input@vger.kernel.org>; Sat, 17 Oct 2026 14:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792246119; cv=none; b=Gaj0PlXhYLZwPxmlg4p1GDACOYIBCPvuOHZWT/xJrzMtAIHYdoyhGELjiBX6WnLuE6ZG+ax++STl3PyMbllvSHG1rLKxOPrWR2rJssCxM3kGyOWSzaQy7Z1puSy0sqLwyfvNL2HVioI2r7+BiTsgNa7Ihrbz5yUwFiTNm5lAC5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792246119; c=relaxed/simple;
	bh=xwgUPno0Hmk2RqvQzb6DqmcZ3JYTRMeMpDvenuilM58=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nEyWxH1UhwRpZS2qgndsSHv8WCb9nVhGJomYtyrkdxZNgLjwQ/1WK8P+kFs+Zqadd8+gfv9J9FP1PhgNmRFgFj5AJMuRBrjN/e056PIsBeOzQqezKKLKbRTm9t/XPacJ0X3en6XKhAnWzOCdCnNXPACC4CgeYVk7W4cuUZQ+YqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k/ohMPZW; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/ohMPZW"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a1dec056ddso2034545e9.1
        for <linux-input@vger.kernel.org>; Sat, 17 Oct 2026 07:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792246116; x=1792850916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HsS7zD1Uucl5hqez+slw3pwoFAUHw9mJSijEO6l6OA0=;
        b=k/ohMPZWbrnzGftwk/mZJYJOf3NBSncQN3xM7RjjpFZwEuZ2cf6DwekpSd4GPR8KUU
         pXU3qhWvY3p5LXPpDn9hX54bY/PhhL8mFOPDvzJMeBV5DDIhw7ckm7WT/bEGgskzX32J
         3DPDQ0uCk30a3bfQGixBu/nVKuI/1u7CMMlZq50OxCDsPj7sLw/vtqfU4uihh/uYN9wA
         ZcJmVyCPNl0X94jQ9V9nOd2GYPP22ljhL68c/HQTTucyNxzNICEsnlKRfielVRobjlpR
         2OyXp5dG49P3xVBuU37DuIO1A6RlGc3Fp+T4SuLXLhn49D8fRGANve3ntxiBdZjmG336
         xe0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792246116; x=1792850916;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HsS7zD1Uucl5hqez+slw3pwoFAUHw9mJSijEO6l6OA0=;
        b=n3DhNV+S9ie3Uq1CrQGmEe9n3r5LF4uPwcwrmyBf9TYWIbVs+TyWCF9UkjTATNcn2R
         5jCN+q/xCtzTjbYKxR77QNx52Iwn2hYg0dqGaZIGV3nNpa1R3WvF5qxrkzqhgCeXQOKh
         iEqcmSzfxv7I8mUT+kg9DyETBK6jL99nuvdUhDCnbXmO7mY7otfkx98lUoiOSbypFQrt
         AhFHe2R9r2UWjzThNn2WaRFiir0tL3vgQ5oZtekdrkDhRcMnhHdV36O0AQwDUjfBQxkT
         lZRda5ENij6ZMOsDRNjXcUiTBJf3Ywl4p3b08d1RJOzU4JHhwCo1pfTIpnDdOGKoxip1
         cLSA==
X-Forwarded-Encrypted: i=1; AKwUvBzJmDV0D8+AzTqFKGjYU/m2ASwVo5cUk79FL51/bSVWknpSSjggUriZHkIPKugXNWvrdw8kZz+FE8SjmA==@vger.kernel.org
X-Gm-Message-State: AFq9FYJNeK1IvXzMFidy/3CNOs1C2RbTwPWBN48eXzXup7o5Fb0HtRjA
	YKXTXppcUOGvjDmV9CXG4oev+OyxjWQtFTzDf4ardk9guehnOXjFgI9Y
X-Gm-Gg: AYBFou1TK8aXC47wTndxGkuj2zzAcGHl3lZ3DGur27GyFME2mZxXlY0jy1lM1TZ+u/a
	QpJ0lOC0fYXTKwMjcW90hZeHSRr04WqVuhPLlmQ639lcJGuGx9MU3fC+BOgLa/egsqd/ZbDZ756
	GmluSTs2QlxKqaYfxOqRGijOTq+N+ZQddpRCmpLq4urV5b76i280eoEpcpp6uVLTKdUJE8V/wI/
	xf5K/y4zVYoQulrP/KuD8jB6StzBwvHYTU/vi/i6pmJAKQAbcbMZxQ5KiEtGPAmmokjlyY+e5kZ
	zSDZruADchQGeHbHt+09kw4Ah3DE+iQuDT4/zqbEQpGjvjMkwwNURguhNwR+4Bv0SPcBWcOyN7P
	Emdb55Rj5i4noFsaxCKX8Pe/fo1+OOyH2Kw06gtze5s0JPwKe8AVSzYiaMKaZ58VdojEBPqC7oO
	HpjyjCPpKfjA70RXbzn0gD4988exM1RA+ItDLFzwZltQ2dw0xSzWwzu7i2JJlX+7HqwR2GnhRgV
	wcb6Jh3oIuWHjytvDmQotESdIrJ50rrRuY8rgJpdVqJ/rIjrd9deqvr8WRPnx862nHK+OM7PKpn
	NQ==
X-Received: by 2002:a05:600c:34c3:b0:4a1:df11:45a9 with SMTP id 5b1f17b1804b1-4a1df11472emr20823185e9.4.1792246115663;
        Sat, 17 Oct 2026 07:08:35 -0700 (PDT)
Received: from machine.home.arpa ([2a0d:3344:57f6::1046])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1ce3302b5sm84430745e9.4.2026.10.17.07.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 07:08:35 -0700 (PDT)
From: Luka Panio <lukapanio@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Henrik Rydberg <rydberg@bitmath.org>,
	Douglas Anderson <dianders@chromium.org>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Luka Panio <lukapanio@gmail.com>
Subject: [PATCH 0/7] Input: edt-ft5x06 - add SPI transport and FocalTech FT8722 support
Date: Sat, 17 Oct 2026 16:07:48 +0200
Message-ID: <20261017140827.290666-1-lukapanio@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The FocalTech FT8722 is a touch and display driver (TDDI) found in the
Nexphone (QCM6490). Its touch controller speaks the usual FocalTech
register protocol handled by edt-ft5x06, but it is connected over SPI,
has no flash and runs its firmware from RAM, and shares its power and
reset with the display panel.

This series:

 - splits the bus independent core of edt-ft5x06 from the I2C driver
   (patch 1) and moves the controller bring-up into a helper (patch 2),
 - adds an optional per-chip boot hook, used to download the firmware
   after every reset (patch 3), and a per-chip touch data register
   (patch 4),
 - documents the FT8722 touch controller as focaltech,ft8722-ts, keeping
   it distinct from the display side of the chip (patch 5),
 - adds an SPI transport with the FT8722 firmware loader (patch 6),
 - lets the driver follow a DRM panel, like i2c-hid does, so the touch
   controller is powered down and re-initialised together with the panel
   (patch 7).

Tested on the Nexphone by Nex Computers. A board DTS using it will
follow separately.

Luka Panio (7):
  Input: edt-ft5x06 - split the bus independent core from the I2C driver
  Input: edt-ft5x06 - move the controller bring-up into a helper
  Input: edt-ft5x06 - add an optional controller boot hook
  Input: edt-ft5x06 - allow a chip specific touch data register
  dt-bindings: input: touchscreen: edt-ft5x06: Add FocalTech FT8722
  Input: edt-ft5x06 - add SPI transport and FT8722 support
  Input: edt-ft5x06 - support following a DRM panel

 .../input/touchscreen/edt-ft5x06.yaml         |  37 ++
 drivers/input/touchscreen/Kconfig             |  15 +
 drivers/input/touchscreen/Makefile            |   1 +
 drivers/input/touchscreen/edt-ft5x06-spi.c    | 475 ++++++++++++++
 drivers/input/touchscreen/edt-ft5x06.c        | 585 ++++++++++++------
 drivers/input/touchscreen/edt-ft5x06.h        |  33 +
 6 files changed, 957 insertions(+), 189 deletions(-)
 create mode 100644 drivers/input/touchscreen/edt-ft5x06-spi.c
 create mode 100644 drivers/input/touchscreen/edt-ft5x06.h


base-commit: d419d682257d813f6cb7a28e42b35d0edf4ad038
-- 
2.55.0

