Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795164076;
	b=dd+OZceV0G+0ZRpX4jUuKO4Hbyqkbm4CX0evb5r5H4RxnyD6+DE2vBHXRWAQgwE788wc
	 HRg2vFEbNekZ1VcWnChP/4JUzUQqpuTLn37gbjXL99co0DZnJjP7gCCsy2sqKGGHhRZcm
	 S5pGn0mcO0QKzOQQbYbwYZGPbLXaaUg8YXnZDB3BQql9RNZCp5fZ18dz/kXhWAVTOBY7c
	 qMG2LpN+7EUhzj/lYbZCeJhj9ADL+TKKtT/IcXrLclluvoAeoUPpcvt20IiP3xcC3Um6g
	 sg7leOd9Pl/agUGoNxnrnDgWzRuhaGnWkhEzwZ4wIPzgeYHg75U0DeWXBhjgQkRvPDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795164076;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=HGzRbKnELJ8qkWoVQZYvDioaGdGM1A2dPzzsZl9uGoE=;
	b=Fe/K8ualXKX5/ZA2kaRQsEPcN1dlbt6MGx/1Z6BCAIaoeLeViaDqla+GJHG8nFjYbSFw
	 BsQ1uuQ+aWW3zPiN2TXjYMoMydVmEShg8k+d9qYM0EVr/SZGln7O+MfY2wqlELsyPQ7DK
	 ZgwT2yNsCMD6JCmbpYCRkm4mcBMtEJbjYTN5yxxzHdGfqJ0bP2IL6Dffxym+rimpjV1hW
	 DbUgblcxHUpZ4QvMA46WqOiywiL7jovgi8xurMWYh4LGGVIdbbLWun8LkGGLQX4y4xrBa
	 RFjGLazmM0td49bPRwq23iXWR8dpwJW5V1OFvxvHnqGVRayN5rGPBcRgSxxkrAoxvSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zalxmY5k;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689C760A2627
	for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 08:41:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 689C760A2627
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zalxmY5k
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-385d8a00598so493807eec.1
        for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 00:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795164075; x=1795768875; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HGzRbKnELJ8qkWoVQZYvDioaGdGM1A2dPzzsZl9uGoE=;
        b=zalxmY5ktb5q1XhAa6vkc7KDCqft8ehVrCQR8UAfYIseCffLXh2tfM4A//m+HSe31A
         qOgWnLMMUWwV2ujE8uB8rkqzSS+RxLIEhur5RgW7Y1vUPQd7zQNqqQUf5VBPM4q6mJ87
         dQi2dfWRe/IURzT7nLFAik58d6IH5qaxzCAZbdG6zP4EVdm4LdDxQyUSgKFGhSNUgGc4
         TgsTg1CfrxuYMYT/NeCxwGY24nW6gaCrzw+uDgSI9vLOFi7OeS+XcwLfR6BE4LkQcsU2
         ZEjUzb+2pmSMd9gPZn04LQuv5ScGLdfyAsWgRJo8zA2GB+kU9aIRVcCkdT8fQFU3Nx+k
         SUOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795164075; x=1795768875;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HGzRbKnELJ8qkWoVQZYvDioaGdGM1A2dPzzsZl9uGoE=;
        b=liXA0S2a7eV7z43Z+spD5ICuOJu4ljlPEtS2Pqx0PEilLMZOknOoH1xQTEonp5Ozio
         gUtAWQTeV5coMVMiuj0iBmVYg4T3Rx9+QjTYqPe4d6spvxpDU7trPCUP7eYz9mZvX+BX
         N6Gx5ZPMXCLOORjs8xmtG0vIyBBBvS1h77Bns/Xt6eZfQBizedPuCk9NEBexD+85eAlf
         7OLfaLJp6L/kpWZtfNY3jzkunb59CLExGDYlmKUw44UIqxKGktExDU9U7AwYhjiNyKXG
         CIFgK+NQ4O/VIi0GeF1loZEM7JgD/JZ27EPdbY8P5vyWHWynwtzstr+jOjMc+Zegcxz0
         t3Ow==
X-Forwarded-Encrypted: i=1; AL+hErHg6a/YjrSqOHXJvtCYxfciCF16N7IN1MdUUNbwGkvD0+6n42LBhFeULepCLOblTSU8hp3SDX1K9wWL4Q==@vger.kernel.org
X-Gm-Message-State: APuU4Z9jfX78KP0LIuMGc/rDxOVS3URUhQ4qlHbpZpOvlEvraIkW7vCZ
	ShVd8dvv+68vISeXS2OlOYA1r4NnBYLz5kS0j8FpXgtnea6xVhYqq4PGgG9ORw==
