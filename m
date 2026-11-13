Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794596878;
	b=mK4DXdw1evegIvANOWtRXLy4ZIWy/URdR7KaMNpcYDWr8gW9cWI7Bdl77O+AhcvrYCNa
	 Q8/5RDTOatBgMtTgxud/7/WCxKsQ2tm+OUHj+rVb26hgszWKCaeqaZ7xXwd+1cqTFOFOh
	 Z8V4RtyEP615p3lMnM06Rk33e+6B3VEVHL0w7v/FkiurBcdlpvOhOdEy5M8BgY4xNsAQ7
	 aCjnAMBaskcwwrROnDO0alV0LQFQij8RJ9KUQyeP22GGGNxynLGNqJ4Xi+c8wJuhk1/hS
	 tE/nU/GFOkAbS2x+btIxJmzbOEuiLqgppV7ucBqEv1KNk/7Jz+mRJetOzYGWx4vkzsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794596878;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=N6YWRmQiNd60ef4bLmQcLELuCtQOypOA2hMcEuSo1Oo=;
	b=IRwkl5jX3eItz4S/jcaupkYhZS03EYx0RcLTx5D90ynvV51GUpTMYTVONZV9F0zjyVet
	 aQ+CcFEO6pT3feQekEqBt4QhUoOvuHHgo4TxQ8Hp7ruAU2dj+IryArYtzeKw0vbzWQrjA
	 5klQYyMyr2L/sIEn9oHrxY9SA7BAHmrlqHlJwJa61nUu9Dlkq3YlEz2bQ6uCCnVK+U8Ld
	 SGp1RxWTdOHIJexXNNwy8yDu/jonOQsB59BLQWoFEaHeugDv0tO0B8fg7Lnm+XzXLkpye
	 eW8/fBNrbIQ2Jc2C7gXJN76ILb8xRRznu6wFBTvprQLyTfcOfbUWBfH+zNIbJmNKvOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uwGcGaPh;
	arc=none smtp.remote-ip=209.85.218.51
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A36606A8A9
	for <linux-input@vger.kernel.org>; Fri, 13 Nov 2026 19:07:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83A36606A8A9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uwGcGaPh
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c4cac7a7d3cso226832566b.3
        for <linux-input@vger.kernel.org>; Fri, 13 Nov 2026 11:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794596876; x=1795201676; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N6YWRmQiNd60ef4bLmQcLELuCtQOypOA2hMcEuSo1Oo=;
        b=uwGcGaPh+BHfex7icC71WkfRYapSs0f9axsnDYJawncCBYbSymIONXbbByTOPA4Mxq
         +CThUvi39AO8kULxSYQr/f+xw1u6F1k09nzML4VhxmzWUWhRKrEMjgv2KeZZ3eAFw3EN
         g7LeZJ3AcCY9gsAwwTotWDvhn77KU5DIk0XZo5qBTBt4xvbvhUhhurEHQNLnQmTuKPSo
         g3wdA9Q4hQLuYGgtlW6F0M768H8c74wm6DdYrw8qOGQklh1OVG/IizczWWSUvUDEXMee
         U7hP5vy0RVUrnqMXRViuaOTkZmH1czb4EuZQoMFrl6qOh/lYG6qVAfp8IGf+Pu3RD8jw
         gxxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794596876; x=1795201676;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N6YWRmQiNd60ef4bLmQcLELuCtQOypOA2hMcEuSo1Oo=;
        b=1hYoCCIJQz2VieU8digD+CorIEs9jXBinqOZ0CO3bLhNSIZkD8h+lIk+Djc+SKa+j+
         UL70jfFFclsAkNS4ge0WD69ErgkkwgfbOYg1DdF6JnxTuBj4SNkrFcKslvP2d80Ov5QH
         HwkT3FrXXVHpRJJsH9qrNilsfDJbHz/rwAeUsW5A0Ce8V6vFE1o4vZtlbYwfpYBN56ob
         yVr+NFmGfDTs2lu40xItMTANYAcGVY2lY7p2B2ElJ4nYA8BTZVEff9BV5nmFCE0QA19t
         z4fy12VPq7C1qvnr+jw0EIqY8gWKQWPHSWDUILGHVxfCT2PFnEJTds8XDPuER+RWfZUT
         TmmQ==
