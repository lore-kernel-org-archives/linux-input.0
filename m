Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198F42FE056
	for <linux-input@vger.kernel.org>; Sat, 14 Feb 2026 18:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771092621; cv=none; b=h8PzfNytDyr1XeJaf2Erbcy18q1AQCNlvwhgDkV7SyxWrWlO4mKhkFbFlplZFLHF8sniDl/ROOkLLNVBayvDg/hOc0yXmSwAIgoz3SF75sTPgE6HKgMz5LO1HAF9+DEc7u0ZAbZ48tO9x0qbY2YL/Cc/775DLMKoLXwN3H9g7z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771092621; c=relaxed/simple;
	bh=6X1C0wECNTPSp6EP/HcEzSJeSFFFyaHViLXEg8EpYB8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jJSNyvTkQMjr7BtAj84cqlpz94hzbxv4zXhKwADX+1iOxNiuVyqIu4Fg7WjnMrKdUioq+rI89rPRrmralocz5MjlZ7ICfuQrSv/IFsVDadK8A0PKvEiZI11d/O5DfcXdtyet5VknHtTUieBZB2N2Y7DbSMpmPLzuTgvEcco3/7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e4oezl4x; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e4oezl4x"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6594382a264so2868668a12.1
        for <linux-input@vger.kernel.org>; Sat, 14 Feb 2026 10:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771092617; x=1771697417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mBgwHHnAe4QujYI3JUVAZlk83RlrT0NjCZwVRWPSZIU=;
        b=e4oezl4xgeX9C9zB3AMRQw6UXQ3do5VNyag1xRW+k0Dx9siqFoPexugdQS1MMq+SDB
         cMTNjdyqV3Gowof96U4AqnEr/cC3mhCg0RfKkyDINuffdnRAFQwhhZNbYMeVkHCUmRcG
         E20dgM4QYuqAoJpm9cE4gevbqkx+csZeuGNsCKxJD7I4ggSEIaISh/Vy0lXy8+ehnae9
         rdHEALQeUOR2GQnfKRMfNxl6X2IHkBG5kGeIQBrJ7TKIcjkVE9/Ae7vWg+L6Y3W3Qio3
         l2lRUmCygBVyZWG0LWzsLhLgXhOVBlyUrr3cJl8TPH3bLkWRWZDUggfLJEiaa5cWfzQ/
         UIpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771092617; x=1771697417;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mBgwHHnAe4QujYI3JUVAZlk83RlrT0NjCZwVRWPSZIU=;
        b=Aa1GC+1fQUSjDCGgPKdvlKfXR1o7GVF2+KAqkgVJtybkdg8J9h4LBfJLAQwiwlX5xq
         Zja3tMIxpCqF85rS+cIcE3cX1Cr3KWx03rUe9ZH9UZ9HTJ85zmB6asatTdmBvSW37/H9
         oQBErReYknZX5f4eTQUZyaC+rnl4GznqCayYrjOfAi/KixZm6YXV+K+R1cTX4TkC0uK/
         GMTOQqny9dYnTtOEPWxV0Ulxx/2s0Ws4zjZDSqAl/fscgZ/MtDxMqYsy4fwq8dJjvqt0
         LqFNNVlplCylEsMbZjD7xC/eP2DlCkOAcZJZ8betpXkb9UpQxHOLkDkCmjnJivNz6E78
         poEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMWvmsFysKZmoIlmqWzV8y3sfRTeypYua1pVZqqOnVxHJZVl2aqfzq97kOIsZZP/hZjMh5txGivHpU5g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyI7wvHk5kPuKHExtPI+ZSZFekQnwCTArB9TuWVohxzs1T6ZYRV
	0DweeCAdKsRTqMFDCs4ZQNX3MS2r9TgGE5OSDL7/w4G2BSd+yLSbmz/1
X-Gm-Gg: AZuq6aJKVa0/tCCy7j8nMvtN1RDDWHMCuv4MsDt6nx4nggeQU6GeKtImw86Cu6nY11s
	6kDnAFDy61axQ+AOkzA1sdjIFIKiUsKnDG11OpIm31zw5dsZDuujbvCv8lSu5FMnY/Gtqd7MTe/
	zv520YSOc4lPzXAra+1rXicjQntb6UYxzMpWQs5CdbFOf2tUU9pExcnn5K+ozyLpepugBQcqumU
	VgmTIGuM0XxhPgYkI5tdEOCNU0+SknxJxkHBkrtcf2ZcHZFQvk94eNMMqLQXX9CDQuXg4BBMMwL
	PdQkTWJnh0+y1DfEHtPYcNaJd/lrAlKBQTsQbO2swZefd3RL5+ClFvO5LgCIgSH0h5sn+AdSp1L
	OU/3NKR7plEN1Ab9T3XE2SpgmU8pzgYq2Ie8PZ4J/pH5sF3emtRPO7x/mVVtNyuE4McTVufZhwV
	/9DjtmqAPPGSgX
X-Received: by 2002:a17:907:7ba0:b0:b8a:fd04:c789 with SMTP id a640c23a62f3a-b8fc3a358f8mr162694866b.22.1771092617220;
        Sat, 14 Feb 2026 10:10:17 -0800 (PST)
Received: from xeon ([188.163.112.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8fc735e506sm88122066b.11.2026.02.14.10.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Feb 2026 10:10:16 -0800 (PST)
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
Subject: [PATCH v3 0/7] mfd: Add support for Asus Transformer embedded controller
Date: Sat, 14 Feb 2026 20:09:52 +0200
Message-ID: <20260214180959.30714-1-clamor95@gmail.com>
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

 .../asus,transformer-ec.yaml                  |  98 +++
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
 drivers/mfd/asus-transformer-ec.c             | 763 ++++++++++++++++++
 drivers/power/supply/Kconfig                  |  22 +
 drivers/power/supply/Makefile                 |   2 +
 .../supply/asus-transformer-ec-battery.c      | 272 +++++++
 .../supply/asus-transformer-ec-charger.c      | 193 +++++
 include/linux/mfd/asus-transformer-ec.h       | 162 ++++
 18 files changed, 2064 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/embedded-controller/asus,transformer-ec.yaml
 create mode 100644 drivers/input/keyboard/asus-transformer-ec-keys.c
 create mode 100644 drivers/input/serio/asus-transformer-ec-kbc.c
 create mode 100644 drivers/leds/leds-asus-transformer-ec.c
 create mode 100644 drivers/mfd/asus-transformer-ec.c
 create mode 100644 drivers/power/supply/asus-transformer-ec-battery.c
 create mode 100644 drivers/power/supply/asus-transformer-ec-charger.c
 create mode 100644 include/linux/mfd/asus-transformer-ec.h

-- 
2.51.0

