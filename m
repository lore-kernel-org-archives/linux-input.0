Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB4E367F21
	for <linux-input@vger.kernel.org>; Thu, 10 Sep 2026 01:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789003989; cv=none; b=A86Uo7o+nt8O8NSOEY0MKeTceV85ptFDLGjrKbVEojMcB0KSpPeVabRhgJJ/Qy3zyep6+vMM2CmhWbbdzXgpDOTelTejuaG9wd6C+ANjzc20eNUbZbn1tSDxYqfLvzmHL5rowED44uhW/YbuzM9pdaVn3xgcnV5uIuuxJGEVHc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789003989; c=relaxed/simple;
	bh=wMHs/iq23jFT//QzJfBpBUbxOI7qz5njBBA7AJ564ek=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mW9/UECw7WidjNFHUmqmywY9csRzuu3J8emWoTqeY/Bo87QOj5GZ71B414IKUbQysCbC41asG2QTwiTPpO8QqNerCf/QEGXaUhfyHewbng2+lz+yQ6XcPyeXUlzoL6ecs+44B24iFB317XyeUv0zAokXazZSMAhDO9B66QNlb0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z9NFaXMT; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z9NFaXMT"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cd6185db7so16520215e9.1
        for <linux-input@vger.kernel.org>; Wed, 09 Sep 2026 18:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789003983; x=1789608783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mNvpcd2n4jxJTfGRiEyXYuLqoJRCII7SmcuheJPc0Qo=;
        b=Z9NFaXMT/DvEIlT798YF+KykZ8nhZjIh+BwG7MctxmS7Evw1UXiFDXLYBMkSCR7O/S
         +iQhkueaBvWlKYUrMqPjxiTSJmb5n6N20m/psh1p2SSFWkN+I8hy/ieK0vIjfJiSGHBe
         J87QnIw9mVVT6/sBMhqsR1ozgTkgcPsHCcP0IPw6QaAYRny/UdRB5hWK4JYif+9eBBFH
         5kGNfl6215Px9v5F1L0fOGI/8N9Wf9IadYFvkwSBMfYgWJa9swe3wuhrmQ8Rbu+ud2Bi
         /3MYyCONBMLpDWqfR4T/+jkcfkKENoPzYBeZ8eGVEDhQvCP4mR3WSyrJ4CkzrUmaxREu
         I+1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789003983; x=1789608783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mNvpcd2n4jxJTfGRiEyXYuLqoJRCII7SmcuheJPc0Qo=;
        b=SwHFyuhU92yw3qDG6JCE/vxR2PDDRtt/yaYcCC1/q9lG3eXpZXq1usG8IoKXci4mff
         1da+hv9qwKXX12iEofdE1EtXxgRGolWCSsVzH3tTuG1On2Q6VwgKBLCkG6NobKZwDY+n
         BI1ykV3vd6W/MnbLaZ1uUKtcs0pq/7VR79NURFILjLPt/mk6vmjPmg1JqJ7bmJZrNsr5
         FYMoPtum34iRz9uV5+TRBm06cTvXq3H16/052MqtYlGkPxEnvvXoeMxPzVOl8JijN37G
         3Cu7t3JO96cHe4vOYBn4+X5WNrfHyqgGlC5N56ZPJGe8+Cg1l1JU9RJ8XJJ/NB4mvE0b
         4c+w==
X-Forwarded-Encrypted: i=1; AKwUvBxQGpdLAvAK1Zp4ORUECB1Rkf+EArfJ+HKG+1hZQpndbGE8ZIPsdkHR91bMHrgoUZIpE+cBC83zVprRTg==@vger.kernel.org
X-Gm-Message-State: AFuF++mPaRloqzwKeOUpWnE5AgK7WwMQrVXMofi8T160SILGbMwfi3pj
	ciAn68pP24PtSwyM0MsyNCbhjz0cKNw/Il4+pWAr7XSeWNMCAEZluxyR
X-Gm-Gg: AYBFou0yBuw0p332fceoTfGZDlbDOuBHvgn+qdxC5cHjyFFm6xmhFf/veWFyP2oSdJi
	Vhfhf2EgBsA9zDMVwTBOQJ+CQbdLRd9hn3K4f2lalg0RSrq5UcLqfPNXwWlbbb20CO/GFrmp/OK
	Sj14csOV90lexkONZPDKm8a31CNKc5RRpM8LYge+mOhLbDOQXjKckwSQSg82MpsUTFG1IzMasF1
	CCC4Qma3l7czckWQun8QVOSJuWr5G+jOnHKCkB1NUp0Y/qLPGd0ZRB3WbHDBwBrqoT/wIMpXTXY
	8uSoYB49JVk7qS9rJQNu0+R4b65HhZY/CqUEJKSixZDQHZZcevhgAtiDXHhhgI7KYMaxCJ6wfXS
	0gZuGm0z4nRKRdfUQn3f1BSCLXImV5aNxNoYGGRJIZv6M8VRcS4lBr/wgobmFa9Qs7nh6fqwBt+
	591lynVmGQL1oev/hi1ud/Mo8evx7Z+CjKto3CxDJK0b1WDgYu42co2tCNJ09xldX0MSPORm5Jl
	3wH1ilajX5X/eklh3q/DbwHWQsKuCyq2mBuRFlx9Y2XsWLhcbDXObgpWGsQQ25AhcxAn4OMEI0w
	BIRgZyTLQUFADyD+ezKwJXXkPaBVBci+ncev3qkdnAbtlbWZu0u3BRwpoodqcIBshEVVlibY8yD
	RrQ==
X-Received: by 2002:a05:600c:3786:b0:49c:f13e:e50 with SMTP id 5b1f17b1804b1-49d26dc1012mr14683375e9.13.1789003982600;
        Wed, 09 Sep 2026 18:33:02 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-b090-6201-5565-e933-e630-1831.310.pool.telefonica.de. [2a02:3100:b090:6201:5565:e933:e630:1831])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d26d4e3f3sm35852735e9.15.2026.09.09.18.32.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 09 Sep 2026 18:33:01 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-m68k@lists.linux-m68k.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	Steve Wahl <steve.wahl@hpe.com>,
	Dimitri Sivanich <dimitri.sivanich@hpe.com>,
	Mike Travis <mike.travis@hpe.com>,
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
	Michael Schmitz <schmitzmic@gmail.com>,
	Andreas Kemnade <andreas@kemnade.info>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v3 5/8] docs: kernel-parameters: Drop the mini2440= entry
Date: Thu, 10 Sep 2026 03:32:42 +0200
Message-Id: <20260910013245.8619-6-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260910013245.8619-1-kmehltretter@gmail.com>
References: <20260910013245.8619-1-kmehltretter@gmail.com>
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

Fixes: 61b7f8920b17 ("ARM: s3c: remove all s3c24xx support")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
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
