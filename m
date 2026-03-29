Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9752E38F9C
	for <linux-input@vger.kernel.org>; Sun, 29 Mar 2026 05:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774761746; cv=none; b=b7AGh4IdTSuNmObKYhDFf/y2SKnHCCaOfQN9gWRBEz8xetO8go0dut1tzuwt0WD/FvdV8sONMGfn9vTqrcvz5IjkcvaIey+UIyWwQ53Q0FXm4Xrv+xQ6kd1QfGaTvyk+C/87GndKJQssWwhQRNNMD71/PlKLXcs72ZbwMd13PjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774761746; c=relaxed/simple;
	bh=8xktqLupwesLLk5j6LMPoL7atD5VVcCofr7jC4TztLA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CRSxzbT8FuDJrJFCz4Vg6FG82r0cRP/xtn8CUzYLmIXOZZgWlgdcMSXoo5x3QeoqT81tPMh8wIEUtH0d4oakyNoGRSIB3JPxJZpHW0CRcVsB20V6kpO7xfrqaG9ELrU3YP/lbIBsuIrTQFRYTq3aJZkEeXjolF+UBHUfat4NHDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q3pqL5Ld; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q3pqL5Ld"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-66b8110361fso1667803a12.0
        for <linux-input@vger.kernel.org>; Sat, 28 Mar 2026 22:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774761743; x=1775366543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5aFPBhn/0xn2CAd+wjINTN9itRCh2xsGw771VpqkaWk=;
        b=q3pqL5LdVnIAjPhnnMbfSasKMIDykBPYXZ11d/HJzmzMI9LTlwcFoVUrxoYBjyZLOS
         aNyOSP1eGJbpZrhO0m3+7OE/v337NIMzQKkdSd4mYHh7w0qMAjEBeNhbaQJufwYADJ2C
         fxce9I+f7zOyeADHt6rWAO5Jxo6RiXSFb6zn10OViv3x69sCvjV+xU3sk2j5sva2XbZf
         pJn7h7zHiV1mFsbd6KTVdsiA4gK5s7dr+0nG3KyK+SRVbCVTiQkYOyiTiPmO2vT9dEvb
         5cDsvhw2fRe21zxq0P7FYmG2XKsNoLrQTaSXzyeW1jGjR9MYxIVaYDE1Pu2LdZKHd/Yx
         Zn1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774761743; x=1775366543;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5aFPBhn/0xn2CAd+wjINTN9itRCh2xsGw771VpqkaWk=;
        b=m/2FEua6QXtlfmU2rlON82+y1c3nueboraYvQsiYpzICeb5CtHeOa4rtmpqhj4ghzE
         /gEYXpzHWoFYQSSJYfe5yeUmA0V6waCC66nlrtaQmi4rTtvXwIejfEdzxaKAN7Z6cSZu
         Yw+hRaUOU4C7xRPwdpbSwnsyB6saKQTDOuSz+EdmOfvYQK/CD0T0C4LSTD6w5mjiH/Gc
         u1wkNHmEXqmmJjSCCpL1Q8rHQqv+JJj0x7wHF11Y6gpM/b1H57Vryo72VVrpxxVNU1id
         OJ5ROLDd2nzHRN8GuV3dH3on9/d5BG3dh2nhE6JaxZQ0L28/8QxoarpbAS59GHYiDyrh
         NkZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOuE4SN9rg2hDxU2vwaGL5bV7fQu1TLi5s+rBauDFp/nT5cRil/RUzzBRuUnauFDtc2lTU3fX6xnMWCg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyKjFy4aAh6Iz+5S1i8Rdw5ZHm6usDqOnjiRzB1rCMs7DwHqtV7
	4sXcEPl67WUzf1frr07Qwn0c0AymvthPfPiebDObGH5/qz9CuqGQe9tq
X-Gm-Gg: ATEYQzxw6Bg6PhD4r2wLRH2US53h/Y7hFShbDk38JuypsFLvtAY4SEhTGwwACH1BLMA
	MTm1oBVAu0yJiCCY4jKGb+jXGzEGtpQuumRNmg/GlNOUWhT/Ophg6dzfsofSDAYO9zSwG93oykP
	UtoBSav+PhMEXRH1xpz/daiFosz1pLIfrxoIKt+nPEtyRbvScpkqkNVsbr84fhK7NrnG1rXybfq
	vokBM36R04byABi9ghvVMwNn8br7olAhHAvVCChO0aleSTesOj2WD6JUIYfqni6rcjCaHk0dvcX
	pL9Xo3PyNZBQsw2Qi5D5RLUojR66Gh4Xgrsdga7Qpf5HFuXoyL7CXUPuBdSok9E+9IQh4D2lNKH
	+39cMmEjR9T3bJYcSuZpqPw26DHu5Vr+MyPUHYC1vhYV+qT1Ccfz1uDxRhQEthNV4y8EJBfftTP
	ZwzY+1ZChmY1SowfLTWmBBP8Ul+aLYZxiaR/s=
X-Received: by 2002:a17:907:2d8d:b0:b9b:207c:f7df with SMTP id a640c23a62f3a-b9b507a92c1mr492394366b.29.1774761742650;
        Sat, 28 Mar 2026 22:22:22 -0700 (PDT)
Received: from arch.localdomain ([94.131.105.125])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9b7ae527d6sm150348566b.19.2026.03.28.22.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 22:22:21 -0700 (PDT)
From: Jun Yan <jerrysteve1101@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com,
	Jun Yan <jerrysteve1101@gmail.com>
Subject: [PATCH] Input: cap11xx - remove duplicate dev_info print
Date: Sun, 29 Mar 2026 13:22:11 +0800
Message-ID: <20260329052211.202804-1-jerrysteve1101@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the duplicated CAP11XX device detection log print
to avoid redundant kernel messages.

Signed-off-by: Jun Yan <jerrysteve1101@gmail.com>
---
 drivers/input/keyboard/cap11xx.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/input/keyboard/cap11xx.c b/drivers/input/keyboard/cap11xx.c
index 0c17cbaa3d27..9c94ea047d64 100644
--- a/drivers/input/keyboard/cap11xx.c
+++ b/drivers/input/keyboard/cap11xx.c
@@ -534,9 +534,6 @@ static int cap11xx_i2c_probe(struct i2c_client *i2c_client)
 	if (error < 0)
 		return error;
 
-	dev_info(dev, "CAP11XX detected, model %s, revision 0x%02x\n",
-			 id->name, rev);
-
 	priv->model = cap;
 
 	dev_info(dev, "CAP11XX device detected, model %s, revision 0x%02x\n",
-- 
2.53.0

