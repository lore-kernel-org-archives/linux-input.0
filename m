Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91F53AB262
	for <linux-input@vger.kernel.org>; Tue, 28 Apr 2026 15:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777390603; cv=none; b=stnGTvgQVc6AiCOqzoECaXIoE/K/2jbqANZmMKI0OuJKuR7Y1EOsMo/bBMTC0tjzk1rZaCrDT1eFkShCJLhiQ3uiVOG5xxgjtH2VtFHa721fHG8aaMKlDXoGteZ3D3IlBevCjv4aRvZKqA3b4qHKnRKBx4VZ3h8bpVgNc4jXiZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777390603; c=relaxed/simple;
	bh=0gEwZwS/FYqnGRZ59VSyvYE3yvqWMDCYZCh5Jh3+mCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P/M1y/L+2HvJwjsZRp14MAHU3UWLw3lZ1MAoxvkWl9i5UBl4F4WAH1t/LqhGP7Uo6eWiecZr0gA/pkaK7PjmmAnDCGXQPUJw5986PGqKTXoAzWP9QRIQC8E3NUNjhf97P18dVnXY2hq7xHFOqfYsj+W//nxax1B7OQ8eda5UwQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r4nYMmJk; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r4nYMmJk"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488af96f6b2so152916885e9.0
        for <linux-input@vger.kernel.org>; Tue, 28 Apr 2026 08:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777390599; x=1777995399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l4Ch5JjZSDRX/44ND7WHKAD/uEQw2ql3s+wN8Su8rG0=;
        b=r4nYMmJkiJTzRJALEoN24245AHb4CqIdo17Jns3G8n63iDncjs01KiHsuYg0Sqpspf
         BfJfemDC7I0uzEUtAwYY1auLUAkmBb88nZ9xETv2Jv5gZ1/zpCrMOr3FAlJkAky6ZT4l
         ydUwXHZR5eE4l6u83FeKOPRudATyx4Gyz3gjK5AoWOKGcZeT3zpCmmfDXKvAM0QBsOLR
         MqhLoGMXCQ1UvfO0uDe4XAIQff+KYQ9BXR6Kzj6X5wKZ5qYZ6KchatBo9oz7J3nD/pNY
         U59W1xbdTkysfrL+xH9nVPcHfgFc62ljOEdYwVsTQr9Ca1jWJfBxg6z6p4h/wzzhCWxX
         064g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777390599; x=1777995399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l4Ch5JjZSDRX/44ND7WHKAD/uEQw2ql3s+wN8Su8rG0=;
        b=f3EJqvgsPjk3PIk7XC3GMqi1cFzl48R5IHU4Lodpc3IiHM7cLc9Wdt3d3xvmPQFR6z
         R0cQKO2oETmhoYGV8f9pyKnZz3mpZxsev//EGHJfd/V5QdVaEBjZPRf73POw0k7LH/Hu
         Fk2WwHLuctQHBMxce5ZxhSzdtkYYQJI9bCGc9A6zyLYYwsKzvSkgxyC29Zq/gDoBq40H
         7ICDkq6wV/YAv9I+/VaGHQsZOgwKWuJHkdZs3xQATu4fRQ8qRq/VnNast7HepqFfR3us
         5ixY57qwdLKCyGMSeagnKe9ar1loQw84/cL4PMomoF1O33mQTr58aXM1Gq1BInax1Q0+
         oiGw==
X-Gm-Message-State: AOJu0Yxoxb82+5nRRLYnKcIfDT8QF4f7VmlUxdsYEXKCMSUwoBVjnxSI
	Yw753vyPKDnqJIkMsMgdYg3JSrYvZ41DDg5UbxqHQ19cRk87fLr8vADW
X-Gm-Gg: AeBDieuBKZNlySqd/4fyAM1VAcoR4XvV8KnmUisPIjHEVdAyEv16qOJ/4fLaNkMymD4
	RVOr9p3qNLPZFaJHFUycLf3msckCl2ClC38l0DhKPmtMle25meo8UHuQmjTXwFg3W4cecDDWI3w
	1jtiBTYyDn5lKXpodYyCYC0gC/+Rgp9EIUV4V0AWBqJTc5eL5qcIH/XPsH/NmSusCbMdwm/YLpK
	7WeyunsOkLZV3n6Su2/7enCUErl7AqNNJX1oVm1wlD+mtZ1bgbObilM7Uirq8fZfKCc2JfBcgG4
	U/mBLz81gE4olBBwlBXyCZnWVrTx2ta4Xx+APB7U9bHmBvbd5I+r68giuNTPTf2ISg0uPrWq5wR
	lODGpuxvpmMAncVvZEVaLUYIkkTQl9MCfyXCvOdMCsZ5yFwdQzC2yCxcmQEk/zrcHNm+Tsb9RzT
	301fqTqCWj1nQDDOYliDgjQ7SEmgSoYLKH2A==
X-Received: by 2002:a05:600c:b8d:b0:489:1f98:71e3 with SMTP id 5b1f17b1804b1-48a77b21791mr56327465e9.28.1777390598799;
        Tue, 28 Apr 2026 08:36:38 -0700 (PDT)
Received: from xeon ([188.163.112.56])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a7b56c2d0sm1358875e9.11.2026.04.28.08.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 08:36:38 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	Tony Lindgren <tony@atomide.com>
Cc: linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org
Subject: [PATCH v4 4/6 RESEND] dt-bindings: mfd: motorola-cpcap: document Mapphone and Mot CPCAP
Date: Tue, 28 Apr 2026 18:36:09 +0300
Message-ID: <20260428153611.142816-5-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260428153611.142816-1-clamor95@gmail.com>
References: <20260428153611.142816-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add compatibles for Mapphone and Mot CPCAP subdevice compositions. Both
variations cannot use st,6556002 fallback since they may be based on
different controllers.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../devicetree/bindings/mfd/motorola,cpcap.yaml       | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml b/Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml
index 7f257f3a1a5a..542d149d2b39 100644
--- a/Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml
+++ b/Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml
@@ -14,9 +14,14 @@ allOf:
 
 properties:
   compatible:
-    items:
-      - const: motorola,cpcap
-      - const: st,6556002
+    oneOf:
+      - enum:
+          - motorola,mapphone-cpcap
+          - motorola,mot-cpcap
+
+      - items:
+          - const: motorola,cpcap
+          - const: st,6556002
 
   reg:
     maxItems: 1
-- 
2.51.0

