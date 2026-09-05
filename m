Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB9C3F3273
	for <linux-input@vger.kernel.org>; Sat,  5 Sep 2026 09:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788601635; cv=none; b=oa9Ltj5DAfr5yomv7UabSxVJZLXHL9wt1ZrVD4WOGTN9jFURVSAdWg4nkCuTJXaZzzEBQhvP8pENY2HgUcVRQm4DKsH8DxaYS40pGd+0xukMd/zFBsDqwECIXxhAQDV9IBUcK3mjEl1MOxwCvHGv1hsdGY7Y4d+4hcmr9qNKdQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788601635; c=relaxed/simple;
	bh=BaEoG/6SLaF+j+PN5tp7+Wdp37OedR46Vcq2/qxVkD4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Gtfa0+NCTXZKAhdNqyvHOtHYX1tcpTK8JFh7pcYNBejki5tpfAeSqlkpVygaVqcWk3OGwlYgn0wA1EbwTV/dcRDW9jsswcv8J2y3ysIgS8WapRlPRF+O8IjjgUSE5bM5+HX4qcD6x8uyrES+4bs1L8Fe9ezzTdLmMP01splkpyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sUm8EgSF; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sUm8EgSF"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-48441a2ba1bso1224476f8f.1
        for <linux-input@vger.kernel.org>; Sat, 05 Sep 2026 02:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788601624; x=1789206424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8I1Jlm5MucKkfjFwaOiA/wi4L8q8pr7cNwUH5XJFU8M=;
        b=sUm8EgSFwuePVR3dg/8YeD3vvUCBHQyHHnli9XsusR7+vKD9DDfKLAcOuqxV//tEjW
         bkQXVykoOZYpgWQtwadrXsG60ZWuob8YKhNQOlMpED8Vk5Wq1OmepQwNLFTYE6mHke91
         PXt43eSDBYW5Qy61QkbR3trMXG79Klg2Ib1TuQT9xyxDyAqdI47TYUvTLLuWntcf0Zx0
         uVOjx9mMgo+mOVdU0gyCodl4l0Q4Visp/sm148NDD5eWQZ9gMf7DoPuhujlRgnfcmHGo
         bPHxEDLBltbFqDE+NBRq7Kz+3RpiAd5tSck4yhiJQmLb/UMVxDlDT2QsPYRPnJCdMr3Y
         QmeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788601624; x=1789206424;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8I1Jlm5MucKkfjFwaOiA/wi4L8q8pr7cNwUH5XJFU8M=;
        b=Q48tzcfhcLy4viHEYdimkGWejpKQAoBNI0Wmf8BHJMKor3qvx+STkVLsrpPwSUu0cc
         HRJi93jmfjadhBzS+xJPcSBrGZ6HIo+HrtE6XujROUGv1B42T8VsKZcFC6Enk7Vj8Y/V
         hhEWnGD2q249eoEvso0k38OdBcHKpbRFvRdrZL1GgSqoNNEtiQzhv3E9WDXrFk2XqFLt
         xxAnLxEXCyqQNGdID//KWilsaTEdZGzJ3MbKtF+RuhFj5obc0HUicFbQHyoCpbGxLt3J
         NfxOqwmPu5/DGMiKWmS+mP54oUW+VOzHYoR4k0kWvNyb7KsQr83PYnhB6x1ZSB3qWt1m
         P2qQ==
X-Forwarded-Encrypted: i=1; AKwUvBzP9azDYSsPG+iXmi6PVqfeHEAdo3qiKHqU/S3nG6E4cmmpAjZQ50sE7s2AuHSCHfFIz8jqyNDbA7z5Hw==@vger.kernel.org
X-Gm-Message-State: AFuF++nkaSUmLNUaEM1Z41tTkHEV0F3ztgeKwvCh6+6dxmowuU65+hzP
	qRHZj8za0Segoheagp+4wB6mrsQyXtzt6CuiRWZhGXZAH1AZ4hMCvqhd
X-Gm-Gg: AYBFou2kvAbhZEAlxBhDoXkOeWXPY1dg1jkgzvF5RQFoltWhG/VJO+LxmNKjbbbXS2H
	X/0r/za5ixdO+0h++KGFCqZlxTGGOs3AT+59UTv/nZJJlwM8858HoKmvHhteznID0VCJW0e3nKD
	bTFSIYomrugoJpAvBxbBgji+GIauEuMirREdt+WVPtWZYZUnOr4pMdRkv0OaTGVmEM906BkPmDQ
	JpCCgYxYhbB7Jvimmuop+BMEv0Z9ApSTsNDKevJtEUoKmgPLcxoJZuCe4Fujfu+ld9UHK+Tqp35
	7UgxeUaKdCtICHAs4YzmOOZPNtCGwIcYKYWF45iDcQayrg/LNOGMboIhyzq0Pzuv7KEVU6rV7LU
	MhN64dHtIQL72/z4Vj77AcH8qcOwgwSdrYQSFKMvKFXkTVj2AJvJu+6oQjjgS2g6wcPY84Ey4ef
	9TIH6SHwelcNhsinrobcgHy3JD4QWrmgewD/fQpGJzRWmmnTlo5Ks7l0/SIRiymMPUqsW6T+U+d
	lvRPsDPoPeK7CvkYM2VNow5LG7Fbmit1/CA13oLk/TnPcWuBO0F8dujXzeHSqVnkiQa3GK+NuiX
	r+LPxIAQ44XwY569+bIpV874iX1P1jWiSi+Go0imOUJvtt/eEryfTST8Nc+PoZIHb4v/Gki591y
	kJQ==
X-Received: by 2002:a05:6000:18a9:b0:485:9211:6560 with SMTP id ffacd0b85a97d-485921165d7mr3155784f8f.25.1788601623937;
        Sat, 05 Sep 2026 02:47:03 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a4eb-3001-c06d-af27-9fa2-ea53.310.pool.telefonica.de. [2a02:3100:a4eb:3001:c06d:af27:9fa2:ea53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883c6ba4sm14232013f8f.25.2026.09.05.02.47.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 05 Sep 2026 02:47:03 -0700 (PDT)
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
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-ide@vger.kernel.org,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Michael Schmitz <schmitzmic@gmail.com>,
	Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v2 2/9] docs: kernel-parameters: Drop the bau= entry
Date: Sat,  5 Sep 2026 11:46:42 +0200
Message-Id: <20260905094649.41996-3-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260905094649.41996-1-kmehltretter@gmail.com>
References: <20260905094649.41996-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bau= went away with commit 39297dde7390 ("x86/platform/uv: Remove UV
BAU TLB Shootdown Handler"); nothing parses it any more.

Drop the entry.

Found by cross-checking every documented name against the __setup(),
early_param() and core_param() registrations in the tree.

Fixes: 39297dde7390 ("x86/platform/uv: Remove UV BAU TLB Shootdown Handler")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index c8d96de4c00d..99d5bb68968a 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -624,13 +624,6 @@ Kernel parameters
 			Format: <int> (must be >=0)
 			Default: 64
 
-	bau=		[X86_UV] Enable the BAU on SGI UV.  The default
-			behavior is to disable the BAU (i.e. bau=0).
-			Format: { "0" | "1" }
-			0 - Disable the BAU.
-			1 - Enable the BAU.
-			unset - Disable the BAU.
-
 	bdev_allow_write_mounted=
 			Format: <bool>
 			Control the ability to open a mounted block device
-- 
2.53.0

