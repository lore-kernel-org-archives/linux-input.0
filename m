Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196B53655DD
	for <linux-input@vger.kernel.org>; Thu, 10 Sep 2026 01:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789003993; cv=none; b=MCb58vy3ZQ+YVF2onPKKszIy8LoR8bSMXwP3Js0nlteyo3wOw5BHJ5HZxGpOVjAEQKpRzm96ugfyJC1atv8+gO1z67/k2BwOUUYvm8fz7S8LOVxTY4acfKGxU7GDQjHnaVETHWJMSLs74XVe7aHsWpm+dmEK7W6LQCtwAAgMQbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789003993; c=relaxed/simple;
	bh=5mxh/fyf7zMbDCUOMNH4gIL5QaZHVPfDcaf33gQ9HIQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=No8vHUzfrttU1ogxU3nKWfivcsIpt40omKZWjN12YstntGVD0zJVlpcoIvZ50fh1AU76lVTGzlgodjCqWKvT4iYFF2A/tOdzX3bn9n8m5Kkr0Q4wQ1vgeUCzs06NX16fpe+l7+iitKKP8vhCYYL3VAyENx94XHOZt4ZWfkv2X7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WSeTwss+; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WSeTwss+"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b91369ef6so6028035e9.1
        for <linux-input@vger.kernel.org>; Wed, 09 Sep 2026 18:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789003987; x=1789608787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PQdyP9lzK8puPxCmvP9p22b7bgDtVaxFnQRwYj/u0p8=;
        b=WSeTwss+d4gUDDaRD2rhGm/VIGL4TIzpAISoyprh6a+NCFi/z+6Taxtl+AsczGmnvR
         329V7ddqkx8W6q+vcrK5wYhUEdH5u5Y5jMk8RvCk1xN0vETqzuHv8S23Jq++YoPM/3av
         HNxa+zF02HjrDkaIo/HQmRIUNAiUTjuhjb3bzrAVEhh8yEeNJOZJs1IweqYuzCVna2NL
         qsw2PPL+N5S2wCfVd65+HvWrmbG3BJmAZsBFBVgykJcrP4x3EJMgh+rBGE2oA67PafqS
         hgBXPtYRQposYQ/zBmBy+T1wCu69P0gtYpM02ca0GDDMcHo5IBQIDe/e3N+6lWxJBrqa
         m6VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789003987; x=1789608787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PQdyP9lzK8puPxCmvP9p22b7bgDtVaxFnQRwYj/u0p8=;
        b=E+PMKu+O07cU1mwz29R7yEbVsGiD6W2lD+3NhlCwFnSoOSzqqd/9GlyF7xXF866I3i
         b4i3dK/9+ITb5re+89+7fnwZgUow3aZ6m6WCYvZFGOFC5oXADyVF9CgSC8ZlUJbn3blG
         h798lG8jssi3lzMYDTIlVa1k92JVCJQmdQ94ZL6vw69/MxkYuk2qvA7vzCXa7qf2+elH
         /ryj+2MkimRX7FhiBSYSfuxM/iKGcWXroEFB0izoU5BKyaTALy3ZJKMPkETxa6RDf45C
         QBtDnc+8JIglk48fyBD5AfAs7fFr9nBV3/L4IR034Y9hXZsrL7P+X5tn0sKfuC5Mwgr3
         CsDA==
X-Forwarded-Encrypted: i=1; AKwUvBwA+u2Dd8by0t3SPwB4ID4SLJx99EFZelSqwzI2ANFDbyjy+LcfojgmNYCD9y50E8Aoe/Dx8EFm3PpnsQ==@vger.kernel.org
X-Gm-Message-State: AFuF++mHCHq2NkFg4Xm9FaoiY0Ksr2PHPKufRhbihghzERqqEQd9t5Di
	YbJhBt7/vhP6VTqTmO1X/k3kAqE5jLPDPdHNtR0Pw06Q3YVwGC+6WYNE
X-Gm-Gg: AYBFou3/xk99Pb6cIvxUeBHjzA3OeFvHV6J5wHKiE3/dvp6jo5hcCT8iTkyY7zT2yI6
	QZXK8Nx+tOGxQXIUj24jCMjHQQcStA4z+dYY50WxV77eQdjWLKH+tiGHFPAv1zWgX6MYtc/GsW6
	XRJ45UPwYh/DaBFUa7XE577a8mMAhktnbAaKXOEASPoHGWdzLj2oTeMSSmkTOLqDZAgl/CFN36g
	Pr3wRRaYPnjYOPHfgtWJSPGUKiJWBSZYiYwg5MtVvdyGFi+8Vh8/symaBJXbrmW72MmKR2ys8Qr
	0YbZssl8l8VvABOBud71WcwC/Yc8v16cg4YvwuvatRGiH50WiZaMUaUUHm6JuOohqeJYVYaHJ9v
	ISKWrUqvMe+MRvfbnX06bxBckGEz63t2V47r9F4q4uZdR3WCjjnEkXB8iDxOzjAE/d7fnTltMCZ
	GhzMGEv0I3SYiw/uAqDlanT4b9xqif+Wsbx7dpBwnemr04gDkivfNRFcgmuExVfwLNrGlu2sNEI
	Xbsmjbq31P+TiW4HcXYluKQuWzqgHkbWKzy2RdGqrDRYN5chm3oj2M6h94Lr7kDNtEGVv4ggiIm
	1S3+GBT1yzrKOAmXhWW4CwtL9wL3vQib6emXIlw/FBEnFMIOZY7oY2cpimndkq/2qVy/v7IuJiB
	1Qg==
X-Received: by 2002:a05:600c:1e24:b0:49c:cee0:e7c1 with SMTP id 5b1f17b1804b1-49d259502f1mr79893755e9.16.1789003986665;
        Wed, 09 Sep 2026 18:33:06 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-b090-6201-5565-e933-e630-1831.310.pool.telefonica.de. [2a02:3100:b090:6201:5565:e933:e630:1831])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d26d4e3f3sm35852735e9.15.2026.09.09.18.33.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 09 Sep 2026 18:33:06 -0700 (PDT)
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
Subject: [PATCH v3 7/8] docs: kernel-parameters: Drop the omap_mux= entry
Date: Thu, 10 Sep 2026 03:32:44 +0200
Message-Id: <20260910013245.8619-8-kmehltretter@gmail.com>
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

omap_mux= went away with commit e9f5f1e45608 ("ARM: OMAP2+: Remove
legacy mux code"); nothing parses it any more.

Drop the entry.

Fixes: e9f5f1e45608 ("ARM: OMAP2+: Remove legacy mux code")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
Reviewed-by: Andreas Kemnade <andreas@kemnade.info>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
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
