Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CAB1C3F31;
	Sat, 11 Jul 2026 02:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783738358; cv=none; b=O7y9jU4PJtCZrCyeP5+S+L6uTu7ckEIOuGd2KOKMZcq2MP0T63eMGwIT60ijyqYZtalQDZgV3ucQlhzrTDhia+tsn6vARW0bS2/x8qd6eBzF8hSe0q4sK8EeuWSgUAGktkjCr7sh2T1cdoy+qnlSLkJKo3fJtR7v+KT961zAwTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783738358; c=relaxed/simple;
	bh=C4JjzYlTHOb/IQ0FThHKuzBfVRnQfUR3rI5B+rk4RMA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=MK+YgceNiFIO31B3xxAy5eC4EJ4s71bw/Ww70YbxXXxzRVmswtc+ox+/6M/K8SUCZTUb76CYG2nkWKKGXchO0rmAfVSX2YfHk+ecPppHuXtVlutUkTg0VP5eMvepjfHi0quBFlPvOzAtMiE1uqeP+jqI5+StvMQtzY6xWwuG6CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rANtJ8Qn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rANtJ8Qn"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 57AB8C2BCB8;
	Sat, 11 Jul 2026 02:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783738358;
	bh=C4JjzYlTHOb/IQ0FThHKuzBfVRnQfUR3rI5B+rk4RMA=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=rANtJ8Qn8IHvOYr+foD5mmUNKjBNfnbC6hrgac5IB9ir+YRSYvJupofBgrUGOSyol
	 qW5/DBVo84dwPenmOvXUNj1OqYusEE23JZWfXokx/srb9Vgrs6GtoOrb2Sw2niF18o
	 RD7tOweooR6z/NakXZUWYe2K+YvZY4wYa4DPrX44XNqbEUJgjyWUBLPTiRzT8rL2tW
	 eClqqgDWrJE1/YpUXVhTNKSOBcEp03u9osxLG5QXFOOG2wwaQWx04Jtsd9eZpLE84R
	 TYdYEVwa5W5vyBtd8hedQABaTt2n5axMd+fj4m0GGP0zpXzLTxQYWzAMrewqOUz2K9
	 VYz+fDSWhXj1g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35385C43458;
	Sat, 11 Jul 2026 02:52:38 +0000 (UTC)
From: Miles Krause via B4 Relay <devnull+mileskrause5200.gmail.com@kernel.org>
Date: Fri, 10 Jul 2026 22:52:36 -0400
Subject: [PATCH v3] Input: qt1050 - wait for calibration to complete
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-qt1050-calibration-status-bit-v3-1-cc9ae3f0b2ec@gmail.com>
X-B4-Tracking: v=1; b=H4sIAPOvUWoC/5WOyw7CIBQFf6VhLQawLdaV/2FcQLm01/ShQImm6
 b9L68alLieZzDkz8eAQPDllM3EQ0eM4JDjsMlK3amiAoklMBBMlk5zRR+CsYLRWHWqnQtKpDyp
 MnmoMlGkBuaysNbkmqXF3YPG59S/XD/tJ36AOa3Q1WvRhdK/tQOSr9+tW5JRTyK003MhK6vLc9
 Aq7fT32ZN2K4q+aSDVVHI0qc22shO/asixvRRD8PyoBAAA=
X-Change-ID: 20260710-qt1050-calibration-status-bit-0b2e479ffd4b
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh@kernel.org>, Marco Felsch <m.felsch@pengutronix.de>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sashiko <sashiko-bot@kernel.org>, Miles Krause <mileskrause5200@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783738357; l=3064;
 i=mileskrause5200@gmail.com; s=20260710; h=from:subject:message-id;
 bh=WQHr5mEu/gw6iREz/hzfxramkMr/pz+yHhcl6LNQ9tE=;
 b=K6EsXMlYrn+kamEyd/CqMT8QkfXsV3PiWGoPUJh1ixXGUfWohGNvasWl06MXRsjZrCd8mE/Hv
 O8fmABjf8WjCHhQ0shBC1smmieN5HNpXsOtyKCa3mfsiA+ppMVWX/cX
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

First wait for the flag to become set, then wait for it to clear before
continuing with the soft reset. Use a 500 ms completion timeout to leave
margin beyond the usual calibration time.

Fixes: cbebf5addec1 ("Input: qt1050 - add Microchip AT42QT1050 support")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/r/20260711024428.ED7FF1F000E9@smtp.kernel.org
Signed-off-by: Miles Krause <mileskrause5200@gmail.com>
---
Compile-tested on x86_64 with:

  make O=out allmodconfig
  make O=out W=1 drivers/input/keyboard/qt1050.o

Sparse-tested with:

  make O=out-sparse allmodconfig
  make O=out-sparse C=1 CHECK=sparse drivers/input/keyboard/qt1050.o
---
Changes in v3:
- Wait for calibration to start before waiting for completion.
- Increase the calibration completion timeout to 500 ms.
- Link to v2: https://patch.msgid.link/20260710-qt1050-calibration-status-bit-v2-1-a58da64bdf7e@gmail.com

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
 drivers/input/keyboard/qt1050.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/input/keyboard/qt1050.c b/drivers/input/keyboard/qt1050.c
index f9f480c91032..8cd061587302 100644
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
@@ -498,9 +499,18 @@ static int qt1050_probe(struct i2c_client *client)
 		return err;
 	}
 	err = regmap_read_poll_timeout(ts->regmap, QT1050_DET_STATUS, status,
-				 status >> 7 == 1, 10000, 200000);
+				 status & QT1050_DET_STATUS_CALIBRATE,
+				 10000, 200000);
 	if (err) {
-		dev_err(dev, "Calibration failed: %d\n", err);
+		dev_err(dev, "Calibration did not start: %d\n", err);
+		return err;
+	}
+
+	err = regmap_read_poll_timeout(ts->regmap, QT1050_DET_STATUS, status,
+				       !(status & QT1050_DET_STATUS_CALIBRATE),
+				 10000, 500000);
+	if (err) {
+		dev_err(dev, "Calibration did not complete: %d\n", err);
 		return err;
 	}
 

---
base-commit: c8f174900926d3b58cd048ac33b4cbb3de419bfe
change-id: 20260710-qt1050-calibration-status-bit-0b2e479ffd4b

Best regards,
--  
Miles Krause <mileskrause5200@gmail.com>


