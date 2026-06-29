Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB51636A366;
	Mon, 29 Jun 2026 13:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782739699; cv=none; b=iyWCDobA2jUBdSKBsRorK79k1ZKPfeL/ThmS7BRO/Dw/sx1gVq2mkZPZy2z2zuxNo9JFR6a4DsKm20Jp+pueHNFsFQxlJCx0auuBHE6OzbI6ZtGQebJvPhp+05HLy9rGhsv+BDgOm/8Dp6q3E/3fnR25kCsob6VAxAeP4XgKhyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782739699; c=relaxed/simple;
	bh=j+Xq+qlf0aQy5fadHBX3DKpcoyWe26ABu8Ry5PWEXLM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gZOZCEenL6dg3lhJx2agmm9T5YkZrbI2l+dGpQaYVK4dAgpKDa2X7s9SEmLT+4Phx7hn6r21OVId2aJyNRlv6vPpxXUIlXsqPg7npL5DHuBomc2k/cEDhC3RXhF31Kaepsdl6BtKhXgyxspfd4iuK0cXbS9abptwJ3g+qElETdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h5AFqQi4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h5AFqQi4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 089BD1F00A3A;
	Mon, 29 Jun 2026 13:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782739698;
	bh=iYwaK59VeErRBhP0Q9iTMSGYiDgPnUNQAe6MLCdyQLw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h5AFqQi4jStPxyTSP1+6Qa/JvBSIFtVgK0MNZzsiH6wjFRswa/RLrnQqFNHih/qjG
	 EWv3fVYPKDKbBtHjWpFdO8cIy9X4E9hkJpPP6vBXA8/qsQylAAtt6v+NK73U7OXv92
	 YB7mQNWAxRfG6dGtDgsPLk0YTrL8XMwVLZP0DiJLe31ovoUMss8UP/7D/l/j5xY8/E
	 GWyr+Tst/J+V3i8q9C/i4YobqaQblCJhFZjTHY4YfQcFjDhwMaiBx0Ip4Lj1e9DE6L
	 mM017Lryq9TQOfeRAPIp4At1UOUu2ZNtp0Xj6zezM1lXYTXWiO8CpisTNWLtJuCnOG
	 JFsljvXoooevw==
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
Subject: [PATCH 13/13] gpiolib: remove linux/gpio.h
Date: Mon, 29 Jun 2026 15:26:33 +0200
Message-Id: <20260629132633.1300009-14-arnd@kernel.org>
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

After all other drivers have converted to linux/gpio/consumer.h
or linux/gpio/legacy.h, remove the final leftover bits here.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 MAINTAINERS                   |  1 -
 drivers/gpio/TODO             |  4 +---
 drivers/gpio/gpiolib-cdev.c   |  2 +-
 drivers/gpio/gpiolib-legacy.c |  3 +--
 drivers/gpio/gpiolib.c        |  2 +-
 include/linux/gpio.h          | 22 ----------------------
 6 files changed, 4 insertions(+), 30 deletions(-)
 delete mode 100644 include/linux/gpio.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 15011f5752a9..7f3f386b1d8c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11175,7 +11175,6 @@ F:	Documentation/devicetree/bindings/gpio/
 F:	Documentation/driver-api/gpio/
 F:	drivers/gpio/
 F:	include/dt-bindings/gpio/
-F:	include/linux/gpio.h
 F:	include/linux/gpio/
 K:	(devm_)?gpio_(request|free|direction|get|set)
 K:	GPIOD_FLAGS_BIT_NONEXCLUSIVE
diff --git a/drivers/gpio/TODO b/drivers/gpio/TODO
index 7ce80fde1f17..894c7e1af252 100644
--- a/drivers/gpio/TODO
+++ b/drivers/gpio/TODO
@@ -52,9 +52,7 @@ Work items:
   base can be made dynamic (set to -1) if CONFIG_GPIO_SYSFS is disabled.
 
 - When this work is complete (will require some of the items in the
-  following ongoing work as well) we can delete the old global
-  numberspace accessors from <linux/gpio.h> and eventually delete
-  <linux/gpio.h> altogether.
+  following ongoing work as well) we can delete <linux/gpio/lagacy.h>.
 
 -------------------------------------------------------------------------------
 
diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index 82f27db0b230..9b6a28819371 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -11,7 +11,7 @@
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/file.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/gpio/driver.h>
 #include <linux/hte.h>
 #include <linux/interrupt.h>
diff --git a/drivers/gpio/gpiolib-legacy.c b/drivers/gpio/gpiolib-legacy.c
index ef3f2ef30cf2..33e5a45e720b 100644
--- a/drivers/gpio/gpiolib-legacy.c
+++ b/drivers/gpio/gpiolib-legacy.c
@@ -7,8 +7,7 @@
 
 #include <linux/gpio/consumer.h>
 #include <linux/gpio/driver.h>
-
-#include <linux/gpio.h>
+#include <linux/gpio/legacy.h>
 
 #include "gpiolib.h"
 
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index e5fb60111151..1f498d6c8c68 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -29,7 +29,7 @@
 #include <linux/string.h>
 #include <linux/string_choices.h>
 
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/gpio/driver.h>
 #include <linux/gpio/machine.h>
 
diff --git a/include/linux/gpio.h b/include/linux/gpio.h
deleted file mode 100644
index b0d4942a65de..000000000000
--- a/include/linux/gpio.h
+++ /dev/null
@@ -1,22 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * NOTE: This header *must not* be included.
- *
- * If you're implementing a GPIO driver, only include <linux/gpio/driver.h>
- * If you're implementing a GPIO consumer, only include <linux/gpio/consumer.h>
- * If you're using the legacy interfaces, include <linux/gpio/legacy.h>
- */
-
-#ifndef __LINUX_GPIO_H
-#define __LINUX_GPIO_H
-
-#include <linux/types.h>
-#ifdef CONFIG_GPIOLIB
-#include <linux/gpio/consumer.h>
-#endif
-
-#ifdef CONFIG_GPIOLIB_LEGACY
-#include <linux/gpio/legacy.h>
-#endif /* CONFIG_GPIOLIB_LEGACY */
-
-#endif /* __LINUX_GPIO_H */
-- 
2.39.5

