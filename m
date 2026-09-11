Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2822036197B
	for <linux-input@vger.kernel.org>; Fri, 11 Sep 2026 15:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789139779; cv=none; b=fh0lWyQAtwzg+8V3eQbtYRlB3W5fMNnDBB1ksZSoE8hN5Pqmm1RhUB0Ohj4Kwa/4P+mXcboSAuCcLH+PaJj/LHQOU70dV9qmojgnC/c6LHX2ny0ngZLJHYlkxfEt7jDrJKW5UVO4FVzlddR7G1uePqOxfLH/DbVbGR8Q8iyPASw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789139779; c=relaxed/simple;
	bh=8Jjd56jEtGXtBKfGu+jM18XnCZwOYP3vVYoIuLH6rK0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=d5DU9F+ew88xs6Kl7/ATmV4+P6Ad7VVAUJxvRAlDRj5LuR/atcmQqm1iviGnYc8dDyg2xGOl4Utv3S8wR6Hc9rDQq0l4fWH1rnFy1fwqzoDTJN2Vv7I7RoIHmLmK2RvwMIt3HIn2pEdxVN0i8tJzriAnaJ6YKVZ0qov7MsM4kSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=M8BYNE20; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="M8BYNE20"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c2055573c8cso158950866b.3
        for <linux-input@vger.kernel.org>; Fri, 11 Sep 2026 08:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1789139774; x=1789744574; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=c8Q0AIdSNybOkF3ME9hchoB4tDUvQhx14DDferN7ztc=;
        b=M8BYNE20OOAXsnKlI6Nw/SyvauyrxAgGyZFZmzIWFr4n/EZvCrwnLTFJ2Oc1IqXHQj
         Mf+5oLeNo+P7QtjA14SCjTKrRwsmlw/w6UA0O0rCRzkMbjrY2nYQ5Kv9xrr0J8cLDL++
         j3Wy1cvuMR3MRfK/azbuBLiP0cJWJMzzmrUHUVKv/oZrlhgMWQicSgdL2KPpBYy30wV0
         sXLetel/YjMM9rC8r/usLGHjV9GFxSSNB7RKajUJvDPzbVxVj1DlwnAL6sW9OQP0M2az
         cGxKuLyF+IphOsLXIuwV06Tltp/m97mt7PJ0X5BLsUXNNsILtI8iU0B6R3K8i0gLbKsN
         26jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789139774; x=1789744574;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=c8Q0AIdSNybOkF3ME9hchoB4tDUvQhx14DDferN7ztc=;
        b=Ar72+2UX06ba1JIxC08RbF3+WsKGJELZUIOZLlbhCZZTAbV2jeepm6Tebm1uecnm3a
         LbY105BnW4aTWNoGzqofnR6cntp2YPNLuX5e1heVaqK2y/TWbzzqlTEzmBa0ikTS9nmc
         Jii+720GL2DCwNGs9egSphCLOt54El/XB1v8wlzBFfFQ2t1Gon3R3t2nrfdsNEJaIddY
         QAGvRRh9U8br98EOTvVj+2rwVQ9jDsqgt0ujPIrfW2lCvdWYlZPFBQY4jm6hMRigPhzr
         6fHkduWM+VHY/W/tzzupvAvif19YeYN7juSM4MsaxNUD4q2BYyNicj25zfThy5YsRizv
         NK4A==
X-Forwarded-Encrypted: i=1; AKwUvByFPK+f+WxOOK7k1IIrZMi/Fp2PJ30q41IIVBzl3Nt0v4VMOWfxjJ7HKDcaS/zY7jxx4MhET1a0/tw5Gw==@vger.kernel.org
X-Gm-Message-State: AFuF++kPKxXqY2xU0hNL/+WJEg8zxqpg7SFsh7klBvrc1h+ccWXtWR0j
	VX77B5nVrl3R7Ln/8fYztHfnZhu9iI6Wfp3DRInZZ6QA1Lxomv2jWfjeL9vIA8LZdhIHOmMrtFH
	EPB7q
