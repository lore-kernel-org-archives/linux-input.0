Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795432743;
	b=YcoTWhKTX1UetuMNXC+YmQKhWl7VpSSVCK0OId0bLPefuAeMHfCpq79wJqDqe86JgnkF
	 xTaGMdvSW+LcRrM3HAtywqBZeOzrSJvqyzbO3w75WyqjdzxwFLLN7l3FQkENChz5EKQ1j
	 3pWTUwu8AXo8nZ2z1gp1y/7KwVLuiuiCyH8bsYLdZS2xLkc9Ku3om5A8tUEDQ9TwIsxI5
	 bnW4kHFbOvdCy/pfP2c28CUN6VdDSQ86pnroEAbwZhJ99YNDf59nFBopU7yi9Vgnhkvdi
	 9/KpSPTroct2YmJIEy++XHNW2DnsJLUJaYMweQj4jdSy/zbE7TNjXMFyuK4O4GpiUag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795432743;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=YQ8N9lrkCBm6g5O+8A22MhXclICDJr3w2WLdfhFanRo=;
	b=iUSm/gnOzl69VqNeUI6s0Yl9PRIhwBbfKx/KlUw48k5OaJPvZEIshZ6HxnxxMjDGttQJ
	 RW4eQj2puwqLi61BizyrzPzmvm1jdKRFzGRevtDtTtsXEQ73vo1h1vOVPDgtkIM5vjnK0
	 wDSHtx0DpzPganSVTGYKU5mA54UH3LwB5kQbxAteCu1hOeJaV9MqP8JAkt2JcxoLO1cHB
	 F9/NQIjjpWvbIITCLXlPnLOrYNeRXw72RwgtZIRUSHvhtsVq/UbPzPuD9BOQqHMy4uMSg
	 pEQqeLJh9rG6UAPUFqm3QRvtcIi3nZzDWCsd4lThKKgWDLHehFBCvLvml9E64CejMFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JK7SjlHS;
	arc=none smtp.remote-ip=209.85.218.53
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8428E606A684
	for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 11:19:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8428E606A684
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JK7SjlHS
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c5126505cb3so398557066b.0
        for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 03:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795432741; x=1796037541; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YQ8N9lrkCBm6g5O+8A22MhXclICDJr3w2WLdfhFanRo=;
        b=JK7SjlHShqGKrK0MfBGja0a0+74eIVz0GikP/sp5w8+YnuWmehFbl5uiXQUjtJ5tiv
         tW2CXRUpyk7pKWHsifd/MUE+XHb49uhymcmyVz5d7wqN06KCa8HiFfLD+tRWDGplid5J
         lnDwwrCR3VsKX3Yxc16haWUr1L//I9LYp4XX/wkMBgZGlsyBf84J4pwNww6hnyGnd+Hu
         zMOgQk4NgPVyI85Hy+cZCo3R8HqtGjI+EoM7xtjaSUqiTDPi9nbBeaWxE02L6A8QQC2S
         ZYtQ36mx0ABEdHAAUuiQiYaBuO5AlXK+BFvFoojQxooRVUvAtKnl13KkH7qn6sxgkzAT
         jJKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795432741; x=1796037541;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YQ8N9lrkCBm6g5O+8A22MhXclICDJr3w2WLdfhFanRo=;
        b=G8wBQi+KIczC66o0XqtVZr/emxl5odZh0cWcQpZNZHIEav5c/vK+9qGt5SnU7Qqm3t
         g0ODAZLndFRfHvfL0Pu52E5uj2TXvEuFWs3DddXb3f1M9s09ZgFA2KO6aYqL6mxscCEj
         hhm6LFzlyo2bfXQbEN0RRlaZKrXGl2fPwwKBduia/hMSJMH2xbpdanhECQwhdEGb2daH
         dQ2MIU9cC94i8W2wQYN2zbcDJnAQvelgUCZS7Q9QR0ef8TVJ/DP5p8YGoAWocxtxmhad
         +57dvaNg/h2WRzCGQR9vDli1w9P/HR4ABpUUaj8vhD9PLYlsoSduh26ts07SERojWh4e
         OamQ==
