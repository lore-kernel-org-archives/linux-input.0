Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986B738AC91
	for <linux-input@vger.kernel.org>; Tue, 28 Apr 2026 15:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777390597; cv=none; b=OtC45M9GThmGJhiqHmThOt/hRNeNP6aIRbxBfrvSO41CEvwP7nhBihNXxL3cjXFW5qPojLmKI6vqCd/+VUsPdp956WJoPuyK8RGbCC5LepS+gWFWMf+K0IV49y+rI1tMbKqfD8t3QQaf/E0lHFczrVLfY0HcBMjkXJ2I0RjlpwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777390597; c=relaxed/simple;
	bh=DS7IGgGnbIXdTV3Ckzjjp/VaA8K3sQmCMzuIXSeyGfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NLei3ysh99X+s7f1YITWhe+jkKttFJSkDFMEXgzrGLedLCCR9VFTh+/6SUhb2cEb8ACWVKRQzA3C8ONBGLD5jnQRHYMBZGWEkmQuqZwe1ljfE8No9NMwwYT6MTBTCD2GWOwBXAY1IDFUBACoAUa0vRiNxsw4FqXgq5SO2BkHNo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HtfWfNKP; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HtfWfNKP"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4893940bb5eso62477025e9.3
        for <linux-input@vger.kernel.org>; Tue, 28 Apr 2026 08:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777390594; x=1777995394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6ptl6Lh7lPIlpY98SxXugxOD9pHianxtP6o9VGnO134=;
        b=HtfWfNKP+FzEIYqUx0AKZvRh3pQbWZzYID3Fk6aRmF1ChVYFf650ZQF/myLrhUf3x4
         k2RiOmnG3G+1NiEn6gXaL+ILGh6IXxZJHhTth7NRHJMR68lH34tXhbG2KPT7UDZTGlw+
         PwpGBYPfr3/q2DLEe2f8D/kPuqbqZnuNa9gN+XdVtrZ87qMs8CVPvlMOdfesODx7Kgwq
         Nx0L+iMFbqOk4PUGo6JS0mXENafaMzVU8ngmN15368JbOHGPBuc6zkSS3scjOuMiwwpZ
         Xs514eCjJq3GLK+7SUwDFVBBrBEJaDb4sjeZAuM8IkiijZUuzktoitgVNnj+BQoIGgax
         d0dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777390594; x=1777995394;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ptl6Lh7lPIlpY98SxXugxOD9pHianxtP6o9VGnO134=;
        b=pxFuaFsQQGaGtsXJQK0fMW/18BqtO46BbVtGX9BlMkcjubQRU5f8YwObmTjkZGueH9
         kRq3RrK4WDUFB1Z+LyqZAubuzDjAlWRdlgBdKNISQ3xUWDoap4JjVFUgITZJwm6FLXet
         EW5mkzlbyeqD+ysrQHr+df8N/0meW8vA6YvunMTx7cOTNz2u//26GWFhedXiickCVQgr
         jlXja/5FoALim/ij1Qoxwnnl6NYC2FWCMZOVkyf4eBKbtHJerI9wmpyv26GZe9SY9sQU
         i+sn+HI06oUeNO0DcZ9/ZHm06Ot1XWTXZQytt5wpH88/EkxgfIL36/aBZOSy3pPzg9m9
         /EYw==
X-Gm-Message-State: AOJu0YxM7ldaXSvTmTtM8s1OSmTLQFpr7S2oeBMiOuCGE0sxIVn3cpAQ
	nxiMHC5zSvq41qQ6znvtyiXNC1xYIxtc4om/AGRVQiCxM/mziLFmhyGb
X-Gm-Gg: AeBDieukWFmZ7VeAxyR539TxijvBmVQAQpRUwceFe9n9mW+cNbORSwHxF67IbcNRY5M
	CCY/y4nLHWvOaIe5EnWeLRFUh83bCC8HN8nmi1Hn3yteEWZRE0Lw49kqP871eGbvIpl+y0ZONwd
	MTYQ+/skc10t+KKG78EsoUPt21fTcdALuCKtaCjLiX+GYFLrC5/2VU4vpIv5TUJMTyg2WI1I+wl
	z3SG2Cz+5Fv1aoQ0EXStCHvYxq+AUmg2i5Dt2bI+SA1vvTHIdBjloR9G2gZ0GQid32Wc7+bZXiG
	wMXOQnD/2fqk+9QIF5oDrYu41Newg8plzslsNtyC3caoAy6sSJCT7byLihaPH4BqtPIKeIYeW4h
	DhwELEcr1f597Qo5atqY2DPeK2Mv2dmnt6FGOM39fXYSbxjffRbo7o5Ye32/dXvqAuEatReCS91
	grmRsCwVHQzEe4T1laXMo989U=
X-Received: by 2002:a05:600c:c109:b0:489:2005:b36e with SMTP id 5b1f17b1804b1-48a77b179ebmr44911195e9.19.1777390593844;
        Tue, 28 Apr 2026 08:36:33 -0700 (PDT)
Received: from xeon ([188.163.112.56])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a7b56c2d0sm1358875e9.11.2026.04.28.08.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 08:36:33 -0700 (PDT)
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
Subject: [PATCH v4 0/6 RESEND] mfd: cpcap: convert documentation to schema and add Mot board support
Date: Tue, 28 Apr 2026 18:36:05 +0300
Message-ID: <20260428153611.142816-1-clamor95@gmail.com>
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
 .../bindings/mfd/motorola,cpcap.yaml          | 419 ++++++++++++++++++
 .../bindings/mfd/motorola-cpcap.txt           |  78 ----
 drivers/mfd/motorola-cpcap.c                  | 151 ++++++-
 7 files changed, 626 insertions(+), 145 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/input/cpcap-pwrbutton.txt
 create mode 100644 Documentation/devicetree/bindings/input/motorola,cpcap-pwrbutton.yaml
 delete mode 100644 Documentation/devicetree/bindings/leds/leds-cpcap.txt
 create mode 100644 Documentation/devicetree/bindings/leds/motorola,cpcap-leds.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/motorola-cpcap.txt

-- 
2.51.0

