Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AB22701D9
	for <linux-input@vger.kernel.org>; Fri,  6 Feb 2026 17:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770398949; cv=none; b=VZFKGJz7iOKmm58roFBZxo/NF4kH3E7Lbt264XokP8BgkzPKdFFhRaDDB/Ar8Kiaw6nKcRBRfEky7I6u9uZrHZjO8WTEEgx+BzKA3xdIej6Zbp4ax0rvk/XyD2h3UeNcnwhb73kCoLjYVdl6v1t+am2UpII1BhoEfMlF4+6sBSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770398949; c=relaxed/simple;
	bh=DMFf8IatqPgPC4SuwdNqD6eGuSOXIaGvf5N2KhUlJU0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t6tGg/q05Z7seU0yGAedcWZZeSysmKfmhNwa8+AGQWH2/Gg63uPMZYj2LOgs3LyDIhiG6J7IrCx87Q/ryXGC5NEApWVE/FUqqyojMqt892Ax0FW/dxcJoD5WFvOYPZeVjW82uWk2VCkYC9s6diT9qeEUOYr9Ovtxg8TgbDn5ADA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BMJqig8R; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BMJqig8R"
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-4359a16a400so2312132f8f.1
        for <linux-input@vger.kernel.org>; Fri, 06 Feb 2026 09:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770398948; x=1771003748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Jh4BgGzIqnS2YSFnGO3bkqStjslK7T/mmxxxgCr3KOk=;
        b=BMJqig8RAQuaF6pjM+zHc6hkfNZU9rwaBeF9HWG4Dvi+DPHKv4YmQ67Pnzh+tEjdCX
         e5SiaSRpTHNSA1hKL+P0wQ/YOZuzcb+nsaaemzYKpzIacmHipVgXsuBIsLsy7SNVFLfJ
         muJckl4mGi6xGWyf8fPXeHVLqFrVM3M07am108W8GWSet7DK240Fu5/Nv44ZXapyqLUh
         goh66DjKhzTuB8N8dDAecSZmUUjQPYLdBPW19pwiC3mNNPfx9nZoKOLdhXJw4KzzswWr
         Q0PPYytLxv9DL+6GMbvWyJV/Mk7ahUfZqZlIO3os5ROH5HP3NFsgxtrrBD2ED+EfLe6O
         HhFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770398948; x=1771003748;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jh4BgGzIqnS2YSFnGO3bkqStjslK7T/mmxxxgCr3KOk=;
        b=j3Gcz/wy2ocwqJ+DyUDpA82sMtSCqK2L97EGH7zFh1C7gc7Spk7bJeVWJI04QgUqv/
         s17lbaoMhDwiDsVaGftpl5De92IUCJWJ2ZHwHgXSgN1VimXI5SWkaEgM6bHNLl8sjvHj
         sWPQJ0pEo9CFE/8ne2aIKYfY/J2Q+/V7S62QhgROZnran1ioqSYtSQaDm7y9TpEPNpPx
         H9+HuT8loG2U7UgsO70j2va99vuuxzlRdBp/LDq2mdYiTIuobc2Bt7NHBkhS3j3y4m4X
         ShPdp2+URBscL5we2ooKwur2Ot6FXnfndNhnirajZ+T49/Un1CmSeasUeGbx9L39hFk+
         8f/w==
X-Forwarded-Encrypted: i=1; AJvYcCViVDpHOzh/BCzhuBXuiURTDzZA4crMKMsT4w7ss26qoSEgk/VY6ihvORYnlWA+J9GlF4yA80/VtYCWEw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyUyfGlfz+SCAaXUZptw7/B6rlbascKWsfHVCeVizevnhZDb4Zn
	dEgqaqE+MuMDqtywWv2/eKPC1aarquLr6VU/Kpbe3ipeLYqpf2+N17Uq
