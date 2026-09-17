Received: from mail-ej2-f43.google.com (mail-ej2-f43.google.com [74.125.228.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8D542C500
	for <linux-input@vger.kernel.org>; Thu, 17 Sep 2026 08:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789633544; cv=none; b=k8jMzqO64nPY4rhkUsZ1sOTUzhssC+aJua+FwglvTpbsLmNGIQNon68RPYggqYuzXRXIvwZSQTwcVdSI1/ZL4v3zF089B6ko72aWYo8LRzNhNn/KVHlRm+gIFUAlDu2ia89SjPMembBlzvyRfHeyG6k2/BHT1oCt6Gf8gTq5xYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789633544; c=relaxed/simple;
	bh=FfHLIqVbUiDFb7PV/tcKm2OY5dbtW8PPcCi5ELgVdOA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dtSRpUPcMs8AgKxV/5hD6/4B0OkZ9+C1+jgauyzkbIBJ7Ik6NQQfeKTDKhmjZOuAANK1abC0RzNyPXPJsOtKOS4q1zk8DRga1HW36IRMaTHjfFq9GWTRDdf2DJq7HAbJi+Nfl3BE7mdNIioUOGPgTDyJBLJzFa8fNMqrC24h7pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=xVTLs+XZ; arc=none smtp.client-ip=74.125.228.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="xVTLs+XZ"
Received: by mail-ej2-f43.google.com with SMTP id a640c23a62f3a-c264788fd58so87110566b.1
        for <linux-input@vger.kernel.org>; Thu, 17 Sep 2026 01:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1789633526; x=1790238326; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pPKRfs0d0OIg8AedUsUxNykcUXne60lf5vpq99a5hjU=;
        b=xVTLs+XZdtDXLeSU/pAzejkZd68K1nUcGAKg+uBvlrRIUe0zu/EIzyNbGaFz9A+x/K
         lgiCRY9YoQbTgPwNYPgr2wYf9jk7E2ikCRtEZTIZsp74d80LI8NyeV+G91O89w6YlWhA
         abYlsgdKxUiFMwZMm4EddBz2rFutAf/89AnMUVEINT8hYvQ60oSQKUVBrW0+VT9yXJkY
         vM5KVQRU+mvANDCpSzk3wtwjYug2mWe0IzAZuLHWWEgoKobco/W0Zarf76aMxXUUAqlA
         pmzaZTqC5SvKseIwJht/2aVR4QvLBM0Pp8lCgrc6gdd6DCUf/mLrzCsJCU+kPGO0njoQ
         QgCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789633526; x=1790238326;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pPKRfs0d0OIg8AedUsUxNykcUXne60lf5vpq99a5hjU=;
        b=hgPBBSBDYDS6L7fQ9qQaWCN9LQ0sr49fZXmswYnHu6Z0y6tXGWWZXE3eUf/p0uQaye
         6wvOFmx8GLDlCvK827/mECrrKM4m//nlsjoR33XKB0CV6/dtqKMXYr38gqhCQ2/Bhj1/
         4bKFaQRQigLmT+WHAtbYH5L/nJPUXKT4KGuX6Uljjnt6oNuuU4bS2iuQ5eEykpXc+tAz
         fPk17H5f+VdbkDD9wCMN/+DnkuO1SDfD7GXwXgxQgPSfo8qLMKX8llkPw1lQ3SYmn5r2
         zH5r1fKQ0UFZKbO/f3DFXhkc25d7vtFYyM+GlR6DImKqinlQEewZgoJCwPNTBiU4f+/c
         IHiA==
X-Forwarded-Encrypted: i=1; AKwUvBx1AITxUk70MRmR1FkKocq0XIK4rvtdGBNzPH0KyrKy2C4maAHzCb5RjLVaoXxwQ/uhUYHIpFFsS8KIhw==@vger.kernel.org
X-Gm-Message-State: AFuF++kWQSA0UQBA0gvGi6BjL3SqnrWDehC0oIEX0IPRY8yOynytwcSl
	oWo7nlkgBcMFwRUT+y4y8yRYR7ekSnbBLSi3WUJN7vtyEjlwx4CtPLj1GXi3yYuJ4IGEsA7jlUO
	EN29x
X-Gm-Gg: AYBFou2tjx7cSgzuTxw0pPS4g8cFy/XYaVAJBfgeaoi8WBmK+CrGy5LTQ8wluWdwFB0
	rbUxkJ+5MgvXn9ycMgZ3D/PzJ9zSj70NMD+zy5IxKJ0wjcXP8bAvLkmDMB0VxWEac0oJfDqMnjg
	wU/+GDnpaHiRc+3I9+MjMuBvbLMu/ZrNYsHz0B3ctMtJcIyHEdlvmA2+j0tmCTd3i/6EK482WVq
	RMmZjYEO0BSpXvMuRliN/XziaMyt8o3aO8pmZUcZ2X2McK9SZ0YOHiZJF3Hgsn6G6xTr3hwKLAs
	todZg+qj3uH6C4DJtUdO4ZgKFghWKFVu00TUorAcvApumJOTxcK+FAFENlehnIgoQ1h/Fm2APZG
	qixbwlOj5XnGZM9rMD+pUTLyrraIaywI2g66aLdCeb/OrbG/7elblKWdMBoRUEbgCsTi5L2LIUj
	gWkGDNf7VtHZNs18Nm91sYljnSnwoVzpyHNIhxF4sG7JtvudH9xsRxYY+QDhSnwP87Kv9S5e1X7
	rfd946BJBuIhtaNDKe5e4QFPcIShch34vkN1mrvt1pOGiJgxkpw
X-Received: by 2002:a17:906:6296:b0:c21:450d:cd88 with SMTP id a640c23a62f3a-c29e51e1395mr396582466b.6.1789633525767;
        Thu, 17 Sep 2026 01:25:25 -0700 (PDT)
Received: from [172.16.220.101] (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c29de0851ebsm242943966b.4.2026.09.17.01.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 01:25:25 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Subject: [PATCH v2 0/3] ESWIN EPH8621 touchscreen support for Fairphone
 (Gen. 6)
Date: Thu, 17 Sep 2026 10:25:22 +0200
Message-Id: <20260917-eswin-eph8621-v2-0-f534080a6338@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WOyw6CMBREf4XctSVteSkr/8OwgHJrrwkUW0AN4
 d8t4NblSWbOzAIeHaGHMlrA4UyebB9AniJQpu7vyKgNDJLLnF+EYOhf1DMczDmXgmVt0hZ5jrL
 hCkJncKjpvftu1cF+ah6oxk3ySzh8TmFoPGLQ1B6Zsl1HYxnNRZwwpxLY2ob8aN1nPzeLPfznx
 ywYZ22TpoXWF0zT7KprcoOxPcZBDdW6rl89vPBt7AAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789633524; l=1248;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=FfHLIqVbUiDFb7PV/tcKm2OY5dbtW8PPcCi5ELgVdOA=;
 b=w3Ev19vHK3OUPv1BqDmTac+9v85Z/m5S2Kr3BnLpY8/UYjszHo9WM3dST0c6SoNjgHp5jFixq
 NJk/4fvM+sLDmuX5CnQngsYOjugx/QNGsg6P6LW3yqyZR8IVzp0hZmO
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Add dt-bindings, driver and dts additions to support the touchscreen on
Fairphone (Gen. 6).

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
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
 drivers/input/touchscreen/eswin_eph8621.c          | 333 +++++++++++++++++++++
 5 files changed, 453 insertions(+), 1 deletion(-)
---
base-commit: c2cd463d6ee7d55a3ec0719d93c49ff99022d58f
change-id: 20260911-eswin-eph8621-5d3d766e2b0c

Best regards,
--  
Luca Weiss <luca.weiss@fairphone.com>

