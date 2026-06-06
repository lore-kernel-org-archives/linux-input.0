Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A7326B2D2
	for <linux-input@vger.kernel.org>; Sat,  6 Jun 2026 15:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780758323; cv=none; b=pHwz0GR9sgVSib63LMwXXrl/wSJX8MQWT64qirxqMj92tpF8hque4DnwwoWh6gn3GD9Kl3FUKWhBGx0iTCGhPdpKa+ci7GXbAFETBhEYxatkK9GF6GNOXgwfZZbH8w91W04fWTcb2IAp7Ha1qEl/2okkmFQhwEXAiZkB6SV6Jqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780758323; c=relaxed/simple;
	bh=NjLkm9mYmm8B70ayavRAnDtp5W0P2+QJpDX+0PkbbiI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kuK9FakTI1h1J9pdSXPllG4bJQhxDkbVRysSCK0s0iHRB/KIB3iE4jtZxQluvahKSdNDeczAXePz9HjYz3fR1phmK+nlGIsfkO+IvJymxJyxhaKdo0l1VrXEQcFvQD9rAeD+492BFTr+kYqlMn4H7mYrxpecFjF8kq8kp/mh0PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jOTGIjSe; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jOTGIjSe"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-137dd4cc208so1730649c88.1
        for <linux-input@vger.kernel.org>; Sat, 06 Jun 2026 08:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780758321; x=1781363121; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G2TbMHCwcm5U+hLOH+EuDpxcZ8w5TOO6sVqeTTwO0uA=;
        b=jOTGIjSeNCQqklAC/mPGlztmFdHj+ySz602FDdvcNySfnTY38JG3fwXjbYBk0vBx/n
         MD1CdAosigiNbVE/XmansyfpAowUpBFDNCyKt3tVFajA/GDBsQGoxKRSpHruAlkAUwra
         vMaKOlKg2fKlTHw2hjIf2YUKnc/h684kY5smrLSXkJE0FcJ/KyZV3+OC+MpP5bnRL6tJ
         euO2mKpSyM6UalEXqIvmeM9Dn8qh/JzBYTszF1Wb9jfU8wu+uFLZbTITPJG9qDMlgqtl
         7nKpP602zW8szKG1xEj7IYV6FcWuvuzDZP6QEuI5PqpTuncwT61PragDD9WnZCP8pNIp
         486Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780758321; x=1781363121;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G2TbMHCwcm5U+hLOH+EuDpxcZ8w5TOO6sVqeTTwO0uA=;
        b=YCHQxdFN+eMjJJDUeVUKG8872ia0B0e29vhNK9DP8DR9GOFF17XOCFtMSoB2Z8JEHP
         eK3u1LiDX0eN7EzyPH8hVTbBIS6nbTpj9qN2QAR+C+Fg0Z0m/ifGEMk9LTEFbNcFtzAS
         6rkLBX+dUN4Wze13oKvMg6ralwmGpa9X/Qh4fco++Q6vlc6M4J+ngJRIdKykHMJPYVDq
         ENweTpCu5RK3yBc+loDQb9/iVwUyzixvUTUrMpphyalulBWfaK9sr4+/pL+2XW8C1xLE
         uyTr3lIuFKTtA4iUHz/WLen4WgaxSzbGP7bQ//sb6MVLeXD08/+/nkL/0MiynBw/fBut
         I4mA==
X-Forwarded-Encrypted: i=1; AFNElJ+gSLLvIM17xsdiPy8j+Tr1y5kVojm7picwX8IbifzDtEzy9ctSvSkfs765w3oNsBnGfVtIYgr+Cgpw3A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxIXDe7Byms7r0FfFmFBchPCi2bH5jc5YN7UMlAH+6Gpw9/BQYf
	okJk/fBrLMjC9BNTjRRGZ5RAK3Sl6RL/DIxHmYF1z6pxvxirlK2P4Xfg
X-Gm-Gg: Acq92OG+0Dqg9mKZ3IkEnwSG2Aj75VxxVxOVxqdrbST211ekVMKRYt5N4a97n1/wvFP
	uNnpdAaLjYcT6e3cQyurbNfUyDKr0wS3jGtzyqT7z46AI3dJzP5m1w0OftDhx3ldP8mx3WazC3R
	daiqzdXS2QNDs+HymPdRW2AUv/HLCvEUtW5L9qs0MHjwEwgCQrlkfZOgsja1Ww0OLrnhvjCfFfE
	Aq+E0RA4DW0LO3RhDiMqwcLN1EmTLj/PZ4M9LEM/mypx0++BBYxDucvrmoR47c/dLH6av+szAh5
	CFIHlTTVCJfWiJOz67xsNZowwMMFlTRpQaB+8+i5xlBC4KA1yHPjSc+qltKx/Rmk/CUAf14XKZg
	jGMaW304wDtauNXlZowwaiDDoHtwm567TIj0ZnPB/Ya8Eo0wtYjP5p8hB6ob257HkCzmmo/Guii
	6jHP4hyfYxh5tzC86tv52y1pJp2y5pbhEw5ZL30iv/pZDyk75y6Q==
X-Received: by 2002:a05:7022:ea32:b0:12a:6abf:ab1c with SMTP id a92af1059eb24-13807d60704mr4187917c88.11.1780758320900;
        Sat, 06 Jun 2026 08:05:20 -0700 (PDT)
Received: from arch.localdomain ([2409:8a28:a54:e741:3a5a:3245:d3dc:4b5d])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137f5539035sm8415607c88.11.2026.06.06.08.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 08:05:20 -0700 (PDT)
From: Jun Yan <jerrysteve1101@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Jun Yan <jerrysteve1101@gmail.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/8] Input: cap11xx - Add support for CAP1114
Date: Sat,  6 Jun 2026 23:03:53 +0800
Message-ID: <20260606150458.250606-1-jerrysteve1101@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CAP1114 is a 14-channel capacitive touch sensor with 11 LED outputs
and hardware reset support.

PATCH 1~3 mainly focus on cleaning up the driver and dt-bindings.
PATCH 4~5 add reset-gpios support for CAP11xx.
PATCH 6~8 add support for CAP1114.

Jun Yan (8):
  Input: cap11xx - clean up duplicate log and add probe error logs
  Input: cap11xx - remove unused register macros
  dt-bindings: input: microchip,cap11xx: Cleanup and refine LED
    constraints
  dt-bindings: input: microchip,cap11xx: Add reset-gpios property
  Input: cap11xx - add reset gpio support
  Input: cap11xx - refactor code for better CAP1114 support.
  dt-bindings: input: microchip,cap11xx: Add CAP1114 support
  Input: cap11xx - add support for CAP1114

 .../bindings/input/microchip,cap11xx.yaml     |  93 ++++++--
 drivers/input/keyboard/cap11xx.c              | 223 +++++++++++-------
 2 files changed, 215 insertions(+), 101 deletions(-)

-- 
2.54.0

