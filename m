Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4F52EDD4D
	for <linux-input@vger.kernel.org>; Sun,  1 Feb 2026 10:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769942654; cv=none; b=R19JsAajCxHIsgO7JEW2cAyhHA+uZWm4DPwZOwrX6esQ3ByqcYRRMIdknMrwSSBneoWHZjtnbi23uylN3m3c/n0oVY5VWfzY2oA58EWHA7BM/eZPBUqgtm6NLDr11qnJ/CuRrbssKMea0xjyOA6bqT7/Effi3vaypuN8b+leSRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769942654; c=relaxed/simple;
	bh=z0OeZ0DJQ0E/+donS2QQkMz+d62Uv6TmN9IynwMz9Hs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JHAkqly10HDbKbWlaIBV6akEZ23wNLSU4n8RB5MnGenDfb5OkirK1hdP6U3pA+hvPZaNpeWnyqo3NhuiZcxkQGRlgTHn7/jCR51vjVQRqBAs2dhDdhCJHsfBqKhPd0lTAYOtlaqispfhKaz7VmuwPzWLP2s47/btXnjQuEklmEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gROvpyKY; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gROvpyKY"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4806ce0f97bso29421655e9.0
        for <linux-input@vger.kernel.org>; Sun, 01 Feb 2026 02:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769942651; x=1770547451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JaZLxb/TpfjjyCLjMdtwmkz7IMvUMrg74EGxr+gYNgs=;
        b=gROvpyKYSnTUJkQJcIzYaiOop7uXsdVdFQGEarkCejwB8yrnhV9oaEndWdSbYbiy3b
         Md9bmHa5C7NpPJrOD5p+eWiYPq6hIk3A2c8DIjbwrIOr8ZkaEAZfsPxsX3maXygqayPA
         LgIoDNSnASA+qeJRMbFh+OkydaJro0BjItd/+qzuZyX2TJLMXb5mRDxb3Ntlg1qxmQOK
         +RZl+xJlegAtnZnoBfTCzAfIJ7+2/Ny1+UBbKUHBl+1pkHvK85q46bRDQOdiwG5G/uTn
         +pkeornbDPnPZJbWV1TuFckhYxqC1m3K2LAyfxlzX1EpN6BM01NuxS4eV3Vz+eJ26IDA
         8VPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769942651; x=1770547451;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JaZLxb/TpfjjyCLjMdtwmkz7IMvUMrg74EGxr+gYNgs=;
        b=Fy4Rk8ZyajsJBYzLWYTlT6zIbaPk+JtOouspxemTkX7rforst7pNgeSm1ncDt62hhC
         dkEBwnZwzYDi8X8NmxDBtSD1eXpKT4a8CmcfIGhVIdWOVH9Oe0ytCXDWOp8tjMTv4ly2
         8UHYpYF0z3fSm3F/qFtGRFwMiTKlXGbXjjeL1ZaSxzryREKeRGmHYxP9JndWM4Ysiv7A
         ktfaz/jNrL2kDmLrLSC9gqTcw8NalqFzx1NUX4bkSuYXBDxbkR3J7icl3R60v309PJAS
         PLX6EkMjIdw4o9X7QXQ5HpjsJNs7bZcTg5Oqg+qVmXQDg1lomyGfDLMC3rE4qERQ6P9f
         jKMw==
X-Forwarded-Encrypted: i=1; AJvYcCXDoHCZrI6BAB0BI9n/PoE4AOhOnWs4t7RhInaV/5qj3ysAyC0CJyQ3Jy+9Z2VuRvvr6XJacEbDD+sh0A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxiLIsStjXnSxXUG0Kt0aPDOsUyjXWyewt973ke7HmBEmia4Z8g
	+iFQO4h7iE73Ryh56x+FkxghG1YYFDaZgiJlpi15cSMMkTwfLLvBVDKa
X-Gm-Gg: AZuq6aKQIkN1osg5FktVtZmQ2uGlvXMHiXS0y1bL7yXqON3Ds8JzVd/4jFxMxLuPS7v
	YISdJlQ9nJbmc1wv2kMqlXe46UGQAgPi40H3ZZPEYN0F6f2PG7GPBmCKtpzAbbK/74uYCuR2Hr5
	Ld7ItbOjVVOmvS3Mx9o8wcpHRZijIxRUg5lRgBZIy7PJGP++J/YcVxIKsb4fW+yzjTt3OOQN4mG
	H940feMT5PE6OISfk3e32lqtjg6F8m2fd5HpeFCqex9hRaQeAiYTxfSH3vCaQ8MtWKaJJtvB9pI
	4hWIWded24UlNbus2HmB7Q2z8WldiMIPq+tpOlOlCiKOJLCvE0YZRQRB2eJGKdBW/IaMmlcIch8
	qEA9PoI4CPRvUOAZwMqxX23sw3GcBSO7zaE+JbJyjXxibzxpeaP02TGZzPiGmac6rW8DPxnZMym
	ElKkJZQbixycw=
X-Received: by 2002:a05:600c:474d:b0:47e:e952:86ca with SMTP id 5b1f17b1804b1-482db4486e9mr105328755e9.2.1769942650796;
        Sun, 01 Feb 2026 02:44:10 -0800 (PST)
Received: from xeon ([188.163.112.49])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4806ce56490sm308947455e9.12.2026.02.01.02.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 02:44:10 -0800 (PST)
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
Subject: [PATCH v1 0/9] mfd: Add support for Asus Transformer embedded controller
Date: Sun,  1 Feb 2026 12:43:34 +0200
Message-ID: <20260201104343.79231-1-clamor95@gmail.com>
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
  dt-bindings: misc: document ASUS Transformers EC Dockram
  dt-bindings: mfd: document ASUS Transformer EC

 .../devicetree/bindings/mfd/asus,ec.yaml      | 153 ++++++
 .../bindings/misc/asus,dockram.yaml           |  40 ++
 drivers/input/keyboard/Kconfig                |  10 +
 drivers/input/keyboard/Makefile               |   1 +
 drivers/input/keyboard/asus-ec-keys.c         | 285 +++++++++++
 drivers/input/serio/Kconfig                   |  15 +
 drivers/input/serio/Makefile                  |   1 +
 drivers/input/serio/asus-ec-kbc.c             | 162 ++++++
 drivers/leds/Kconfig                          |  11 +
 drivers/leds/Makefile                         |   1 +
 drivers/leds/leds-asus-ec.c                   | 106 ++++
 drivers/mfd/Kconfig                           |  14 +
 drivers/mfd/Makefile                          |   1 +
 drivers/mfd/asus-ec.c                         | 460 ++++++++++++++++++
 drivers/misc/Kconfig                          |   9 +
 drivers/misc/Makefile                         |   1 +
 drivers/misc/asus-dockram.c                   | 327 +++++++++++++
 drivers/power/supply/Kconfig                  |  22 +
 drivers/power/supply/Makefile                 |   2 +
 drivers/power/supply/asus-ec-battery.c        | 282 +++++++++++
 drivers/power/supply/asus-ec-charger.c        | 205 ++++++++
 include/linux/mfd/asus-ec.h                   | 113 +++++
 22 files changed, 2221 insertions(+)
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

