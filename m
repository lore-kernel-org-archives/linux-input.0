Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3BD477999
	for <linux-input@vger.kernel.org>; Fri,  5 Jun 2026 07:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780643407; cv=none; b=cgXMI/KBH3vGnL2+MkX3EFaz1YDxqk9L9JGwchTRDisR3IdEq2jvgYcKccy3b0mQxQuJhSqVYM/SYqbJeYoTHOgSkg3QAoU3U6FcZHaTjN+yxFPO6x9qYzmBkLR3md3ULUmRZu7bmoD9QvrrnNnFSduD8h2zb4B5RoAU6wHKlks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780643407; c=relaxed/simple;
	bh=hVTb0DesiLB14DyOmgF2mSD+qdL2FylIfKbrjfTiu3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WJlr5nuiJRaDO4niJyW+wWzoIXKc3UOwvZjkz5nee+HPTpxikwjXA+j7UeSm+e8W6WFQlMuNVfK253ImGSTHkhsGfKM2V4/pztmJ5ckerAqOm7m+O3sS9nbUJvaqhpCJhXYzcuz+q0G1cLC8SoheLNZA7ANi99nSur1dlmHILj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TeglxoMt; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TeglxoMt"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-45eedcdaeaaso1072609f8f.3
        for <linux-input@vger.kernel.org>; Fri, 05 Jun 2026 00:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780643402; x=1781248202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GRiUKaQT1nJBPq+KqxNJfa8ue8e7/Pl8K6UY0lHo7O4=;
        b=TeglxoMtxklcy6nTqFAzsR0oMiH8gCsf0xd6YP0kVCj3l3/qNrbAO05Qq6olTG57+8
         PrQf223Lq1rDdixXUyya3OpujCwGqTtl0/ESXn6dylTY++6SnJkFAjZw63yl+4bzieE8
         dblgvWb5+9GZoRip+eSks2dPs8g8hJAHwoxXw85gjbrrubM+NrIrN/3EOieW3bkz9lBQ
         LpFOtrk8Ldk5lq3McEkL6Mwzh9RlPp7p2IuKGHDt/dA6ph55CrfUcmZI2scQxxqdF3bJ
         z+gTyaG57I3KP+g/Z5X7q9zaU1AbTYEtVU8WMOcClD/NmMVhX7Xd6u06r0x3HCacNVy0
         JR7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780643402; x=1781248202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GRiUKaQT1nJBPq+KqxNJfa8ue8e7/Pl8K6UY0lHo7O4=;
        b=RK1bS9LPtvAxLmCcKC/KW5fT45u3cvtb6USRrgTvRkYiMYifwaHUFgmwTv1VWZ36uz
         0MdIwBxer+MjcJF97nBQVxoxZpKsl3iUSYw5uz0KOwcO9AgSGO+vLC0SAMhVrdcWuDi5
         aFCtxFwpvJEDnn2b/5ZlG6Ql4GUWUb+Hz4gLqZtLAr6kFmTdqBWIoKVeMA+Y7O7QchvM
         +nLvojYdXXRrjd7PpIORlTideazIBVfwwipbLDVBqE1bFxf2a/SayBjfWdOp73JB/hYa
         lvM62dQwcEDiLBhUlm1tXVHmAFG0mAyS5WS5Pbmgry04f2gKu9ZTI9ZQR/l0Duhc7App
         RIsw==
X-Forwarded-Encrypted: i=1; AFNElJ/xYih67JGKkYhO2cXE2FeDsiXWC45TFmCOgJYTtXHuYQ8nDfvEw5LpZKntuECs4paWVIV5EEoQ7c1u+A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw29lXSCGOAIzcYU2Xv3NZtyFegddXyyfvj0eXxP7lUhTkJXO1j
	A2WvfTq70ebbHMNCeqmMGYA0Oz54gh1vETN08dERjVTxHCTNjbRl1UJg
X-Gm-Gg: Acq92OGzBteYpusOP6qUrLBTZu0Dbe5KquuJtylkKgiIpi4miEM772WReypcpmZe6ap
	TNrK4zv2XcVM+2v6KvT+h6kds3Azf+Es+zaZ84QPglpIZaUlTrQ1FA0/nb75iSAFkYkL+nxuJl8
	WeSHFamq4dlald5cxsEwUcy/kwdC59YkBXwQiMLmqPVBPDB1UHe7UdOhsZBg5UsKZF5aCPyZFBr
	VZFvKy4l0QOw5Su/bv0V4gDtUmtiFMHnELw0Eah3mzNO/6ndGf2L+8jalWTyEglkOa19CqcYWwX
	rSEDcPl6E8GUSnTPMxz7BvGT6qxtIk2znqvauZnql+j4ZW5PF42hs2VLFHLGY25mPJZSOxWkUFo
	7Lrul/75uwEnJ984zG1RVIQl5oGYXKFcR/Oaf4fQSl2uQ7VEnVxhRjNdPB7hRtowX4REq5QmHrc
	BXV8LUBEnEQDfBPru8lJenIBRPVHriSvlkkyrC35E6DI+gWMff0e4n66UeRsCzzx9zrJFtigNMF
	L1YwkCPmfERHpBIqWH6ew==
X-Received: by 2002:a5d:4ec7:0:b0:45e:ed7e:f900 with SMTP id ffacd0b85a97d-460304ee4bemr2656740f8f.6.1780643402240;
        Fri, 05 Jun 2026 00:10:02 -0700 (PDT)
Received: from localhost.localdomain (72.92.4.85.dynamic.cust.swisscom.net. [85.4.92.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dcad5sm25132882f8f.5.2026.06.05.00.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 00:10:01 -0700 (PDT)
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
	linux-input@vger.kernel.org
Subject: [PATCH v4 4/7] dt-bindings: input: sun4i-lradc-keys: Add A100/A133 compatible
Date: Fri,  5 Jun 2026 09:09:18 +0200
Message-ID: <20260605070923.3045073-5-alexander.sverdlin@gmail.com>
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

The Allwinner A100/A133 SoCs have an LRADC which is compatible with the
versions in existing SoCs. Add a compatible string for A100, with the R329
fallback.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
---
Changelog:
v4:
- new patch

 .../bindings/input/allwinner,sun4i-a10-lradc-keys.yaml           | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/input/allwinner,sun4i-a10-lradc-keys.yaml b/Documentation/devicetree/bindings/input/allwinner,sun4i-a10-lradc-keys.yaml
index 6bdb8040be65..524c8b51f53f 100644
--- a/Documentation/devicetree/bindings/input/allwinner,sun4i-a10-lradc-keys.yaml
+++ b/Documentation/devicetree/bindings/input/allwinner,sun4i-a10-lradc-keys.yaml
@@ -23,6 +23,7 @@ properties:
       - const: allwinner,sun50i-r329-lradc
       - items:
           - enum:
+              - allwinner,sun50i-a100-lradc
               - allwinner,sun50i-h616-lradc
               - allwinner,sun20i-d1-lradc
           - const: allwinner,sun50i-r329-lradc
-- 
2.54.0

