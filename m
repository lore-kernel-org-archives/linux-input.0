Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE83831283E
	for <linux-input@vger.kernel.org>; Fri, 18 Sep 2026 07:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789716600; cv=none; b=Pr0xbZ8Qutn+lk0cd8nZaIRuUzxV5IwOES3xYE+2W8dZMGV/ywLmovRiQSNY8K/ylaNQt+wMyo0xJuAH7XBTzq7d87Sk1A/Oc3rRIzfi8SKFxntbgL6cmt/KOXJ9wqjixSWdFjHvhCpq2GWMWWQyFRZMkgpEZwUtQFUjH77q+uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789716600; c=relaxed/simple;
	bh=RuNvguTwwr2VuOUhAB3PD3uxO9vmyNSZMReZz28odaA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=J4CKjad43XyXtbC9jHmAulPeSGlzrAPjo9vcPYaSxBrHJfaqoA563agT8Ju0nvU5xIfQdYjqyB/AKYuaLVyMp0SAk/TKijNkNM0Z9OceQcaHTw7YJhe3wpQxt5E4czg8PeM+n10aySKXbTuCtIflpFUvb9nU/DNgbVq3eXAu430=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=3/FTNKmB; arc=none smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="3/FTNKmB"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a9984f9a59so536784a12.0
        for <linux-input@vger.kernel.org>; Fri, 18 Sep 2026 00:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1789716596; x=1790321396; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8n3CU8yWz1Zuk0+R71ZKSDVgYHmxdTzcwMr6TT8Hzck=;
        b=3/FTNKmBJY1YD6F8Of2+jKYodstX4L5z5+tnaYNuiLyLsNrjYFY/LwPSBeK9GNklPM
         U1UmhQX/Lz3ynTaDbbnM79x5zg+KxjC1YLDjJA+9/NV6d3czr8syXVuBs836haqqwRst
         +infEDXFlJ7Dt/Q1+Zhh/euvawTDHB8l4LCt3XEs1LDnlHCvCxcOIDBLNkiyXpT5+gtO
         oP7Tw0cs9yi5jMbM5PNf+frX1dd6WqSDVuo8XBoSkj7k4uBWWX9Hq3LVKBEEPd1F36Wb
         QGjCO2jqJiejtXaSrs5VCeLc+hSkpwDcPvrxt8/NKiOv6AvSIPduas3pUFGzZStyRXA+
         q8yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789716596; x=1790321396;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8n3CU8yWz1Zuk0+R71ZKSDVgYHmxdTzcwMr6TT8Hzck=;
        b=JdlphkgkJR2Dzkf5GRy4AJCVsJ62P0Zr16b6/W8y7oBpZ+XAJ2U2DTkqi2hZYQTUpN
         9b4Z+MEhU4MkCiIEnUviM6LzswGdzVSIMRNa1NdikiStnLmcMYtGSMjtF7Gtb4dF2EiU
         GFgK5DCH8qEqoQpct7S4Fqb2uxB9V9NtPA1wiG6iMVAfztcyIHjn733loE0GI3+16X8w
         qYJbTUKAYtVm0piDjsiAIzBsN22ABqEopMXvGc+UdakpGEPGh1wZo6SrK7op02YKxTLO
         y/lcnJX2RaF45Jwv4G8Oiheox3iL/Yqpi3O9Rtc8sew13TzkoDjdHyE9OtULIETwyXpa
         5JPQ==
X-Forwarded-Encrypted: i=1; AKwUvBxZbHpdUaCUqsILlawB1FBFu8AXNeX+ub+UoXJFP3dI6KRYywz1s+kuDlB8wPBrH6MOvVtUC/R5fHa3RA==@vger.kernel.org
X-Gm-Message-State: AFuF++nP163cf24JlDAHWYmfxgihHOHMrx2R9rIyFrhaKWnaMy2zJR9n
	w1aSENsDpj/1d6Uw1MXWhdbnVyLwiVZefn4SLPqHilLxk3odTrOXH60av3OUVjQbC8Y=
