Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB2A470137
	for <linux-input@vger.kernel.org>; Mon, 14 Sep 2026 14:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789396680; cv=none; b=GVPBhTHs/2DwK76gtDOJlJYh6IZWHdWO4+jjcmD4a0Pyj8svPvfmLGYra4KFmcTrpyMjW9o5JAC6sj/Nw2GcbBu529to/FcM2nX2YOA8R37rsBLnD4q5up+O+AiEdH5UX2UzhXbUGKfyFmzzdzf6Yc6yLtCUB7Ugex6cTLKKT1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789396680; c=relaxed/simple;
	bh=iT/FZEMnleE687KdY6E27lK5mHHkASo1EJs5U6DSIK4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TiwnJ7w3TZ5hT3xqi5UXr9dhKVlPzVCITJoh6Jo+ilFprwnvjLX7C4hMYQBqlAICTPrslJ3UsVa6pzZ8GhTZgHYQIprqHt1h9tFnXTB+IT60LRHnuZHD9YmTDqUW9bD9COx81bywzIsSatQnHxhTw+mGLkfb7aKH2M2aExb9vqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=j5GHoz6D; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="j5GHoz6D"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c25420fe973so568939566b.0
        for <linux-input@vger.kernel.org>; Mon, 14 Sep 2026 07:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1789396676; x=1790001476; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0o5vfrfW6OtANZ4B56aGkknEqwrzuBWv+LAox018S60=;
        b=j5GHoz6DLJJ2/0ozKpIpU/PCLfRz72rzK5kdnzD1nXm0Ls7wH5Ii0xq4fhc+TcOdsb
         Sm04RHvNNoGA46p3CNYLvOqPO2k5ZCk/PGVqPMvl2rYYAU4DVs3Mx8z2PdOGE4YfBCMt
         CkAaBoahk6Dkx6VwyaZbje7Fp279I8kMFMjoGvSRcVkOEjgtageDRhy/tj1OzZ2iCLCs
         Vk2IlmsPYDTkTBxvh0h/8TkB5pvz8Evs+Dw5dA8waLSehkEspV3CK2owu3mbc/A7iUec
         V6B7N1X7m++pwTaRIBQKqXYjdEVFeCEI/02CGf2N81U93uzdhB3YVCjO+tfUXSPAuiWL
         q2iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789396676; x=1790001476;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0o5vfrfW6OtANZ4B56aGkknEqwrzuBWv+LAox018S60=;
        b=KPtTFs0ShXRdMX1jd0LVZ0tcV5JQrvmj1C2llNyyz2h6tEapSxsT6o79AZ9zIIueRC
         BCIfqQ1OZublvgLKEPAsYK9dtw/StL0yHk3XiFikEcw6KmX3jKjv6WMFBDs0k37+6jqu
         4bI7DDO6Zn+Yb0hzwyrg2l6SNET8Ke45ih0XTXsEJZ0HWSNwf4IHALk9tSe5ft5vNxnS
         QJsdgCnDTMkdQjP0XcY72c+EqqldewF1tO2IdHqLo5NimUvseRhMYKptqfXmXdmx25Rl
         Gi6gPX2iZuFUWm/tUp7SP4YVNWq5+6iJLnToWDmGAx5WA35YjhFBYbatJNBiqVk38dtK
         ZcxQ==
X-Gm-Message-State: AFuF++lPl7HOZYdRLun6ajHSqndNtG5h9KPWeeY+TnPC9q0swcQYQqZU
	fJXrwJkkNvct1wBv7Mgpl+7HthBm9KnztUoYfQXbkzUWYsTE9H73ghJ/Cst6Z+n9D5k=
