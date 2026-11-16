Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794869294;
	b=twOprMIrMX2mDd8mjcRkcvynYF6u4zH7kPK/S6ui1rCv6R4EtcFV4HzIOC2cEbT81lyX
	 6IQe0kRqePyhbGaAqd/Y6/+7tkHKOfn6WstwLqlGBWo02cfbRH9PAEAhrJJxxknsxZgN8
	 0LWA+NrnP6Z4YLg9Rb/lhmg7oyR1Yhwq3cQFByLicT21YNoLrVwW5d2h7i03fAR3cjgLh
	 j1686bMTmWLuRQZVrE2DO7nrl1yeOxpaLWJMcXNMLvfkZEeYBToxEEob0KzxVgIMz2A/C
	 PtAbDiXSQCrjyim8Z3tzDnyUvFL0K/EdhZN9RZf1JFfivvPzGV+uhPe9MHRZNTvWTSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794869294;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=rS6peJ8v9Pm7ofa72f18HTAmcNJmQCcntGCb1eMGOG4=;
	b=zt8Ewc0UhcGxuzBZeJVRwkTQn9RuqFmypTLbM73Bb2Bo439jiDdkNWFMQl6pKCnzyHIa
	 eOKn6dKiiYD65Ykj0ASI/sYF7VqyOPqahcJTZeArRHaFJRfQywwO3ADyTRoPlxhdlmrYD
	 j4ll12TuoFxtiJ30jMv9G7X5OIjmdCdXFHD+bf4ZQfxlC5g87UFDY3siqo1cAREN7ThzV
	 xDxZ9Jz8HE78p+cH4K+tV9sLjy7UpS/VHWgartq3azau/qv7uDJTT/7jPzHJiow4dBkw+
	 abtdWZucRehEY89+bJht4mkEjZvB2vLXnE/akgoAwGg/GKBJV8UIffM/fBc1ej2EO4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mMrP4nhH;
	arc=none smtp.remote-ip=209.85.128.180
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695F4606A339
	for <linux-input@vger.kernel.org>; Mon, 16 Nov 2026 22:48:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 695F4606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mMrP4nhH
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-8b0ca1ebc8bso39926037b3.2
        for <linux-input@vger.kernel.org>; Mon, 16 Nov 2026 14:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794869293; x=1795474093; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rS6peJ8v9Pm7ofa72f18HTAmcNJmQCcntGCb1eMGOG4=;
        b=mMrP4nhHg1WKTA07AKwpAgg+P5/GoShtgNoHJW8UIXeK2rO3d9JAmX4JKmd/efBJjm
         WFicAGY+DZpockrWJhvlo0RmHGyjsgloldDkyWrW8b9C7NvmPPFOUxtKvYG14VT2BY2J
         Tbcv1K63JWRS+c58NnGXfg+k9gikcQo/8HjP9858Riq2lhiAbH+NIjB181LOY5C4FPHR
         tDh3wsxSuCpkkR9q/kx+zMU9PnY6/O1/di7A4RLhifyFNs5LK6EUNhiEyTUYQxy0IVL0
         O1+YWSveYimJuRae6Ck9AKQa5lvbx92y6ZJSV0nCkyts7zhhdCfLqCUI2z9mZBYUjyzo
         hIew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794869293; x=1795474093;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rS6peJ8v9Pm7ofa72f18HTAmcNJmQCcntGCb1eMGOG4=;
        b=HJ6352G0bmjc5tg3UvYZPowetGU+RJwAfgK9R+28xcf6r71qN+qdc1tJizlMs375uI
         8nBMGgMVmCR+Mzb+9E66WJR47ouPJfLvsVDYbz4VxP+0OAMul+hsx7o2Q2L7jU4BToBD
         HjB97DumgGh11+Fm5mZBv3VPJ4C3ExYDC2f38fx8gZxX3YQHX3g7vvV0jljlwY+F3DsE
         Tq03DWSH2sPF+TUfBDF8OXMjAV1LKIjsg54gJ8/gEnAn9Rzc9ouzwJ/sRPzqTSUdKzkx
         gsQutZ/UGVzBPUx7GJtIP+46FP2ZNHeuky6555j6bxRA3o0V3KFvdBBwP5G8GxjdtejL
         lIvQ==
X-Forwarded-Encrypted: i=1; AL+hErF9qyX0/gaCf8hFLdPUb5RB3ZfOUafTxkN6P6edQxzKI/i7roDPJU1SpO+iv7r7FuxjPSJZSQzrjf5QLQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z/yjBW9vJvVwlT4lcnoQqCGCYnwW/TDPLbDI/T6WHdlb8SclLfw
	zX37ImZ/7E7RYn7HKs69Suj+7216vLEXRuXwMqkFLX1sZsREHpJYWdLr
X-Gm-Gg: AZFdTZfOMuXBgBl6CgY5WkhGp/C5xGtCZagVvuF758+I23AOoJc1tI9kBvVXoA74G6W
	wA4MA1DSzKo7n+n7FZ1fGK2S1q+qh3f16LhBsuaKIVlcwHz+rlO6jLuR+fo+deFMz7AWfLpHbqA
	Udm07gh0jgBHvVGJlupp+6TWFXsNu/B3YLyxRAFjpj0risUMaENBM4HIICen9s4lIjDaiut9r9q
	yQIvq2XABZXEUR6VEdO/ZeFuf/lRnmiA5g3Yp9f0ffpjGpBS/DsGqwE9J0nTcsZWqqwwri3gUc+
	fbgqRGdwH6rQSjZMmEwqz8t6/2PnmDxjK25v99GTKx4tmafzQcjOLOSCxgch7zt5p6OqiRNLEeV
	uL2Ho6pE9l050sy0qYI3CXADxtgEAr8JlOAmVt0hZF1BFhfpI+lZzt42FQDbO06IU/kOMQtMJvm
	VjwzQK8A99nz6S9sJI7omBePTxIv29S4SgWSkwuLXze/YWuYv9gyzVd2e0VW5yokgI9t6jeO6V5
	SBk8N0iJVtESEsJsSNTpXsjmpaMDcfg3bVZQAvCVceVOc883+ILo4Gkc5MIe+IDAdDZzBUpar3L
	AiS5bTZuNPjkj9gZ5KZDyX23+VjlNWd+iQmmFXNLFXxYIDVhS3yzXlHQ7PPE5XzU/+4OqU2hFtU
	rwru2CQWQILqD3H0OJGzDoX8=
X-Received: by 2002:a05:690e:4191:b0:677:cf4d:a932 with SMTP id 956f58d0204a3-67d896cf4b2mr5729807d50.63.1794869293001;
        Mon, 16 Nov 2026 14:48:13 -0800 (PST)
Received: from fabio-X870-EAGLE-WIFI7.tail2bb604.ts.net ([2804:1b3:a803:1afe:e1c3:da60:db44:d0c8])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67db0361f39sm5259534d50.19.2026.11.16.14.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 14:48:12 -0800 (PST)
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
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	Fabio Estevam <festevam@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v4 1/4] dt-bindings: mfd: mxs-lradc: Fix interrupt order
Date: Mon, 16 Nov 2026 19:48:00 -0300
Message-ID: <20261116224803.61154-1-festevam@gmail.com>
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
Changes since v3:
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

