Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795096491;
	b=VfAHQkCqkQZWaFb0PrjpIZd8pdcab74vjMQ1x/PVPtwm3ZlJWm/WCLMf7fKA7u7lRbAP
	 ZDo5D8LPCH8eH0VgEWtdCgSqxR6uMffvKUjbLaIuDPm8Fgn94IqDjBit7Ph1wp5iFLc2q
	 OdU5vY+CUfsSlAYiMOF77b84U3IMseXZmNo8mCjd4Yj/wALRFEbNbo4GOg9h1tXRyA98l
	 xZW46EVbaPEHQsueaeLkySMQeNZlUyjqKMa69GntJpzcejxtJJwm5NTDVvC4HkJ9nEREw
	 u7K2unA0kfwkHUvsDJdm7xhINWcV7sgx86k2f4wUqfYOuMKKUrDX+Ymh1h/YSg3y5hA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795096491;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=7efxhBC8v8hoV9AoQNptenBefumTTDz5WaeZtXNjs6s=;
	b=uKy7aCGXu+g3AI0Y/6Lg3alilvtV9kZPzcspOVqAO8zeCfQGeufkvsjyVd6TTJo3WqOh
	 gyo1o60jx51Wbl94ww7NKNUhNAgq3SNdveMHFAYr+SPp3o42Q9TTAW/965QVPfhciApB3
	 PuRrRp1zxMfcxpqfFwNfuOi3BiZEjTE+L6DMFD3I22WlX75WCgx/pqzJTwMwpWzcWxWwS
	 rTrDMUixD/V5gr7I4/NXdmySa5VfexNBUjdRRBG3hHaI29l5uhLgje9ow78uS7U/XR5xC
	 /AYznXmMVCjsCapeu7yC8jOHQdJOzDMnHNddpqRLoO4CAPIbir3RSl6vleKNR9NE19Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fairphone.com;
	spf=pass smtp.mailfrom=fairphone.com;
	dkim=pass header.d=fairphone.com header.i=@fairphone.com header.a=rsa-sha256 header.s=fair header.b=qQWVfoIV;
	arc=none smtp.remote-ip=209.85.218.49
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5735F606A326
	for <linux-input@vger.kernel.org>; Thu, 19 Nov 2026 13:54:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5735F606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fairphone.com header.i=@fairphone.com header.a=rsa-sha256 header.s=fair header.b=qQWVfoIV
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c4395d31228so353251066b.1
        for <linux-input@vger.kernel.org>; Thu, 19 Nov 2026 05:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1795096489; x=1795701289; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7efxhBC8v8hoV9AoQNptenBefumTTDz5WaeZtXNjs6s=;
        b=qQWVfoIVk37Xzh9p3yus/Gl9HA+4rnKDHNbs5NmdDvoW5q5TRL6iYrwZSN8lkdfRUA
         KEiFghvs6w2vkqkvS0ikZRp5cZdIC95ERoIZ6Jw9FZ1yuFuS/Q/hq6Z1V80vJeb0CrWe
         2nDtl4oQD18SuUUnkKmKoAI5fYzkJMhPFqDkqnyAbW4eSahciF82j72uPsZevruUy9Fj
         o/yXu/AG4HALi/RUN5leUEClLfFdx+qs6cgCSXOWwhdbFCcSoNbhm7WhSZM3MhEj23j/
         l+nNXzVxUGALciQHLiBXmM4uZngPyPCUMix8swyjMpujNSvXTX8M1WtAlf8IgPafI72u
         JNUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795096489; x=1795701289;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7efxhBC8v8hoV9AoQNptenBefumTTDz5WaeZtXNjs6s=;
        b=TmvZ1TiuCxpLcKy6tERWbkQdhTYS37SdOAOB5Eew7fREWs0R3CHMlae76Bo2cenXmS
         Q9E96SfxU6iX6eDIrBLhn1ViINWI0pwL8Tx85/70pVkcym6JfGT5QZK9wwpFJ0D39M6d
         3gWAwdaM2nVl+qc04AOpGDjNnnPRMabt94RHqiRluAQxSzTp3clp+kX85CjuDHzGR4bE
         Ml6yLekHLhNcAVbAzEI/6OvH472NPZ+wOTA172odHy9RCgMUr80AdtcuRg0OesOve7lX
         0keVTeif6e8a7jadFryYklzyy3SDJOXtKogI0QJCpx2m1j7803CQ3srpr6Qry0cfXJhi
         hgvQ==
X-Gm-Message-State: APuU4Z/U2+38ntM+1CQ/pIjoU0iLS01aAeRxsjmvu5KyQ72vj/mIFLzn
	tKUMG/cgaf9OrjNrcLJm1/tlLszwabXQEak192APULKBAtXvp4EmK6uqPIkTIj11/oS95GwfHwJ
	Q2djWm/g=
