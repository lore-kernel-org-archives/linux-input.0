Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794596880;
	b=YcKMrA9YFU9x7yM02wz8adxJDg1x5SukZZa+0EXVrrMoRuEVXVXEkn0/BJ56KFqUxAQT
	 CnHG5DqMpLvXsHxLSXGWHj/g0G8iv0eYxKg1mAlbj8vT3E/KVqJQMF6tiu188RqEPEsu2
	 hvpSABdexnio9wkg2R3xssuGRUwoeMc5aH6tKunP0ybJ2Qyw/ZYmxLPpXeG4nQ8JgjDgy
	 rrqOTy/3KZWXCGBPoOig1Ks1wNOlD0paBICdkBzK5yGb0spVyfp2RqVgBjbQnnccD2LF3
	 nX2aeNCfrk7pktzv0cyrYQs9HBpe7mLOHgn3XKb+EHTjpylHQ6b1nQaLqqysPuS3vZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794596880;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=XeIdUEn41huggshJVY5dteXJQUSowVHL3L4Q/+1iZEE=;
	b=VZSe9/6sbUxw/Trhrlb08LFRYxeI/RCYpQ1FdjWWYv+op0oNM2fJoKs+omgv1wOeK+Xk
	 MopCA9fB5clfSWK95nzBjSLKaHsY7MBnw+HYLz9mwLvDMyAnizeYDchyXTo/IzE87xwq1
	 TOo2q/IL/q7YGt7dz8XDm160IG2WDFPzHCVqY9LDHB1fFK+6S4NdgpDyy7MmjyWvNBNUF
	 ZZP5cxBIBNit2X7i/HQwhymGjqY6kOFjDQ6ZlvJZ7NYj6H1x6HzPH92VS0XTdqVYr8nF0
	 ka6WUeRSqh1h+3YeFqXaewpVMdtpowLJlqalFiSembIkTtPPpV817qE1vm3P1D0k+bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=abdJekNZ;
	arc=none smtp.remote-ip=209.85.218.53
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F3B60A381B
	for <linux-input@vger.kernel.org>; Fri, 13 Nov 2026 19:07:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08F3B60A381B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=abdJekNZ
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c4682977f9aso268051466b.1
        for <linux-input@vger.kernel.org>; Fri, 13 Nov 2026 11:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794596878; x=1795201678; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XeIdUEn41huggshJVY5dteXJQUSowVHL3L4Q/+1iZEE=;
        b=abdJekNZ8HxFrzNGohRBeEoTf/523bitcDzqsMoXfu/U4MopGkOP+b8MXZ5tWxql83
         +H4idS6CeHAz29Ea3I8Yr8DkY2D1+ljIBctRuNZ1EQHnxCBrrSzbgBs4xgLyJVibQTIQ
         LYPvOHevrIg4Xv1JpSAMiLR37kb9Qq0S0VvubHWWazdzfJLS1TikFNzYi8HMMVqCOQbI
         eKti5JdPJe5aXqzgfLGy8UYM3/T2YWQ3JRtjF20hkIhmgBcvDm4bRhNg46dcYztv2oc6
         BEcFEfaaFNumUsm4LprF9aHBwJYDZeY8ItR+D6Dw/wamqL2ToslkaAQt7JXd/JPGbXXY
         Xx6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794596878; x=1795201678;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XeIdUEn41huggshJVY5dteXJQUSowVHL3L4Q/+1iZEE=;
        b=JqLCRxj38jIB8OWR+4EZrSvWl6305Skcr3ck5mGVM1TEIjpEigCHIMGtNhwKYQS5Ca
         xwbDhjlQ6SM9O9h69WR66MhZiZzXvYo/RgWOskhZ1Q0FV/qSJ3dFVbIODHOIitlqKjPz
         vJWdDwng5l0NSevP5mM9hqAxtb9y48Tf2x519iXrw868bp0AbI8DcnQ2PeFO07zCitIu
         kFe427KiiIG0oXM6mXlsYauOmE5Xi5F0hZaYQ9ygk6ZuGbyEsPksXSi+lImoZh3RmSXC
         nUDlDVDeWh5/L1hBYMh6PLOv4V9aWMRnzTTDB99ODQ+c6EW7LQz2t7p1POLb4JYJeLw7
         HJYA==
