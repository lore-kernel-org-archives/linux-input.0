Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794858929;
	b=ay3nDN8EfwnMDrG1ozbCBxkX5hKxaD024RGWwC7ZHqlG3kg51FE71onklEVMHkS06CSo
	 OqdKMZyXAp9eynNEWWSGRwP4TTqChTUwsdp7to89p5TQ5eMvrmPizXQ0wD+j2Vv4JS+pQ
	 uGRPAU3ly06CiFknv4S1XV9VWYQVwwXtccEuKdYRVSuuTImaNjWYTu+mETLwVJ9T0UJRG
	 tNdDMFmMWBWqgPWtUgR6rxIp0UtJV5nHQvyeyN39oK2WedL/HubRMLL2g7IqbQ+/A7v9i
	 CeabzT5Y/XBSMxlrOh5UkNjjFk1QSFtMs0sh37XQ4ftgwCLXDhzauS8QicgCphSQzGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794858929;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ZYix/OLdciQihq7DIwR9ubCLG7vIH820farEoUf4A/A=;
	b=oJEctFNoVbbxmq0TgFvKxyowQfqNPEp6Zlzs4mfWIGHpun5jfu356UPkelitCpDkf0gj
	 4wcR60Io6pgQszqiBjqLjRJDKuAz+Nshdy8zbuK0VOaZASXS/wQZalyYvSTUiE0wtwcbI
	 lmlYtxY9YtT0QmDu7QWGTNdL8HvP8XPjByq3F0Vfu5l3OlInY8Se8aX8GLJigKSitiB5S
	 87Wh/cMKOCuTo77yKK1auu1jJEx+gKW3t0Crab9Ottkj8USzUxuU+owhoGVys1Ryh0y6Y
	 dV1Ph3RTVUFNbvAg7WTh5R4WcZZwPFwl0yQJ6ZdtK/5s+vqPHftj8H0X0RDtGvS3lMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OePMjijy;
	arc=none smtp.remote-ip=209.85.217.51
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B2B606A31C
	for <linux-input@vger.kernel.org>; Mon, 16 Nov 2026 19:55:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99B2B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OePMjijy
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-78fb1fb9508so148917137.1
        for <linux-input@vger.kernel.org>; Mon, 16 Nov 2026 11:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794858928; x=1795463728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZYix/OLdciQihq7DIwR9ubCLG7vIH820farEoUf4A/A=;
        b=OePMjijyJ15gubJKFAW+vUGCzLIYnT4IOOfJ+548xdDhlEwkw4AY3KHK4QXTEWcAsK
         RYO4U5wH3R17WxYKwcS/KtIHQJX7lJpJhJamOl1Ezn+p+MPp5JpfizpmaaWNwoCIwA8T
         psXxdIt+xkMy4gxffbkFkPkZsM73/TyWUGeyfMykJGFogsmJyMjVQCxrZzax/g+cNMkq
         0tTpGarBb6B6DlI414Hu9iMsEFEOVhrUB8ZDjo83iX+Zvse//Mjo3gI+S2afsM0g/LUa
         HTMlZ4doMwtM6Df0LYVIQjrAZ+1benWSjGmbnGShvD5iSiAEu1N53rRRHafCDv23jE//
         G8Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794858928; x=1795463728;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZYix/OLdciQihq7DIwR9ubCLG7vIH820farEoUf4A/A=;
        b=kL3Whjx7SSjLrfyQ9LW1Rf1WpeeMzO3jFLXIGZV+OPvCV1rlB+50TwZ4e8otunKDLm
         z3SG8C2ahuf5ipW5xQBbXzCE4l71jmaJU+ks5jmJCANJN2PAa+6AL5jSTtZjqXWyRNBz
         VSIn3QDA4w+l84ub99d6HLFPAMqzmWupQF0sGK2YMGsXof1mCIiGhLs0EfIwxoxucSiW
         gZ9yRFF0aGvJSlOAHNHNhwLBfNuM+514maD8SOCKHFGsEljPmM0QKlde1ZkNe6k+OyLl
         KvgJTOuL3alO+6JPFOxwXhTecmWlLB0IDW16J0zqFJuafODwuWD2Tu9IkdYHX/IEqOgT
         u3uQ==
X-Forwarded-Encrypted: i=1; AL+hErEXdDeakjpIUCqGH5IbNYkrLMU4ZT0pDQAtOlBf4eUMtLfiRnh83FcjTGCJOVSOxaQl7mqycgHj6D7RYQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z/rb31PkLJljlo1Odkh/sF75djSDLfCfE3oi64yrM3K/iEUhvDW
	oNdmDWVkmn0fSU/HtUL6XMIpp246P6uhQB4wHiJetyXsg5JCltKrpINhWd/7aHEA
