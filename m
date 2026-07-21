Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9EA44C641
	for <linux-input@vger.kernel.org>; Tue, 21 Jul 2026 09:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784627829; cv=none; b=AOSLar4HgwVxoxJR6olGf+AJxiaMEiGVEIf4tW/mVwbLDFQsa1SIILYMkkmrjQx5Sj3rq76WxxcSN+0lo69cecplpZgX9vbNbaL3nk52vmAT+jfH5lYTd37J3mEi6M0+aVOYCnCeFQoE3YuaTnjdX7trsT65lvF8Q2EL4ATnaRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784627829; c=relaxed/simple;
	bh=zZG0SwXpBaudvhL8T1nanzDcag2V5GkwhlyQJoKbJVc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iBNZBFtG8TvIv9I98uiqYva4T0jDrERi6vtbYo12JMf5vC3+VI481MtO8jcQ6gMDqcp6OBXSbDmWHIxUpuFp2a3uxb7xNcDpBKHxze0+yU7c1mhhjykrDyQSQqc2n9cBGjsqaJ5D+cH/W8GFh9G7LwRZQwf5baoJg0u8T/+Il9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JUj44CDh; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JUj44CDh"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-495635a85d2so12389295e9.0
        for <linux-input@vger.kernel.org>; Tue, 21 Jul 2026 02:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784627826; x=1785232626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+cGDwZcLwL8KiYreb24CUFPP8K2PTwnHJJuWk44wG5c=;
        b=JUj44CDhuKTiTTOJyxA8aHtxzT7D2WFNmg3NJbUoYfVWToRui8LJVoz0Nw6nMJ6fzN
         BsAsmquaf9zbq8S82IEC+1xqCALMRnkVdqzeJ32gwa3jFZicjUY2UEKpWWbwL6TU8JDF
         uLTnRjVTIf7YYP+QjRYjQf1prWwk7WpRrDmKTzSDxJA4yeROAfV9k4Vtu1q33tALDMXD
         l4mTYHu0VhF4pW4EjFJ9Wk4rVKO46Gd74vknnl0S2SpQyDvkIfX7OYK2dp2jb874t4Sr
         cSgP/Zl2YKLJpIS+UvZc00wABo5nf018NmcdAwvBnzehHjAlxkI/E/7s1rW3tCH7AyuC
         evew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784627826; x=1785232626;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+cGDwZcLwL8KiYreb24CUFPP8K2PTwnHJJuWk44wG5c=;
        b=cWJw+3ZxOUJh+8TXB43KDbkWUy2Bq/GMM9BBzbOAsz4t8/lO2/UGKPEzqOze7fuisq
         /3gxjHFPOryeEali8XcDroOoFsKs/HkZXIoX9brBIhTJBhB7t6Qcm49lhlB420yfF9PE
         XllEn43C509sSSg6G1YRCF3rJHz/HaRR1zp3/sSk4UP58tmFJPPD2fL1vD/R2T1+IJgS
         ZjAP4BZ+slAFpIyGMzET8jgvUbt87R76bg5G40LuAxM4pq6VWFq1xi7LJGP3eES9EvL5
         IgJbA1goAZ23P0anYRkVH684ZKZdE4aLG/RSbamtIpCSaCapBmAVAQdRsZaTAQyH+qiN
         E4Jg==
X-Gm-Message-State: AOJu0YwaDxkjSnFJYLMWYKJwewTsptUPf5G8QLiXwwElhHhmuFhgLah1
	FiHXHpCAxSmlcFBNJwoeEC9Bywkg/ahoeLN03zd7hHo29yBy2PjwyBbp
X-Gm-Gg: AfdE7cno7jtB9y2mu7ys1KkicN14Nz1RagLBH8wSD3QrXTYiAe3n0tmxQEKuJuAeeHG
	6BQzRHEP3m2DQNNt6u+vmiGC76RgsVJry/OucrNJD0Fz7kqAaCzHgDIv2gx5IfBPldwdvxuYRQW
	kRkqTqRgcofHtmL3Rw3t/oM1+coTzgBC4XCUWKqflSjwFDxT8vUcDHMAzyJUeBE30pS1afozaDQ
	8zKjod6OZXGskXO2KVy7nS8xKykzUjJuV4Srpk3NGmJZSdOH8Jm9zGg/6a5vvgziUpMz9kpDkRG
	DmIkTbLA35XDZUtyYeN7eENMLIcn3UE5gg1p6QRcjWETp2ykU2mmOI3kLTHWCpcosz56fk9ZpTG
	CmdxczDw7xv4EDENpoIbaiNTuTK4WJTeCKA/0mA4qDIS22eHnx7m41ouEIfSiOVYLXLLhuqoxRh
	AqUEZN1hUnb/8lw1NkmYwEcuM=
X-Received: by 2002:a05:600c:4fca:b0:495:4e1d:82df with SMTP id 5b1f17b1804b1-4954e1d843cmr165855415e9.10.1784627826040;
        Tue, 21 Jul 2026 02:57:06 -0700 (PDT)
Received: from xeon ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954995b78dsm227476185e9.0.2026.07.21.02.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 02:57:05 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org
Subject: [PATCH v7 0/6] mfd: cpcap: convert documentation to schema and add Mot board support
Date: Tue, 21 Jul 2026 12:56:47 +0300
Message-ID: <20260721095654.429346-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
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

Changes in v6:
- removed address-cells and size-cells from main node
- changed macros formatting and OF matches
- factored out common devices and made device addition staged
- dropped cpcap->variant check for 0
- EINVAL > ENODEV in variant checking switch

Changes in v7:
- adjusted spi_device_id entries (name/driver_data)
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
 .../bindings/mfd/motorola,cpcap.yaml          | 408 ++++++++++++++++++
 .../bindings/mfd/motorola-cpcap.txt           |  78 ----
 drivers/mfd/motorola-cpcap.c                  | 143 +++---
 include/linux/mfd/motorola-cpcap.h            |   7 +
 8 files changed, 571 insertions(+), 188 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/input/cpcap-pwrbutton.txt
 create mode 100644 Documentation/devicetree/bindings/input/motorola,cpcap-pwrbutton.yaml
 delete mode 100644 Documentation/devicetree/bindings/leds/leds-cpcap.txt
 create mode 100644 Documentation/devicetree/bindings/leds/motorola,cpcap-leds.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/motorola-cpcap.txt

-- 
2.53.0

