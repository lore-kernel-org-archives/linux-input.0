Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0134970830
	for <linux-input@vger.kernel.org>; Mon,  9 Mar 2026 00:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773014635; cv=none; b=kYh5Ob1TwN1r+joj+plTokBUJf1crzlN3+R0evQe6uPdsWl5ZX6mFYu8dcNrtK/GjHHL6vlKqu36qH+GlnTCZ5Pm4iwBIfTGsUnSP4UGVtSDFm1idic/LLfR3c2Rl+TbR/WcTCX33zPf/T628WZodIjJ03US3r1/tT71xEhOHt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773014635; c=relaxed/simple;
	bh=h4gOd+UQkfsuU8dfRXEsm3/VN4Iz5YJm2OLlL8dMYmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uA8S9bo5ReXZitKBss0nrZ+BmDMKCNInu3GQu8+IBbXmp4/HDhLGtTZkEUTNQDlouFFo/YQaBY6Ql15GiYnykNY+DSR2W2V82eyUx9kXB8mQPLTfcfi3eXcYAJRDsXS7YS4uOff3qZWoEVz1BfxKq9tOdriw7USxTHLrrentueM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YsmNw0g5; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YsmNw0g5"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c06cb8004e8so4256808a12.0
        for <linux-input@vger.kernel.org>; Sun, 08 Mar 2026 17:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773014633; x=1773619433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eWAv+cXchBb/HIG329G/h7rJcEkvvlkIxA/O7EdGmJQ=;
        b=YsmNw0g5ICHBXp1wi5KxzxBt95g/1+5cEyynOYoRw5Tf8fx8kdcmLlOL61ir1AuT8B
         RKI50BPJsI2zY2m4YTEIqhn0B9ahZE0s0xavyGlpGQHgexB9Tr6FwsN8oBI2YyURp8X2
         RRTKHe6MewKGrGDtHBzujx26nM2oXWXktHp7sRj+nXwKbF5qPMKVzvPAOqmxqgPwlVSB
         YECHRjfQxyvywrpomw8B4dt4RuDN0omld2wx9Bd7oHbhyjz4Mqfdk/HmtaWbrPW7YRim
         tVgIV+hmhNSPyb9zQ2C/UIwXyBI3g+sGi8EQ/GEKA5VXi5IzlKTWM7esW1s/Q70H861Y
         o5Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773014633; x=1773619433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eWAv+cXchBb/HIG329G/h7rJcEkvvlkIxA/O7EdGmJQ=;
        b=XczyPdXrqTxxwwWC9QFkqcum2J7tELrPCFzkb/E6YCNbcDiAziqL3UBfrq3+J0W89U
         8+PgV5+bKOyCPS9NrGE87yo8DBXC+2KR09Vwwc0g1g5eNZIrzAT16Ak0OYOHA4vOQWKN
         WMjpOnmNo+SDcxg4O+CTzrKj4PBLj5zOgmiEy6JIaIvkYAIkWFvFzldnaSzSeWcMpIO0
         tPxwDKcs+oI7D78TD32FXAuIFv5+oTBL4vdlyn2zyuGxZ98QeRuGXF2K0Y4bdF0JbCys
         D5CC+QX759Hi6hLiE/oXoDlLUJmkw2nfxjmQHl7SrJP0tHoHb/gXvIdpcCmmcpsjCIeQ
         gQ5A==
X-Forwarded-Encrypted: i=1; AJvYcCUaX1G5OZ98TOtEiVz+3dt0zn2Vu6RRKJERqlJ2c7IEBzw2Kn+AvNtiULHg8zfuOlyZrJc5VvwVZhFwLA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzTH4ZkCxU92RnqT08E3kFgbJb0cqUNZw8Pxry56pgsQaAeQZep
	cNVQ5eKrfHTYCtz5aMZ89pS24F9WycrAHYJQqaZ/cWVVM8I5KFrpUW7v
X-Gm-Gg: ATEYQzysvekQPclHyvjMoNsdXOk2DicA5QKvwShtTXXHzKB/I+WWH0bcB8WxocFVLja
	8Qwf8OVKVay0ig4a6do9lWboiozLl3jTWw0wabGWazWe6XMHcAFwJZPs3l+Dbd8e7ab0SE0FAtk
	Ze4V5oMF4DSD7v6hIP1DWFamENcYCIvE1EqA2VEHNFCwGsmGH2FfalEfY1q0PFX5gxtYXVSSV/S
	thAmGw3noKDx3zJcbnnUlDQtvCIt+xFNjyxna8ps8mrQg0wIguLwZ53fJlsjDKXbgN/3bpnTj2L
	jUFljlIPeM/NkUyy9gUx1NJvjI3l0j/yTE/2AtORWEkFCFQuWA7zomXVARLtrWbAcerXI429psS
	5MmijVf4Vhqb0mnTATPLYAH2ZyRVeBNfZPAQwBQKCFTR6hQ9w7NWcfyFvZyZuc+BgApP2hCWjFe
	E+eWTdzvMqSkwq6LcBjLpiFqu53PvU+cRuQ4NT4oIOi7ogP0pH308knwIfBvJevvNKuaQm
X-Received: by 2002:a17:903:ac4:b0:2ad:c66d:ad06 with SMTP id d9443c01a7336-2ae8249420dmr91012115ad.47.1773014633289;
        Sun, 08 Mar 2026 17:03:53 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83e9b9c6sm104845405ad.29.2026.03.08.17.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 17:03:52 -0700 (PDT)
From: phucduc.bui@gmail.com
To: krzk+dt@kernel.org,
	geert+renesas@glider.be
Cc: krzk@kernel.org,
	krzysztof.kozlowski@oss.qualcomm.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	dmitry.torokhov@gmail.com,
	hechtb@gmail.com,
	javier.carrasco@wolfvision.net,
	jeff@labundy.com,
	phucduc.bui@gmail.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	magnus.damm@gmail.com,
	robh@kernel.org,
	wsa+renesas@sang-engineering.com
Subject: [PATCH v4 1/2] dt-bindings: input: touchscreen: sitronix,st1232: Add wakeup-source
Date: Mon,  9 Mar 2026 07:03:18 +0700
Message-ID: <20260309000319.74880-2-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309000319.74880-1-phucduc.bui@gmail.com>
References: <20260309000319.74880-1-phucduc.bui@gmail.com>
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

