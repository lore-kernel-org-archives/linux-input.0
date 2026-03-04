Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552033D412B
	for <linux-input@vger.kernel.org>; Wed,  4 Mar 2026 18:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772650685; cv=none; b=ZSCEIPwdBMouycs5Oze3qywibcOuIWDv99I0DEx7QhJO+nN0YWZOigkCXpRcG/iekPYq+Or9Eb8KLnG8W9EZainnebwpHPBF1BvzHqqkFE4olfaOco/3tgSwi4fN1bLroybmGQhG0+YPnIsFc8R9Rrc4AG0KbD8pAu9BZ2zKxoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772650685; c=relaxed/simple;
	bh=R2AUYnU8Wz8oU/h5rvR1qBJ/kWXkextxlhRXzMBmDPY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ryJo4BgJ/+HNmwFJhjqgWtDZn+RwOH1kcQRpOVrTemDv0E7Bv6N3lm71edKQhklrdWUYcztrw8gYKDYAbSgBTpVKY5rrybxIAOhRSPnBIWWXKFkCyJhYKGR0LUOaO1m/VCBYQzd0UlqQzSN8LFD8ftT5MnGJVMTKU3RFKURNkRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=es3DPGsL; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="es3DPGsL"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-38a2f196cbaso14549931fa.1
        for <linux-input@vger.kernel.org>; Wed, 04 Mar 2026 10:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772650683; x=1773255483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3/VwVHY85Z4sAx1gqqncPobsH7DOkhMw1reihUc4ZtI=;
        b=es3DPGsLJn26+Co2HAWCOqc4Gh2z5omQEHbjEFXZ0LWlgaoyj7VsrmenNpRO2hVVaJ
         gl4U3I10/1Ol7mUuJaJi0v52Z72Cy2jno8kmqyRx+7hpBGYkQSCruI7q3mhjBxsPFu4Q
         rHrBnBKmUw7Ctnvej6jWevizr3tfKFV2In6x5T/Kmex9f724I/bl4SK0MJY90eFv8GAQ
         Sdm0iCmjhC014efPxAQ8hkDr4RTrvjg3ud0BbuTpZUWO4uhz0Muq96QnOyoxzQzB+2vW
         fZ40xDQGoYD/OKDXCmxb8899Ywm/lXTAG7pxT4KIekaM4kYNFrns6RXfpUwd8ILkursD
         ZlEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772650683; x=1773255483;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3/VwVHY85Z4sAx1gqqncPobsH7DOkhMw1reihUc4ZtI=;
        b=Aoacov3SDKtRUBcT7ZDn1emQOBUMb3aavtIo0zo2wK3CobrOP+MB/ezERgNiYuXC1i
         W0ARNL8G3jY9g7UAtsHoqRv1OP4ydUa4izFqeywexlFtzCvzE1Mvfyn+i0ZkRRyAT54X
         5BhA2n3ljNWemhLQTSh3GYt20VxomajF7ZCSK7ahOG60O+nI1WnqVv0pIcILcR2X2E+S
         kiShEyEYIYOj64/1Xg3jYUEHxUfR5UJfH9AW5BPwK2MrIvsvRv2VPT5JWZZOarteGnSX
         XuRV2VwlqOhVq4X4nWQGq4kM63Veq0kGJjx/DSB1SIrxOG5vm6k123Sp1meuXV/1kP3j
         fM+w==
X-Forwarded-Encrypted: i=1; AJvYcCXY3YpRLw3Oqm6kU7kOr9YcMn3nkgaBcevdRWBvXzFSBz7OOHySDIMOE9UsVB2MZcMFmF7+VBQ5wlUA7w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxmpCEYaxTf6wDpFmZh/hn0OY86YN54P7BIPv0VULza9A5+5rk6
	h3nrJowRPMyy9jGG1kSOHxY6SGfK8mUoCP8WgAnE39VD+7Z66tof91irxKi/wQ==
X-Gm-Gg: ATEYQzwsZOs/c/8b/ahVDoQlYBqRqmhCUCMBOZ580da6W0UmHvpIMoRvINkh7eymOHy
	7eEAxcpANQDoeMoPoa9tquigt8obf7QyVNblpcoPKx/1gxWy1oFjNAeBMHwHNqwUF21r19F9BrS
	woHsF7dHnfxoS/N9dwXErPldPbqCTomj8QAhNUGZycpMNMBafQI9Z1RffdJ73Sap6P5Iu57uePO
	PTYtwla91eQ5MNbK259wfulsQUKeAtgKPy/Lu2qVeRuXmgnYqbfUtySZJywnyRniMCZLy92Wz88
	WoWrNQx4hu7rMLTTrq/U/TMPDwqt1kMAiGyxrf/oAm4bYbecObPFk5hxUihGGNhOpiY3xeodFRn
	8wgUj4KfBbW2vik627ii3BymMhHA8K4ymmBWRnfkXwNnfMna15vrV9jY4jHYEKwqEC+CmpXuzP2
	WYHH+d0j4I4c2LSSnD0oHIrDk=
X-Received: by 2002:a05:651c:1581:b0:385:dde5:1bf3 with SMTP id 38308e7fff4ca-38a2c564e64mr24339791fa.6.1772650682396;
        Wed, 04 Mar 2026 10:58:02 -0800 (PST)
Received: from xeon ([188.163.112.72])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a12a6ddd3bsm704985e87.0.2026.03.04.10.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 10:58:01 -0800 (PST)
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
Subject: [PATCH v5 0/7] mfd: Add support for Asus Transformer embedded controller
Date: Wed,  4 Mar 2026 20:57:44 +0200
Message-ID: <20260304185751.83494-1-clamor95@gmail.com>
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

