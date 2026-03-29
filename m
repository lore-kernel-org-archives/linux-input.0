Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA16F1EFFB7
	for <linux-input@vger.kernel.org>; Sun, 29 Mar 2026 22:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774821642; cv=none; b=doSUlJ2x9UWlkX6gx+PuBlsH+JvU0m3bnRdFhObNw8MBQFIzeBDwj3XgX/MiMM//6BQSgpID+UfEnzoIbA1LJAj74YZ3+CW5yE8NAlFQf277DERs7XzZo1o0i/JWwjhoeDj0SY/4eV8Orsb2VIBZkPCm1OFmxw2v6+BKvIJpTPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774821642; c=relaxed/simple;
	bh=MepOThWcCx8p6n9tRcX735r5JGRHuPq8wJhZlb+Hgss=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cadg4NA9N5q/e89wj/fZgi2dAzjpA6ZdaDgQvAdmpuDncry4xa6IleNN6yJqcsDlJAOeMKSwvWUazFZj7KzdQwt9UKY0ZhDNMY0ZYM5kgv9gfnGoWRc7LqpidYtdDKKa3dHK+nd0DbMI6UmzY8rdmS974iysmNLya8zQo0rRHo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LLVZ0cer; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LLVZ0cer"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43b7481f9d3so2066921f8f.3
        for <linux-input@vger.kernel.org>; Sun, 29 Mar 2026 15:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774821638; x=1775426438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lAoWP3QMATTzTkQY2fSI48Nt0BXLDx5M4MIGwmSonEA=;
        b=LLVZ0cervwlu+nvIVZdwzT8ZzPaEdvwLgLFtU+yBUQmfEnngHBBCk/T+YGotJmUFXc
         OacHslMIvsA/suSZJ3ar9Qn9pojTjHkeJ40RcBHCWNE+wY9iGa4J2lpr16hOTFnjtkAP
         b3BYJqsAW7w1NR9zziIFvZRW9Yafl/5y15QyxbYgK59UcaZ66YEXRRr9XZgwcVvKVNTc
         5CBnoCeUjywUuiWTcLPfo2oDWoFSeooyFTLOtwsILTbz2rlpwIiCt9F95yGMgargtLzS
         4uGu4ZLPFGZJ/rFQs+Eg2RwM8eURr7X7BMgs2+Vx8dzdZyXBTSYOT05ElcphXn6U/E8U
         RROA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774821638; x=1775426438;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lAoWP3QMATTzTkQY2fSI48Nt0BXLDx5M4MIGwmSonEA=;
        b=QNRGljYRw7xt5dHoPS+arVrq1u1zJ+JfxGJqbVsbN/4hqSzZN/XVadVyaZhPzE9MG+
         hgkYAfln/1DrRpRXynJdskQIKdPwXKaS0FbY9vbioiZrDgUNkRt6VHXRn03kegJnN2DJ
         nGHqubmkAZRS1hK1Hqw+h3gTfic1FWgw45w2j7SFQ1WBeLk9zW8yfuwyTh2Pnk3lTwzU
         5Gx8ZO98eUmCtmo4dRCoZ1q/ATs5OZVraEH4V9Lg5BykHlmuXBkcFqwXJ+OWvDdYw/9B
         wfxQGWYlgjxVBqBkeAYZ5npDY4UG7ExFYJ08PUZ1cQTykF0J2aL7TC6o45pDnbtOfQ5G
         egjQ==
X-Gm-Message-State: AOJu0YyqLu+2TDoK7YGkI6SE8pk+8tm6+bYw1p35gkY1QyaHLLjkmTdx
	SrtjYmYN6tLFliyNkZGjjNCbjdoPbe3obH1Sz0Y4ZZ3dW1zT7Hy0Kz2skOXLc/KC
X-Gm-Gg: ATEYQzx5Tk1OmzkBNHga7FoxvZVPfdG/KTaQE259BkT6z1NiEm70zOuQwQdf0ea9xsc
	Mr6cG9WGhX/dVZo0BQkGsG7nK4tNGhHH8EPb7GwED5JghzmWIP8gpTJ2+BFmGGRKD4E08ZB7SNl
	2fKfFuCMr4GcdBTuyU/FcFgn9+WLzOuXzak37PtGRWzzu2RCpx0X3yfr5rth7L3f/8reA4h/F+q
	R0kbNsckCY9CFUUcTGOBmkPUG9ekJYKKCgHL9VHVZfIJJNpdkXsmOT1XiDp88b5+KCm2Nq8rm+S
	Ii0Bphpp6AyONTrQ1vHMrPR/BKevtnPfRkTpRDYYLnILzQ9TZA0UE6qHqQbOtQPJ5iz6Yo3Ls+K
	CXrM5/zAx/8ftHKd+ZsV8r3JAYcWJ6wytGbzJAsHQ+kJa1E/nxjIzu+ARVKIv0wZnxaa5/5fgf3
	6lzOnrrXDqKHKZieow5JO6YU424g0k+YPxmMtY8iBOauaiDCnplAp3AqA2gFazvh9Tw7rMuY+L
X-Received: by 2002:a05:6000:430e:b0:43b:436d:77f8 with SMTP id ffacd0b85a97d-43b9ea4acbemr17100005f8f.29.1774821637915;
        Sun, 29 Mar 2026 15:00:37 -0700 (PDT)
Received: from pop-os.. (234053.ds.3pp.slovanet.sk. [84.16.47.75])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf21eb95fsm15429323f8f.12.2026.03.29.15.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 15:00:37 -0700 (PDT)
From: ZlordHUN <zoliviragh@gmail.com>
X-Google-Original-From: ZlordHUN <137647604+ZlordHUN@users.noreply.github.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zoltan Illes <zoliviragh@gmail.com>
Subject: [PATCH] Input: xpad - add support for Razer Wolverine V3 Pro
Date: Mon, 30 Mar 2026 00:00:31 +0200
Message-ID: <20260329220031.1325509-1-137647604+ZlordHUN@users.noreply.github.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zoltan Illes <zoliviragh@gmail.com>

Add device IDs for the Razer Wolverine V3 Pro controller in both
wired (0x0a57) and wireless 2.4 GHz dongle (0x0a59) modes.

The controller uses the Xbox 360 protocol (vendor-specific class,
subclass 93, protocol 1) on interface 0 with an identical 20-byte
input report layout, so no additional processing is needed.

Signed-off-by: Zoltan Illes <zoliviragh@gmail.com>
---
 drivers/input/joystick/xpad.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index bf4accf3f..b09080def 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -313,6 +313,8 @@ static const struct xpad_device {
 	{ 0x1532, 0x0a00, "Razer Atrox Arcade Stick", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOXONE },
 	{ 0x1532, 0x0a03, "Razer Wildcat", 0, XTYPE_XBOXONE },
 	{ 0x1532, 0x0a29, "Razer Wolverine V2", 0, XTYPE_XBOXONE },
+	{ 0x1532, 0x0a57, "Razer Wolverine V3 Pro (Wired)", 0, XTYPE_XBOX360 },
+	{ 0x1532, 0x0a59, "Razer Wolverine V3 Pro (2.4 GHz Dongle)", 0, XTYPE_XBOX360 },
 	{ 0x15e4, 0x3f00, "Power A Mini Pro Elite", 0, XTYPE_XBOX360 },
 	{ 0x15e4, 0x3f0a, "Xbox Airflo wired controller", 0, XTYPE_XBOX360 },
 	{ 0x15e4, 0x3f10, "Batarang Xbox 360 controller", 0, XTYPE_XBOX360 },
-- 
2.43.0

