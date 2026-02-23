Received: from mail-lf1-f66.google.com (mail-lf1-f66.google.com [209.85.167.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112BF344DA8
	for <linux-input@vger.kernel.org>; Mon, 23 Feb 2026 06:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771828754; cv=none; b=NrsBPXf51eciAzZNT8DdwLAljYgHV2MnyVt2iglCF6+xwfpzwgnpiQtOof9E41rZuIP2mrGHEWT5HcJZOuCEyl3V3PHGfrrQ3+IKd5DdfAQ+tM2a7M1W7U6gOAzPjW1Ip7QTkciVZni5t7HtKtr+D58zkcPB1h8DrhVk5+R2izQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771828754; c=relaxed/simple;
	bh=Hiwv3J5f8T4xRB2Iui0BluAqlu57K6cNFHiipxvCbK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NRCB42sfbYpk2+j5CMLNKZZOCq0TTa2dSOndwmWmX7P62uFIEE4NoY/n2ZlrHF9LRk6tBAs4F4TPj1eOR8NKOPx7OJ6DNtOCYU7Tda50ma2RX8UVlw+jng3aUHY2SSlVwy5jyZ9GfD5QunNFQReSteKT2a3C+OGhQtE6Um+wnkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J3e5B5Nb; arc=none smtp.client-ip=209.85.167.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J3e5B5Nb"
Received: by mail-lf1-f66.google.com with SMTP id 2adb3069b0e04-59e61e94e1bso5022436e87.0
        for <linux-input@vger.kernel.org>; Sun, 22 Feb 2026 22:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771828751; x=1772433551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y75LAbRPNmnF+JWA+lclJuQoC0srlLt7G7opFFmU2PA=;
        b=J3e5B5NbYgB2KADyGq+jP6ip3E99dyp7pzbkitym2IB+jsOYz4iIy8sFBZLYITyd9W
         dH/m2Dx1NLoWDP2w7YEkVqdBrodTCZgSwh23cpqfTRKzmTctvUnRVpVKkR2F9OCF5iBA
         gbmvfb/zomFDHmADR8Mer4wsTwu3L2ayWSrk/tPztZmSUTyQx6Voju9cYGhxEghOhObi
         d28pCDorXa+wkUn5qj3kwTyaIb6nMoFl3kPlPwjxC+NR9lQyQCGO0hhrV3Njr1fo0AIy
         dU+sBrZAH2xzwJIm4sBPs5OYsW9oImhqv5NOHS/5TZa6RkVm0GzetfuX75uCLkEhvXhK
         Nm/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771828751; x=1772433551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y75LAbRPNmnF+JWA+lclJuQoC0srlLt7G7opFFmU2PA=;
        b=hrw/yrQ4LoaSdu+f8HVEQpyIyj89GRPreYhNa2nNuZn2XO2ELwHPC3JCbXlkT6xsbG
         psodtVnV0kIGafuXMHHlu1DPVFLh7YfC5+7XBDu0IwNoFaSeMpZG8/J6uVaY4hb9Qs1S
         Cci6OgfGkL198m5hQYDpzFxqnwwU+lz9mABTc+JGpqf004zOeYOs+nIZg7Hb85pH0KdF
         IIPHnhfGS6yG4IdvN1eCB3R5dx25pOUHxf/QDVFw8msRNbYVjlFu4nJMEpXwkQ8zibNG
         pQQEzMo+0hOYH9gvgTvKxI+plg/5YVfEILEibQEJd7uBIwO8TarRszGunm+Br9AbZqNv
         WjOg==
X-Gm-Message-State: AOJu0Yx9+qnepXC628A0OTJlIOGA0mToOgXf7lD6Na+ptdZfRqZKvS/3
	3/Q58e3YJi/eU1bcl+RiOIz3H8XqDaTakbZtyVhmBgLB22En+3QzjZPD
X-Gm-Gg: AZuq6aJ8IOJyXM6B4AtogOHnCG/khJC0qo/9bv7Kr2xsi8b9wWiU87jziRCpSod7Lqe
	zM3nEEX9W+NB2w9hM/2O5/dynJxu17ONlISknR2ptqsdxLOA+1s/Ctfg9mArL9bOqUnIwUCwhbg
	qTYwY81+td3JUzEy3HqZj2hoWqnSAiocoHw/bqgUQQ4cES6hPoimRxyknsHslFYBYfs8Ce672Za
	gW8BXxABf64So8zAeyWmEIidogTONkeuwBffp1swZ+gyMX1vVkvjNQdcCuP5TemLd6vZg5YmRSL
	AGna+CKS4gzm7i9YIT0oAjSf8YCd8Hi718+mEQxI7rObDNnMrsAV4yHJVScx837d/si+n/za55o
	CJ87splGGwBuJCQ33ab2Ji1KaosW9symY4t94o9PnQn7WgHjFjzpkThfOlEYTOTl6YsaGE3miSx
	BgqdAIYXDPMK0v
X-Received: by 2002:a05:6512:1153:b0:59d:e589:c977 with SMTP id 2adb3069b0e04-5a0ed99c694mr2127041e87.26.1771828751162;
        Sun, 22 Feb 2026 22:39:11 -0800 (PST)
Received: from xeon ([188.163.112.76])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a0eeb13abbsm1369626e87.23.2026.02.22.22.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 22:39:10 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	Tony Lindgren <tony@atomide.com>
Cc: linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org
Subject: [PATCH v3 2/9] dt-bindings: regulator: cpcap-regulator: document Mot regulator
Date: Mon, 23 Feb 2026 08:38:51 +0200
Message-ID: <20260223063858.12208-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260223063858.12208-1-clamor95@gmail.com>
References: <20260223063858.12208-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document regulator composition used by the CPCAP of Tegra20 Mot board,
that is a base for Atrix 4G and Droid X2.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../devicetree/bindings/regulator/motorola,cpcap-regulator.yaml  | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/regulator/motorola,cpcap-regulator.yaml b/Documentation/devicetree/bindings/regulator/motorola,cpcap-regulator.yaml
index ed28d2653a55..1a44c8e61243 100644
--- a/Documentation/devicetree/bindings/regulator/motorola,cpcap-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/motorola,cpcap-regulator.yaml
@@ -20,6 +20,7 @@ properties:
     enum:
       - motorola,cpcap-regulator
       - motorola,mapphone-cpcap-regulator
+      - motorola,mot-cpcap-regulator
       - motorola,xoom-cpcap-regulator
 
   regulators:
-- 
2.51.0

