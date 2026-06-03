Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C97409104
	for <linux-input@vger.kernel.org>; Wed,  3 Jun 2026 20:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780519447; cv=none; b=Sx2qk5+lTxsy9MOR5xK1o22fceb7QYo9TUU1sjuCEy71lqUXjItzWGFG11GgBj85sBLPc4ez2dJ7Pzkt2LC//bIi+bdMFMV9bz9Q2Axt9ZmRSN/jke285Wa7lHrVj7JbjFiBlfym+b0PSBQfPZt04N7xnup0oTAWMvmJ0Qu8vPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780519447; c=relaxed/simple;
	bh=1VgHiEy4LZCKpTLkS9uhtOQ9zMOOI5+2vy09ZAAS624=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Iw9w9C72VkReMNC0XO6ozK9B3n/2wzzib/zmc5SvnqMZfhNHFzbitooW9WgU8bb4X7FASz3PNtC7FTizH49Hb8T4R1dUqcIGIZapmGJO0cYp91lhG+puQX3CNvZZ6YDsDFMk3BBPvv+i4RG3L6IYB22L1b6oNnwG+OV/YlvDKrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PT1+lJi/; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PT1+lJi/"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-4863ee8474eso1976323b6e.2
        for <linux-input@vger.kernel.org>; Wed, 03 Jun 2026 13:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780519445; x=1781124245; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HWkxW7Ud9tasihZM1AsETVa4enpdjUpARrEAwS6/9NY=;
        b=PT1+lJi/dVYSSC+fFoYHIJrGX9eMjKdSl476Uq9/CyTks5EULnBzI+7eCrWu9tCyl7
         Ld1H8U7yUkY7YHV1symkS6+rVED9QEQ3JN/bckDHENZc2zy4lUWMGCkC0pV55dNgRQ30
         c30GJghRC2z2yv3DxxpteL1bPrBx0EBd9iIWLLUztI7M63Fe5jrl4C8wE8VtOMtlAQX0
         WNo+Gh7X4gEUz0IyrgvkLEk5rOPzRl0JoXTF7d4Jn0w1tDWoXvbOFgBTdsIjzvPFrgzz
         Yhxx9TBiuxpTtU80FiuhQNCII8hH466uUQw3YDokhGYhIR6N/DwYkfA/nx8w1Me5qpoE
         wAaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780519445; x=1781124245;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HWkxW7Ud9tasihZM1AsETVa4enpdjUpARrEAwS6/9NY=;
        b=FAF+RGUp9CVRFY7S4BoAH/msO8h8vXIETSgfs1dXBB7pAXmtpPESfytpoU0yEg2nm5
         X+RNaJ1fogH5Xn8TJ/wnQq4VuFj0YRJIYlDMFMemTTPQKpKJJbknBWn4JOIEkn4YVQRF
         GBV2O196AiFci/Xrz+HOL6K0kcZN439Gxxhf9Ec9KAPtWa0bwu2Jv8ZEZDaT293n8cgJ
         /SewWjruDEj55FtA4sOZYX8Itlmoi96FlOoPUUfQbtv01uW1K7leQqBA02zWpLS5bik+
         LpTAq8qU6dV2RerQi4OLg2z4uMS4JfaEjuq7djXNfSv1nIhDar07M14N4vPeT4HkAP83
         DnjA==
X-Forwarded-Encrypted: i=1; AFNElJ+crY6hRsb5X77ZuIY7hgcg4tyg0R2HOsAYUfRYGnMfNJivmgwTsu294OFvCNut1mOw9Ye+VSyqjf4+5Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb5VXQL0M2jqGyFSGpEsR8cVmDcXyhX0Jehr8v6bwcYl+T+r0j
	eEafkpgbFlXsGnABbonnP+uQtgaB51Kn9ls3QMJWYZfLmMH1ADcwmBz4
X-Gm-Gg: Acq92OHXZWsbZxWG9P3FOWrS6bMbbeJH335zzEVjy2U/TvpSLV0uI7irNo7ky0ciByt
	+XUTn715f5YkluzpJIBNBwktksWpj3cBGuOKrprx77hX3lUoMhcQhQNxw+PdVmtFCa9zQhXMduc
	OOCZY1f2VXtTBsmUJ6gKDK+FyimnhiPFtSQ6iiZd3VhWlQpGOhYCaACz6r7DHRBkHyEUOMaqMav
	/6E1u7aUwoppco9KN6R3xOmTC65ejH/cc8hyw7UUVOVZQareOTvTVqmxp3+8ZYIq/R7toIJzslx
	FsqNRQY+KVvmNWfQDEWlvYTk3Zt0m+zAkCoubY/O6SbuoGFR7+1jJ2VuaEvwmR4aKFvnVin+7Jk
	OQaRo8DDieJ6w5fJGlGfa3ZrHbY9X/xauva1dfDeGkojsK1mlyyNRCad7NlpMAZM2eqN8CKIxSB
	VOIKV44JbzDV+HHbDAMcTri/5upAu3ZVkhPK3vWPy5X5DJU4ztdA==
X-Received: by 2002:a05:6808:1a19:b0:467:58e:5d4b with SMTP id 5614622812f47-4865ab31ed2mr2926769b6e.20.1780519444730;
        Wed, 03 Jun 2026 13:44:04 -0700 (PDT)
Received: from [192.168.1.71] ([2600:1702:56e9:4b40:e3a9:78c5:641e:a58c])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4865b5a5a64sm2667962b6e.4.2026.06.03.13.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 13:44:03 -0700 (PDT)
From: Akash Sukhavasi <akash.sukhavasi@gmail.com>
Date: Wed, 03 Jun 2026 15:42:18 -0500
Subject: [PATCH v2 1/4] dt-bindings: net: remove obsolete mdio.txt
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-b4-remove-redirect-stubs-v2-1-c8c19876ab64@gmail.com>
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

mdio.txt has been a single-line redirect to mdio.yaml since
commit 62d77ff7ecbf ("dt-bindings: net: Add a YAML schemas for the
generic MDIO options"), which introduced the .yaml schema and reduced
the .txt to a stub in the same change. The .yaml has the same filename
in the same directory, making this redirect unnecessary for
discoverability.

No files in the tree reference mdio.txt and it has not been touched
since June 2019. Remove the obsolete stub.

Signed-off-by: Akash Sukhavasi <akash.sukhavasi@gmail.com>
---
 Documentation/devicetree/bindings/net/mdio.txt | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/mdio.txt b/Documentation/devicetree/bindings/net/mdio.txt
deleted file mode 100644
index cf8a0105488e..000000000000
--- a/Documentation/devicetree/bindings/net/mdio.txt
+++ /dev/null
@@ -1 +0,0 @@
-This file has moved to mdio.yaml.

-- 
2.54.0

