Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2575368264
	for <linux-input@vger.kernel.org>; Mon,  9 Feb 2026 10:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770633868; cv=none; b=BSYhXI8IsSxmMdxRKD1b04nItJmRwRaWfCQwmT2AmS/I0DBiLEKHqRPNs6uzPkNkPoqePH01ERHUvaOANT12Cnyo8naVzwzfnMNk7JFipVL73Gkl87WN0fNYDTQN2pSv9YtXSwvi0SlWq0ccUsCZ+5bgwEXxdOMiuLiWzAAX0Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770633868; c=relaxed/simple;
	bh=08Kt50dHkpQiui6kV4b2Z9IHxPwovMpEiTWbFMykybY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XCXpIjcT0XPGEovzjm+aOgWRKRzDU8AUqaAi7pnImLqBijTD9x7pTK2rDn4Unbl5Hnoq4MkKnJ1nON3KKE1q2xY3jQvO3SA35bMsFE21+ynm2VcDlwRyZlCXEv1sVrEMyGmFdvGJig+ZpS6D0QsUkdRGsRBILNnYXXt6RLAtZK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wh8NScqi; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wh8NScqi"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-59dd22b9895so5757257e87.0
        for <linux-input@vger.kernel.org>; Mon, 09 Feb 2026 02:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770633867; x=1771238667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hyllhJpxVbOC8g6WTpUW33ixHuDxxdyB8h+jNgtxccg=;
        b=Wh8NScqimUGJl9ddKTCTGbl3AuAdghPHSLsOQBAEcJarZJzPuJOpNshSF/2vyXbElM
         mrQsBU38gFlLPvYmONhpjzfiSYEv7dEj1v0iamxB8PCvC2C+NFXSANCXQ7k48Ui/wf/X
         dw/2aAEh82nijJVnIgxYXwOiyiuCwvt3Y0k6yveHWe2xjTXIqjADKMjLQR2zgbRgnuYx
         fSUtH88FOhbx89e8kGYmW42/waZhw7L7VN09vtOcOrZzkhSdqTO6V6lbT5IKfAQV/Y0w
         EBXeTJiNg2bbuxYHJjk4nGwjShFnSWzI2Ltq04fBHuOp5chGOtOekk3qSWIrMiODZopC
         p9sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770633867; x=1771238667;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hyllhJpxVbOC8g6WTpUW33ixHuDxxdyB8h+jNgtxccg=;
        b=aAt9v1RgSIFPgr/ysEwG5g804xf5IVxXAvxLmVZoHfkdOTpQCHuq+4jY+RjOoTVaTz
         rAZlLWLxCIZaZjsqwBcUqUlTXy6WY/oE7Ym5rGjuzBTQNz5nKn99YDfHvMIdRCgiqN9D
         6FSiEVm/PnP3MdlQTOMtEkGMiB6YpkDj5SGSooWJ9haz5+ADTVfLKT711ab5X2AkYWZ/
         PGMwzKmcqSJpBPiMsTM4DmhUaXrlb4b9geMkL4p16M1koV43jV733M31EjG1ebb4/xOj
         MPkJFPAsTI/POf8SkcgiIcOanaTCI1MJIP4+UJpu04ybmGkGocoRooV7gvhtwqpj0Fap
         iYgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVg/yei/PfgnpD+YRTKEul6aByUuHvlQa7LDq0aTALZuB3pxhnEWmH3Z+33KswTAO4uNrzD3ZJPKvjhcQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzV0QgXpUOqCrqGnBOGunBl5qHhLnmvrsfCqU6bZ72zfN1q4f0K
	wO3x7k4TLD7Qxvnf1pzOvrmh8BrxsfJa7MJRXaLbRt2i40hwLTd7gfCZ
