Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26B4313E2C
	for <linux-input@vger.kernel.org>; Sat,  5 Sep 2026 09:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788601638; cv=none; b=UIPjoz2tUcUSITvhnipkEGnuI9qD6BvCJLtJQbjdw/T/Wxy2MuoRIVZecBKpO5nRuLkVhTNwt5/AJBpmEjUZkysCZ8HBgLitZN7IQw+GSD84EUUQeZ0ZTKBdeCmnvhz+Tf8PIklIo8SNLmNAmwR84az7n+WWKUiMsfU8LZcBsy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788601638; c=relaxed/simple;
	bh=8GOJ1bBhkXnXFQ/xtc+4fZdZejRnue5u+K5BgJsvQus=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HP7RAxPTEHtMQfATRwvJ7skoAn2KahARQ6x2fuagJNzNRMEdvoh83k4e5ei7GoCC4f+RlXHLQ5RoLbXVyRVnZMJdA372PD5iOezyY0Ob+V5TB4Hn2EhKStwOUn7hF9V7HGq/rkZtgtqqITFGEpbv9sUrTKJhsLaulgBdu+oXqbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ucx/KA64; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ucx/KA64"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-485850cf499so1065524f8f.3
        for <linux-input@vger.kernel.org>; Sat, 05 Sep 2026 02:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788601631; x=1789206431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OVDepIdvewIAkDae/qknvPHnA6zOWa1HlsWKZdzZmcw=;
        b=Ucx/KA64UP7YYy5FQQDaPv4iVpJGN9cu4a6gtRoYPN/MlsoWrBgL9kqhFiscfmpZzL
         r3p6A7rGwpSo6U00Cb10wjtr+mD6z0RLWlLAGmEE8eyqONRmuXoNkL/FV689kTIzZBWP
         gqEKeCMO2k4MN8VMPu92HuDd0AlqnTh1jQBi+ZvkLa0A7mZOm9Tkn1+mZhoGemzlxztQ
         YEtV2aJBvuK1aZt1EKWgo7D5sSEqC36gCblrWzvmQX3yyNe04+mJSOI0JWRmrg1dVZ71
         oylWSAJmkL2qP7fdvg4GTZMjKK5y7eqyXLGgH/+rq8Ob1Xept9jfj6uuti0/qYNUcrlG
         e3cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788601631; x=1789206431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OVDepIdvewIAkDae/qknvPHnA6zOWa1HlsWKZdzZmcw=;
        b=WZWk9VyWGhQAX7hfzyGNc8+K3XURanj53HV2aXoBymTXaTGpK9jdtXvhVZzhq4OO71
         +JL2hdtrP3SLH07h2zo9PziBTzq2ud12hGMf8OgC++rqbi1NnXR0UTzGpO+8kwAtli4a
         8jWefpsUXHMNiYc5GXF0zp53sVRDZqOCPM9fsVxqlNdjC2d0JcusV9jC3Z/oCXyP8Psa
         wpgxrAdnfHO6EdRU5DUyyEmDujyfDjTlJpiE+jQeLuXsxKem8dD2Kvd68NdCwwlzbwQr
         pvkMdpX5GjE2pq41szhlbD/ADnQ0srWrsJtvVOK7Dx2DVUFUxGctpUglOdSEJCugpaY9
         aNnA==
X-Forwarded-Encrypted: i=1; AKwUvBxvSOQpsEhoHfBSDbUWqO/q22xI61uAwVuP+5SS9xYZWbKX39vFr9oYcOJA94pG1wxE2D8DwMBfu4ctrw==@vger.kernel.org
X-Gm-Message-State: AFuF++mwzZHwIVEcdu8CjoZHPi8gV54OOcVovw5p6u9WX7WxHe4DG16f
	er+ytIojgu24qz5gbagCAlTZjiDWvSnBsqUQt3EsLwVENk3XpJDRiRhS
X-Gm-Gg: AYBFou2UuGIphldvx2iMWB7/dLfwzTtR+mP05DNMjgCLoAQuxNMxd/h7G+Pzd1zc3wy
	smU4TwGQfekw6tpBHxkEH/cZO2jz4bHyMsRc+/0F4QBG35Pm3CCXUzJpODVBjK7daQ34knWQAPw
	YELw13YIpFsp9wDKcY9toQctkWXvUbLBrC8jrBXQ1lS46jFhgYjN0mTeZrfsvrnW3fnODgh0zKA
	5dIxjK6ealQ0MXdXBEWWUocHHaWQNuVG9LaGvLsLO44HGJa5EhOWTJ08DWOACK4pnrJYAnF1Mb2
	ZxSZ6Os4n+RxT9PZ65CV4DTD52DFwGBMPusZHakBfq4a/6gwpSsBwP2+SiLi32FuWl272nBIyLn
	+cwf97q9FpzJc8rNW6Rumrty7IAS7cdCldBMVDSlQ18Dg9I5sSiJHPYf2wy3K1o+0FL8PHgd6ef
	h8Xzr7J1fCGYN68wZyijjg2+pEAmDwhfWr7m+nfiDiwSLLr9fC11hl6b6s3AQaoFmD6iGwU6pFu
	mA+3qbk10AX9n75h9A/qIOgcYDmNaG0ktJxXbH/Ee0hUCC325AC5MfSQdrEddA6hbLeEhdU51Gj
	1U682FKzgFdQm9do8HrnCppCvbYWXcYgOK/NgZ2ycuTZl2km8PTlqtdGLpTweq2ufptp
X-Received: by 2002:a05:6000:2584:b0:482:b813:8315 with SMTP id ffacd0b85a97d-485872ac3b1mr14547032f8f.21.1788601630963;
        Sat, 05 Sep 2026 02:47:10 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a4eb-3001-c06d-af27-9fa2-ea53.310.pool.telefonica.de. [2a02:3100:a4eb:3001:c06d:af27:9fa2:ea53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883c6ba4sm14232013f8f.25.2026.09.05.02.47.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 05 Sep 2026 02:47:10 -0700 (PDT)
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
Subject: [PATCH v2 6/9] docs: kernel-parameters: Drop the nomfgpt entry
Date: Sat,  5 Sep 2026 11:46:46 +0200
Message-Id: <20260905094649.41996-7-kmehltretter@gmail.com>
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

nomfgpt went away with commit c95d1e53ed89 ("cs5535: drop the
Geode-specific MFGPT/GPIO code"); nothing parses it any more.

Drop the entry.

Found by cross-checking every documented name against the __setup(),
early_param() and core_param() registrations in the tree.

Fixes: c95d1e53ed89 ("cs5535: drop the Geode-specific MFGPT/GPIO code")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 2ed1e2c03c61..d44728a45506 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4553,9 +4553,6 @@ Kernel parameters
 
 	nomce		[X86-32] Disable Machine Check Exception
 
-	nomfgpt		[X86-32] Disable Multi-Function General Purpose
-			Timer usage (for AMD Geode machines).
-
 	nomodeset	Disable kernel modesetting. Most systems' firmware
 			sets up a display mode and provides framebuffer memory
 			for output. With nomodeset, DRM and fbdev drivers will
-- 
2.53.0

