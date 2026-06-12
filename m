Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937FF3D75CF
	for <linux-input@vger.kernel.org>; Fri, 12 Jun 2026 07:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781249020; cv=none; b=KcDgEsASeYsnRl9PO9sZznaF5S33Sl+vbx3t9oudO04YmWin/WOpgvLygmVUCGh2s53ZL4rgONJEM+1Z+QF5L5guHIxStMbw64Zee+DwSqxJrW1kNMZldvIFmcGc1rSnaBXU8a57b9PxrzAcXNyAPnCf6J20VV1Ij2ajz6iDzJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781249020; c=relaxed/simple;
	bh=CoNqm2/IKzxHeL4EMhoqsMiSwsbvySEkzaTN57BAct4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L1MY27PTQNVskQwR8vqyIQm4GBnocPeZq7O5PuPjCjA8hGwTTU8Abgw4iYNM5IUhMBaRLRqIPi/9apPwI7VFzJVtJz+WFv2IVaAjSiqeCyavmBgFHcOzvNgpfFBexrVk1M2PdUm/B2MORsFd7e3qVFWhaaBKeVXQDaTufLlyIlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bBku9C+K; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bBku9C+K"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-45eee266c6cso528284f8f.1
        for <linux-input@vger.kernel.org>; Fri, 12 Jun 2026 00:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781249018; x=1781853818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WZ56rq6Rsc3VF5U8Hu6dAL1RpTeX0JyCUsP+ibErqoE=;
        b=bBku9C+KTdwFzpY8CJ+eKSe0DBpqcNKhH03JAnHa2NwIh5I+xSvbRI04B0J4B3O0j6
         feIZjL/THXGSNvXPTxMffGJZRhuzWdqrBab5KIvqc2CYVC5z6UZwtQDco5mnhLrU4qrF
         8mBQZpCqsJbv4n2NA86JxnN9b52MIekm/fYUKVnk0mkNKESnSnJRDOYzEXqbnotgAGAK
         3jlySR10rl6+urVOrBLkHKmKRcv8Fw1fptmRICh5V9RAXwqIIWeFrL5xrNuTpdPDOoLM
         C1m7hgJw2lRwOksNgnJhxEtmO3r3QH3bqZBRrNvT8R5IIbFuIp9ixpj3vySGmA7nciLb
         iI0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781249018; x=1781853818;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WZ56rq6Rsc3VF5U8Hu6dAL1RpTeX0JyCUsP+ibErqoE=;
        b=PYIdzrulpYHuX7L+PCksati6kFCdLnM2jfzxf7fynqEp3S1EiHpGmgSdfE9at6/GPC
         QqAh7eU9QsZPHua0DqFYg0BE+sCpRMRATqFoyklUo0/BXoFw4LhaZETfbRaCZA33Fcxq
         iObDE2xs4P6OnJ+ZMYOiOyFD6HqtltFGbZJpK2Qgc2pV4LlhFhvXf+qN2qmvmz3rMm+Q
         gxVk7GweKZ3m4FtGISyDs6ul7lz/R/9xtrPo0RZ75V5xyymPYhrqCajGQXEO5ESIKV2H
         G4gxOIGIhppn3Ni89jqhzeyTRNARew/gtm2sbnrM4mh4b1wxRX4r+5Bdm/EfOm4ig9Il
         QXWg==
X-Forwarded-Encrypted: i=1; AFNElJ/siP0sKblKlbJKt3XcR41LxGBzqQG5zQp1vF+tA0H5hBMl+YNTik94bmgqlxG9vVaHTCsv41zBfSalWw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzvIHmm71WRsT+TVqpwXCuKhNY2HoDrqMpoCvVUh0uukpA6+Dnc
	t7Fqb6FhZ72bUFBrkrUFSscq40mXbrWawl9TQscKLD6w+ff/X3cqtxSO
X-Gm-Gg: Acq92OH4ICchJ84LY/sEji7v9V5zEF0IThtstiWGTd8Cgv57sTWGjt0BxU/82j3LMP1
	Ht1TdWj7Y//4UXTqzCCGQOgarTfEkCUxqvjOPvCCTaK2SSRLrNwXTdhr7AUmT1zSUyN2USo6O7H
	Cg4jIPtalKTaghvDUN3KmEY9r2cGp42GJKhz6V+8OyY/UtMgSPdJp5BMkpk4w9dsZs8utqBzZaV
	nNtgGtv/zHlnt6z0fyvU7FCyc15imjyqTtOWPSg0fhopTisKBEejsQFJKIwf3MBHXDXn2OGI4Nd
	BnXw4splwiNGtT1Ic0YLZfRJ4HQqUq2Wt0/Uga7Un8az51sFuQEb0TAJnBm3qrqTPHUYYIOOJSH
	veM/x3Wf7a+/kl4OnNAKTWyBzBNWKF7qHBPhaP0kU09KcOAQx52z1kYKknTat0Kcy4HdJW8+N5R
	oXbbs+o5TrM6nt39bNEbeqTtEw9sFTRzTO8LvGe7w=
X-Received: by 2002:a05:600c:354f:b0:490:b00c:8e6a with SMTP id 5b1f17b1804b1-490ec4fe74fmr17921415e9.28.1781249017872;
        Fri, 12 Jun 2026 00:23:37 -0700 (PDT)
Received: from arch.localdomain ([2409:8a28:a54:e741:3a5a:3245:d3dc:4b5d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490ea963cf8sm28715245e9.2.2026.06.12.00.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 00:23:37 -0700 (PDT)
From: Jun Yan <jerrysteve1101@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Jun Yan <jerrysteve1101@gmail.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/9] dt-bindings: input: microchip,cap11xx: Add microchip,cap1126 LED reg constraints
Date: Fri, 12 Jun 2026 15:22:10 +0800
Message-ID: <20260612072237.1177304-5-jerrysteve1101@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260612072237.1177304-1-jerrysteve1101@gmail.com>
References: <20260612072237.1177304-1-jerrysteve1101@gmail.com>
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

