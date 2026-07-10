Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0E03B895E;
	Fri, 10 Jul 2026 21:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783718467; cv=none; b=ATZYLG8ivHG1YWtHZcy11yCCffN68lxWGSbxSmE93jalsxGWedPgAh6AnF8uLebPAGk2W7aPvvFeuj4yfsTJVoBkM0m2pGvpM9s2Kpm7/SdIEhTdk+zF6QvSr7RjiBPMkMHMpKZgnD7hArqyl6zE96z/5nDg0YiJYzCtWEyZWU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783718467; c=relaxed/simple;
	bh=ZUyFGyAKWaKXJoGeOtwrmmcCCGsSVoTyLELAtY6AyZU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WzAvhmUZcTsgSKChH3UGOTaO/jzQzWOn2MsYT6jTSuLWl46/3z/uwLO/bK+6EPGnGAfejjjzCaUL8ZztJW32I/AKwgHFTCDddPb837Pwmzqm8dxnzKE0I9OMWPR8366xqDqej/WwdqnC8ou6nvBsRCaNQ0btH0y7m6xq/wxEZEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TX6yUC2n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TX6yUC2n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE2BD1F000E9;
	Fri, 10 Jul 2026 21:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783718464;
	bh=nv7cz44iwUgVWCe/vkeZL2xE/X/Pa4B1obmjmVQVapk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TX6yUC2nv2Y+OJjIq1TAChYa9ehBIOLyVpW/H6xv26I8eshyz4Y3fs3LlQ2KQPYPI
	 jx7CzBx7Ehzs8JVdiGkcZJDO0ynoVqn4hG+FHhZqqRM5hUmMBlkIRr+3xatfBIZ4D5
	 W1yW5kIpwzVV0RY6k21fsNNpaZoJ0BLffrAylzLXjOklVFn5m6xaUnGe8ZjhnYBQX8
	 a3kSj7/dUnTuiJkjOlGL04uB57q5b2E3E31KvTntPuaj8Jb5NfT490w6pJRiZkF7n2
	 t2BaCMqKSc6r23YjmpjmbOGFnbQpBBKjfJcmmAod7v1OLjIzCaSUZAVeGDCOtkgM/Z
	 TaaH4j5bP5gQg==
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
Subject: [PATCH v2 09/10] Input: matrix_keyboard - replace linux/gpio.h inclusion
Date: Fri, 10 Jul 2026 23:19:54 +0200
Message-Id: <20260710211954.1373336-10-arnd@kernel.org>
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

linux/gpio.h is going away, so remove that since the driver already
includes linux/gpio/consumer.h.

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/input/keyboard/matrix_keypad.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/input/keyboard/matrix_keypad.c b/drivers/input/keyboard/matrix_keypad.c
index e50a6fea9a60..8863b741d1a3 100644
--- a/drivers/input/keyboard/matrix_keypad.c
+++ b/drivers/input/keyboard/matrix_keypad.c
@@ -16,7 +16,6 @@
 #include <linux/interrupt.h>
 #include <linux/jiffies.h>
 #include <linux/module.h>
-#include <linux/gpio.h>
 #include <linux/input/matrix_keypad.h>
 #include <linux/slab.h>
 #include <linux/of.h>
-- 
2.39.5