X-Gm-Gg: AYBFou1B17K02jtiegczs8hwSjD0up+EIhEB0BPv2nAe3YAeFt9mAKfXler8BSRk/g6
	HDd4ExlWxQb7AZaRPUslKS0HASr5Ti8Xsd+dCryDy3HXGyhLgIkB3pt0QDig+e2OtjL3bTDkJlS
	aKDR2YIQ9vFFJmOG3GPmXlIma+YNl2wxGvFNuGwZd2AoIUxHuIpzYyj6TvJt+Z24yFhmfLMSRn2
	/GyJyrpuzvCPdGzjdKT3Epo1mv/hmhg3WLtzYc6N4xqtca+u94nBmjf23GFSLyemBKkjIlRq4vd
	mVUVj2CFk8yX23A7NWfNiPqrxjNFCjvslHXhdkbQoyqsEYpgriOuiBVoWPW59ib1OF9Gt2Qbh6+
	F0ZcC0HtME/c09kjcrqLCIcUBKm8RI9OLd+sUg2+bMGFciwBCNQlj/l4WsYgeACEyVuLvr2JsLX
	NKQpPfm31pRlEEvVCqqN++gVIv9UcE+zMb3AM6EcueWVFeiBwzZJPOETneMKJX0+8asZk427x9W
	qkU5gLs/4ISgCJeeOvIcajmUu3pxREXhWsULtK1YNHBNci9RXnzrKp1f2kXIyCCJ/DzwLh/ymwY
	t53n8Y6oG6a+j1y1nO8viFuFhu7QM6JvrKARf6y+vA==
X-Received: by 2002:a05:6102:84c2:b0:7cb:bb7b:77e4 with SMTP id ada2fe7eead31-7d69f60aa43mr133060137.3.1794858927558;
        Mon, 16 Nov 2026 11:55:27 -0800 (PST)
Received: from budget-pc-cachyos ([37.19.211.133])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d69dfe6e71sm720482137.6.2026.11.16.11.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 11:55:27 -0800 (PST)
From: Elliott Tyson <planetlinux98@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Elliott Tyson <planetlinux98@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vicki Pfau <vi@endrift.com>,
	stable@vger.kernel.org
Subject: [PATCH] Input: xpad - scale Xbox One rumble to the 0-100 GIP range
Date: Mon, 16 Nov 2026 14:53:58 -0500
Message-ID: <20261116195500.107990-1-planetlinux98@gmail.com>
X-Mailer: git-send-email 2.56.1
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

The GIP rumble command takes actuator levels from 0 to 100, but
xpad_play_effect() converts the 16-bit FF_RUMBLE magnitudes by dividing
by 512, which yields levels up to 127.

Not all pads handle out-of-range levels. On a PowerA XBX Spectra
Enhanced Wired Controller (20d6:4002), levels 1 to 100 produce
proportional rumble, 101 produces almost none, and 110 to 127 produce
only weak rumble. Any effect above about 78% of full magnitude,
including full-strength rumble, is therefore barely noticeable on this
pad.

Scale the magnitudes to 0-100 instead. This is the range used by SDL's
HIDAPI Xbox One driver and by the xbox_gip driver currently under
review on linux-input. Intermediate magnitudes now map to
proportionally lower levels than before; for example, half magnitude
sends 50 instead of 64.

The problem was diagnosed and this patch written with the help of an AI
coding assistant (Claude). The submitter tested it on the hardware
above and reviewed the change.

Fixes: 2a6d7527b35c ("Input: xpad - update Xbox One Force Feedback Support")
Cc: stable@vger.kernel.org
Signed-off-by: Elliott Tyson <planetlinux98@gmail.com>
---

Notes:
    Testing:
    - Built as a module against 7.3.4 (Clang, W=1) with no warnings and
      loaded on that kernel. A GCC/allmodconfig build was not done.
    - Hardware: PowerA XBX Spectra Enhanced Wired Controller (20d6:4002).
      FF_RUMBLE effects were uploaded directly with EVIOCSFF. Before the
      patch, full magnitude on both motors barely rumbled and half
      magnitude felt stronger; with the patch, rumble strength increases
      with magnitude all the way to full.
    - Not tested on a Microsoft-made controller or on other architectures.
    
    Behavior change for pads that already worked: below the old maximum,
    the same magnitude now gives a level about 22% lower (half magnitude
    sends 50 instead of 64). If you would rather keep those levels,
    clamping instead (min(strong / 512, 100)) also fixes this pad. I chose
    rescaling to match SDL and xbox_gip.
    
    The pending xbox_gip series (v7, patch 2 "Input: xpad - Remove Xbox One
    support") removes this code. This fix is meant for current and stable
    kernels in the meantime; please drop it if that series lands first.
    
    AI assistance: Claude Code (Claude Opus 5.5) found the cause using
    userspace FF_RUMBLE tests, wrote the code change and the commit
    message, and built the test module. I ran the hardware tests and
    reviewed the change and the description before submitting.

 drivers/input/joystick/xpad.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index d2eb48d98fea..6cb3be9845fb 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -1606,8 +1606,9 @@ static int xpad_play_effect(struct input_dev *dev, void *data, struct ff_effect
 		packet->data[5] = GIP_MOTOR_ALL;
 		packet->data[6] = 0x00; /* left trigger */
 		packet->data[7] = 0x00; /* right trigger */
-		packet->data[8] = strong / 512;	/* left actuator */
-		packet->data[9] = weak / 512;	/* right actuator */
+		/* GIP actuator levels range from 0 to 100 */
+		packet->data[8] = strong * 100 / 0xffff;	/* left actuator */
+		packet->data[9] = weak * 100 / 0xffff;	/* right actuator */
 		packet->data[10] = 0xFF; /* on period */
 		packet->data[11] = 0x00; /* off period */
 		packet->data[12] = 0xFF; /* repeat count */

base-commit: ab13b5fc808e043a13f861a7c1c2ba8173c22b84
-- 
2.56.1

