Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE79376A0A
	for <linux-input@vger.kernel.org>; Fri, 21 Aug 2026 07:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787296351; cv=none; b=gmAZXIbcEtkavsQWtIv+32n7sgUKYgLyPkLq1YXDSFoYwJlsSm73MIlPUDHsyLczKJDKdbnB0eSzdnz/00H+k6y8X5YW+90xzhyWHm4Tikc+cb1eUG9dj4ebzeIOBU7C2s2RT8ymVpGiv5Ivoxj0DOjB1kxAYuSqHiGGION6YwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787296351; c=relaxed/simple;
	bh=tvgIcEmwbkn7e2pPKun/10FnYGAhaEA1A5qBEsJ80ug=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TntkvJ6e8FKa1o1ru7NKf5Wm8uN2KEu6NF3NcOw95l+sdYDtPBfWPINo2Uy8j/O6zgaa9GRSUO9tujbU8//XOHyF5Z+AQ799HPScy302gGivzD3Xhz8gbgNrIhuee52mCmhxd1Q1mvkdpjZsYJDEugsU1VI1UeBOiCui4jtNGEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=Yl+DZREW; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="Yl+DZREW"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c20fb91ed0fso96628766b.3
        for <linux-input@vger.kernel.org>; Fri, 21 Aug 2026 00:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1787296347; x=1787901147; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=csXrgEgazCRDtxpVG8iq7b2VnqPzoGLj29Ecu+sqIh4=;
        b=Yl+DZREWqZKWd93GDp83VegcJL2VGquXHi+e9bAzfaV4Lleappq52xBcBfuLqzh3BD
         cYoXuiYP/h94pCOaAzDQr0Wt452ajntGHxwX5USax72JVronU8pjRYOgGt1NMroO9xiC
         Uh+FGnfku7lH3fosaVsNRS4Gms0+MnPeB8ez8/ZG/JdIAMuWa/xHYOx8+BrsIHPc5rCC
         Jk1rrrGSd6x425z/Oebk4POYQj9m5WlXqpP9Ho2k3rpLziKl7fDPcVgF2/CvfLukRghN
         mBtH0HOU6fuA6K1CPxwvz4J4w2ghtuhA0L/PBCdh8OE6jsnIcWFXrrfO7Di0dRF/Tqh3
         7H4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787296347; x=1787901147;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=csXrgEgazCRDtxpVG8iq7b2VnqPzoGLj29Ecu+sqIh4=;
        b=JzPVQi2vr71zlj8/gLyeswFyC7QnGrHyfz0yEYZMUVboyFV4p/2AhPFtC8qF5yUyKZ
         tp2G6esgJi06DdX/9MVtaX4dLDHA1XYxkqwib603TZnuXZ+OCRxwatIEtDZaq5aBYMnp
         iDjKHD+d4XI1hTZQ8S2O5d+5hi1GpqX71Eg+bh8MCMTlvbywRzZ4xvTtoJIR/hnIcIGB
         YBOoiXZscV57YsHShSKv4CZd4Fdzpul2s6KXvio046QTLYHGNL3VNS54AxHMGmpmWhWr
         /SncgzY0vx3O8NGEG8ILKp+gfi9fOabPG5ThrnjR9QxM7DIyPm2t7TDl0RWgdzINzYeX
         EvIA==
X-Forwarded-Encrypted: i=1; AHgh+RpEv9QmtScFPYPV6IduhItiJEbKG0XlfKYQie/jJSYYtd/CrRfjvPKS4vQ/ZDgpUBHW027Ys3kejy9Upg==@vger.kernel.org
X-Gm-Message-State: AFuF++msKDI2gNb4z2N3WSj6+/ipgfKgQs7cm9w9qXmsk/JaiHkMFF/v
	u5o1RY4cr+Az7D4eEC6tkLJrPZ+Yk4yb13db7Xlj57zR1i7Mr9ORmyjUQGesaSnsbkY=
X-Gm-Gg: AR+sD12gfWo/+W2hSXhc0vRXcIiKLA8agAQo/vx9Wnq24OzF6E4Z6+ZwOz85a/DIQeh
	MCoDcmTvFggoDcV6LRy3Rwn8YkPE06fvw2KIJdtmBKTa1Euq2tXSYlLy5JK5QlXLPZKbDNyWAoW
	ohZ0yRa1XIkLjpaWKH2nd13xXtDR/LAl7HMFqrsoCTjrt+kNnS4r1dRgOKaLeoTBr87Bh0qxlEv
	CusfTgHgjWi3nK+n6F005+41AnNxDyCRvPgFoQr1ly1DmJ6gJotUgMepqw+7bceqwLS2NCwkt77
	wrIFjloj90E8T83daOwYi2rkBkfAfbxIKsaQE9np73RzPeeByqUgS/HJ2jeuDsySjMI0UMYY/aA
	dQfZDov/PF385eAGcmzHsE4rkRAFmdCRfOSpoAZTiSg1iX0sQANVHbAiaz3eH1JiocixAn+tnos
	xLXCvmBPf05K/+dy+1LukYiBn7qbLFhoxnaUSgKlogWn5VAPelELNTgnYB5rRsIKOJT4BYivC4U
	sObGk1cULIGUJAI6UwB41XRQe+/x28wIiYq7jrl3rg=
X-Received: by 2002:a17:907:961d:b0:c24:469d:5653 with SMTP id a640c23a62f3a-c246a653373mr384101466b.21.1787296347585;
        Fri, 21 Aug 2026 00:12:27 -0700 (PDT)
Received: from [172.16.220.101] (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24589e04b5sm339431866b.5.2026.08.21.00.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 00:12:27 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 21 Aug 2026 09:12:18 +0200
Subject: [PATCH 1/3] dt-bindings: touchscreen: trivial-touch: Add Himax
 HX83112A
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-fp4-hx83112a-v1-1-474941bd8860@fairphone.com>
References: <20260821-fp4-hx83112a-v1-0-474941bd8860@fairphone.com>
In-Reply-To: <20260821-fp4-hx83112a-v1-0-474941bd8860@fairphone.com>
To: Job Noorman <job@noorman.info>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787296346; l=1037;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=tvgIcEmwbkn7e2pPKun/10FnYGAhaEA1A5qBEsJ80ug=;
 b=5UI9BRap8wYkbwAe4UYWWdiFDrjr2MCLWHh+epySaUfuTZuusa3nS5sWs8RdUGwP9akCuISd7
 BhB+PXXHX/BBwllIwqdRqub7ah+wgkBTgqZCRFQekyjkihxPc1LYIKO
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Describe the compatible for the Himax HX83112A touchscreen controller,
which doesn't need any special resources not described in the
trivial-touch bindings.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 Documentation/devicetree/bindings/input/touchscreen/trivial-touch.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/trivial-touch.yaml b/Documentation/devicetree/bindings/input/touchscreen/trivial-touch.yaml
index 6316a8d32f39..a4b535bdbd6c 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/trivial-touch.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/trivial-touch.yaml
@@ -18,6 +18,8 @@ properties:
       - azoteq,iqs525
       # Himax hx83100a touchscreen controller
       - himax,hx83100a
+      # Himax hx83112a touchscreen controller
+      - himax,hx83112a
       # Himax hx83112b touchscreen controller
       - himax,hx83112b
       # Hynitron cstxxx series touchscreen controller

-- 
2.55.0

