Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794380191;
	b=v1rkxDja+HgdIBZU/PAVf9UHlslJ7+QcQjN1krVWEi7sWsumHf5rpQMqPgeusKGjmJ+3
	 I2kWT1TcwoOUmIc4kXjkTwdUvlqRk0YPMvi2H8QTwZ9IcVu+ai04+OSqw4ZgAiujzpJxr
	 bEHtR/5kjK3fARJcsc2/zYF+w1jNmgPafLU2wPs84dHGOCPbFa3jAfQx52EQ0mOc+hQMg
	 Vndab5PCbYzdxsgp48WAT12t9ybVfqxTjkG7Z+jV5hZJZUM0sCrSBg8HwFYQoW0MRBlyT
	 cLuHR/sH+/bZn5sgiueTKKjaEsfVhL3dq0Ujw3+7TPRKz4HEgzMl3jHAl4vvUpuBj7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794380191;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=xOxTVkJvL5fIfalUxaM9jLKgqHystwJOtIasfX34Vd8=;
	b=m38/lPxmC5XOXW1LdynnM/LJmbO0VvqSh7Z+rjKknxWr+izH2DIaFkfAV0W5eLDP9Bp7
	 JTYTxT7Dyud6ZMrLrIIk6kgSM2s7iMP/DjUWXwYYLFRg28Iyhh4oO0+YfBy2BiPsAgYPa
	 KU2jmiofeDCz7/DYDcpSNkvOugXZI0OOvRlQ7Sp+dc5+VpqP36sIyjeiLryXGLi/Hhh2s
	 3xrisml7v7vTSyrTfbhIo67QQNJ+tYDjgEp+NTktaPPacPv+3kSzfj2b/K82uzObiED4b
	 KjlbT4oHFyXL51N6ZrUgR6TUt7IFWy2keY/EI7w0jX5DUNQsBK4r8XR8tYKCznkCXJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WzJwJ5Ym;
	arc=none smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D6B60A380C
	for <linux-input@vger.kernel.org>; Wed, 11 Nov 2026 06:56:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84D6B60A380C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WzJwJ5Ym
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1931ff67a29so4164872c88.1
        for <linux-input@vger.kernel.org>; Tue, 10 Nov 2026 22:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794380191; x=1794984991; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xOxTVkJvL5fIfalUxaM9jLKgqHystwJOtIasfX34Vd8=;
        b=WzJwJ5YmEHZmO6+/lyRDLTkXW+QuTGRlhYXjQyaV25nirrsoTvwkfIhe2hDNer6sL3
         7Km2YxEVLKh/VGXGLN5BBRfAd1Hwa3NCQfB8XM4G62wgBLDq/3V0aH92cH09o1p4LKrw
         wj1xObzxF1MJoEJKMZU5ixh1nEsrzfqs7TVDfuDbu5wrQ1BQbKhR9zWv01L6C4rhIMVc
         4/yevFIWoTPnFsoB26REoJO8kOt50jciNW0hpk9ubC5yCKkLd6xHkDZqGptZ2kpyE/SX
         Rgz9AP9gsfR6q49Y8EoPMgR8fDxtuo51pyyY9H6tnzHrtso0WJiWHZXfbq8PLz9sJIJI
         tFYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794380191; x=1794984991;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xOxTVkJvL5fIfalUxaM9jLKgqHystwJOtIasfX34Vd8=;
        b=zUWWld2DPASsG+tXncJsGuUbXJ0LWvL1eaOvgsPUD55wTu2ziAzkPXCgfvNnXamINM
         ueZBTtGuBcqhK+1/Z7a11V44l1kPg8VKsLOIAx5f9yCogI1ELWoyu722akWm2WG15bD8
         881AfGCKw6AVRKLhoGvT4kvyjd3IwWI6l9E1g1deKYVYxx/YMBplEh4lXlfdoQRSnyQo
         ku24QymTwN9rU1nX3S4LLXu6P5vzehWCy/NB2grL8X25Q5w6629ywnP12O1xQANLPwXG
         s5NETanDsbR2fWg2ruXiagg0VgHsjnDtBS0yDjUaa2PxJLQWJVNOHEpavXKq44+sTOas
         0dQQ==
X-Forwarded-Encrypted: i=1; AL+hErGxzyT7fALNO/eceDqwBscCy5VrHTu2ktBbuEhNwg3lXclcLLpddQSyuI2+0hz9iuW3VVlcChNfO6ffUg==@vger.kernel.org
X-Gm-Message-State: APuU4Z+L8IDkzUuKhxrpC4/eLDRJ76dwkqAJxm2GIdl9rcsrOMcsDhFU
	F9+W25WtMK4CvdJi9kE0tUWu/NRvhqmNfpP3gSilsvmr9oaMFAo8vZIv
