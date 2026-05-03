Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D2737C90D
	for <linux-input@vger.kernel.org>; Sun,  3 May 2026 16:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777827178; cv=none; b=Zhy+qK/bNsKYU9sqi+iYS6v1EzCO4eyKg+0W2wTlzbYvhCIHPkCLp07fipaDq/OufaGem+Lhej4fSMuXXRQFwEhHWF6TTGiCqt9WU2QUkQ9MgiicfBllXAG3YYrrDC61dpfUoKgUiNHsbydbSDamRFkZJi0MeXp1rPwf5bpomJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777827178; c=relaxed/simple;
	bh=otc+OpkaiKiBwUF+tcUidC95oQ2tFxa+9cKGsKaCglI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cHB8kAXcHXrhf0GL33oUTOhvNFBJ9PwbivLmTKC17DFcaGPOmNICOYykQv6EdCpEbtKBnqi3PLSpDq+rtMOWURzv+OcYQIYdxKIWR/K4kSiSE2rDGlFfvrBCSjREN3DNOLqbm3RTC7CGhJRCWKM+Nb2fwO9YFAftEMv3+dUe1Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KDTHcUjh; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KDTHcUjh"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-bc188a20e0aso58134166b.0
        for <linux-input@vger.kernel.org>; Sun, 03 May 2026 09:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777827172; x=1778431972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7Wottvwh2F068u0uO4a2RGm+BqrKKg4sWw04x7ifouY=;
        b=KDTHcUjh7LgoxOkPrkoK1I9RuOAl4OAhKfealjOJ381/qsIyyMJfq3dLdUjfzDmHZS
         PACtTqztKocVZqHkEy/akoViFEc7aBN78adt6PQErjT7NK54CWPgsAJj0tW79iQX0kwQ
         41aQ+SlP8Sj9iRm/VWjH770eJyqLWIt3EdzJdac/bzZp4IVKT5n/OTISSHVsONnXrw3N
         trSUdBTy6Jg853YHnpZToXZTiy1hoYoniZpoM7ROb4omK08lH8Ju5Uyj6oAcMrIFcHqO
         I5Iuc5aOsxbj+ZQbi8jFGe7MD0AocjoKrc9Y4Cq4l9xc+qsSevOHThfuD0RwkJ0UClrF
         YAUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777827172; x=1778431972;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Wottvwh2F068u0uO4a2RGm+BqrKKg4sWw04x7ifouY=;
        b=gcCZxZqE//l7k6FwdMWpRPXjIpngzlFRSugfUkVYCvOUEY2PHNAoeeqFbRaY1he0fP
         h4CBQa0pXY8oVMEM0RYcoEjVbUho2RI+5Y4sA/hyH0q2+u84QyRdst5OjbOdmkAkwkku
         tKqjd2D8g8l2pbu3yoays9PXE7LVp7CM9Zb9ZvyPNI9ixM2IS93Uh7nluhVz3hiQIQf9
         fdOcuZUfr0+miIdlgPWA7ZqWZsn7dDVktDZz7oxEvCehwHCoWI5yBpy1GIf7ZGD71L9K
         0zokdpDinsT27JYb8sacrixZrwT2chdyzUkB3BVsSYWbhoBIauH9sHdIofX4L4KJe9wD
         LIRA==
X-Gm-Message-State: AOJu0Yz3cN+j16rSbtmN2kpVsCN1xo9tnzep0kpT+K9mRuvKx9jKW4S1
	CbQROIM3VWHmJJ5ERYiqa/XMyMaZrRTT/4rtUUTQ5awVEx7KJm3aQg0Y
X-Gm-Gg: AeBDietbVobGFdQJHHhxFnW4tFYetfp5OtfeJJ6MUHNmQ1+G2MVmllhQ2BnfBEpwdr/
	UD3YqAFfC/ENr7YuAAhc9VH54nqRInbHtN7uqk2TtuW0Xl/CEDAEKcX85cp2bmuz32/nMQIIaGQ
	2J2P6u2MUf9lFcK/qmYEp3qJ77sq9+zKXQy0nxplPBQoh+YA6MIHcgUIrI/qEZB+a/EIwawKQcJ
	jO0XO+o52vmcYh167AVc08dK7jsfeVZOer3hOwGOMzBbbWyFEGeLg9m//0bLzeWgxIeKBo1non4
	iyRMXS044PiJDEJ3ClMRsqgUEH3pgMHTJkSrW0n8VFKMa5+aNWwpNQUE21GNF2hgAaD8g3naZCe
	WDwFj3BbrT0AUA+lyrIm4CTydPC9jzrlDowNNcu0O4FZ7rMVzdrgmOz0E+dBOg5IXBN4EdeTorv
	gcrPGoH2GL2zX2vImE/NMS6+0=
X-Received: by 2002:a17:907:3f8c:b0:bc1:606b:1198 with SMTP id a640c23a62f3a-bc1606b1341mr133515966b.10.1777827172110;
        Sun, 03 May 2026 09:52:52 -0700 (PDT)
Received: from xeon ([188.163.112.56])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bbe69f6b7f6sm316772566b.3.2026.05.03.09.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 09:52:51 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] input: misc: add support for Imagis ISA1200 haptic motor driver
Date: Sun,  3 May 2026 19:52:41 +0300
Message-ID: <20260503165243.215979-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ISA1200 is a haptic feedback unit from Imagis Technology using two
motors for haptic feedback in mobile phones. Used in many mobile devices
c. 2012 including Samsung Galxy S Advance GT-I9070 (Janice), Samsung Beam
GT-I8350 (Gavini), LG Optimus 4X P880 and LG Optimus Vu P895.

The exact datasheet for the ISA1200 is not available; all data was modeled
based on available downstream kernel sources for various devices and
fragments of information scattered across the internet.

---
Changes in v3:
- added clock state tracking
- dropped level check in vibrator close
- added clkdiv clamping
- added comments regarding registers 5 and 6

Changes in v2:
- imagis,clk-div switched to accept actual divider value
- dropped DT header
- adjusted imagis,period-ns range
- initiated hctrl0 and hctrl1 values in isa1200_start
- fixed situation when PWM might return -EPROBE_DEFER to be
  treated properly
- added chech a clock or PWM is available
- fixed regulator voltages check being off by 10
- added chech if state.period is not zero
- added action call to disable clock and gpios on error
- used managed version of work init
- added work cancel on suspend
- PW calls are done under mutex lock
---

Linus Walleij (1):
  Input: isa1200 - new driver for Imagis ISA1200

Svyatoslav Ryhel (1):
  dt-bindings: input: Document Imagis ISA1200 haptic motor driver

 .../bindings/input/imagis,isa1200.yaml        | 140 +++++
 drivers/input/misc/Kconfig                    |  11 +
 drivers/input/misc/Makefile                   |   1 +
 drivers/input/misc/isa1200.c                  | 535 ++++++++++++++++++
 4 files changed, 687 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/imagis,isa1200.yaml
 create mode 100644 drivers/input/misc/isa1200.c

-- 
2.51.0

