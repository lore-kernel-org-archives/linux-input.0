Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792896536;
	b=wcqoF5e8nyHnQEhaP/xkwB9OF1uCfR5bovK0zqqNnCfK5dGvNNe3SdxYQSESB8PLxkv2
	 x9Xgl6xQdSevvPiqRPbSzCnR9cGFKLn//A1deOMosVanD6vyO6u/QO61BBn3c6rSOIYuo
	 QZRPXuvRN4OfJbBuWObpCo8Jr/rwIhduFDTqkU/TWAhX7zPndKAIeWPnL6ob7/2OA46PF
	 7d1hAi4GS9/3k/4YvcaxPsCazonp6W+frYyxSq4InOzG+68u7oVlXXmJ+a5e/Vxjm1c9m
	 jCccZPJlxZcbJigQjDb1bRL3ztrf8Ku7Tt1QPY8V+F9u2i9gF9mYzJ64Ow4AxJhZ5VA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792896536;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=K6RWQvZ0010QMq8qM7UpBKJiUI/Pg5qFMdimoJtiVT4=;
	b=5KHCNesHImQKScHMQ3atm8hc8qS92+/Y9otwRq5FEqUxhxvUo/QnExMdlOTqE0fEhng+
	 j05TNZyMozUyqDTE+Y8h4hXALsq/x4ePCw4/eigioOJKzpL1p/+N6fBpUF79gYCkWPDnG
	 6yJBL3TlZT8ACVTedl88Sk5oZvEhoO/6+x0kMqJ+qdF2FKsRu6WzWEVL8Noal6a4/1TZE
	 9fA+9t89+J9UVbdLdhSxkifnE24I7B2ZTGqYNrDorqP1v00CQNd9apCqTgda/YY3+0ah2
	 LJQ9TpiWdMGs+7iA5n3ChTOXpXedS4wbDrHM1R41zUXjfIQdieesizbjhwc5A6CnR4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jY+GWyYS;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C598606A339
	for <linux-input@vger.kernel.org>; Sun, 25 Oct 2026 02:48:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C598606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jY+GWyYS
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso5337057eec.0
        for <linux-input@vger.kernel.org>; Sat, 24 Oct 2026 19:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792896535; x=1793501335; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K6RWQvZ0010QMq8qM7UpBKJiUI/Pg5qFMdimoJtiVT4=;
        b=jY+GWyYS06WKW7sEDFJqidwo1kj5aZiu+FCc59Yl6t+aaUEEs04DN9aHOSFvf4pJ8Z
         qDTsGyTd2hnl7k5Ym46s4MK+M0SwUS6QT0od/3PXQUY9mRrVY4wqzdWTtw/7QLtKhHPa
         Wl1hqNxbGN8k3SsCbjwlCsOrJRQMs4gMf/tZHs8fW9xwTRoGmWNJzJ/3nkRIzMHK2jEx
         7Yvg/dWXiInPgUoSXDzs3Y09VvZo+NgZaXTjGaJ6myy/TWg725XOGN2XlqtCb0y6wNjt
         /5awgzg0f9X0YKC3fb5ZWJ1bxfPVtsB3fUtQFpxRIUQdbgAmX+A1x2JOoOg4XWscVZWx
         qdVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792896535; x=1793501335;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K6RWQvZ0010QMq8qM7UpBKJiUI/Pg5qFMdimoJtiVT4=;
        b=CQuku+27y7doIyuJByDqFHOqaYuHZ0SbbIsnKyPXpcXT3a7aKM+CGPjqQvTiup5i2M
         mrh+vSGXoTxWvBk5brBx08t+ZnZVDfPT/IfdSTZ/n8FiIFXnK2mQ4/eTdRHVHF0FAURM
         CdwXxsKzv6TBm0QY5yzPDfEfI7qcZMrj7o0jqc19eba3GPFIS/TPxca5f9DtbtXTxzrT
         F5+/f62dc7zlogB8/fH1025YxUFr7PBxJO9nwufJxgAe8gkUCkdqTquuC//iNAmWY3FN
         D4a+rsEsOmczuM36HzCs99U99N97Tuc6JdV95gz8ublGJkt7twHXX404I+3b+LSQt2FB
         uSqQ==
