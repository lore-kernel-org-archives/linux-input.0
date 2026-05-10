Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA658332EA0
	for <linux-input@vger.kernel.org>; Sun, 10 May 2026 11:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778411313; cv=none; b=FwYnzlBLhjBIqRcD3K5MfV4+KL15+7K2JwWv/MQCoiW5DN2f71qNEllxgs6K3b/9/3ACmXWJcwqUcceN12IAViSCuwki4VJ5PivjgjOi8ssyLLTMsDVWP/PA4h3kHOU6zSMdrb1oQMsfZGgLCeosCWkiCne63ly2J6PIre0DlzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778411313; c=relaxed/simple;
	bh=VZr/KgDt/hGxG6GZ4EDdLnrAIFerfJ7PgEKpMx+t91E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b1j3vZQt+VwcPE9kbAtDUOEb7nt5NzKhoUBhygC7aYkHQRpzMQ8AMWD909/dPDmVsSVcITJuFMDYHjq8mHyzQKGStK/d81VapfILVNCcrzidEebhZMwAfqum1xvl6VeK7DTM2i8klWABgg8QJ5JXOJVH/MzToiFpdNPzBHywneo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BwL/I45x; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BwL/I45x"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-bccd251d622so119433666b.3
        for <linux-input@vger.kernel.org>; Sun, 10 May 2026 04:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778411310; x=1779016110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w7VsOIce7RBjPGjcbUBZuNu1NQetW/4tiS7UIOUx/bI=;
        b=BwL/I45xrnylbMqje1bY0+ecBHS2i5T6II4g3p6x4SZpptZPt+nVNYhzfHK/36i2n6
         SzuZQGyctdMCvxKzuISXL0tZ8V3+e4C9x0eEQ9hNfyACkkyBjn/exrp5kCFti5eUG3Cp
         KftpP95gAb/SKaXLrdXgJk0ZCD6p2aADJFWkgW7dHKQtjUKcFQXkE6hv1rawZcDsLHpl
         2+M1urt3dFs4U9HdEhYtyPRXQL1pysQBahEVJ6F0OEgGC8RHA1U6FzF0Xwkn0Dtz4Q05
         jjBvhpFFSca6cXG7mlfyQJMPVwLtSaFj1We2WZE2ROIvG/7za6csN4Yrn4NfS7gcDkvR
         Ablg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778411310; x=1779016110;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w7VsOIce7RBjPGjcbUBZuNu1NQetW/4tiS7UIOUx/bI=;
        b=is8sP+fcWd6+ViksoiG+EMQekxlu7qM+hapd7cVa+TJE/9C8pt9LcVk/px/Bne0XwR
         zOKJpI1DKqnFZd1NIf/d4Cl7CUXLK++kf59OFqcubpI9o/hh1O1umuGGgvW3yrrRYncC
         OL9AQTVkoE59V/LzBJPyOUD8RP3E21FqJYGWc1SkzIxoVZA1EeE0kD9Thkra86V6bQgx
         oxt+GCW5+GP/9S8nc2aKXKkmX6GgdsfxCfahT58S44tNiNx3rShud4F/muuKz4KPaeIB
         1MCg28wJiAgHQkdDY/96ElKEfyi20r97ogM6bH9EHWuY2FCPVvdPZGveF/9t774dmDPg
         0Q4Q==
X-Gm-Message-State: AOJu0Yxmlzcj6F6b4NAppB/2pn1Aqm6QfIWVoX1FURdIC4kEsMbwKRhD
	vpAS5WlGeNuIYBMVnHt9t6WZsafxCC5pnA1gRGzWLJLbDXpw3AhbBdvE
