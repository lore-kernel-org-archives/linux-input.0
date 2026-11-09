Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794204672;
	b=Q+LoJMrWMHiBjI+QeZOmQLDYNVMlni/TvgtYy4Fox4DPmvIqsIvSULNDZUlJTND28pQV
	 eyycPk/hB7dvLTLHUBiQgvkQ0Tg78M8FPTACa2TQQS/4fFfDWreiWMHFHFuwXvqGsWXLJ
	 Z6NKSEMcdPY19FP6gqT/7KITwUMI0x2LixkrgWvOP/hvd/rVa9OjRpCppIBYZ6HJ0xNl0
	 Rhz6rikaEKGdVXDHngX3beH8KsU6W8v2FaTWOsk0Z+HW1Mef2tAQBRqil088XZHFN/3Ui
	 mnm6kWA0Ihuh++nw6sOxA8AUnNKXZwsYZOQELPbvm9gjjI6z2mVGWFRZeugqIFgPRIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794204672;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=3Id2km5CxlYm1pWn+dcidbAfMpqvkr28vGXkLmQcZjI=;
	b=tX6EXziPihBCiFj13thMeeIdTtjIv6E++pxsitu5XcIga+yaXLDF45v5thPEUCtAiXjk
	 6vXrK7WwhTZGFShWxFoDpWS9Hs5k2aGU756tamhvLoVwPKUf5QLVafbNSQSynBpXtEEIl
	 BjlOUYtJfBZdl2OBuqAGvw9YucgpnNzPgy7GR/+Yu8+3X4JUoF5ARggTaTnahMcJi9FbB
	 ONr241/rgrzq45yXFYfgdw4xGwymwg6xPrxN5JBnbg9uKIAhBU2UZBAY1VG9G8S7LoUvS
	 b3kzSumd5gEq47KZGWTJAQtRm9b/7U307nZ06np2fuNzWo3pFBgbh5oGjYkk4zSv05A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NDQuNPNu;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E15606A326
	for <linux-input@vger.kernel.org>; Mon,  9 Nov 2026 06:11:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6E15606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NDQuNPNu
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-3645f0f3fcdso1023282eec.0
        for <linux-input@vger.kernel.org>; Sun, 08 Nov 2026 22:11:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794204670; x=1794809470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3Id2km5CxlYm1pWn+dcidbAfMpqvkr28vGXkLmQcZjI=;
        b=NDQuNPNu+wO1kS1Dx2SDzKWSRL67InMOdPsMwvGfI+nDQYbctvO10qNrQCKgyl4Qvc
         jWB4bUwuibbuW3fmHUix1a+ixJSRxVQBigcQBvcwwhy5GunugTwUXTgcWu0FSao4WzTA
         iCGPBJnvc6AwcYH52h8QjZxp0GLZKE0ji0dRjrUTLo6Xrcek5ziqHyX/IESkGmqW2Sb6
         NMlYwTArmhUvvLKNEZt+UEih08xp/TDB59pib1PfodnMrgZD3QyH1BVxyRzDNY/FoHZR
         MCpBQCxdH4WcIgmA6xrFafLWP+TI+ESAUHiERV7lqVCr7cH+nhfUBMBg0nH+9kAWiRWD
         dT/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794204670; x=1794809470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3Id2km5CxlYm1pWn+dcidbAfMpqvkr28vGXkLmQcZjI=;
        b=iHKZ+RcmkycNRyNz+hWs8/W5hMYyUzT+wnZ+ylismdJv7gLRYx1aAw389U+BEnjAfX
         hQxyPxSC9K1zHvp9KLoKRSuBPQl5nkK8YUb3ezABmutdT4q76nDXBKN2Z0RwDccsYMy3
         O3nB/VG5vltGdUEDzcXB+H+Z7n64R7pw/u9bLk96nxMogaxGYxTsCY9Mh+eqmn5Uy9bE
         kGBZdwbxxMm/HPqyiQ3MfDVPLOo2+9zIWM7C4f64FSKtqxHr3YgceotkVsRJgRNoxtNJ
         JOEI7/vyEzqeWBz78uT5gE0iaWe4LNNXlavYLoLK39N+AnNlq73DwfXzZEPCBX/yGXHo
         ilYQ==
