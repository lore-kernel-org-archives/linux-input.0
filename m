Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794380232;
	b=nP5N0GbwX9Ei3WIKymIT/qStzetlG8JEg3r5DY24tpRgelzEU57IY1qIKdQ1VnynrPUM
	 ysUrzw6VNq+kbbZITH413/M/B0iXAcR9RL8NAehaUhF/phVu0j/8sNkEoxZDxE0ffPdZx
	 0DtdbdZFUW3KH4ePhnO6wOz38ITmjSgNnDYmNqMZDmdLhmXGwP0mBh3SdUqtiqkz5q/Ll
	 392TcR2cwpMXd3ewHxkbb3DlLlB7pMQPhRTGlM447xK0mNug8kV1b7rCPHJRFoamkN7GM
	 OR8a6Dkymw5VJqBmg59maFMqJ8Dozx1hp+WWt1nB9IHjeKF1ZA6Wzczxh6b1mreEnrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794380232;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=7cAG0LFOyDFplTYOgTeu/80XNthLT7QaiGEz/0QjoBw=;
	b=cuNbU1VEA7dlSnKEOGspLhCuptOOzxpw1gTQRmfKkoevcgZY5mI1qUP14lxGPbRPLjCy
	 MpEG1BhuYxMTuBqydmrw04qlbvyczyygzt9Hkg2nyjrN3IdcQn8Vi4VL2vrLVTnlxqGaJ
	 CyjsmfLATzc76aBSFkA+J2F81yULeNQbI4JtyMO4jY9cdOtGCr4s39D5fk/rM6u+vngmw
	 c+euqmPGOgvjtPVdZgYFnms8jQDdj+cMpFO43cgQqlxAWSW7VpxhQHR0mcQxZV7Buqshx
	 nLfCJSSi8BJ8pcMBIHxKGcYosOcBY1MGv5pkEosliIHDyZ8QBYNYl75vx6bNSmNgepQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FpY9bAxH;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA34606E230
	for <linux-input@vger.kernel.org>; Wed, 11 Nov 2026 06:57:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5CA34606E230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FpY9bAxH
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-37628596783so1712482eec.1
        for <linux-input@vger.kernel.org>; Tue, 10 Nov 2026 22:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794380232; x=1794985032; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7cAG0LFOyDFplTYOgTeu/80XNthLT7QaiGEz/0QjoBw=;
        b=FpY9bAxH73oZ5SmkvIIbJrU0L1zcgFIpDl3vljpy+mMT6JHmwjGXFxqBB9HZA5tdNc
         Hy5kpaFvoIF8XwC6BfAqZGD7UdjPsCYVj1rQ9AaHT6dUTwM2CJaYpq+VOpnAFKNhkW9A
         g39AEBpFHLYli6Mw6TZJ3RZFGcplKvl4O87MERlT38svz0ij25r4EF3rYTOuFeSFW5Y/
         a5A0Jj6PDGrO+hDUsnumPyaKJJ8C/clgSC0YqAUzFHx0z/SO8/0MrsN947QQ4bU7+NC5
         kaqn0l2VnSFliRPnLqDGQpZwlZmSpPeikpQFycfxr4hk7o/O1+Dw3Qf9CX2Saj8VqUnj
         IWjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794380232; x=1794985032;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7cAG0LFOyDFplTYOgTeu/80XNthLT7QaiGEz/0QjoBw=;
        b=QoyDcsketiCDlHwbeuq4Oy7g9vhisQKT70Enm7ri3FJUcLTjen11MjriiZwLR2fguo
         VvY84qx1ljz4FszcmC7biBdUTgKBWSN/fuyj4kUG2ybQY9DGsOoA3EFn8yHsCbOdyEWp
         gjB0HzQayTVL97g6yrG8rzgMGT9v2pTFHFNxifgk3MbOyZhO9+nakwsBBx4UsoJjfFlx
         j/sIpAIZOh9lLQj9lXMblTZYavrQxwZ5NMldkt52tgJeaYkJs6h6BUpPWPzZSy6kHBpA
         UcRHYWNyHg8OYVwuUCmSfXN6W5E4ykiM7ox/DPtcwDN9lL8D7WuWnAT7oOLDcijF5RLt
         rsGQ==
