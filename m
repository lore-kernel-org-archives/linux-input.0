Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD613ACA5E
	for <linux-input@vger.kernel.org>; Tue, 23 Jun 2026 20:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782247723; cv=none; b=QzwJh6ksGpOncuSk1MqfXT8+nWQNiK/i2gvWl41vMNe/iGfGa9O5L/639q7X9jQ6eynL1lcFJ6SXmCacbJL0q7REFZ/vxxVB0cP3v8NCVVnrFVM8n8sY0rlP03NZWL4rTmxpZJejj4NxniAdJ0+ApgTJQBPtQ/Uc7xDU9bfSS4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782247723; c=relaxed/simple;
	bh=dR45JslvD8X9ffV3iYwOxJm087D1op+CNofDiF/LfOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YUfJFDVfar3a61KtkYPm50p+mOeKsw3qmTvOpfVJVx80Ommafb3A8wEJfhPvynyYkwB14gSDRvSIN6ve4j/UI6XEyuY/mSqKTKKV00fHS36MfyDxZGk/VYJly3Vi1gqqcmxTMYBIrPiBBIuyryyWKGvtW7xz+OHx5BMmkiQNgXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m1oYq2F8; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m1oYq2F8"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-490b8ac62baso14146105e9.0
        for <linux-input@vger.kernel.org>; Tue, 23 Jun 2026 13:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782247720; x=1782852520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fHPVJLFdyyFn1B3+/j6XeVWPQvw5tBspxfdA6KrvZVs=;
        b=m1oYq2F8ZweMqdxIFtBb71bpuKN+qZPCxbJQ9VYlDb+JxLySGWFae+G3ZAXpb5EqLk
         w12SHOEEPQnHthqPzVJPqWJvKvd+7za9i4MEiGyRaYzvV8d3EOk39b0WWGd4ToEx8LEB
         bp8jNevYNz5j3e+wuGBrU70JCyAfSkGuCNO4YPbkeX4znQEpuBW1CltC2w9opBSDvvhv
         mQTH0zV/82oS1klhRgtIY44iZp1le6S+Yz+b2BI1MYmL7mMn4q5mLny6VTFrj88gWnp1
         5hCkKZF0JPbMOW7ybXJMPsJBEgpoijKcOnkkI+bq7/wCFPEjjQXfuzXHbU+nbI5RUDo+
         rysw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782247720; x=1782852520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fHPVJLFdyyFn1B3+/j6XeVWPQvw5tBspxfdA6KrvZVs=;
        b=GHSAk+P4exLF7CR5PgiZ/fqa29s962G6gyDwu0+zyI1nIq/alkR/RYBCvBIC55zowz
         TvkTM0A9I/lB0ynpzOscjioPLXJ8xo/hppRMD+zd9yhyWwrOc6oq37MKKp50ttqgvXvB
         jN4fxFvTU+QBsUsZfGL0FIXK/XoyrhWr2IBjbARZT9BbTDW0ii3Fi/ihBb/sGE3VZhCR
         CsbjGOu6xUqhvmeB7LUeCjb6+uXvKB0ETYrHU/lLsUTJ4T+dK/oUFITMzANWamU5kmkN
         uPAvXyoZ1jsF2ndzS/w0QLv0o9Hff2KghW9dS1mgploDvsrKvGDg1WA5HlzKpiQnOfiD
         XU4A==
X-Forwarded-Encrypted: i=1; AHgh+RpOJ3wlK+IxT6fZaim1GBm/chWaE+Hn+192IrCRFtcP1AJccSaRuvpUsiQS+39GbKmolWTae5ZDH5upuQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+R6y1DuB8PLARp6mRXoC1Bl9MV6azXd6MXLFpE2+ELEXuZpMr
	13ZGRgsncY8xcMhXWIpQVs2by78nJWb0HAA2x/7FiraEaEGjRUht73xg
X-Gm-Gg: AfdE7ckWqNy42xRcknu80hplGvAbldG4JWJll93X0JvErv5KSuzdZWt+Ao2KFtPoa4M
	FaGsAAaZgPuMWagkHcNxqC7vk/UrtspwJJzjS37wQqetU5A+aQo6lw6bdFJOraxTubAIRkfW47U
	ky903COAkwwHCp/NqNZSBTAgzIfMPbv9OerNyRT5JfDEYcINhj1E0GuFdX+Cr4VQ11s9ttRizuQ
	JelPwCW12Efke9/b3i/24JOIF6EVSZ/y2NYRskV+gPcNp9cqhXq0Q0O0TJLWZl9netu/yRlp+bh
	AHehTlSRTHmyIN55PNAVsWC0mSNxDkopa0WHWuoA1DSZr2HoKSHwymIb8YvFlbKyyH8irasHBXh
	aGjPj0uZkfkPOcozzngmpFh419SWTqwqoPh2GeREA/vPjm39bc6r0kKT6IO6AwoULrKF48UGrBe
	ITH4MxYMXMU2W6tbvGu1fYNEhAGbS33Z3p4NAvpMiKPw==
X-Received: by 2002:a05:6000:401e:b0:460:6b12:1783 with SMTP id ffacd0b85a97d-46a7ebdf3eemr8161239f8f.4.1782247719719;
        Tue, 23 Jun 2026 13:48:39 -0700 (PDT)
Received: from localhost.localdomain ([2a02:1210:8642:2b00:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46c1e840f80sm351996f8f.6.2026.06.23.13.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 13:48:39 -0700 (PDT)
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev
Cc: Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Hans de Goede <hansg@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Andre Przywara <andre.przywara@arm.com>,
	Jun Yan <jerrysteve1101@gmail.com>,
	Lukas Schmid <lukas.schmid@netcube.li>,
	=?UTF-8?q?J=2E=20Neusch=C3=A4fer?= <j.ne@posteo.net>,
	Eric Biggers <ebiggers@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	Luca Weiss <luca@lucaweiss.eu>,
	Sven Peter <sven@kernel.org>,
	Maxime Ripard <mripard@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v5 3/6] dt-bindings: arm: sunxi: Add Baijie HelperBoard A133 compatible
Date: Tue, 23 Jun 2026 22:48:15 +0200
Message-ID: <20260623204824.691832-4-alexander.sverdlin@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623204824.691832-1-alexander.sverdlin@gmail.com>
References: <20260623204824.691832-1-alexander.sverdlin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Baijie HelperBoard A133 is a development board around their A133 Core
board. Introduce a compatible for both the Core and the development
boards.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
---
Changelog:
v5:
- no changes
v4:
- renamed "Baijie Helper A133" -> "Baijie A133 HelperBoard"
- renamed "baijie,helper-a133" -> "baijie,helperboard-a133"
v3:
- no separate section for "core" .dtsi
v2:
- introduced baijie,helper-a133-core compatible for the Core (SoM) board

 Documentation/devicetree/bindings/arm/sunxi.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documentation/devicetree/bindings/arm/sunxi.yaml
index e6443c266fa1..82dd58b95f8a 100644
--- a/Documentation/devicetree/bindings/arm/sunxi.yaml
+++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
@@ -96,6 +96,12 @@ properties:
           - const: allwinner,ba10-tvbox
           - const: allwinner,sun4i-a10
 
+      - description: Baijie A133 HelperBoard
+        items:
+          - const: baijie,helperboard-a133
+          - const: baijie,helperboard-a133-core
+          - const: allwinner,sun50i-a100
+
       - description: BananaPi
         items:
           - const: lemaker,bananapi
-- 
2.54.0

