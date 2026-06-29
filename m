Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB29A404BFA;
	Mon, 29 Jun 2026 13:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782739685; cv=none; b=s5AryEiabCqIOR7IExhK0fa15larYkOIgTq6wT6yl0PofcunkV9b7LQ4rv7KA0N/XZOPWgfvR3vU1tF0vxZyM+kNykSKzRNqceZJpmBB72uN8DTjdaBrLbjPjYy7V+/Ij2oNyY/Gs0qvyNHOlM4PSM5a6mETbdaVnUI12VS6ocM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782739685; c=relaxed/simple;
	bh=obNPcB+BaZsnpRHlcsBGxQCruLKZ5xXtfc+XJI2PSpg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RKHn3sSA1kf6VI5uj1pt61I2upm6a4SsfUH9r4J+27vurV7dgF85KFZzFDdHwiF9JTcDUdRjY4aUhl40TxFfJVii8ev/hdOlcKXLEh7JarPFh9KTjDa56WeMMeuG7wQbf3ra+JlrCx8gKcZqV1nql9k/wRi0ZFYRdTfKpQXl6yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MdfFbWJ+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MdfFbWJ+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 095261F00A3D;
	Mon, 29 Jun 2026 13:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782739684;
	bh=NrdLJGMFs8wtvc4BJiEXLk7S18TXVPww8hdTab/uPp0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MdfFbWJ+eRFMBqPEa0RaoTx93bwz14wfILPGSeLWLBjlLfc3/sLoXDbWrIj5zm02+
	 Cf2hMRjwSDX/HAe9LEvEYerCFkB4Bk3PXB3dCOCCjACDoUXoZNbg8bIRYUlO4u3fYA
	 d+1jW1L/FhTyHKMjueY3fNJ+ZEn6tUHmVKdynuygFjwpm+i13U8Rgg7ESeNFEllxMf
	 MEenB1SREnePNOyBX0VPdLwMnOs4/5gV6TKMZk/7FolVupBaKJWIqfsANDATpC5cz+
	 GtYRhxo3yuIHrBGuNzZr02FwMfR28H0gTO6X9o6PxTogIxu8yfoYD9nvIRoXYg4F/d
	 k2IOqV+EaupRw==
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
Subject: [PATCH 11/13] Input: matrix_keyboard - replace linux/gpio.h inclusion
Date: Mon, 29 Jun 2026 15:26:31 +0200
Message-Id: <20260629132633.1300009-12-arnd@kernel.org>
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

linux/gpio.h is going away, so use linux/gpio/consumer.h instead.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/input/keyboard/matrix_keypad.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/matrix_keypad.c b/drivers/input/keyboard/matrix_keypad.c
index e50a6fea9a60..98d0269a978f 100644
--- a/drivers/input/keyboard/matrix_keypad.c
+++ b/drivers/input/keyboard/matrix_keypad.c
@@ -16,7 +16,7 @@
 #include <linux/interrupt.h>
 #include <linux/jiffies.h>
 #include <linux/module.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/input/matrix_keypad.h>
 #include <linux/slab.h>
 #include <linux/of.h>
-- 
2.39.5

