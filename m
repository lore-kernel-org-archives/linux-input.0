Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D96A41C72;
	Sat, 11 Jul 2026 02:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783737325; cv=none; b=suxMT8YuDhinbLRUs3ST0oTpD3Q75Ih0YG4bG59gzHLg/JgNf5BmaQpa3IufkbPt+fGJb7+uAzBSPrGb/gB502QiPe4MA8xC+RB/vqbViiS2WKC3O9aJuY/E2lwHJ5ZJ9xwl0esac83DDmn0vsr//13xjaQVUT7mPpqXQGrtBYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783737325; c=relaxed/simple;
	bh=a9QLZ8/YTGbQ8E5OfeeCLHuA1ohbUPo7wTQ9m81Qrwo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=uX11klaMcwD/M/AyIz5Oh8zcAMe0ab3ip/G2VqTAKM1zghMGMlsAb1Xqda68PFGzE+mRalNPnMH7+5d2JToJa5OapSzCHFgJlxZg346aWFS/b8KPDowHWGai1tznZ9kXWvOAZvw3JtFtT1WLBfAk4B9kl1T/Qq+eRhA0r0YFEWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UTRj2HJh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UTRj2HJh"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 923FEC2BCB8;
	Sat, 11 Jul 2026 02:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783737324;
	bh=a9QLZ8/YTGbQ8E5OfeeCLHuA1ohbUPo7wTQ9m81Qrwo=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=UTRj2HJheP0hHAJLJfTQTmHzA/KSy+/V603IoxZRjZo5e5RafYmsjioLc+yKfz1g7
	 D66mJ8p1/ME4aa7Tsp41KxgjsNSHWc0M09QeQrf2LrgFrk0yYcv61CH6aFGLyEAW5a
	 LKl2NTSrL4UhiIdTE/fb6yYDscYzcfvHHwlTYJ0kAIUkxQMlL61ol4CTfzNTH+dH8N
	 fVkdxDzt9UodFTMqrhXXa1Yx/8LZh6CxCwxwqAuaJHhg1G4Y0x/jN3OdAX01bvZ/7K
	 FZmHXEv/UFqlqGi7CkCMuu4Ba+B1iBVKzUnAIym2oiPr53KnY9kbcMdXlrf2w+BR2v
	 Ckz1FLDQkhMsg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B914C43458;
	Sat, 11 Jul 2026 02:35:24 +0000 (UTC)
From: Miles Krause via B4 Relay <devnull+mileskrause5200.gmail.com@kernel.org>
Date: Fri, 10 Jul 2026 22:35:18 -0400
Subject: [PATCH v2] Input: qt1050 - wait for calibration to complete
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-qt1050-calibration-status-bit-v2-1-a58da64bdf7e@gmail.com>
X-B4-Tracking: v=1; b=H4sIAOWrUWoC/42OSw6CMBRFt0I69pm2QRocuQ/DoJ9XeIaPtoVoC
 Hu34AYcnuTk3LuyiIEwsmuxsoALRZrGDPJUMNvpsUUgl5lJLiuuBIdXEvzCweqeTNAp6xCTTnM
 EQwm4kViq2ntXGpYbz4Ce3kf/3vw4zuaBNu3R3egopil8jgOL2L1/txYBArD0ygmnamWqWzto6
 s92GlizbdsXAjmhztwAAAA=
X-Change-ID: 20260710-qt1050-calibration-status-bit-0b2e479ffd4b
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sashiko <sashiko-bot@kernel.org>, Miles Krause <mileskrause5200@gmail.com>, 
 Rob Herring <robh@kernel.org>, Marco Felsch <m.felsch@pengutronix.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783737324; l=2442;
 i=mileskrause5200@gmail.com; s=20260710; h=from:subject:message-id;
 bh=yOyfXbtdozLVe5JzVAxDjGUfBsAtmdRN/Rae3W6CsXE=;
 b=zLMTxk7rHnFaSHpwDwXofzKVrRC9LxjgCYlEzWIeNnjXyukDFhjDtuULt3ZRv3jejx5TbEa59
 PYSko5+pQ5gCgGsEN6yYiGqYSl6KXsxXum7iELnYOhcvDcn1b3OqsHi
X-Developer-Key: i=mileskrause5200@gmail.com; a=ed25519;
 pk=QNhNjcQarqig3ColJBIEr3DYfWM1PHpP7z+6thxWXaU=
X-Endpoint-Received: by B4 Relay for mileskrause5200@gmail.com/20260710
 with auth_id=861
X-Original-From: Miles Krause <mileskrause5200@gmail.com>
Reply-To: mileskrause5200@gmail.com

From: Miles Krause <mileskrause5200@gmail.com>

The CALIBRATE flag is set when calibration begins and clears when it
finishes. regmap_read_poll_timeout() stops when its condition becomes
true, so the existing condition returns when calibration starts instead
of waiting for it to finish.

Name the calibration status bit and invert the polling condition so the
subsequent soft reset does not potentially interrupt calibration.

Fixes: cbebf5addec1 ("Input: qt1050 - add Microchip AT42QT1050 support")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/r/20260711011903.0605C1F000E9@smtp.kernel.org
Signed-off-by: Miles Krause <mileskrause5200@gmail.com>
---
Compile-tested on x86_64 with:

  make O=out allmodconfig
  make O=out W=1 drivers/input/keyboard/qt1050.o

Sparse-tested with:

  make O=out-sparse allmodconfig
  make O=out-sparse C=1 CHECK=sparse drivers/input/keyboard/qt1050.o
---
Changes in v2:
- Invert the polling condition to wait for calibration to finish.
- Reframe the change as a bug fix based on Sashiko's review.
- Link to v1: https://patch.msgid.link/20260710-qt1050-calibration-status-bit-v1-1-e4f7d1d797b6@gmail.com

To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Rob Herring <robh@kernel.org>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/input/keyboard/qt1050.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/input/keyboard/qt1050.c b/drivers/input/keyboard/qt1050.c
index f9f480c91032..457acae0986a 100644
--- a/drivers/input/keyboard/qt1050.c
+++ b/drivers/input/keyboard/qt1050.c
@@ -27,7 +27,8 @@
 #define QT1050_FW_VERSION	0x01
 
 /* Detection status */
-#define QT1050_DET_STATUS	0x02
+#define QT1050_DET_STATUS		0x02
+#define QT1050_DET_STATUS_CALIBRATE	BIT(7)
 
 /* Key status */
 #define QT1050_KEY_STATUS	0x03
@@ -498,7 +499,8 @@ static int qt1050_probe(struct i2c_client *client)
 		return err;
 	}
 	err = regmap_read_poll_timeout(ts->regmap, QT1050_DET_STATUS, status,
-				 status >> 7 == 1, 10000, 200000);
+				 !(status & QT1050_DET_STATUS_CALIBRATE),
+				 10000, 200000);
 	if (err) {
 		dev_err(dev, "Calibration failed: %d\n", err);
 		return err;

---
base-commit: c8f174900926d3b58cd048ac33b4cbb3de419bfe
change-id: 20260710-qt1050-calibration-status-bit-0b2e479ffd4b

Best regards,
--  
Miles Krause <mileskrause5200@gmail.com>