X-Gm-Gg: AZuq6aK/J+0PwrRtlFXbtRYXXtU9qhcjjbA7KmS01KK8sveoYuMgJDTCgKpiAdWNXEv
	YilH0lrczMhfLADU4J/CYtyZ8So4xIFGnLxoA2LCHD70hFiGDHe9DvitakqdEqVr2D2JNZRAn9y
	YU5mxNcy6HQPccz/EjdDZu6Cz7WsywTRsfhzzkYJCxw4IlR7XF8udx5shDZjfsvdTvFZpN+03Yn
	rU+KyoEggq4ykC8CevQxQQLkmVDt/C4VilAEb0Eowf+eSNgwz0xAL0ci5dtsW7R31NZTfGRCZ0T
	+HdnT1VPyQSXAwjkbEJULkdXGPV/qbRjgPwi5pKe5mKO0WmiWcW50eF5v8wJsi4rne1J1/M/KuS
	0SBY2flmlWafYeBEkOX7OveO51HNa0DpX+mrAn72YomnG00UvNUDeLDaElaZJqnJYPo7c73VUOl
	lQ
X-Received: by 2002:a05:6512:250c:b0:59e:5243:6c94 with SMTP id 2adb3069b0e04-59e52436eb1mr251424e87.5.1770633866556;
        Mon, 09 Feb 2026 02:44:26 -0800 (PST)
Received: from xeon ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e44cf6f88sm2501469e87.21.2026.02.09.02.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 02:44:25 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Pavel Machek <pavel@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sebastian Reichel <sre@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	=?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
	Ion Agorria <ion@agorria.com>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-leds@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v2 0/9] mfd: Add support for Asus Transformer embedded controller
Date: Mon,  9 Feb 2026 12:43:58 +0200
Message-ID: <20260209104407.116426-1-clamor95@gmail.com>
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
---

Michał Mirosław (7):
  misc: Support Asus Transformer's EC access device
  mfd: Add driver for Asus Transformer embedded controller
  input: serio: Add driver for Asus Transformer dock keyboard and
    touchpad
  input: keyboard: Add driver for Asus Transformer dock multimedia keys
  leds: Add driver for Asus Transformer LEDs
  power: supply: Add driver for Asus Transformer battery
  power: supply: Add charger driver for Asus Transformers

Svyatoslav Ryhel (2):
  dt-bindings: misc: document ASUS Transformers EC DockRAM
  dt-bindings: mfd: document ASUS Transformer EC

 .../devicetree/bindings/mfd/asus,ec.yaml      | 152 ++++++
 .../bindings/misc/asus,dockram.yaml           |  40 ++
 drivers/input/keyboard/Kconfig                |  10 +
 drivers/input/keyboard/Makefile               |   1 +
 drivers/input/keyboard/asus-ec-keys.c         | 285 +++++++++++
 drivers/input/serio/Kconfig                   |  15 +
 drivers/input/serio/Makefile                  |   1 +
 drivers/input/serio/asus-ec-kbc.c             | 160 ++++++
 drivers/leds/Kconfig                          |  11 +
 drivers/leds/Makefile                         |   1 +
 drivers/leds/leds-asus-ec.c                   | 104 ++++
 drivers/mfd/Kconfig                           |  15 +
 drivers/mfd/Makefile                          |   1 +
 drivers/mfd/asus-ec.c                         | 467 ++++++++++++++++++
 drivers/misc/Kconfig                          |   9 +
 drivers/misc/Makefile                         |   1 +
 drivers/misc/asus-dockram.c                   | 370 ++++++++++++++
 drivers/power/supply/Kconfig                  |  22 +
 drivers/power/supply/Makefile                 |   2 +
 drivers/power/supply/asus-ec-battery.c        | 283 +++++++++++
 drivers/power/supply/asus-ec-charger.c        | 206 ++++++++
 include/linux/mfd/asus-ec.h                   | 162 ++++++
 22 files changed, 2318 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/asus,ec.yaml
 create mode 100644 Documentation/devicetree/bindings/misc/asus,dockram.yaml
 create mode 100644 drivers/input/keyboard/asus-ec-keys.c
 create mode 100644 drivers/input/serio/asus-ec-kbc.c
 create mode 100644 drivers/leds/leds-asus-ec.c
 create mode 100644 drivers/mfd/asus-ec.c
 create mode 100644 drivers/misc/asus-dockram.c
 create mode 100644 drivers/power/supply/asus-ec-battery.c
 create mode 100644 drivers/power/supply/asus-ec-charger.c
 create mode 100644 include/linux/mfd/asus-ec.h

-- 
2.51.0

