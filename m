Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB4E3B6360;
	Fri, 10 Jul 2026 21:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783718422; cv=none; b=gA2+h8y2Twp6+d+2uuIC+RvFnkM1RfnsJOrQbmabhnmR7JlJ5QEiEQhK1VbFNFg/47gXoQlhFrbE5QPSwg12bWkt4DLNZf87gI6/QnZeQyR7ygArX+24lFPxRaZ4s+0ks0s015Wb+6KJvr2etcp1fxau4yavBUgydGUGZFL+Vhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783718422; c=relaxed/simple;
	bh=4mokNNPojS1dEeW5zw58UyFDib55NN7JLgiU7MmEbDM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bo/YTrbBQ2EPqpBggTfn3n2QPNxkeBSb3sEqqw+zW+mCHQTtCyEq5zb0uSZmheNJYir7uiK9Ib42J5PUM3XJLI+mrR/vPfYjwRsELyeM6KsURNI7Ndcbw997khTSm2c/v+mDYle+ogh25tiB99qnX3bUb2vqymuR81Q8Fy4lyes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PQXHMnq9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PQXHMnq9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C4C01F000E9;
	Fri, 10 Jul 2026 21:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783718420;
	bh=Ippdi6b589IgoAMhedLQYNaZwp1GbrBaowTRouqK7J4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PQXHMnq93t/jiY65DiW2KjVscsiWvxZQd3sccuAHQQ4oEdIVq0dXtlL7ZmqWmcF6A
	 2XJTF/iq0e9sfFWP9RiXjY/Pi11cXD/QzioanmDzajVSfyG5woC+USH4XgegE+NKm/
	 yIxyrc2DMUQkvpBmBb2/FbgZKkF3k/WZzK3WuifnKeaecS8oMPFp9bB8YL16m5L6gc
	 PlzutgltMnrTx0mA/FFC2yzZDW13pe1Hc0/BT5384p5e95MGV4zNd8Q/QDRSHRppGg
	 XksJbRStCyHc/Pnm1G2vwKKkgeEPZqD+4nP+BIPgPuVkHFPsvHP0gTO3+0VicmyTOA
	 UiGifRmghMKIg==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-gpio@vger.kernel.org,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Frank Li <Frank.Li@nxp.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Greg Ungerer <gerg@linux-m68k.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	patches@opensource.cirrus.com,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	linux-phy@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-sound@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH v2 02/10] m68k/coldfire: replace linux/gpio.h inclusions
Date: Fri, 10 Jul 2026 23:19:47 +0200
Message-Id: <20260710211954.1373336-3-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260710211954.1373336-1-arnd@kernel.org>
References: <20260710211954.1373336-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

linux/gpio.h should no longer be used, convert these instead to
linux/gpio/legacy.h for coldfire.

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/m68k/coldfire/device.c     | 2 +-
 arch/m68k/include/asm/mcfgpio.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/m68k/coldfire/device.c b/arch/m68k/coldfire/device.c
index 1420bae0964f..9a0258acd998 100644
--- a/arch/m68k/coldfire/device.c
+++ b/arch/m68k/coldfire/device.c
@@ -12,7 +12,7 @@
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/spi/spi.h>
-#include <linux/gpio.h>
+#include <linux/gpio/legacy.h>
 #include <linux/fec.h>
 #include <linux/dmaengine.h>
 #include <asm/traps.h>
diff --git a/arch/m68k/include/asm/mcfgpio.h b/arch/m68k/include/asm/mcfgpio.h
index 7103cfa4edb6..29726aa40eb6 100644
--- a/arch/m68k/include/asm/mcfgpio.h
+++ b/arch/m68k/include/asm/mcfgpio.h
@@ -16,7 +16,7 @@ int __mcfgpio_request(unsigned gpio);
 void __mcfgpio_free(unsigned gpio);
 
 #ifdef CONFIG_GPIOLIB
-#include <linux/gpio.h>
+#include <linux/gpio/legacy.h>
 #else
 
 /* our alternate 'gpiolib' functions */
-- 
2.39.5

