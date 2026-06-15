Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CFD3FBB7E
	for <linux-input@vger.kernel.org>; Mon, 15 Jun 2026 14:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781533306; cv=none; b=WMHMsc56ZeRtS5ZnnffOenu/kgkOydbc/T5m0lTEiSS4tKKFS2CeHnHeV5eJo1nj0O3pT5CNBQbPEbQGEAA7U7fUanNvpWeZ5ZpHICDL0ZHJZbRyP1UQ9SzQ993VHSaw/6HssZMdCVNjkao2ZV92D6J/g+NOB1ggFcSMegzWUy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781533306; c=relaxed/simple;
	bh=CoNqm2/IKzxHeL4EMhoqsMiSwsbvySEkzaTN57BAct4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZdgoSrXYVsRzF+bCnU+Xim+eXmwE4TqRy+Ah7E0LqMEJCVOdaBCbUid8NH283vbtUs1CB0O7tEDTgoOChytTfkj2axP7qv5I8J1s0yola5Oq+wXceXa1Eth/bNx90uQYcjNQ8RdvcP+Hu9si56g9T0bxr9Y+O9q56noHJYS2ID0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zq+EJRtb; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zq+EJRtb"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-36d98c9b596so2183949a91.3
        for <linux-input@vger.kernel.org>; Mon, 15 Jun 2026 07:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781533298; x=1782138098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WZ56rq6Rsc3VF5U8Hu6dAL1RpTeX0JyCUsP+ibErqoE=;
        b=Zq+EJRtb0LZzhck9iNl+zLvafBrwdnTvxx3ih9AajitcBZd3S9tcp74laHz1dnBSGC
         VTWDVeqP4sl10Nnk3h/PLx8p23TsFuxdNAavpSbc3xnQ/jJYaQXDpwaWriPDsyHuceJC
         5qvurYCSbBNZYrET2OYjohfdht4nzNSrFjfUfoJ9O1WApucppoCLWuaxUvigRHH9egsD
         NrPBiybrv5hd0cTqsI3QFglCq50hQc3d2L9unIO6iuRj0ykpnh9gcbeBnGJMHcj79zaW
         qAIr5xzbZZZ/CAgiEAKCEOqN3+B1AM6/Al//YVzrxB8kdU9OvXP1OC0r1AsuidkGG9GG
         df0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781533298; x=1782138098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WZ56rq6Rsc3VF5U8Hu6dAL1RpTeX0JyCUsP+ibErqoE=;
        b=Z2ONKO7WUxTl8FGXZJ45NxluE/oKazEjDht5zxB6kf2bNhpLI953WFSglJ7EEpkfvc
         368JIv0aRrHobjs4QmhfSRRIvqdLUM2I8EQ+D8HIdyOpCXxzyN8EBT2hZo5F4BEGJqJo
         EIFPq7fMtCHEwzVyG4vGKltHlICDtZh6IGD6lzYkgYWseWPJgTB/OErDD8DGubkIiDnp
         E5+usx634PmwHxrryWQHqIQeuKpN3YvJ+gLYJJD6EZQaXYvL8/RWLCQbeRssZ/B/kenl
         /4rr9meysUZDkyo/7NGSCMiBRgAyV3vrFLTxFLTmOXnJgtc/MWi9fZa9RIHlxapV4CeF
         RjSQ==
X-Forwarded-Encrypted: i=1; AFNElJ/0NOVsaUvsBlL01ioHREVQC00SmTyhhO4IEf+jmTaiWuP7RlWC/Kt2VHDmkU2S40DMsJHMsXR6EhAEVQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk6vMJZctjNPI4sj2YqidMyOCvetOIi+iYKaYOAA2rTjobDsny
	cyKxrXDuMsSKvd7gRx/wNdWsvvZrQsl8E7BEJKpE5CVNhilfiC2PegBS
X-Gm-Gg: Acq92OFHCZkvnfCOycq2G3rv++J9tkwXslRDtBfHlgFhl/i2N2lpOTwpfyjIt5NCsL9
	MAsVoxGvaHr8u5B1zTtSAPCjXufMXCTnHgwGPjxsRbeMKP+QchXYJthrT8N8Mi7xb+kDOmNf3f0
	DJJ7ndQc21Pbxhw2DyMs3TNijjKSg3KDxDAlE2IQPt36vgpNgKfoGTnTca7fcBaUbWGWfpQ7gaC
	vkowpnhfLKWWTpnuMWVnytghp7F7TzkPKuEnYwpqAoNMc4Gpe+9TiP+W0KK9BMpFGb7KLM0DAHe
	zolkE5wYfEjAb4Mtam+VYr9P3FUf7nsTuX4kT/KsSVwLOgjQ04bMv27/DsIKvtnPO5LZqGUIqZy
	Tgkrdf+SopH/NPRZ8J7Xp34WH0sq7WcodDM4onuCmLcr/4vGtznhrSTJMocPYiQE9ZEa8cIL3j5
	OcWeaDhjRZ4OX2wz7pZR6u
X-Received: by 2002:a17:90b:278b:b0:36d:b818:f848 with SMTP id 98e67ed59e1d1-37a01846bedmr14854691a91.5.1781533298298;
        Mon, 15 Jun 2026 07:21:38 -0700 (PDT)
Received: from arch.localdomain ([2409:8a28:a52:c491::1002])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-379e8cc467csm7178233a91.2.2026.06.15.07.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 07:21:38 -0700 (PDT)
From: Jun Yan <jerrysteve1101@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Jun Yan <jerrysteve1101@gmail.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 04/10] dt-bindings: input: microchip,cap11xx: Add microchip,cap1126 LED reg constraints
Date: Mon, 15 Jun 2026 22:20:30 +0800
Message-ID: <20260615142103.352163-5-jerrysteve1101@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615142103.352163-1-jerrysteve1101@gmail.com>
References: <20260615142103.352163-1-jerrysteve1101@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Apply per-chip LED channel limits:
- CAP1126: max 2 channels (0-1)
- CAP1188: max 8 channels (0-7)
- CAP1106, CAP12xx: no LED support

Signed-off-by: Jun Yan <jerrysteve1101@gmail.com>
---
 .../bindings/input/microchip,cap11xx.yaml           | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml b/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml
index 9578c7c206a2..22a292d4a880 100644
--- a/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml
+++ b/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml
@@ -171,6 +171,19 @@ allOf:
       patternProperties:
         "^led@": false
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - microchip,cap1126
+    then:
+      patternProperties:
+        "^led@":
+          properties:
+            reg:
+              maximum: 1
+
   - if:
       properties:
         compatible:
-- 
2.54.0

