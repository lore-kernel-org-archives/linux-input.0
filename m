Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2CD3DB33F
	for <linux-input@vger.kernel.org>; Sat,  5 Sep 2026 07:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788591849; cv=none; b=jyLHIgxuvFynOTTbIn8vDsD5wgyfMUsrriuG3mWchkEjvWcWwXlpt8Hr736NlhoQXxEtovIVSEaJ2SsNnyWzMcxiisEbzPxWsAYJ6iUcd2MjvwJbBKJCe/gW99XIFFDKYmSd5cYSlwuE2KDy0VqcBHRz5Ar2clgsCJ0r3XjO3HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788591849; c=relaxed/simple;
	bh=YsfDHjDKsIWAkoUgaj1imFKWTfOFfJnvMXwuV6H0pgE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R0GMimDYgb3VnDntpL0B52GT5ENpsrkzPSkw/I11U4kNl8PgL3a/RXXL9QaRK0oNxLXLEaXCZLwKthP86KYvEy6ry4M8JktJCxuDxN/bDCCl/QhC5Gxdtq1u1hc9NGHKYRZO5UVe66MHDvvyRsSwVZeL53GNWPXomQriqBvZFYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CTgk/Bir; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CTgk/Bir"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c1712a04ddaso295340866b.2
        for <linux-input@vger.kernel.org>; Sat, 05 Sep 2026 00:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788591843; x=1789196643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9h3cyhQ1bY0apuRrAImVycgRtlSF3vYdx1yKBS/SgnI=;
        b=CTgk/Bir/irm1HNOtFUvU6UDv+QZsqLHmwn3U1pGvJvT3QHNNspH2iWM6hsvRzd0rQ
         +UBq6r6+i+ciz9GE1cNac5fERSG3fs531KyW86jZ4vkoKuZhDfTmhI7UhkPRKYUZmK01
         MgDyFOjl0fErZ+P01xZbNWAla+v84cUhIsRo7x3Bd9TmDbPPcPbjc9ZQjtLwW5ne+6jT
         w3JZtCZxqL6zrMQZd1HZSv/MFn2o+HtGLaXzamx0uFvJ4VWnHe7uUsowPi7AUWpdqM+6
         jIIak06kMPVed/xh1N37YsqjOe1Tpncqtc1BaaIYFR/Z5MraNH0XqCTmj8DSW4V4yRLa
         jG6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788591843; x=1789196643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9h3cyhQ1bY0apuRrAImVycgRtlSF3vYdx1yKBS/SgnI=;
        b=CfStu6l1F/MQFgTYJBSaePvmL0IWC5ThRG4DGDQSo3tRrZceZeDN/WxP7wrsQtiUWX
         1zf/so53DPhPlyc/Gu6tKgikB7NPI1TVXTRCllIkeZ5B9O9lwN+ipe3XXmN9NnfEJDY8
         5+P56d8YDfmBuQPuRduH5xPAX6UN4e09ouvBDmPFx4UQZoERIH+NCmK4HlAF3lbY7kvs
         CTm8p3rdEHxACUUdEl9KmyeO93s7Jet2De9+lUYWazK6GtNF4d4IFqSK6CBVQz3K8qpj
         +inRsoDUGjGxQLud6cg0R5FlbA5IDF6db43nkMmwb7V9XAnkwVFxk3WJRbTEGlAjdIr/
         uiLA==
X-Forwarded-Encrypted: i=1; AKwUvBx07V01IEMNw1mWaDIf+lg15lB2ui0Wi4LmRMCMRLq/MFtrUNpv5jPN3rjqX7lyoHGrcmy/Nc6Sk5PmXg==@vger.kernel.org
X-Gm-Message-State: AFuF++lUk2J/5EUoieiNiaxXQ0KOATl1XB7oTbEcUlM3mXdR6qEl1px4
	PITRfD/NhGxSEqz2e4Q0EVc3g4XKAGA4VApIW7V6EDSUpZoQ0GoIiv8L
X-Gm-Gg: AYBFou1erdtN33m10wbhzAwyZYnt7BzP87GMhLPzeGrI46/UhcAA9pW0sBnC5ujifv0
	ItUaWvu5SZE3mziKGOCcGDzIX0e7xvlK58AuooNcnBC/mAtxB27V3qKEXW+BVjbCD87lwVBVHZc
	t9TCRGbYLxmeDHodGuD4S4gsgyOyAyv1rZMRYcgzA3Rg+emqdkwl0rcPDJ7eUNCz1JoRz3aCRcv
	xjGxdjjjlodWOiETnMwvCFkxQKUjzeIiNcdiN/9aNZ5bFX+wTbLRCDtpfkriJeGgrhJzXspwDbL
	cBN343gWr2k78VdZjlITZ2NTK84XGr/gckHcfF1gNkq+hzSdsmwb0/elEzSl3HtcfjUMoPOw609
	htu/COTuyztAaoJ2HaF4sgWT7MqIPSg+Zu6w/ymBZXxRGIsT4Rw1iZ0ZzyfCA1qH6RhFsSsSara
	m4OuQAxpAoEQtiJ8ybQ6vvmjfvr4sbcKz8d53EzGsRvvq7wbhqlBM27ExAuQhkz3lr76iMM5C7X
	LRve3LZsQdeUbV8vLPgwDN7KBCxp0xXAB3B4OFO8oco3afqecuwgOIj6tNWeAnL1DxDSRBBtoKv
	UryOloCLDFMllD8t2fWRYa8wdKdZBCwKTzkVIjw55kJ3WWZee8tZ0wXESXuPISZQaQmiUOcDDg=
	=
X-Received: by 2002:a17:907:d94:b0:c16:4df6:176b with SMTP id a640c23a62f3a-c260ca47420mr442803966b.20.1788591842595;
        Sat, 05 Sep 2026 00:04:02 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a4eb-3001-c06d-af27-9fa2-ea53.310.pool.telefonica.de. [2a02:3100:a4eb:3001:c06d:af27:9fa2:ea53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485885bfdf6sm12011719f8f.34.2026.09.05.00.04.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 05 Sep 2026 00:04:02 -0700 (PDT)
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
Subject: [PATCH 4/9] docs: kernel-parameters: Drop the enable_timer_pin_1 entry
Date: Sat,  5 Sep 2026 09:03:42 +0200
Message-Id: <20260905070347.25902-5-kmehltretter@gmail.com>
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

enable_timer_pin_1 lost its early_param() in commit efa2559f6516 ("x86:
order variables in io_apic_xx.c"); nothing parses it any more.

Drop the entry.

Found by cross-checking every documented name against the __setup(),
early_param() and core_param() registrations in the tree.

Fixes: efa2559f6516 ("x86: order variables in io_apic_xx.c")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 2a8d862ef30f..f4314492953d 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1647,12 +1647,6 @@ Kernel parameters
 			to discrete, to make X server driver able to add WB
 			entry later. This parameter enables that.
 
-	enable_timer_pin_1 [X86]
-			Enable PIN 1 of APIC timer
-			Can be useful to work around chipset bugs
-			(in particular on some ATI chipsets).
-			The kernel tries to set a reasonable default.
-
 	enforcing=	[SELINUX] Set initial enforcing status.
 			Format: {"0" | "1"}
 			See security/selinux/Kconfig help text.
-- 
2.53.0

