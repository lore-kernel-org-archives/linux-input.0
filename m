Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794254331;
	b=Gk2yKn7WsQqlXeeWzcF7o3vt37JrKypnG0/witV8tAK3Rw+k1Szg+wQMC9hBmjgpKaeR
	 8LkrMBcwAv1Hd0l6/GDxWcBFd1K08iykDETEfa/ApFn25p8qE67OjpVuCgIxH7PBf+cvI
	 llKgBysi7BtElzzUc0slaYznjACS06XR9q5axcON7Glw8oC8x05LLM0QWi8jRFtWWYhvS
	 cmWfZ1Z3+bwmiRPdrcxTok77I36BP129s+SuIWRptPYXNqIgOhRHSf/bK9k3Q0bs0mOab
	 wSsnVBh3XDkmma7Qrzi1mFZZQtL4dQDiXhB38EH8O8AVJ3vURnH1nnPi2InZ3AtrImw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794254331;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=+iyECRctbczd6ccDWJllCZGndv7fKJ3cecECSIHK5nQ=;
	b=3y4Hr1sBTGTngHdRl6hXanUI+JKPYCH8zvsUpBoHSpqmy0qGbgyUIrgfu1PdqP2PyVkR
	 mP6aBQN5okZkmm5+vS9CLFCbwnuEBHFLdCtP6elIF96aSd4gPNKkSgthLIY5UoUiLsZAC
	 fPzsFlfGV6A52aRHiwQDuOtiqDkh0wGfEkjzSNfbMB+wcNLuoKvlbQOLb35W23SWS+n8x
	 nOtOAjz4B/t2QU2pvLDLWJ9CZYtE5v7KpyIrz1Hfj0vyc2VIhAnDof/32pEsAaxgHLZaM
	 dpOhsFCvvg3gpo5nBICPPCnUMqcJOID5A0b1AP2bUWE1P3jprJ8ZtG+nDYdmOxKKhBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rhuECTCS;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177AB606A321
	for <linux-input@vger.kernel.org>; Mon,  9 Nov 2026 19:58:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 177AB606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rhuECTCS
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-49412eb1474so854089f8f.3
        for <linux-input@vger.kernel.org>; Mon, 09 Nov 2026 11:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794254329; x=1794859129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+iyECRctbczd6ccDWJllCZGndv7fKJ3cecECSIHK5nQ=;
        b=rhuECTCS+bB7jG5zMkDBKC3MkZBACtJzGiFa7SSQBo3XYJskt67wesPfkWb8QH84ks
         1ovje8H8Kmkbq4L7Bo+0ZAEte8FfWZ6k50HfP1O4/OswdGat8FTzLjC2Tyjpod2+4ZBJ
         X/aA2b3i6QjjVkn/5EpEjF3OuZnqJuGAf6FMgkJ8LW0bVsnSr884JmMSEmaQ8YgNsK06
         PLrJcm/YpFoqlzOojPWf8Ji985FqUhmMsVegjSjimCN2G1RLrbz1VV/Lka1FHefy03XI
         st7BVSat+7FYl+M+9FdoKMOLmijQy/WYukgfNpkBdcSnr88ir6nzK2qBfM2wuuILtiaS
         HtpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794254329; x=1794859129;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+iyECRctbczd6ccDWJllCZGndv7fKJ3cecECSIHK5nQ=;
        b=CJEXZ4SInd9L8qBze1Q2s61g220nim1l6vch35Isrc9hMG3w+U+v2+sIeYGvIxTwYF
         qjafB/BZDfMySm9Ocb6w9S3nQjmnfFPQ3jD+lqFa6ExAtjhRx28ItY07pHnO+zskpPxi
         lLkvISfrDj5AgnK8SJJLw0qIkNXLANwsyFTXocrhftA/iMcL1Cr4uS9clvWLztI5kMKb
         5YPFYYLEnLh22POZJOXJYW0JtHgSbKU4hNmeQUD8o6D3uPq1lKsYWPprevVeMaf9xbG2
         jgzaJAaDFncQdhR8SnrbYA4xrTN0zSz+HZXv8MXpNLZweYCk1sJWCKOsAChsqrpU4PvU
         erzQ==
X-Forwarded-Encrypted: i=1; AL+hErECm1yIwbnyTSxEc1pGvYgeM3XX7ghH6z8A5TtgXCJUKF2lnz+wwp8tKp7ZOvoIbDYDjKeHdrfKZNB4rg==@vger.kernel.org
X-Gm-Message-State: APuU4Z9NYpHvUcEMx1yqtFokoY6iYrYecrg2dUSmulHssysEhUnvfl08
	EoDpq4KMNqKa4K+/gUqOhKkybYebrOu9oRWLHhI5wpXCbny8jSmSsyqB
