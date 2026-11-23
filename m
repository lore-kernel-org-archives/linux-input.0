Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795432746;
	b=jWMC1IeCYpC88CiH8qOznznZAjUkc53Ffd1S1W0cuRe49pJJ/0/6jLw+ov+zVYnytBzg
	 lGav8mFxEzxtuni1Zss5Q44ZO628djL3eDkyytlMm9QaUen94EUAoPDc4yOWk27NccoNq
	 ME5sgTEja6ycZFh/nfVVU/0dLUTJXOcoa7U5eyYF+uON/rTIf++B1qEUfsMqP0v8aTtax
	 zFQc5TZlBQMAKdBV+p3Dj1S6Kt3DT25MJ7IkiPH9fdQadIezu0ATFXFQKmu5qawUtjPqp
	 vE/6gKbiQC/KcJsZVmnnxy6DKHA4+44TsMjfXIYAebrc6cYPK5qUF+P7OlmmXu6Gd1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795432746;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=EtVDEEY+1Q2B+PJRdO/nFO/tm1fJ8wXwnQSpYA2WKh8=;
	b=vN4Vmtk6x2HdAYdEos2eNu9dMH85FRXhlop7osS2uxhlCvks8Pi8Yej/ge/PT9ljn6/n
	 f6HLF8g+cx7oIgTEDP35CVAzz5X2oAmApJGrRlUS6O4OXtQbBAz71Al9t6S/JH8NczoaK
	 biip0M4+lk+Y9tHtR9ay9DkGv3BjCsMAVN4NbmM8tspGWEqHXdRe4BWtPYYg9arSvcewM
	 SMTg+xac3pp3GrImvn9S5JslL2rOt+DOGcxKqi6DUyEXTTbsdJ0yqoCJaC8noJ/qNXCHH
	 +AGYpBdA2XXvCawTlTF8NwV/gExj+x4+lOSu5xNli1KK7+RIQWFqfL63Of/WXhGz1vQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VfIg7S0N;
	arc=none smtp.remote-ip=209.85.218.46
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A735F606A6B3
	for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 11:19:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A735F606A6B3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VfIg7S0N
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c4d28f75d62so522424366b.0
        for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 03:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795432744; x=1796037544; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EtVDEEY+1Q2B+PJRdO/nFO/tm1fJ8wXwnQSpYA2WKh8=;
        b=VfIg7S0NyjDFiESdcciLc42EeZNUHkJFW+yGCnS+PA5FOZnFbalkEzBPwAkLuIayTa
         eRr83rB0tVsFoar4KBae9dFGYMZVX68eI4RjOO0yq+tVzl2VhYKSok73vfwwVjZbSg6H
         d6ewwLont5tR6xs0d8c2QiD02Y4M2y5Y02DebZ/RuAAl5cc1HPD8id35r3iMfrsLug4z
         MijCMWgZ2iXwVRvzNp7hJH2BQXLmLsLnSHzmlnWqZq/sjECnDCsociBw6WQ2fZU1z1KX
         zmfHulnVN2dQYmRqS/w3NZULcuK1a7Ac/Y7lAXMV9j+jf3FA7SbDfrxoGfY3rN+z3yX2
         SM0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795432744; x=1796037544;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EtVDEEY+1Q2B+PJRdO/nFO/tm1fJ8wXwnQSpYA2WKh8=;
        b=tbFTralQv35y3iDIRXEhYoUjnEMzCAAYPFSKk5woLUDvJiJY2QnUGZqMWFpYzG9IKe
         aLw0urszM5ZGrWe+RfiM9gqq73C1Sn6QWckgiq4QhGBv24TkGkUR9t3fXMtgie5BRN9M
         u0hvS4/jz8NP4pI8z40DFrpo2StWm08TV6W+cEDGH9HSGnkpahcS5IHrpOYnqZzymBW6
         MCrLkz9yyNZrpAT1TtIR3t3xlmrebeoU3musKVE5KT7uZQvYCBBjmpuiXSD30E5QIJah
         0RngVVqQ6BOJ55HKmNMNJbEYYp9NItzwsHip5+d1etFhBXAcfw69aroUdVPL/tsQQNuD
         9RvQ==