X-Forwarded-Encrypted: i=1; AL+hErGDBvTqXr+2qqz7agRQiRkF9Y7P2xNnkdaMAlZFLGil4QubFYJEe6pL+TVVYiph1YXNdKtHC7y31K7AQQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z82dJnzolI5eZHY2ZEfm4kXG/Jb4vPZkJbY4Q4viB468hASg9IV
	DevzHh3CevjL1erzSRCsyJMGoGr55DSLkjDGCYz1bdFzn64pkjZEiBZt
X-Gm-Gg: AYBFou2v7S170ppfRJsLOISQAaTdDlfolh3B1CU/jhaptUo5lCEwYez/RRA2eRsd02R
	kr0AetdaK8jxF1JBh1O5e9OB0iU3buh2g/kU/EXa1DKrshMmoRJHznu6PVgBA+Jbgya5N2kdeL+
	gERCLJgnZ+LIYG72TVt3Zn3MOT4ajWT10gXMEJobWsrEgrROtFC/wHouydt9NDDb7lOPQOxQo1/
	8T+r+2Gi8aIP6oMU6EneOkAT9Wpx3J9poY6c/oJYHhbsOh+a901WRK05CIy3dLMAlmSPUG3n4Gf
	Qef9/4OTPBYcF0SQjkSs3DmPwbq7nTXfMLc3E7IyLEiuIS4/7cbCp7mz7IBtJ4OxlKDRr0lhizN
	/ZovphO2ltyX/q8sLSyBNsTIyHfaMmpJVRqKSQg1xuOc230XN0Zq9egrZxkRxzlNWuEblofgvXv
	QcMfWGbz2++S/scm9igL8rzb1FAP41kQYRmUhw/D1xXXndG5mN4dfWa84whwrllHBgwCU1Ap+PR
	QHhG1M5K8JTfzTY4rz+r2npoCwjtDmOXKq2SpwQTbC8A1n5bgBqTmEhQv8oI13dbJJ3WUuCwBgq
	yyiMDxN4JG4izm1OOzOl7Qqdt/PVclXyil4ND7QYMxDqKmxIoJQlYPWGA8qpeXJB
X-Received: by 2002:a17:906:4fc5:b0:c2d:c739:30e1 with SMTP id a640c23a62f3a-c509643c050mr336353966b.32.1794596875807;
        Fri, 13 Nov 2026 11:07:55 -0800 (PST)
Received: from [192.168.1.100] ([163.245.50.16])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b23b09sm129444166b.26.2026.11.13.11.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 11:07:55 -0800 (PST)
From: Alexander Letuchiy <asalde.le1@gmail.com>
Date: Fri, 13 Nov 2026 22:05:01 +0300
Subject: [PATCH v2 5/9] dt-bindings: timer: mediatek,timer: Add compatible
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
Message-Id: <20261113-initial-mt6895-v2-5-4ab0aa9fa391@gmail.com>
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

Add a compatible string for the system timer (SYST) of the MediaTek
MT6895 (Dimensity 8000/8100) SoC. It works with the existing driver
through the mediatek,mt6765-timer fallback.

Signed-off-by: Alexander Letuchiy <asalde.le1@gmail.com>
---
 Documentation/devicetree/bindings/timer/mediatek,timer.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/timer/mediatek,timer.yaml b/Documentation/devicetree/bindings/timer/mediatek,timer.yaml
index 337580dc77d8..ee4af54c29b5 100644
--- a/Documentation/devicetree/bindings/timer/mediatek,timer.yaml
+++ b/Documentation/devicetree/bindings/timer/mediatek,timer.yaml
@@ -40,6 +40,7 @@ properties:
       # SYST Timers
       - items:
           - enum:
+              - mediatek,mt6895-timer
               - mediatek,mt7629-timer
               - mediatek,mt8183-timer
               - mediatek,mt8186-timer

-- 
2.56.0