X-Gm-Gg: AYBFou2rl//QsKIjL8wL1UNYzksd9SqgsltFiHBKOhYN5xSSFzsl1+9SRjrk7rObP8Q
	VpSiRO+BCTHf+YV+ngXa1b5JCVcRn/u2ZRIBFqTLXqpQAvxaHPxGIL+JlB1j/gmrKSkjFW/ynAB
	jNuR9WGTshKQfd/Znf4BJru5ax8cdGxu0fl8Pn85UxDKhh9Vqr80SMxo/lxdG655/17Dwu6lHWd
	dEE6QffLfRCnZnxlXS2jxF0bfbUzJbuVp/HnS0bvoFajsRF/YvqaitbagD4DD80VDA6yQVZcera
	ZVgCYu3wgX5y7+ZSFX52TvP2uRRi34k7R8KHtnP762J6htQF8jMHuVWV+SsxZhOT3nsLYjeQA2C
	7cirvlmbWlxJ2Ul0aPggDtTX/4MbL8ez7jiEzPx4TrrWJW/TqSKolsHFBrLMfBn7PH7XzFuTFc/
	a2GaR2i/IOYqkLUI3E4SXS+ME1zbj18StJ0cfstZ9is06pLnsU6OuZq3jg1K5km1TpH1nWU95TP
	x0NI9hLHWGQYBuem2VDfLaQPmikPGy8vIgpfDvQaDx/jqHbFWh6+lgZiXfOfRc7ivo83f5que8T
	teMA7MonasrTEfttE8GLF26XqHzHrLqgH00mHekYYUSqMwaJteAFt3EMB7P0YB5IAeOSU/yxCA=
	=
X-Received: by 2002:a05:6000:24c6:b0:490:411a:1eed with SMTP id ffacd0b85a97d-4983105fa73mr947073f8f.39.1794254329550;
        Mon, 09 Nov 2026 11:58:49 -0800 (PST)
Received: from acer-gaming (121.red-88-28-14.dynamicip.rima-tde.net. [88.28.14.121])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-498369a3f4esm792446f8f.53.2026.11.09.11.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 11:58:49 -0800 (PST)
From: Juan Parrado <jparrado.1817@gmail.com>
X-Google-Original-From: Juan Parrado <jparrado1817@gmail.com>
To: sashiko-bot@kernel.org
Cc: dmitry.torokhov@gmail.com,
	jparrado.1817@gmail.com,
	linux-input@vger.kernel.org,
	sashiko-reviews@lists.linux.dev,
	Juan Parrado <jparrado1817@gmail.com>
Subject: [PATCH v3] [PATCH v3] xpad.c - Add support to Hori Real Arcade Pro 4
Date: Mon,  9 Nov 2026 20:58:30 +0100
Message-ID: <20261109195830.22156-1-jparrado1817@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <sashiko-outbox-204846@kernel.org>
References: <sashiko-outbox-204846@kernel.org>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The HORI Real Arcade Pro 4 in PC mode is currently recognized by xpad.c as
a 'Generic X-Box pad' and works out of the box. However, this generic name
does not match the actual device name, making it difficult for users to
distinguish this controller when multiple devices are connected.

Tested on physical hardware. The proposed change works perfectly as is.
The MAP_TRIGGERS_TO_BUTTONS parameter does not work here. Other arcade
sticks use an identical configuration, such as the 'Street Fighter IV
FightPad' and the 'Hori Real Arcade Pro.EX Premium VLX'.

Signed-off-by: Juan Parrado <jparrado.1817@gmail.com>
---
v3:
 - Updated commit subject and description details.
 - Fixed metadata and updated patch version history.
 - Corrected device name in code.
v2:
 - Fixed truncated code lines in xpad.c.
 
 drivers/input/joystick/xpad.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 810e52782..2567ea3bd 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -255,6 +255,7 @@ static const struct xpad_device {
 	{ 0x0f0d, 0x0063, "Hori Real Arcade Pro Hayabusa (USA) Xbox One", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOXONE },
 	{ 0x0f0d, 0x0067, "HORIPAD ONE", 0, XTYPE_XBOXONE },
 	{ 0x0f0d, 0x0078, "Hori Real Arcade Pro V Kai Xbox One", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOXONE },
+	{ 0x0f0d, 0x008c, "Hori Real Arcade Pro 4", 0, XTYPE_XBOX360 },
 	{ 0x0f0d, 0x00c5, "Hori Fighting Commander ONE", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOXONE },
 	{ 0x0f0d, 0x00dc, "HORIPAD FPS for Nintendo Switch", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOX360 },
 	{ 0x0f0d, 0x0151, "Hori Racing Wheel Overdrive for Xbox Series X", 0, XTYPE_XBOXONE },
-- 
2.56.0

