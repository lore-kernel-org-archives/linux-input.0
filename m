Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407CF3ACF1D
	for <linux-input@vger.kernel.org>; Tue, 23 Jun 2026 20:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782247730; cv=none; b=ku+IEPS6KcIsEPEwUEJlzwBKOi/BtvZK7tT50jyiKFkVELPUoLaGGo6Zsfh+5iVhDZx6p0W9P1jK0bEPHnA2Ts4bLbQkpemn9L8Z7UAZmvB4AI/SURwslmvqSV14u+MiboxN59yaWhCTdpWafQDVGP/bkmXoRCbiA8pUOhd+jZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782247730; c=relaxed/simple;
	bh=c/ZEvKrH8NyUFFYM1KdAFACpOhsENfDRqpjWjQ8d+Q0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z6l870BDfFfM6/3+5u2erctUgo7uPFi4kcUcQqJ5DxB8RxkudFTBlEVl2OMNE03mLH5o2ArERBRenohf/0v6alp2NlvaaIR3/3VIk0v3B8uVY2SMB0W8vswUU/3UgiUAFKlLE6Iz6Ejem0Rl8u5cTgy05d7OlCwcuVNPZd46m5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z+wHy1vw; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z+wHy1vw"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4629051c946so204018f8f.1
        for <linux-input@vger.kernel.org>; Tue, 23 Jun 2026 13:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782247722; x=1782852522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wchiVNh3rpBI2XZC92te0JGKBDBHe7YjoYm2rNU3USE=;
        b=Z+wHy1vwPxEkHwF4dpklQG5j50PtvQkDa8t6G9fC9qyTPPVvFvLSAfTlvU7En2Ci9I
         eIFic7f6XXerGiILiDp2bBTu1+5R1W+w4muIsABGXitA40g9eR5VPFiZMR0DTUn99qmx
         xGzSGLp4aqycRPyLNWtB5WhKxhDSGwhPKjqiis5hpxr8G1LvuHo/ocSh8C3juoOD4CgL
         RoIWoyH1ZVx1PGyv2G/xwZBrjl1GFCjiXvOZ59vZTTqqGdpAI9VtAqrnEnpRFzIZnrSG
         PcldnJiQUX1krOapKlBKExIFc6OV9c+2Kg2iWIvucA6z5GFqHnJOpJnyYO+/tdiT62/7
         VzqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782247722; x=1782852522;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wchiVNh3rpBI2XZC92te0JGKBDBHe7YjoYm2rNU3USE=;
        b=X7u+doHNiqMoEECpikZKAIlir/PaLNz7HVrw510U1DFrQ5QvrBFhi1JiN/RTDIYXKG
         AJgTspSAWopOF+X1ZxBBHEE1i4PySSKBh4w0L2iYhwr8iRrmC4WcOZnty5LM1I9el+wG
         ckNrj5Z8GDPTlUKuoS5tVvFeqRIpjb+Y891aMq2laJiFwm0E5YxqzINBrlyc0wkRXdDR
         NEnHf6phg+FXxAUbi5W/YI+tBGX80z+2sw8DJ0Hc3+lk6goUApWWsTvurpd/cs0FgYXU
         nig7DUWJ3/+a1MdAFjFRxKzOkwZnZU8Emje4qIqXs5g3KktqF7eQav5Jv6TekMK4qtdL
         gwsQ==
X-Forwarded-Encrypted: i=1; AHgh+RqHrCi6rYtUmZv6cfRwc6gOhUl++GJyHRwTeLk22MW3WZwm7xuVKTqYIbmgB0JfepMC9Ck4Wio7Xovjtw==@vger.kernel.org
X-Gm-Message-State: AOJu0YykA5s2DU/3gZfe3+bBahDl8haQbgXstFPfiY1QljWsSW/R7ZYQ
	akl6mY3oNSoC0chG3ab/cjyHLwOYGTgV8HdojWvAIxEh4Y9Kz0DwHX0r
X-Gm-Gg: AfdE7clpEtqmXR3CLop13HFxKJlVkZ5ZWrflB/KfSG4mnTR+uzW+UpQIa8UEBULGBIH
	zbsDxHQd9iAMsgQvkl1gUsfldxjzTuB8+E2fAuABWnrgJ22pFBTAJJ+dFVWgbyC7rcErZ5qZtTH
	2aAKJXVD0aqTZYbpIdlImD/p7SZJFD83uIs/9ssWtRz+aAkDQ2zvzooaf3LVG4syR8sFAsJ63NR
	as1EuMHQ0fzzhq3J0AqqdVvVo1IO4kCZqEqCtLeuivzuBPgv2h6Dz8gl5KF3Ic/yOMMiX81i2gU
	evSyDqtibrevGuILi6LIITN+kZj1/FRU4EXQaVi5zoLkdi0tdiTDxVHhNXe1ykzWGjlFyrTLUUL
	dGCu4EDLttwui9hfWlpZG6dD8w8O1W/qL+hjWMrKJxXVTMxtLlvcbTBLgnO46HpEAbAFDD/lC7z
	oUQlZmo9ed6mUttrBh0z7TxZAWMkXff78Ql6g7zgNMPQ==
X-Received: by 2002:a05:6000:4284:b0:464:fff6:489a with SMTP id ffacd0b85a97d-46a7e9f3eacmr9075904f8f.6.1782247721730;
        Tue, 23 Jun 2026 13:48:41 -0700 (PDT)
Received: from localhost.localdomain ([2a02:1210:8642:2b00:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46c1e840f80sm351996f8f.6.2026.06.23.13.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 13:48:40 -0700 (PDT)
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
Subject: [PATCH v5 4/6] dt-bindings: input: sun4i-lradc-keys: Add A100/A133 compatible
Date: Tue, 23 Jun 2026 22:48:16 +0200
Message-ID: <20260623204824.691832-5-alexander.sverdlin@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623204824.691832-1-alexander.sverdlin@gmail.com>
References: <20260623204824.691832-1-alexander.sverdlin@gmail.com>
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
v5:
- no changes
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

