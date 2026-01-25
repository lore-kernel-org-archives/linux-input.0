Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54C6322527
	for <linux-input@vger.kernel.org>; Sun, 25 Jan 2026 13:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769348598; cv=none; b=tkAuKv3c2/ggy0Stgt5+w5FZvNMd824HGtSF59bhB3Rx8Vre7qCAZpSZ08FA5G+MXbp0z9//aq7puDDyCVX6T1UOfO0Nu8eC/cV/lSA7S90glHrq7wIotu/7MAB55ZuToWic05HPM1sRo1wgH043yqfdnfNqHjXoI1pjl8+LcbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769348598; c=relaxed/simple;
	bh=hHWILRyUU54F+w7k7JPriQ6DmoCAg8TcBCDlQKA/teg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vBr6p18c2LOk5SF6LGGpZHtgo1PZuDEsc0laQFjObNi4fyHtjBWJ2vvZFuGmfqkYHNSDfJt5LYUKZRmXZyREACtiyyTlsJ7QWYOkvdVaRSagDLK2XRAXqzVUIqwMb0stbQ63L808OJyiEagJGvk+51J+Ywvmh0dPg8zVDnycH08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KkkAQa8p; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KkkAQa8p"
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-43591b55727so3537792f8f.3
        for <linux-input@vger.kernel.org>; Sun, 25 Jan 2026 05:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769348595; x=1769953395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SM6Glg7veqcWlsyKtZF2bdqamcvshEMVFBWJQkCFRkQ=;
        b=KkkAQa8pk+K6A4UYfw61ESplTSO1FwqHE9aWvDVpOPFwJQUIV+ln1LAaxk9fNgE+/R
         YhbIncZI9Pw98gLno0610Y7X0NQoHNoQ3lHfnAk0iibeXhmb1IPqq9KG/c2Zf6n7Tfwe
         qN9bfojsh3di8hOMJZFAS6w6/EzcXzB4Ee/+VZxVQN6vlvLxwBcn6zaNniQ/CYEiTmtM
         0JWww2zno2CHh8zFkVEJQtdgqYqIPwIm19S8s+kbceNAumA5ImVckrxzgGXsOcBSMdId
         gNJKd9WT2DQGKHYKDbBwrA9RxSpjEeVvgJCCofbrCLUI+79fEISSdkb4VOWNcucjMD/K
         Ou5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769348595; x=1769953395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SM6Glg7veqcWlsyKtZF2bdqamcvshEMVFBWJQkCFRkQ=;
        b=IuV3xzILPL8JdVvLTs2nkKeo0P0os9Xhcske/tN9cpkWj5mm5Qzh8Se/OoEt79bWBw
         nWVrCRBNgxzIWU25E6QX0lkoqUtCfWuZMKnV7xGSmjUS66O26ianQpNR0hSIUgkcq+zM
         A1nYN/gokIUvE190A5EK0Jdw6O/2cW4+ngXWf6wqZQKmkCcGlIdpadll2C//J/brn7b6
         24q4G9pHHuVzO/ZXRh6nQ21iCIvrlKselMsJCxpCDw2hIxmKXB0QkJTVJHTl3ebI4WZ7
         7w96LgPyn1bEGMKSHWaFDVqdGUFbg3LKDuEz6kLpcmQ0xmZJi0e48TqsoutCEAV0PG0k
         MXog==
X-Forwarded-Encrypted: i=1; AJvYcCV++ug0zy/dyw7P4cnAQKavqyd4Df9nZBf7sXr6mdB40z+sqUr4qndYVfDqmvI9Xa2AS3VhI6udmfPxbw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzDcONCNm1gSLpjld1aWMDZ/9H1PSeh4UIt6Uz7CEtq54+Ooo2Y
	QCEe1AkIx89djUrJsEiQ/FAoreMwFk8hNc3I0gDYCox61sOTFRi8O+Lb
X-Gm-Gg: AZuq6aI/RIWthFtEX8il2LduCHxMINuuxLav3HpBcIsRz1H5wz2CL/T3hO5CCiDMLSV
	jlmLbfWtjA3n7TRGZ5Frsy1KSig0PEfw23GFWRBccxVqDtHkj0M5YP0BmzKENHHfqRA9Eq5icZo
	mHcxyxgz3qdAce6tvjQhkVZHqbdvrxMvx1BNO3fshKSC9sJnhcrZNAKKk/dvtzIWmCvUa6DlhpE
	LGCpP8O0g87nfr4bwEF1q5S1EU8u+ZQNO33CVvKCA6SGD4F+igXfomTyA8IfNlP2+OsDtdEQ3DF
	9XznRJpRxanFjfzQT9QIa0XKHSQ6nzap8Jk8wEPvcWhCr7izZngbrq3/cz+bSMH6Pr/FAcClmz5
	pWJCX1Shx2FxnvqBPBVdAVUuOUrF91qZnUjHwzXmII3FxlhRdyVRe03sxLe1um1KoV0kkvpmLUY
	fy
X-Received: by 2002:a05:6000:2506:b0:435:b020:30a3 with SMTP id ffacd0b85a97d-435ca39b3c7mr3408860f8f.54.1769348595045;
        Sun, 25 Jan 2026 05:43:15 -0800 (PST)
Received: from xeon ([188.163.112.49])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1c246ecsm22459688f8f.10.2026.01.25.05.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jan 2026 05:43:14 -0800 (PST)
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
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Dixit Parmar <dixitparmar19@gmail.com>,
	Tony Lindgren <tony@atomide.com>
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-leds@vger.kernel.org,
	linux-rtc@vger.kernel.org
Subject: [PATCH v1 03/10] dt-bindings: iio: adc: cpcap-adc: document Mot ADC
Date: Sun, 25 Jan 2026 15:42:55 +0200
Message-ID: <20260125134302.45958-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260125134302.45958-1-clamor95@gmail.com>
References: <20260125134302.45958-1-clamor95@gmail.com>
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

