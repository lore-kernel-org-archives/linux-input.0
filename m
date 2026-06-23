Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DC73ACEE9
	for <linux-input@vger.kernel.org>; Tue, 23 Jun 2026 20:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782247722; cv=none; b=liolmolvBYNV8EsdTx/EJQC191q4RD9q/5r5NmceYBPjg5xk8K4fDb5iRIDAMpR/6HjWS8YofQo/aHRtbBf6n5wvu4M4CLL0UmcMH8YKUUVGFgbUo0cTahv5g95OuDzLBAwnANgRyU5EE3ywz78jXs9d8d/tcLiWVEQ/hRihuSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782247722; c=relaxed/simple;
	bh=keipto/oGSm9DO6JiPL+egMCOZdUpk6kCgz+ngJcUX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t55ZNRXs1C9TtsYdzN23AOaotxsDnjevRLoEu0Kvmb3asCwOmVx+bHAbRey87SUhO5BJ/8Fsj+3esKub/P5Lq1BrcrvOUB3leaYx+J2GTPXLEA3CUg7tG3tDKjGICIe7JlILi3h405HBOa1+tSJmRhHJFE5CP53e9NRgV+zZumo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BygdOmBX; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BygdOmBX"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4923fb1f095so2930645e9.1
        for <linux-input@vger.kernel.org>; Tue, 23 Jun 2026 13:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782247719; x=1782852519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mJ/LUwVD4cMnF3/D7za+W6saFQ2jiETM71jeGNmmf3I=;
        b=BygdOmBXz2S0reV8gMiyS4LImdvwKPfm/91Df1UiAjAxXzqOJgWOn2h+OUGIpHel5c
         HfVLW8vmlIM/lomsLyZK/5NX9njryR5gUJOpMitClK+LUNH4bn3c0lRDA8P3pYI9mHGn
         G66Sf9RivUOBaAaP/BLAAPAYIkUCrP+bQB816rq3Q7Lr4UCKFCyxNH4FVQTPAuBFc1Nd
         NpViBqLLD9gxdzviCTuMBPVLpFs/XlQvJTS3t+Jo84srS9bH1Sez3Oy+cgOsKLkT59xI
         SR+9dy86hrrLdmnVTEctFlX66L0qheHmvsaYRQt2oBBoJHLx6W/Tq55gGH+4TYpIr7+4
         lIVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782247719; x=1782852519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mJ/LUwVD4cMnF3/D7za+W6saFQ2jiETM71jeGNmmf3I=;
        b=Zf3324fOuJTYd1OubVyAXLjapF5kHl3vPugeCzTnAVBT0Dgs5xsujiq7yDcwOdEk0t
         CDrBP+GEtNT45JXwrkusY+cuZ9M7N6C+jwhIQA2wv0yULaF2Ah+uErwEhLsRsZxa5Lik
         Gsx+MD4TcdAV7mqjafqvl3l0S3M9KNlXg76tR+Jut8oB4InfmKAoGgQ1TekjMSSFKwfI
         zPqr64VgfItqGRnGtwOCmgHvqjKIA+CqKCBVoBGh6NKulz2EqdZfxnWuorxBup/8VWnH
         b8OLe+hAM/Zy8e3KojYPiMG99n/bjIEgPIEBX0qMvDVA9+HZVf41skCmBD/4x44imHkc
         AbiA==
X-Forwarded-Encrypted: i=1; AFNElJ9Q4k0f37KFnWKlkorB27Hegm+zuykpTYvKgzC9MF6uAXWDYjb/N+3BKxLqAfqbLxCckPClVKlyj9Uufg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxO3dJycDUoP1XY/Ed9sShl+762EnGB25UoFPFLRSbY6IsHexMU
	DCA6qseBP7gvy/ycg0X409VboJo9I8TtGNITOYImrOhKUbBKZBWjrdtR
X-Gm-Gg: AfdE7ckJS+U6skVf4nHnQQeKQPOiTZibIs5wbs/uEJgYE3EvPCTUPbqUfifBX325sPP
	8YHGv1HXWDXvvihT+tozRgSiJkUbklESNCyaxzPy8T3Az0UKkYvIIZQvg603WDezmUEGxgsedXD
	y7tce9bwhk8/qD1+yHQLkHoeXsaOZ6eS0PeOud1r91E+O++eJ/G/07BdDYRMM98dXcd1WYHOUDk
	mwrblvTLl5cyf2cuGfE61wPg8cJGI3/PKmXPuoZJVNJBZg/zmxC1UC+C13s5M3eCJS05fG85/aU
	6IwRc9OjdVxhM0S6ZdjaDYAUpG30OZkvK5TcT/Iyn+fTKs1vcTbruXWPrmeF4iDQWWqMINZD4O0
	gZFmS+WAIy6XSqqOF8zYYxfghrOruFw0Sn05mghkrUQWtroG3OXJMwRNZ3EjYh6KyQQ5AGbIdqv
	3ybKxChzHPjB8gM0dipYIdEj3ABfo2f7SKUzcn5wm88w==
X-Received: by 2002:a05:600c:4453:b0:490:d32b:39d6 with SMTP id 5b1f17b1804b1-4925b37973bmr71981035e9.19.1782247718492;
        Tue, 23 Jun 2026 13:48:38 -0700 (PDT)
Received: from localhost.localdomain ([2a02:1210:8642:2b00:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46c1e840f80sm351996f8f.6.2026.06.23.13.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 13:48:38 -0700 (PDT)
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
Subject: [PATCH v5 2/6] dt-bindings: vendor-prefixes: Add Shenzhen Baijie Technology Co., Ltd.
Date: Tue, 23 Jun 2026 22:48:14 +0200
Message-ID: <20260623204824.691832-3-alexander.sverdlin@gmail.com>
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

Shenzhen Baijie Technology Co., Ltd. focuses on R&D and production of
embedded products as well as customization of embedded solutions.

Link: https://szbaijie.com/
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Paul Kocialkowski <paulk@sys-base.io>
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
---
Changelog:
v2-v5:
- no changes

 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 6b9fb6a6bf0b..88225786e216 100644
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

