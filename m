Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794533542;
	b=AQ6FiBXBPgcAEzGek7qmowM+aXVo6MyPRoHyHf67yaVqmdxNH/axhRl5N+ntBw2P76ph
	 rHGXRhZz/hDvzsZksu4jP9qAK1COAmkY25yurxbiacbfCw6bafzKsPs1eg58NDt4fjLcI
	 PURTut+O1W7U3Bs6JDfMgvU9xIpH7rIFeu5bdrLNof5gFN7n5CHN22V2/WltGfbhRU95O
	 X3/k/zJ4KJkIYQJG6Rkpgv5ZWqK1XHZVZCdSMLVUpZ+B55ighB5su0Byn+bmXap6sG918
	 pl4ex9Oj9kzEGLp9YXl7XnDS97hvaNtazOjDyNb7N7YPxyXFv3ssnNCiJFq4feGv03A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794533542;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=9HVV9rxTa8NDtE3CvH1N7rbiUfOat50MeJpUNT5hdrA=;
	b=S3lBAM6fY1IsRiFBf907p40m9xS0TeWUN3uCfJhyDoNOIChpcrGdWUqhYxUH15g1oXNB
	 fAuZYsnRrbJb1DzO6KYdTJ8YN1DQZDsR0AKHYVS3Xw+7DOP8CQK4JHIxDM7U5tgm9dLCb
	 uDMDo5Kn9hFmexqWTG5EH1hL4MAeF5+xmgPS8ingUSDQMUseMmtTZl3lXzVE1NS6XzxTB
	 5/dKX/s2619uiY2Du+Ij/us/Uj9O7fR6UnWfvgvMoq0cGkIHrS5awALdyT6uPLUhojlM7
	 2WJsZCeFSvpcYbjvauE/kkjXCEdXyWMJ+y+8stM/6rZLP9NEn/xq6bHdqnQbHpimoOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hy3qLLrI;
	arc=none smtp.remote-ip=209.85.217.54
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C105606A321
	for <linux-input@vger.kernel.org>; Fri, 13 Nov 2026 01:32:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C105606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hy3qLLrI
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-7d2db1b9bf2so92563137.2
        for <linux-input@vger.kernel.org>; Thu, 12 Nov 2026 17:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794533541; x=1795138341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9HVV9rxTa8NDtE3CvH1N7rbiUfOat50MeJpUNT5hdrA=;
        b=hy3qLLrIRv1BFkwO03rDySamlfl15qA9jnwWfkhmYebEr08ulWyC5RQg7wEwkRCAPw
         3a1/ziPmO1tvE0msm2E2MWJYqKzAihW51iu/sd5T5eXgOo0K3+K8MH1XqPhKD346YLP0
         E4qYDA1nYrnGvdcfJhtl6VEQTI3F+IEfx6STNupxzIQQ5TQE1iWAxPiN4/NljjGbNRLb
         P6KvSXyGkQzsadvVlzZ50eiwrBlsF/Tn1HK1FYJbAW01NyPM61KGqR+GVs1VX//aMtHc
         xN8nHj6UIXPrFvAmxWxXd3xDTTSyuItGgcL/pTV4S5FJsEMSeL9xZsR/7y2B6WSYkiMa
         i/yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794533541; x=1795138341;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9HVV9rxTa8NDtE3CvH1N7rbiUfOat50MeJpUNT5hdrA=;
        b=PfoBwIO7+diY5KdtOnG0TN0zWLPwXRWgR6Tj5mgRAwRUfJfd1kHfGIStubVPOpZFBP
         PVRzxdGTuOoxxzUuw2phKBtIwgl8e/0Xttc05JhAO6KTzBDQgQCc5TU81WA/2PVDqR0F
         1jeYa6hscihOVTrg908wtTzWoJDYzf+htNaPi0RB0MxTnkZwTrcGD8mxI4GewPEwCEN3
         yX0n3M1pcdEqWtudMywK/A9nub/zMRiSz3pbc8nzyKNr1MzAbVdmmDLGFcke9LMowJ+N
         3WInuczPffp9LKu1cEGnRRlFTIZiGo4KpuN+EnSqlCKj4+Fs6vMe1RZlf+GwSr4dQ+EI
         fBaw==