X-Forwarded-Encrypted: i=1; AL+hErEUg0YQyivX5sJfR3Ikje5jJoI6MIu3IqTWc/n/h2HqW31jVsjzf4uzbv00/D8Zz/nFYVLY8iJZ2aC5pA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+nlpzIYxRsait6QNhhobndWIl/c/jz1rCwSUvFkTKTYTplgJcF
	PUkDWCw7NNJbQy2oY8BApoP/5ET4WUr4NqFmWaZgBlWJhkoZkKPGZmy1
X-Gm-Gg: AZFdTZeQ1PNVIWk036Xg9MpZb1IaexCXaVHgPYzRsBmWaOTQ2+YFfmvhRFELYsfvJBF
	uwQkfVU0uUuHzdbUCv5VNfYvbiR7DliDwHGWtLYPVXGk3YGqDY86XBFtVe0RgvusK9hbGgmDwGV
	UmfeecAbqsKOtN0zcqgb/+d0UUpFnVgHuHMjugoCgrNPRknO5kwVTwiYb+LgltGthXOjAN0X/2l
	28zDad16ytwv2bGW0f095BJ1u0GQ0aDQilaXvjuiCVUQj8jt+YjSNR7b9v7vJtdLBZzr97mCIrG
	K2goO6T/Dx7QvSl/M4V/IKWcUlK7Np/2KvHmsFLGJz6TqdRN/6MGUD/xsQ9KQSbqm81R0Ir3wtz
	8I5O15gvOGyRlJ0g1YmbAnTth/UQpo7XNpvZTULxr6Bkfski6OCn+gwOe6rgtaSpgBI+A2puUYr
	exFyaJDUkAUq7ZZgUOcmAUrlxbMnb2dTRD5ittCbcKEV/lsmnMws72lPZ3ZiutsrBVdaKXywgT4
	aYliEKl4VGywcM7RmNO7n2HHgiBb6MPw2SeOrd6blawYyFmeYEPOciMCg+OpiU1vReRtRl03MQG
	Kvx3a7q0IPRMtJ5pVPOPsPg2UGlaCBWeHNOVkRCb0ZhUPtsmnZ3kR40tfS5y0+rsOw==
X-Received: by 2002:a17:907:948e:b0:c51:3b09:f7f8 with SMTP id a640c23a62f3a-c513b09f8eamr826376566b.25.1795432744060;
        Mon, 23 Nov 2026 03:19:04 -0800 (PST)
Received: from [10.120.183.232] ([50.7.123.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513afc679bsm392442266b.63.2026.11.23.03.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 03:19:03 -0800 (PST)
From: Alexander Letuchiy <asalde.le1@gmail.com>
Date: Mon, 23 Nov 2026 14:18:35 +0300
Subject: [PATCH v3 2/7] dt-bindings: serial: mediatek,uart: Add compatible
 for MT6895
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
Message-Id: <20261123-initial-mt6895-v3-2-95c46597e63d@gmail.com>
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
 phone-devel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>, 
 Alexander Letuchiy <asalde.le1@gmail.com>
X-Mailer: b4 0.15.2

Add a compatible string for the UART of the MediaTek MT6895 (Dimensity
8000/8100) SoC. It works with the existing driver through the
mediatek,mt6577-uart fallback.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Alexander Letuchiy <asalde.le1@gmail.com>
---
 Documentation/devicetree/bindings/serial/mediatek,uart.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/mediatek,uart.yaml b/Documentation/devicetree/bindings/serial/mediatek,uart.yaml
index 5bd8a8853ae0..a3969cfdea7e 100644
--- a/Documentation/devicetree/bindings/serial/mediatek,uart.yaml
+++ b/Documentation/devicetree/bindings/serial/mediatek,uart.yaml
@@ -35,6 +35,7 @@ properties:
               - mediatek,mt6795-uart
               - mediatek,mt6797-uart
               - mediatek,mt6893-uart
+              - mediatek,mt6895-uart
               - mediatek,mt7622-uart
               - mediatek,mt7623-uart
               - mediatek,mt7629-uart

-- 
2.56.0

