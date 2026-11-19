Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795096491;
	b=smZUZD5ZVnEmIx5MBSwOpSN11lAkFqCKEFZbDRx2KjmlcMpQ5ovs6Xl85D8/4MlAsBLF
	 ZoYe1ZEgb+E1ZTB6jOQtxWFPZNVKRe4VgCDw1ncu57Wqaa9mRhWWuB0EorcKkttYx2Dan
	 nphlCdQO75uq2eWL0ZozUNNC1+YAzOUnn/ywuiJHP8Zsn9a88ZplKWNBkxkCZ2yEuFGpj
	 R7vJ36RHOIsqmtwQFp25K7i0fScTziK4I8VYUBdHLFHAQW1rVpTPQ4EnZ6kBlzSIXLcdH
	 JKNXGmX7F9uoRDZ3e2NzjTYF+ttUKZnDBBjUDazctRR2D4PaUl/pA4dMaRhvo0707cQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795096491;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=kcyC89VcgJaq9jLzeow2xIThvgwDvibG6R9ei49uqAE=;
	b=yipyBRK/Ofrj3vUx2WnT65EoPvsNAEx5+yeCLUv70Vv+HT60Na2pZcrg9rkIpruIMSmt
	 5lWKURCKzGuUYaCIr6M0PBJ1IA/dVbeP4xcj+kULkJXxVJ6f1vKOKUyjdzHtlH4b3XF6F
	 WqYuTKntyG47OfEaJdf/mcO5zaHe9VwgwSX/F+KM0/IwW+HUPyKK5RcenCh16Ld3WbUCW
	 JqTU8X9fQTiZavjZXzkVPturNGFnQUc6B5QJQ0OSsvCwAVipwG5RmVuyU95+6qZCW/rV/
	 tCFygDsFPjfcJMocr2tNgZs5wOBS5iKFcq4LkizWhp5HpQkT1bB7rY7Y5RpPjuyE2ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fairphone.com;
	spf=pass smtp.mailfrom=fairphone.com;
	dkim=pass header.d=fairphone.com header.i=@fairphone.com header.a=rsa-sha256 header.s=fair header.b=CzkbAfVf;
	arc=none smtp.remote-ip=209.85.218.44
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98319606A32F
	for <linux-input@vger.kernel.org>; Thu, 19 Nov 2026 13:54:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98319606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.a=rsa-sha256 header.s=fair header.b=CzkbAfVf
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c40f29667e6so361605566b.0
        for <linux-input@vger.kernel.org>; Thu, 19 Nov 2026 05:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1795096489; x=1795701289; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kcyC89VcgJaq9jLzeow2xIThvgwDvibG6R9ei49uqAE=;
        b=CzkbAfVfuTMH9DbWALI6+24aNSL410vewuZjg8g/iiflXbhSEOsVBZYEhDMPItk+cF
         m3qogGz44+uj4Xy3jSTD6cw8uBwULZd4ff/DR0Qq8erSuGAbphuU22CTgfppDb7poxMa
         kcZWvHoUCZwSeBoisZR8IiLmlrnlnaj22Q8uaLQl39qcOJS/DnsiqPlSUwG7O+g3MHTG
         jp5rmeHGevcqBDtP6/0teWStMtqH65EV4WAG8de2HgbHJfKYIwiOR3cLu+bF9byANmrm
         PbiZvMMBm9Z5DSfKlMCvzmKlN6DUZIUS0aJ3zrqKbe7G4NpPfW9cAVvuTmDZUwaT6GiW
         hGkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795096489; x=1795701289;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kcyC89VcgJaq9jLzeow2xIThvgwDvibG6R9ei49uqAE=;
        b=Y5WIX6VunK0IHnR1g+5yOREBmOwyg9w3S/Y7TGnUpuHdTUbHTftI9HR4PXBrafLYRJ
         pLbKOmfjCv3/GJtSqSCpW8v6LRkRs+Q7bxvxWQrC0vZMUHI+7vJsPE0XcxbL2j4imZio
         2PqQKOArA7bqHc+cmifSsGJQemyvhw8ehy8ZAHS20cmoGYVsTiT8n4s6X+23khYUWSdI
         1VBz6LfodrIkMnz8rPnL37z+kOffjLPpkq6njIpy+V+7IiHC0EcNy4aZvpFWF/hyoEnu
         e5zp/FidVyYCopbq6h4pWCIBdlK6A1ttnVAKIr/cDLEjqmh7LSTmLqnXA8/W//FbICXU
         TFrA==