X-Gm-Gg: Acq92OFErR6UzKkpu3wlJejrhTHZ4pC30N+S8ssuIH1WqTZ3pzsPkuhpLOd5vZn5HWE
	ZecH/JgDcoPRCWRwGb0ngSyrxVapa34I9DPIYD2CD2bwI8bVWZgOqXKP6ILkBwtOf9dwD4vsm/k
	Z9gXeHDMKIRP1G8jMBeeHV+bYy0XaoP953z6nyVaEtRzINsReDMJuXv6S97X3mfd7VY8twP5OHj
	ewQk2x8mqM39y1r/sRPdyy4iVyDuPYP6zbKHpJLB7B7o3oVlIklIwQOjTqwwIczq/EkosHEffl3
	brFtznFKkb3trtrMZagL7Llld/JF3MbWWIBPNnqImlcfwtbmgcKlHMo8KePoe7mHdHt/4YXXF2/
	9vI3t7djFrQZYYHivxwr4vEq6i1Agyj5tBnZegh+wekEhuQY0mMnEni2yVZOyrDRCAkDlYziUF+
	Ra3y/JtXlgcRifcT1bp346ZgI=
X-Received: by 2002:a17:906:f58e:b0:bce:e7ac:3682 with SMTP id a640c23a62f3a-bcee7ac45c8mr61385966b.33.1778411309862;
        Sun, 10 May 2026 04:08:29 -0700 (PDT)
Received: from xeon ([188.163.112.56])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bce7a3fcb57sm68146866b.60.2026.05.10.04.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 04:08:29 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	Tony Lindgren <tony@atomide.com>
Cc: linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org
Subject: [PATCH v5 0/6] mfd: cpcap: convert documentation to schema and add Mot board support
Date: Sun, 10 May 2026 14:07:58 +0300
Message-ID: <20260510110804.33045-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The initial goal was only to add support for the CPCAP used in the Mot
Tegra20 board; however, since the documentation was already partially
converted, I decided to complete the conversion to schema too.

The CPCAP regulator, leds, rtc, pwrbutton and core files were converted
from TXT to YAML while preserving the original structure. Mot board
compatibility was added to the regulator and core schema. Since these
were one-line patches, they were not separated into dedicated commits;
however, the commit message notes this for both cases.

Finally, the CPCAP MFD was slightly refactored to improve support for
multiple subcell compositions.

---
Changes in v2:
- fixed code style
- rtc conversion was picked, so patch dropped
- added audio ports description into mfd schema
- splitted schema conversion and compatible addition
- minor style improvements and typo fixes

Changes in v3:
- added regulator node names list into pattern
- filled spi_device_id with driver data
- ADC patches were picked, so changes dropped

Changes in v4:
- dropped regulator patches (applied)

Changes in v5:
- switched to MFD_CELL_* macros
- switched to use determinator of model
- switched to spi_get_device_match_data
---

Svyatoslav Ryhel (6):
  dt-bindings: leds: leds-cpcap: convert to DT schema
  dt-bindings: input: cpcap-pwrbutton: convert to DT schema
  dt-bindings: mfd: motorola-cpcap: convert to DT schema
  dt-bindings: mfd: motorola-cpcap: document Mapphone and Mot CPCAP
  mfd: motorola-cpcap: diverge configuration per-board
  mfd: motorola-cpcap: add support for Mot CPCAP composition

 .../bindings/input/cpcap-pwrbutton.txt        |  20 -
 .../input/motorola,cpcap-pwrbutton.yaml       |  32 ++
 .../devicetree/bindings/leds/leds-cpcap.txt   |  29 --
 .../bindings/leds/motorola,cpcap-leds.yaml    |  42 ++
 .../bindings/mfd/motorola,cpcap.yaml          | 419 ++++++++++++++++++
 .../bindings/mfd/motorola-cpcap.txt           |  78 ----
 drivers/mfd/motorola-cpcap.c                  | 172 ++++---
 include/linux/mfd/motorola-cpcap.h            |   7 +
 8 files changed, 611 insertions(+), 188 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/input/cpcap-pwrbutton.txt
 create mode 100644 Documentation/devicetree/bindings/input/motorola,cpcap-pwrbutton.yaml
 delete mode 100644 Documentation/devicetree/bindings/leds/leds-cpcap.txt
 create mode 100644 Documentation/devicetree/bindings/leds/motorola,cpcap-leds.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/motorola-cpcap.txt

-- 
2.51.0

