Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05B93EC80F
	for <linux-input@vger.kernel.org>; Thu,  3 Sep 2026 19:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788463886; cv=none; b=WhednZDUTFivvZ8E4XAzsqseiiaXyqbDv2THWlVkGIqnmsoUujjJe7bMC0WZmYEXLHSlD+2IzLrAuG8aVVxe7YzsX3vcG1pnX14HE7S20KEdCqXrFVLwZs5zl/78Vv76q4AgnXFfpdmEosgWArQ3QY6CZnnsQ+JEn35xpAJ6zuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788463886; c=relaxed/simple;
	bh=LRIB+Ien8LNhu1QGXr1xo2szN3dRaFD/6agQW0q8qxs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dfxDfE6RKAM6y9SS14+Ncfe+gwc/f9S1rAXxd12axjg77F12bXGm7JmajIQm+P+pKGgD17272olmBAR4+vmQPlToyByktmMkVjKKLi34Y/BPu0UFV5U4YVF1/NvGawAxTMoQm5Pfh/KfHnZZj/djZ7W42gRMTqsPX8n3AlxDGVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rwdqi28I; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rwdqi28I"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2d91ff7d9acso2039575ad.3
        for <linux-input@vger.kernel.org>; Thu, 03 Sep 2026 12:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788463872; x=1789068672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4yIetKXnfU6qQx5OfRzSQNhmvwvEsmpVmmGdbC2BbsE=;
        b=Rwdqi28IC2n6hedfuQzzuOvAxUHwIrsve3Gvv5hDjjOH8/BdTlPKNocnWSsZ9iHz24
         Cf+BJGD6z+rNWWJZ5WlUG9TeDcubItwYFJro72JonhFc1nnLyjJ/F9dSmhevIr6UQnIA
         wJshvg0BFGbf+Y5fSBSkZgfoHksoPLpFYdAYUWKh6V88P39NLoeLhRb+8kJiBMm3cEXr
         8q/hpredYakkLfqPSedRw2qfHjPHFjAAkwid8sfU4XUlCpGtOl5Fh/FcBVsVcoHPOEET
         bAuvGHb7GsC34+irRuoncZwGEQ5dvd4T206H1kllv9+yTopMbixMwhS5d+WNqOhPsrOb
         uhFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788463872; x=1789068672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4yIetKXnfU6qQx5OfRzSQNhmvwvEsmpVmmGdbC2BbsE=;
        b=OaM72UbclbEybJSeQrBvCy+MdOiMalonrHNQRaH+ycTOOTZ85Ej2S70RfEfcOws2gZ
         9yizS/7sF1dBEpxiWGvwZzAXNMAj1j3ZH6PQOXg09cutTc2hZwn2qOdy+SID/n+S+/7t
         lE77JBlIlZl4H+BJv2B5ATEiV5w+M4kJg5PxEdLEvmrhNwEHVGSvwYI4s2qeUj2SCPCh
         N6FlwOSaFOfwjVJlv5ex3T2X6rzV/3rugbvJMbHDzZ3W6J0gxY2JDAGX+fKL/j3RS3da
         QrGEbakakO0nlj9ysfaqZMKfwOHSbPbrsy+iSspoPKitrKJyuQLTogCuy6BUYijpwp2a
         WFjg==
X-Gm-Message-State: AFuF++kFasVhwhGt/S19QK3Vf2bMOglnG2fUYkXd2f/umqMlLx7YBBDz
	ql/Nq8g9xWWUgKRmO46AXeULeq0646Hdynhj0jvFdhWQGjC392UqwTgz