X-Gm-Gg: AZFdTZfHEs/fujN9u+V75LLIfz9zZETblJdtoOk574vIV3oWpEP7t0ERfSE45PPzZK8
	TWBpdg1qAx2CtVfTMBcmLETRXMOgmr7zPYV+Me070Y2mIYAISwncoWVVJr4dZlpKtahaU3Bm0t7
	cBagrMpg4JHZMxtrs8iDre7Wvu0fmlphgWVhXnMk4xxUabfANBNRZ50xah5KJdVemFjYT3wV7uQ
	3jtl9Zp6S/g6aXSzTIunJxMXMloKKqFgL9ideIZTI8yjiLENRpPgPnpag5eCAW2YlxytG201xg+
	mRTNS6+JOp3I8S6iAAdOuyMCZ9ZiN6wUFEfXNfiGv9rUB6Ld0+JzONq8nos9QDqbtKYVjxgObtI
	5uzSwjIhQBwhaATmGaxAY25+MudQV/ET43gXiA+CbvCP95Ucmw+UsXXccpMUzGp7xE0MGmXEpOX
	FIbE7rFtvmFMgrVrxVoaWaIGvUSEyfGk1bHDkxcxLon94dx8aqzQBjFb0uFxI/ugoIfDm6K/Ieh
	2/XsGPrUCi2ukjcLZ0TEYhVglLmaLpCD+TkKxsf0kBl6FUhcwlm+KtjimJlovRso3Xyd89VhHZj
	nFKuN31yrwyKq53IEqKRBjC29yRy9K5Rd8e2rfagThj+f4nfIPRb21s+HtfuXKqgQKt++y0ERSw
	hMp0lB6XiGAvApOPp/Q==
X-Received: by 2002:a05:7301:182b:b0:36d:9900:bb92 with SMTP id 5a478bee46e88-3856f256533mr1782564eec.10.1795164074557;
        Fri, 20 Nov 2026 00:41:14 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:ea97:e47d:2ebc:210c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385677c371esm5793181eec.23.2026.11.20.00.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 00:41:14 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 20 Nov 2026 00:40:59 -0800
Subject: [PATCH v3 11/14] HID: logitech-hidpp: handle negative errors in
 hidpp20_get_adc_measurement_1f20()
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
Message-Id: <20261120-hid-logitech-hidpp-v3-11-cfe2caa1d0eb@gmail.com>
References: <20261120-hid-logitech-hidpp-v3-0-cfe2caa1d0eb@gmail.com>
In-Reply-To: <20261120-hid-logitech-hidpp-v3-0-cfe2caa1d0eb@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Gideon Heinz <gideonheinz02@gmail.com>
Cc: =?utf-8?q?Filipe_La=C3=ADns?= <lains@riseup.net>, 
 Bastien Nocera <hadess@hadess.net>, Hans de Goede <hansg@kernel.org>, 
 Edwin Velds <e.velds@gmail.com>, 
 Stuart Hayhurst <stuart.a.hayhurst@gmail.com>, 
 Andrey Smirnov <andrew.smirnov@gmail.com>, linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-6b8b8

When hidpp_send_fap_command_sync() fails with a negative transport or
timeout error (-ETIMEDOUT, -ENODEV, etc.),
hidpp20_get_adc_measurement_1f20() only checked if (ret > 0) for
protocol errors and fell through. It then parsed zeroed response
parameters (0 mV) and returned true, marking a disconnected or
unresponsive device online and triggering spurious "possibly using the
wrong voltage curve" warnings.

Return false whenever ret is non-zero, logging the debug message only
when ret is a positive protocol error.

Fixes: c361982a13c9 ("HID: logitech-hidpp: Add support for ADC measurement feature")
Tested-by: Gideon Heinz <gideonheinz02@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 0ec2f2fd6dec..28402baf04fb 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -1952,9 +1952,10 @@ static bool hidpp20_get_adc_measurement_1f20(struct hidpp_device *hidpp,
 					  CMD_ADC_MEASUREMENT_GET_ADC_MEASUREMENT,
 					  NULL, 0, &response);
 
-	if (ret > 0) {
-		hid_dbg(hidpp->hid_dev, "%s: received protocol error 0x%02x\n",
-			__func__, ret);
+	if (ret) {
+		if (ret > 0)
+			hid_dbg(hidpp->hid_dev, "%s: received protocol error 0x%02x\n",
+				__func__, ret);
 		return false;
 	}
 

-- 
2.56.1.750.gf70dc682cf-goog

