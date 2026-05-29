Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E282853E9
	for <linux-input@vger.kernel.org>; Fri, 29 May 2026 01:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780017414; cv=none; b=iC0hPzBJajkIGbToVieBbae7JdDfuAj/LYDwzFytJe5tJr7dI6BmTog+qBTq1aQs8pp3Q7weI8pVxaTMahpPpSBKVmNl4LPcrd91HFQAp8ee+001xctOiGljNWcZIKkzocJMjSsylPwz6pJxLNJ6XnxKE6YvlXxCuCq271kTI/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780017414; c=relaxed/simple;
	bh=sKg6xoqq2s+ZZcuSNKhLo4WCT4rISU2pWEoW2HBRb+o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OH8OGFRf5LsLKFvZDV9U6NKzOqvoN5fkniTEpxs7OFXdrS0G+aveSH4vrthaAH78Mdvu6dPELEbuekv5llXSCafkDs2hCqh200USnUIGgMbCJhAemIip6XONSl+WnSR9jO2NpnvZuOv9+BKskvItXpEhE0w5xYCKP4sOUkZroiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o3feYz0w; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o3feYz0w"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-36babe2c4bdso379919a91.1
        for <linux-input@vger.kernel.org>; Thu, 28 May 2026 18:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780017412; x=1780622212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GDATUkG/OtxlAUVWKXX5mKstzpi/LS1mSaHeR98JWp0=;
        b=o3feYz0wg0BP86kBDfLGCOfCBFcdqHotfqStAeNzeC72X7lwjKgka7e58vHi727QyS
         74bipmcYMxQP39guIeScFgk7aXnz7ThSmZ1Oh7j5gdMapyrPJqbl89lo86+r4GXPqykl
         uMcFBg9NAqnj5DguqbjWuB5yIegaCUquCluh1mCZSt0zLz16NP/SPHDXM0MiZi/tsmKy
         fQXbBaMQjm7r/pLDsTI9qB4j/MIbgmUzmK8mhp8GUimYswcxktMl/IgExHkZI7T7GOUJ
         UqwSOxYYxN0eQAzKeBKf9mfKfcWBgppCibrCVpd6bLS9loQYbzg4aCwXlKTvukff1DRQ
         /oBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780017412; x=1780622212;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GDATUkG/OtxlAUVWKXX5mKstzpi/LS1mSaHeR98JWp0=;
        b=ZpaVQnR8TvJbn7WIPdoeWsuRCw6mjuSeV+KnYqr/s0n7HOQ+mU6Bp1Wm3IRdaeIniv
         BWTauxe0PJcMxRPKbJElmRdVuEkFdsBbaRCmzAXh+jJ5yjI6OoJKZwTAhCqdV8huU2xD
         qjHKLBJVCALxv7+HtY5Dx7H5iHLY0w3KuTWfJhiIwRFWgv7iAQEuoV0CGeMmIIXcWWPo
         WovEvor7DanGUjdLIG06D455TG1Ub3U/pIBLPJIt7AiiOXP5RnNJkitUmefisXSyRlXi
         ARbktn/P5EHJ+yA3yprQhMW0U+i2fThPBi54X57+0xzLZXv9LvQiMEMvhMsr7TnFofVh
         HrRg==
X-Forwarded-Encrypted: i=1; AFNElJ/cAg/2rXudD1JsInWEfjuxBC7fv3LIN031DTlM5j/vHDSqhZCEnlZTbCckyQ7cqoWc3ngjCqJRXNpuVA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7PxQLApfS5EdVAvvHdAR+cKANoP+H9WjmaDwqTJWaFty58k+q
	KM1XldQ/eXwFSGgbu7/ls8ZlE940lcBN6aTdwoLrv9UnMRlvxEsRTdSp
X-Gm-Gg: Acq92OHVuVo8N+e/Nl9D12x61reHzyJRTnsVjds5oDVFVYGrKA05vIxOVLW2gta1gD2
	QzPk+mZY1ETKlgCoWM3dzdSh/3spq8ar29vPtAS1wzOnUPGJISrGHpTdX7jXMYNrtT1LK5UpchR
	LZesc22Nbp2z9YVkudRfCPH7KfGEcHJEkSqL1MROjoj/K8Huhl/0K7lMMU+61tWhioBcrnKUwFP
	TBL4VY31sDI0UHwl1ndgWbmCfCWro157h3u0n8/9nVpsL/uHcE3w1ONbwi0CbirRhGeLSPtPk9y
	dQGY0rvrka2acIllzo3DB3ZWiG/J4/SqGd9XSrIpVkCLCrGBzw77mN9/70yLJcvQ5LA5/oXo67Z
	rfKgiaW39bkF8sDEIAodYRasOL3zW/6pnUSuQsIaaYbvJvrmJTp7J3EVrnIy71cpJg3eMJftZ0P
	4Olirg7ckL68F8Qs6/CIiYyXqSiNNuIYbxGZrJ5dwPOgyEnI+hs3wIuzCmYWzj62eirBQFM3KZ5
	HuP8gN1OZOBMqD5HOXxR2lF
