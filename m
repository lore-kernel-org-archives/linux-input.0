Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99758392B88
	for <linux-input@vger.kernel.org>; Thu, 22 Jan 2026 19:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769110595; cv=none; b=Msss89iwvM2R0jns/2qIVtWZbRU5bpalzdR2hRcz1Yb8YItjGGg4qwzHLZW3trrT8eLhFVRpohVc++bh7MQtKtTqNLWXwrTYIh76+aJPGusYP5IdQr8LidLVn8a0Ar82+EjBvYv+KOQQbDJ82D+n+NngLqAoUsOsEkdK1bWpxUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769110595; c=relaxed/simple;
	bh=yDihcp/jd0OMfi2PU3Gn+hOP4VhSsBYD5UizE3u770I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MHPY+Z7JMHMHiAqWoio/EGlamNHcdGOw6f+eKPqGWjGkzT38FrCbbeR3xBNyodLcQyDSHawBkUb5vc3RI4ool4+3BZSLEsyg//OIVp6nRI9+bU3mScPrNCeFAM8BTcZoLpcf6tfrvWhHd95/DVZx06AlzTrKTLIERG+fIn33R0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VXr8kV0D; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VXr8kV0D"
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-47edffe5540so15577915e9.0
        for <linux-input@vger.kernel.org>; Thu, 22 Jan 2026 11:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769110561; x=1769715361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7SBABkPDPX8GYWi5QA3maCVdgfUpUsCKkHw/BcpYjfg=;
        b=VXr8kV0DDgXl2kcQ/ehPv3kVxAtrRaTafSLaIlzzt9V42/QwbYP2F6ukdCrD8OdVe/
         Joj8AelJpKiQlYXMLW17Uolf6FkrmeNr/G2fZfNbnvlQOsMptt83+bZxnHNDtaEDfdAw
         xzEieOGMG54xOHogtzVD9he1MUo3AkQ9D4h57SwGrOltLPtrSqNT+tKl8fFlLEXOb6WQ
         5xOJ6VP5TWqYnf03YlIIJ3FELhiep7U2YohsY+Qi35qyqQf8CvWsFT+ad9NsSYFbaiC2
         PhP/GDqUDouM9q60s8pdEZl9aw4nwUoAknSAlawpiEyAucvTsq5DnQceLQvFehlRPQLG
         4Kww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769110561; x=1769715361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7SBABkPDPX8GYWi5QA3maCVdgfUpUsCKkHw/BcpYjfg=;
        b=PWq+AngpfuIBHCi8BvHE3iD5IFrlE5kWK2lNQQy6GUM4IrqhByKfT3+KtDKol/KJ/H
         UuGixFbKdZjdAII8R9P6U+Kb7ifREAQgLF9nLhfIYDdKRehYeE6mZvHHswmnfd795eSC
         hcFlfy/VqpQqur0dgcf2F7E7L8xmFPouEywzJs35ho8XL8NBt7IB2wZ+Y+4FxJuXfotJ
         zCGOcgsI9Y8p2FZi8f5UK5Zw8o5nbkqCiBzH6k88AtO7G33Xk9xWgDwA3qk4sTvJKOba
         v/83bCGnlN2q1RoY7/8tpAgpe6RQAyom+SAZpxOhiUaI1dK8hvpxyhJoUpaDKOz9xkoY
         7GlA==
X-Gm-Message-State: AOJu0Yxo95NJWUa5oxcO4TwnlqrBWVsFVjV1IIxIW3qmri5rOIB+p7TU
	Ogb8U5CS7Qq2upMbe6unOndU4q3XA/6Q9QJy1gKgyup0FBp8SQQjpHIf
X-Gm-Gg: AZuq6aKqsvXEw5y1X4Mwn2WseOIpJ8MW/cfdQAFQcLXZgjqgGrvfPiZdOx+aEMymuhM
	eMlpbxgb7fnlsKMxWqQFwzGan2hu1VG61grtgk6yYjBayBSj0uBrWCkkbnn1BJ4gTDSQLFx+mTU
	m+RhaBZ8711D0kkbiau7dgIyx1xGePp0E1V/cZImJYrja8wgOkuyHt+Yq+b459DrGQkYE8nlSZL
	fTBw3+Qjsi9qbw4JDjIfd1g20Rk4T1qhtKUkFID0l8squpq9YoiL19fgeu5MC0OkBy6UaYGaTm9
	Z+CSGYYMAd2ICduAb9my+GkwN9dWJGOL84+qN/EaZAagC54IRGOF0WP2GCX+btqr55NT4YjtSW6
	SMlJcas+Oe9+h7hhGLVVdDPbBQuS8FhLf3QLcIjpOCbs9/mAKTdZcw6kk+IdAkhfqUKwfqoeos4
	oE
X-Received: by 2002:a05:600c:4f4f:b0:480:1dc6:269c with SMTP id 5b1f17b1804b1-4804c9d00b4mr10024235e9.37.1769110561252;
        Thu, 22 Jan 2026 11:36:01 -0800 (PST)
Received: from xeon ([188.163.112.49])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1f745e6sm843027f8f.33.2026.01.22.11.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 11:36:00 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Frank Li <Frank.Li@nxp.com>,
	Fabio Estevam <festevam@gmail.com>,
	Andreas Kemnade <andreas@kemnade.info>
Cc: linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/1] dt-bindings: input: touchscreen: tsc2007: document '#io-channel-cells'
Date: Thu, 22 Jan 2026 21:35:49 +0200
Message-ID: <20260122193549.29858-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260122193549.29858-1-clamor95@gmail.com>
References: <20260122193549.29858-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The tsc2007 can be used not only as resistive touchscreen controller but
also as a ADC IIO sensor. The second use case requires '#io-channel-cells'
property, hence add it.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 .../devicetree/bindings/input/touchscreen/ti,tsc2007.yaml      | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/ti,tsc2007.yaml b/Documentation/devicetree/bindings/input/touchscreen/ti,tsc2007.yaml
index a595df3ea802..d9cb53e86512 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/ti,tsc2007.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/ti,tsc2007.yaml
@@ -53,6 +53,9 @@ properties:
       how much time to wait (in milliseconds) before reading again the
       values from the tsc2007.
 
+  "#io-channel-cells":
+    const: 1
+
 required:
   - compatible
   - reg
-- 
2.51.0

