Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F6A3C2BBE;
	Fri, 21 Aug 2026 21:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787347845; cv=none; b=tLAUv0XvN0J4TiKJtJD4jO6aItDr8J7fO03kT4s99NwNfSvDsLfpN/9/Z/5m1X4FiF66Z3LDnu1+lHMPzdmC6baHhrEIjw0XY+c4+lUOIn2J6aeFWslZNWoNdHGT5a0I8vOVa5pZSJalWif4MhE2Tp+7AumokO3M3m+tUJMSlTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787347845; c=relaxed/simple;
	bh=eEtSFkQ1r4h92neMD9WAjhSengBMVp7TXE0CHsypDoE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WLRgqP6FsUn1L0yN2yXI6oT/m/4xDhtzks3ORRuFQFu0unT7rLfTabGgofm8dy9daA9kdaxA0tTA7gr7ZAcGOJRYWo6HuDtHTGZeTo3mBNOq3fQv9/y3iLfUl7uZxNhzLLakgxB49nSDauM3SaOjwBNhFJX+/Utfxkp/ExTCHVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YQXuaxLt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YQXuaxLt"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 30B7DC2BCF7;
	Fri, 21 Aug 2026 21:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1787347845;
	bh=eEtSFkQ1r4h92neMD9WAjhSengBMVp7TXE0CHsypDoE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=YQXuaxLtvPx7F0/+e9DYUhjoDeAHToc4F43G+7El3WJukltuKgjDaVo13SG31ZRuY
	 SbPj/jMHazq2wJ3n4/mfGwsFGwQoydaBOuIxcgNXqTRWa1+a9D0xK7bZTpubNGrQBf
	 gN/T+/epsJ8Ya3pm/DcUdswI/fle+juPf/zXLLl7jP0hFJHi9jhJFcQX0rvwP4BKqp
	 tiKum0GwbnMVHbPMsGZSpmWrmLTuIG72hyxcUPJwI7VpzaH3ccWiYVagSbI66sb6ul
	 /1qCv0K2+uJr26d8TJ+HZrlZy5Bc73v+k2fy5UUg5Yt4iTB53o0azDD/3AAI2zyl63
	 pvPLyiwcvJDoQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D4C7C5DF9B;
	Fri, 21 Aug 2026 21:30:45 +0000 (UTC)
From: Markuss Broks via B4 Relay <devnull+markuss.broks.gmail.com@kernel.org>
Date: Sat, 22 Aug 2026 00:30:17 +0300
Subject: [PATCH 5/5] Input: imagis - add support for IST4050
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260822-imagis-40xx-v1-5-73e6d6cdf110@gmail.com>
References: <20260822-imagis-40xx-v1-0-73e6d6cdf110@gmail.com>
In-Reply-To: <20260822-imagis-40xx-v1-0-73e6d6cdf110@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Henrik Rydberg <rydberg@bitmath.org>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Markuss Broks <markuss.broks@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787347843; l=2500;
 i=markuss.broks@gmail.com; s=20260803; h=from:subject:message-id;
 bh=UyRIydLek5fXGaLKcikWjx0AWVlXprKtHklwuZw8lBY=;
 b=ctEYCAqRbPnvqlBuV9ssbb0NokAiCtEwBZaZLprPpKtNGM6pUchmWwzrYqwGTF08a/9khUvHn
 sXYecFl38uFCXfbSRwgzL6s5/GhLQD3fjtBewApPhS2AaFAv33tqbRa
X-Developer-Key: i=markuss.broks@gmail.com; a=ed25519;
 pk=oKzGUTm30BCDqinRMpiHQqByOx1mp2mwmhg80Mv7Zg4=
X-Endpoint-Received: by B4 Relay for markuss.broks@gmail.com/20260803 with
 auth_id=911
X-Original-From: Markuss Broks <markuss.broks@gmail.com>
Reply-To: markuss.broks@gmail.com

From: Markuss Broks <markuss.broks@gmail.com>

The Imagis IST4050 shares the register interface and the power-up
sequence with IST3038C, and reports touches using the IST40xx touch
reporting format. Its chip ID register reads back 0x4050.

Also mention the IST40xx family in the Kconfig help text, and refer to
the older chips as IST30xx, since the driver supports more than the C
variants.

Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
---
 drivers/input/touchscreen/Kconfig  |  2 +-
 drivers/input/touchscreen/imagis.c | 10 ++++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 9b9ae8ac3f7f..96fdc4384a75 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -705,7 +705,7 @@ config TOUCHSCREEN_IMAGIS
 	tristate "Imagis touchscreen support"
 	depends on I2C
 	help
-	  Say Y here if you have an Imagis IST30xxC touchscreen.
+	  Say Y here if you have an Imagis IST30xx or IST40xx touchscreen.
 	  If unsure, say N.
 
 	  To compile this driver as a module, choose M here: the
diff --git a/drivers/input/touchscreen/imagis.c b/drivers/input/touchscreen/imagis.c
index 5254cccdd653..9bf5afd43848 100644
--- a/drivers/input/touchscreen/imagis.c
+++ b/drivers/input/touchscreen/imagis.c
@@ -23,6 +23,7 @@
 #define IST3032C_WHOAMI			0x32c
 #define IST3038C_WHOAMI			0x38c
 #define IST3038H_WHOAMI			0x38d
+#define IST4050_WHOAMI			0x4050
 
 #define IST3038B_REG_CHIPID		0x30
 #define IST3038B_WHOAMI			0x30380b
@@ -491,12 +492,21 @@ static const struct imagis_properties imagis_3038h_data = {
 	.protocol = IMAGIS_PROTOCOL_SHARED_REGISTER,
 };
 
+static const struct imagis_properties imagis_4050_data = {
+	.interrupt_msg_cmd = IST3038C_REG_INTR_MESSAGE,
+	.touch_coord_cmd = IST3038C_REG_TOUCH_COORD,
+	.whoami_cmd = IST3038C_REG_CHIPID,
+	.whoami_val = IST4050_WHOAMI,
+	.protocol = IMAGIS_PROTOCOL_TOUCH_EVENTS,
+};
+
 static const struct of_device_id imagis_of_match[] = {
 	{ .compatible = "imagis,ist3032c", .data = &imagis_3032c_data },
 	{ .compatible = "imagis,ist3038", .data = &imagis_3038_data },
 	{ .compatible = "imagis,ist3038b", .data = &imagis_3038b_data },
 	{ .compatible = "imagis,ist3038c", .data = &imagis_3038c_data },
 	{ .compatible = "imagis,ist3038h", .data = &imagis_3038h_data },
+	{ .compatible = "imagis,ist4050", .data = &imagis_4050_data },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, imagis_of_match);

-- 
2.55.0


