Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20E331618B
	for <linux-input@vger.kernel.org>; Thu, 10 Sep 2026 01:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789003991; cv=none; b=AubZFgb90R2SFo+C08uvi9jy2XDBQC0pq6OoC+CyrdKA+KQB88OHX9ZAY7mNxOwzsEwD2ikiOJGabYpFZlOfAg/DGR6f0leV+rl1K3pYv2tlmOfsZuL8fz5DUJw1/8gBMnQMfWZGt/vJUKZPEWXIuR3vN8j6j0mWppwBj8MIGLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789003991; c=relaxed/simple;
	bh=qYH6DW3OX6UAw4/JqAXW8T1nZ5UkGcJ820hwItfbiXQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ALjiZ9c/5pwBSBuY0IqfP560g/lCO6fR0rgvO0pp6JYlKzuwMSgapj45k1RKUvKSIIOYGQR3lUplh3hmBPVdpbvXm+CeaTQc1phBrL0LvOUa6aLRVg7CW2Mhj/XV1yzU7VfstUsb9d+Hz2M0kbWZfB7v1v0wKN/rTvH8DrTD70U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VHGsoflG; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VHGsoflG"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-49a97714f5dso62852385e9.0
        for <linux-input@vger.kernel.org>; Wed, 09 Sep 2026 18:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789003985; x=1789608785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b+FNgBRdn5SuYqzApc8cKDhkrkv42DWP10C8olavTwg=;
        b=VHGsoflGoH1EMEKYJ8WhYHFs2hx5YMvsRMtvZFqrxZi4gkkOTIlcRiLxqiKZ89PTpi
         pPJg2JioLNUf8/KeChzI/4Jg6CPTtZddUBlXpkgLJF/VEjiFoMJ36ZNrDBRdJLNljXa2
         KkBgTiMG2f5CkluzgDlEM0njkRz0k4vG/QnS9a6Na8V10UEYtJi2WacXbzkveN3eZC4I
         M2WXHAaWSJD5oLXngZ0Flv6g91kXWJdwiZdX4ygCGSwfEnQeTE0em0Z5N6IAAOG1U2xx
         LWCnckAWNuInTAQJ1HB4kmcbcn9x0P2m8QYpTl88z9zf+tpd3Ur/ngcSu6QeFKvibUJF
         +Zyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789003985; x=1789608785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=b+FNgBRdn5SuYqzApc8cKDhkrkv42DWP10C8olavTwg=;
        b=MWTmGEtUdV/2BqnSQf0NbOjOMjIkR1BGh45WNdWOSDk6K/idlMy3KGpvwTnI72Iid0
         /TncjlQNkeFP1oNoFnbkz+drJ1M6SQy3cn8q2LoTulRI/U9/8rkGZfd9rBnAUmJddEBE
         thvSc6k7IXXiDmIKS3oBeqsBppVSU2dgpvJm9/Fs7g9cpx2EqG+WvtclY75SPDco62PU
         TLSLQ5T0O7X3wHQqvoMfQt3HndViLLtbv3+8nvm9ysBiSxPcx6C3YoPSngotD3a6uxnj
         EqDrGDiRoKh7LN7lCZpFS7NpYISC3J42C+5395XaFpAMSM0gNF2/6iVvXbiy7ctIsVf6
         Z8Bw==
X-Forwarded-Encrypted: i=1; AKwUvBwmYr+RBniOIo6qRyzOxdrlSChjegqmc+gEZmKiM4XG90MGNioTNJbokA/iu56HqAiSlxtx4oHRZOSecA==@vger.kernel.org
X-Gm-Message-State: AFuF++lsy0TQmhOBycWPsAzTzD9jCYZHkI4OVANHqgf+V9hZUXvsmWJS
	1Fx+959lrp2GwudAwl+t1KIdyaEim3EbitTnrbbCiejixP7nUsr9fKDB
X-Gm-Gg: AYBFou0BYGWYM009x0qLxahK+cy4dT19yAYL/LpjnTOBO/B+WdESSEaw1lCMP+2LxCg
	6f7nJZPuFJWmkE12qBQp1FEan8G9noJUf9PVdcFjVU8ekGjkV3Jgny+C30hvEQUV4lvMIclUog8
	gnZDAmgU8W2gK8PmJS+JhVvyER6J7CHlBwDUbSDhXwUWLIYxR1WsthkfrVdW/oCaiwWsxaKzgye
	ys4ZfhGudcmCstXQRpsndxO++1P2jNcx42xea56ohTHpbc4ZNR+SAzaRbbdXiw+SNQxF1mjHhep
	KxjpiRx0bYJ55422Tl9ydIez9HSWqBSgHQ2E6wwuWb9/n3VMo5+SwCIyFZtOfbX+cT6EuSJZs21
	aYpXUGDYQS3QZOKGUf/Iyf7JwA5vl/bsubPcty+336Ugcw17hAfjNXC3siY5eWLrGTyfGxVc3hU
	dfVOYm3gj/Y2KOEyIFzLFJWihYe+hnyjgD2stsUICRGiddQr/mMult+ff3iw7nyXu0ZVmuFVy4f
	NXYUUiOaHB9zP1Ow5+PCCMNeHbZ2TyXTx/RpgQmwp0G1QJLktf6jX7CWIKhFBfzL3XxlQ4grs36
	E4ToIQw+HSs1BbVqbTXn6Z7VL0bSC96QZURl4MEns4HyrHHal7YGItfPOhG1TjIVF4w6in7DY1t
	HfA==
X-Received: by 2002:a05:600c:628b:b0:49d:2856:fcf6 with SMTP id 5b1f17b1804b1-49d2856fe91mr11506445e9.15.1789003985034;
        Wed, 09 Sep 2026 18:33:05 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-b090-6201-5565-e933-e630-1831.310.pool.telefonica.de. [2a02:3100:b090:6201:5565:e933:e630:1831])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d26d4e3f3sm35852735e9.15.2026.09.09.18.33.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 09 Sep 2026 18:33:03 -0700 (PDT)
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
	Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v3 6/8] docs: kernel-parameters: Drop the nomfgpt entry
Date: Thu, 10 Sep 2026 03:32:43 +0200
Message-Id: <20260910013245.8619-7-kmehltretter@gmail.com>
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

nomfgpt went away with commit c95d1e53ed89 ("cs5535: drop the
Geode-specific MFGPT/GPIO code"); nothing parses it any more.

Drop the entry.

Fixes: c95d1e53ed89 ("cs5535: drop the Geode-specific MFGPT/GPIO code")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
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
