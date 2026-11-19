Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795095659;
	b=yl1gGXpNda4mk5/N4OMjNoVJMbt8u94goibBiJGJrfXkYX6Z47CvrCx5YULrXPM3409G
	 QyEQEC3lkr3FwntW9CdTp9Y8MIDo22n7uI24cl6VYuItgB8SLnDDWb2yrgVX4721rWBLA
	 J38gwf30aIfgzIgM0V42xT+6EXpdGl+xS7/Ur2hDD19e+n9LJ+1/uyHykT7tWbgZpD5h0
	 fRz8CwcT+lP95mg1+4moKlWs2MV3J2aL0ActPV8+QArzgdyFaQoWKvyFpkJOIGHCgxZsG
	 lR3OD1MHqpAxzNTm7atk0dsLkweBCfjBdXVtszYwYy9RDTmAorH+iFA5BU7O4OGTDdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795095659;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=PzR8EHqO13mERGH6qlAcIvdtNywH2LjT8NBNjWxU6Bo=;
	b=3JZTx8aNkf+379XNBhwC/grOYXoVvKhp4wx8IpmRyp8qq8Qo7EQ0mZl6Tni1nWcg/1JL
	 W+mTBSD/NY7Ue82rbOKHoWNDsyUMZrEHGio6chI+JHpoqv/XefgzsiAtMwVZvK2TTZpCi
	 BEdIwXuOahsiP0KUtgZ6Yl/WKUsv9aMnxdIBsgazvDvH+ChPaNERp9Hjr5hj3IKxsJqq+
	 2YIxyIk05n+C1VURxCLxiIBwnZTMzmFHxKcJM1JKneaIGQauAvYxRsOZ966wzXeEdVLp4
	 WcIwK/38qzuWq2VP4gEKaWi/YmyFj8xFmsYzLGTn4/9poSiMtslT9j46H8mXdDGd4RQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rdXZDhHO;
	arc=none smtp.remote-ip=209.85.217.46
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8017A606A32F
	for <linux-input@vger.kernel.org>; Thu, 19 Nov 2026 13:40:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8017A606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rdXZDhHO
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-7d2e1abf3eeso770637137.1
        for <linux-input@vger.kernel.org>; Thu, 19 Nov 2026 05:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795095657; x=1795700457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PzR8EHqO13mERGH6qlAcIvdtNywH2LjT8NBNjWxU6Bo=;
        b=rdXZDhHOsEz9CaLUyjruA+CqbJbKEPqMupYrT++jViMeQJVer+/hLdp+EMubbRt/R/
         2hPLO6jmI/DJfw96d0srhIN2GAVfmg6kDVpxKl+wpiGdm5wsYGvpgvo25NI8PjOYHNlF
         9G4v6Lwgnd2w4KxhZWclxwqq3WX7NdSXc518D5PN6EIbwGnbRxpqaFoDD59qentEUiP1
         IoSWZXYYYVJsqxaGYgd+TUEPswKqkT4H6Fv7bLASgh1hXoVhbTTRQKVLVdiVPFhlQekU
         9XLYGZf1mFJmHdRN82BQ/wJHuwP0s+Hr0OE1IgHt9urSwoOdaCxu+nw9jT+exb1x3svG
         OuRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795095657; x=1795700457;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PzR8EHqO13mERGH6qlAcIvdtNywH2LjT8NBNjWxU6Bo=;
        b=hA0abcOZfkVkDwDGRWvq8M3QanJFxLr2iAnWr78GiZnpeKGqrUnNoJyfHEEtXTIzsm
         gzxDLCZAA0S+KlDIWvWjc+Br5NmnUgWINbkaPYnBfI6iCuhIRxFNmslPaQEt+hBf8X9m
         DXoPT6mFhfZyN4WLFzUuzrg7zlSzWQ5s+jWg6jfc7FmGOeEDwTAqDxMcilqcZZ4jH6Gx
         UOQmn7tTbJRr0ApYHoGQOtRicNbHTqccoWeYqEcD5Jv3dejLpb1Ulz82BydPYLTavi7Q
         bvtsF2DHES9le8nV/Ekvfs+tIt8rA5KV27b17PlE9EA5ZmfZphwGT7w81+/4G3HGUJ+N
         MQLw==
X-Forwarded-Encrypted: i=1; AL+hErEJcXm/Rt1BJiCsDhEFAxjLg2gJWZUG/iSk+3XeCC2yvl49Brca87+HhGUwuQiGuAaL1qawFp/Q9NUmeA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+zTlb/3kNhbSc4yIMtxJfLdrshfYkxUU2We/vXB7eyx4HnqvBL
	T+WS5B26/k8X6XpDb3PmERhpGMX/uJy5ofbP3RKTJrQvGqswaKG+hMcN