X-Forwarded-Encrypted: i=1; AL+hErFgPogZDQ2UjaWw7CupbeKVF9HKSQQIQWe36pqtfiLZZmyhwYjYG5nbf63DyYhf5SzwvYND8Spfc34Axg==@vger.kernel.org
X-Gm-Message-State: APuU4Z8wObtlsVl22JEwy4uLFJWfY3pz1s2kTk9rYrScFpZorrsb1LDM
	DUGbX6KMJEs62QIxOQ0ipVGEM3FouDfFXo1JhBqgB8RAYmBJ8bRpqXjp
X-Gm-Gg: AYBFou2+2DB83+K+hdgo6TsUJpNroENkktSWXSEfbHKYr2P53tjQ/M33oiLav+Z2LhG
	36BmMFr37RFooYSHcftzJ6XXv1Wo+TIW//2emrgQzu5wzDRkUA8JzPYCTpw9dIMo+TpjemTqkDB
	mf3W/+USF2/DliM9N4iAW82b6ZfqKLPVljxRHQ2SIoO5CvF8ES9dsuqJu9PdBSOBcJEwjor5iAR
	gGEUVOWU2PIs2Bm+MKXssBuJi0TuznybiGm7CKzWAzr0wViUOJcmb43DO3AjsJyALU5Lsi4py4J
	2GRqmQatklkr7dNeGDF+mWpfQohV99SqZrcvryS1cfwcIaiKveTVBNh2ubiQZapLLQRFckQM1mS
	+ki3Lji2tv18BCslQ1k7JpB+hUCZgCuhRsHXVRBQhd/g+WhtXAONGfi1cq7CTuozSzYz85+0/i0
	ccd7CFeYyA2ZsKHkSxUdvIa2P1B2WnhGnhB0XVWCDRtdFkEskiG3LUS5fmxhNoXWp28WB19ro81
	cHB+qqAGzNNYPmp8PIR50DO+reTW0Vk2gemKmPFlMhKqQ9ADAx8FQrWmK4EBzjFNlL+1RyhiDO4
	+TaEwZPvMSTaUqkJmhoDUZT/Y+D0WiJjc0EGFpHobSB7U0WWuunQc9BrdiMeh4QKPB0ggyQ/LGe
	kpFeEfdmCNJZJ5ehT
X-Received: by 2002:a05:7301:1908:b0:36a:180f:3154 with SMTP id 5a478bee46e88-37256615db7mr5282253eec.18.1794204670493;
        Sun, 08 Nov 2026 22:11:10 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:3588:b56:78bf:db5e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-372661ede11sm12201192eec.21.2026.11.08.22.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 22:11:09 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Gideon Heinz <gideonheinz02@gmail.com>
Cc: =?UTF-8?q?Filipe=20La=C3=ADns?= <lains@riseup.net>,
	Bastien Nocera <hadess@hadess.net>,
	Hans de Goede <hansg@kernel.org>,
	Edwin Velds <e.velds@gmail.com>,
	Stuart Hayhurst <stuart.a.hayhurst@gmail.com>,
	Andrey Smirnov <andrew.smirnov@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 02/18] HID: logitech-hidpp: use GFP_ATOMIC in hidpp_ff_queue_work()
Date: Sun,  8 Nov 2026 22:10:46 -0800
Message-ID: <20261109061103.2887636-3-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
In-Reply-To: <20261109061103.2887636-1-dmitry.torokhov@gmail.com>
References: <20261109061103.2887636-1-dmitry.torokhov@gmail.com>
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

Force-feedback playback, gain, and autocenter updates are invoked by the
input force-feedback core while holding the input device event spinlock
with interrupts disabled. Allocating work items with GFP_KERNEL in
hidpp_ff_queue_work() can therefore sleep in atomic context.

Allocate work items with GFP_ATOMIC instead so force-feedback commands
can be queued safely while event locks are held.

Fixes: ff21a635dd1a ("HID: logitech-hidpp: Force feedback support for the Logitech G920")
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 6b1f55483385..40ebab5241b7 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -2542,9 +2542,10 @@ static void hidpp_ff_work_handler(struct work_struct *w)
 
 static int hidpp_ff_queue_work(struct hidpp_ff_private_data *data, int effect_id, u8 command, u8 *params, u8 size)
 {
-	struct hidpp_ff_work_data *wd = kzalloc_obj(*wd);
+	struct hidpp_ff_work_data *wd;
 	int s;
 
+	wd = kzalloc_obj(*wd, GFP_ATOMIC);
 	if (!wd)
 		return -ENOMEM;
 
-- 
2.56.0.506.g506a7eabc5-goog

