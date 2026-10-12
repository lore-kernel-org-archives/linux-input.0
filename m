Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FEA4A4821
	for <linux-input@vger.kernel.org>; Mon, 12 Oct 2026 15:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791819947; cv=none; b=f/ynb6fmWklIohVqRCEwinyTWks/c9107Ta7hp6zuEESCjYMOysvCzMblBSLHvoj1PXiHIqfmRihEQGUOOgpLpllPLFevVxD9B6SbOneux4p5YJg9tL9EXnY4X+PCVSBV4wVmWjlwkq/V79rDj+pJIWaNFRLKzsxhcled/pjnFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791819947; c=relaxed/simple;
	bh=D7sxvwTQORDG9UZDgAwID33nx8Gdqdcm0JU1TwJ2tdo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sxQiwXTMtwrrmr+G2Onkt7UgeJUgbvVp4InnNndhSF7NKr2v+0n5FvkOOHHh4trA5ZgP3AEXGVsbSS1atiuzbvFgQoCD4GUVqBdOBDEHrq7lQsrbQT2lmkdTjPNI8KCIvK2+EvfLWb1AZZjAp7LqDXiG8gYx8rIzPdV8EI0WEcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YVgRYwC9; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YVgRYwC9"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-141395927feso3630762c88.0
        for <linux-input@vger.kernel.org>; Mon, 12 Oct 2026 08:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791819945; x=1792424745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XsEajUbPO5LI3z3KVxIR8CEQ6sxYOQ2C/IR/YdstWrc=;
        b=YVgRYwC9103XLk9yRZV6b5Lb4S7tB/RgIdvD2AeQWxy8K4aapFiWm+qkWRAM9CTaA8
         9Rx89oe1m1XJvcEcPgRHYW0aswHCE13crTMc6KDzZfQb02SOCSumGF3j1WuFnWjaUqzN
         1kYnA2pdBxq7meyf77Ws3tjIEsqUSnCZZDy6RFRxnAomuf10X9fsjYcP4Yp946mOgdmD
         h4wSUacg1phET2RJm0zH9SWzh3N8jKqmAm3WaZriIRVd81TxjsEl5zBFqsKWLQyJFxuB
         I+2Iz2c/PyHotyk15s68CCnzwOul9ZWaSY9Rr6PVCgN0azl380yvtEv25TpqX039lyxt
         lVtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791819945; x=1792424745;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XsEajUbPO5LI3z3KVxIR8CEQ6sxYOQ2C/IR/YdstWrc=;
        b=vBBKuMEcMLdVQtFlFN3rnIcyR0XI6T2dY/luKDA4Bshiy/Cs/GsYdYzS4hRE090/0n
         76mhypFROXqC6kjuMjQnb/xU2e43y+DGXcMFREhfo83rJKKAeCCOo6iwl119Wjjyi3uf
         yH18M51Fpg2MpYDfF4sqOcTtO1E6dvNX0BwFplnqU9zGT9c578T6YCXEK3F/L6Kv8Oxq
         xd20Gof0SFArIheI60p+15ayQEFd/7T6yyhD5rM3D3IGCL6eO8ESVuHaQmRImuVsPtLN
         djCgNO9Ljo1nT/EC51jmF/atEo7Z2eOPUnHqbNtML4JKTrMTnm1MzYR7WvX5tqSLcGxo
         zEPg==
X-Forwarded-Encrypted: i=1; AKwUvByQS1WA+LcDh7HLaqAc3jWHTUjAK1YRzRunhE8UUx56nIHqn9T2aXADNJsFGo+2T1xkKFlgJFhnAnRlnw==@vger.kernel.org
X-Gm-Message-State: AFq9FYJ5oij0iLOgAAqQNr6zmm1W/BX73gfw2H8K3703PUd9Q1Orn9s+
	yaHoDK52GorawqBldtMsR1HZQqM8isppTJJcCEUane6ZB6X4k9w2OGCi
X-Gm-Gg: AYBFou2Z7/68kModarlnolafURSAQdm0WvOI6r31eiPymTlVtBr3L1At99Sl/2m47r0
	AVIMy4yy6KriiX4xeM0OaV/1euJ6+EfT+icKr1RMwCkY5Aj1TUZ+JK1BHO0kGRGJhfUR5SAkInB
	OW1/OslPcOzKaWhEcLZK+B+Q5AIB+VX1viUQPZf/a49btRDl1GgHI2wTQ1uXlb6KIUDu+zG7LS8
	+rUMmZfpcr2pfvMfvgRKXIg5z14b64gSrBf4VmiTDfQd/S4ighwRR84EnDWYLhAObtM+b0lSqqm
	JrZX0emEYtGTA/yKyO756U+jVI6LI8N4j9NkG/GySpaQAceLA4Z8oNhT79ceNZ2OBZtg970GYxs
	/RF9qWKbAIIYL1BMWqPQkA2MQLIsuhHmXAnthdoq0sFnmPlDKUutQly5G7HHK6itIjOPep4B9+n
	k4MoRL/HlyXc8fQlj0w4BcD41j+fyGG7Ttbjs+ImBU3QRvCMy2ZsPr5G9wxM0KsVIB17HGwGtJw
	pZeNLWCodScTp8Tx22fs4xnE7brk16/PIjs+FQA4KkJ1y499MBl2K66dba9Nqzyj0SEXWUE
X-Received: by 2002:a05:7022:3a86:b0:151:2e62:fe8a with SMTP id a92af1059eb24-16a611bf1dbmr14334378c88.40.1791819944866;
        Mon, 12 Oct 2026 08:45:44 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:301c:f8cd:c1bb:8d21:6c07:8107])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a6021e49sm31316736c88.20.2026.10.12.08.45.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 12 Oct 2026 08:45:44 -0700 (PDT)
From: Aryan Sinha <sinha.aryan03@gmail.com>
To: "Derek J . Clark" <derekjohn.clark@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aryan Sinha <sinha.aryan03@gmail.com>
Subject: [PATCH] HID: hid-msi: Use str_true_false() helper
Date: Mon, 12 Oct 2026 21:15:32 +0530
Message-ID: <20261012154537.42113-1-sinha.aryan03@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the open coded ternary in enabled_show() with the helper from
string_choices.h. Gives Same output, but with one less conditional.

Signed-off-by: Aryan Sinha <sinha.aryan03@gmail.com>
---
 drivers/hid/hid-msi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-msi.c b/drivers/hid/hid-msi.c
index 3225d3bf6..4822b5d6d 100644
--- a/drivers/hid/hid-msi.c
+++ b/drivers/hid/hid-msi.c
@@ -28,6 +28,7 @@
 #include <linux/mutex.h>
 #include <linux/pm.h>
 #include <linux/spinlock.h>
+#include <linux/string_choices.h>
 #include <linux/sysfs.h>
 #include <linux/types.h>
 #include <linux/unaligned.h>
@@ -1586,7 +1587,7 @@ static ssize_t enabled_show(struct device *dev,
 			return -ENODEV;
 	}
 
-	return sysfs_emit(buf, "%s\n", drvdata->rgb_enabled ? "true" : "false");
+	return sysfs_emit(buf, "%s\n", str_true_false(drvdata->rgb_enabled));
 }
 static DEVICE_ATTR_RW(enabled);
 
-- 
2.46.0

