Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC75EED8;
	Sat, 11 Jul 2026 01:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783732148; cv=none; b=vGoWbONH78t6Hq25zNvFb8efOLBWnWkEz9ixVMlxxgThNnQTgP1WY8jk45UAZ8A9FSJGbj/kdoWQSmRIhz23dlPRffkHBvnM8+rKHABwxJylcpxCg0N7t/O/KFyW0dDFqd2z7cD3oSnC70YitY3mCK1nKKC90ij5eDiiqXyRPD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783732148; c=relaxed/simple;
	bh=BnECkKJ9/c3FjQOTakLYaNAGEaZabCU6kNQZqFNTFSo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=e8r0B5sKljHULYG1SCjlI1yOjBNVuts2ZbPMnOs+ZI3kJtodjk8kRTZPXkTElmL/baZP0G1/HKUlasba0uWUvF9rc0pB4bTVnpIcUPLxkyOKnBg195Tp+mxa9rM/ZmA0Gz2fq6fLOSsqLSpsB4h0MfMOPpeguGh2rlWIPemqt2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R5DEATb3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R5DEATb3"
Received: by smtp.kernel.org (Postfix) with ESMTPS id DE8F0C2BCB8;
	Sat, 11 Jul 2026 01:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783732147;
	bh=BnECkKJ9/c3FjQOTakLYaNAGEaZabCU6kNQZqFNTFSo=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=R5DEATb3QrFBBXg05ri0l9C8hZuRhhf8K7iAI9h+otmA1Bw7kK7cqdRrjK78vKF0a
	 YxCzA18fplACKUEnth6rykmfI/Ter1sx9xXUe5olKfVn2sP9B1vLXbGxm/2HtFRTPI
	 cuHXRBMpYeKrIoL77okO1XlZiD6BYfHssMSS+AqTKY+XLjNYCBIabxeVuHSlbZ6Opx
	 cj8EUjdXC7hosdvn5AYsikCBaVeeRuNNW8vAzk8ijybMSm13QlOJApeHnwoSABxAM7
	 EdAUgrTGT30ukuSHNX2vBLsFyOWHAZmaHxB64D9gQZR4yba64V3NNrw6vsGVMp14G8
	 MCdboHzxzCNiQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC5B5C43458;
	Sat, 11 Jul 2026 01:09:07 +0000 (UTC)
From: Miles Krause via B4 Relay <devnull+mileskrause5200.gmail.com@kernel.org>
Date: Fri, 10 Jul 2026 21:09:02 -0400
Subject: [PATCH] Input: qt1050 - name calibration status bit
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-qt1050-calibration-status-bit-v1-1-e4f7d1d797b6@gmail.com>
X-B4-Tracking: v=1; b=H4sIAK2XUWoC/yXM0QrCMAxA0V8ZeTaQlunQXxEfmi7ViExtMhHG/
 t2qjwcudwGTqmJw6Bao8lLT+9QQNh3kS5rOgjo2Q6S4oyEQPj3QljCnm3JN3nI0Tz4bsjoSR+m
 HfSljz9AejypF37//8fS3zXyV7N8prOsH7Mwwz4EAAAA=
X-Change-ID: 20260710-qt1050-calibration-status-bit-0b2e479ffd4b
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Miles Krause <mileskrause5200@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783732147; l=1610;
 i=mileskrause5200@gmail.com; s=20260710; h=from:subject:message-id;
 bh=RY4tjQcuZkpaCZPC5GXl5Z5TifqEyJldGFwLCDOhcWQ=;
 b=9osnnSmQILluaI7QKd2YiKmSqP18ai2gyI5pQmalCuXIgu8j1JCIAgj+BT68eMyBOG8O0fTaL
 PporRb9p7oFBANNAeQXzWOLZVUjVp5yRIvaESU7R32vRvPT/qB3qU1B
X-Developer-Key: i=mileskrause5200@gmail.com; a=ed25519;
 pk=QNhNjcQarqig3ColJBIEr3DYfWM1PHpP7z+6thxWXaU=
X-Endpoint-Received: by B4 Relay for mileskrause5200@gmail.com/20260710
 with auth_id=861
X-Original-From: Miles Krause <mileskrause5200@gmail.com>
Reply-To: mileskrause5200@gmail.com

From: Miles Krause <mileskrause5200@gmail.com>

Detection status bit 7 indicates that a calibration cycle is in
progress. Define a name for the bit and use it in the polling
condition instead of an open-coded shift and comparison.

No functional change.

Signed-off-by: Miles Krause <mileskrause5200@gmail.com>
---
Compile-tested on x86_64 with:

  make O=out allmodconfig
  make O=out W=1 drivers/input/keyboard/qt1050.o

Sparse-tested with:

  make O=out-sparse allmodconfig
  make O=out-sparse C=1 CHECK=sparse drivers/input/keyboard/qt1050.o
---
 drivers/input/keyboard/qt1050.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/input/keyboard/qt1050.c b/drivers/input/keyboard/qt1050.c
index f9f480c91032..2371ac027aab 100644
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
+				 status & QT1050_DET_STATUS_CALIBRATE,
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