X-Gm-Gg: AZuq6aKMb3N+Jn+ghdfFEbrcRAKOMmMWMtI5c0V2e/L8PmUBOIxxin4IWfgNXB68lmp
	q4PbUZJxt7w/Ij2+1yQt9W39PpaJjBaQL7lQuv2hJVreD+EJQgVcKIdXFZTWrn3m7NboV9sugZ5
	i8NZvHUiXUVmY3S7Ch2V/st00AK8vP5/09xviKx0ywq2DqLGc3EXsgx0R4L7RRJF0CRyjk9WrTm
	MPXJcaDy50hEgGk7Vyo/pRL/EGVTl3cnXGRNZTaJJyWxIvR90Lv70zvOuGFwtBbat3GQ8JlwCUW
	beezerppapmvLeqxNlnxPUW3LsqJpEe27ZJfh7FV40Va/Y4deCPgWNFwNvKbIRmzJfR8wcPeu3U
	4qwW+DOFyT7anpAKaENKxFpxFK1ixsXyDhS74pLIFnh/rNH5mzwOIsWDojUs1ysB6SW2DQ5IFAO
	66CRGffTc2BOI=
X-Received: by 2002:a5d:588d:0:b0:435:94f8:e7c6 with SMTP id ffacd0b85a97d-4362933ac28mr4655822f8f.9.1770398947401;
        Fri, 06 Feb 2026 09:29:07 -0800 (PST)
Received: from xeon ([188.163.112.49])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43629734268sm6846033f8f.24.2026.02.06.09.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 09:29:06 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Dixit Parmar <dixitparmar19@gmail.com>,
	Tony Lindgren <tony@atomide.com>
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-leds@vger.kernel.org
Subject: [PATCH v2 00/11] mfd: cpcap: convert documentation to schema and add Mot board support
Date: Fri,  6 Feb 2026 19:28:34 +0200
Message-ID: <20260206172845.145407-1-clamor95@gmail.com>
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
---

Svyatoslav Ryhel (11):
  dt-bindings: regulator: cpcap-regulator: convert to DT schema
  dt-bindings: regulator: cpcap-regulator: document Mot regulator
  regulator: cpcap-regulator: add support for Mot regulators
  dt-bindings: iio: adc: cpcap-adc: document Mot ADC
  iio: adc: cpcap-adc: add support for Mot ADC
  dt-bindings: leds: leds-cpcap: convert to DT schema
  dt-bindings: input: cpcap-pwrbutton: convert to DT schema
  dt-bindings: mfd: motorola-cpcap: convert to DT schema
  dt-bindings: mfd: motorola-cpcap: document Mapphone and Mot CPCAP
  mfd: motorola-cpcap: diverge configuration per-board
  mfd: motorola-cpcap: add support for Mot CPCAP composition

 .../bindings/iio/adc/motorola,cpcap-adc.yaml  |   1 +
 .../bindings/input/cpcap-pwrbutton.txt        |  20 -
 .../input/motorola,cpcap-pwrbutton.yaml       |  32 ++
 .../devicetree/bindings/leds/leds-cpcap.txt   |  29 --
 .../bindings/leds/motorola,cpcap-leds.yaml    |  42 ++
 .../bindings/mfd/motorola,cpcap.yaml          | 413 ++++++++++++++++++
 .../bindings/mfd/motorola-cpcap.txt           |  78 ----
 .../bindings/regulator/cpcap-regulator.txt    |  35 --
 .../regulator/motorola,cpcap-regulator.yaml   |  51 +++
 drivers/iio/adc/cpcap-adc.c                   |  15 +
 drivers/mfd/motorola-cpcap.c                  | 139 +++++-
 drivers/regulator/cpcap-regulator.c           | 105 +++++
 12 files changed, 787 insertions(+), 173 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/input/cpcap-pwrbutton.txt
 create mode 100644 Documentation/devicetree/bindings/input/motorola,cpcap-pwrbutton.yaml
 delete mode 100644 Documentation/devicetree/bindings/leds/leds-cpcap.txt
 create mode 100644 Documentation/devicetree/bindings/leds/motorola,cpcap-leds.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/motorola-cpcap.txt
 delete mode 100644 Documentation/devicetree/bindings/regulator/cpcap-regulator.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/motorola,cpcap-regulator.yaml

-- 
2.51.0

