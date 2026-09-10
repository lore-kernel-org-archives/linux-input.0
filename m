Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13473644CF
	for <linux-input@vger.kernel.org>; Thu, 10 Sep 2026 01:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789003983; cv=none; b=YZ3hQuBJJZw5VgLXDA6S6rLDMIOLmk3875vwgq6tLivbzi2WAfb8qGlToDNZah01um3egINAqA9UoZYzgu6XXBtApkQdWJlWtwxvVnQwtMWlCleqTXn38Qk0M4BreexgCnZyaMSde0/7ktbH5iLWDz0ZnUnyFIq4h0uO18sWiys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789003983; c=relaxed/simple;
	bh=GhxAkOxBMRZ6zZ0dFT8xEiFSpjQVEMyU/AlCAWxV42c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rz9Yd1SUSUART9MXVSMun4WSnq0hx5hn2Pfnu6sgjQoQS2YqHmBmvivMGMdJoVyESX2/LFwdLvUVZ18oc7tWsPgKq2ApVWnGYFHbvhIanebKplJ6FRGcYVaPRy3Q0ZOihVVxUi8HOiNJAw9KFsbY81fLZUUsi+hkQqGoRQNh/Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FRweCLTm; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FRweCLTm"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-49b96837ca3so50491445e9.3
        for <linux-input@vger.kernel.org>; Wed, 09 Sep 2026 18:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789003978; x=1789608778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sjlutxGiX8pDK8sYanBqVVvMMg/4+no/0Rn14LPE0yU=;
        b=FRweCLTm6hE3ScM5rUKdIWX5D7IO1QOebFr3bYP+SSYn9YSUEJHgyo5FvyiH9fcwWW
         VFae+jdUNq6ZO6o8BpPSdywlUJajJnyod/kMpE+ToJY8Kx3bMwhqTO1MqUQtvVa0/Q4F
         wmZzOapWlNvP9mwiH1l3LoiMAIJ5iIcCxAxWx36PcOth7Ggz9K+SawijHILWpafUrJ+b
         Lk/KRZBmoeYSzAz7fF1VQiQ/y2O06+Ne68fCggfjJmtoBIxkkzBotfjm9RmCGc4cdspI
         YpCuMc2khwnt9wHBpJ98PJ0FGUY+BcFJyrhiJxuny3GHQpD2livSiQnzowuzp9aFOx4E
         TSLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789003978; x=1789608778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sjlutxGiX8pDK8sYanBqVVvMMg/4+no/0Rn14LPE0yU=;
        b=PR5wu2+wKJ9aFVS2oxwr7GTge/jiSGdiwEeXFPhTPqtmTsAImKjZR898uvQ8qCN327
         nex3OUXh5Di27qWpZ1a1uj1hdehlthQaeuybJyDVLNioY+mZO8LoWVZ1zHHC5q2kRwS6
         cZ82DatSGuMaywKfZ0LBPxI3HZGRSxz/CV2fRKNbg1gjm+FZ5xMQ/zNFVFaSOooSoBcd
         aEgM3uzcsXSi0ZUXnn9+//Vp6EQEeEELG2o7BzYLy2WF799DQO6kFde3yNmpDy8hjMEU
         GXdeRpaIIZ0BwnCoNycIeADl40GSW48ohOZV7ThWURsnqkrGZ7HyKfDnVHz7pONvhYxX
         bQVw==
X-Forwarded-Encrypted: i=1; AKwUvBzmN27YuR4DmI/SWlH8u3ZtcH0OA96d2XUTTsW7x1IswEu3ep9mMHDbtz4RiQyorEwRb1CH1xGSnzx92A==@vger.kernel.org
X-Gm-Message-State: AFuF++lzw3NTthSoLesetyW5YzzRt57Txre6ZfbHJwFIHT+KvF9IOVdP
	NzxzNSrDWl/eKvoX0xT2g025mWc5QVyoVlO85yT4tIzce1u3q0gnk1u1
X-Gm-Gg: AYBFou0GtbMvC2hik9S34PyQUbjVLo74aW1MWoj26imJtClJpoBiMxcZPena0pRrTXM
	6dHYjiQUB0xwFGLnI00Iyd3MnnGsyk25NdRNonSiqP6yeDoPugvmYs7f06b/KXG//ZaVMiJYyF2
	PpNoFKxQmENkIl2frbG2/CZzCITdev2cyl20mU9lDlikgZyjSbZpcrylDRgA4Et+1CB/fVbeeC+
	vS3PxEqVanX0ZxhRtlyaAmDw4cNMXfRKMXzTkxZS7zBc8htG4RT40XPxN1hSOWuwJrd71HVew4N
	vIko/sz9LaC9ReXYHk8j4RILayr95pttErPDga+Fwax2xjXC5kEhvALp5hQPxpACMP7bIjGvPQI
	xrt36TQ5tzl+6hxCWZW/9mxjCS+b2rwtBzGrbTEvlYQBB+8IPQR73cZpCnO1KhYzyO1z43oqH+j
	yH/8SRK5c/lYWQloTBsfadExVtQ3OwL/Kr3ujH/SxxmF62PJXhXra//0x1GOk0gS/2NcXJIxN1a
	zOoy6foGPWDyl/I4OisRA07WNs7gpG7hLNGq7v0/uC1F2b4Ofm+JQ4Cqz2h+t76RDSYRZq7Dyu5
	Y1ibzflK5ZCdBWn9zvUDrvpFGNy6IkpcxDAu/ZX+S8D6Jbc68r2W1idU8vDhnn4rw6mA3NkiLhw
	Y+Q==
X-Received: by 2002:a05:600c:1c29:b0:49c:fc6c:be03 with SMTP id 5b1f17b1804b1-49cfc6cc06cmr366891825e9.26.1789003977900;
        Wed, 09 Sep 2026 18:32:57 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-b090-6201-5565-e933-e630-1831.310.pool.telefonica.de. [2a02:3100:b090:6201:5565:e933:e630:1831])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d26d4e3f3sm35852735e9.15.2026.09.09.18.32.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 09 Sep 2026 18:32:57 -0700 (PDT)
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
Subject: [PATCH v3 3/8] docs: kernel-parameters: Drop the edac_report= entry
Date: Thu, 10 Sep 2026 03:32:40 +0200
Message-Id: <20260910013245.8619-4-kmehltretter@gmail.com>
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

edac_report= became the edac_core.edac_report module parameter with
commit fee27d7d9788 ("EDAC: Delete edac_stub.c") and went away with
commit 7fc0b9b995f2 ("EDAC: Drop the EDAC report status checks");
nothing parses it any more.

Drop the entry.

Fixes: 7fc0b9b995f2 ("EDAC: Drop the EDAC report status checks")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
v3: name the right commits, Fixes: tag moved to 7fc0b9b995f2 (Boris)

 Documentation/admin-guide/kernel-parameters.txt | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 99d5bb68968a..2a8d862ef30f 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1578,14 +1578,6 @@ Kernel parameters
 			PCI device even when its classcode is not of the
 			UART class.
 
-	edac_report=	[HW,EDAC] Control how to report EDAC event
-			Format: {"on" | "off" | "force"}
-			on: enable EDAC to report H/W event. May be overridden
-			by other higher priority error reporting module.
-			off: disable H/W event reporting through EDAC.
-			force: enforce the use of EDAC to report H/W event.
-			default: on.
-
 	edd=		[EDD]
 			Format: {"off" | "on" | "skip[mbr]"}
 
-- 
2.53.0