X-Gm-Gg: AYBFou2OLTGlulk/QzydA93D+y+7NUVFk6eBiTjRByFxBgmSkSKfYwBFvajddwx740H
	DAxWJsNvq9wnPvY0zbhAKeSpMa+7Xhqv6m8z2s6sN5ZL0rV7YsiPAW6slGR9VqX4OPJLMVfXU2P
	YHe1OwbZv1tesT/Qx3uIyzjQ0pUnmPhQ3eqtVFFOHEnAuKLb10iF3v/N03ncoDEJRGjYy1u1+wb
	Q+JoRrX35x/jhxWCbqvobaanyWMgrR1EpnEnw3TeVWg5F8TmYNhxzy1byw+hL9KTypJO1cGR6XE
	MfLtsqmKzsx/uGuoyMIgY1Z4BQAnAEMq/AmtiGB//juLeABs5ojHOFNIFH8xpLNX9pV/D4bqURd
	1qPlPx7Z9RUagRVxuW1LPoKhqcjUVknoFpf3Nq+0DMP9QnLuSbmaAraW8BEqAgOOs+1HDa0u84K
	pIalEpaZBc6ISW54A6NedgHzKHWflhhiNYIFkvc0/opL1LLF7Pe9z2S55Jh96obNqcmdhBrzIVt
	sAU/ltRLUV0jT+wCd4UC6p+oz1aI3isaLe4OM1SKxwm53rDifPMvppBZ1CnbgpT81hz
X-Received: by 2002:a17:907:72c6:b0:c26:19de:912d with SMTP id a640c23a62f3a-c29b86f1ac8mr215323966b.32.1789396676416;
        Mon, 14 Sep 2026 07:37:56 -0700 (PDT)
Received: from [172.16.220.224] (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c29660b29a7sm449634266b.43.2026.09.14.07.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 07:37:56 -0700 (PDT)
From: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
Subject: [PATCH 0/3] AW8695 haptic driver.
Date: Mon, 14 Sep 2026 16:37:46 +0200
Message-Id: <20260914-aw8695_haptic_fp4_driver-v1-0-156f7549149a@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALoGqGoC/yXNwQ6CMBAE0F8he7aGtthSfsUQUssiewDqFtGE8
 O82cnyTzMwOCZkwQVPswLhRomXOkJcCwujnJwrqs0GVypRWGuE/tXG3bvRxpdANsep6pg1ZaGc
 rLdFZo2vI9cg40Pc/fW9PM77e+WE9Q3j4hCIs00RrU2z2qgUHBe1x/AB2u9a2lgAAAA==
X-Change-ID: 20260716-aw8695_haptic_fp4_driver-397431e97638
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Luca Weiss <luca.weiss@fairphone.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789396675; l=1104;
 i=griffin.kroah@fairphone.com; s=20250804; h=from:subject:message-id;
 bh=iT/FZEMnleE687KdY6E27lK5mHHkASo1EJs5U6DSIK4=;
 b=eVlU1pjmzGtg79PQ+00EkT/kSE6G8qdAiCpTtZHnhwFBmeUJP8N8oQKkA6tnrhHyrHBJ1VI6M
 Y6gUnIrzPkdBXpzT67RX+NAjLPRBoddY8a7/MD1NFNT3lbAZX58vf1J
X-Developer-Key: i=griffin.kroah@fairphone.com; a=ed25519;
 pk=drSBvqKFiR+xucmLWONHSq/wGrW+YvcVtBXFYnYzn8U=

Clean-up of the aw8695 haptic driver patchset that was sent in 2022.
Variables dependant on devicetree have been hardcoded, and unnecessary
functions have been removed.

Signed-off-by: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Griffin Kroah-Hartman (1):
      dt-bindings: input: Add compatibility for Awinic AW8695

Luca Weiss (2):
      Input - aw8695: Add driver for AW8695 haptics
      arm64: dts: qcom: sm7225-fairphone-fp4: Add AW8695 haptics

 .../devicetree/bindings/input/awinic,aw86927.yaml  |   1 +
 arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts  |  26 +-
 drivers/input/misc/Kconfig                         |  11 +
 drivers/input/misc/Makefile                        |   1 +
 drivers/input/misc/aw8695.c                        | 753 +++++++++++++++++++++
 5 files changed, 791 insertions(+), 1 deletion(-)
---
base-commit: 5e036ce12de91c6fd674dad33b169c6150be2a7a
change-id: 20260716-aw8695_haptic_fp4_driver-397431e97638

Best regards,
-- 
Griffin Kroah-Hartman <griffin.kroah@fairphone.com>

