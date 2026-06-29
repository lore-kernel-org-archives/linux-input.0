Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B52C40911B;
	Mon, 29 Jun 2026 13:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782738251; cv=none; b=Xm+eKCZIdz/V+HBi286Vw1QuItWq6koo4am3TJ3swni8wk75F58bvuN8VSR8Mzi85VtGwVYjONag/S9T9rH9/gERbSiLw5DRpQVBCF8Uyt1cyXehb8/t1o4YW5bw/5AeD5J/CoWJUr4H7i6uAgUAh4LQX0zdoAR+fCDHZ8lSOJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782738251; c=relaxed/simple;
	bh=OnyIiJ9k1Mnjn+nNQezceY2xDapKkl2m9lsvWrbueBQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iOv4FZsR7cFe+7X1HgyRr1HZsk+xrGlfdzSaJg5JJGXpshxlVDrxPWfq2A2ebS7+i1/n8L704JDp/f3wk4VBaTuzBS7bMXe7fvJ2P5Cc8GINQUwUQC3bB4ao5COFH519uv4Tip0BQB4RnZm149xnMBxu1Lm5W+GTXsQhtJt5YDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GUEolJ1L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GUEolJ1L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EA3B1F00A3A;
	Mon, 29 Jun 2026 13:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782738250;
	bh=dEG+ZoyZP8nWtf9r5C9gt2EU40Cd6Cp+knZSd7mv5p0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GUEolJ1LbqpAJJD0x3b8UiAcFk5ozZn23C+0EdVPSJDI4smSsn8/N3kzb72XBQwCG
	 gMA6sLVeIK86vzN4REHb9mK6rglOwFm4xtX2hHiKlYOWQpUdiiTew4p4rueYxpl3NV
	 ZfSggrLAEXqssFya5mT/X8DilVz8vBifnReULr9hGVUsrNaQm5jTQYdTp3znRPOyhf
	 LpWr4c6T2WCqBv6riE2EN550P4ERy5qgHPGR4vK3GEmyhpCsGy/H7pQdhXrWY+aInP
	 Rk1eKjTYGIC/KAqAKv2z6jfcuLrxGveCDnTItUFRdSjJ0YD8gZA4g8Vypkb7YbMX/z
	 /haD9GYzFe/7A==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-gpio@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-leds@vger.kernel.org
Subject: [PATCH 6/6] [v5] gpiolib: turn off legacy interface by default
Date: Mon, 29 Jun 2026 15:03:29 +0200
Message-Id: <20260629130329.1291953-7-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260629130329.1291953-1-arnd@kernel.org>
References: <20260629130329.1291953-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

All users of the legacy interface now select CONFIG_GPIOLIB_LEGACY,
so it can be turned off by default and only get built on platforms
that still have one unconverted driver.

Allow turning it on manually for compile testing, in order to keep
the build coverage of the legacy drivers in allmodconfig and
randconfig.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v5: added patch, now that we are getting closer to completing
    the series
---
 drivers/gpio/Kconfig | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 28cf6d2e83c2..f063bdfd111b 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -4,7 +4,14 @@
 #
 
 config GPIOLIB_LEGACY
-	def_bool y
+	bool "Legacy GPIO interfaces" if COMPILE_TEST
+	help
+	  There are a few legacy platforms that use the traditional GPIO
+	  number based interfaces instead of GPIO descriptors.
+	  Say Y here to enable build testing drivers that are specific
+	  to those platforms.
+
+	  If unsure, say N.
 
 config HAVE_SHARED_GPIOS
 	bool
-- 
2.39.5

