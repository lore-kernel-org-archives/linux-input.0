Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905553655FC
	for <linux-input@vger.kernel.org>; Thu, 10 Sep 2026 01:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789003981; cv=none; b=grOsdsAUztjLdn0KngTZv3crg9d5LWMbivzrIfhIIZFomGAhtshKg0M+Q3UQjWN7kUmBu89lb+de538iViKz79b56sB0UCjvfzYNOT/RCYuAbpOEoBIQsb6z7+fknb0TnFHgSrc3FxsxdOMLeDxV7c8gwqqcwI4AsoRGz5RePRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789003981; c=relaxed/simple;
	bh=5npIdaapraypBrumlWXF26qNLLXzmRV667k+YLJkaDI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WeJYEAeq3LgowPKGJhiSXlw3MeUnD1K+vL3z3P7L/0PlaFxinThWDGQldWLyVHBwAvc2OjTv/qzIL0zjI8mu8bpd7Z5+u9EesojpXfX4OSB2lMiO1n9pqYLa+Tx5dwbyI5cNmLjuKjdNVCy4xo7DxivSVPAnKwIaDD523qj6txA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oTBYOs9h; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oTBYOs9h"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49b8e527d63so81382735e9.2
        for <linux-input@vger.kernel.org>; Wed, 09 Sep 2026 18:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789003975; x=1789608775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MYl7DgYw3pPECQ79mBvyISUl5xXzjI6JeiWJOfwAtIc=;
        b=oTBYOs9hrQ1g2s7H1bO9ogdhbix+86v1yKFtfKCQWjR2iRiM0lteprlG6Tn3bvnNeW
         RDnjU23cFSUweUOo/dO+YQs57po24Vf3jckqzJ7ygXrMBi2RX2UeRHj+//bkJ8Eiqukq
         6dmbafTfGj8ObvjKL3mFBCqDa/6+bq4N4jT/jPNvy3dFG8CMTQtFozbVCsxKjxzetMNJ
         wxRIGzrC4KOjnhjl9GxsScP+rj5w9qgsm2euP4SfZ9sVImxRy5fXrI15ETNA5Ppcuua2
         NtIxDrLqswMf+z5hVSRi8PvnlqC7QVtXzpLkpX1wHIxIC88GSFYtxvHmgyuubyqaolzO
         KxCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789003975; x=1789608775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MYl7DgYw3pPECQ79mBvyISUl5xXzjI6JeiWJOfwAtIc=;
        b=jAz/3NSKkgOqhQPooK92RRLvW52m9V2FnJlGqwcXBBHERo160QEn467ydTRUZcvnCV
         xdpUsZoj4iWcwaS/34EtIT/6aOh++ZQ84C8djeVj2xJF3puWZbafhzsINz+ZBqTfaRtj
         JVTU1NaHHt5m4kbKVd5Sa3Gvsps1XgajkE8YcfULxGdPe3MWUDrWVnMgWSBxfsAhEKU6
         IeCsbinKRDbDYfpdv9hv0FdyHtR9mr3RsO+6VOu7fGOoWJLAtGgTEFI6jXwU4NKEogxs
         +pHLADx13SJCET2jrBDuhnjL48orCV4bZe2cKECLul/Ky40fA9zOkG0vhyqY6CP+MHke
         WShw==
X-Forwarded-Encrypted: i=1; AKwUvBzGDckTQw87z9HMe0+ZaPFxGoqChIMZJ9xkQC878Q/SQchUwTHpFnbGgLVcKGFGoHHPgyDYbxjnNgxzZQ==@vger.kernel.org
X-Gm-Message-State: AFuF++mqLV733gU1jwJGsE6CG3zGLWHN+yNvVAZfokG7RD0FoSnIJXoJ
	vF2vomXPR4zOD9ldbUT+VEkw6Ks0DvyF+9g8EqBd+7m4JEsWwePOf2oRbnoSfA6v
X-Gm-Gg: AYBFou0GiDkwICJ2dKQlDZAtPZ9UB/e0iqzXTuBXyui4MTWYdCUpKBNiUADdN4dx2wB
	XBh5s4Gmjzr9WpEC0WmLrp3QCemCY1j/yDSnC2K/3MHNsvl/eHHVZS0YHXMHwxiMZlHr5f4cxLU
	mc5j5pEb3M4UENfpiztG8CzUlX8BbsUYJ6ic/XmfNVC4hRjUsPsyfwvsSulFwk+Pd443ABSFHwu
	bMgaDzbuTGWOLYkAiNvU1CN+8Hqg6w0vrnqCrAAPsGTRxIkkjAPMNL74td6CRn4G+RivhZa9hEs
	IdwPauhI2/m9KlojqmOvDD00sZwKFtf7lxBIvlJkPqlROL3ND9wbyX2XZvHy9v/vG0Ru1cOOwY1
	OmQHdEs7HggeVE8aPgQQRCdXlTLbYWAQjzvc4wI0ERgdZk4eRAJhM6XzYKMtmfIqDyIp+k6snn3
	D6LFkT3afNNOPX3vYszSjZNu2Ugzqv5Ip4kX42JKXifQ9xkCtG73P5RNZcXsal6LEa5tEi/48hB
	C0mMoHpOGnyvHEy+z351/DxVFaRdiIErD+Yyp5+8VoBmLjG6W9S85CcjzKiFuZvtI2h5SRAuCMJ
	DxXDgSNg7Zp8b6cC/y2FusDfCqw+1RJP2ku0HxdWbdmnS7TzbiQ0ZFcIkfB8hQ1OG3qTIxDpGY9
	F9Q==
X-Received: by 2002:a05:600d:849c:20b0:49c:fe46:7219 with SMTP id 5b1f17b1804b1-49cfe467228mr261724915e9.20.1789003975492;
        Wed, 09 Sep 2026 18:32:55 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-b090-6201-5565-e933-e630-1831.310.pool.telefonica.de. [2a02:3100:b090:6201:5565:e933:e630:1831])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d26d4e3f3sm35852735e9.15.2026.09.09.18.32.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 09 Sep 2026 18:32:54 -0700 (PDT)
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
Subject: [PATCH v3 2/8] docs: kernel-parameters: Drop the bau= entry
Date: Thu, 10 Sep 2026 03:32:39 +0200
Message-Id: <20260910013245.8619-3-kmehltretter@gmail.com>
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

bau= went away with commit 39297dde7390 ("x86/platform/uv: Remove UV
BAU TLB Shootdown Handler"); nothing parses it any more.

Drop the entry.

Fixes: 39297dde7390 ("x86/platform/uv: Remove UV BAU TLB Shootdown Handler")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index c8d96de4c00d..99d5bb68968a 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -624,13 +624,6 @@ Kernel parameters
 			Format: <int> (must be >=0)
 			Default: 64
 
-	bau=		[X86_UV] Enable the BAU on SGI UV.  The default
-			behavior is to disable the BAU (i.e. bau=0).
-			Format: { "0" | "1" }
-			0 - Disable the BAU.
-			1 - Enable the BAU.
-			unset - Disable the BAU.
-
 	bdev_allow_write_mounted=
 			Format: <bool>
 			Control the ability to open a mounted block device
-- 
2.53.0