X-Gm-Gg: AYBFou1IO+qOikoFW6mKEBlFNbpLIz+K51/S68bq9n3n9vup7Um6ckhQCHVOsiXTeoZ
	OrdVUafZOAnp2Gco1P9FCNvWwoqDcQ7PCl1uw6npPLtiVIq6tALimYFNUsGdxIfAdpKtegD9CS/
	sl38BKrr2P4cZCN7LW0k/B3u8TWI8tTdiFLkqe7EwPJ4yMgyqHjqmcR0PHhG17novquzl9m2udi
	n/baE43+I0zTJXfEUnfKXQy4cs81WAxlf8DBl8Fa/ZaT3R+GhcuUM44Vj5ClGF7DDYnjRi4e1wk
	FCH+V/6ZlezaKxvzr3xIrWYRwqySX1iQq3gRZUAk6txKlXDE618UBAM+XKryjigjuo5eRviHv+o
	nXS7ucKyJw+KHIgG22XFCsBR9FjhbFwypvZtG8BKeCaRZSnPeB8bXaUuGjPwD11+jdQP4e0BFfa
	IgSzniyGYCPBIj9WmGZCPe9kpAf3ynICbwYwifovwHmCb6VjUKuNQTlx3viBFP2oeaMtSZ2Kwjh
	dXH9lSNtlPrtLQKpxWyYtP9BNF3/X4wZovp4Cxd6DNL5JCVbEOcdkd0BMo9IJzIloXSDZ6Fl8qc
	SgAPXaFNcziZ6HQD0EJRG7ENk9TPcf8u6V4VfvnqX7y7Kc9e6sD4qzvNFq/wTSpYmqxSid+R9JA
	BGHbMD13qXz7sieS6lCbbTu6s7XXtowoPcKPSaKM=
X-Received: by 2002:a05:701b:2302:b0:18c:e014:6f1d with SMTP id a92af1059eb24-1b3c024ac28mr1481360c88.1.1794380189133;
        Tue, 10 Nov 2026 22:56:29 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:311a:ad7a:93f8:96c8])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b11435sm13858121c88.4.2026.11.10.22.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 22:56:28 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Tue, 10 Nov 2026 22:48:03 -0800
Subject: [PATCH v2 05/33] HID: logitech-hidpp: do not store ERR_PTR in
 battery->ps
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
Message-Id: <20261110-hid-logitech-hidpp-v2-5-30743e91d83b@gmail.com>
References: <20261110-hid-logitech-hidpp-v2-0-30743e91d83b@gmail.com>
In-Reply-To: <20261110-hid-logitech-hidpp-v2-0-30743e91d83b@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Gideon Heinz <gideonheinz02@gmail.com>
Cc: =?utf-8?q?Filipe_La=C3=ADns?= <lains@riseup.net>, 
 Bastien Nocera <hadess@hadess.net>, Hans de Goede <hansg@kernel.org>, 
 Edwin Velds <e.velds@gmail.com>, 
 Stuart Hayhurst <stuart.a.hayhurst@gmail.com>, 
 Andrey Smirnov <andrew.smirnov@gmail.com>, linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-e56a4

When power supply registration fails, storing the error pointer directly
in the battery supply field leaves it non-NULL. Callers such as the
connect handler and battery event handlers only check for non-NULL
before notifying the power supply core, causing an error-pointer
dereference oops and blocking retries on subsequent reconnect events.

Capture the registered power supply pointer in a local variable and
publish it to device state only after registration and sysfs linking
succeed.

Fixes: a52ec107fa81 ("HID: logitech-hidpp: create the battery for all types of HID++ devices")
Tested-by: Gideon Heinz <gideonheinz02@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 0e1a9fd98faf..6ac41b7d76ee 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -4333,6 +4333,7 @@ static int hidpp_initialize_battery(struct hidpp_device *hidpp)
 	struct power_supply_desc *desc = &hidpp->battery.desc;
 	enum power_supply_property *battery_props;
 	struct hidpp_battery *battery;
+	struct power_supply *ps;
 	unsigned int num_battery_props;
 	unsigned long n;
 	int ret;
@@ -4413,15 +4414,16 @@ static int hidpp_initialize_battery(struct hidpp_device *hidpp)
 	desc->type = POWER_SUPPLY_TYPE_BATTERY;
 	desc->use_for_apm = 0;
 
-	battery->ps = devm_power_supply_register(&hidpp->hid_dev->dev,
-						 &battery->desc,
-						 &cfg);
-	if (IS_ERR(battery->ps))
-		return PTR_ERR(battery->ps);
+	ps = devm_power_supply_register(&hidpp->hid_dev->dev,
+					&battery->desc,
+					&cfg);
+	if (IS_ERR(ps))
+		return PTR_ERR(ps);
 
-	power_supply_powers(battery->ps, &hidpp->hid_dev->dev);
+	power_supply_powers(ps, &hidpp->hid_dev->dev);
+	battery->ps = ps;
 
-	return ret;
+	return 0;
 }
 
 /* Get name + serial for USB and Bluetooth HID++ devices */

-- 
2.56.0.542.g3ef89b7020-goog

