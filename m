Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792896539;
	b=cys5oNkblLb482Bhu8s+pB2vaNyqEUCq0GROWOm905EzSQDy4tNvM5mb9Iz7vjCocWe9
	 G94OGkxuPjpkDhu7tWTX7VLVw2EcHElLcfp6xsniick9tyVDPi5EfNoGjM/iM5IxIxhXA
	 NZqQDPL0r+CG8PVez6X0FSlhF470oGiWJoR0ekMENjTdWjIvRPtWMfMVya586Fvh9vlgK
	 OTRM80D56OBVJlBHDVLMut5H84YbRq2mTNwyANNRUf7BpREX/y/xccpVi1rUD0HJMvXo9
	 /s9oF86mNoMCO3TOmlB2dO4fNhCQiMnceI3wQUpcv9qesRxeNYkNTl2NjDODPKZeAXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792896539;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=+D4LEQidpEa6OUGGXTLPtwOtKyE7/MIv6b0FECjwB4c=;
	b=WStav2LIE7sE/Ons/TdiZSiAT5RzNBy6yZCQZUHaka/Fw9F2XL+DiMK7GiSWMOsq9FTB
	 87/N/ZSEc/XQCbHV06J7BsafuoU+rgOUYGvaNpzGBph6ev87nzFmEDgIQvoODGNIQ6/cg
	 Le5rpy+RtLm7OBCuTEYQh/4w821QcsxrzfXC06KLYPO+zl3JSRZAsy5wmhsmteOM3KsUB
	 T6nNyCqArDwoEKkALXmVzZOxifObh13UT+UeHFbw3RaIQqy02cY/qv6YQQivag4GBl2Ii
	 vWsuqt4c3jxGUMxEy6F8fi32MvZMStwW4CMCRZ5UlntEsniIxZD9D2/p49H12YrNxbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KoY+mptH;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6EF60A260C
	for <linux-input@vger.kernel.org>; Sun, 25 Oct 2026 02:48:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE6EF60A260C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KoY+mptH
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso5337131eec.0
        for <linux-input@vger.kernel.org>; Sat, 24 Oct 2026 19:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792896538; x=1793501338; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+D4LEQidpEa6OUGGXTLPtwOtKyE7/MIv6b0FECjwB4c=;
        b=KoY+mptHC0CdbSXyXRIQLOUk+sIQ2V8zR/H4vg66uM1mRxvr8C2tagJSF+7ZHnvhXb
         mrm+QXgnkIMNQlrG+qcqoZpD2EjjNBgf7f9tWH1pbJYvt9qCPRW9+uC87jYr5Ky702+k
         AnIyrs+SQfRs/p/9TcI61sYs1h+H/Fsfw++AkiPkMECbrp3cvdsYXqI2VnhX7hkgOGEj
         mD+1RWZQm1044SZN0wrIX9xjwCRD/zU0pUFMP5Gs6Ypw/7ixhIsI0b0kGgurBXqbWMeO
         eC+o04P9a2kRz69dA+KfBCr9OukmHDQDjvSOZdjBIcjV7OxjDDtIWYnbg+PLlF0D+H3m
         4z/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792896538; x=1793501338;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+D4LEQidpEa6OUGGXTLPtwOtKyE7/MIv6b0FECjwB4c=;
        b=H8BwZAohkWMVk90a5nWVcxwz+qf4kQbbi0krJZ7QsIdSvyZHucMFbCh46LO8sGWvD7
         5d2RxvYf2BDXIVWm8V4Ki6ztqnrsEx6PzGrg1j2xSFBp323RJ1IANkkMaMlOrlWnjaPE
         IKWda2V7hwfOeDxL787PniCH0UEkD82GC4fG93zaOiD+U7GdOvl/HcCzB5EKYhck5pnw
         ArnSYPLMT4iU3zypvMs2N4heVwSitnpCm/v59SZfR9voISl6TH0g2ZusYY+t9FQno58O
         BR3Fxc//y5SkV4HmDoVi7i6ZVHHJ7R+9xIgefsFTevubFykWuyg4Pz5gb/UP2f78Wzfz
         7i/w==
