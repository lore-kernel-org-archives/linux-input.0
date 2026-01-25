Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2344D31B117
	for <linux-input@vger.kernel.org>; Sun, 25 Jan 2026 13:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769348595; cv=none; b=fV+CHF7H7wVf4PxSem5bBt3mnllzjN9u/eA3oCZq9ippTEwOwzhwudLWQMfVZzHfd9GtHMpURBuqdKm8PBXbN/t+kBut3cNZKShEVbyTwn9N/qfiTsT4DpCtWCgbD8MsWgpevk6sWH+6EWQ/JC1Bbn34AVqhf7skp5Ppe1Gtfy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769348595; c=relaxed/simple;
	bh=JJjtH9otRLzOZRR9aD+dplHYB+LHXNglPxedcB5O3Ng=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WAQJGSqb5NxPlhPxKWQnvic8/u7gkQDskxE9zitr/94a9hIjn3qcU9p/1ooepINkA0oUKFT5E28nqKpK3G9HdXv6agqd4OMAGVRiPunOaGcBz88jrXISe+tktuu6qqmx/vKkqfiEfN1j9xmVfhyp3iq573NZ54WyXWQZlCp7pwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MTjBm/Yn; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MTjBm/Yn"
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-43590777e22so2147766f8f.3
        for <linux-input@vger.kernel.org>; Sun, 25 Jan 2026 05:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769348591; x=1769953391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8NUf/i0X9PwsOhEP5BF7TGftifUEandWRzmLdR3A48k=;
        b=MTjBm/Ynp16NWWrM8ZY/wXQXjKbs4ihg+0O25nBNys6RA66yKbbXtSoXMG84R5NvKn
         St/U8M8lhig+j+WOEsDASNef8CFFAl1+fQLDWlH334PgF987zQvyrPw/7qaEkZ1LQM19
         Dz67Lp7engVYWNksAoM7P3eQiYpzS0xrMn5TLppZQXdDUZ4Iai1Y9jgAWC1b30feZxdR
         qkhRD5GlkLSgUhH8L14n4g1vwCtr/BTDebW+9EvYyBotkpb2zNQSWv72msaFqsO+HFUN
         DvYOr9tsMhUw8SKJSluK5ZFozXPppPcjKtXjPrDkzs8sY7CHttUxWd3+tH/S7qA8C/6E
         3o9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769348591; x=1769953391;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8NUf/i0X9PwsOhEP5BF7TGftifUEandWRzmLdR3A48k=;
        b=A0+BmL+Aay1zAcx94utW/A1eU7fNwdhtQwnC0if0bebMbAIMF+L1pyFKoLd+ahjhXW
         9fax5HPUWUN4jyfNLo4aHnpiQ+oUmyqh5cK1aURaUvPde2JOe91nRqDF5dUnbT1HveHG
         AlkXodNeBGn0nf8Nz/kUsFTfre9Yz7v4KxD3IlXrUfnov8tmaMQgXdHldcMHzbg0Ggj7
         DmAqAsJjUpr6Uo+81InjEJInnewrGndvRyfJDaJeopjJoWCRPfNACWcg6X1FdTlm1ZRX
         C1GphuNVoI71iriUEaSWTVE7vsn+MoakKBm8JVOyRBUYSckEDWcG32o828YFdE9RJjtv
         qRqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVps1OlCpVxUMU3mq2Lk/L/f6TokbuZMfJZaVo6P/RGwzvqGhVaCSYwIFulMDnRCFRg7SWaaUOZDZ0yg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxcgcLiCz7bZmAD1ZmosqQuswCyL2S3ihE+7lV9uWYaWWYCaBpi
	5I0CmaBFH18QhdAS3ytXFN4+Ywweb3APwO5zgfMHp+2H4OkCTYl6DVQ1
