Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FD7360EC3
	for <linux-input@vger.kernel.org>; Sat,  5 Sep 2026 09:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788601635; cv=none; b=jNAC4Gdl0GmnbLknKrTsE9lTCRYt2eTTRui9XvODVRQolqSXJKwbGULlAhJFgQAUtqlylPOX7VzRImzRR0xaU5/V0+dMiIKtex1eE/gxnduaPgfPzSu2BBaLlFTgVzGySjK1jp4dsvnKzDLEet5e1s8M0GNL9u1qXj85PNlIPoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788601635; c=relaxed/simple;
	bh=zqIZgn7Zgj5WSQepFgJtQ9GMMyKpvR8InLxOiqTa/8o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ITUrAlGYgipbLSlWk7DeHm8SCAucepMAWR6pb6q2fALEM/1PFGkRUjX+W9u33QD6nHvTwobjLDfyZmD1VppJ0/mZpLooB/1hUWbh/iLddOoNBa+sGv/wxV97zG9C1ZV+VAyhBiv0CG495O8BH0Kb9qOFSimE04isDhEkXZdg+iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sS3GkGDt; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sS3GkGDt"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4858595f997so1139126f8f.1
        for <linux-input@vger.kernel.org>; Sat, 05 Sep 2026 02:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788601626; x=1789206426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RNFfTw1WuaSNgs5HCMSq2uznGZvnZVsIDtneqTMILXg=;
        b=sS3GkGDtOZOrxGVH2ecp8Y9BijuvKIZGE9cRol9c394h++PWXXMUkrbfk4MaucH7Xb
         U6xnSpOgpPlCLgGRJgFJusDEMpGl6GoEPagk0EBRDekWebDNSJ9c2+7bDODP5t5sx6WO
         S7qWSKaOAWth8EWw5f4FyoVQksRMC12WKRbvoec5wN9+mVJAxfr0JzbGojpcXGDPLycy
         Wm8keJ8zf60yL0isTXgjllly0MsmA/q9Yly09xrEJx9E+b1vfnw2Do6nlXQGx7bqY2/W
         iT83xkaYf1IN7FJtaRTK97E2OxZs+3sKatwn2475v/Wkqn0YcgJ9E5z39H73lyE+5dXm
         3iCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788601626; x=1789206426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RNFfTw1WuaSNgs5HCMSq2uznGZvnZVsIDtneqTMILXg=;
        b=aw4DTSev7JLipiXew92f2ptwGwQHWGe6lv0aEfCgNaaVKeGrdOtQHVaa025PnbpXvQ
         OIrBQgtT3UjKwGR6E9BIpw84TumusZAO2+dN2qe1y5aFYQ6B5VkCeMJzZQPSTh7A+n3u
         OZ51bIctOORV4ZNoEkDuwqRRqTbPsKHjsHIQH2l+WagYrIUf1hnuMV+MBTN1uA/cttma
         2RJZtbzqxbFZMYGzdRlU6CJp/GmRgbIV0dD3G7sfqMiRYaoCueyPADMm0U+v6cnFwc3Y
         eME3ZPGvZulXjsmMGJRjGOKnhv019/eFSopolkQcmULcP2ejKvWkYq1mQ7/U243RPIT9
         uvxg==
X-Forwarded-Encrypted: i=1; AKwUvBzhERAV3+Zco3yBmViNK/c0/5EMryWR52T8RXqfqGzb73n1mVe5EcD3r/DXW3gSQmXVesI7IA8DDqPKKQ==@vger.kernel.org
X-Gm-Message-State: AFuF++le4C7dmrX96I67NHbGf6vne8RPo3qgyL0ou9rnrnu9BgvpPG+Y
	GppTOMxt245UX3N99d0NbBh6RC66U/jRS9k+2rVoIW7Toub++d92Ynbs
X-Gm-Gg: AYBFou2GrZ2EcSOi3a+cGb9CZmWNLRUBJPYLeJLuMiDpoAlK43uMalPySyZrkSKBJqm
	gEnhlcsTlHQD6SVL5R9YQGFDuan4aRaRuew1JQ8KkDmasjuH1THu+MhZq2UOADqtgr6wJHXuc1X
	PgxY0d7AeKHA9ulWz5VbAM6GRqhVYBw87xY0R5zNPWc0dbXFSzpvNBjl+yc+KH+q9KCnLmMZCWt
	0p2QQdAEHq3Z80wlMpTdKgOlPSshi7cROJyYaMrZGxUUf5+hCuG/jHdbBfPewcRpM3nPNmADNdu
	6I1LnOtB79nIJymDgYXoLRokNWs1Cu/vbeTM+rLXoe7uJT7V8hK6nRmfP6V7+v7lqBs+IFhgIj+
	xjipvopvSu6ibQ4En/ZMJnH6O9VyagyEU7BXG2X2fiWnrc4P/CGBP8xLtnsZY3PTiTNxdJDlc2p
	9m/e6eu6kgYEPMNEOGkzwF0k1Ig38wK4olOcAgn9bj8Aezo7ktEsEZVHRPEuau1c/Ub2eAshTdN
	BHHK3iQmEX5E3i+0f4uf2vATbK75d4NUxN0H+YKoLxmXVaMiJvjBPs65lRdSaZjixHnG+b/sofp
	+EdaKtQkiitJTJYuyI9AL25+83n9N59sRepxDaSaA2vSydVcEnC9VPY5ZigjOaMTU2U=
X-Received: by 2002:a05:6000:178e:b0:484:3200:b7a1 with SMTP id ffacd0b85a97d-4858708c88amr21220202f8f.13.1788601625675;
        Sat, 05 Sep 2026 02:47:05 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a4eb-3001-c06d-af27-9fa2-ea53.310.pool.telefonica.de. [2a02:3100:a4eb:3001:c06d:af27:9fa2:ea53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883c6ba4sm14232013f8f.25.2026.09.05.02.47.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 05 Sep 2026 02:47:05 -0700 (PDT)
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
Subject: [PATCH v2 3/9] docs: kernel-parameters: Drop the edac_report= entry
Date: Sat,  5 Sep 2026 11:46:43 +0200
Message-Id: <20260905094649.41996-4-kmehltretter@gmail.com>
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

edac_report= went away with commit fee27d7d9788 ("EDAC: Delete
edac_stub.c"); nothing parses it any more.

Drop the entry.

Found by cross-checking every documented name against the __setup(),
early_param() and core_param() registrations in the tree.

Fixes: fee27d7d9788 ("EDAC: Delete edac_stub.c")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
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

