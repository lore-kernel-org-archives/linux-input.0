Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA2B35B12B
	for <linux-input@vger.kernel.org>; Fri,  6 Mar 2026 10:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772793668; cv=none; b=Gzavz0eOqW9rwPgz+C4Ni82rTA2ivfCVV0BWFjulbwf6+0bwOTKeiLlImqub4Bhdm13iYXaT++QQ1NEjqj9J5Y1s04AbxGzwa3kkAgOhOV0qI60CQsIqOuJjdm6eqd7GquZyMKaNhMAOOFZxZBkPoZEvqxnso132CA/PDgmPJe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772793668; c=relaxed/simple;
	bh=TJITmyCLoFI4WevaGgqd7twsgtYri7xyyfq6zwNFpz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jPYfwqrTBFtVXN1Y9rT7Yg6Rg+hWAjwinnjmPmOyd69bItdTPROxbw33Ntl96cQ3/y+RmJY4tus5RYbzvk0XVOKhTEse0FKb/soLml38mY019OyoGet68z7AlvDtTbE/npwfqzHHFMwABl9iqTzIjRiw+sJNXqZ14e+nWvgFsFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iIt9u1A7; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iIt9u1A7"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ab232cc803so42820735ad.3
        for <linux-input@vger.kernel.org>; Fri, 06 Mar 2026 02:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772793667; x=1773398467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7rhUejIrQCco2TAE64/xhR9iZ0UV/0oq0FcF9FFdRas=;
        b=iIt9u1A7mNtUo+PCWlehO7WCzPmbWM5ogGqyJEITZdFxKPP+0qG2+2HFkQYG+dG/lG
         jlkWdM+HrgJkWMQyzB1G+dVb+Qzu8w8yd667VbkUQ2y93xKTrAsrG2+dfhEypcZ5SfQ6
         8Ee25rEnUAIMPI/Wb9WJCPLDT34BLTbfSSsoaThyd25RVAuWQ9ZDt2ZeOLI0Zc6hjIb2
         KM4y432WNRTTCBvTh8n59+R+El0iTdcKJ3VvpN9nTFwSULBMJ1J1WMWpa4xDXW32vDAQ
         Fzb8WB9pWDDcaGS/aXDhP+SYJcDLw5lmVt9aq5WQ3Ae5Iuxg5tohaikPUzIbHmlDrZkW
         cVrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772793667; x=1773398467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7rhUejIrQCco2TAE64/xhR9iZ0UV/0oq0FcF9FFdRas=;
        b=B/6VyTGGP3hQFb9i9rJjr4OOr7KDcOO7hgOZ3j9aZZGMARpf5Gii9Al89voBtSMLsZ
         fjA5NGJG8zpSH7wgathKOwBsRUaf1g51NoTQmYQv5DdGRr2LL9Lfk3RsrZkJ7u4pCLF8
         96+l+txE9JWw7V90iXWZ2qYA/SOqkBloq1BdrnJLqBwd8Jsr68ULxCb89FXJ20IBZsct
         faCy5ppLGTPAmda46MPDMDs+s7wD2vLMwVsKhLzk61gdL3GWFecRzrux+s3qwnqbg4AW
         TnY+3LeTKAAVx17OchlRrjGWTtcvyQ5r1Ko9yy9NGTgAhV0y0XvGDQ5TYfB3Kymv1/1G
         PtSg==
X-Forwarded-Encrypted: i=1; AJvYcCXNdFozcgLOmiDnPD0hVq1PJDci4zm3RvJEu0556Cssm5gkEamc03WJztZ6HTWacveKrTLd1nyIqk+ZsQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzlHGBkWSEqBRJPfCGqCw1Wh8nkVKSDbFxP4igtUPv3d6Py0yPU
	P3gAk95eeA72f06FP/kIWAA3uUInAgeE8r7PqMQbFfekUjq6zv4+kHyH
X-Gm-Gg: ATEYQzx8NhNNyw/Wb17Ls9w+Z0gdwGriHeuZ/PZN3AS5AYx21BO4klYuMXHF/qBPvSL
	6YECdb9pmhCaz52aRxxCSXR/S1hEbN7RoHuTP6l8kLZgI9oQnA0kgTGUJnmQXSoVSYtHHHdNFJ/
	3HocnBHT9wlckHp8OZ/pOKAl19C2lW2dNs/VXfZv0YRZs8OPzZtloJwiVXVni//N+I/aYVmzfue
	pUDFUrLs/oMhdEH+ZMKo8S8DHtK1v/diWw2n4bF3trJiyKHfGUl/eFWO7WQe/eztFA1jfuZOso7
	wSwat3ZbR6s9SmvP9ogdwksSdliLue+kABE9F+/s8YA20K29UNpdAtdaBJEPuYg7aDbXEHdi30W
	i1L1FbCRF0L9KlQiw313qEATH8DxVqyJb2aNfcU1w2E/blG35idQjTNLhWH6pBlxkUY2UoTsqTS
	j/AmJ6HtORJJfCy+emK63l3fXxhXBNL6eM8jiV0J+Sie6SPMNIg7E49RMYrQ==
X-Received: by 2002:a17:902:ec87:b0:2ae:5a70:4786 with SMTP id d9443c01a7336-2ae823a958fmr20001125ad.25.1772793666799;
        Fri, 06 Mar 2026 02:41:06 -0800 (PST)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83fa2fa5sm16107775ad.70.2026.03.06.02.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 02:41:06 -0800 (PST)
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
Subject: [PATCH v2 1/3] dt-bindings: input: touchscreen: sitronix,st1232: Add wakeup-source
Date: Fri,  6 Mar 2026 17:40:23 +0700
Message-ID: <20260306104025.43970-2-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306104025.43970-1-phucduc.bui@gmail.com>
References: <20260305113512.227269-1-phucduc.bui@gmail.com>
 <20260306104025.43970-1-phucduc.bui@gmail.com>
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

Changes in v2:
 - Drop redundant description for wakeup-source property as requested 
   by Krzysztof Kozlowski.
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

