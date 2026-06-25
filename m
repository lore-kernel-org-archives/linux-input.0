Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AE737FF40
	for <linux-input@vger.kernel.org>; Thu, 25 Jun 2026 08:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782375506; cv=none; b=AN3pJAhRze4k7ssdCigmhtH/UMe6S25698ZWD3Ab+RJlFam7w5drX/rt4RGFm5vj0h08WRGOUgrwuIn+Rz875mv3bbVyahDMhcfMkrXaBtmEr3R9qGz+gY/8GdKChRX+PFgMU+V6b7b66FKXMITcORclWVFzIONPQiVFexP0GQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782375506; c=relaxed/simple;
	bh=u2OLiahfl07CNATXuFabWWh9FHbJAKKwBhG0BfZL37o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TpLvuWWm2VF/3A7kem3tnOiLoTp1Dhw/XIcR8v5AY4twKZ01vfty+pVDxJhbq1UIrtfLfMDyPmGp4jrOn9QxcgzCQv0v+X8lEu2PRblxhr3RmJNjE5OXFtlK5rc0+w0bE0wK+JHTT2DSut9m4fCQxWaN3B0ad3Y5uMiaZhxdVPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LbH+fc0m; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LbH+fc0m"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5aa5edf347eso1339160e87.3
        for <linux-input@vger.kernel.org>; Thu, 25 Jun 2026 01:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782375502; x=1782980302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YOOkfLDGxoFwS+H8nJxSYqxjZdBzyZuCgc0/2jHIOOo=;
        b=LbH+fc0mUpm2TnQ6mUFpSYq6mgq50Ar0kFsB5G02S9I+VZwPhXDUUKufv4iDkq/Jfs
         ybC44cwB9IzR48YxW7RzntLyAVaDeL1dwkssQjj91CYGK77OsfG9TUYHxvrbhnPhjd0X
         F8jxJkfGaJZBb91vpDx8icNjXVkLv+QYgMxqD897mtAlvxdO7hc69yG9ohflcVqja87m
         bIWIT1kAaH2wwvVK8VavuLszhzyXUcQcgv9+On9N5Q9kFedoXBARsX4ggE0mXz8IYDUC
         GNYOAy5xQ+ha2OdUUhgMHuf3JfclJPHjywRqJn5XcjWB87uvyR0EtFcme8Ks7mGCnBde
         jJAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782375502; x=1782980302;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YOOkfLDGxoFwS+H8nJxSYqxjZdBzyZuCgc0/2jHIOOo=;
        b=rsX8tqOg9kvglohMD/bfZa3/aRWjEswECDRlobXBMOH42Zhv14tC9TiPoC5MDyCmJF
         8nalUdoWBU7oHEPeulz6/OOJj5EHVwAXVdt49SSjFRNu/FH6mTbdYjXZUiySXNPdPqd5
         Tj9j7PhIz804WJ+GPtndfa1UHkrV5v9U3+VRsTjtfUl8nEgRRTtVIqNvofUzgL2k1DCz
         VauFWnyVA/jK62MQohPCimsOLfzZ3X1ppKYs4Fli0yFxlE35ID5EHSNw7+DUJtSzW8zl
         b4H42lohnpIVGGf999k/MkdxrwrORKQVI3cIqKo0yQdPNwn4qdCHyFXToNgfOWSUtGfh
         al6A==
X-Gm-Message-State: AOJu0YxvJ7gP8wGvbWNAkg1n4+7OzQf57ilYIpq+XD4C/n4mbpdGAiHc
	M1c2whSO0EWtHrsXRQpeSkOlpmKkD7DWQiiuhwfhl8UymbDpJhMyowpj
X-Gm-Gg: AfdE7cnqL+hf2Kx0Mt4B62tF8bU3juhJ0ujDepf1xuSrxrofpz2eG1jLPQ3Jff3rUH7
	Y8QpmNuHF/+ZgDlNzqi/PNWm8bx2ecS4iE8pgHQcmgjjtcjX0mvLNYph4ojQ4XsnFhqCnNxoAzE
	WA2B7Ebrn81nKH+T8doiUdLeAAqIew41RZR1HvWUZEzi6zmBQkMUYrycQiPtwlcedgZwk8XjfB1
	g8sm8sI8aQbhyYDjmmYoNUoKzYQZ+VmZFXJaKspI2W1wBatyFPQeDHlwa0KhiFsj0kvGdRduQ07
	DBQVTjvKidcqIZOId1mVOG84u4RbsMAXBVyol4Xn2II6FaAquOHr8B2PZVtW1ZFkGjBgywo42g2
	waa7z30VtudNaenoZlSSwj+TcCxrExiyQO8XOYiJ9/AD84dIxN8HoQjGsVvckcj4C6TsQbCxySE
	O5GeRXbJfX2nzfGDUgGnu3MDDSioR8Ey6UHJhtulZWGg4s
X-Received: by 2002:a05:6512:660a:b0:5ae:9fab:df10 with SMTP id 2adb3069b0e04-5aea1f63f68mr385519e87.32.1782375501911;
        Thu, 25 Jun 2026 01:18:21 -0700 (PDT)
Received: from xeon ([188.163.112.61])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad6957a268sm2464601e87.38.2026.06.25.01.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 01:18:21 -0700 (PDT)
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
Subject: [PATCH v6 0/6 RESEND] mfd: cpcap: convert documentation to schema and add Mot board support
Date: Thu, 25 Jun 2026 11:18:06 +0300
Message-ID: <20260625081812.33474-1-clamor95@gmail.com>
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