X-Forwarded-Encrypted: i=1; AKwUvBxgF4ArULzjbpB3/6goDV5lP49i82zNk3kL5OfgbDK9xuadHBae5rvO0KG7r2iQFuazOBNFWQEfgvsL5Q==@vger.kernel.org
X-Gm-Message-State: AFq9FYLIlQuvlEl10O6VG0aakiREFh/IjklxTmT6Z7dP0fckeLJEl7oj
	AqmqwuR86hogQTj8rlZie62NH4hkhbj/R/0JGrDm3dWJh4gicYltBGyH
X-Gm-Gg: AYBFou18QO6plTw1u9Q7Q5CmdDIJ23m4pf0nLZeilxl0MOXJGSF7CGq+FXJnakEf+pf
	oM/exC2fCksDQEzGtzHUR9RK8k30C/+O+t3UPS0Wjm07C5nY3FRUDLz479BG+JdtW/YPvI4VVRX
	+V/8+kj4QAFgy14i9GQf1RY2kznPkBm0M7equvczMzp1y0TjxGTJ3qIJktqQTFZFWxnYfk4Lo9N
	GubqPLOAXym5LIlH8+m3f7/JYHUpQSuxI3ceMwzA+Ol/2usYwgmL9YbHzxNwiMufT9OF5lG2yDk
	gDjS11KE/eHKJbRyalcgjdf1YnhSZyKpUcSK/CF/Xwqd2TxYWWmE5GvyzEcDbQCO7ibhjaGVw/x
	J6oXZ7QMlVtak+08/x7mzFqPvUg0QDGfn/Ypl/KqXZAaKuXYWT/E2I8VHxf86us2C64WNLu8RnV
	C0m6Q0L/35EA6OXkwlq7WyBF0gNQfsoMcK0QIluyZmzBSOrLsjTL8ueosqHU/DEnq4nEQuxizpF
	RyN+hh4+i+KWNK2uKvGgfh8AEbQW69xOD9nWBliYpe2P+AWup6RXIb+EY5g+UXeMABkyevN+gS7
	To0mZLjJd5GHxBViZn85N4UrqmaR6zoOGGqLam9khgQ=
X-Received: by 2002:a05:701b:2714:b0:19c:dd9b:d09e with SMTP id a92af1059eb24-19cdd9bd124mr1585077c88.23.1792896537822;
        Sat, 24 Oct 2026 19:48:57 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:8fe4:693:7158:24de])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a2e32479sm10521272c88.21.2026.10.24.19.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 19:48:57 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Sat, 24 Oct 2026 19:48:47 -0700
Subject: [PATCH 7/8] platform/x86: x86-android-tablets: use 4-argument
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
Message-Id: <20261024-i2c-smbus-read-block-data-v1-7-19bb97467982@gmail.com>
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

Pass the expected response length and destination buffer directly to
i2c_smbus_read_block_data() in atla10_ec_cmd() instead of copying
through an intermediate buffer.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/platform/x86/x86-android-tablets/vexia_atla10_ec.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/platform/x86/x86-android-tablets/vexia_atla10_ec.c b/drivers/platform/x86/x86-android-tablets/vexia_atla10_ec.c
index 67dba9aa51f6..bbfa040cd4ec 100644
--- a/drivers/platform/x86/x86-android-tablets/vexia_atla10_ec.c
+++ b/drivers/platform/x86/x86-android-tablets/vexia_atla10_ec.c
@@ -65,16 +65,14 @@ struct atla10_ec_data {
 static int atla10_ec_cmd(struct atla10_ec_data *data, u8 cmd, u8 len, u8 *values)
 {
 	struct device *dev = &data->client->dev;
-	u8 buf[I2C_SMBUS_BLOCK_MAX];
 	int ret;
 
-	ret = i2c_smbus_read_block_data(data->client, cmd, buf);
+	ret = i2c_smbus_read_block_data(data->client, cmd, len, values);
 	if (ret != len) {
 		dev_err(dev, "I2C command 0x%02x error: %d\n", cmd, ret);
 		return -EIO;
 	}
 
-	memcpy(values, buf, len);
 	return 0;
 }
 

-- 
2.56.0.257.gf7497c7d27-goog