X-Received: by 2002:a17:903:196b:b0:2bc:7d09:dcef with SMTP id d9443c01a7336-2bf209a2d71mr9668965ad.29.1780017411611;
        Thu, 28 May 2026 18:16:51 -0700 (PDT)
Received: from harrison-Surface-Pro-12in-1st-Ed-with-Snapdragon.lan ([58.164.4.185])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf239e702fsm389235ad.4.2026.05.28.18.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 18:16:51 -0700 (PDT)
From: Harrison Vanderbyl <harrison.vanderbyl@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: jikos@kernel.org,
	bentiss@kernel.org,
	andersson@kernel.org,
	konradybcio@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dmitry.baryshkov@oss.qualcomm.com,
	Harrison Vanderbyl <harrison.vanderbyl@gmail.com>
Subject: [PATCH v3 0/2] Add support for Microsoft Surface Pro 12in
Date: Fri, 29 May 2026 11:16:14 +1000
Message-ID: <20260529011619.9586-1-harrison.vanderbyl@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Changes in v3:

Rebase:
 - Rebased on next-20260528
 - Removed ice device tree changes

Device tree:
 - Fixed C++ style comment in &i2c9 to use /* */ style
 - Flattened mdss_dp3 port into &mdss_dp3_out directly
 - Whitespace and formatting nits

Changes in v2:
Ice device tree: 
 - Updated to use 0x0 formatting

Panel: 
 - Add edid to commit message

Device tree:
 - Fixed formatting and ordering nits
 - Removed extra dmic audio declarations
 - Added suspected devices on i2c busses
 - Fixed incorrect usb regulator
 - Describe panel pin regulator
 - Added defaults for volume button GPIOs

Already applied:
 - dt-bindings: arm: qcom: Add Microsoft Surface Pro 12in
   (landed in linux-next)
 - firmware: qcom: scm: Allow QSEECOM on Surface Pro 12in
   (applied by Bjorn Andersson, commit 667d05a09db3)
 - platform/surface: SAM: Add support for Surface Pro 12in
   (applied to review-ilpo-next by Ilpo Järvinen)
 - drm/panel-edp: Add panel for Surface Pro 12in
   (pushed to drm-misc-next by Doug Anderson, commit 02f48ffdf96c)

Pending in this series:
 - hid: Pen battery quirk for Surface Pro 12in
   (acked by Jiri Kosina in v1, needs a tree)
 - arm64: dts: qcom: Add Microsoft Surface Pro 12in
   (reviewed by Dmitry Baryshkov in v2, minor style fixes applied)

Will be done in future patches:
 - Camera support (pending purwa cams patchset)
 - IRIS jpeg decoder support (pending purwa iris patchset)
 - Accelerometer support via ADSP (probably userspace)
  

(Audioreach/ucm2 changes for audio)
https://github.com/linux-msm/audioreach-topology/pull/32
https://github.com/alsa-project/alsa-ucm-conf/blob/9577cd31121546b288759097901025376141177b/ucm2/Qualcomm/x1e80100/Surface12in-HiFi.conf


Link to v1:
https://lore.kernel.org/all/cover.1778498477.git.harrison.vanderbyl@gmail.com/
Link to v2:
https://lore.kernel.org/all/cover.1778822464.git.harrison.vanderbyl@gmail.com/


Harrison Vanderbyl (2):
  hid: Pen battery quirk for Surface Pro 12in
  arm64: dts: qcom: Add Microsoft Surface Pro 12in

 arch/arm64/boot/dts/qcom/Makefile             |    2 +
 .../dts/qcom/x1p42100-microsoft-sp12in.dts    | 1194 +++++++++++++++++
 drivers/hid/hid-ids.h                         |    1 +
 drivers/hid/hid-input.c                       |    2 +
 4 files changed, 1199 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/x1p42100-microsoft-sp12in.dts


base-commit: f7af91adc230aa99e23330ecf85bc9badd9780ad
-- 
2.53.0

