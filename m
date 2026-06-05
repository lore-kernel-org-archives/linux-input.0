Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B45E45349A
	for <linux-input@vger.kernel.org>; Fri,  5 Jun 2026 07:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780643402; cv=none; b=gSU7dFII8ld4F/Cj4iz6pGDv++dX4zXVySvP+yExOOG1Jp9XrPpYSjKqtquqlX937kfZ10PKChfuHNtj/qizTzYM0dUecEzhNRXxBSuXby4b0PeTJHmmfOjx2Rd7ZE1L1N+vA3FPGRFprnXrf6woo2IYxk2e0E/bvTJHayEUOM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780643402; c=relaxed/simple;
	bh=81QWGp2xwz5I5iCFmW4tGpxlb1ZZCK6gGl11cl7Gxbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i9nutPPBEKHJKzQn9bpwpLjUEGfSMeHnhFbsmbFmFf0QSxw/CPnCqZ4lLZBWut3/N9cH0cvTZNh3xVXCIhnu9M1BUfrZ3BwVDycRqqs2/k2TfK2Zl+TfXpH127Kfn6NM+XZBHMI1JjgsAVzmS1TTDmv/XaNKZ+EkGlqRMa76H0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OiQJE1lB; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OiQJE1lB"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-490c0c92cffso7086085e9.2
        for <linux-input@vger.kernel.org>; Fri, 05 Jun 2026 00:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780643400; x=1781248200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=//utTjSSQFS79aIABVKNXcplPpUF6UEdGauCN88OgVs=;
        b=OiQJE1lBfqJhsNSGtRE6hvNCZl8O0JH/n7508pOaG1Yj4F2I6RKttuwqTB5YKQQl/Z
         E6x2r/4KN8KIHaU6pmmeH878wdben34ihjWaXwHAWJHS1fsCDPlZzPmdoRuMG4BdPZIB
         Dl8GlQtV/ViusHFXgkanRfIYGewpeIiL7/mjpuoKz+ZjB1Pw+ddj+gAzcMJ/VfgC4UFq
         ekjq0oBKyIFvt4pyXL2iMKg1W9ePRKVw6suImJwuSwGKmafKW+5SuyUCa+QHoxjMAy+k
         jDDGw7ZmoTkuyGfQdIyAF9cUwoiOgWl3byEhUAmjmC88boVVkyxFijC/Z4Qy50Ar23PA
         h/hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780643400; x=1781248200;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=//utTjSSQFS79aIABVKNXcplPpUF6UEdGauCN88OgVs=;
        b=Pm/0ty32M2H6xJqN2g9H7/QxrtLTEOULGQwxJR6GJiocExy+zCTsEHBuzfFa8KffKB
         M8fMhQUG3I+VzsOJTMOavzDb0RwwnPxs21fxuNGe3RAb2tdtKjQ+Jb2bETcTZslvXFnD
         uEP2pJWWIgznrugLlk7LKADWosFSIIoejRe5c94lkSFbRuK3J6nDrCx1blBxH3tKJd1Z
         t4CMpJDDhFkC061vQJB7XY+uMWaPsB2GYW7TKjd6RTsFFlgFJ0KirpUPXz3ZiPdA/2LW
         cJypj2a83eT57DiGbD74oT0+5Oo7eLwH9q3iliqBEI79KkokPVUukmm7tCpBEaCs7rbV
         d3+w==
X-Forwarded-Encrypted: i=1; AFNElJ/Oc8cfRrtXBmKDeGMNjS7xHB1gYqv4KxOU//UAUXd/7E/QuIoLTjwq1i91kGFnILz/ZrNM2nyEhOYG7g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+I+hZP8lVDELptDoMc5T0lAMBm1bTB1l6cnz0/2q2rwMBil9O
	Ia3MWm1mMFryoZWRZTJnZQRqWHp8yzlSBxlexlyokNo1aFACKJdReEf8DkqtXGIcsVA=
X-Gm-Gg: Acq92OGu1fBAlWsNchoOyWyAI+GfhmH74Qf0jH+JCQPs6SHya3KJW+kqV4dW0KBTup0
	mrLIiRUTSHs+xuzIQ1VAV44EwxHk7oMXscUGaJdxHq3rjLUKVGHjQATN7kAX+8YBUVnbb94FVjK
	k6qaJr0IzBSsosKE0B9OlllRsvDjUlWWGJF31RoekSlyJxL802ZP/F/LBpmBQtKM+HMuqm2Y2dh
	EZ9wAjWm9nrACS4qsfs++Fvjen5qT4Q7FqtG/KYsu9TLC3p8zYIxPw7qBZu93R2dQra5Z2oYU5O
	QwpzqYWprkjB4fBvrf0mMIEr3Itk5LAqLY1tzIe/8Nd31YbBJdD4rOFlSuv6rGZzhIqDqCWY4dG
	57GUXZIa1Qm0hp4Yw3tVAOxHcGV4xEKTj064NeK7c7QI0YW8hEhspucbpyJ+4JzADuojcrgbMvz
	K7teF3HsRX+2lHUAJ65p2xaPG8N+9ZAGOZrPoXsm7cy+gnN5BwoXX5IeafiC5GXD2rCu2ND2xau
	8vPIpf/DqhtKcy8gsaNFg==
X-Received: by 2002:a05:600c:3f1b:b0:490:bcf6:46bf with SMTP id 5b1f17b1804b1-490c2599fecmr30837895e9.9.1780643399552;
        Fri, 05 Jun 2026 00:09:59 -0700 (PDT)
Received: from localhost.localdomain (72.92.4.85.dynamic.cust.swisscom.net. [85.4.92.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dcad5sm25132882f8f.5.2026.06.05.00.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 00:09:59 -0700 (PDT)
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev
Cc: Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Hans de Goede <hansg@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Andre Przywara <andre.przywara@arm.com>,
	Jun Yan <jerrysteve1101@gmail.com>,
	Lukas Schmid <lukas.schmid@netcube.li>,
	=?UTF-8?q?J=2E=20Neusch=C3=A4fer?= <j.ne@posteo.net>,
	Eric Biggers <ebiggers@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	Luca Weiss <luca@lucaweiss.eu>,
	Sven Peter <sven@kernel.org>,
	Maxime Ripard <mripard@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Paul Kocialkowski <paulk@sys-base.io>
Subject: [PATCH v4 2/7] dt-bindings: vendor-prefixes: Add Shenzhen Baijie Technology Co., Ltd.
Date: Fri,  5 Jun 2026 09:09:16 +0200
Message-ID: <20260605070923.3045073-3-alexander.sverdlin@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605070923.3045073-1-alexander.sverdlin@gmail.com>
References: <20260605070923.3045073-1-alexander.sverdlin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Shenzhen Baijie Technology Co., Ltd. focuses on R&D and production of
embedded products as well as customization of embedded solutions.

Link: https://szbaijie.com/
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Paul Kocialkowski <paulk@sys-base.io>
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 28784d66ae7b..095cf654787f 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -229,6 +229,8 @@ patternProperties:
     description: Azoteq (Pty) Ltd
   "^azw,.*":
     description: Shenzhen AZW Technology Co., Ltd.
+  "^baijie,.*":
+    description: Shenzhen Baijie Technology Co., Ltd.
   "^baikal,.*":
     description: BAIKAL ELECTRONICS, JSC
   "^bananapi,.*":
-- 
2.54.0

