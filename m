Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854C53DDAF7
	for <linux-input@vger.kernel.org>; Sat,  5 Sep 2026 07:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788591850; cv=none; b=adhCy72rA7teYBO/7YtB8P73RKQGBLaaAznlaimmTAQrO9X1ih8XDgJI72tP6X0Zk57x2ER5Z7WBu/Pb4GVuk3NgdBCeHISXr9zUrRseGfLCbwLExMnEnKs1mU7/kdm6iBKj4FPG+O2tjD8yJjHZ0OJ64D4bEcATH/1YoG6ka2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788591850; c=relaxed/simple;
	bh=snUd49mCf7brp4BBjf0T9QYSF39uzje6kt3MIufRgeg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LX0jY0hbP5gfGHkEbRaA3DcsCuWwi4NulgMbvlc6PHqtjJnghQXZHGk637l4R/SQoK0jfJiD6COBNn/Te9t5O4d5zdSJHKHPjFj3tlQN/YQov+y780b0h4n0FlybRxHniDEd6r/YO8fEIleU9dHEnlimtA3YLIeivt95yO6ELug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=APjuR2bm; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="APjuR2bm"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48436216a98so1173890f8f.0
        for <linux-input@vger.kernel.org>; Sat, 05 Sep 2026 00:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788591844; x=1789196644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j5lgSAOpNjAXzpb467QfOiibQnaDkCl6BQceKsplpJE=;
        b=APjuR2bm2EoJb+WyneRnBa4v+b+0gb7YJpOkRd6NJwnZfsB5vS28r8J4Eu9t63azgL
         eq1CmU4amK7XdRzOAQlxkAuAZTSC27/A4oLk0uA6XvH6OpHGBkiqfyDmlBSyMDg7pFzz
         Ps2j2ajeoziQtI9nOrzA6jMUTzw4gkc3gRvl0XAP6u1m7tyoB07kFREGWR2H1636O1s0
         KvzsfVr8h4dOwetmGw9Uw4DbByCFxt6VHHAZCt+ff1H5vEEta/f4wz0ji2+cuE5X4kiG
         CGZpsXGGxqk8/FCEZEPeDQgj9tFcHWk3YpxuyyIviRghmT/2GkWgIisDHXQWhRNvwB3p
         F2jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788591844; x=1789196644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=j5lgSAOpNjAXzpb467QfOiibQnaDkCl6BQceKsplpJE=;
        b=J9JYB1VxLMDnjBJxnK5yi5cBnUNZTX7mLUjWJgj8muqOK2U52YFoYnYLANxrL6cklI
         EHiGRdGQg3upJE2+h/JxeNsDtkFc03ngibIRi9iYx31/ZdrqHHfigb7DzuO3a04t0cMs
         E4hPP+v3Es62oOeolMCUif19eZ8HWdh8Z7Hco+I6gwhGT6SGUYTT5r1MffvcJWXQyr+7
         kRrcOk2gwtW2WIRxWKNuFY2eCPG5l7GKSjrRkJqaBohEC1Yu2+X2dxEBgk6odJ1fm7FW
         St5WjPo/EXZEKQOiPt0L4UE/OF5WlthLdA3KDurXVM0mZkvoN+S+ngLqpHtCkTUXC3vU
         ECgg==
X-Forwarded-Encrypted: i=1; AKwUvBzy5iDxNnb5X6R3vJBm/9bRjV1GIU8L7wvX22KAAmsYOdA//uFqrI+QPLAyvibhH5MotQ6kaA7d99DCFg==@vger.kernel.org
X-Gm-Message-State: AFuF++kRuV9R3Rmx30YP3KUcRKleGBsstOlHRbUC786cPpk7pguHUPJV
	A4CVAg8dmcUHAdRng2bsOxYKjAx3UwYwNioiYWSr8bDcWqkil1ym2FdU
