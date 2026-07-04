Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C182F38BF81
	for <linux-input@vger.kernel.org>; Sat,  4 Jul 2026 05:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783144658; cv=none; b=B3R8/ur5WzD6pNXzwZLw6y9I1i16A/hJTLuT7cq0mwrtS2ycMveyMLZFEpqqxpSG3u9rQQuRDnp7uYU14df/ZfHbCSK5Mpscc51h8IJ5hiifqFdt7XYz10GUDTBEkgQyv/r3CSixnY+1vQWZ+yJYqThhHHFUzL+fcApE8Z+CfxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783144658; c=relaxed/simple;
	bh=ySw9qD/kY9kF4/jT9eMYAumbFCGcpBh/qogTEfFjPmQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AsfcNQP8w+ZwSj/8MDxchl8F8F2VwD53u9DxtCCsudyhtFtIhr62lZFAqJAIxXt1QQzAUBILAFCEAl8KSy0r1/MBT2agUit2YyeZ7gGAlfXFf9uhBU8WyOYqlEz9Io47ndFkUyxv/o8Q+jpgK3pr6ajoeSZdXJ9/hEHtITioJh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fClvmVCG; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fClvmVCG"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2cc61541f8cso2654855ad.0
        for <linux-input@vger.kernel.org>; Fri, 03 Jul 2026 22:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783144656; x=1783749456; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VSErm6zpSptbzDDa+NTYvT0p4kk13g2ope/8ugzuH+A=;
        b=fClvmVCGQU6cZCHPG93eVuV2OZidqd397kJemid1/SPC6rUqMAeh49lNhkw2MqgsYE
         /GgZhU/sbo6m5hjCx+aUWqy3mQq5v89qEPVOMU6ixFowPYMY3t8DZ1y7QEGlPH6FqAn5
         BGIPpm0jSlKBd6EOE1/lxL+9Q2rfkoN1jFRAMh5PUGaL4DCGmNx7iOvC6HKkIDYGCGzv
         lI5zCzpwOCnTcnSt7mRe2K/PkvcuNIX7YappA5z+YhXvxoKOGcepf3ODTDt3Dpb/Wi3e
         kb3+UTZRKv7WHKqfixW7JRGG5Mg2E/B/yU/vnIJo3OwTkR6ihtwe6dP9qMx5HnYYwDR6
         m35g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783144656; x=1783749456;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VSErm6zpSptbzDDa+NTYvT0p4kk13g2ope/8ugzuH+A=;
        b=KXuZgkNsmG0jXReZGUlBIxRgp/0tnc7jipSjSi+S2i6mwKsn/iW4qYqyCHD+6t8tNq
         tvAT3wIt97+RXsf6cMTw8dNl5xOgVNki6h6ln96pddIQhFjPjbpuNyMgQxFOIQr5IqFt
         /ZEmcx37lgUujngpNOKZJ31SRsQ56tjS3Mv6iSOznFDKlaQ7Kfo/tkprMzhl+qngmWZr
         FMi04ynZ3A/bgvz1X/0qvHo9lrefMH0kD9cgUPLY//sm5n08M0dvbc2D8F/2LQBD14rU
         vnXOJrPWCLxuWZEHNMxOyeJxW8xg1HOcVWdbcC3/hwQKwNE94NA0GNVJLPtFI7ZOs5Ys
         tN/Q==
X-Forwarded-Encrypted: i=1; AFNElJ84H2h0PNHo4D4/ifac1zdo3zjdXwqzrMpln1nQGc3Br5PZ/bWme51D53rdxuZJJC5SsqMgauZU8mikZg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9vKmn9rwzg0qmP5FUy0iq38kW8yW087wFqJl9ocwSKVqVbS6E
	BxmbpSQdaUh9hY4eZFzV80wWwdY4zhTABd1gFP6nf0s/x0IYxegVCnEX