X-Gm-Gg: AYBFou0Vg3UNn12YGsabYP0TiwHX98wSeLBJW25Fge0/f4awPUvcCtaAC3rbdHBQxs2
	0Ez63b0daR6NsQEfOhQJoaRsuVeCUssK5OOsGNAHcYnT9TVjcPigShWIoRQwMgQHw3k1C7oeWp+
	0fc7XnRnnRcpA5NVfzP/GAVMIFScRYuhVJbJnvnpmgdwJLVfHqZf5vPP7k/wanWGLjOnkCG5S/9
	UoSAZX73K9vWfkY+wEF+hM679GZEzKgY6ouoe9Hme4VdZjwT1I2lKYoKbrvCOBYowI1DH3LPAl0
	eXFNRgywd5CJ50Mx2K6xnNSlC8uHrIcBY6QMV1wlV9iMjQ/L5dL9X9YWHYXFJEzhT4lxnLszIEi
	la/EhMVMwnR+mcd0iY4pGqkZtpYDcY3MwX2FhLi7ecuupNu8Omq4sB2GDRiNx9d2n37GCGFN8e2
	dq0PX6t9gottE0C91T7xjO0pkCCf+EMAvigVs+js8WLm3umJqDmcp5GT+wSWCnmiTYIX1MryW9q
	NzNPca8fMCUfXJNtZIrzspro5se9vPtLuTuvkr9+k50RhuDgL/OyKM=
X-Received: by 2002:a17:907:874f:b0:c24:6390:decf with SMTP id a640c23a62f3a-c29665b7776mr196074966b.16.1789139774073;
        Fri, 11 Sep 2026 08:16:14 -0700 (PDT)
Received: from [172.16.220.101] (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c29660ba623sm94656766b.45.2026.09.11.08.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 08:16:13 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Subject: [PATCH 0/3] ESWIN EPH8621 touchscreen support for Fairphone (Gen.
 6)
Date: Fri, 11 Sep 2026 17:16:08 +0200
Message-Id: <20260911-eswin-eph8621-v1-0-db447ff9e445@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/y2NQQ6CMBBFr9LM2pq2xKJcxbCg7ShjQsFOQRPC3
 a3i8iXvv78CYyJkaMQKCRdiGmMBfRDg+y7eUVIoDEYZqy5aS+QXRYlTf7ZGy1OoQm0tGqc8lM2
 U8EbvX+/a7syze6DP38jfSPicy1HeNXAdo/TjMFBuxFIfK5m8gXbbPlcQiAadAAAA
X-Change-ID: 20260911-eswin-eph8621-5d3d766e2b0c
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Henrik Rydberg <rydberg@bitmath.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789139772; l=910;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=8Jjd56jEtGXtBKfGu+jM18XnCZwOYP3vVYoIuLH6rK0=;
 b=LBlZtbUcP/9iDsemprine9FuVLBDbXoLQ8FVQTemqwD1QmkOBkWKe4avZExPlWlxauSZ52esU
 UMUgHUohHgiColjyFoZDgNFLRL9bOlHOZD8clZfF19JSysm2ZIylwTb
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Add dt-bindings, driver and dts additions to support the touchscreen on
Fairphone (Gen. 6).

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Luca Weiss (3):
      dt-bindings: input: touchscreen: document ESWIN EPH8621
      Input: Add driver for ESWIN EPH8621 touchscreen IC
      arm64: dts: qcom: milos-fairphone-fp6: Add touchscreen

 .../bindings/input/touchscreen/eswin,eph8621.yaml  |  79 ++++++
 arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts   |  29 +-
 drivers/input/touchscreen/Kconfig                  |  12 +
 drivers/input/touchscreen/Makefile                 |   1 +
 drivers/input/touchscreen/eswin_eph8621.c          | 310 +++++++++++++++++++++
 5 files changed, 430 insertions(+), 1 deletion(-)
---
base-commit: 5e036ce12de91c6fd674dad33b169c6150be2a7a
change-id: 20260911-eswin-eph8621-5d3d766e2b0c

Best regards,
--  
Luca Weiss <luca.weiss@fairphone.com>

