Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58DE36BCDE
	for <linux-input@vger.kernel.org>; Wed, 20 May 2026 18:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779301398; cv=none; b=AQnOfx+UA+Mae2Krfm2nnWruLPZxRplpf7p9sUxkvoWIAT3EHPAFxW1ooSP2B/NwGJGULKAR6T0/MaJTOFX0zK2gT/n8YutQeAY8tfoxPGpeFeENxJRDg2AyDCohS3MKiDYhUTHVLI/ep/snNXM/ImEVOwtOWn0IG7VsOwx25XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779301398; c=relaxed/simple;
	bh=u2OLiahfl07CNATXuFabWWh9FHbJAKKwBhG0BfZL37o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bh3UNj7FY+zzT8YLd1N14i/2snHTSQ0HE5qxYzPZHcyuEzYVDdJEalKQjk+tZ5UacaLdTr8Ge8Na/pyQH+wlgCq7R1AAY2ZzgqoktJBk5/7u0Lf/M9Apk9WXjmPo2lwNWzWWA1PlNs997T8rf9Dc/j1MHgTbalJTTwATh66DYxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DzNk9hke; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DzNk9hke"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-45297094718so4113281f8f.3
        for <linux-input@vger.kernel.org>; Wed, 20 May 2026 11:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779301395; x=1779906195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YOOkfLDGxoFwS+H8nJxSYqxjZdBzyZuCgc0/2jHIOOo=;
        b=DzNk9hkeA5tH0IcOuG4LNn2Pt1H0Baagmyfj2myXoEdVJb2uimWH2UhtK5DFJ18l6R
         ZTrq93rHGKC9SSzsnDKzepy4pQ2XDUZufdlmHO+dWswFqHTvKbN4QbfZ0m9fayvUVyiM
         rMC+LtlKNPVPDW4oQV7aEbyuA7CRxehWcmlzhD/ZZrDRWbZiofpj+CYM4qg8yEf1sOG7
         GK1IcoPIhyTQbtsCZ05fYuKYuD+yeBgLl4lBMUmfSqPORgm4rnAs1peUog0OACwvYzO/
         ZmcgbGwX9cysd2hcKbfYXz+k8IHruYhjZavmIaOLo86hMvylXAaVvge8VK5fRm4dPp7a
         9qkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779301395; x=1779906195;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YOOkfLDGxoFwS+H8nJxSYqxjZdBzyZuCgc0/2jHIOOo=;
        b=DuDZCI6FJx2oR9XhQNDnWxtLtaSl7YEpIfqpzCGrTAkQTn2Pv1AmK1FC0nfKUNNUUf
         FCsf9ad3gTEaXASqIu/SV/akhI4m3Iey1JmNuHdSrXLZcbsZxM8og88LispcrEUwNXlI
         A8j+kt9FvYG7Ao9vkaso/y0UQgrUt7mofqNbu0r9EspII8MdfV5FVyM0SB0TrIhB9akX
         1p2T+9EUulKutnTbPD0Xk3siZHEqXviRxmyOnMqfWSS5+rrtFGAiKsOPAr0/nDH6C1wJ
         R3q5RgyN9eXNhgoPEXTgEmdpq/Eb9qmV9EY5Vo9eTdF5l7gJJWY8x477vBIM+ob0vBF1
         F6PA==
X-Gm-Message-State: AOJu0Yy+EMPzcxV89GV8DbCUI7CvGkIbJduat6XWiFFzWho/MkScyX81
	JUHwNAUXBHpogsDzmbCkiY2BYKj5gV12kJWGjPCcXcuvsK7oGq+HGfm4
X-Gm-Gg: Acq92OFNl9MOcTotiqn9g8DiAvjwkj7cR5zmcpp+6rgIbGf03+Q0bsXccb8icm923mR
	SvyzmNkyOGpS1TfVBCaWZ86IwnnY7cKWNNLWFz3N/p3aoVoR1JEUWAWpt8z1Iiedwf21UiFacSJ
	R0p02mOztI2cbigj52NSB2tQZFVfk2R2e9uRrJwUvR0Mx8pq5jGvgTYMl6kzPipEvYhPZ9mbidD
	IIfswYenpwfeHodiAhJlt2RW2h1GugKDe4Q+mtAnLSxxyvK76avE7QPHJHFnUbl0VVyH2Q7/Ahl
	+M4nanaxntNG6t2YnKOXSRtkmGj0ikHCHhUACAihqD4Go+ZMhYdxxpDZW4j/j+l4Ifh+ld969Dj
	rQV4A/WXc7VZvqyEhCl/8EYpEhdlO+ia99IFg8V+6bvzxAZu2aa7YXJ7CL8JfSb7f1sRN8TknW9
	cScE16JnodriSkXBWYc8RzpV4=
X-Received: by 2002:a05:6000:2f83:b0:43b:3d02:7806 with SMTP id ffacd0b85a97d-45e5c58ed80mr42266150f8f.28.1779301395198;
        Wed, 20 May 2026 11:23:15 -0700 (PDT)
Received: from xeon ([188.163.112.61])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9ec3b18fsm51297739f8f.11.2026.05.20.11.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 11:23:14 -0700 (PDT)
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
Subject: [PATCH v6 0/6] mfd: cpcap: convert documentation to schema and add Mot board support
Date: Wed, 20 May 2026 21:21:18 +0300
Message-ID: <20260520182124.117863-1-clamor95@gmail.com>
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

Changes in v6:
- removed address-cells and size-cells from main node
- changed macros formatting and OF matches
- factored out common devices and made device addition staged
- dropped cpcap->variant check for 0
- EINVAL > ENODEV in variant checking switch
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
2.51.0

