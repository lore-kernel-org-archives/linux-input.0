Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9457F3E008A
	for <linux-input@vger.kernel.org>; Sat,  5 Sep 2026 07:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788591856; cv=none; b=NSgEv3xJdVaY8KEE4T2R3S8R2arlalwNejIcqNuO2BSQwAgZ0V6qO6SpfYibHWfpDS84fVx/LTvwIUxRG4qDev6ialjLiqtHH5QyTugB+xx1cYBNHP3cF+7kJSQ3YrzCfmiNxShKNBlXu6K4lF+NW5pwwj1RG6g17N3XsJ5ADGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788591856; c=relaxed/simple;
	bh=8GOJ1bBhkXnXFQ/xtc+4fZdZejRnue5u+K5BgJsvQus=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q6cU2L+soM4IRjxENvFrJRMw/GzlhQHqADaC5DdONdUVnA/6WbaPskvRKQNiryFiABvxbBp+bN0rgotBKBAnTrkI8hVp81g3HIQ8k6RlcLLmlMO6u0LsCRHq1jXvfSEE+WiAyzcfisDOz4mWuO9T+72+i81rAfBXNMigjkDG6L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RncqAtK4; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RncqAtK4"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-49954b88fffso13162585e9.0
        for <linux-input@vger.kernel.org>; Sat, 05 Sep 2026 00:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788591846; x=1789196646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OVDepIdvewIAkDae/qknvPHnA6zOWa1HlsWKZdzZmcw=;
        b=RncqAtK4nFcBPPTgUs8AMiwXa2wMoBlgCSap1WCpkog2HtcMl2dY0x6D3q6dmaNRdv
         dICsimEaPz30ld1lTg0ZiKxsLwFIftpMqaKvhdk05060EGt0E/TH9wY1NjnUxgLHrxpl
         xv5k835yE02E708d8v5CHjGi4xQDLYi0grCez+M8lkOCwlFNTWgxrabpNifw0coZTVKl
         3M94khTCkWfOlr56gra/i6mPDGQC/HAyeu9sioXVfRX5a2izI+B9jI0HqjvLPJSJ2uKQ
         o9xkwaqBSsK6NIKcOiZXcWQmBYJ8fkAy8Nv9UPXWxOtAtXNA6WCvCEdNkipGdHKIoSXo
         6zGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788591846; x=1789196646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OVDepIdvewIAkDae/qknvPHnA6zOWa1HlsWKZdzZmcw=;
        b=IH22Cv+0aBgB+HOu6UrxvmoG3C4o07HDxvHWTDrFE5d677MXhKHLaBEFLq4I01QfK1
         10uTaRhjfCnCh0yQaxtvdfU4BXGK9eMyUrmKpjp5iFv1Rnw8oYUGcpfHihF/bKB0nvwy
         AS214qVCgkqzKmnzg+BT2RtRcNfQ4mSBO+x5VddGIpCm2tL+N82ZO5UXmk4uzRn1ijAH
         TwRIEmm4VI7dnRy2oViLXIJBH1rNQ0GaBoXrWePi/ttQRUs8zm5PF0tYb9fZh1z72gVZ
         UKhH8sMKMH3walM5WxXAMPBl+HrABJFQf/hUSDDNkC3KH9sJvPoURpMz8Eu0p87m/a8i
         Wwlg==
X-Forwarded-Encrypted: i=1; AKwUvBx6cHcPMo2E8nalWIiLQr6IivAS7Ze2KnK793lxwk975SEQAy8mNtmxluhq8rdeT/DmdyRvj9/1WgyJew==@vger.kernel.org
X-Gm-Message-State: AFuF++kt1x2AlT8W9ZfwfRSGlLBuYij+B5lyo7vfHKv1gW4CE2WXNMmm
	Ne4LRBb3+95BV3Jab1J+aFQn+VTbLluIKSnXb8WkxXu7i+StXKhwqNZt
X-Gm-Gg: AYBFou0Cafqg/k+A8dKO3UC3oBQW9+0qjQf/o6uH+/f55XkVXL+XueAZMkg1C5lFfb8
	N81e8dpd7z8PDUtvHD/JSb1q1wqpXsGuqQtBGRwjRBc6GQ1M9XAg1zTG6OZ+wkywUQEvI8gF+0b
	birfA6Vumw5IXvlMjVnUPqP8JYoTcFiQ8Kw3Y3dsMhs+Rrph0O6tuZ6gdIAEwMgxhq/Bg8w7dR7
	Nlg3IkctKrKsUSRVIlIlPn78huWqCjNL1a2WmBe4obHQy8W1moWm8FlZqZkmlPVhA4FKu+a+XfS
	GWmLZ2VGXJx3saGOOAAIDmGdfbxp9IOasSvAy2rd9aO5tso270LFqRFMxbJZE5Bplavo953FmI0
	LPaCLzz8mKXLrb4UIIyQVNXsTuwwC6a74ggztM2I6/mycrxili3zqyNlaVj9zDru6IVhNyuWQ2/
	2hRhkYyedSay27TDcL/8D8XCW+FrTl1AH9JHPEDW0boMYbVCrBeM9Qc2lqzjmBKuC2CWHBA1/qz
	rtci+cLFbQfZ172yrc+L2xhx9DPVgqZEPPjd/PCyjeyKfgfAjL7GPsR3fWB00Dmp5sZacSEtcuG
	B0ld6qmjOHPLwkBBgOI0qjh/3GSv9y2wthAz54f/o6PygbEwZAvOHkUX8XdP0hlQvxfLhThz
X-Received: by 2002:a05:600c:46d5:b0:49c:fc6c:be06 with SMTP id 5b1f17b1804b1-49cfc6cc142mr76992175e9.29.1788591845868;
        Sat, 05 Sep 2026 00:04:05 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a4eb-3001-c06d-af27-9fa2-ea53.310.pool.telefonica.de. [2a02:3100:a4eb:3001:c06d:af27:9fa2:ea53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485885bfdf6sm12011719f8f.34.2026.09.05.00.04.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 05 Sep 2026 00:04:05 -0700 (PDT)
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
Subject: [PATCH 6/9] docs: kernel-parameters: Drop the nomfgpt entry
Date: Sat,  5 Sep 2026 09:03:44 +0200
Message-Id: <20260905070347.25902-7-kmehltretter@gmail.com>
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