X-Forwarded-Encrypted: i=1; AL+hErE6DFgDm1cOaJfR6OqHOGgZEyaa+4U8Xw0glC4gx7mrsYMIlnNWsc47Q+fDFh0mBs96IPww34jB9AeiwA==@vger.kernel.org
X-Gm-Message-State: APuU4Z999IVRW5s4qTOtvlxupJWH3v1xx937nOLLCWU4vKn00WELrWeV
	EX8UzXZwvBYNVlcInwpnfav00FHGLLh96/qtZMJpAHZ38jGtGzX6C8xZ
X-Gm-Gg: AYBFou0Dm4CIL1Nl3LPyKb9xRqkVKES/0traUWoIy3SJ67+qzi7UqA3i2wxH0W12Zlj
	44H9LB97duc3hM8hWsX47RzM4Sj3f05tptGYmKHYy2+yGT75vXFrtj/J+V0R/T5oMRGEo8zSM6h
	mav53xeK0uVbEODHA33KngBDlFzWXfPa0GOtWNeA1SAtjCPGXr/KBfROfzy3v2kAdSn+t22/c2K
	HeVX1UjMkWrhQtHa1a0LduOoewujGlEyHpCH7qSudlCqSqZARSOVUQkukX2NafAECWOXA/yW0Kw
	g8YpjDOldBy1XFHBjAX4eGvBxgLwfRFYWbtDAdYWZ+CpxUrUWqnNGBS+G8yz8taS/OckvkHdrSO
	zt1cFEmBgQ2TNDoAeyvdWSbjicmgQVDb5PO3MXAl7Nkom+mss/Ft9cZDJ6OxcnS/dp7Vyp/b4Fc
	2ro7hyn80ortB9jS6OyXppU2BwNG3DogGJQ/twgZ8O3IX5en9/cNfIWboblipXyvFltnVyA9qLH
	dKqT26cqDBG4OOfGjG6pTOFr7rvpUaVhuCfzkIhN0zHRFpa4I16SOHnj/B30PmbheE8diHIy/mS
	KnctAJ2jbXk07o9XxmjM3RpK/pcXj8IlJPeDTGImC3ezMkOkXGCMY7Sq1srpqgH2
X-Received: by 2002:a17:907:2d89:b0:c46:8063:220c with SMTP id a640c23a62f3a-c5096398047mr303416966b.11.1794596878270;
        Fri, 13 Nov 2026 11:07:58 -0800 (PST)
Received: from [192.168.1.100] ([163.245.50.16])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b23b09sm129444166b.26.2026.11.13.11.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 11:07:57 -0800 (PST)
From: Alexander Letuchiy <asalde.le1@gmail.com>
Date: Fri, 13 Nov 2026 22:05:02 +0300
Subject: [PATCH v2 6/9] dt-bindings: input: mediatek,mt6779-keypad: Add
 compatible for MT6895
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
Message-Id: <20261113-initial-mt6895-v2-6-4ab0aa9fa391@gmail.com>
References: <20261113-initial-mt6895-v2-0-4ab0aa9fa391@gmail.com>
In-Reply-To: <20261113-initial-mt6895-v2-0-4ab0aa9fa391@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sean Wang <sean.wang@mediatek.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kees Cook <kees@kernel.org>, 
 Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-serial@vger.kernel.org, linux-watchdog@vger.kernel.org, 
 linux-input@vger.kernel.org, phone-devel@vger.kernel.org, 
 Alexander Letuchiy <asalde.le1@gmail.com>
X-Mailer: b4 0.15.2

Add a compatible string for the keypad of the MediaTek MT6895 (Dimensity
8000/8100) SoC. Its registers are the same as on MT6779, so it works
with the existing driver through the mediatek,mt6779-keypad fallback.

Signed-off-by: Alexander Letuchiy <asalde.le1@gmail.com>
---
 Documentation/devicetree/bindings/input/mediatek,mt6779-keypad.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/input/mediatek,mt6779-keypad.yaml b/Documentation/devicetree/bindings/input/mediatek,mt6779-keypad.yaml
index 9f0da1240187..9a1369c9ff4c 100644
--- a/Documentation/devicetree/bindings/input/mediatek,mt6779-keypad.yaml
+++ b/Documentation/devicetree/bindings/input/mediatek,mt6779-keypad.yaml
@@ -29,6 +29,7 @@ properties:
               - mediatek,mt6572-keypad
               - mediatek,mt6595-keypad
               - mediatek,mt6873-keypad
+              - mediatek,mt6895-keypad
               - mediatek,mt8173-keypad
               - mediatek,mt8183-keypad
               - mediatek,mt8365-keypad

-- 
2.56.0

