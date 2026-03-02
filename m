Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A43356A12
	for <linux-input@vger.kernel.org>; Mon,  2 Mar 2026 10:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772448630; cv=none; b=I81DmAMCKdr6UQKEUfYECrRXx/oQBOMVQ35Hn1k7w82l3K3OQAM2tDsjBp8QPifB+vfcj9N3lntd86BSPBEEmddA5euR/dc5qtcTpSEm9mUBwIZMPUsyZXVIizhj8lNgisrvdFJHFVjfN1l/NFxMjjO9LfMqkW9erh2y5TSSwLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772448630; c=relaxed/simple;
	bh=GlADQjf3oqael0HpubNah13JMqhh94V8vrJ6afwoqIA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WGnFaejf8QzaBn5a9QiwH9F36cXShoDdN1UpmqQ8wO3KKi5BS2l2dVr0jHIF9+33ApEll4i4k3CmYb7Jjr5vjXH4+M+Id+z5e8ZL3J2ICh25I3PoNxAuSvZ0DRlwPdE2JMpZ7WoNicJnDNlfDNnPMYCrpyHiM86iXwxxvl/lI68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=SLda1Ezg; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="SLda1Ezg"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-65f90233e28so7870801a12.1
        for <linux-input@vger.kernel.org>; Mon, 02 Mar 2026 02:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1772448627; x=1773053427; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gRu/CGwKuJ7if/qJsZ9ADoBMjsNYwgR0/rcDykqWA30=;
        b=SLda1Ezg9b4Qc+QydBc2/17Ie6PWqBMUkRctSNo1JLiEwdKSbor8qibuUY2PSKCcU2
         QfMDft4M2uPHYrNQm982pOd+SMjwL3IAKfS2aDwFYh5G89JNlXnR/fVUDrNAYJY2iMU9
         5F1/zjo/Ke9x7kebLkszXHPTdJkh16vRTbVAaIyLDinnM/PAN+tWvcbKLg6nULDtpLwe
         2QykqMnTHPOCHwKpn8ctu4F6s10wHgXVVpEI60851Y1fkIvtG4ik1sH2Jjoq8kwMRnmq
         /D0fV7cL2TRpkDEb5RUzonm3FX5+M9J6Pqshk+PCPry5nN6Hmajr1uNPtzcuDoNU7ZWO
         XrFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772448627; x=1773053427;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gRu/CGwKuJ7if/qJsZ9ADoBMjsNYwgR0/rcDykqWA30=;
        b=UHPtd1QYkV851Vcz+8GGbc34mAjcqjrAYlcmFveebBFFA6EtxUUnK96cYOLsK4KtGn
         jsTKQdwGFdMsksMpCpQrJQZZSL9VCUuyU4nVdu0ldiiNvXpQLux+tH6RGIJyZhRp+E0V
         Cr7UBebQroQVS4tabOsgJzuzNuluInFhhgybalfX3V63ZvJk7fDVOlFm418DMNy+zeL9
         sGbS1OGGLvhKAutBoX5y+/zyeKkN4G2l/ELjOFU3Fu5i9cd+Wg0ruYbenM0FgFB8/aqF
         U5zso5iLeY46/f/kKW8/L0B1vtHR+F+sfDp9lD1jnEwOG2MYif+y464kVNVHWHNx/5CL
         1vzA==
X-Gm-Message-State: AOJu0YxTd4E3FVs/JNUgFAqRLQ8iE+UIBvQZnhEqyy76PnoICxH/K+Sh
	zgyGVUKXtu4VvAFpNUMtW8K7ususLujd8Rs1qwsFS0WLZKjs6x2c+qA6MRoGxOPxLd4=
X-Gm-Gg: ATEYQzzrLzRfJRZkPFmBOBmxA2F3xwoDMevIfzweEmcxFu66CEa5L0YI0pVPQ9jTwbx
	LZEES0fnieDKqNqff9A2VjMOEl8ANK0YacG7YiyfNhAFs4FXBvlqxqi8lUMLSVlQy924VYCXmPO
	jJG9QzkRVm7I2HR7C9ujZmzFYdZl5UB+uXhzRtGqJogf+QqiN6QHmd58imOT5I+kO/JFNsiMEQV
	Tdt4Rt9Ui605wQ/BEnEjGXl8HAur5h+DbKeeOTpHOAVC9RLMPLa224UEvzwU+mfDEcxInacbXEO
	7jKwknyvyKnGSGkkNGrlgzVI1fhG6B4pk6nzQwQ3yMZL/HRkEju+e660nsq4gLHaBJ03W2uvy94
	NjE98Zk7+90eJUar0zDnUd6RsrPTSPbsiSgYcrDnNroFK3+aakbgDeyb3v3AaPGhD7s3YjuPbN3
	NDTPPGxFESsjMOL5LgRRGNP8X5mGgG/t/6SILaz0x11mHdpYu8439WocUWuu2gVerKe1z4jjKJy
	oWgvQNffoQp4e1qGnDc
