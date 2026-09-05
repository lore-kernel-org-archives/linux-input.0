Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0813DD526
	for <linux-input@vger.kernel.org>; Sat,  5 Sep 2026 07:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788591859; cv=none; b=TxXEHn6RgDTsRYJXljRxSQt7874oXPsGVLNdOKHfSxgmtqZPSCge3umVG7FGw3YhLg1sdOu0KRj0KLQxX4Ng/lLZdfwbukLJWIu1kbFRrnzYNMVPjjO2fNiFYXCxirnRbhFnxc+9DdDx+qzPhPAYZ19HGOJMSLOpMUWBLyVqixY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788591859; c=relaxed/simple;
	bh=iIEWAYVGI2FzX5iZTyH81lDATptMQacAG0wTPy+abXo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LvJTnAW4IIYH+9jDb8UGhFzRMIfZBuxEs821b8rBr5uWe/8kS7Qitx1k9ghb4fgddybnZfzpW8QEyGdNOgp30VvDQvDN7aiM8rFbrd0xK0QeJRUmSMPhdBlZfCFL/BN/oMKc1x8I9vt1fUeAZyNhMDCTLQougPRubI7J0vCdvRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n/VnKgEw; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n/VnKgEw"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-47f96c5b722so1162268f8f.0
        for <linux-input@vger.kernel.org>; Sat, 05 Sep 2026 00:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788591849; x=1789196649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8xnteEJpCubomPwB6glv59IEZPm5BMjzUqWSxe52tsE=;
        b=n/VnKgEwCzZzuUfJUOeRE+oKzjhVOyufVIm6bkaulaLPTDQm2Udno1JesGrfw+QtXz
         rtm2HC9oekj6emqCHGdjmj8Tg7GtyOqUaLYn/RB0+FVYHZ+4xb5I8BszVLSoWQKWnUOz
         ykiTBqE6hq7UgsTha8RD7CuhFhhy5kDjFQBiQCgcgB3RGwGNRMX3Pg7/TRuIJqfw2a9F
         EpjIsiNmxO6bXgxOyi0EgzQ+9+XnRBpbp+/MkKVQI+xT0XzSfP9iUXr4eIb3HBe1Orv8
         BHqNJmEGTo7OOeFNbie58dyBfFSSmVSCeP0DGssZQo3HSLtGpMSaveVk3WFXlSZhC0II
         gtNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788591849; x=1789196649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8xnteEJpCubomPwB6glv59IEZPm5BMjzUqWSxe52tsE=;
        b=UnQ11Bd99+XNmwDXGhh1/X6/oS5n4T9XfEQEi43iqhbRvr7iZNyDN668g+aVSQSTQn
         BGYo8a8b+l7STcpbCEutmBUnjF3Qn9zmNh5N4UZR6J4Z+3MMwQMeaqTt+SVAqff22ff2
         030LeCA8xER6twFSaphF2ZQ0ehdU+Tup82q/ZsHVBEpj48/N8qtEWjT9UvvY4IJ6Bqtv
         p29newhHCL6k5Aob3yU5oTy5q6B3jEvdgEwywIhoYJGgRQ6Rlpnakon51mkK4veatdsZ
         NqVvFRIEMd3tWmH2jqbInD4yLQb21Do/c75Acys9a9oqLLqc+2KadqjQ0yNBMSyQFl2l
         TLMQ==
X-Forwarded-Encrypted: i=1; AKwUvBxSZEitJuHKS7OwD6LOtFIECrzGgEtbc+9jxvzWSsTI9/L8G0s/MYZiZmxNRrY5Qk+zl5zLI+FWnWZn2Q==@vger.kernel.org
X-Gm-Message-State: AFuF++k02jPo2q1MtWwkSTwWy2uljwK7hhZWgs2ruHJEWztMAIdPia1i
	TZf6OydokJyyHQ8uGGrsUqu5CAGkA3SoQ6gyJEHjn2md/6O9UN5SXYlt
X-Gm-Gg: AYBFou0eI0LqiBJChTYrr+3KIOwvoJtRpa6J0XGaFSv93vaCWKohEuYFOEdeARWgCZs
	kXWbp3mC9eixl5vEyprXcE1fYYMy5x8Qv64dvnYvQrPlOpFPh4W6N0sw+bJRBtucb7MjY6LJsvp
	rkA/pbbeBy1ZDRrwURMboAoi+dqJA2paOCBP1uwndIooGfDwgjehiK6nFVR0FYSZD66+rGwgySs
	peHWd21ZR1D0NLAeFoXHwcnyZXOQaJKIM13sSGsIxVn3FgM0e6ZQIHFR5jxpaOf4uFPI7oYee3P
	G7Fvoc8t6PCBTcBC9XObOQg7yTvLEyjsqnAERQDXB5y3jLK9djmuIbP6DKFhB1PEE4L/4IyzQgT
	eGTHXuReQwBEvLXn37Agose9lpTZB//p/uI9lyM0QR6UmVmqmmy6ACh1GBwdq7PIkS+P4sqhT8J
	6Be/vnZLuEi/zkMfncbRZJc9yK2MzbVf4lIz7XN8WFoN+K4ZC9YT3fKYML4mP5hnYtxbK44bYlW
	8lMQ5bcCmY9VIXNhd4VU8lxjvFdelcqhyMoukrAkPTxghrVIutzmMYzvmnXvqgxZ4kvalL+JQFT
	HaLSyBDlI8tPnRf23SpMpJ+E5QFqbrcY2XDSMIWQE2dU53Sv85Mtvlr//gUFbxVYRKX2fNbE
X-Received: by 2002:a05:6000:46c8:b0:484:3f43:4914 with SMTP id ffacd0b85a97d-485872a6622mr9310761f8f.20.1788591849363;
        Sat, 05 Sep 2026 00:04:09 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a4eb-3001-c06d-af27-9fa2-ea53.310.pool.telefonica.de. [2a02:3100:a4eb:3001:c06d:af27:9fa2:ea53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485885bfdf6sm12011719f8f.34.2026.09.05.00.04.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 05 Sep 2026 00:04:08 -0700 (PDT)
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
Subject: [PATCH 8/9] docs: kernel-parameters: Drop the pcmv= entry
Date: Sat,  5 Sep 2026 09:03:46 +0200
Message-Id: <20260905070347.25902-9-kmehltretter@gmail.com>
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

