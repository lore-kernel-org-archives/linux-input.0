Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5855540FDB3
	for <linux-input@vger.kernel.org>; Fri,  6 Feb 2026 17:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770398955; cv=none; b=JqeO7X8Jdk/C2yEHxnMRZzk8gpKyAW+Ca5yIzjTuREG2fpTk2onpO5QsBppmhwi4alAjZheI31DIjk8LS9fEQcjxW8cZk6i0IMTf2O1imPX8XJckTyWKTQgt3N8baaXH6HTj5qwLWHnlpwgYqiQ5e80z0y3Zh2xgdlXd2tI2P90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770398955; c=relaxed/simple;
	bh=X4OCnQEpeJBorGqYXoi+7J81mCo8rWEmlgZBzdUxnPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LOL+kIun3X1C2v6uQFb84fF7lj22tuG7Xv/BtK797/n/fe4IrCDzgJ8ZiT5/cSEUacis7Ce5HrIBcgdVdCWHGTW1T/gr3dJ2szDseSP1FH5DUEACJcrz5KXBNpagBziqQ1K92GVZ2VvKw1NvGo5+Js9yz/mSFciBFLEfdW+uvjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FAlnoLPS; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FAlnoLPS"
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-4359108fd24so1575898f8f.2
        for <linux-input@vger.kernel.org>; Fri, 06 Feb 2026 09:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770398954; x=1771003754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xxB3vH0iuOXdnI22F4EJHvjyJ371rVhhdGFC5x7FW5o=;
        b=FAlnoLPSlM8dtR82duwvTKydAMNVEJ7Bc4wOmX8xhb9085zI3CzfT5/HmfpvjLr9Ts
         Hm77f7JOfB3lqeefu/AGkeSSUKRSZ2uYBZYRo0+opD3k23ZwJHa3rzZyTuPcBGYJS6XO
         VBgy9TYCmjjOcOymRhLR8GeTOyWBJIOi2QtlmK+wkfM6gR0350m4n8RKlSL/Dmf/ONIa
         Y89qkcXLPoFNesVkYVIfSBIhfKshsuNn1dvSxmD3HA2F5h7wQ+EJCVaYAOTlBhSEAkKO
         d6FpYOtT/nIoyGY4PStK2aW+e8fg06UrBsYmir5v4vb1s7UZTO550QaP7nPcMB2A3npj
         8rpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770398954; x=1771003754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xxB3vH0iuOXdnI22F4EJHvjyJ371rVhhdGFC5x7FW5o=;
        b=v/pi5I86HQ9pCdAzcRkvIxwvB3uGix3ooQP9rnbOtMlfC0zeP3YDszYbl9HhAB8ofL
         r+d29r/kp7nlOSfNQeIuP052bsXUrOe0PVGquYP9L7FnplLA5Sw1I0WXW6bJwlcZ87J0
         7sISvfnx6zKC6O2QoBHj21wfVVfoYZUu34Yrg5L0GayVd1LYUZZvYP8ez8X41JiOUGIL
         cK/lRk8z+jcouB18GSVATqtz6US3Hk5W1ISImII4U/EZqPUnc8OeQVL/cFlH3Gx9acQt
         yB32jLtvN2qum4niUb0KGFt6YINNj/hZ16TQwLmQRA1rdsfOUS6jXy2DpouCXGZOk9Cb
         cbzA==
X-Forwarded-Encrypted: i=1; AJvYcCVVGgMo9WXaJiMkX/G9cgd4TwlumMP04juco6xcIVzVIi1xw/0ItY6mHdASbsVZZyAywtkd2vT63OhJ6Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzSCQbWRIvhF9IYChsM/vXG1KWqriUZ3bo8o/wCWCYBVQCdBbvb
	DEvxIXvxQTkcqBhJCaKSOayGM+cpR3VEevpz4/QjKEoBux/BDAB82sag
X-Gm-Gg: AZuq6aLflir1atVNi47XLWwpx3SXZY99jkExWDSsECuE4M24oRh+QCogahkQP0tR6Gr
	qANXyCyXaJtPUqHod1Z1bPrXf3Y4R9f9du7H6yZ85yaly+1Atu0uDd99B2BkmR9aMbrLh7/vHlI
	gM+eM4is9GJG951Z/aq1Ij5vAafVZ+iQ6ipJovo9jfNuFEyQqyHqwlBDjtnjFOLKmeMhngxl+oA
	0mugnU2dAgT7gtbHTMTxMFQ2+/O8pRh+ZihfBO/vbkx4/lvelTJGMgj+ZgWT6nRl5pqinioxbBL
	Oy4SJtCPVii4ANG02zMLRNU09203Ll9vQMcn8ZViFmy441OGGkU6vex2MSv4d1qlW22DLUvxFvz
	+U+95JKNAvxIVPKJuABJfsxUQeFckIMl5vueU5clfZU0QY+ZeACf3VUGKqoIXPZAYUt1oriWL5z
	v5
X-Received: by 2002:a05:6000:1445:b0:432:5c43:76 with SMTP id ffacd0b85a97d-4362967e34bmr4965535f8f.39.1770398953684;
        Fri, 06 Feb 2026 09:29:13 -0800 (PST)
Received: from xeon ([188.163.112.49])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43629734268sm6846033f8f.24.2026.02.06.09.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 09:29:13 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Dixit Parmar <dixitparmar19@gmail.com>,
	Tony Lindgren <tony@atomide.com>
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-leds@vger.kernel.org
Subject: [PATCH v2 04/11] dt-bindings: iio: adc: cpcap-adc: document Mot ADC
Date: Fri,  6 Feb 2026 19:28:38 +0200
Message-ID: <20260206172845.145407-5-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260206172845.145407-1-clamor95@gmail.com>
References: <20260206172845.145407-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add compatible for ADC used in Mot board. Separate compatible is required
since ADC in the Mot board uses a unique set of configurations.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../devicetree/bindings/iio/adc/motorola,cpcap-adc.yaml          | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/motorola,cpcap-adc.yaml b/Documentation/devicetree/bindings/iio/adc/motorola,cpcap-adc.yaml
index 9ceb6f18c854..1f77da7f8e06 100644
--- a/Documentation/devicetree/bindings/iio/adc/motorola,cpcap-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/motorola,cpcap-adc.yaml
@@ -19,6 +19,7 @@ properties:
     enum:
       - motorola,cpcap-adc
       - motorola,mapphone-cpcap-adc
+      - motorola,mot-cpcap-adc
 
   interrupts:
     maxItems: 1
-- 
2.51.0

