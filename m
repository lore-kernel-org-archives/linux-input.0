Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A75440654
	for <linux-input@vger.kernel.org>; Sat,  5 Sep 2026 09:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788601645; cv=none; b=WkrGR7T1dMac9IamvoePNa/mPYHHYWFCXjYlFlvuShwFQjKC0XQNXi/5cTD6aLU0276YD2pzYbKe8eedw3mkrefgu0Uhv1f09nF09UytJotX0n3vp9wgHlBhTQ+eL6psBNcjqsLIflB5FSewo3lOLGYinZHLPLvYO7oBipwgwNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788601645; c=relaxed/simple;
	bh=tXKjfoKiXZ7V6wID0vROu3EjAKBYvGUXtlTaR3CzeO8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UCJz9xgvHo4ZQiD9I7BptPeGKHGMwaoGq4bomFVLoHWyZGsqZKHC2KDB4RLCTbjfH7S2qOaCV3FVxdrOFZCgRPX7Wuid4qBjg9JdleYoeD+0K0AKZAP8TseLQ7GlqjYRk8BjbgtoQk6Z0EiG1VpahDmQN1xqiXS/VjYtuAuiF3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IEVPm1zf; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IEVPm1zf"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-499ae1c6471so16713785e9.3
        for <linux-input@vger.kernel.org>; Sat, 05 Sep 2026 02:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788601633; x=1789206433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0boECcjjn/VFHFH6rk1vpO238PkXNlP4zHZKdanKNnE=;
        b=IEVPm1zfJ3dYP4k/o2iihvqOZUQoa934q5meWH63sSrsaeYufweygjH57c8MV9NFx+
         lkQAY6pKYddn41/9VK2PK5XddDJhNrdTbnuKAaBUqJQj/pQ1hH6uaKHFaFZpYydnqWif
         iYUdcJQ3zgkHLUpus7f+x7lrko4HImMasZiYYCKwX92AsuKXxzX4Y+PE06+v3awXu8z+
         aKzCjivlRQudT5FLIn5THmRE9Yuu+YyNddrBqUxqTa60piZAC4sp1gP0mr3F9Jdu435L
         vGAvspUcmCZfuLpNewH/64WPN2GxRDd6MstWVz0P/WNasjh8mB9Q/dxa4Btjp3Ij8KrL
         cImg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788601633; x=1789206433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0boECcjjn/VFHFH6rk1vpO238PkXNlP4zHZKdanKNnE=;
        b=C7F4AJScu7hItHmjLlTQVm2BMPtcP06C0OZZSLA0bCBUO7SivVtoZ/YQ4uUxTbN70l
         2RT2V1ZUyikZP/064j1FXcmq1LwM4jC2Z05Tu8pEWdBPXi2zPEdhpWCY/3yAJFPyN7QR
         +qwx5WpdVsXaqSPxlJ70l8OT/gI2uxLzRl0Sircv1Lqwf1kW+tZimfAAvtQelRGxRp6F
         FOaIwX3Qp5AXRpl5uXjZ8j0EsKNjwl89V5Jh3gS1ztG2DJ5+MNlYYm2zqmbH3Hxp6ViF
         0YZrE8kGlnQbSQ86bzLENKLOpR7C3Kg2p18oVLsWyNT3ENyEmFuUQBUedj3aQTzKGXJY
         ItKw==
X-Forwarded-Encrypted: i=1; AKwUvBz753Y7ZsHvfrWixiBZ3wjsaHWX6u7Va9zPqXENUNAC1E/ZYdCGxPmDDUDNgObp14hmF221fRnA+mi3vA==@vger.kernel.org
X-Gm-Message-State: AFuF++kwOas8tKezsfMY0iUVFu1h1KhIfJXPaZGm/dz7SpXfN37ecPj3
	5/5G/w4H96PcRNtSjpWq3Jo45a6KCLOEoLI9QOlvkIJtqXzM/UWlXrTs
X-Gm-Gg: AYBFou2tsi3qWTEWsgny34nS+IFzQUfVZZcD5ZgomPC44vB1ktGjFm0VzzKtXh2qw35
	FMWoL5z5bSccAOlRm1rr6OFNP2si3zF9tNLB6w8Cj4011YiOs/sXP9qHRfeXymwLq6uNlocgECa
	oRBelElW0/6FTmKZDEtg6BvowXpST8i4dOVgHq77lfMS1IyyU2ttpzmzd0751lHXJsi5RtSuMtw
	3dRi5BM7PrAWnJC5dARO8ittsZqSzK+GEpAG3/wZ/ZFSpr8AjmDd0rT6qlaiQPznAG2BuBZ48kn
	xYfZjjeyDRpu5FJ9Zk05JKZG6ojvOZGDUWGDr+yMJluZl1pG8jUAkjMdTKVMxr/pVwkLPCnDrIq
	W2g/TdHd9bYN5Nt4xIbV2DTTiW9sp8gx+KC9xMH+wvbdHvl7jiy7DX2YrhC03dZmeHYhiis2jh3
	p5lgWQ3SXF36livS9Of4wJe1nz0OwowXDgPE8+7U59Ii5Ij8tFO4SIHptov32bgAmXd+rW7Iy3p
	GKw2en0V1Q6OnjGqGFhpImFDKsgQ3odI8nej/pUgt+0bPXxDjloIGi+2gsKjmHO66gMpeC5dAcQ
	TCnmlu8ZWyCH5wnObq3w9SHOUYBmfivYOTqNWr9ytHdsp1gP17uNKNSLcKkajjzfklQ=
X-Received: by 2002:a05:600c:8b11:b0:49c:edfe:d525 with SMTP id 5b1f17b1804b1-49cf82417f7mr260260105e9.10.1788601632697;
        Sat, 05 Sep 2026 02:47:12 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a4eb-3001-c06d-af27-9fa2-ea53.310.pool.telefonica.de. [2a02:3100:a4eb:3001:c06d:af27:9fa2:ea53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883c6ba4sm14232013f8f.25.2026.09.05.02.47.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 05 Sep 2026 02:47:12 -0700 (PDT)
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
Subject: [PATCH v2 7/9] docs: kernel-parameters: Drop the omap_mux= entry
Date: Sat,  5 Sep 2026 11:46:47 +0200
Message-Id: <20260905094649.41996-8-kmehltretter@gmail.com>
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

omap_mux= went away with commit e9f5f1e45608 ("ARM: OMAP2+: Remove
legacy mux code"); nothing parses it any more.

Drop the entry.

Found by cross-checking every documented name against the __setup(),
early_param() and core_param() registrations in the tree.

Fixes: e9f5f1e45608 ("ARM: OMAP2+: Remove legacy mux code")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
Reviewed-by: Andreas Kemnade <andreas@kemnade.info>
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

