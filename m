Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C853DD536
	for <linux-input@vger.kernel.org>; Fri,  8 May 2026 12:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778244811; cv=none; b=q5FxsOy72HPx3XaJSwewWupgNNSKybry1sGFOx65SEUkfApOb0aANeo4iNuX6yiV3BowI18wT8a6P89ANkxTPEIu3YiEsTbo491pK0UqRjR90o70Qv4booHWYzk0XJy2y37U7D/JsuSmiV/07UjBQj/SJ++hZuAnB3eMwA08Ofc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778244811; c=relaxed/simple;
	bh=mBgePVtH8KP/YKm5cr3Eyl6uZOeX81yQ6wflLgUtcGM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z9yWmFHkiKdIwJOKfIGNzKdkc7VQivqeIxLl08EKSwfh32UVA3oI7JrXTuEk/9JRAj1JdnssNkHvFQ28s6rTuMnrJyfLm3xocwjyZkoEPHHXWzaFPm6cB9kOki7w49c0eY14qwTl9U5Z1tQh1vu5oQtVk16bOgFgspHvwaTXs7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=mbwRNt+Y; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="mbwRNt+Y"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-67da63ae541so3324353a12.0
        for <linux-input@vger.kernel.org>; Fri, 08 May 2026 05:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1778244808; x=1778849608; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2tjmcAcW5PrkABseVYIXfoZIwvpSsM/t14LO/QfHcsY=;
        b=mbwRNt+YM2cROsdr40YPiyuI9t+Z2lPvmqRVQptuo7vVCVGxwP2gZpWK9kLw9KpwXn
         SRNeaPbVh88tP6MP7LnrVADSDW3RsQRCcERwk9xODzWi+sxuRQ96PsBNyJVfqsNhHAol
         wmqT67drVkF2XEBMLRijIQp3m05B3wsiRiMwAtfF2At84jLCwivZOekGBBlm7KERcv0v
         QL/3sA+7Vck6fget1FNpBasQa3K/bEOM5xZ0BlJA28QohZhOfZctQnNiu9HpbMiK3sec
         H56/XsGCeCHOpeGZT3uZyFokjNSwjGKTGbIrmmd/hEjYG3BCwJBB2/800a9hJbLKLtJG
         ssbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778244808; x=1778849608;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2tjmcAcW5PrkABseVYIXfoZIwvpSsM/t14LO/QfHcsY=;
        b=lyFDZrsTFFra1e8BM+28JYWOv2NsfWpWeT8mBw8Tg6sgm/AkzIt37Pm1sXQAeW98pW
         NmnqhPfuW+Cw+DiKtBKEI/LTdz2oi5v5jyEpBl5UwzA7Dp1fhPSsbV4VswxzdvgfAs/T
         ieJx9cM4oAYnDSKzfY79Oj1nuqiDYeSSiLEWzH6XnqppM/bgNtyzU0/ZkXeNtM3JjP84
         cvYSFgIVSvXPUUqJiaNoZniTtkaO31J6sUxPykNJapqKrZ5/+Lkb0UFmm24uzxLXDfC4
         p8WnsMYx/josEI7CCDMxfi9MlXRU569e1Oc76xrFWaoPkZ4AROONuP5Fz170i9KIXlVk
         yL/A==
X-Gm-Message-State: AOJu0Yy3KqSrFg6GdaVf0uDtqAJaFC/OCeUaEFm7TFsFSH9W74s+DWFn
	PUy2wXfDpUQ/InQI8s3tor+UBwplQnE4T5r2IjEMujh72P65DXpN7/iqY8AQsSfGuLA=
X-Gm-Gg: AeBDiesBxfXNdGQlX9qN0iUMMJdu/8QPOSnTNY/h9nbAz1Gfdw3ZW1p/OqjXNp44on5
	8Wx21eQY9VU1A1V+Qq/vNcI68EOhgSyMAK1eFGJ0ytm9pmFWly2UwXuR1Ue2bhBy2q08P/tQN76
	qFEiLkgTK3qWGFKrSSX+lwqpFQkZ/GANlbPQVNzE4t9yul6dwdvYPKoEPiayODS4CPYQsglWZsI
	mjm9qFrptRAPf9ZdQxprGFdWDQxPYOruWK2sN59/RiS/fKTljRkERwWCqANggezWzDOmR0N+jLV
	DleNCdyU+8mIJPAWP6hQf1DBkVAjJFf5+QDOAGWs7UeH5oHr6ihzQREavVO2lvkvyiAaqV6BXNP
	uEaHH/2LtGm4+AbDdM/S+hjn72ECfJWersJBAJ90OQqBbifjjMPjzDcNg+pek7EHnmJPlPC0h1J
	muQ5ZZCQhVmPDPYxvRW+29axTz1+bdCPHEPqlAQ2acrpl8KUG76okoa0biVyzxXQTQImIIkMcXu
	ja5T6Qr4w==
X-Received: by 2002:a17:907:1b0e:b0:bc5:113c:1b55 with SMTP id a640c23a62f3a-bc56af25895mr720284866b.8.1778244806334;
        Fri, 08 May 2026 05:53:26 -0700 (PDT)
Received: from [172.16.220.224] (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bcb94415c94sm800266b.53.2026.05.08.05.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 05:53:26 -0700 (PDT)
From: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
Date: Fri, 08 May 2026 14:53:14 +0200
Subject: [PATCH RFC 2/4] dt-bindings: input: gpio-keys: Add vdd-supply
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-gpiokeys-vdd-supply-v1-2-0bb32e8e6428@fairphone.com>
References: <20260508-gpiokeys-vdd-supply-v1-0-0bb32e8e6428@fairphone.com>
In-Reply-To: <20260508-gpiokeys-vdd-supply-v1-0-0bb32e8e6428@fairphone.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Luca Weiss <luca.weiss@fairphone.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778244804; l=957;
 i=griffin.kroah@fairphone.com; s=20250804; h=from:subject:message-id;
 bh=mBgePVtH8KP/YKm5cr3Eyl6uZOeX81yQ6wflLgUtcGM=;
 b=WddPCLUCCtWRzxnRp+iKtWZQgqxMpRDewJw5kUnR+eMEezJiWtPHBRZUNrMrmNDpdneL2eVIb
 j7idWog00kqBtVZd1Kg4LjLn4llJmw/T24cMRtVmL5m+JHAwt4miMGq
X-Developer-Key: i=griffin.kroah@fairphone.com; a=ed25519;
 pk=drSBvqKFiR+xucmLWONHSq/wGrW+YvcVtBXFYnYzn8U=

Allow the use of vdd-supply regulators for gpio-keys. For example, the
Fairphone Gen. 6 Hall effect sensor requires this functionality.

Signed-off-by: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
---
 Documentation/devicetree/bindings/input/gpio-keys.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/gpio-keys.yaml b/Documentation/devicetree/bindings/input/gpio-keys.yaml
index cc78c2152921308fe0cad3e29ca78a5fad08f066..9c5ec1e7d0fc7ea236c161c7bd5a041aafdd07a1 100644
--- a/Documentation/devicetree/bindings/input/gpio-keys.yaml
+++ b/Documentation/devicetree/bindings/input/gpio-keys.yaml
@@ -102,6 +102,10 @@ patternProperties:
           which can be disabled to suppress events from the button.
         type: boolean
 
+      vdd-supply:
+        description:
+          Regulator that provides a VDD power supply.
+
     required:
       - linux,code
 

-- 
2.43.0