X-Gm-Gg: AZuq6aJK7OxUoIJNpOSHFMnsjnmZy9wh2WJtMIX8VIBJ1wKZ/96nNA34ArCaLXUdibK
	52Ri88kU+A6CD7O21YdkpCs3DNybrIF4uAdTzAPJRjjDPEhPuQewbTbZM3S3kvVUf4SHK5KIJ7Z
	uKbXlekgFiXO+ok8JNgJFXco4f9mKNkUAn3cyPQFxKlqvFLyJlfRLIfbmRP9Gc88k8DRbBSzycf
	21Bfiinzr7TIuEWeB2IcJNQnb28YUXIeDg//MViZh4xFCUxdIGddeeyRr0CwblDFZf10zccTH9M
	wMp8s2pFx5qBgqSzgnnZMig6y6c0+5Mv5yUI6SAhOZVCjcul0DUjUQBvetkLshGstBRWeSQnKiF
	ekCd0n9vkeYlEC+MprYeshtjT4NCtOH0L4Cy79twHYd+cSbMSdllAu7msQijlO2ozj4RYgCH6Nc
	dU
X-Received: by 2002:a5d:64c4:0:b0:430:f40f:61b9 with SMTP id ffacd0b85a97d-435ca0d3e4emr2467557f8f.4.1769348591411;
        Sun, 25 Jan 2026 05:43:11 -0800 (PST)
Received: from xeon ([188.163.112.49])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1c246ecsm22459688f8f.10.2026.01.25.05.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jan 2026 05:43:11 -0800 (PST)
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
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Dixit Parmar <dixitparmar19@gmail.com>,
	Tony Lindgren <tony@atomide.com>
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-leds@vger.kernel.org,
	linux-rtc@vger.kernel.org
Subject: [PATCH v1 00/10] mfd: cpcap: convert documentation to schema and add Mot board support
Date: Sun, 25 Jan 2026 15:42:52 +0200
Message-ID: <20260125134302.45958-1-clamor95@gmail.com>
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

Svyatoslav Ryhel (10):
  dt-bindings: regulator: cpcap-regulator: convert to schema
  regulator: cpcap-regulator: add support for Mot regulators
  dt-bindings: iio: adc: cpcap-adc: document Mot ADC
  iio: adc: cpcap-adc: add support for Mot ADC
  dt-bindings: leds: leds-cpcap: convert to schema
  dt-bindings: rtc: cpcap-rtc: convert to schema
  dt-bindings: input: cpcap-pwrbutton: convert to schema
  dt-bindings: mfg: motorola-cpcap: convert to schema
  mfd: motorola-cpcap: diverge configuration per-board
  mfd: motorola-cpcap: add support for Mot CPCAP composition

 .../bindings/iio/adc/motorola,cpcap-adc.yaml  |   1 +
 .../bindings/input/cpcap-pwrbutton.txt        |  20 -
 .../input/motorola,cpcap-pwrbutton.yaml       |  32 ++
 .../devicetree/bindings/leds/leds-cpcap.txt   |  29 --
 .../bindings/leds/motorola,cpcap-leds.yaml    |  42 ++
 .../bindings/mfd/motorola,cpcap.yaml          | 389 ++++++++++++++++++
 .../bindings/mfd/motorola-cpcap.txt           |  78 ----
 .../bindings/regulator/cpcap-regulator.txt    |  35 --
 .../regulator/motorola,cpcap-regulator.yaml   |  51 +++
 .../devicetree/bindings/rtc/cpcap-rtc.txt     |  18 -
 .../bindings/rtc/motorola,cpcap-rtc.yaml      |  32 ++
 drivers/iio/adc/cpcap-adc.c                   |  17 +-
 drivers/mfd/motorola-cpcap.c                  | 134 +++++-
 drivers/regulator/cpcap-regulator.c           | 105 +++++
 14 files changed, 791 insertions(+), 192 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/input/cpcap-pwrbutton.txt
 create mode 100644 Documentation/devicetree/bindings/input/motorola,cpcap-pwrbutton.yaml
 delete mode 100644 Documentation/devicetree/bindings/leds/leds-cpcap.txt
 create mode 100644 Documentation/devicetree/bindings/leds/motorola,cpcap-leds.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/motorola-cpcap.txt
 delete mode 100644 Documentation/devicetree/bindings/regulator/cpcap-regulator.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/motorola,cpcap-regulator.yaml
 delete mode 100644 Documentation/devicetree/bindings/rtc/cpcap-rtc.txt
 create mode 100644 Documentation/devicetree/bindings/rtc/motorola,cpcap-rtc.yaml

-- 
2.51.0

