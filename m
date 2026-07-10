Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BAB3B7741;
	Fri, 10 Jul 2026 21:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783718459; cv=none; b=TJHhb3cVBeQwdV4fwl3gLECOwZxOM/9mlCVXt9e415kOwH35ThXBMN5GS3F+OniqPZAfHgdrazq03upmi784Vm/t6nUtkO2kQYX6vMuWsDjUxRgwNoPAsUCcUDYGjL5Ur+4KFVkFcj//UM9GITohvZSWJ49y3K+2d9bG+wVigBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783718459; c=relaxed/simple;
	bh=6jteeCAcT3+N3BA7R9A6RQ5K/uVNwWbuABYnr08/LWw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XnS82kOcRcx4UuJsNN53l8UEAAWChQoi5wL85gqGNuQf9wxqVzh5weqQfoLjtxnTQYB4jJj14HSFHvP4/e0JFF9tcBRzzwz1ZvnXJ4xS+27PFUSMmI6NQy8GuE1ZWsAVqD90QEJ+4O2LLxB8qXXMSou8zEwbjl4zKuIbdI7KhuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HGyes/oH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HGyes/oH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67B511F00A3D;
	Fri, 10 Jul 2026 21:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783718458;
	bh=b37fFY1bviqEnaLlbm41fcnqbx2JSx0mhMImAdcr6E0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HGyes/oHC8M+ATz3uD0lP9e+9cgWWjj6YY6Sz2mUhzsz6RPvOZG4q+VrnxpwAXGQW
	 6dJ2OVFIVAhWXAlxy3CCmtli9rDf4UfOZqtn3W8PENfRMoxJ2Ux3TvRaPMfUpSyhQU
	 xJuwmr4i7/Jz1E7ZzsAYwZQPrKp3C8p1Ad8ukCLGadL5rQwJ6p2A5Rr0Dsih8utYRe
	 SWfpYfCkS0cKQ2J461R6NUUdFZOyfbxio9fhJC4oZ59lGcq0f+BecEOa4sgYTj4bCn
	 hFpCDPCqBfseIR7u3HiwD10EIK4KXsm2m+0344hw/dScFOZD2BG9zHV/t2cMk0sJU+
	 r6lNKDBcS9llw==
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
Subject: [PATCH v2 08/10] phy: replace linux/gpio.h inclusions
Date: Fri, 10 Jul 2026 23:19:53 +0200
Message-Id: <20260710211954.1373336-9-arnd@kernel.org>
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

linux/gpio.h should no longer be used, so remove those and
make sure linux/gpio/consumer.h is included instead.

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/phy/broadcom/phy-bcm-ns2-usbdrd.c | 1 -
 drivers/phy/rockchip/phy-rockchip-usbdp.c | 2 +-
 drivers/phy/ti/phy-j721e-wiz.c            | 1 -
 3 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/phy/broadcom/phy-bcm-ns2-usbdrd.c b/drivers/phy/broadcom/phy-bcm-ns2-usbdrd.c
index 8473fa574529..171bf097a8b8 100644
--- a/drivers/phy/broadcom/phy-bcm-ns2-usbdrd.c
+++ b/drivers/phy/broadcom/phy-bcm-ns2-usbdrd.c
@@ -3,7 +3,6 @@
 
 #include <linux/delay.h>
 #include <linux/extcon-provider.h>
-#include <linux/gpio.h>
 #include <linux/gpio/consumer.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
diff --git a/drivers/phy/rockchip/phy-rockchip-usbdp.c b/drivers/phy/rockchip/phy-rockchip-usbdp.c
index fba35510d88c..d0d736a30d08 100644
--- a/drivers/phy/rockchip/phy-rockchip-usbdp.c
+++ b/drivers/phy/rockchip/phy-rockchip-usbdp.c
@@ -11,7 +11,7 @@
 #include <linux/bits.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/mfd/syscon.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
diff --git a/drivers/phy/ti/phy-j721e-wiz.c b/drivers/phy/ti/phy-j721e-wiz.c
index 7531a8a04912..1f5dba49ace4 100644
--- a/drivers/phy/ti/phy-j721e-wiz.c
+++ b/drivers/phy/ti/phy-j721e-wiz.c
@@ -11,7 +11,6 @@
 #include <linux/slab.h>
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
-#include <linux/gpio.h>
 #include <linux/gpio/consumer.h>
 #include <linux/io.h>
 #include <linux/module.h>
-- 
2.39.5

