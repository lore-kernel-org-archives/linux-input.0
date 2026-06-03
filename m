Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E395407596
	for <linux-input@vger.kernel.org>; Wed,  3 Jun 2026 20:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780519450; cv=none; b=nGy4cumEGfucgbVMLRl8JXEL+54sp5N1ScuUTQoRNVK+Y1KrxDxdbLpPaHmImlCOm0bCKggSlPlswBTdtyhbUnkPPDtL9CKxGBgTugKHygqQ/FQqHxJ0ZYOv+jb0kP8ZOZuOYgOk4ihhvDOcs8XjWyWGgl0JrWaJqv9k3ZJ7V94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780519450; c=relaxed/simple;
	bh=cVp6ayeUgmE8WBe34rL32LQuso/i4iAijoExnQqrcQc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YQKSNml5eGIVWV1y41efLzlX/ZghVex928HQlGsoa9mXzgWRjkU8L5HOWpb4qNn6CQfVbn0z6qZID4pqd9xrraTcliMNgpsLpeeRbvDPPug8IzUDVhm8uHL6dzjYrXpKXZQa2S2qVppU6deKVzdzTxsg0jOVVPIHii3F3xK0/5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qz9X5i2n; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qz9X5i2n"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-48662d16d08so475896b6e.2
        for <linux-input@vger.kernel.org>; Wed, 03 Jun 2026 13:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780519447; x=1781124247; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mLhbmjyf/Pct2anMIF8eJOQ51u9gqHgtr+412iMIgpE=;
        b=Qz9X5i2nTcIhNIe1a5IIN9d4uP34651mWbQht0SEm9kRuzWw6MibroZ3hRElOojd2x
         IcdFwlp1m4I2LQy2sfa5gvz9ZbjwC71Njc8tyfqes3DBiUvCFZPU6RO9kDEUE/hqhMef
         UGKjA3eJmgjTNlUrlFHxP+RiFjW8XcirN6EOswyUX7bp1BbdEM+Jf7KAgBKSVFeRFDge
         J/w7Pd/V83MYDXurrjsX6NXVF/mhxXfeY+IX41HUmQdft7PPjZwuTp01pi/NNXx4gGj0
         iO9C5mywFFGGAZZN7UaVmqG4YdRwj1OzoVfkxJ6v6KzFw0eRKsw/lvT57ic6e2BX0uhY
         +r/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780519447; x=1781124247;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mLhbmjyf/Pct2anMIF8eJOQ51u9gqHgtr+412iMIgpE=;
        b=efOP5xywAePWjYhRUo1GRvY+rXAxfsjkoBeP8cP/IRnSkEFHMp+MVWclgRvoLwtdbl
         T3A7SqYRBeFls7RoCM9yKLxFgqjtY4J9rY7x3QOAD4wDDvk44UYlc0m/TXT6tPoC1SkN
         VhDzF/ztNLvSVDjyu0z4f5v80Kv4PjRhe3iuKW4fifSJt1KaWCa5isasEtQEUXNMJEKL
         vhgq8lV5wg6vLhn6mKkuLr6el0n5TA0qlb0gkmoF9hLhz1FUQDLKRDYTAaKNNTJhdhUu
         qDzsH2WlbsGO6C6xft2mNXGhdlmj700CcoaHnW3DlVL0XjRS64xy+nEgpTa6nEnTQB+p
         orHQ==
X-Forwarded-Encrypted: i=1; AFNElJ96HlHiIxvl+QbC6gl/cp37SoUXqsfGWkAtmB9jwl4hGl1iwb60wcK8GfO7hJtpVF3FI4atKhVKM+DnMg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxKqzIsDNuX5biRdCBxPnYB3x9ZAW+IcK4VACSBJRoRjvi3kEcv
	sQ0a5nkTcpepyHBAJ14RQC0UTadIOGjMACWGB54yLVW3gKrEjmkp3XtG
X-Gm-Gg: Acq92OEjoP+EdW6EM8VPg4ZvBj83ozG5vt29kUVpVJwxAmasXLiVU9s78En6LZqOSoS
	Dlh/tDvJ44tKdev4q1SG4BPbSJKpcKvpIqWfzJyzqfFuLZSIgsw0yfvsQMZnI/aQ5gPGpp0x9/D
	Lzu5/1GiGeoHANfr+QPq7vIt/C3VhykEYtx8+ngd2/wBG3DbReKOEwnfXbm9rq/3mRcuUjk9b/o
	Ps5JiSs6Ks0vD2Rs6bRpHJIv4KKdxw+irtqUzWAZNANtuYujsGnajxtn4qM+I1iiIKggOedNCI3
	qSvqwEC8OoETB+NWTMTOIt6DDRGMK9y3AjepSJ7spmXRRn4+fRzOC5Y15LCz4a84u4uYVDpfJle
	ZabXyMUJccf3hbLuHoiaPSyQ0Qhb0a5W2bNREuPII+tKFzewgabk9UmtgW59/yKUtTN86ZwMsiI
	CA69KmigNe/YhbsjysjTxCbDRLgxKOR4TPunxQ/xYXrnfYQLFOC9N42si3Uz/c