X-Forwarded-Encrypted: i=1; AL+hErEizFPDSPn/MbCiEsyVcF0wSQqAdhFbXRH4rpURb4xfkBO5yYcrUxXvb1i/n+fQLDu8Jx9hLCfP/ijg4A==@vger.kernel.org
X-Gm-Message-State: APuU4Z8HPh5Me9fIP7sfy9M2ygMFpPK7snQcylE/z0LEo+2KsgBytgmA
	lbbHrJV/2lh6t7vaZq1bzBVXIrRGB940K8QhRqkf2vKW+mo9qnkOfT6o
X-Gm-Gg: AYBFou3q4p/YYuVw0zkks9ooE+P8p8Dg67b+fy3wmEs/4OqK9eyz9KM5fdWHUc6zTM4
	9wGVXW9DDis59A+q9uMbwIQi21sht6awsMYPG7aTvlpG3Cxe9plaWvWHG40OCEO4M/Jp5M13SGs
	1nJtiMYpj+9QCDiDpLpyJKabfDzI8hZIup9Hv4eYWNHwXbgJ8zupid7MFbhu6o6VTAAXWBye6Dw
	6cY1kUHpTyaR6VEV15VBZYiDqVG8VlBmPyXAvlLXXSzlF5eG7AahLfcrponTXM3XjOPaV8TaNps
	97N6f+XQfHY0LyESSEm6/teBq9KoUBVv2/UQKGqjxqyXXPiYBtD3qAycRSt6iCW0TCnUdR2WdXA
	tRrXv7Shh1ZFLDQm/wGHI8r/h6bm5tiYIGFNH/z16vG53ZnZ025y2Pl71d8OKIwN+JWEufVp8Cz
	B1FOcHCvvlyDP4TDAXBNbEjM+9G9g1yjGf8praGCW7nCbQstq8t/zPMOrT7qBHiErIwi5CRqsAr
	uCdsugBnfSWOzDag8UPFxmTFGiUGLl2ergZe8+ZuQc++IyvvVW4dIC3HYtDEinJZiM7Uz3gLMR3
	lTTvg6ekVBhaqMSj/0WpBsfm4+KjbDJiP5ykXVRmsyMOiKC+/IMUfq3jzFiZu9c45BWc0CUklyL
	1iy4qVTsUGAkB75uQQg==
X-Received: by 2002:a05:701b:2415:b0:193:3274:aac with SMTP id a92af1059eb24-1b3c0362a89mr1547534c88.37.1794380231494;
        Tue, 10 Nov 2026 22:57:11 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:311a:ad7a:93f8:96c8])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b11435sm13858121c88.4.2026.11.10.22.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 22:57:10 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Tue, 10 Nov 2026 22:48:28 -0800
Subject: [PATCH v2 30/33] HID: logitech-hidpp: use
 alloc_ordered_workqueue() for FF queue
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-hid-logitech-hidpp-v2-30-30743e91d83b@gmail.com>
References: <20261110-hid-logitech-hidpp-v2-0-30743e91d83b@gmail.com>
In-Reply-To: <20261110-hid-logitech-hidpp-v2-0-30743e91d83b@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Gideon Heinz <gideonheinz02@gmail.com>
Cc: =?utf-8?q?Filipe_La=C3=ADns?= <lains@riseup.net>, 
 Bastien Nocera <hadess@hadess.net>, Hans de Goede <hansg@kernel.org>, 
 Edwin Velds <e.velds@gmail.com>, 
 Stuart Hayhurst <stuart.a.hayhurst@gmail.com>, 
 Andrey Smirnov <andrew.smirnov@gmail.com>, linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.17-dev-e56a4

create_singlethread_workqueue() is a deprecated wrapper around
alloc_ordered_workqueue() that unconditionally enables WQ_MEM_RECLAIM,
allocating a rescuer thread. Force-feedback packet submission does not
run on a memory-reclaim path, so allocate the send queue with
alloc_ordered_workqueue() and zero flags to preserve strict in-order
execution without unnecessary rescuer overhead.

Tested-by: Gideon Heinz <gideonheinz02@gmail.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 67b4f1112168..b6c7a951cc94 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -2791,7 +2791,7 @@ static int hidpp_ff_init(struct hidpp_device *hidpp, struct input_dev *dev)
 	/* init the hardware command queue */
 	atomic_set(&data->workqueue_size, 0);
 
-	data->wq = create_singlethread_workqueue("hidpp-ff-sendqueue");
+	data->wq = alloc_ordered_workqueue("hidpp-ff-sendqueue", 0);
 	if (!data->wq)
 		return -ENOMEM;
 

-- 
2.56.0.542.g3ef89b7020-goog

