Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D013DDAE2
	for <linux-input@vger.kernel.org>; Sat,  5 Sep 2026 09:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788601642; cv=none; b=czLFd9omF/Gyk6tVFQgkQwzpS1WU97O2TDoEEmgOKd6ejQ1awuRL3aXay4ixA6mC4IUPQcLwwuvuH90tsxRLJbZ1NlpoFWhdewfPUyHAkcn9Ip4n37ZzYEtt470HSPH3vz17ajUd1c3va/ZGdN+STTT4AUtDBXEd23VEu25QN7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788601642; c=relaxed/simple;
	bh=iIEWAYVGI2FzX5iZTyH81lDATptMQacAG0wTPy+abXo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IMBBA1h6bWyjdDQuggEHqi9kjgzSyboAmmqsIJUCMlLEolciljzL8z/aTMAkuiZjrbegG3+Wv5gEFKrBvdxJz6mhTliPbFnDt5mOgrtcdnZiarl4wQIzuPmcvzIXOKs4evYjD2T9lULMqERGsKnMqleaWL9AJ40HSEyCYYHG6Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WyvrpKrH; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WyvrpKrH"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-48586861639so1303858f8f.0
        for <linux-input@vger.kernel.org>; Sat, 05 Sep 2026 02:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788601635; x=1789206435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8xnteEJpCubomPwB6glv59IEZPm5BMjzUqWSxe52tsE=;
        b=WyvrpKrHJwVM/8ZcX1GSWFju4g14O4oDahiOI0OS+wcnypQuvsomCZxxoNsngGdcpS
         iMNMMyLbpjtmvW/EWl4iZ53rr0WuVL50Je9Pi/ewScX5oXjVlbyTy66vsM00pKJDHekp
         zbXJPoTpg2PVAHDnNeCDSEqB6+IXMYfMRVEYlxkySrV1FIftT3xdeKrCHXTmz2dCvBqi
         G7Nx24hz/S/2cGB8bDg0xlI/4JzXD2cIxs27X9WE+cEHW97xbSD60x2O4TuuUiiEtmMN
         gLz7tKdUexx74iuFiJ5OWz548lW326b3vnw9JZ0uUDJlkfikeabOhE0wjsV0JZs8aZoF
         EjXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788601635; x=1789206435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8xnteEJpCubomPwB6glv59IEZPm5BMjzUqWSxe52tsE=;
        b=hF/hSO2ZCdObwDugLwoh1ZrNWuvXH/Ci5FS832HvMCV9Wow7bZSKWciXC+QF4HipCk
         LulrLTCSZwl+D4EZK3wZFOsfP5vJYlIYLAxjbyxQZrnWbaz8w+ZLEPEVg2ArYYoa+IeK
         GBw38nguTxvyRDcdNDIvBW+Ic2pwppSw/mHbUASNT/T1sURIvzQoLB+Tf1vgqC/EeyYL
         ooYpn0ZFsdZe8R8L6rVjone21IM0E3kTk7g/dc4msFhOvGdAx9jNktAYSdMNAiHLEKhc
         UfSK2GJS0WR/3sTg8qaR0M4cyAGp2ZkHGO7XnFGtHJTRiIdf75jcQJw/tcqrJ900rOq/
         Qyzw==
X-Forwarded-Encrypted: i=1; AKwUvBxuAPCMdY8rCPr4NUhmzTBpNXuVz5x+fL/aZYaLdFsDA6+vUFsE+nvYsJykSDYJRn8WDM1hFxp3aFqkAw==@vger.kernel.org
X-Gm-Message-State: AFuF++nL6AJcKoU0h7ImTBn/T0eSRmAucCTIFLMisD+F5ycD/jd895qR
	OGqHCu5B9Lq/v+lz6d7lBVvC5Nfqe/78lNZFs6zb2ubRqV/dWIF4hfb+
X-Gm-Gg: AYBFou1eXyj8WE0+tL08NR8a1iDLtmuE7bH/62py59BphiOMsndaXWPwhc3KjGGBWPQ
	og1OJTGwaT9lAboRkx+uQxWHZCUu5MBdpkAjeicP+fL886gZp+CcG0Kf730tp5H29Lxybm+vMv8
	A8yg1FupZ/rA3QxnLgTWhfjeRqAsZuNv6hKkSlpS4TbnXuM3HSeJjEBOnbVbmIUHeFWm/8+oHpw
	k0ICfUZAB3X039hKcwoZ2DVBWEo+pRLORPx2W/naXHOdeiXVuqfYSQ65zrpZZU9PF5izIvyAHVW
	jukJYXmmWYfmocMRJm4izLyJ0nBaEkl/eD3x1NLTBkm9ZO/wCJZgCp9uZP0d1z+JB4Tpxtvl17+
	A3nxZcFIOCY33XM1QCiCHN5YQzW/7pb7zd2Nfb4Q9mdqsHkOudkqfE23l3hbG4OaMguRID4PbXu
	mePXDP0schyY3ablWayLe/1/usKpuQhyn+W/xACo29M+rfO15haDJZ1gh7uxP8UZXeddy0qjFVd
	7xd2J5S3pbqPX5AyWFmHlqToGD3ux9VhLjX/QEXImfy4qi6JNHfFazVNXUNqz/gOn2o8Fh2VV5i
	5k+46iDnQwov9C28Pqec3O5297fz5bE9oZmIDY8z5n9jZ7uUXhl8ym4Ye//J0VhtYwg=
X-Received: by 2002:adf:ecc6:0:b0:484:49f8:b56a with SMTP id ffacd0b85a97d-4857e4f4adamr18253955f8f.8.1788601634554;
        Sat, 05 Sep 2026 02:47:14 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a4eb-3001-c06d-af27-9fa2-ea53.310.pool.telefonica.de. [2a02:3100:a4eb:3001:c06d:af27:9fa2:ea53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883c6ba4sm14232013f8f.25.2026.09.05.02.47.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 05 Sep 2026 02:47:14 -0700 (PDT)
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
Subject: [PATCH v2 8/9] docs: kernel-parameters: Drop the pcmv= entry
Date: Sat,  5 Sep 2026 11:46:48 +0200
Message-Id: <20260905094649.41996-9-kmehltretter@gmail.com>
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

pcmv= went away with commit 7aeffbf2ddec ("pcmcia: remove unused
pxa/sa1100 drivers"); nothing parses it any more.

Drop the entry.

Found by cross-checking every documented name against the __setup(),
early_param() and core_param() registrations in the tree.

Fixes: 7aeffbf2ddec ("pcmcia: remove unused pxa/sa1100 drivers")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
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