X-Received: by 2002:a05:6808:50a2:b0:47c:be93:9214 with SMTP id 5614622812f47-4865a97f66cmr2948106b6e.20.1780519446735;
        Wed, 03 Jun 2026 13:44:06 -0700 (PDT)
Received: from [192.168.1.71] ([2600:1702:56e9:4b40:e3a9:78c5:641e:a58c])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4865b5a5a64sm2667962b6e.4.2026.06.03.13.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 13:44:06 -0700 (PDT)
From: Akash Sukhavasi <akash.sukhavasi@gmail.com>
Date: Wed, 03 Jun 2026 15:42:20 -0500
Subject: [PATCH v2 3/4] dt-bindings: net: dsa: remove obsolete dsa.txt
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-b4-remove-redirect-stubs-v2-3-c8c19876ab64@gmail.com>
References: <20260603-b4-remove-redirect-stubs-v2-0-c8c19876ab64@gmail.com>
In-Reply-To: <20260603-b4-remove-redirect-stubs-v2-0-c8c19876ab64@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Vladimir Oltean <olteanv@gmail.com>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Thierry Reding <thierry.reding@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Lee Jones <lee@kernel.org>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-tegra@vger.kernel.org, Akash Sukhavasi <akash.sukhavasi@gmail.com>
X-Mailer: b4 0.14.3

dsa.txt has been a redirect to dsa.yaml since commit bce58590d1bd
("dt-bindings: net: dsa: Add DSA yaml binding") introduced the .yaml
schema. The .yaml has the same filename in the same directory, making
this redirect unnecessary for discoverability.

Two files still reference dsa.txt, forcing readers through an extra
hop to reach the .yaml. The stub has not been touched since August
2020. Update references in lan9303.txt and
Documentation/networking/dsa/dsa.rst to point directly to dsa.yaml
and remove the stub.

Signed-off-by: Akash Sukhavasi <akash.sukhavasi@gmail.com>
---
 Documentation/devicetree/bindings/net/dsa/dsa.txt     | 4 ----
 Documentation/devicetree/bindings/net/dsa/lan9303.txt | 2 +-
 Documentation/networking/dsa/dsa.rst                  | 2 +-
 3 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/dsa/dsa.txt b/Documentation/devicetree/bindings/net/dsa/dsa.txt
deleted file mode 100644
index dab208b5c7c7..000000000000
--- a/Documentation/devicetree/bindings/net/dsa/dsa.txt
+++ /dev/null
@@ -1,4 +0,0 @@
-Distributed Switch Architecture Device Tree Bindings
-----------------------------------------------------
-
-See Documentation/devicetree/bindings/net/dsa/dsa.yaml for the documentation.
diff --git a/Documentation/devicetree/bindings/net/dsa/lan9303.txt b/Documentation/devicetree/bindings/net/dsa/lan9303.txt
index 46a732087f5c..0337c2ccfa9a 100644
--- a/Documentation/devicetree/bindings/net/dsa/lan9303.txt
+++ b/Documentation/devicetree/bindings/net/dsa/lan9303.txt
@@ -16,7 +16,7 @@ Optional properties:
 Subnodes:
 
 The integrated switch subnode should be specified according to the binding
-described in dsa/dsa.txt. The CPU port of this switch is always port 0.
+described in dsa/dsa.yaml. The CPU port of this switch is always port 0.
 
 Note: always use 'reg = <0/1/2>;' for the three DSA ports, even if the device is
 configured to use 1/2/3 instead. This hardware configuration will be
diff --git a/Documentation/networking/dsa/dsa.rst b/Documentation/networking/dsa/dsa.rst
index fd3c254ced1d..42a99f5dfa2e 100644
--- a/Documentation/networking/dsa/dsa.rst
+++ b/Documentation/networking/dsa/dsa.rst
@@ -509,7 +509,7 @@ Device Tree
 -----------
 
 DSA features a standardized binding which is documented in
-``Documentation/devicetree/bindings/net/dsa/dsa.txt``. PHY/MDIO library helper
+``Documentation/devicetree/bindings/net/dsa/dsa.yaml``. PHY/MDIO library helper
 functions such as ``of_get_phy_mode()``, ``of_phy_connect()`` are also used to query
 per-port PHY specific details: interface connection, MDIO bus location, etc.
 

-- 
2.54.0

