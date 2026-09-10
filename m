Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C753624A9
	for <linux-input@vger.kernel.org>; Thu, 10 Sep 2026 01:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789003996; cv=none; b=W+SF20eAYb5w0d+7XIyEdzrQEyu7Y/L4HPO8F06s4bR0+yVJPLOmG/Nsj26Nnive9UGUhi3hYmXr2oxytEFslm5XXQkzBefsA+eIm3EqrB9AFEAhgA78UmKqZWb73mKyP4tQQEAla94r55+j+VgL7xy87gFZ6aqNTzejYibuf3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789003996; c=relaxed/simple;
	bh=ZYFLiiSEbPgU0+ZjsS1KNzdvmrfyUGct38CSb+7KC10=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Bczx2AVpUTXkIPXPBGvDCn7HzU5BNBggYtMANNcJl2F+yLtCHmKfE04zEkVIEZCLU0Y2/w5eQn7o3NMp9emRSwWitV/cj3IXZcj8FaJwkV3Wop8JymOHAmjYhNA+D6g4tsAgIBvh5ZLWZDjRWUmkkA+wRJxMw50Vo1Gbph9AIz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CKOsMtbD; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CKOsMtbD"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-49b8e527d63so81384905e9.2
        for <linux-input@vger.kernel.org>; Wed, 09 Sep 2026 18:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789003988; x=1789608788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7gFP28iKq1M/HJk3t4X9byGhtWcmOOGCTOZxmuDlWN0=;
        b=CKOsMtbDLmlvqC8UoICufqDEvkMqZRt2CNhavbyp+Wp4tgCcZvOZel11M4HI5DDmnO
         ZAzzXbIWC1dy0RP9A1G0s94vYDEvR/IfMcm4AokLVmIzvRZGmoJXnyFEHsVQ4ZhfxFxN
         vS/7t5ODxV7m+iWr7weuwS67oq8/8AgHKnG6MsC5+hdHRbHkqRbr462hkCSppYgvs5tg
         /gfLDyDd7IjuI/rLVfo/8ltTx9CDAaHReuOyntpOAHsz2jFwB9GUDKnNR/G/rBJeqiSi
         BSURrWL3KxAM2vuO0xHeT4gJRhUNeK1sSMjJIFbAvI+BweQVtCZaYJhYMQLknpfNySl4
         phNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789003988; x=1789608788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7gFP28iKq1M/HJk3t4X9byGhtWcmOOGCTOZxmuDlWN0=;
        b=kQLY8BcZPK1G+C2aFENzQujE3B7IYlAYkvJo8/l6lYovF6mbP3kVGWVQWMkBTBfGAm
         UGwvu5iE4f565LYwb09pRo817Q7V+0fUW/I5lyUrXeacxnj87FiSYX/7oXRoA53AKd5e
         aAWi9Fbt0N7nu67BynpTzJc5lEw75e0vVZH8TrOdvZqFOSagprUhXtU4r3bZP8DM4ydd
         HTupylCLX1lpyb+AFWRG0YyX3xJzoWRi1gYvH+9WX3tyMI+gdJrj3WwxhKf4Mygw3BpC
         +982tmL08A/WfT3mAaQf1BwdwzpVG92BExnHqgIfRSar5zEcWQZCasxROucUHMSoflNj
         hjAA==
X-Forwarded-Encrypted: i=1; AKwUvBwB26CyXR3vHfL976k1ne/LtBJcGxl5qjqvoCavGAfa3XLiNr40ESktdihJzmcVI2eiN/yU9bCqFwmJUA==@vger.kernel.org
X-Gm-Message-State: AFuF++mIFksC6vjz4dyo8dCgbjY6bWHB8w4VBnAOu3pv88V9T2mF372j
	Dpcrelry1G3jxUjdG8tnm2U0LKCcEfwBylf/NRt8qOWDo78KZh2aC5V4
X-Gm-Gg: AYBFou3myqI8WQM4J0WSFXptZrHqQTGZrZ6GiL76Sn3BWzfROf6Yy85n4fMDMEpCfvA
	XT9BvjKOqubOQtEGOm0ov9Qv6yzvDmfIf2pWD/TKzwmLmys5j3z0r7o8lQfuqPt1OYZgT9FRW1F
	8xce/1ooEooNV99QWJdDcrihc+6zEihHH05wDRSEMUHyGUEBbYuIkAR6A51xB4hqfYcSpWm6OU/
	WPFU9ia1kCQEdnxklLAcDiOhq0vwHi3nio0eto72+7aPDlOoVSYDmCIO72Nh27C5WaDn0Z4FrKL
	8ibCzwDzY5FR5q09rSvImUmnJwO6JQggdC03BpLm6tWUIkBJdKsTMdxBclYj2R9fH/Oofz00L0n
	qrh9pOpOKyzxhOQ4vLZqx2rHlbf4AJWCeGDLspzPfl4YRUs+HwfM1SrCPdj0nNUHqDhw1t0gY+K
	oDUBGn+Vbmu1pdJ+e3PhcipbpOfWLF438wvd+NDPKvF33nA0dR+qVzI9vjyNN7gKTuR4Y+mslWA
	OFg/7WGkCxYEi6yrBaIgkOarDqWGbnuKdJl3y5l+Hw3MBAUSChHibg/AkXNUTmdFyOeetHp7zMy
	m3zW2o1gVV1cl0F8AMELq+gCzfnRfJWckYKu2yNyWNVHfo23yE5Itf1C9Bol3q7JM9FUUMvtfk9
	ahUbg0onhuAmk
X-Received: by 2002:a05:600c:6305:b0:49d:2803:22fe with SMTP id 5b1f17b1804b1-49d28032d49mr11185475e9.32.1789003988252;
        Wed, 09 Sep 2026 18:33:08 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-b090-6201-5565-e933-e630-1831.310.pool.telefonica.de. [2a02:3100:b090:6201:5565:e933:e630:1831])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d26d4e3f3sm35852735e9.15.2026.09.09.18.33.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 09 Sep 2026 18:33:07 -0700 (PDT)
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
Subject: [PATCH v3 8/8] docs: kernel-parameters: Drop the pcmv= entry
Date: Thu, 10 Sep 2026 03:32:45 +0200
Message-Id: <20260910013245.8619-9-kmehltretter@gmail.com>
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

pcmv= went away with commit 7aeffbf2ddec ("pcmcia: remove unused
pxa/sa1100 drivers"); nothing parses it any more.

Drop the entry.

Fixes: 7aeffbf2ddec ("pcmcia: remove unused pxa/sa1100 drivers")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 48dd273eaf6c..4864e37005be 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5311,8 +5311,6 @@ Kernel parameters
 		nomsi	Do not use MSI for native PCIe PME signaling (this makes
 			all PCIe root ports use INTx for all services).
 
-	pcmv=		[HW,PCMCIA] BadgePAD 4
-
 	pd_ignore_unused
 			[PM]
 			Keep all power-domains already enabled by bootloader on,
-- 
2.53.0
