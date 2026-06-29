Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EBA3FF882;
	Mon, 29 Jun 2026 13:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782739672; cv=none; b=WALUC2XVklNBMjzUNkGNaW50dl0ESf2rb+UaMnDWLvJqLN0shTjIBdlnXh+8TlijVjsqwWiM5yjM2uz5/q6sGvEKMQ2PyYup7SGj5TkeOg8OhfqwGQs+6dG3WLjEcyU2Dq+1Sr5RMiAVPCimObCtMkQjvVA9dSI3NPSakZvoGpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782739672; c=relaxed/simple;
	bh=HjfFL0am9vxsV7d0k9jRsOtm7aABoaj496THOMS1g7Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UI57A7MGyPEVUauzjjm5HgEAfgkZJyacUAB4si88qAls3qmyQ3T8YbCua5sMPY2d5zpVoB+f5Nsmqno8t5jht2iO8EZtPx+9T8ugCKXYJf3QmUSvbxbBDI3RsMLZ0XGkS0/5yD7YLz+jrm6uLAoaHlH2S9vA82vUVkzkgVih5C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=frCMq+90; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="frCMq+90"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECD421F00A3A;
	Mon, 29 Jun 2026 13:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782739670;
	bh=TSJ5H7bOOMhyz7FEoPXZ7o9gnbiAA9g1/+KyzvH3xDI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=frCMq+90h/OOkRt3VRllbgW3boGE8WzpIkP6+O9NYpBXkdj0qYzG++XaK7GJMpAGD
	 t5ScqajVzKDdc9QUmdl5re7CGxfTCnwyyyVsDQCQFmok9I/fhirTzPrcrodaFyUQL8
	 AZs3SrUwykM4Z/z4AX6z8O3sjPR3oLjDjs0Ah+JtckiqquvFAkl9DnIBTe34eh94Fi
	 LDsahVUUuCuZwGmrB98x6WbJqA4xl08HihuVeRXdM1MaGOUIebzbGow9y3/cMvd5zG
	 9fVZt5FPz0wFhjpVOnRv94Jk5QSvb/i2t4FHYbQH7gTgFlHNh3aBtXVVCN3r0AbKah
	 WqU08S/XD1bGA==
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
Subject: [PATCH 09/13] phy: replace linux/gpio.h inclusions
Date: Mon, 29 Jun 2026 15:26:29 +0200
Message-Id: <20260629132633.1300009-10-arnd@kernel.org>
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

linux/gpio.h should no longer be used, convert these instead to
either linux/gpio/consumer.h or linux/gpio/legacy.h as needed.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/phy/broadcom/phy-bcm-ns2-usbdrd.c | 2 +-
 drivers/phy/rockchip/phy-rockchip-usbdp.c | 2 +-
 drivers/phy/ti/phy-j721e-wiz.c            | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/broadcom/phy-bcm-ns2-usbdrd.c b/drivers/phy/broadcom/phy-bcm-ns2-usbdrd.c
index 8473fa574529..d9c06129ed23 100644
--- a/drivers/phy/broadcom/phy-bcm-ns2-usbdrd.c
+++ b/drivers/phy/broadcom/phy-bcm-ns2-usbdrd.c
@@ -3,7 +3,7 @@
 
 #include <linux/delay.h>
 #include <linux/extcon-provider.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
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
index 7531a8a04912..2233babc0078 100644
--- a/drivers/phy/ti/phy-j721e-wiz.c
+++ b/drivers/phy/ti/phy-j721e-wiz.c
@@ -11,7 +11,7 @@
 #include <linux/slab.h>
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/gpio/consumer.h>
 #include <linux/io.h>
 #include <linux/module.h>
-- 
2.39.5

