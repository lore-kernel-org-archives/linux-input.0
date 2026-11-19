Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795096492;
	b=WSaByTpgFJudMYlaEzxmmoJ3VZc/0bZQ4yqqjFhf5qFo1UIDzcOC6ZQlHAk496Wz1M72
	 OdH4oXTzgmuxnPkE4AjWVoIdzR0+geK3m9UEavbQhpfrtvuqrbcSpn4gDtXys2/GVVnfa
	 K62Fu5C9VF1U05V0RhEu4QUwhTWFlAu4mabovvu3wprcSWzCgcPGRYZWLjFoxMJU01u7J
	 ZlOlAy9xWnQ5wB1dxo1586DxWfu3yaX5TNp+bCLvXV4gb8G0Osqi/nhsOcOecb660+b+y
	 Rtp+cVE22s2WHrVIzsV6YjtGs1OUPARBVO36JmEc63Uqd0XeiRMgFLSCpfI3UHSwGTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795096492;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=fppy/ckcexGy49EMxxyWk/oBKj2HMd7yOzhiBjOklOQ=;
	b=1/Buo39boSl00GIeUSThGeP2O+5qXFIxdA30zzD6IwPuutqwe342/0GgdkD7t07EzjxI
	 37MkZAcoPYQngPKkOS7L9zk1p6BsH5NutlINrOfkesL4idV4TajBeeJryxCFKvbvEZasG
	 Kp2w5BlR4R5q+6VrMfVz+lGZwaiGAJumZOOUsGCN5tOzuDQfoh89857Du6E38b9XKhift
	 xm4dzi+tICEoE/aCtVWIp8+XTzdQlRl0R9egZ4YyPrDdrIvRWKMPSqVuyLMr2N7iDm088
	 pQEwqY4me0Aj1PHBF5XGA+BXnyoVa8wiSFL1985LgEXBppnPamCpvVyfhPJon2xgzyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fairphone.com;
	spf=pass smtp.mailfrom=fairphone.com;
	dkim=pass header.d=fairphone.com header.i=@fairphone.com header.a=rsa-sha256 header.s=fair header.b=w3utJXtL;
	arc=none smtp.remote-ip=209.85.208.41
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21632606A320
	for <linux-input@vger.kernel.org>; Thu, 19 Nov 2026 13:54:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21632606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.a=rsa-sha256 header.s=fair header.b=w3utJXtL
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6b88d143160so2859301a12.1
        for <linux-input@vger.kernel.org>; Thu, 19 Nov 2026 05:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1795096490; x=1795701290; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fppy/ckcexGy49EMxxyWk/oBKj2HMd7yOzhiBjOklOQ=;
        b=w3utJXtLjz8WlviGNw3pKMT/CGBNJtTtd3syRAvsHEgRWi+Ay4c1Ka+9b6f+wbiEJx
         7IpjqMsocZCGnSjjoqSBYrwD9Yffb9b55gQQDz0ihTZxWkwIwJfZjEDWOzkuaDjHdT4S
         Jco1rvwu9lQHIC+W2qA84dhIdpKsMJ44GhKrMAzlY3ztooZndFXS3SaPE/w3kXMA0kID
         RR7xHoJWUQmpqX89CMDEoH2k6f+kmA0h2XC1G1vNuPxcjd9aV6swEG1BgvDyqOax+gsH
         9RbQRwM5ccTGbAGBNAMq3FC4bTa74zbqy022X0IW5gKuJUGr1hL58PJlRJgXWQh6+PYF
         RU7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795096490; x=1795701290;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fppy/ckcexGy49EMxxyWk/oBKj2HMd7yOzhiBjOklOQ=;
        b=dZi07+qMlhXC3XO62DbJU2PbpgoHGGMExXVwWpDW1pMu+bj4CzEMjkxTuuyKvF1cu6
         gRsXqrDZ3A7WLDhNstccAkNxYGRusoFVnak+0TbZpO7zNPHw1MYWqBAIkn/FYBKMeyr4
         wnaTGV1EcZRGzqT7mghUgaEUcvn3BFLq5jNMLaToQm/hJla+nhALKyaA4O7YTNFH3Kx5
         9uUYvfFhkAXbypB2mX2CudEJT7CEMbZ7LK7pDmtA96MWCfksEE6h1EtZlQlh5M6SvqUO
         Mfu6HWBlTEhO+q3irkrqKkCGaqsFQfCzRhLvhJB1ghJRZyd9EjnUGplBgpQYhoMAdz9W
         ARMg==