X-Gm-Gg: AYBFou3ByzRvxqKHTBghNrXm70N0kesg9UG1P1Kb+3MG7OJFVmJy5oWhSXeGOGtrbP4
	EGgjZz3MyoEAFsVkLUqpjh9+jzlnnpQ3qMVwzcipLvJ+lV/MUCWpMhb28ellH2pPY2QGh48onxW
	GO9lFY4VCHNzaO7iwmXjWEyKC2Gd4xsbxAtBzqf875iEDqPNx/pyu7/cL40N2/Q5cMkODNK4MhC
	jjclj29bia5apVz/p7FE4FOq/iS6ZUlW6uXCnMv2/AZpNc2sYNPvquo9qBatZIk285n2v7ljIfD
	u3xoh9fbieRqWUEKZWR8bDcZ0FzjrIQG2KYV7G5cs7GoClmUM6eyYhJfQMoofODYKsWiIkGsStL
	R3LUGD+ST0VMVPcJM/2FLawKPYorWxDKTkNd0DVYPCp/zcslS9YMBttDcX2/8JXQDX3/bPLovMU
	rRHtzQVB1PN5c6k/6+Zicp0zwIqiBQFTF5aR9pov+xyNAwxOGWxxsSe4PRGgePMVdiFZzrQwnN1
	GYTCqj41gehjAsrcGN5F41JyUqZuLmc+ocVPixIhUYm4tSHlx+qrdfu2U/udGYHNGwbs7pNzd43
	jF6IwHElkrETwPe251SSb51AC+alGpjvQFQSmPWF91Seq57VRXE8exHbA1OpcEPzSp0+khT8Lv2
	DRup0T/ekuwE=
X-Received: by 2002:a17:907:d89:b0:c4d:f63:642 with SMTP id a640c23a62f3a-c510e50d843mr581627866b.33.1795096488539;
        Thu, 19 Nov 2026 05:54:48 -0800 (PST)
Received: from [172.16.220.224] (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c51233c4d02sm106820266b.21.2026.11.19.05.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 05:54:48 -0800 (PST)
From: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
Subject: [PATCH v4 0/4] AW8695 haptic driver.
Date: Thu, 19 Nov 2026 14:54:44 +0100
Message-Id: <20261119-aw8695_haptic_fp4_driver-v4-0-9d107334bdb2@fairphone.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKT//moC/33Oy07DMBAF0F+JvMaVX/GjK/4DVZHjTMgsmgQ7u
 KAq/47rSggh6PJa12fulSSICIkcmyuJkDHhMpegnhoSJj+/AsWhZCKY0MxwTf3Fatd2k183DN2
 4qm6ImCFS6YySHJzR0pLyfY0w4kelX073HOHtvVzY7o+k9wloWM5n3I5NNgdFY5Dk1p0wbUv8r
 Ksyr+U6wHH1/4DMKaO81aNpVSk6/zx6jOu0zHAoVyqcxTfGGeMPMHHD+kHanjslB/gLkz8wIR5
 gsmA+2MCVNAas+I3t+/4FFQ+trooBAAA=
X-Change-ID: 20260716-aw8695_haptic_fp4_driver-397431e97638
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Luca Weiss <luca.weiss@fairphone.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Griffin Kroah-Hartman <griffin.kroah@fairphone.com>, 
 Abel Vesa <abel.vesa@oss.qualcomm.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795096488; l=2105;
 i=griffin.kroah@fairphone.com; s=20250804; h=from:subject:message-id;
 bh=vSG/kPXqNPwYJI59MvB89WNJPXibeQ6CHHNfIpWOoy8=;
 b=YexMVoUCILJpwVuo4OyGHfeT7YUsefgg8CHDaChHZUSALkKgd2mkpyGTeW9n0EQQ0kGUfEEXT
 96zq5dcqYQpCG2mycu48XVC6774E8YUxyVAlgfLqoQSAoxLLgJrE9+D
X-Developer-Key: i=griffin.kroah@fairphone.com; a=ed25519;
 pk=drSBvqKFiR+xucmLWONHSq/wGrW+YvcVtBXFYnYzn8U=

Clean-up of the aw8695 haptic driver patchset that was sent in 2022.
Variables dependant on devicetree have been hardcoded, and unnecessary
functions have been removed.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
Signed-off-by: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
---
Changes in v4:
- Level now changes gain of waveform played with the same calculation as
  the AW86927.
- Level is set to 0 in suspend to avoid a playback bug.
- Link to v3: https://lore.kernel.org/r/20261022-aw8695_haptic_fp4_driver-v3-0-ac8c14377e82@fairphone.com

Changes in v3:
- Removed potential race condition in power management.
- Fixed dt-bindings.
- Added MAINTAINERS entry for the aw869* family of haptic drivers.
- Link to v2: https://lore.kernel.org/r/20261001-aw8695_haptic_fp4_driver-v2-0-1bd38b1943de@fairphone.com

Changes in v2:
- Added power management.
- Reformatted DTB schema.
- Removed unnecessary IRQ dev_dbg messages.
- Changed reset pin bias to pull-up.
- Changed error handling to reflect subsystem style guidelines.
- Link to v1: https://lore.kernel.org/r/20260914-aw8695_haptic_fp4_driver-v1-0-156f7549149a@fairphone.com

---
Griffin Kroah-Hartman (2):
      dt-bindings: input: Add compatibility for Awinic AW8695
      MAINTAINERS: add entry for AWINIC haptic driver family

Luca Weiss (2):
      Input - aw8695: Add driver for AW8695 haptics
      arm64: dts: qcom: sm7225-fairphone-fp4: Add AW8695 haptics

 .../devicetree/bindings/input/awinic,aw86927.yaml  |   4 +-
 MAINTAINERS                                        |   6 +
 arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts  |  26 +-
 drivers/input/misc/Kconfig                         |  11 +
 drivers/input/misc/Makefile                        |   1 +
 drivers/input/misc/aw8695.c                        | 813 +++++++++++++++++++++
 6 files changed, 859 insertions(+), 2 deletions(-)
---
base-commit: 19d1b4de6d37bccecc3ad9144d279f1baa405eb1
change-id: 20260716-aw8695_haptic_fp4_driver-397431e97638

Best regards,
-- 
Griffin Kroah-Hartman <griffin.kroah@fairphone.com>