X-Forwarded-Encrypted: i=1; AL+hErGBN43fQYTswliagYQXpIPPJ+FDuNso3VUU2JErU2UMMdpd+cfGXsYucmUMhHq5NJgPBOPbbnsB2oQX6g==@vger.kernel.org
X-Gm-Message-State: APuU4Z8cz54SjfigUA9wKIr+9EHwy1eSvb/H7q1CRDbnreuwNXOpAbld
	d9cNiUDOTXoVtmSnAY8anKjjsXGgm84pA+j8G6IBt1S3NCc6XpGtAprK
X-Gm-Gg: AYBFou0ODoxbyplm0bZvpKyeTDlo81ZmIcAy3cX0Ncta/y9R0gT3jqsG0AY+PD4/yMZ
	WuYYahiYfLdl94rjjU8sM0mNWJ+5z2nhQJ3jt864hkOixbEeVlDYOZ67/N3OzCU64P8Ts6l4HEy
	rM09KwktDtFl4Qrla0khEQ1+78q1FD6EmSUfJGgxeDI8Oc+ZV/aDKbKjfN3cXkVmdjgnOa1ZxrN
	api8PU85nxFYiIweG9m7HNnlR8l5mwpUiXH15KFNZnMo3SVRFXc6Kk9Kzh/jFSySaSCvCeeKaTR
	P1i9bjyy5yABcJNmS7WBPx8NUn5vQCGrgrJkoy336dl95z72VI04k/9P9WUBkM486VodBuBf1hy
	pRznwE0JvGYPL4oayjTACVCVygImdjh6A7HlUc7uJ1VBkd7A6ofa7owUjBZsKWWedviYPnuzKJe
	Q3ftNekZS8oF7jIHJTw8NQL86FdoqiFhGSAPqj8dDu4AlsmBzir5UTThVTQMFTHom9rdjDRxE2r
	i7aFYvyaF4K8nBRfHpdwEcnr00EKCco5sFf0j0Wx0BMUiBZwbNn3INpoVpce0Q52kGtRfIugfDo
	2XSoLgrMUhJxspL1BT4okfdYTcO5UI+DMBjAEuaSuIxzManHnWsrCRlstR738MAh7GKTG2gQDma
	S/sU76n8JcJzCLzUv+Gtl4w==
X-Received: by 2002:a05:6102:a4b:b0:7cc:1192:563c with SMTP id ada2fe7eead31-7d64d770298mr297767137.25.1794533541329;
        Thu, 12 Nov 2026 17:32:21 -0800 (PST)
Received: from fabio-X870-EAGLE-WIFI7.tail2bb604.ts.net ([2804:1b3:a803:1afe:4b16:e82:1dda:bfc3])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d64be7e2e9sm796166137.0.2026.11.12.17.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 17:32:20 -0800 (PST)
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
Subject: [PATCH v3 1/2] dt-bindings: mfd: mxs-lradc: Fix interrupt order
Date: Thu, 12 Nov 2026 22:32:11 -0300
Message-ID: <20261113013212.470981-1-festevam@gmail.com>
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
detection and sources 37 through 44 to channels 0 through 7. imx23.dtsi
lists these sources in that order.

For i.MX28, Table 5-1 maps source 10 to touch detection, sources 14 and
15 to the threshold interrupts, sources 16 through 23 to channels 0
through 7, and sources 24 and 25 to buttons 0 and 1. imx28.dtsi also
lists these sources in that order.

Reorder the schema descriptions to match the hardware documentation and
the existing DT ABI.

Fixes: 009528b5aa13 ("dt-bindings: mfd: convert mxs-lradc bindings to json-schema")
Signed-off-by: Fabio Estevam <festevam@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
Changes since v2:
- None. Only collected Krzysztof's tag.

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

