Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB633DC4B8
	for <linux-input@vger.kernel.org>; Sat,  5 Sep 2026 07:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788591855; cv=none; b=o7KvNDSbWj6qeX93hk7+Tbzjn8f61VTxBfiiNL4xGhJ41QyhrrIT5LpYBog1XzT0YWkeo8ePZ4fgkRj3ifbC662WarXzUJxT33qetkjFWEKp0LuQ9ZetA1WukUW/7gL2CTSeJ99k9Un+EM8q7pbfM4iMVom/AwzOiiORswwKK7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788591855; c=relaxed/simple;
	bh=ItZT5GNunHVnueIdaFQjAOk/BPjP1n6HkFAdihTWgYU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WX7wzyhJZo+0xjuK3M3YSh9aaqv8aJsk+ZjCJQVL6gdFM4KednhpExfw9t4ySVV3J2vhItWUKiNjQ6QJQyUewxPUaG6iGu489shNRienwAXXhFmXpkfExJKkwnmrK9+IzTPt39b6lDIqnj7Xk0KHx7ZxchMB7YFHD3ZhTSziHxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ot2TgaTS; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ot2TgaTS"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-4858be8b509so679093f8f.0
        for <linux-input@vger.kernel.org>; Sat, 05 Sep 2026 00:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788591848; x=1789196648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kFzQQFmCjPVcuR+l7FGQ0u8MffPmow8qd7a6fWjai5g=;
        b=ot2TgaTSFyf0JGzHOS0qVEAf6ZxzDDZ9GbwaoviLSwiAMvTFLOKcRxlwvGcTuqHzw5
         EkRs1xP7nf03aZMrJAMt2A4vqFH6X5rfGTK0/Vyri5Ijk2c4UffB1TcG58IRkXtYgSV1
         Lqiczg4F7DVsT/bfD8Dx4iw+ZCRZ0G+oAO5ESiQxUiSEN3HFL52rQVd2QFAYy01WVJvc
         AuwmYB7H4ehU2TRk4SWu99reuV00ExXtZkNHcXcIzps/tOjkWE+FX3P8hYqnEYJ1/MCI
         dpBI0NJG8Rj8bLcFMvzVpenCY3Q55LPB62VZMu36usLLEDEOOWtHzGUhvARquerAn5BG
         Sbnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788591848; x=1789196648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kFzQQFmCjPVcuR+l7FGQ0u8MffPmow8qd7a6fWjai5g=;
        b=Kh+qE5Sa7WWX0pzbkXHaQPusIvVeSDvZF0N2Cr2QFy24kaTlIgjjpJaESQlrIqKMxM
         WrumcOREsUSbZj6gcJDl6iYDjYInsISRWBdO8T8S6NHsPMV3SiYY/klB3cga8lg0UQE9
         zfR6JlXu8AdhiY8BIjhy/WlYTfaEGwIrjvXPXKMTB992neckviaeMasRm07hticYTOq6
         LRR+txOpQrfP/iTrOnZn6iEFRukdh12353CM3kmdTGzsmggz3j+N5dTBbmSJjrV6d9dB
         /mEvttWvPPhcfqnam3jAu+3CoqG2fE0s5v23fJMmEzKEzGkh9Q8YYmsjgIf1S7jucOzg
         8fuQ==
X-Forwarded-Encrypted: i=1; AKwUvBzHUwHlhZvFGU7R9lYRYvvN9L0kcZ5wKjAORh7PDl/rzMttuNu1qER1vei2e5dte8tWZLZL8WfGi9geVw==@vger.kernel.org
X-Gm-Message-State: AFuF++lVJFUt1/jVBcHdf337IVYFh5HP8CLUrTRu0AZftm3ZzXfF4mc9
	J1l/R4wTQODPAJTpD0MgKFd/ccdqyfOIUZf5PFd33PRX7obO9ROvEMZH
X-Gm-Gg: AYBFou0DSGTBFx/c+MmDYcNK5BG6gRgyLMaayZLvq/aI6e4Qs09R3yzBVQr3pXxOB/2
	qishCnrni2Q9zc1mYfcuotT3w1Lfp785sSWGE+fMVoLudUueuoCMg4R8mRi9NnJUjG/OMAJqz6/
	nVEoOzhcv73IJRvlgKSHxbuUr3jkF6wLeQ9VJ7t8RuEoUd2BJrCbU2P5454tIKuAbvNx2XD/8pS
	hTQxzubYD86gpCIdCWCJiJLArbDQeWifUCMRTKzIQpBcYjSfF81SH/RgcB8+v6H2lyDWs0iROki
	tdUa+HCArTcuVdmGHgBCCoMXDhb6wJ/npvOelLe8dwMrcPxkeQSiIuf4t+ifylwAmgXQZzBulKT
	D8wNSzeBv2gpH5K+Qb3xSipMa6534+hGmnlvAkprng8QFt8V1iKN1Xt9ONmqvjJdyjDSer8Vrnn
	uEenNpkbzF2z5HXgQ2vKSr761HdtGGer/4Mtujv3sSDtYKgt77jenNThQB5ptn2/MdYjvxYIs61
	8Qg++cpvbIwJPmrYkWevBprWNAO1ZCl1dNLsnc6pbSwUTv57dVTsVz7lSh9twWVunG58e4gJqif
	UL4XMTQiF+H5GnJRBG/d7urkrdC0iQPJBavbKV0W1RK5MP5p+kQPoPGFqZx2+rIFpSLG3MRkd+n
	/pAtw8Kc=
X-Received: by 2002:a5d:5f55:0:b0:481:503b:b663 with SMTP id ffacd0b85a97d-48587091856mr13328658f8f.18.1788591847580;
        Sat, 05 Sep 2026 00:04:07 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a4eb-3001-c06d-af27-9fa2-ea53.310.pool.telefonica.de. [2a02:3100:a4eb:3001:c06d:af27:9fa2:ea53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485885bfdf6sm12011719f8f.34.2026.09.05.00.04.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 05 Sep 2026 00:04:07 -0700 (PDT)
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
Subject: [PATCH 7/9] docs: kernel-parameters: Drop the omap_mux= entry
Date: Sat,  5 Sep 2026 09:03:45 +0200
Message-Id: <20260905070347.25902-8-kmehltretter@gmail.com>
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

omap_mux= went away with commit e9f5f1e45608 ("ARM: OMAP2+: Remove
legacy mux code"); nothing parses it any more.

Drop the entry.

Found by cross-checking every documented name against the __setup(),
early_param() and core_param() registrations in the tree.

Fixes: e9f5f1e45608 ("ARM: OMAP2+: Remove legacy mux code")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index d44728a45506..48dd273eaf6c 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4765,11 +4765,6 @@ Kernel parameters
 			waiting for the ACK, so if this is set too high
 			interrupts *may* be lost!
 
-	omap_mux=	[OMAP] Override bootloader pin multiplexing.
-			Format: <mux_mode0.mode_name=value>...
-			For example, to override I2C bus2:
-			omap_mux=i2c2_scl.i2c2_scl=0x100,i2c2_sda.i2c2_sda=0x100
-
 	onenand.bdry=	[HW,MTD] Flex-OneNAND Boundary Configuration
 
 			Format: [die0_boundary][,die0_lock][,die1_boundary][,die1_lock]
-- 
2.53.0