X-Received: by 2002:a05:6402:1e8a:b0:65f:8b6e:e1e5 with SMTP id 4fb4d7f45d1cf-65fdd6e43cemr6617297a12.12.1772448627543;
        Mon, 02 Mar 2026 02:50:27 -0800 (PST)
Received: from [172.16.220.227] (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65fabbd98bcsm3511769a12.0.2026.03.02.02.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 02:50:27 -0800 (PST)
From: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
Subject: [PATCH v4 0/4] Add support for Awinic AW86938 haptic driver
Date: Mon, 02 Mar 2026 11:50:24 +0100
Message-Id: <20260302-aw86938-driver-v4-0-92c865df9cca@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHFrpWkC/23QzU7DMAwH8FepciYocfqR7sR7IA5u41Af1m5JC
 UPT3h1vBSFtHP+2/JPts8qUmLLaVWeVqHDmZZZQP1VqnHB+J81BsgIDjbXWafz0be+8DokLJT3
 UEU1wAB5BydAhUeTTDXx9kzxxXpf0dfOLvVY3Ckx9TxWrjaYhdNa3PkSHLxE5HaZlpudx2asrV
 +CXaI0F/0CAEENjiYxvEWPzH+H+CDD9A+GEaMauH2N0pu7hnrhsVyY6fsi31u1UNWAmLf09r7t
 qptOqf3bsZOLyDXRm90RnAQAA
X-Change-ID: 20251113-aw86938-driver-b4fa0d3228a2
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Luca Weiss <luca.weiss@fairphone.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Griffin Kroah-Hartman <griffin.kroah@fairphone.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772448626; l=1722;
 i=griffin.kroah@fairphone.com; s=20250804; h=from:subject:message-id;
 bh=GlADQjf3oqael0HpubNah13JMqhh94V8vrJ6afwoqIA=;
 b=laLZkVwpvQTA1mGqn26YNE2T+h207d5p74Gcyhy2AqV0SyN/yzBelFrEY73xyHFxnqbmH4GQz
 ZlG0gufUciPCQqQuEfWWC+TJrWwd2+6lqhRU19Nzf6XUjhoN1EllLxJ
X-Developer-Key: i=griffin.kroah@fairphone.com; a=ed25519;
 pk=drSBvqKFiR+xucmLWONHSq/wGrW+YvcVtBXFYnYzn8U=

Add devicetree bindings and driver support for the AW86938 haptic driver
chip, and add it to the devicetree for the Fairphone (Gen. 6) smartphone.

This haptics chip is quite similar to the AW86927, and shares many core
features but has some notable differences, including some extra
features.

Signed-off-by: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
---
Changes in v4:
- Changed how vibration intensity was calculated, added a seperate patch
  for it.
- Link to v3: https://lore.kernel.org/r/20260209-aw86938-driver-v3-0-5c79cff30492@fairphone.com

Changes in v3:
- Changed how compatibility was handled according to feedback
- Added reset gpio config for vibrator node
- Link to v2: https://lore.kernel.org/r/20260128-aw86938-driver-v2-0-b51ee086aaf5@fairphone.com

Changes in v2:
- Added AW86938 specific registers
- Added chip model enum to differentiate chips
- Link to v1: https://lore.kernel.org/r/20251204-aw86938-driver-v1-0-ebd71868df3a@fairphone.com

---
Griffin Kroah-Hartman (4):
      Input: aw86927 - respect vibration magnitude levels
      dt-bindings: input: awinic,aw86927: Add Awinic AW86938
      Input: aw86938 - add driver for Awinic AW86938
      arm64: dts: qcom: milos-fairphone-fp6: Add vibrator support

 .../devicetree/bindings/input/awinic,aw86927.yaml  |  7 ++-
 arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts   | 26 ++++++++-
 drivers/input/misc/aw86927.c                       | 66 +++++++++++++++++-----
 3 files changed, 82 insertions(+), 17 deletions(-)
---
base-commit: 0364de6be161e2360cbb1f26d5aff5b343ef7bb0
change-id: 20251113-aw86938-driver-b4fa0d3228a2

Best regards,
-- 
Griffin Kroah-Hartman <griffin.kroah@fairphone.com>