X-Gm-Gg: AYBFou39Wxhj6fPoCtl/dmK43DM/M/rMkzi/HQGMTiK2/cFlCZdYJwQPW8zw9O38Jd3
	ZGr7au+lV18nGOw+JnqOfqz5Zg0WdowRebfyqnNS97wF4mgeIodeQs3bJufGSg2+ukOq/iUr3ww
	tPmTYNnSroFkpncVhaqsVhydsWSFc2tyIMPwkz1AXF2BqJxb/QTJEuuugg8h806IBS8GOQZHp9A
	ri6HzAHWcnWhbr1q7/kWeevJh77Yb5oLXKTFG1zZSoDmMTRKJAlhCBmLx6Dhw91665aiIbSLOaJ
	DC40aqa9I8ToKbvI+DEDrffmvjr17hneTfDDVkqm67maM8FcBxH7ghKQAy0+FjbSMWs2Cf1ac3M
	y3SEK8xbw8V+cEbjDRk2wzkJUkO2E3nv+VCdkN/0fCGIlB3hjcocnfZ6SRfnODOKS2YIa6DHErO
	NUE6icPvDjsewlVyHZrAZT6pQQSJZwYbmQ+yMB/WKQd4YoQAyhW4vA5biMIHbX9CQU6xaTB0ccj
	e8RRObFE20RaaQDfEfegSTut3tLldCMmV5tdjVdc3RTKjKItcwMVbVLcEtKSbNvZOQH1uixrlYO
	0kYZcBeKcML5oEEE7DJzUOZYX6tXOInLsBm9udO4YaKs49uWtAx0PqDya5pqYRMovQu2b6ow
X-Received: by 2002:a05:6000:1843:b0:485:8c17:9767 with SMTP id ffacd0b85a97d-4858c179a7emr8752866f8f.41.1788591844264;
        Sat, 05 Sep 2026 00:04:04 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a4eb-3001-c06d-af27-9fa2-ea53.310.pool.telefonica.de. [2a02:3100:a4eb:3001:c06d:af27:9fa2:ea53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485885bfdf6sm12011719f8f.34.2026.09.05.00.04.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 05 Sep 2026 00:04:03 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-m68k@lists.linux-m68k.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	Steve Wahl <steve.wahl@hpe.com>,
	Dimitri Sivanich <dimitri.sivanich@hpe.com>,
	Tony Luck <tony.luck@intel.com>,
	linux-edac@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Tony Lindgren <tony@atomide.com>,
	Kevin Hilman <khilman@baylibre.com>,
	linux-omap@vger.kernel.org,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-ide@vger.kernel.org
Subject: [PATCH 5/9] docs: kernel-parameters: Drop the mini2440= entry
Date: Sat,  5 Sep 2026 09:03:43 +0200
Message-Id: <20260905070347.25902-6-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260905070347.25902-1-kmehltretter@gmail.com>
References: <20260905070347.25902-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mini2440= went away with commit 61b7f8920b17 ("ARM: s3c: remove all
s3c24xx support"); nothing parses it any more.

Drop the entry.

Found by cross-checking every documented name against the __setup(),
early_param() and core_param() registrations in the tree.

Fixes: 61b7f8920b17 ("ARM: s3c: remove all s3c24xx support")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 .../admin-guide/kernel-parameters.txt         | 21 -------------------
 1 file changed, 21 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index f4314492953d..2ed1e2c03c61 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4052,27 +4052,6 @@ Kernel parameters
 			Enable or disable the microcode minimal revision
 			enforcement for the runtime microcode loader.
 
-	mini2440=	[ARM,HW,KNL]
-			Format:[0..2][b][c][t]
-			Default: "0tb"
-			MINI2440 configuration specification:
-			0 - The attached screen is the 3.5" TFT
-			1 - The attached screen is the 7" TFT
-			2 - The VGA Shield is attached (1024x768)
-			Leaving out the screen size parameter will not load
-			the TFT driver, and the framebuffer will be left
-			unconfigured.
-			b - Enable backlight. The TFT backlight pin will be
-			linked to the kernel VESA blanking code and a GPIO
-			LED. This parameter is not necessary when using the
-			VGA shield.
-			c - Enable the s3c camera interface.
-			t - Reserved for enabling touchscreen support. The
-			touchscreen support is not enabled in the mainstream
-			kernel as of 2.6.30, a preliminary port can be found
-			in the "bleeding edge" mini2440 support kernel at
-			https://repo.or.cz/w/linux-2.6/mini2440.git
-
 	mitigations=
 			[X86,PPC,S390,ARM64,EARLY] Control optional mitigations for
 			CPU vulnerabilities.  This is a set of curated,
-- 
2.53.0

