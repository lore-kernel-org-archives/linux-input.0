Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633BA35C184
	for <linux-input@vger.kernel.org>; Fri,  6 Mar 2026 11:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772795987; cv=none; b=Xxwxhga6AArWsNGncHDKEKF1OShrkBOaP2rYVjGJ9omAxSQvzxXleKP6EGn//GtA8dbmdQ3jPLGNI8hzGKlYo1mKd5okJzWy9+QPdoLkWAKhGBCouUE1i4iZgi0anpucCCwNKyQtCEbwBHqosRVanmMMam0WhfSDCWGQPjHAYQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772795987; c=relaxed/simple;
	bh=h4gOd+UQkfsuU8dfRXEsm3/VN4Iz5YJm2OLlL8dMYmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AleBdjgMnHGdyrtE1gO9VaVu6U+Tch8BKjSPXv2Ea56XCV8I0V5m1atNZewcybsPHUeLwbVwm457d/jZPft+lMrDmejyz4x4TTpQenoEKKvDgPsXTOTmzj63hJm3qp/QJlrXWpWm9IbPkjWn2lfXam5T4yV9oNZmVt0C9Td+E1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ndFK8GrL; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ndFK8GrL"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-82987437624so1016080b3a.1
        for <linux-input@vger.kernel.org>; Fri, 06 Mar 2026 03:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772795986; x=1773400786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eWAv+cXchBb/HIG329G/h7rJcEkvvlkIxA/O7EdGmJQ=;
        b=ndFK8GrL8/KeRMaoM5+AzuOtSylcP8MiccGVzhsZ45VSDt5/hyTPbWdyW/LbmJKYMK
         nuFIwh/6qyggqZX9RC/D61eav+7mbsMgBZx/aA+Gzrj2UBqAKnBoqzNYOXx0kTi/RFRb
         tv+OJmpKrfabUXti8Yo/BtfF8P+oy9NdQ8h+4f1dBck+X0O1kgLeJGuSVBDGKQglGW0j
         s6fYLYjFgc9vCU0exeW+jhA1H9iZPrLRGK7bgKep6Tqw+hgCQkWkM2eafznnOjH7ClOR
         qY1grf2NtsmvWqDCYUAq/VnWo075hk7j7LMg7cqx7wVgnfz9xyINQ4KAoMK575P7zJuA
         GgNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772795986; x=1773400786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eWAv+cXchBb/HIG329G/h7rJcEkvvlkIxA/O7EdGmJQ=;
        b=HUFc6/Y6yvj21D+lyIpyZbUvrfe83kNuxP/4xjHVviRgLJJbfjQHyOuV6Ed6qeLlU6
         /nmS0/BYk5cFuIv2m49V1CFAqk7bLDAHPsdf0KQILN/sL08YSWILfW2wGfQlfA1FvlQM
         A4qTlmB7BEHYnDmGQnP4m9x06I5fV8ZjYiEMpNUWg7E19IKXtqXdtP04KPNfQcViTvf1
         mjS92/J3zGwb+IL7DvXIu2R6THx7iK8g/EZSnsbED0zVTXzwD0uAIuY6nIEdPpyCFQD5
         PLnkri8z1b/9xXJsoHKPBzTtxYgtvF62wjpQYJhxDcKR0qNPhC3QLqao/z2uHaDUiYVf
         zVsg==
X-Forwarded-Encrypted: i=1; AJvYcCUPST+6t/j6OS0Rq/Q+qMFr50FQpO1VTtd9maX9rNxL0s2fqHk6fWENjR8yqlnNni38N5B2N2gmubDgOA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwlP3krr/bEWxQQkiXDEmWW2nortpjmw1K/edogmLbHKkJIdcS3
	a1WT4zsw5oGf2uy9p7qFAcjUrWyr4+FtUKaJKBFsb3JIS6iiDedBY2Bc
X-Gm-Gg: ATEYQzzqIPfQchV4H5MjnSHW7C75NL9lgHsDMf6O9u3yJ2B6IklehKssHoEayMpT3dG
	oE4pahxQp8lP3eByxDmq5cv6I4JqhTr/VcUD3HvIVKxZiFqTzMXjSC68uz+uTtEY5aoBYSGQGmi
	C9KHOEb4POaA1vK4MjWHc5AXsKUFFfZjHWGNcjBjJ2bwEh96OcMQWTnJfe8s+wfpTjQET+FJtvz
	55D3CRG8qFgmBvPMpDMLHjM0dsIfIkDZ2lgc0MmuZV+4hm0dqL/PShFrADbxHg0NrQ7+LE0iaRF
	/tLeGZk5/3vXMZAABozXldPt5qFez4vzfTDcOvSGxdBHejqA/IYXgrXwGOujplPmzydgf9/SvTO
	sY6FUpii71b7neoqNYY1a4YD6DM97+aqISG/TksoL7vlccUlqCW9QcBn6xGjH79LKC7oruZ5EZN
	MatDZ9svlc1Yr7s+QJsH+aMMC5nAfsLJr3EL/P71S3bKN2UOu33AduJjojLQ==
X-Received: by 2002:a05:6a00:1c96:b0:824:b03f:2f65 with SMTP id d2e1a72fcca58-82985586d87mr4495740b3a.7.1772795985792;
        Fri, 06 Mar 2026 03:19:45 -0800 (PST)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a4636cfbsm1475973b3a.13.2026.03.06.03.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 03:19:45 -0800 (PST)
From: phucduc.bui@gmail.com
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Jeff LaBundy <jeff@labundy.com>,
	Bastian Hecht <hechtb@gmail.com>,
	Javier Carrasco <javier.carrasco@wolfvision.net>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bui duc phuc <phucduc.bui@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v3 1/3] dt-bindings: input: touchscreen: sitronix,st1232: Add wakeup-source
Date: Fri,  6 Mar 2026 18:19:10 +0700
Message-ID: <20260306111912.58388-2-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306111912.58388-1-phucduc.bui@gmail.com>
References: <20260306104025.43970-1-phucduc.bui@gmail.com>
 <20260306111912.58388-1-phucduc.bui@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: bui duc phuc <phucduc.bui@gmail.com>

Document the 'wakeup-source' property for Sitronix ST1232 touchscreen
controllers to allow the device to wake the system from suspend.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 .../bindings/input/touchscreen/sitronix,st1232.yaml           | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/sitronix,st1232.yaml b/Documentation/devicetree/bindings/input/touchscreen/sitronix,st1232.yaml
index 978afaa4fcef..fe1fa217d842 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/sitronix,st1232.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/sitronix,st1232.yaml
@@ -32,6 +32,9 @@ properties:
     description: A phandle to the reset GPIO
     maxItems: 1
 
+  wakeup-source:
+    type: boolean
+
 required:
   - compatible
   - reg
@@ -51,6 +54,7 @@ examples:
                     reg = <0x55>;
                     interrupts = <2 0>;
                     gpios = <&gpio1 166 0>;
+                    wakeup-source;
 
                     touch-overlay {
                             segment-0 {
-- 
2.43.0

