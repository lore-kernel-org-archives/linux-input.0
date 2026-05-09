Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A1033A70E
	for <linux-input@vger.kernel.org>; Sat,  9 May 2026 02:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778294483; cv=none; b=uco8j0qa1DnrLGtTbIhvUZAaA7228ZbkAxkDlkSdRE+HDR6MaLJGQQdpviHrqPN2bYCZUSShS8Sg7/PNBi1wfrxhn/C4Y6SCDhNyHs9j6Pp0WZEbOJDcjXa9IpohjmaIzH5NLMn2D3X+FCtziZ7JoJ68RQkkl918xaZiGTu5VwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778294483; c=relaxed/simple;
	bh=DHJVPLU+Df97l7KRCQLbL3vW/Qr4GYO94betjeY9UNA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V0NYWsxb7pFkPMBBBeZ8BOUPpKMINUTJWXb6fbpTauWxiLK66WcPvKjSr83pT7jMWDLuK46UwbDNneVGb5EfRRVk9z2nP2xAvUNnDHNBPLhrm9wseUguubzWacdA5D7DejNhtuXmNqM2nKoeXerA613vVOrjcZIs6WbNzXBSxRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZPy8fI1X; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZPy8fI1X"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7de4ed0593fso1366653a34.1
        for <linux-input@vger.kernel.org>; Fri, 08 May 2026 19:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778294480; x=1778899280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pKs3dD3OUU41UF/yUteowq5619hsqPe2p4DfPDuMepY=;
        b=ZPy8fI1XjCRA9SMUbt8iqJM4/W2M21JWnC0YGt+d3eBdh3vC2VZ8Zw7ZTMOp3EbIan
         dYdK+nxRsvxZIq69J1/7LGxUwUW14D+xi48fuNjAjep7vAdE66W5ViFkY0Jocsi0I8LQ
         IxVIrsHbl042/9d1fRcBK8SrwvOXnK2AEPTavzOXWtPfdf5z8k6KD8lmP60EqA7A80+6
         7/0XR7LObha6P5X6JbkpJBJemHuLCAOZUTiJq9lTB7jDQBmL6qxUKBblnrDqyK9qNY2G
         iui4ZhcegmMw+MCuQl1mhbTZd5rS036kr516kIw5KoQgRGqXSliP8kf/O0hwztOM0RLe
         7sCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778294480; x=1778899280;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pKs3dD3OUU41UF/yUteowq5619hsqPe2p4DfPDuMepY=;
        b=Pgr++ZN3Nx3zABBLegdcQAJB/xM7rVjfVt8jld4r2PXOJA2IHVlx6jIyjDMz0kSfjM
         67RpF8vyePaBl1ytOK5XmNvo20JnL1Gghlue/P88hj3bSledD7zXGQKUiCg6Sz/5odnT
         3C5hjJxwWIc8msKaKlC0vYQW1nseTPIbUJRZZozJYq1yw/kvIKWX4d8oRs/B+4dtxu9I
         W0sapnC7aIv1jhn5CZX7UUnz7wEtd7yia7Ui1XwR669zFxIjnMcUn8JW13h4cbjkDJJT
         5eKOJGuIECe8jjDPx6PylicdwfXjbQQGi3LCYw/HMcvou4GidIVeas+Qv/BMDPJKFQQ7
         1Tqw==
X-Gm-Message-State: AOJu0YxgnKwvEW95IVnJqFwGXmE0pl4jssgC0RlMofEl9Jgj5MfUqXNw
	HybR/VYysSwjxjAWzoCUAhhzXSt4bntC+88UgJjO4euD0kQ2qPwz6D2H
X-Gm-Gg: AeBDievkA+ayrat6yLby3H3r+Yuih2785R9sBvYKKZeoXyC8KyLMDJytVCqgFnJyYQg
	ieaIskorm0EPlpbIG6Cirwso80nXdIo8OG4gbp5M41uIL2ICgRUSp6l8gHmAONF4Qi4Rx74yzR9
	Iiie8dQtk17T3JS1nqvzfbGZ6PPdPS4fL+2/LJISy6KKkj4T5UmMV5HKA+sSMvNU5TgXKJycLaJ
	HIdjSYpJrZCwKALxs1PbSn2Vb/8p17kPgHqLSF662apxp5tgmzEPjCG7+H6S/vCk+g8kaEBHcWH
	HsB/9UADXb9Zg93RhorEruh2wRO4D0nAQ0Xmg9q1nTZ4GxhMZb+2udf0Bm0qXl/pUCuHxQhOoS2
	M7ejPYBWUrqLZzeoVj3/d4vEZrMeOA87SbXJFIe9pH+dM19M5q/gR36OMI1nngGoUcA+oCui2rS
	Ozvlo7YkUzhNDinnsyNFIJ9iDHc93mD94ghMLCUwk=
X-Received: by 2002:a05:6820:161f:b0:694:6acf:a420 with SMTP id 006d021491bc7-69998cc4661mr8167883eaf.15.1778294480626;
        Fri, 08 May 2026 19:41:20 -0700 (PDT)
Received: from Dell.attlocal.net ([108.243.219.47])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4355736dbc0sm3443464fac.11.2026.05.08.19.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 19:41:19 -0700 (PDT)
From: Akash Sukhavasi <akash.sukhavasi@gmail.com>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Akash Sukhavasi <akash.sukhavasi@gmail.com>
Subject: [PATCH] Input: analog: replace deprecated simple_strtoul() with kstrtouint()
Date: Fri,  8 May 2026 21:40:48 -0500
Message-ID: <20260509024048.46132-1-akash.sukhavasi@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The simple_strtoul() function is deprecated because it ignores
trailing garbage characters, which can mask typos in input.

Replace it with kstrtouint() in analog_parse_options() to enforce
strict input parsing.

Note that this introduces a minor, intended behavior change: while
the old code would silently parse a malformed string like "12abc"
as 12, the new code will reject it entirely and fall back to the
unconfigured state (0xff). This strict parsing is the preferred
modern behavior for kernel parameters.

Signed-off-by: Akash Sukhavasi <akash.sukhavasi@gmail.com>
---
 drivers/input/joystick/analog.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/input/joystick/analog.c b/drivers/input/joystick/analog.c
index b6f7bce1c..07ad360f8 100644
--- a/drivers/input/joystick/analog.c
+++ b/drivers/input/joystick/analog.c
@@ -653,7 +653,7 @@ static struct analog_types analog_types[] = {
 static void analog_parse_options(void)
 {
 	int i, j;
-	char *end;
+	unsigned int parsed_val;
 
 	for (i = 0; i < js_nargs; i++) {
 
@@ -664,8 +664,10 @@ static void analog_parse_options(void)
 			}
 		if (analog_types[j].name) continue;
 
-		analog_options[i] = simple_strtoul(js[i], &end, 0);
-		if (end != js[i]) continue;
+		if (kstrtouint(js[i], 0, &parsed_val) == 0) {
+			analog_options[i] = parsed_val;
+			continue;
+		}
 
 		analog_options[i] = 0xff;
 		if (!strlen(js[i])) continue;
-- 
2.54.0

