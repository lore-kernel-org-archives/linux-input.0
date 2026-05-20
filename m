Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BE83D1CC6
	for <linux-input@vger.kernel.org>; Wed, 20 May 2026 18:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779301404; cv=none; b=SmNAzJcAMcCmjB0j5ejRLSC65y6PjuwapnTh2fmV0B5x5/1HolpRva0W1pVviNazdtKR+h7Eewd2xslv1E3FxH94ynW6zGNhy7uDNnIGufVmzXlif76SjC8XMFD9Z6e192QLy1d0BG5sManaJ4ram2Gm77TrrBmdIuJRcvK4nHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779301404; c=relaxed/simple;
	bh=J4ST441g4GcL9Qf2m4E79qGEfDOnvVL9JwIy2R9JJ48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bM93hQ9FFTbPOSZnxBSTLwpVLTvOBx/VnkOJyE3THNl3LcgRunsDyGI5OO3+KnGK+TSPBdbl4ZDGz53IqPxhsSrBhb9bXdji60IYoDccAIiWFWyWsFXggMTgeK+ClUgSNtoklFq/sy/rVwc7ONgHlBdEhOcl5EY74Yz90AWGU84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e6dEsgK9; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e6dEsgK9"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43fe608cb92so3277481f8f.2
        for <linux-input@vger.kernel.org>; Wed, 20 May 2026 11:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779301401; x=1779906201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ihKUarJUZQ4s5QQSEeZE4451TwDBF8kmyP9i/ksYTag=;
        b=e6dEsgK9ifn4czM4/OC+NfK2dCyeL3G6gI3yw6pMGcXfWMXFrk2ETn5lxP74AQLc06
         bGMLvHU764GOjoja8mTipUNMWFqnF+y1GVQ7T6GB+KcW5TObXi3JW1vS6A7BqWnG+Twt
         QnQ0KOb3yy4ihkuo+61OvEZBUtSruf2/U/Bse4l59mftjUV+/wqF1CPVXtOgQIDjj6Mk
         VWcz5tbiclFmgXVXV43nS+jG4CYtbwca0d0LQDJfC0CoFcK1WTZPAyLXHCHGDsSggL17
         LoJ0SmqyJwCYfIV2Qtvm/L7tFJwe/WtUTyJ3dtXUJk7C5sONQ4FadSGi6ztr8LJsccMr
         JIHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779301401; x=1779906201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ihKUarJUZQ4s5QQSEeZE4451TwDBF8kmyP9i/ksYTag=;
        b=BIlBUiIeIJbLcPZ0r4SnS0V0tADhqtdh+VduSQfkx8pz/gngbpqnI89bdlh9Ot3EvA
         Pmg2VCCTzoGAEbyMKrCrIV4TPK/6Apb3Q6/nrJk5Ux7ACoFWedsyIb3lSjLcjSqpROkM
         1qbooDfY23OVOjlbFBa5eGQP4YJf0n9zLMzQvQLhphCgj/FmJD86IkKn3cjSVrqPXt7Y
         5eEYpmc+FRNgRcU201S6UrkMIyxg15VYlVVZqIxiO+zZ3qmqJrV/fHSfA3VUMjVkdLIk
         dQpgU3kM2UgLElvmfDuUloJ4pMCLRwg1fFoKae18v/OyLxGAZ2KOEzyfmsLK4dbr1nwe
         ijPg==
X-Gm-Message-State: AOJu0YwjQcSjDGPkAHwKv5+eKv8ybS9WSpaHwMdxW0dhrQ8ofZ7QlOGL
	ESDvAV7AXyxFGG7ybDUfSyFiqjyAkbKnf64EG50ifYokCRVeox6Hh/hM
X-Gm-Gg: Acq92OEu2DymHIiPvFYpiAM6eOA0aFtjpwp9P2Y3JBJAiG+PAZFWQDDdGA5ny3N5SZA
	A/7dGYWdqb6QYY9It3eWYab4nXO2sCX0W6TSNhgmQAul0ogkvKUaCSLd/ppGiJDdSveKNA3Q8gG
	C2XMMWc3nKYp4krMgi7Pjj1/GX1iOJdxdudnBArlgPJXyQU0u8HDMck+d10HAgq1FKRde8fhauL
	VK2FK9aQ7/TdR4QNBPpAvCr2EP3C/npc2dC6KVVnJV8XiX6iIj5MrSPBv8Q7IQZrvlkfVs7lgyW
	j0TPWgstAmHgZiawSqvXwRo5bWQrzNR1N8UlZCn3A3x0MgD6NREFeQRuU2rY6imndjx0hBAc0sU
	zO9ULen//NCKl+PWTJ6LUo5sBbo2TgFRD9Hu32ABWdVwGtTyN4yIdygp23ZD9IMojClEl3H/dzg
	aQiSgQCpNRtpmiljKuIYZhWP8=
X-Received: by 2002:a05:6000:25c6:b0:454:a12c:6cdb with SMTP id ffacd0b85a97d-45e5c57d4bcmr41302298f8f.2.1779301400746;
        Wed, 20 May 2026 11:23:20 -0700 (PDT)
Received: from xeon ([188.163.112.61])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9ec3b18fsm51297739f8f.11.2026.05.20.11.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 11:23:20 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org
Subject: [PATCH v6 4/6] dt-bindings: mfd: motorola-cpcap: document Mapphone and Mot CPCAP
Date: Wed, 20 May 2026 21:21:22 +0300
Message-ID: <20260520182124.117863-5-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260520182124.117863-1-clamor95@gmail.com>
References: <20260520182124.117863-1-clamor95@gmail.com>
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
index 76705ea56805..da7abe2ec912 100644
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

