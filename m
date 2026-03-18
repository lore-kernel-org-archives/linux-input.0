Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0A937D104
	for <linux-input@vger.kernel.org>; Wed, 18 Mar 2026 08:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773822713; cv=none; b=N2WRK3RhpEA0gFC9k+rvNHiQQLoBAHL9D85xOr3xZUBisjlJcpyxE4Fo+PMoJoi5cjJ8ASqQhly1EmUwPAolj6QprowyJ58i1LBaZeUcUa/5iryVsgbFcldZG2jty/XqS/vKVYnx+mHWjJD8ZshQDLVXPO7S/0zYwEbdr1xih4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773822713; c=relaxed/simple;
	bh=XHnB+mK6xGRUI/1P4LOs4QVdLEWard9D2s8tWWJqkKU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UI8YzEZWU5LY/8mSc5+4eKhftNIuLg2EAcsHvA6dmZFCvp08spA9hZWCLFf+rKT9fdqdt8mtwvBMh3dV7fS8ifly3fHnR+DOxZGoUJ1thQZqkFva4wefXRaFx5bFL5uD/dDHwkGfNp+PoSCWaFZ+NegHmtcqe94pPuuExq6AH6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hoZAx2mR; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hoZAx2mR"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-82735a41920so2523470b3a.2
        for <linux-input@vger.kernel.org>; Wed, 18 Mar 2026 01:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773822711; x=1774427511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=klbyuhxtyqmgcbtWm671qhdJGBO8PRmtUd+eMK0w1Ho=;
        b=hoZAx2mR8E2ire7IG5+lIrpFPYe0PmnV+6mHumZk3d4JhRVPHG9Zv58fzgnoG3x8Dh
         r6c/7XEu2j+oKE6Hwp+9S1c9kuNCXZD9snT1rAZ+jNiv7Two1H9QwhSBJYOTajZhFleJ
         fpkhE6coKZR6QyQvK2U3cJJ5owOOdE/RI37LAjCTJTrx29DhtBe+uQ7OfIWzoWMMHTDZ
         5OckJtF6asHq/XRtbNFJEE5eq4NwY16eDV8Rf9/zy2BaAw/g3hiV8Oypfsb8Vw+R9i8z
         sEZtyuSwAPOJ51LsRmSutPALJ6if1swNIpVIDk8Zxeu61VqIrlJJUxyg2mmsEcq5ZiOm
         UMrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773822711; x=1774427511;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=klbyuhxtyqmgcbtWm671qhdJGBO8PRmtUd+eMK0w1Ho=;
        b=dO2Lep0ODEzlmN2Qh/zYgVFUyzfGZbejjOX3+GRCW6R7gGhaQaS76ttxxNigB8ZX9S
         l0kKgkW1UYhLtJ56vOpkjzb1QPTxo8Qtg9wD3VlcVTNaf6cUU+6SHglV/BNjT5CL0yPn
         5mpCsir3k2qmwHdPTDOMEXHx/gd+qREvsH+UPl/xEcIAFsT0gT6nf/8qANJNBLYUEWNK
         ARyhaZS3UVSGIKhsXQEJzCdGqfI7GdgYyVcYI8NCqY+zYC4vrGiKzVfabgNgS1AFcZv5
         wKK5FmI+uV6gCTgRt8hqnuA0feza5E0CXi1k9I2jHMiTt/LNq9YagJ9Q0opn/bwQqcVa
         hNmg==
X-Forwarded-Encrypted: i=1; AJvYcCXQEs9lni0CgLXcdTSk73mEe4Njh6pDOsBTrhx8bxCLqNJpbbEOInPDzKFGRbcD9RAMY+sc0piqf0AB/g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwgjmhMGVtImtkOqcqNn5DiSxkatls9leh2PHQ6a0fCxF9rN2fU
	mivXgmraYSg+XPg0Az541lJQ9F80RD8rziT3g/Q5KEmbbl4wY6aJCU6D
X-Gm-Gg: ATEYQzzaW+VDHnLV/eoMedWmCsN9l+Su/JnJhOkCWIDrPrewJXyCOoB9kwDzGX+3D/Q
	eDPizCLoqeagQW+HkxvC+lEaC+ka0UXdx52Ay7k8iury7BPMThOBbeo4Y76Vkt2cgTrx9vWGuN/
	2kRLkvsAxCx63Tz+ewimDOAlR48NlePr6c8ZncrLbOO9QNgMgO/xx5Vb1Z7rXShEunUQPtdPd71
	f0Vy3SsHOm6qJEtmEzQDJgtzS78FAB1BKb4iUMwX5mqzUIM1TmhGw1+5xj7KdupC9reDSL1vyv4
	HpSikNZM3bXK4449029dDiIeFvsNaFOEInjbhdabK6t7pY3qpII3UkmsbvYOYJ7uPdQQuiyfnRC
	phAFZjFv2OuiOP1XsS0KsY+wgZ/kP0Vw4YR6GlVLT2cBjcLS/dq+y15VKlF56VHDT+AmaXbVemn
	6ieqca69+qEQ/71Tw3l7vdCdNLyzw5HYwIDN75KzzHww/YuVMWh93uNCEsxw==
X-Received: by 2002:a05:6a00:1702:b0:82a:60ad:87e with SMTP id d2e1a72fcca58-82a6adff9e8mr2364033b3a.19.1773822711265;
        Wed, 18 Mar 2026 01:31:51 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a6bbe5ea9sm1794663b3a.45.2026.03.18.01.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 01:31:50 -0700 (PDT)
From: phucduc.bui@gmail.com
To: conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org
Cc: conor@kernel.org,
	devicetree@vger.kernel.org,
	dmitry.torokhov@gmail.com,
	krzk@kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	marex@denx.de,
	mingo@kernel.org,
	tglx@kernel.org,
	phucduc.bui@gmail.com
Subject: [PATCH v3] dt-bindings: input: touchscreen: ti,tsc2005: Add wakeup-source
Date: Wed, 18 Mar 2026 15:31:24 +0700
Message-ID: <20260318083124.21793-1-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: bui duc phuc <phucduc.bui@gmail.com>

Document the "wakeup-source" property for the ti,tsc2005 touchscreen
controllers to allow the device to wake the system from suspend.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---

changes:
v3: Remove blank lines
v2: Revise the commit content and remove patch1 related to I2C and SPI 
wakeup handling

 .../devicetree/bindings/input/touchscreen/ti,tsc2005.yaml    | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/ti,tsc2005.yaml b/Documentation/devicetree/bindings/input/touchscreen/ti,tsc2005.yaml
index 7187c390b2f5..a9842509c1fe 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/ti,tsc2005.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/ti,tsc2005.yaml
@@ -55,6 +55,9 @@ properties:
   touchscreen-size-x: true
   touchscreen-size-y: true
 
+  wakeup-source:
+    type: boolean
+
 allOf:
   - $ref: touchscreen.yaml#
   - if:
@@ -97,6 +100,7 @@ examples:
 
             ti,x-plate-ohms = <280>;
             ti,esd-recovery-timeout-ms = <8000>;
+            wakeup-source;
         };
     };
   - |
@@ -124,5 +128,6 @@ examples:
 
             ti,x-plate-ohms = <280>;
             ti,esd-recovery-timeout-ms = <8000>;
+            wakeup-source;
         };
     };
-- 
2.43.0