X-Forwarded-Encrypted: i=1; AL+hErGFGfNxVoY6htmnA1Yq2JM31cBZgxC/aiM8gUS7XZQXkWH7JSMYi8vBEDYPKz812+1O4Y1c+6b0bfsFbg==@vger.kernel.org
X-Gm-Message-State: APuU4Z+gZwW/aEdoHmxv7wdKZJwPSJlXYvXU8+RY1BMhxcpFVS26Ag3b
	+/VlK8oEjiCPZQRLzwwxhvZXhu7pEAc43FhRNaEf8Eu/ovEeBO1splLt
X-Gm-Gg: AZFdTZf4+KSPSSvDkjQThmMRhESB1L4to98VBsCSH29aYlsWaH6M2DEiwPgXdmJr4OS
	bBddLm9mMWgvu4+kN8HF/vpJFO8pLOMUtwYIHuu+uPCUkiOtCcxlk7HjyJ3qS/aaM8QCc4ozdVj
	ufAPmCc5nfWvV+6HlIHyhfG4nJYH05snsZRpmCLJGzxtQP9yNuwPFcKUodYqEkXFa8DXT260XIk
	/9H2r4q8rD6q/2WCkSl00IxpKDPRNpGu0oXESb/P1iOHEEm2YHyR2IkI2Jud1vbqGvpo+cR23M0
	LsfyD1xSl2xWBEh6I6bgqtRDhgH9/+DiYCJZj27mCYCmrFenIN+Pg3dvoj7z+mV6UnkRlOnyUUB
	peVujr3f+yLOZL/H3HCrgIiGKuuetrY7WNDAj0KN6oOQ1DdyGCwQXZCVZRnrDt1wGDvRK8Cl9hg
	GtTadif3RFNDqDCY1t3gd/RLEFyVDJDQdEpSih5qrDKnQKcEKPWYCAg832hlAGCL66cvT/ND9+Q
	JqQhD/RxRKt0W2ug0J4BOMVxEE68LxNuFHyhy1DiANRjMNfGuzsjR0c7NhyYfCLZL02AMqCx8PA
	IiCfTn6ndJ9KwKuXdQ8vXHuEACNI2/1CKkhir4QedIvVoXZJai8364/Hn2uz/RK97A==
X-Received: by 2002:a17:907:3e1c:b0:c51:53bb:8d70 with SMTP id a640c23a62f3a-c5153bb8ed8mr586385266b.16.1795432740595;
        Mon, 23 Nov 2026 03:19:00 -0800 (PST)
Received: from [10.120.183.232] ([50.7.123.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513afc679bsm392442266b.63.2026.11.23.03.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 03:19:00 -0800 (PST)
From: Alexander Letuchiy <asalde.le1@gmail.com>
Date: Mon, 23 Nov 2026 14:18:34 +0300
Subject: [PATCH v3 1/7] dt-bindings: arm: mediatek: Add MT6895 and Xiaomi
 Poco X4 GT
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
Message-Id: <20261123-initial-mt6895-v3-1-95c46597e63d@gmail.com>
References: <20261123-initial-mt6895-v3-0-95c46597e63d@gmail.com>
In-Reply-To: <20261123-initial-mt6895-v3-0-95c46597e63d@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sean Wang <sean.wang@mediatek.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kees Cook <kees@kernel.org>, 
 Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-serial@vger.kernel.org, linux-input@vger.kernel.org, 
 phone-devel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Alexander Letuchiy <asalde.le1@gmail.com>
X-Mailer: b4 0.15.2

Add the compatible for the MediaTek MT6895 (Dimensity 8000/8100) SoC,
along with the Xiaomi xaga board based on it, which is sold as Xiaomi
Poco X4 GT, Redmi Note 11T Pro/Pro+ and Redmi K50i.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Alexander Letuchiy <asalde.le1@gmail.com>
---
 Documentation/devicetree/bindings/arm/mediatek.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index 26f096587631..13e5c31cecba 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -72,6 +72,10 @@ properties:
               - archermind,mt6797-x20-dev
               - mediatek,mt6797-evb
           - const: mediatek,mt6797
+      - items:
+          - enum:
+              - xiaomi,xaga
+          - const: mediatek,mt6895
       - items:
           - enum:
               - bananapi,bpi-r64

-- 
2.56.0

