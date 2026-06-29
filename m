Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F13A4071FE;
	Mon, 29 Jun 2026 13:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782739657; cv=none; b=mruFTLlwkS5WuwO9qvKxhPICNOxwQgTFjcb4jHiEG+LGX1eqGXWIlPw/qKmwZIKNISfS89iVA1Siu7OF0FmL8wPg/bQAxP0Rlnc5y8O7/9hLNE43lgGfnAQQwgBCgME79IeDk46FBLsVTI0fG2z2HfNPhDndB8uqJnOnjv4eTAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782739657; c=relaxed/simple;
	bh=CltlL4gLl6R/aUyo3NNWu4aPN7uRAiEFCORu6U1GoVI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h9r2tXp4s/JhMOcfnifhQyFZ2aqqqwchM2SXkqLZJ1qRFReZsw5aEyqwQZmHtvDzFcWm6FSlVMhfCCj6UaG3hvbIs64OHraok/ZjVo62m4aIj2d995fPxzDmEqZHn3fqktzH2Ic8l5KfE17cP85QfJ4N2v10pOEDXowpHqMpULk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W3XxLeAX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W3XxLeAX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB7A51F00A3A;
	Mon, 29 Jun 2026 13:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782739656;
	bh=qVU/cQLnaenh7G2gzskwzWByJ5M8lYz7G2KTZBNaXl0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W3XxLeAX94oAJwi6KccusZYNep78lyadH1eGcnGUUrL8zeW/m5ri9nxkqGDZRVcob
	 uG/2mwq0oEhrUpgvYlMUhA3Hn5e6ilprAecYZlavcYxGt6RxCLr6ZNWbi0lLGO7M8w
	 c6SLMjx6ofeUljl4HXzXKp883719e6wAMUAfKDx8R9PQuEFLSobHJ8ut89AIBVSa39
	 6N7miTIf1RiXSvruCB9D4e6uyU8ULFKrNz4Tnr1co4c9L3Vk1jsaW2gNYufFcgpvl4
	 WaJhLoivp0gvakiWmOrUevc7Ne1ZfGmIknu6R8MWz6qBGSe8WltGzyUuzHPzJ1TdF+
	 7naoLS346ECgg==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-gpio@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Bartosz Golaszewski <brgl@kernel.org>,
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
	Linus Walleij <linusw@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	patches@opensource.cirrus.com,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-media@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	linux-phy@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-sound@vger.kernel.org
Subject: [PATCH 07/13] ASoC: replace linux/gpio.h inclusions
Date: Mon, 29 Jun 2026 15:26:27 +0200
Message-Id: <20260629132633.1300009-8-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260629132633.1300009-1-arnd@kernel.org>
References: <20260629132633.1300009-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

linux/gpio.h is going away,s o use linux/gpio/consumer.h instead.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/codecs/cs42l84.c | 2 +-
 sound/soc/codecs/cx2072x.c | 2 +-
 sound/soc/codecs/dmic.c    | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/cs42l84.c b/sound/soc/codecs/cs42l84.c
index f2a58163de0e..36c3abc21fed 100644
--- a/sound/soc/codecs/cs42l84.c
+++ b/sound/soc/codecs/cs42l84.c
@@ -16,7 +16,7 @@
 #include <linux/init.h>
 #include <linux/delay.h>
 #include <linux/i2c.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
 #include <linux/acpi.h>
diff --git a/sound/soc/codecs/cx2072x.c b/sound/soc/codecs/cx2072x.c
index 83c6cbd40804..0dd35fa86cc5 100644
--- a/sound/soc/codecs/cx2072x.c
+++ b/sound/soc/codecs/cx2072x.c
@@ -11,7 +11,7 @@
 #include <linux/acpi.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/init.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
diff --git a/sound/soc/codecs/dmic.c b/sound/soc/codecs/dmic.c
index 61e1bf1b3c9e..8b05d6f9b429 100644
--- a/sound/soc/codecs/dmic.c
+++ b/sound/soc/codecs/dmic.c
@@ -6,7 +6,7 @@
  */
 
 #include <linux/delay.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/gpio/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
-- 
2.39.5

