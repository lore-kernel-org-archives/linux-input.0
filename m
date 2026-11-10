Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794320434;
	b=Adwhbblm8q4SCvabJEntBsvcr5U7vVjgsXlBUyok1XXK2u8/N5M05TUdDQcEztgjnT97
	 smre8KNFBI1WQqCggIPSFeXCRQQxXKB7E/oGMQSMy4S1NLAdhLUtrXq6FUWypUw+BSmWP
	 NMihLThp3A1b1i34DWl9PEIXWYvLS2+jldwl99bB6K+3d1v0wMkFOfMbBUzwQCj5UEfgG
	 7sPDmQRaQWNmNsmMSKPEt1kMnAGYCZ3wjcJ8G7/2J+UoIbDaLsA6oT6mESlFGfYF3rtId
	 MB4bKbEjvWtr2wG1Q7Qu7GvsRkGb7phyj7a4Wa0p85zFH+o3fq7IWnzi1csszbfm8Iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794320434;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=pjjNjXW/DLhm8uTgpvdp1RvacwHSWzmRlnWHV9BPT4E=;
	b=HggFRBzFikvwbwe366gHTTpXYg+zk9k/buk+gIYgpq0CbWOE+HKGAAVG9bDSCRQIK13Z
	 2OVr24bLsS9386NqdIkIWY1hqoIgJ6pxNZ3ntICnLbTe1tj6J4sEm6MeDmXynSIZNgIF4
	 eBlPJ//8knOrbuiyfODgLN9hlnQzq02QBPm6TvSN420kYGsVWWRPwQRQgvJqebu3U9R2y
	 FprV9feyVhs5QA209Q0CFfiQT9M0nv+8hX+c/kysFW6FBCRT1SYueCga90tu+PZeEJB60
	 yCkAjvb7orFMJqm4bKUrkZzvNLFoPlXyseIbe/AUaTD2ref/g9JciVccBZH2lipJhWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IDICeYXe;
	arc=none smtp.remote-ip=209.85.128.175
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492E560A260D
	for <linux-input@vger.kernel.org>; Tue, 10 Nov 2026 14:20:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 492E560A260D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IDICeYXe
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-8b3402105b9so15556177b3.0
        for <linux-input@vger.kernel.org>; Tue, 10 Nov 2026 06:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794320433; x=1794925233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pjjNjXW/DLhm8uTgpvdp1RvacwHSWzmRlnWHV9BPT4E=;
        b=IDICeYXehUCODeb6gf08r5i2r/Lverd0wyvsfsCYPyCpfVRD2EBgtWpUnwoAar6XRO
         wgxoDhY0VKKJCAv7zWsmxzdskVr1R+CNe/rqFPIafdLl0x1F/sKJYx8uEr7TnUk0zgTX
         D+7kqoaEUnsT5V8dnYR3PsOlr+dI0Osb5bDhYC7Tvc7W8eOeQRSEYmWMcBHqjAjdSEY6
         j6QQEP7+SExFix5mFuGo4XXctgewthQmFzntr1vFM+cuMQXB2lJTIS6PJMrLlp+Gjjzs
         G8JjPocE3MDl8wvYC3ZVxFwN+O3jiBNNEIWH7I9QHv1JuJxQ/SJBCG4hheXqaTQ35ZLz
         GAcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794320433; x=1794925233;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pjjNjXW/DLhm8uTgpvdp1RvacwHSWzmRlnWHV9BPT4E=;
        b=xXDjMpqVwb4mzPWiJ6oEAKyRs3/4Nu7B2xKMPXVF+TSKZ0K+JokZ9d5LOjiNZUT7e4
         mCYVe3i/ni0VEKn3f496B8L1Uh9w8z3lq6DtwMwePWB8X45n2wYQR7SlqLWEa0N/nmAF
         kLTYqE4DKMxJkhua/U3Yf9JN7gphjJIbKVgddD+4Eefya4/R/vftDqWcb2daXHSMIGig
         wHHQAFLAj7t9y3L5eDR18CIz9mTraXm7JKENcGV6Vq0jIyjPl0UxGaRvptx4GPkXJmkO
         mI7qEyUFDTzdhGz2PrNe+eZE0J2OKuzmxWIhdMHx8BFsG90rnIx9kSRubKLKaIK7Ml10
         LkWQ==
X-Forwarded-Encrypted: i=1; AL+hErG9K1MYmO2xEdikoG9RbgW5dJCls1XG1DnfI30IH4lM7YYATBNTT+tle/HWiJvEtXzydrqU6cSxSwhuEA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+R6vzEPImJElTwO0GtmHd8NPAB2DpxeOrwIAzxi6W5Os1EffI2
	LEyr2w+N335KbCVB7O+2R65cYjvIDpJR+z1awoMZSmddz2Su50TkYzJX
X-Gm-Gg: AYBFou0dE359F3AjrxrFk3p2fRCAA+TADZZH1SAcN3YS/DzsS+47RbgQUL39wHiUHlQ
	naIvx8pab1yZE07Q9AZPhCGjAPOfp32lRKkKH4p6b1YMRB+w192SFEsQoUSlka8wZN27raULfTH
	ksX2e1fdrmYF659uESxT3BMt7OM6fjNf9ZBIcyf+xbUwfMEqCc03ZLh1OSR21saWOJB8Khy++uH
	a+9ofLaJwCyav3jXdrUjMqp78Zjo1r6VnOHMxLxTsCKY0kyL5RklU3NzVYRjuhSMXidpk9lGUa7
	5SQkOjuZs1PX9R7nEELfDBK1yAML3R6yhAqFaWiOdv6yOjoxc8mSYUg6rA57uTVdt8GbR2GF9ZV
	HEyIaB5cUM0st2kFcMWul0z3MI5bI2uLMGvMix2t/UA8nL+DRGNHS6VbA0pQZzyKrRZagJpMRXZ
	/iGMd+EVQ2LzgcxrG81r+iuxCEa/aUsiJcr1AHXyAUZK5bRp+2kWJetzv682ER3+qjatDrVvdvV
	nPfwlSAszwVziPUXqMDWrvL/bgDgOoANIQoe6dGPJ8UPJC6pWx/dfBO7clCg7dZaEWw3691YC8C
	WXS5b/LG66jX4bA9PVvdrkac+DXQ7xdM/LX4QTpgVZ5halhxoMum9KaK2ihmO9Pvgg67VTIg1UF
	S+r12m+mtSTTz1yFXEBptDNM=
X-Received: by 2002:a05:690c:c4e5:b0:8b0:4f12:d28a with SMTP id 00721157ae682-8b392c0b62dmr12596647b3.65.1794320432935;
        Tue, 10 Nov 2026 06:20:32 -0800 (PST)
Received: from fabio-X870-EAGLE-WIFI7.tail2bb604.ts.net ([2804:1b3:a802:b7f6:2185:e89b:b285:6098])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67c589a229csm1863712d50.5.2026.11.10.06.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 06:20:32 -0800 (PST)
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
	Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v2 1/2] dt-bindings: mfd: mxs-lradc: Fix interrupt order
Date: Tue, 10 Nov 2026 11:19:33 -0300
Message-ID: <20261110141934.42490-1-festevam@gmail.com>
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
---
Changes since v1:
- Newly introduced.

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