X-Gm-Gg: AYBFou1DzcnM2+kfLslxfJDIXo0C3MnbPMxn3Ah9F5sU3WEBjxrAfEeIPaUoUJyxXXH
	2fkOz08OpTeTNJ90buXZZGT1E80/RGjrhVa9nTNlgs+1ywbkGXBBNqyL8fIy/CPmkPGjwT4WKGc
	MLBrD3ZeaKOBjw/wX2sdOoiBv8BfT4MflSBGA7l9mo95l/BPOQTTzeJlD3ExQd85V7s9EQXNUTw
	oZdQFIzNDHPiHEWaGUEiIDh/+ZR28iY+EITBEbOAAL630O0zT4U6Qy9hmnycYj7s1wCIiECARGR
	MGsmRleBtFzOvLnEAR5jdq46OBEhjW8VFkuHHcr1aw4UTU9Ni5fdF/3DvajooW0n1HY7EYQ19jp
	MGH55TuDmsR+h6LZHCTw+YXJzO3E+pExnnZtwSYuzUNCkS/u8gAEYuAqIr/0h7bSrNri62/6g8z
	ovVlF9M0m2kK/rN4UNTW4kiEMHFkuHs/5XstfkacFADk1kTYHYpJWpN1+5qsHLAwCCGYmhmS7gG
	to3KNxvmchMzkIXKX07ZZywJoi2Hs4jli4CPxPKfTuiqNj84jAA
X-Received: by 2002:a05:6402:21d1:b0:6a9:a255:2555 with SMTP id 4fb4d7f45d1cf-6aa53102f8amr513503a12.4.1789716595790;
        Fri, 18 Sep 2026 00:29:55 -0700 (PDT)
Received: from [172.16.220.101] (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aa58d55cd3sm462048a12.2.2026.09.18.00.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 00:29:55 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Subject: [PATCH v3 0/3] ESWIN EPH8621 touchscreen support for Fairphone
 (Gen. 6)
Date: Fri, 18 Sep 2026 09:29:51 +0200
Message-Id: <20260918-eswin-eph8621-v3-0-514eb1f622c0@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XOyw6CMBAF0F8hXVvTF+Wx8j+MCyhTGRMetlg1h
 n+3ggtD4vIm956ZF/HgEDwpkxdxENDj0McgdwkxbdWfgWITMxFMaFZwTsHfsacwtrkWnKaNbDK
 tQdTMkLgZHVh8LN7xtGZ/qy9gpg/ybTi43uKhaa2RuvJAzdB1OJVJyPaSOiPJZ92inwb3XJ4Lf
 Cn/+SNwymhTK5VZW4BS6cFW6MZ26GEf6UUL4lfItoKIgk2lYjmrtJT5Vpjn+Q1F/mE3LgEAAA=
 =
X-Change-ID: 20260911-eswin-eph8621-5d3d766e2b0c
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Henrik Rydberg <rydberg@bitmath.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789716594; l=1416;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=RuNvguTwwr2VuOUhAB3PD3uxO9vmyNSZMReZz28odaA=;
 b=IdunNnHJc7fklXxaMRn0CrbST5HSDl79y+LgAxxlU59S7clmZaT/rqyE8Qp1kenHFzbzy7YQ9
 tRz7MsAe1WZBs3k8UknSAwzpvDcNr3XL/SHMVV0KLYwds/p2X8YJDm7
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Add dt-bindings, driver and dts additions to support the touchscreen on
Fairphone (Gen. 6).

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Changes in v3:
- driver: return IRQ_NONE on error, adjust code style
- Link to v2: https://patch.msgid.link/20260917-eswin-eph8621-v2-0-f534080a6338@fairphone.com

Changes in v2:
- dt-bindings: Move additionalProperties down just before the examples
- driver: Fix some memcpy undefined behavior, and various potential
  issues with malformed or malicious touchscreen response data
- Pick up tags
- Link to v1: https://patch.msgid.link/20260911-eswin-eph8621-v1-0-db447ff9e445@fairphone.com

---
Luca Weiss (3):
      dt-bindings: input: touchscreen: document ESWIN EPH8621
      Input: Add driver for ESWIN EPH8621 touchscreen IC
      arm64: dts: qcom: milos-fairphone-fp6: Add touchscreen

 .../bindings/input/touchscreen/eswin,eph8621.yaml  |  79 +++++
 arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts   |  29 +-
 drivers/input/touchscreen/Kconfig                  |  12 +
 drivers/input/touchscreen/Makefile                 |   1 +
 drivers/input/touchscreen/eswin_eph8621.c          | 344 +++++++++++++++++++++
 5 files changed, 464 insertions(+), 1 deletion(-)
---
base-commit: c2cd463d6ee7d55a3ec0719d93c49ff99022d58f
change-id: 20260911-eswin-eph8621-5d3d766e2b0c

Best regards,
--  
Luca Weiss <luca.weiss@fairphone.com>

