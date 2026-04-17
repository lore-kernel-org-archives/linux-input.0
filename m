Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56C319DF6A
	for <linux-input@vger.kernel.org>; Fri, 17 Apr 2026 07:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776409894; cv=none; b=u5K2Gp5XzWhpsZ1g8hu/gJdKQK3yu9OlGopwiNW+7KmI188YWZpMB8noDdIWizR19VRHCLiYO8kokcE3ItZOQ9Z4LUSTf0dcynV4fDVaN4cohz0yImi5Iu2rj3vgmLB9yX/gXKqY2vL4l93ca6R1CKDwZ1DAC620sElBSGERwVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776409894; c=relaxed/simple;
	bh=qsbXpuOcVi9cj56MTeK+/eFhyj6nGZutYjLNfesMxp0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VqNrSlJGonKb72mmGfV8+c7tQGdQu7lv13wIZsyy1hpmLmziTzCIXZlgilDC7seAzDkEd6MD+gjiz3uRacGxbsTExbjSLFxhsZidjoCGbAUPeWCNeXIlG5KpxCH8PJBipwsnatDyiHrhZbNXWHxk8ruBcY3SJjQ9NukMS0QaEvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SI7P61jl; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SI7P61jl"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5a2967e5de4so381418e87.3
        for <linux-input@vger.kernel.org>; Fri, 17 Apr 2026 00:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776409891; x=1777014691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YjBeGkQBcP1nglY4BuR0wBXskpEgo4GmwzySCtgIaXA=;
        b=SI7P61jllGAXMO46ful3G4Ix/gf728v4Nayw2VzCVpmeyoioMt5EFAtwtsCM4ww+wD
         y2S/Qb+43gwMCRS3X++egMpG8jvIL80/upD9iVT/uZbRcCvTK0anHzbHeW9uZKoXH/mZ
         eWiz0GuC968OxqdmV4+B6mhqQ2owgzCR5T+ndhiCtztXL7domQd+4c7qjmASTJwEDR+w
         o28OpUKUGB0Ur5kl/JQtydW6L861i6t9BUxXj7jHZ2xGsLK4yb/Xf27vXAQdkR6gXFxe
         wsAxdEwndX22Q2V5iKASPzXowQED5mlX1EH12HgFWOm/fIfN9qQ3/6hLksvnEoiCiMEf
         KHgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776409891; x=1777014691;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YjBeGkQBcP1nglY4BuR0wBXskpEgo4GmwzySCtgIaXA=;
        b=Wmviwao5lDjzy8dNAyJnstusXFwZg4HIndMVjCxZrXs4xdOkMdC9NuSJgZfZyqL+bR
         iOfzwMbsit1azly8a75zaUZ49yVKlFKJXcpw2c7w11ZpTloeuHuRVwS4Td2/tAOV+pQK
         +camsKrwnNvCa6omgStP509bXF4auNcsQDsQZT1k+aCc854l4xJf2ggVXu6fW+6VIdb9
         SbdXS6VlM7m1MuphwAY3GncE7QIhKjE/aRNOdM1VPpN7759UuOtVXDrCJhtZaHdYRtk2
         cO30LyLILdnycpZ6DJ3bnNsWvvL2JvschaVKftz8/qH8NvblgjEXRdS0FlPNc3qcdIC0
         6sCg==
X-Gm-Message-State: AOJu0YyIPAc1CVAw8eqNv5eFOw/lioRf2oRkw5EDz/Bm2OUjGb88ldLx
	xPiod/CJlDN9pPhp9FdSD5LbqogpO388BOJ79sTbdM7gKlShq5CtdPnI
X-Gm-Gg: AeBDiesR7bjd0GI0U+Grnm0ypmTmJ0nr2EkWHKUVcBN8T0kvwqSZcCAhA9kuN7gM7lX
	yKwPoPeCgWed6+vg82C9wEOLv3T1kil9tr8vc+twAFXMtqhlyUKzPeku5XXW9cNnf+JMiT+/DgJ
	t4y+cVuRbunP48EhZs5Xxpcstw7ijXfbsvqt0Ub61EobilRGpBh6zbkMkCAL4HZOWJMqaP2la0W
	0y4gSU46oNdCP2C/Wn61QXjGST0EZ81Ul9V7IU1ih8uAuEkvJ065yO1/IIHg8wBRW/M22rUOheY
	ULp9V7br6UrqQ/Sgx66pMmokFF+5Z00Bl2AquNqVKOH5NzRqmxqZVvfUfTv+igT5LhQK2FTB8Tj
	Eng0go1aC2b+t3KEinG+XEz66gRURh/5SUmlrOpGwjioPOY3E0vbBh8a2xcSKKPL4fbT6OegFmQ
	jrtMrGafCQGsuXn+0fuqVQvKQ=
X-Received: by 2002:a05:6512:3d27:b0:5a2:b219:3eb3 with SMTP id 2adb3069b0e04-5a417308f0bmr463637e87.41.1776409890856;
        Fri, 17 Apr 2026 00:11:30 -0700 (PDT)
Received: from xeon ([188.163.112.56])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a4185bc240sm162772e87.23.2026.04.17.00.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 00:11:30 -0700 (PDT)
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
Subject: [PATCH v4 0/6] mfd: cpcap: convert documentation to schema and add Mot board support
Date: Fri, 17 Apr 2026 10:11:00 +0300
Message-ID: <20260417071106.21984-1-clamor95@gmail.com>
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
 .../bindings/mfd/motorola,cpcap.yaml          | 416 ++++++++++++++++++
 .../bindings/mfd/motorola-cpcap.txt           |  78 ----
 drivers/mfd/motorola-cpcap.c                  | 151 ++++++-
 7 files changed, 623 insertions(+), 145 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/input/cpcap-pwrbutton.txt
 create mode 100644 Documentation/devicetree/bindings/input/motorola,cpcap-pwrbutton.yaml
 delete mode 100644 Documentation/devicetree/bindings/leds/leds-cpcap.txt
 create mode 100644 Documentation/devicetree/bindings/leds/motorola,cpcap-leds.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/motorola-cpcap.txt

-- 
2.51.0

