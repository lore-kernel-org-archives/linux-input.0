Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B440F351C2A
	for <linux-input@vger.kernel.org>; Fri, 29 May 2026 01:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780018782; cv=none; b=C3QWNNBkDXJoxOFixI4OOx7qLEbS+v8KE5tfpunkcIqSiH+5Q10HJBA6iAhLs+vao+p+ejH/QdIDAXvP8fVGovKV0OE9LXWV4qX5YPEeu/3zCqlVGM7X+c96aDtqoaOouf0Z7aC18uEk1Gm0fcJrt/RSeTb1X9EHYjUrz7PLDB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780018782; c=relaxed/simple;
	bh=R+b0dMhfdCvXX7tTYJwUEr5LPeqp/sASGbu3bzIUePE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eUpAWV7JuBcLSp7Slz72NhBHwxRxWFjir9N0obwNxgTv1Jb6MuB4YTfwYxiQ2pRlaw3r6xzH1KSjf694LmoLXavJozhCR1F0QVKB5It5QiJnk8GpV7UnVXyVvY4kaSMrICRI9nqorlNejU0dq72Z+b4rKPrM/zWAch0C0o4VcIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pJcoYQ5q; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pJcoYQ5q"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ba856db1c0so97477975ad.3
        for <linux-input@vger.kernel.org>; Thu, 28 May 2026 18:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780018779; x=1780623579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9YrQLWRT7P2B9ehvuGmHa/4OwVk6y3qDhXkQzP89SaE=;
        b=pJcoYQ5qtLVEvR/ixH93dqH8N3M/GTcUT/kvHVdzP7+YXGAvuaKptS5HoHhCy6VAND
         gVEG/9uNdQSWYLsOSVEhhdLM0MA9NdHtQx5eK5nnqg9DxCT6V5NVRqx5Rh6TRLY5nmVI
         73etQROo6KN2I2koDznmggM+VnrJcq5Vhny17rWW3tVvL8XvGEyYC4O5fYHFlzyL4pcw
         P9zJ2BdVoggvp/aiLs2CCcLxgFBo9QIG8dndvumSboSF9apadW1JP+5On9oujpgHY/eI
         zCvWGoZVZAO9/WS0/K0zpajvbR1xekZp6qXpce/78yDEs2KP2ODakZ7pWtWb2RejU6RL
         iQBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780018779; x=1780623579;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9YrQLWRT7P2B9ehvuGmHa/4OwVk6y3qDhXkQzP89SaE=;
        b=sr/UqZGP//6SmwbU5GQkpj2i3yLc+ZDorubdQywqjZKPue/2N9bbEBz62nPtPxvm7Y
         4nh5vIKQE+fU83JBzW/0gDToBiHh4cwcikiUJBLA2Va/ptQ6gMlw/BzVkD7FqI+6zIou
         vpQ7szOmeGzwjl8xMW8k0C8zUWQk7ApOIUmVGu+WoBr/wi3fHrvvKKZeEJEXlOW5VHKq
         HgLLRiI6Z3SiEdQvF9xacR6U8h1sLNtctTgLO4eIurB6jZ2JtLZnufqFk8zncoUIirfw
         BFJflDuRsKVNYKUA6igPnV0XNNIpWVuYC43L50XrxNKsci+Ps7sHYSy9PYkjxRbkmJjX
         QKLw==
X-Gm-Message-State: AOJu0Yz9ZKRURUMf8ChF/LaVwKmWWJPOkjC8Jxajcz7N30ojw1vnlNYh
	u8twQBu7z2nQXly75xL2l3sI+KZ0A5IadTn2ZYKCki2AA7qscjruLzdd
X-Gm-Gg: Acq92OHsMkzXTcopuFPRM36Qp9BUi1PVycB68pFgGn9B+uJyLj8tNj/eA8UC++qUzup
	EWSuRMdFGAoi6WxF9ccK5KHErxmH/ed/vgaZlUQ9y2GLzEyXNDx3ku09JIUpWiUQLwE7H0gNAR4
	v5UDFC/iXHYomzCSvwFDko1trIZTvnFOwHT3OVU0EUqO56xfN45xjhnd5Xj1I5GSkpH5dleA7jV
	iDsp42t2QJ2AAYkbAKpSfFejbNV1Q20ZCFysNFul63KayyPvFUOqVItzu2uOsggF/r2et17vILQ
	dR70hyIUi1lnC2AyDSIINw8LuHjrOCwfQCKiMTwZf2T/IJhNepFeOGy/YaTT+qpv/pEH2cvk7j3
	liQikvzOxuMR7c4ZheJRi21Lb8jUszObAIjn+DRFaql5/ZOk7WRBNKqKNCl4nB+84gyATa16jH4
	ZDZfYGvRYqK47C7j1GdV99vLFs01rN8lZTJCMx6bmM6yvgDKqfqk8Q7sqYyzOEDhG4lqCLfjw0V
	7ZDaXfv
X-Received: by 2002:a17:903:2283:b0:2bd:8dbb:293e with SMTP id d9443c01a7336-2bf206324f5mr10817595ad.14.1780018778908;
        Thu, 28 May 2026 18:39:38 -0700 (PDT)
Received: from lza-virtual-machine.localdomain ([120.236.174.211])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf239e7019sm721585ad.11.2026.05.28.18.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 18:39:38 -0700 (PDT)
From: Zhian Liang <liangzhan5dev@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Zhian Liang <liangzhan5dev@gmail.com>
Subject: [PATCH] Input: tca8418_keypad - enable overflow mode per datasheet (SCPS215G)
Date: Fri, 29 May 2026 09:39:00 +0800
Message-Id: <20260529013900.43854-1-liangzhan5dev@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver currently sets only the overflow interrupt enable bit
(OVR_FLOW_IEN) in the configuration register, leaving the overflow
mode bit (OVR_FLOW_M) at its default value of 0.

According to the TCA8418 datasheet (SCPS215G, Section 8.6.4.1
"Overflow Errata - Description"), both OVR_FLOW_M (Bit_5) and
OVR_FLOW_IEN (Bit_3) must be set high for the overflow interrupt
to be generated. If only OVR_FLOW_IEN is set, FIFO overflow events
are silently lost without notifying the host.

Fix this by setting OVR_FLOW_M alongside OVR_FLOW_IEN in the
configuration register.

Note: I do not have access to hardware to test this change.
Testing by generating 11+ key events without reading the FIFO
would be appreciated. Full handling of overflow events in the
interrupt handler is left for future improvement.

Signed-off-by: Zhian Liang <liangzhan5dev@gmail.com>
---
 drivers/input/keyboard/tca8418_keypad.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/tca8418_keypad.c b/drivers/input/keyboard/tca8418_keypad.c
index 68c0afafee7b..b124e576feca 100644
--- a/drivers/input/keyboard/tca8418_keypad.c
+++ b/drivers/input/keyboard/tca8418_keypad.c
@@ -254,7 +254,7 @@ static int tca8418_configure(struct tca8418_keypad *keypad_data,
 		return error;
 
 	error = tca8418_write_byte(keypad_data, REG_CFG,
-				CFG_INT_CFG | CFG_OVR_FLOW_IEN | CFG_KE_IEN);
+				CFG_INT_CFG | CFG_OVR_FLOW_IEN | CFG_OVR_FLOW_M | CFG_KE_IEN);
 
 	return error;
 }
-- 
2.34.1