X-Gm-Gg: AfdE7cmpWld914MtRagZnRFQjSy3bif3UOdx0di6iynOMHYP8AwKby3JxLiOz6pCWSe
	72PjDF+Fm3/wwaQpoY7g6KGcrv0lklm+dcdilYVc+jxtWk49FoYPeCz9WkE3Jj2v2MzNRuvLcyz
	25QhJIzOA/qtpYi05DpYaHNGc8SlVOaMcTnumjbwXuAAtbtDJdO+pMgIlBsJn1RguaP518swUbk
	bl9skTS/NC8M/lV8xiAZR8uCHP5Hx8CZ5KjPFO2eRsVLBTK3cmk/k7hwsdd9bfChsvAJrTxrxZh
	zx/KlI9P0zEfYqZAIeEbLiPTi6C55HEHiwQXrzD1RsqD1XGv+YdR7x/em+YWvJKbx8O14mn+V41
	Fa0xjwJ90jVG0Yoq2pXWOzjtsG9n3Xu5HaA74msj93Z6KAQGuf0AKdb7Qx4olnmi8QoVGSeHyvE
	Uongpjz1xgknydDQ5BI1oOiJTlRw3ALllUv7cK9jMZlUj9dtPI93sZXsGWgOdj0e3v02+yFCRbf
	KM=
X-Received: by 2002:a05:6a21:3a85:b0:3b4:7459:85a0 with SMTP id adf61e73a8af0-3c01caacc85mr7518057637.18.1783144655975;
        Fri, 03 Jul 2026 22:57:35 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:880:86f9:3b00:6746])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0b813cd9sm26262412eec.8.2026.07.03.22.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 22:57:35 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 03 Jul 2026 22:57:25 -0700
Subject: [PATCH 02/26] Input: maple_keyb - fix key press detection
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-b4-maple-cleanup-v1-2-41e424964da5@gmail.com>
References: <20260703-b4-maple-cleanup-v1-0-41e424964da5@gmail.com>
In-Reply-To: <20260703-b4-maple-cleanup-v1-0-41e424964da5@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Florian Fuchs <fuchsfl@gmail.com>, 
 Adrian McMenamin <adrianmcmenamin@gmail.com>, linux-kernel@vger.kernel.org, 
 Dmitry Torokhov <dtor@mail.ru>, linux-input@vger.kernel.org, 
 linux-mtd@lists.infradead.org, linux-sh@vger.kernel.org
X-Mailer: b4 0.16-dev-6911d

The key press detection logic was using ptr instead of !ptr (where ptr is
the result of memchr searching for the new key in the old keys).

If ptr is not NULL, it means the key was already pressed in the previous
report, so it is not a new press. If ptr is NULL, it means the key was
not pressed before, so it is a new press.

Using ptr instead of !ptr caused new presses to be ignored in the first
poll cycle (only reported in the second cycle if still held, because
then it was in 'old'), and caused redundant press events to be sent
on every subsequent poll while the key was held.

Fix this by using !ptr for press detection, matching the release
detection logic.

Fixes: b11d2127c489 ("Input: add support for SEGA Dreamcast keyboard")
Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/keyboard/maple_keyb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/maple_keyb.c b/drivers/input/keyboard/maple_keyb.c
index 3d5538dd4f23..623d7951405b 100644
--- a/drivers/input/keyboard/maple_keyb.c
+++ b/drivers/input/keyboard/maple_keyb.c
@@ -107,7 +107,7 @@ static void dc_scan_kbd(struct dc_kbd *kbd)
 		}
 		ptr = memchr(kbd->old + 2, kbd->new[i], 6);
 		code = kbd->new[i];
-		if (code > 3 && ptr) {
+		if (code > 3 && !ptr) {
 			keycode = kbd->keycode[code];
 			if (keycode) {
 				input_event(dev, EV_MSC, MSC_SCAN, code);

-- 
2.55.0.rc0.799.gd6f94ed593-goog

