Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794596869;
	b=WCDUFv+RoM4adumX0vYpJ38/bNNVzQ4Wepe4JhvjTXPCBJBA38GX0twoAS/oznny63Om
	 RZ9qzmRXSYOge3oLGrQM3rYjrs/JEEK9cdH+ttf+MCeoy030GKzQLlkgMbxu6eDUX3OWB
	 4Gvlc0p5U0I2FAEBjoOOUWZEFVYaBIYsstLx0o21OLxeNDIAOnQTQOjeJlRJrxYOM+2Pg
	 rnG1Wp3fFu9PIQhOXFOt8nEfF+VskxjdcpaKC4mHRga3eCNUOQGFPA1T/ssoJEOhOnEmZ
	 4Hrcg3djmsCOAzGaT66ivfLpjQhOMImSX1L06KpnQZXoBPRmB+IFckI0pp9jA/Au3Xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794596869;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=EtVDEEY+1Q2B+PJRdO/nFO/tm1fJ8wXwnQSpYA2WKh8=;
	b=XwFHZ76Yl6AKriWNlfjb9Og+nLWg7u5H7oQG2GwV5Ptr/z1MomTDGBQh8btP3Qm4ihJ1
	 dHF/VwAuAVahHMMWlHjJTsrwEvRGMrK9+BYy1LCXc2uFlFNk+XUw0eR8BXDF7jzFzsV1b
	 LhJV0nWLZOhDXTXJg2alJaV/oklcuJ/4p7wA9QH82/pQCw2jtcq9KPCLWfgEVHpJH/UxH
	 xEwCBK2rc8RI7+QlHKLxi8b5Uk3xBmTXlfUu0lkeeUWALYwFTnrRA9hJk95u9FUSkhV9X
	 V2HbwGRT+AMmIFswJb2/j4lmzHnLdX9CBhXmZDbThLwDlHjepmnquGckNqxGsSMHLtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rE2u3Ig9;
	arc=none smtp.remote-ip=209.85.218.51
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A97E606A8BB
	for <linux-input@vger.kernel.org>; Fri, 13 Nov 2026 19:07:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A97E606A8BB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rE2u3Ig9
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c4d58c50743so237587866b.1
        for <linux-input@vger.kernel.org>; Fri, 13 Nov 2026 11:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794596868; x=1795201668; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EtVDEEY+1Q2B+PJRdO/nFO/tm1fJ8wXwnQSpYA2WKh8=;
        b=rE2u3Ig9QQmvYdO4meupm38R07509KcJIbOAEE8bkGwjMEOVzVv0JJLzRE37Peidsb
         smpNCeOpTI7ROICLLY5L90EV6xSGREQ/ui4lN8ruSeUYnNG4G3X9tiX6tmBDjD4S+rmA
         EJ+gM48JWQjmSoetmjwKebkBu1/6kW1rn3mdQb8JgRGM1t922TkimGEZMcSERFZuIPXi
         452eL4fN1PQASGBc2YGLxX4d6X09AtHZIOSnl2GtlrSWA8UO0+oSOyfyLdzIXzzzqMTS
         vEBgWlzFFtez3312Bw35huiUspC7CzTPnn3dJJdqQugkUMAD1AMnk+Aob0x4KYw0XNBZ
         gFUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794596868; x=1795201668;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EtVDEEY+1Q2B+PJRdO/nFO/tm1fJ8wXwnQSpYA2WKh8=;
        b=sOBpfaxfOctB51l/ZbBECDI//wDmEHirDBN81fvevcrvRtDjBaISS3uT8Q2NgRFUGu
         v+lNMKKecOH6BTNUZko2MHQaDyDqC/jxWHos0ITDZrS9RO24ZLVB3hGAJXRN2Qs3hcpX
         pIRwHEIaOAkYUe+rF7j4iV7obqnWPvdqdo5rUSZY4l4k08PttsssLoxM3ghNeNr5KMWg
         Wo7zvFS73dMkefYI86OcyZSNT+C3qjkZG00IDvKpF4KZW4gb1uK39tpudivjur0CUdS0
         HL87aWKWsa8h5mCnn93MpenyfWuNZuqYXYJ/qgb5A+OQht4cBsfxy97xs1Ik4ks4xv84
         GLTA==
X-Forwarded-Encrypted: i=1; AL+hErFbYVNpMdn86xv0+TN8UWzkIKMUHM9xzxDdLyeY2YZ8begKIg6hiPgk259vOvq14nlh069wXyVp3AwKfw==@vger.kernel.org
X-Gm-Message-State: APuU4Z/ecQuAWxpqcCAr/4xm5sC7dWAxpiL+jQYeQwAuXZp3gx/k++JC
	2WtLbUy6xwE34z8WvyEbykt8p5AEY1D5tga+ItRv1OyHGWu49Vt51wZV
X-Gm-Gg: AYBFou2vRi0IJy5Np1OlBHW70FOwDUxgZf53EoiUNeRZG+KxkGK/Qj0pW/HN5K4y9Es
	dSwu1hRU1CM9pKcbRTMkk0/9lqSPmC2I//93BObk61S1o133lmQTdW5XwA5VrxlfGT8F6IHkNuh
	Til5GGnY1UXhIHBFllZFLwrhfhPnz/oqwk7F63akq+m0HFq2Dj3C4Mp7f8DdrxjJgka6IYRooCD
	61o8f9rXFI2clE0LR/ykByF1uqK5saj42ZDOUQXweTFDp5dkPqnOY/ecNWGMwM6/Fb0LWsATAcB
	8DloIlu1FPIsSnDuEVsw0hIQ2kHPqqoPRoKqOmh9bNjmkOEvuRJTjshe4RR0TaH4gOSTzDsfOxF
	MIQc2VaeFfUQS0Yk3T84QFPhf+b7fFYFPwcBDDaGOpg2zD6xxYqMuAtV1JHlu6UbjQc5Isx3x3e
	CGHcf+ckvzbaqQlaoVfCsZzQJJedW/yWAUciXX4zBqwQ8PFcPtD0hP043LiUJYk6yQAA/Fi2orw
	yPzkN1G+9/ZKgc2z09FEGooOPhGdciKf2coA3Uk8hhwWzx91VJJMAF0QLsgbr+avnbUUpwGhN8s
	vpKIulCkMYJiEw85qxb0uDL6JnumodhFncNiU6EaUYX6lxtqSH0Kk1iBt9TkvIVi
X-Received: by 2002:a17:907:2d8a:b0:c40:cee7:3918 with SMTP id a640c23a62f3a-c509683f389mr411823466b.44.1794596867571;
        Fri, 13 Nov 2026 11:07:47 -0800 (PST)
Received: from [192.168.1.100] ([163.245.50.16])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b23b09sm129444166b.26.2026.11.13.11.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 11:07:46 -0800 (PST)
From: Alexander Letuchiy <asalde.le1@gmail.com>
Date: Fri, 13 Nov 2026 22:04:58 +0300
Subject: [PATCH v2 2/9] dt-bindings: serial: mediatek,uart: Add compatible
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
Message-Id: <20261113-initial-mt6895-v2-2-4ab0aa9fa391@gmail.com>
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
 Conor Dooley <conor.dooley@microchip.com>, 
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

