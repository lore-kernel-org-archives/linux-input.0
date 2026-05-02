Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E3733DEF2
	for <linux-input@vger.kernel.org>; Sat,  2 May 2026 12:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777725678; cv=none; b=bscwmqEehxlPkuPccMnIDI+u0J/6yQq4ngDjPtatmGGu0YTnSROn5GljbW/M8tAenhRLW9Otc5cblzNvWl/5ytWC86K6xTo8HcMWQWOVH01jPYaoMYelHzFNiIArThcI/l06pMMWUbwkqbmv21dJJcDkPGe84veeURO5MoaHbYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777725678; c=relaxed/simple;
	bh=bzK7TuhI7iXeChjCRE/yKbFe3uEBIwi8ReixnO3VzD0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=G1npZdSyzlibzEVuG7tQDHf48vr3XuE4G0umHBmufIu5gNa4iB42zW6PcJ9VITH6PnHntE4AmNuEkmIH7wlkFEqR6gxfITJTyT5Qc48AtXpxVmjLwDR+any0izhV5qRkVyAFAxxfatkCy3gj/wU/XJdHGRgPZEZGCFxGAX5darU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=szC/F6aa; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="szC/F6aa"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-67b6da5a618so4341511a12.2
        for <linux-input@vger.kernel.org>; Sat, 02 May 2026 05:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777725674; x=1778330474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HBPNRk7v8mm7QEjJvKG3bZ2ji7O0ntCyzGjvZOc47Jg=;
        b=szC/F6aaQSGgS0XWpir9o5lO6cfT0oCt/xvdG5zbZfgRpZRZRei1DER181TJBgW3kZ
         HG2LQMX5Wh0nqXLmesIugpj+EaiV8Z8LkjgHgMonkEl+f8c84+dc8A+K4WNaaNPfFTPz
         2z5bnoHs8lDj0Xpg7hKi9GpAYaypNrUNNiNZ8oIwv6M2l8icQTeM9XGorcwjHzVL85n0
         S5W1N77C0pkKYzK6FUHO092IDvVSJw4AyT6aFFkq3GGXHkOD1RaPEgOX8vXNoxSE4QGy
         fx4oq0Vb1MVgIAs9zLRBMUobAs5IcXvdDRiyKiXAqsQSi2oTpViCsOKceO0LYYPD1xgR
         T7xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777725674; x=1778330474;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HBPNRk7v8mm7QEjJvKG3bZ2ji7O0ntCyzGjvZOc47Jg=;
        b=Ds2hQ0nslDZJqsxJVEU7tWSlRnt8pDaGKgvC+wwwV1XQ2zbxR9vmrRH75oXBtfftB9
         XGBY+tHFJVznWWVsE4mIGY03JIzz0Ri76ggcniqJF21zxf4ojOY5VfZfhLN/JbrufOii
         pYC025WLYoWiRJ7gi7grS55fRFVLu+tbbvnbYoqL+rTWLSEIHczFkgn+Ha+ueVG8KmO/
         r29i89wqQuswD+iYGaeXlQPNlgyGhgMIrUsdI39XiZNsQbj8i1Wpe0Ybrb7onmNA81HQ
         xPOXTsCUqugf8J468j8jBE62kCWTjjh2dO1u574Sn+9bXQOhJZbsQJ6QJUralxi6taKr
         ITTw==
X-Forwarded-Encrypted: i=1; AFNElJ80HhDLDMOSFriTTtFDxWy8nbillnnI1z2bX8mBnPc4kS36nn3tzTqaSo8skJyld0+68oUEM37YZg3cmQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzoJinYfDvQvlEjeNU7xJWbn31HUsEp4+xnMV7bxh+AqUr+1xWK
	+f4cNbZ51R0KIlyZWYuOqeFvzEf04EMFeZYGh8xX0/PFiNDV7c6kSvK4
X-Gm-Gg: AeBDieuBtBVat8ENi59ErtQQsGhr09udf0eHstH2SNhbzlsv6LfaI9iT7N8kWut/BBn
	AnLyHLoEbIy3sx+5hzkOMoB5CH6p5vXbx5xTqJtsWE9jJL77fLDFYKYekNKdymgBlYVe6lly0VA
	VvyzHiysztdPpaAcj/865TQXZBJ31W6SOHYQxyM+SiH2+NhAIxmCFuUiJDKl0zvmvqXLKk/hsJm
	zAZFN+EmdR/VIYP20Ds81ToZsWGAkXRvGKlLDy26UOg+tkiJ93wusC5oXqagZWM8dehqwidFpk0
	7RLi3JKg8wl08o4VJemg93Zpetm3k3M9I7fuWMUjlRz8opGHO1TAYAE8l6uBUwCY533LLdnK5XG
	iSewRt73BH1YU1RRyYLi0vymkwco2WtWDtSgYPYRce7Ww2CRqTwZp1feq4mXhrf+adjD9EKCRTw
	vKJiTuAM6ptpSptzCrvTaKxX8=
