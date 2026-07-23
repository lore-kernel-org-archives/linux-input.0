Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F1A43B4A3
	for <linux-input@vger.kernel.org>; Thu, 23 Jul 2026 10:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784801181; cv=none; b=CvXHgMh6XU0uQSVlsbat+62FFWdJNEP+YUwNEe3bfekZLcmH6sZxOG5/Au467xqRVnQaX+bqcBC//8U124VEyA5ELsXmAG72hsW705SMazWEcua2VQmrEzQjmU6FHaZJtazSNkVcM52+0XBDYcjxxIwpzerfrVCiAlCV7VQJElU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784801181; c=relaxed/simple;
	bh=kqwgEUYByWeKCt8A1G20ZW6yeKjOibdlAuv2gZFEVqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cPQRjyRDAMVuqcApzQAxoiNLBk0Twp7itW6Ur0/+OQ/zxkmiDTMV1VuAKFbTNATbhbwah313J2XqY0mOAna99mjs+0pH4owjzD5mpm8xhG8Lc378whVJQDvQma+1L8fAvMiCmUDPe58NEJINrdobA05zAikDKsqcaVNXfoJOrzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LpFwFBQK; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LpFwFBQK"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-49554ebb87dso5135735e9.3
        for <linux-input@vger.kernel.org>; Thu, 23 Jul 2026 03:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784801178; x=1785405978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6g+koxDLN1Chjep218/XBMsTlfwQifOiOfABmvTzX4A=;
        b=LpFwFBQKShOgdfhRoBRsuw+SLLE1s+QvsSL5qFnSTAyeg+7Kr8dRPeMlG+shYJFDbG
         KoUmDrOJ5y1Z2JA0thB/lOTDGL4BiLOLbmNnacxYxd3nYTyYCwgE6XN8m3v1MdDxMiCY
         NoSbo3sDHvjheP2K/lvcyg3r8RhBmm3HHAE1MOD8n5vMLeiecV56kQZP1CH7Zwj9lXIz
         QZWEnjdPiyuvBl2tHeQblL4FQn/HQfddIQewiFHrPIYy3kP7C9+sNi088szX/KRqMcFI
         O6ltKyGKsadLyFnq+ZHKP9221BZ+iKKCUDJJ9CaSqtk4DnY/+pBO81i9c1RdScEVy+zI
         oLGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784801178; x=1785405978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6g+koxDLN1Chjep218/XBMsTlfwQifOiOfABmvTzX4A=;
        b=TjvhNaqRFkn8WWME73QLkrnDhUaDRQYfs3SdZ8nlUxPHb8VIVQvMtDtqfEfS5JtvtT
         ynctKUxxGcBUQSwpzAe/WIdlYh1mSqWMUHjil4RuYLCelMq0kcofRCl2fJzRn+VfY+AG
         diLDbzFnq/tovFtywoxZlsuoyLP8HFwqY7qMjsnKU5hh5alCG/z0ux6/2/VJ1VNivxxE
         5aEOsEl4jNHXwxggvKHkzwYtdfgYiP8t3ECyBq47uiv+QhZhiA+9iQ1ATxJ0AT4oojGw
         EQc7znz8OYrhYOS3A8qFJun/9Hx6MmYNIEJeQLcDEvfB/BNgGXF2WLhHKSoXpVjxvbCf
         rlMw==
X-Forwarded-Encrypted: i=1; AHgh+RpxVEvqjg8GZi1NpNxjD6mzyEeqF76GfGNqLuD9L4wHbCizhTNemTvY/kCxMmJTPsVy7u9krxWVbifmaw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzdZ7bpswYKyrk9rzrqHB0WKtHNQqtLvW6Ote7+hQhxd9e5PGyy
	UDPF8wr9T4snrXGuFB0wtcoayvmlEk7bj4RxojSPb3gGTT7CR9YaCX11
X-Gm-Gg: AR+sD13RbLy7aAwjI/FNmshQHxKAZiltJMmE87nQ3f8rFc98xMwkLU4oyi8iMSt0++0
	MX92gRVycWxdNtOMeAs9WrPrj7iiHsAzVh07o22aHfd55tHkntyTPLUijTzdpa4LNpy/MfRgroY
	1xeOC8v/8vkKv3cBdo086BPt8KGGTH9WHQSQVuynMVfu91KIWgK0/3+tZTZyAT0lwr+nqnmEGDw
	L8WDZCG8g6+oc7nnWUqX3agylT/0gKpqK4Xz53jge21uh8hgKhiYbVN5J1b37GjdXyda07yy/Bb
	QjfDOL4MgTliP2hRKTG0hEwTf1ulgWFKp2i46l7AbCvZ0U8AnjPdJr62tZYJO5Z7Y/JhbM99+vI
	O5TyVTJbU1A4C6SW4fQc1K2OLluQY5RnlmOS4tBj1yfLGcU/2A7ctnUMQAKr76YqcG/2QzDtxq9
	OR0kfW16scbgFgofeli66VNoTN4LsURCWcf5DE6xm7gmuK
X-Received: by 2002:a05:600c:4689:b0:492:6f6f:fa42 with SMTP id 5b1f17b1804b1-49573d37f29mr28050145e9.37.1784801178079;
        Thu, 23 Jul 2026 03:06:18 -0700 (PDT)
Received: from localhost.localdomain ([86.126.27.145])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-47f85b9a60asm14212163f8f.3.2026.07.23.03.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 03:06:17 -0700 (PDT)
From: Eduard Bostina <egbostina@gmail.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Conor Dooley <conor+dt@kernel.org>,
	Daniel Thompson <danielt@kernel.org>,
	devicetree@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	dri-devel@lists.freedesktop.org,
	Eduard Bostina <egbostina@gmail.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org,
	linux-omap@vger.kernel.org,
	Mark Brown <broonie@kernel.org>,
	Mark Jackson <mpfj@newflow.co.uk>,
	Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>
Cc: daniel.baluta@nxp.com,
	simona.toaca@nxp.com,
	goledhruva@gmail.com,
	m-chawdhry@ti.com,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v4 1/4] ARM: dts: ti: am335x-guardian: Drop unused isink-en property
Date: Thu, 23 Jul 2026 10:05:59 +0000
Message-ID: <20260723100605.628882-2-egbostina@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723100605.628882-1-egbostina@gmail.com>
References: <20260723100605.628882-1-egbostina@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 'isink-en' property is not documented and not read by any driver,
so remove it from the TPS65217 backlight node.

Signed-off-by: Eduard Bostina <egbostina@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 arch/arm/boot/dts/ti/omap/am335x-guardian.dts | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/boot/dts/ti/omap/am335x-guardian.dts b/arch/arm/boot/dts/ti/omap/am335x-guardian.dts
index 6ce3a2d029ee..d595e79d6b05 100644
--- a/arch/arm/boot/dts/ti/omap/am335x-guardian.dts
+++ b/arch/arm/boot/dts/ti/omap/am335x-guardian.dts
@@ -320,9 +320,6 @@ backlight {
 		isel = <1>;  /* 1 - ISET1, 2 ISET2 */
 		fdim = <500>; /* TPS65217_BL_FDIM_500HZ */
 		default-brightness = <50>;
-		/* 1(on) - enable current sink, while initialization */
-		/* 0(off) - disable current sink, while initialization */
-		isink-en = <1>;
 	};
 
 	regulators {
-- 
2.43.0