X-Gm-Message-State: APuU4Z8pTfW3jtvYqxSR3jGA/jNeQzRUVFK+LL2XvSF8z++6lGJgfxqp
	AQMcS5QF2St3vSupOoEna6nUc+GTqWB3ZXsTarKo+zsfboxvlzF5ZdkMN3AtLVz6BcelcIHPq2A
	Hw+JWpf8=
X-Gm-Gg: AYBFou0Lmvo7Ld8iFCn9Ji9rUSFvyBwSu/RzGKRzs5yQEfXtSd58RpKQASvNfZTUz4U
	K5DwzKy2ixGyuZ8tyK6OGL/0vXri6Yt7kw3Z4PuY8HhN18fPRMTKsDr849C/SgJFV5uqNNkRL87
	Ueq/WZcoazdb89ZX5DkE/ooW2X62zqXuLKq25K79IPByCz0fhOpIEEA1R2ksT9/7amx3u0SmNRI
	iysZ6Rv+rxJspV9LAFn/7Gr0f8Hhh79qwK8ejgSrUj/SVZGSqfVXu8oKCtP+kuK61vSNn+ZVft/
	cD0LlOGaQ9/+5rdxkumc8rS1gBlkTD8QxNjNhBubmVaAbsXDlnXnP3SkIZ+JFn4Q5JZEmX1C8P8
	s2riWtH/QdUQoFhX/eH/tdh8JKDh8jYh8BmKEJ9T+T87fqveJ5fYn5GfkZ7pT50i4NDhbG8nblY
	6kiWq0E27DvHjN/zXDGmXMZFUoZip6WAknfNMveCJQY7GnPjNHlRYq7v8W0wFyNPFOY8wInllzA
	2mVU+v/yglkdj1pPsi0O8CUcVHR50OC5yf1jjmZyfSYalsa5Rh3zf2zdGKxPH8+nUc5b5o6W/u3
	c0E8P++q1EQF1paZY8jyuXAjmjF+qgi5vBjrtPsquoTKwMiweNc6m4wPsSg/WZnQ+M1VZUg390c
	9kRqws8DhuOY=
X-Received: by 2002:a17:907:7ba8:b0:c51:638:7838 with SMTP id a640c23a62f3a-c510e4c7dd1mr563619266b.33.1795096489051;
        Thu, 19 Nov 2026 05:54:49 -0800 (PST)
Received: from [172.16.220.224] (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c51233c4d02sm106820266b.21.2026.11.19.05.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 05:54:48 -0800 (PST)
From: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
Date: Thu, 19 Nov 2026 14:54:45 +0100
Subject: [PATCH v4 1/4] dt-bindings: input: Add compatibility for Awinic
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
Message-Id: <20261119-aw8695_haptic_fp4_driver-v4-1-9d107334bdb2@fairphone.com>
References: <20261119-aw8695_haptic_fp4_driver-v4-0-9d107334bdb2@fairphone.com>
In-Reply-To: <20261119-aw8695_haptic_fp4_driver-v4-0-9d107334bdb2@fairphone.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Luca Weiss <luca.weiss@fairphone.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795096488; l=1122;
 i=griffin.kroah@fairphone.com; s=20250804; h=from:subject:message-id;
 bh=GrcvT5TdUs1hjWk2qQFIg31PeZXjjwY6F+gMZ6FifVI=;
 b=9iEGoh/iygzIfheMi0lAKt+cW6CY3GzwX02Jl0W5iSz4VROo5+c+FVG8va0LjQyfCO9k2Un/w
 1U9q7pnUdn2Ba8uA+xMr5SfcxXZ/wZoV0chaBuxb1PqjQEMKMTECuml
X-Developer-Key: i=griffin.kroah@fairphone.com; a=ed25519;
 pk=drSBvqKFiR+xucmLWONHSq/wGrW+YvcVtBXFYnYzn8U=

Add the AW8695 haptic driver to the binding documentation for the
AW86927 and AW86938, as this binding needs the same properties.

They are not compatible though, because the chip identification works
differently compared to the 86927/86938

Acked-by: Rob Herring (Arm) <robh@kernel.org>
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