X-Received: by 2002:a05:6402:1209:b0:665:3d68:c46c with SMTP id 4fb4d7f45d1cf-67c1ada368fmr865771a12.14.1777725674231;
        Sat, 02 May 2026 05:41:14 -0700 (PDT)
Received: from xeon ([188.163.112.56])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67b85e281cdsm1649649a12.3.2026.05.02.05.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 05:41:13 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Ion Agorria <ion@agorria.com>,
	=?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-leds@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v6 0/7] mfd: Add support for Asus Transformer embedded controller
Date: Sat,  2 May 2026 15:40:48 +0300
Message-ID: <20260502124055.22475-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add support for embedded controller used in Asus Transformers for
managing power and input functions.

---
Changes in v2:
- converted sysfs debug exports into debugfs
- added kernel-doc comments for exposed functions
- fixed minor typos and inconsistencies

Changes in v3:
- dropped DockRAM commits (both schema and driver)
- integrated DockRAM functionality directly into the controller driver
- EC schema moved to embedded controllers folder
- removed all cell descriptions from the schema
- removed all compatibles from the cell drivers
- adjusted naming conventions to better align with the ASUS Transformers
- defined EC variant sets to provide coverage for all known devices

Changes in v4:
- grouped known programming models of EC chronologically (both schema
  and driver)
- call debugfs init only if CONFIG_DEBUG_FS is enabled

Changes in v5:
- added asus,tf600t-ec-dock compatible to schema
- rebased on top of v7.0
- kzalloc > kzalloc_obj in keys and kbc

Changes in v6:
- removed asus_ec_handle_smi casting
- asus_dockram_access_ctl > asus_ec_get_ctl in control_reg_*
- fixed battery Kconfig description
---

Michał Mirosław (6):
  mfd: Add driver for ASUS Transformer embedded controller
  input: serio: Add driver for ASUS Transformer dock keyboard and
    touchpad
  input: keyboard: Add driver for ASUS Transformer dock multimedia keys
  leds: Add driver for ASUS Transformer LEDs
  power: supply: Add driver for ASUS Transformer battery
  power: supply: Add charger driver for Asus Transformers

Svyatoslav Ryhel (1):
  dt-bindings: embedded-controller: document ASUS Transformer EC

 .../asus,tf201-ec-pad.yaml                    | 119 +++
 drivers/input/keyboard/Kconfig                |  10 +
 drivers/input/keyboard/Makefile               |   1 +
 .../input/keyboard/asus-transformer-ec-keys.c | 272 +++++++
 drivers/input/serio/Kconfig                   |  15 +
 drivers/input/serio/Makefile                  |   1 +
 drivers/input/serio/asus-transformer-ec-kbc.c | 147 ++++
 drivers/leds/Kconfig                          |  11 +
 drivers/leds/Makefile                         |   1 +
 drivers/leds/leds-asus-transformer-ec.c       |  79 ++
 drivers/mfd/Kconfig                           |  14 +
 drivers/mfd/Makefile                          |   1 +
 drivers/mfd/asus-transformer-ec.c             | 762 ++++++++++++++++++
 drivers/power/supply/Kconfig                  |  22 +
 drivers/power/supply/Makefile                 |   2 +
 .../supply/asus-transformer-ec-battery.c      | 272 +++++++
 .../supply/asus-transformer-ec-charger.c      | 193 +++++
 include/linux/mfd/asus-transformer-ec.h       | 162 ++++
 18 files changed, 2084 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/embedded-controller/asus,tf201-ec-pad.yaml
 create mode 100644 drivers/input/keyboard/asus-transformer-ec-keys.c
 create mode 100644 drivers/input/serio/asus-transformer-ec-kbc.c
 create mode 100644 drivers/leds/leds-asus-transformer-ec.c
 create mode 100644 drivers/mfd/asus-transformer-ec.c
 create mode 100644 drivers/power/supply/asus-transformer-ec-battery.c
 create mode 100644 drivers/power/supply/asus-transformer-ec-charger.c
 create mode 100644 include/linux/mfd/asus-transformer-ec.h

-- 
2.51.0

