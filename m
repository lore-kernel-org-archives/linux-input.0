Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792660761;
	b=yt7h61hY/h2L9gTVW5SYegKCEiD/eavjvbTJ5wvLuf7BAMvsNJ/FRYAfv5wWnZLmiyzW
	 Fet9KwEyedpcaXhbjiKl4s82Ov3pNM+4aYBiBGzywyxn4SF6PI3obrkKQzJQfcFjEEFGt
	 DdH3Wr40b+Vi1kZqRIkFdMYMnmpAEpaom7xj6y21Rbf/hjNUPKiBbOhVGmEUCzOTyvc4z
	 bEkggvwuxwhslJBiX/Zm+5YeN4LKd2V7XEeo/6ryAZ7aiATWDbvtgxUX1QhbXX3k8m4KL
	 2CXUT5jXkWikgpowRwQYyBPaVgJ/miE3QevUD4lwrSHpkrzltxDKuT5+yVszmMcLN4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792660761;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=XmLU67b9anSH351lrdK4RsIBICbIuOZ+JS/MULhXqf8=;
	b=OO8uah/zWKnkOIdddi4t2h0FMFDHcfRnunJm+A4TBmZiQ0BkdVOqZIqcPhqqVrYo+r5P
	 2I8oDSCkyNbVfppNHF0gCzktQHGru/qBwizCqKFFNU5YDSBIKSaQSBI+m3lobjy96wJkH
	 kyqPTlqpC6BGMXFPSYXYka+q830RE+EmY5SFJCdAUugwgBh9IfHrhbFG3sFryr3ERiF0g
	 8XjqS1Arucxpn9m/Qahx3hB7qcmsFyFunOQ2Ay+qil3SOAO3TMts1wDnMEkSDYOp9HcuX
	 GVrbakJmoWpksQRACjzKPSwJ8Ew3DHXR52jweCgtkkyvkymgn/jtkGbHxYhD4hXmT5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fairphone.com;
	spf=pass smtp.mailfrom=fairphone.com;
	dkim=pass header.d=fairphone.com header.i=@fairphone.com header.a=rsa-sha256 header.s=fair header.b=eerU79Dn;
	arc=none smtp.remote-ip=209.85.218.50
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205C0606A31B
	for <linux-input@vger.kernel.org>; Thu, 22 Oct 2026 09:19:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 205C0606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fairphone.com header.i=@fairphone.com header.a=rsa-sha256 header.s=fair header.b=eerU79Dn
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c414e5d282eso202322366b.1
        for <linux-input@vger.kernel.org>; Thu, 22 Oct 2026 02:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1792660759; x=1793265559; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XmLU67b9anSH351lrdK4RsIBICbIuOZ+JS/MULhXqf8=;
        b=eerU79DnBIXSgkNX9XH5RvEx6v2IJwgHnx6cLavomh9+/x0S0S/nzMd/T8E7dX5dGX
         bbtHQZvIpitzL0W2/wWvPZYaE1stMzV+29nM+scZxGiDqIbP5ct3kZMfLVmGdvgsDGAM
         qTXoO594N5NrexjsKhZU+5ozQ1D0AepRPEgqXRUE0d6jdwLDQjge3ObyOjSciuomQF18
         NLTywnjVXikcxzX/HLHwQNIfxSfEmelm2GR/sVxIWNlqOA+t18EL2+jjjEEblZ+i0g+V
         ec31CyLmK5pVAGSaUmSO0UeJTDfwc7hSoqr19PSe4vB87eSLN8ud7gV8Zm4TIBkK17r4
         imTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792660759; x=1793265559;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XmLU67b9anSH351lrdK4RsIBICbIuOZ+JS/MULhXqf8=;
        b=Ju0keaRCh0Am8JUOHp9wi296a8GGqGjytEwgY51XuTXHAxOhyFVbQwwfKGk/68SMrY
         wyqDKd2ZhdaC2QeQRLEywTOSQrj68lETOHlv4BfFruUbuZYPJ44uoBbsMAXlE1dwdXIr
         o0qlXSkKiA5amcRSs2dFMgEg2BoC3H8LHfQ1VJCaUGwNKoh5ZeOus1wzG8mo3iCxJwMp
         pC+c8dlsyrwd4n07zUKtH/Pc4vpZd4ZB6sgC7x0+gWHDWhH/OA7yNOgf951wLn/HC6d9
         f2WgYkdQs0hxB1UHsC5hqV0xBnWkYI8tKXPwc7bBn6e9M7kWdVTC0tCh6eTfz5YnzQyh
         XGGQ==
X-Gm-Message-State: AFq9FYJLISBAP5LYEtjPLAlVZ5HXe9DBryX99sKdVgQG56QrhihkdrrG
	QS5l89uUXcZV5MupXBBohkCEPYtNvTRMq4RxPj2nFk12AsmAJ5W2q6RiGHJO6LctKi0=