X-Forwarded-Encrypted: i=1; AKwUvBzAm/EgPkNIajF/CoRcocwwx9Q8Q4VOCQnL2aN8HRF8vkA/gLQh+39Sv0fDBepK3CPFwfEtUvRuSPJ2yA==@vger.kernel.org
X-Gm-Message-State: AFq9FYKW4s7YghA7X3dT/LHgSZvoMl9jOJkNA+62GgNFH/GValPUrZ8F
	lQ0iiFrWKqAKXFM54C7aLE24blp+1FivtlA+BCgjezfNcxVtJlQpl7HG
X-Gm-Gg: AYBFou3ZKCFV6Typ61g/DfmJuTCrpuKLD0IeVvgx119GeKZYHOgGmQH3CVbG+07fP8W
	DCIENkaUNfRZNY+xsqqyraPZltuHwpEJUmbXBjTwmJyOx+ekt65afvBJgvTnXpnkJA1FwJ4hvez
	2z21wLqJKd+4EbP8X8PV6eTjjpzeSk2ubg2Df5ZbTBuhWyfC/uGDLTuZrfPNjqDKI5uhRdCwlnE
	o7UzPtxNRYokkOSFHC3PBel4MiT2aot8HaVZyMZFY7AaeeowGGwVshPLMwc3ydusrOWJbS6IhqP
	G0bgSq38rOJh6btEh7bP8qrK97yv31RCTv4xN69qEScvD7JnciftM3RsdIANZA6a/yxBu+sfTtW
	x4uAaXccAPBl/iPZ3S4Ly4q8dJs2qg4cb6xXR8WRfdrnw9JP/ewmeT05Jbn/2oglRhYHGQKNqaH
	LHvv1vxSBcvnl3GxGdVwwZdoEseqILgg9soxIx1bUKBw6w7TWfmnxY/40FCqYneXxCrZloq8LEZ
	j+nQWCudPpSqFa1P5TbDpAqX8QR8zzH2b0v8Y7O5VfGJ9L2WwMzOiaq8wfNWqtqGaCIcuc4e5MN
	dPLP7c6457mOwY1txEQL28OeqRTOKNVpkcdBuVrqCmw=
X-Received: by 2002:a05:701a:ca07:b0:184:d593:2897 with SMTP id a92af1059eb24-1993f3ecfb6mr5382379c88.29.1792896534741;
        Sat, 24 Oct 2026 19:48:54 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:8fe4:693:7158:24de])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a2e32479sm10521272c88.21.2026.10.24.19.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 19:48:54 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Sat, 24 Oct 2026 19:48:45 -0700
Subject: [PATCH 5/8] Input: synaptics-rmi4 - use 4-argument
 i2c_smbus_read_block_data()
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
Message-Id: <20261024-i2c-smbus-read-block-data-v1-5-19bb97467982@gmail.com>
References: <20261024-i2c-smbus-read-block-data-v1-0-19bb97467982@gmail.com>
In-Reply-To: <20261024-i2c-smbus-read-block-data-v1-0-19bb97467982@gmail.com>
To: Mika Westerberg <westeri@kernel.org>, 
 Andi Shyti <andi.shyti@kernel.org>, Corey Minyard <corey@minyard.net>, 
 Hans de Goede <hansg@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Sebastian Reichel <sre@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 openipmi-developer@lists.sourceforge.net, 
 platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org
X-Mailer: b4 0.17-dev-e56a4

Pass the transfer length to i2c_smbus_read_block_data() in
smb_block_read().

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/rmi4/rmi_smbus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/rmi4/rmi_smbus.c b/drivers/input/rmi4/rmi_smbus.c
index 8b61c2382297..a180becb7670 100644
--- a/drivers/input/rmi4/rmi_smbus.c
+++ b/drivers/input/rmi4/rmi_smbus.c
@@ -172,13 +172,13 @@ static int rmi_smb_write_block(struct rmi_transport_dev *xport, u16 rmiaddr,
 
 /* SMB block read - wrapper over ic2_smb_read_block */
 static int smb_block_read(struct rmi_transport_dev *xport,
-			     u8 commandcode, void *buf, size_t len)
+			  u8 commandcode, void *buf, size_t len)
 {
 	struct rmi_smb_xport *rmi_smb =
 		container_of(xport, struct rmi_smb_xport, xport);
 	struct i2c_client *client = rmi_smb->client;
 
-	return i2c_smbus_read_block_data(client, commandcode, buf);
+	return i2c_smbus_read_block_data(client, commandcode, len, buf);
 }
 
 static int rmi_smb_read_block(struct rmi_transport_dev *xport, u16 rmiaddr,

-- 
2.56.0.257.gf7497c7d27-goog