X-Gm-Gg: AYBFou1ilFEpmqkZI+DHw5PiXu0EnyjlT9amvAHYA9NGJy97JwdNk1mMuskXWmtA1d+
	NcE1HHyyiKyzhrxwVD6Sw1MWgIK2lu/nKzsAmO9my6PwApYWalCUuu58i/cmGNq9oQLuz024X9R
	yRCGVGfFO2h8HYh01VoTxVvpvkhHTtHPvs2eEIKRHmRM8kuZU2nSDi10P+Eny9xaTmJqPOOYth8
	zD6Am9xRWI+qjdl6UvJSMWieYJ4vvc7XXiIY/Ou1lNQ9o30HQ0UhCClePA+onKsJh0Br6Kb8pp8
	A9Q789TMijBKZhypZ31jNTCQanzccFqq4A8w3/SygGydYkT0o95IJLIvHun6yu445tKaxsJCot0
	8Vxziv/MLnZK36XxfR76F8yWH2I4Ev5vmHYFiikYa8rFDDrhOxWgnuQy2VHMesARuzHygtW3HxN
	KroltOnFIs6+GgbuVCIVcFLFVS5/7TzSEQXDsc7j1LfQS8x8pRvwxvGUPAWTh+sYFC8jILAJHuR
	BdGw7bdR0/GDwIaNfzpGzKL7j4EEQ/BQmH5xWiD+kirX7ApnPrsuo5yfsBRDN5Oob6t0LirimF5
	Aor56beQmokF2vhYjji48T8nZe7HDK3ZDZlH/2vBsNxXiZxZz+DCUqhywp4AedLJUHco+SsSnjC
	OCodQ2IZ0u4MUG2+QWvM=
X-Received: by 2002:a05:6102:578e:b0:7c8:78bd:fd7a with SMTP id ada2fe7eead31-7d6db9e66a3mr319517137.25.1795095657332;
        Thu, 19 Nov 2026 05:40:57 -0800 (PST)
Received: from fabio-X870-EAGLE-WIFI7.tail2bb604.ts.net ([2804:1b3:a803:a13e:f40:91:660f:4d51])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99e4a240ac5sm4134862241.7.2026.11.19.05.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 05:40:56 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: lee@kernel.org
Cc: maz@kernel.org,
	andy@kernel.org,
	jic23@kernel.org,
	dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org,
	mfd@lists.linux.dev,
	linux-iio@vger.kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	crofts@kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	Fabio Estevam <festevam@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v5 1/4] dt-bindings: mfd: mxs-lradc: Fix interrupt order
Date: Thu, 19 Nov 2026 10:40:38 -0300
Message-ID: <20261119134041.16611-1-festevam@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The interrupt descriptions added during the conversion to YAML do not
match the ICOLL source numbers used by the existing DTS files.

For i.MX23, Table 5-1 of the reference manual maps source 36 to touch
detection and sources 37 through 44 to channels 0 through 7. The DTS
lists these sources in that order.

For i.MX28, Table 5-1 maps source 10 to touch detection, sources 14 and
15 to the threshold interrupts, sources 16 through 23 to channels 0
through 7, and sources 24 and 25 to buttons 0 and 1. The DTS also lists
these sources in that order.

Reorder the schema descriptions to match the hardware documentation and
the existing DT ABI.

This change was prepared with assistance from OpenAI Codex, which was
used to compare the binding with the reference manuals, existing DTS,
and driver ordering.

Fixes: 009528b5aa13 ("dt-bindings: mfd: convert mxs-lradc bindings to json-schema")
Signed-off-by: Fabio Estevam <festevam@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
Changes since v4:
- None.

 Documentation/devicetree/bindings/mfd/mxs-lradc.yaml | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/mxs-lradc.yaml b/Documentation/devicetree/bindings/mfd/mxs-lradc.yaml
index 782b2f4005a0..755029880677 100644
--- a/Documentation/devicetree/bindings/mfd/mxs-lradc.yaml
+++ b/Documentation/devicetree/bindings/mfd/mxs-lradc.yaml
@@ -87,13 +87,13 @@ then:
   properties:
     interrupts:
       items:
+        - description: touchscreen
         - description: channel 0
         - description: channel 1
         - description: channel 2
         - description: channel 3
         - description: channel 4
         - description: channel 5
-        - description: touchscreen
         - description: channel 6
         - description: channel 7
     fsl,lradc-touchscreen-wires:
@@ -102,6 +102,7 @@ else:
   properties:
     interrupts:
       items:
+        - description: touchscreen
         - description: threshold 0
         - description: threshold 1
         - description: channel 0
@@ -110,11 +111,10 @@ else:
         - description: channel 3
         - description: channel 4
         - description: channel 5
-        - description: button 0
-        - description: button 1
-        - description: touchscreen
         - description: channel 6
         - description: channel 7
+        - description: button 0
+        - description: button 1
 
 additionalProperties: false
 
-- 
2.43.0