X-Gm-Gg: AYBFou0j663lewjHa1ecBd05yVhxT8XYS02EcgSrWb62qpdQdGq5abcG6PX//Ad9BT9
	85X+pM/xp4pGIOmw+RX5aFWT7d8x3zyQmCqI3X1IoZomArtg74WXRLCt20SDkr7bY1PZFZ30DSl
	NSNHbXHsRqxPRo1e5mzpewUrhPGtNekTQ3+phPEz4KGwobPPVHDDIZ+EWKLKnNU8t5rLd/q51+J
	V9PZD6dwX8p+8fWKJ9tfZHMk++bbK6FneQgHY1b33pZJUiQmXGfX1JVTb7PhLu1L8vHnyB1m8Yt
	oatJcsVWuamWGUmrcHvIot5Uj7xxfNgL6YJ9uB9osVjY+lMfJYL23zx3/xqoX5DerCPHQfdUkU1
	ArBP/qz1Ju5O+JOkKjGcsLP5qI6zFLsRmDoiR4TN0eUOMO1/npnpiBFCgbZ6LJJ7pORa5nnKhj5
	WxJ9X0M2qiWssnpQx7jB8s7dbPL7SDCxppKHd9ThrEjti8zseyKU9A8KKM+5KPpOdHmVcJovdXj
	jV9Weakvq8NMWadheobrL5cQYy/cqj4ndrpnYFtfT7LEUxjUyCOCOsRsCKm2df6Up+ZFD1nXfI+
	PLQspw6z6JKFP8+aMiyxVsX05kKnlbrvqGvfNwMV0lU45UsA6tOrJ3nMogPKgcMUGLbj98QDjM3
	c1v33+xlMcJKrTfO4YxLLNHj2vBaiQrajgtuqZlm/uOO2J6WKCDcVi51IOmjVRHz6lFZr
X-Received: by 2002:a17:907:9711:b0:c2e:6498:5bb7 with SMTP id a640c23a62f3a-c46796bb426mr444488566b.31.1792660758671;
        Thu, 22 Oct 2026 02:19:18 -0700 (PDT)
Received: from 2001-1c08-080f-fd00-57f9-c36c-aa93-fd36.cable.dynamic.v6.ziggo.nl (2001-1c08-080f-fd00-6fe5-b143-671a-f202.cable.dynamic.v6.ziggo.nl. [2001:1c08:80f:fd00:6fe5:b143:671a:f202])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c468a50aa01sm85790866b.22.2026.10.22.02.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 02:19:18 -0700 (PDT)
From: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
Date: Thu, 22 Oct 2026 11:19:15 +0200
Subject: [PATCH v3 1/4] dt-bindings: input: Add compatibility for Awinic
 AW8695
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-aw8695_haptic_fp4_driver-v3-1-ac8c14377e82@fairphone.com>
References: <20261022-aw8695_haptic_fp4_driver-v3-0-ac8c14377e82@fairphone.com>
In-Reply-To: <20261022-aw8695_haptic_fp4_driver-v3-0-ac8c14377e82@fairphone.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Luca Weiss <luca.weiss@fairphone.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792660757; l=1075;
 i=griffin.kroah@fairphone.com; s=20250804; h=from:subject:message-id;
 bh=zMc7fnFtbUBSVjfmEWHaUyV/0ui2OWBr6T8F5VhNG4U=;
 b=VeVZAjOe4nh9A7LEj+L1Elp95Otpjsl/9uITlARbofk85O4zyU4uaNHE2dHFfXgq0BYw4byC4
 4vmCiqOGmW7D8nLkwe/t/3Aex4MoT4fYW6/E2SJVdNGCJp19WAcmA9T
X-Developer-Key: i=griffin.kroah@fairphone.com; a=ed25519;
 pk=drSBvqKFiR+xucmLWONHSq/wGrW+YvcVtBXFYnYzn8U=

Add the AW8695 haptic driver to the binding documentation for the
AW86927 and AW86938, as this binding needs the same properties.

They are not compatible though, because the chip identification works
differently compared to the 86927/86938

Signed-off-by: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
---
 Documentation/devicetree/bindings/input/awinic,aw86927.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/input/awinic,aw86927.yaml b/Documentation/devicetree/bindings/input/awinic,aw86927.yaml
index bd74b81488f61d72b675b5701b321b30b3430be0..58908ac4ca7964f63e392050aff5e15e836983f5 100644
--- a/Documentation/devicetree/bindings/input/awinic,aw86927.yaml
+++ b/Documentation/devicetree/bindings/input/awinic,aw86927.yaml
@@ -12,7 +12,9 @@ maintainers:
 properties:
   compatible:
     oneOf:
-      - const: awinic,aw86927
+      - enum:
+          - awinic,aw8695
+          - awinic,aw86927
       - items:
           - enum:
               - awinic,aw86938

-- 
2.43.0