X-Gm-Gg: AYBFou3m+y2IuumU5dxtsi1a+fbAf7btdR5GdNUp3Snyh71fpwOFKIoPvlfBdsS+aV7
	Kyxh98TLvt9QDgwwv4FFveJJogF9ldehB1/DhlU2l0phghJa4UygyoftnH/q7c3xyNWjjz0BqnO
	0zEAUc9v6Oyf2E9z4nz7gsvuXuUYekCcT6RQjPBFzVGjxD+JH+w2omfqtiqpHbK0COOGg5j2jzd
	j8hkd3KvqcdwDsShMaamN2aFyF18Fa/UAD2cx7YiNJ/p+wya4iAD0QUiyJ+v/waszLB1XE9xn5k
	ujhkro88cMmB8sWqllbdUjzvFhPyuGMwvNEY0VG/OaBFKWk+tANlewbtoDhkXZJTwzuwGg3Nz+s
	9M/uZ1N40hOjrPEHTOvJEo6ca773qWseoC/ZbKCwkqhM8+ZcReBOU6cROVXaFG3mBId48Moh1KB
	BOkiPSu4hzEgDB9dn9DmXs9A6yaJLYiZkGPPWjMxXW2PKeMwWk/mWEgCVgb03r9/R8CHFEo1yFF
	HetaNB9QBvCSjMIpTI7zkBDRbHrgNXMS2TQXnexKLxQ/Q==
X-Received: by 2002:a17:903:1670:b0:2d9:438e:b70d with SMTP id d9443c01a7336-2db1232c88emr19260755ad.1.1788463872345;
        Thu, 03 Sep 2026 12:31:12 -0700 (PDT)
Received: from lza-virtual-machine.localdomain ([223.160.226.115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db14ae53ddsm396985ad.78.2026.09.03.12.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 12:31:12 -0700 (PDT)
From: Zhian Liang <liangzhan5dev@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Zhian Liang <liangzhan5dev@gmail.com>
Subject: [PATCH 2/2] Input: tca8418_keypad - fix race condition in interrupt handler
Date: Fri,  4 Sep 2026 03:29:42 +0800
Message-Id: <20260903192942.21906-2-liangzhan5dev@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260903192942.21906-1-liangzhan5dev@gmail.com>
References: <20260903192942.21906-1-liangzhan5dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a race condition in tca8418_irq_handler() where a new key event
can be lost if it arrives after the FIFO is drained but before the
interrupt status register is cleared.

Fix this by re-reading INT_STAT after draining the FIFO and repeating
the process if K_INT is still asserted. This ensures the FIFO is truly
empty before clearing interrupts.

The FIFO depth is 10 events, so a loop limit of 16 provides sufficient
margin while preventing infinite loops in case of hardware misbehavior.

Signed-off-by: Zhian Liang <liangzhan5dev@gmail.com>
---
 drivers/input/keyboard/tca8418_keypad.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/input/keyboard/tca8418_keypad.c b/drivers/input/keyboard/tca8418_keypad.c
index 9f0aace6bd21..0952370c0636 100644
--- a/drivers/input/keyboard/tca8418_keypad.c
+++ b/drivers/input/keyboard/tca8418_keypad.c
@@ -212,6 +212,7 @@ static irqreturn_t tca8418_irq_handler(int irq, void *dev_id)
 	struct tca8418_keypad *keypad_data = dev_id;
 	u8 reg;
 	int error;
+	int max_loops = 16;
 
 	error = tca8418_read_byte(keypad_data, REG_INT_STAT, &reg);
 	if (error) {
@@ -225,9 +226,19 @@ static irqreturn_t tca8418_irq_handler(int irq, void *dev_id)
 
 	if (reg & INT_STAT_OVR_FLOW_INT)
 		dev_warn(&keypad_data->client->dev, "overflow occurred\n");
+	do {
+		if (reg & INT_STAT_K_INT)
+			tca8418_read_keypad(keypad_data);
+
+		/* Re-read interrupt status to check for new events */
+		error = tca8418_read_byte(keypad_data, REG_INT_STAT, &reg);
+		if (error) {
+			dev_err(&keypad_data->client->dev,
+				"unable to re-read REG_INT_STAT\n");
+			return IRQ_HANDLED;
+		}
 
-	if (reg & INT_STAT_K_INT)
-		tca8418_read_keypad(keypad_data);
+	} while ((reg & INT_STAT_K_INT) && --max_loops);
 
 	/* Clear all interrupts, even IRQs we didn't check (GPI, CAD, LCK) */
 	reg = 0xff;
-- 
2.34.1