X-Gm-Message-State: APuU4Z9ZfLkPv9UG9mrYrACKgxCfbCClNS85PUnAlw0bVAj7avxmdzW/
	khWzOfuqO6UjC/xTArGZU9N029UrhLYfO8t64hWeC1RX8w7v40zDUExDEQ1TX44Im93WIwEFg1N
	1132EvSI=
X-Gm-Gg: AYBFou0RK+WANwhMZxrF0gZdOt42gwN/0gnJvMInQ9eKC4/gVZJHqZYMcDzid2jB28V
	BiL7KkBVzjE21mmUd08bXG5WiGmxFXluz63g/rskqC+/DSg/SOlHlUfitFegvRn4pAblU5Xs87x
	RyoAgqMqv6Q54udJ/PcX+2WFw5Da7vZ21Mnq6BctcUpRJJSfwcDxlLDogXg80+Ml2b2IZbwglom
	LXbt8YZrjDgUmRwpu1zhfppx3xq2sko//jKLRmP+6hmE8/cM0fWKC8fRUCDdapZC+jRmWslXdD9
	GsXzPTi3R7WJ93LZ3jrWHNRA11jFNy4ZZGCZKW3h/eZSUP26XplkEoLn5Ul/fY3yVI6BAfdLrsU
	6TEvUbGvE6iDhPBw6ERVv9PqHC2U5yHQANmCJsSfdBvyV0996KDbfhbJHTVPtD18peuyhKt8C3s
	9AteBnJifpRrU1MHCM4pWE/sYaAYF3gx5i+3xUcmXwDsko8qGPpyaMwjJ13aID6kRLbCQjMlPHR
	qyi2N6IGieggdRYXroUc/1RGVHjaPjuKJJ/8LnSbp+3jUmTpGGf+dYGbhxvB3Oo6KrY4TeQiCGu
	Lfmhtj5oEWysEyjcd9eDFM+Fi635g4zmPCAOvHABd+BVNCiWkunoMXt3GecoQvKC1wnB5ZcwHNV
	8FKDknDtMyF+w/GHxnFXn+Veg+JdnJe6dVg==
X-Received: by 2002:a17:907:3d8b:b0:c50:5005:8ecf with SMTP id a640c23a62f3a-c510e0e8be4mr548781466b.8.1795096490646;
        Thu, 19 Nov 2026 05:54:50 -0800 (PST)
Received: from [172.16.220.224] (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c51233c4d02sm106820266b.21.2026.11.19.05.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 05:54:50 -0800 (PST)
From: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
Date: Thu, 19 Nov 2026 14:54:48 +0100
Subject: [PATCH v4 4/4] MAINTAINERS: add entry for AWINIC haptic driver
 family
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261119-aw8695_haptic_fp4_driver-v4-4-9d107334bdb2@fairphone.com>
References: <20261119-aw8695_haptic_fp4_driver-v4-0-9d107334bdb2@fairphone.com>
In-Reply-To: <20261119-aw8695_haptic_fp4_driver-v4-0-9d107334bdb2@fairphone.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Luca Weiss <luca.weiss@fairphone.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795096488; l=946;
 i=griffin.kroah@fairphone.com; s=20250804; h=from:subject:message-id;
 bh=vimJ88gDAgrMbKiMPhlbLbM+XfYfImQrayboZz/gmXs=;
 b=4iAQ8jRN9EaanqlLNr+Mw6FTdAkGkFADKZfYNJu5jVU+OembBmy98dT8T5qtsaAlN2MVt79oH
 Bp09DN3IME5BvmwdcoH622KkaqIrLWbMaEzyCRu7Tl61FprnnvWFwBt
X-Developer-Key: i=griffin.kroah@fairphone.com; a=ed25519;
 pk=drSBvqKFiR+xucmLWONHSq/wGrW+YvcVtBXFYnYzn8U=

There was never an entry added for the AW86927 driver, I will take
responsibility for my creation and maintain it alongside the other
drivers in its family.

Signed-off-by: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ca1c59e1fc5928b361a63e0b7fca6e95308ab8b4..f138ef76fc5cb611fd56bf1d2bd808985a4567e3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4541,6 +4541,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/leds/backlight/awinic,aw99706.yaml
 F:	drivers/video/backlight/aw99706.c
 
+AWINIC HAPTIC DRIVERS
+M:	Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/input/awinic,aw86927.yaml
+F:	drivers/input/misc/aw869*.c
+
 AXENTIA ARM DEVICES
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Orphan

-- 
2.43.0

