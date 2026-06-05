Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF5846AED7
	for <linux-input@vger.kernel.org>; Fri,  5 Jun 2026 07:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780643404; cv=none; b=SDITqBmon8MZtpxBqJ1gFVNSjVYQyQjyNbXRYJeldLhRjbGmsEhxB5T65sTYD7QBg7ld+8KJaI1hl9VGnLMvtOe3pLoZg/WT+zRNwe046LveJs8GF7fg5Ii3VDIiBPyEJ9kenZER/yxUVev6zd1ep22XkucR0KX0gbhNWY//WSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780643404; c=relaxed/simple;
	bh=7MDbaMfdfDFcEL1euNDkSuzapxJuUtssv4QW4CSalUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YNTO7esh4foMKDu8w1qG3QRri0Hra3DkCaF9HFpOj1YeTJeJsLz1IsW4XDNY+c8pdrE+Wfw91kcL21iF4XoqKEMTILpKqCWp04YUPQpNPEeuvwsyksyOpoWBDQor7aWjK+34Nmsr/B7rUifOI5NF+z5kUoa/N37uRhkixJun7vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fSy9aAf/; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fSy9aAf/"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-45eeba68948so1016205f8f.1
        for <linux-input@vger.kernel.org>; Fri, 05 Jun 2026 00:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780643401; x=1781248201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oL4Y31r8dtXqoPXz/W9R/fk3pvn98vrw1YoAz+z4buw=;
        b=fSy9aAf/UppHL2XCuU87VFTQmEsCIb/b4p5MU/uaQTdP3j0fbn3QW9kZS7IsOgGmRL
         A9TPjxfxioz3hQWmTBq09svrElNUeclNmT2W9ke2a5hAxeFXvlJlWrTBsvdg41zF6PT+
         1UH1MBTL7K6BuWC03AvGOaI/bIExTFWtIKvBUe+V2soaQGIynTuTKpa/mbeO73NRF2i4
         Eq1fhyuIYKelTNDBdOqoIKYUAc+N0Ss0RmsukBtY6KzvCVWmH+I2/SdQpQG6n0N74BcJ
         CkHrDAK0l1+w8y1tumNFf/bq1BA1stF45eWrgJwtJImvUu6/DtAfS21ibRka+z5zvlda
         CMQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780643401; x=1781248201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oL4Y31r8dtXqoPXz/W9R/fk3pvn98vrw1YoAz+z4buw=;
        b=g9FUszgtNQeAB7VMdBatrhkl/ryTsaraH4qLiiHFzrovpMixmM+vU/HR7O8Dc3QSXI
         Cy1rzeO0zsGGma7PNpmaiijjl4DkkKLvDZEmJtCSUkPt9935g99wmzeT6xlBowyPjawQ
         muW5XwblS84p040fj+A69JVN+MNefw1rpXGKNQk4AP1dN0fCF+rE3CAQfaHNpLuDMrp5
         oGRbNyQZXmy+A70AK9quRxIMqqExy6BVS2pd5EK0AybwvITO+CUR7tVE1QI2Qdr9wsK3
         hPvBR4YASXzYxZWV0CYnB/fWiXAeS2IgRIxIGdzzuyWg8sHYwE3Frz5+nxPuYcUkf63Y
         /gXA==
X-Forwarded-Encrypted: i=1; AFNElJ/m7W90pMVOXY+6dISfpKt1G69UW1F2YmnK5T82FN7AxyZ/llX35di/WVNEHkTdk83e0zDCrGz5YRw3Tw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8+skEKyJsSBi000V4q8DWdB1nPXUJ3kO6Zfu+vm8Ok68V6yrB
	NI7g70GK4YXInXUdVwNX5zK5aVjzIAC6EvNvkxYhdfiGi+L0hOfXa8mk
X-Gm-Gg: Acq92OHGJ8iuEFeI+GdTqvra8aIyccjcjy0EVHh7GJt0pbPPkjPxAnPPhOVrmXyo036
	eBVsK57NmkRtNeVgEA4Qr3Bl1WfzHpkny8lroRL8bgAFuAu9Mf1pgDbYyLm9b5vIm6nMSoNqY6M
	2mnsEGwUIK44NHO6Xy33KQ85c9oikmbiPzI53P4dFTKkbnpyO4QV9Bde5/6KS92A/U6snqPXovC
	l4YMMrzWrCrlL2fLzecMYWj2RtrQCHLP97DUzfskkGj2HWLlt2iyrg+Szr8XCx2jdW7Fsiaiwp6
	9DBzLL+tVJ1ynh03DdkKg8rFwhtfSLbE+c1GoOslOTHOoI3r9sd8kVavDOXm+1cdBPR+0f363Ms
	1LJDHYP/5ZPjxhJp6tP9NzIirO/UF7187ADn2rXgRoISofYF8Cgo14wkGdtRNWwIM1xUc4+R9Yi
	AdrVwCqdlBc4HMQBmvcdqb/xfhwwgifDLqsY9CJoqnyIOuxxRzKoAglBb1lSSg6EnxAUjtDRdbp
	/DwQ5DXfFzhOZJXH/YmoN4JClI1jf4q
X-Received: by 2002:a05:6000:178e:b0:460:3234:293d with SMTP id ffacd0b85a97d-46032342a62mr2372600f8f.40.1780643400949;
        Fri, 05 Jun 2026 00:10:00 -0700 (PDT)
Received: from localhost.localdomain (72.92.4.85.dynamic.cust.swisscom.net. [85.4.92.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dcad5sm25132882f8f.5.2026.06.05.00.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 00:10:00 -0700 (PDT)
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
Subject: [PATCH v4 3/7] dt-bindings: arm: sunxi: Add Baijie HelperBoard A133 compatible
Date: Fri,  5 Jun 2026 09:09:17 +0200
Message-ID: <20260605070923.3045073-4-alexander.sverdlin@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605070923.3045073-1-alexander.sverdlin@gmail.com>
References: <20260605070923.3045073-1-alexander.sverdlin@gmail.com>
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

