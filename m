Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795164067;
	b=rlkidLjXaKNA6/RdZWKEWh7AuWc6eQZu2YIfE9C4Via8X8J66Oetgwi/GdNHZ6uloyJh
	 LeLkwAxXqi8dn/sQ7MXaigwryTNqxYxCjkMx99WSdh9SMuBc6HJWq6V0j5aphilzPEqPJ
	 YWEK+3lu0nhJbIiVMF/h/KyTgkJ6cuMeVIwpVMLbIryZdsCJiiOrwrApo94VqVYr29B8w
	 64pn9eIJhO2GitNIjrkUwTD5vaSTq+n4FS/6KXUSweU9+Q1wY1y8yZBVlxnaONfwt3yIi
	 NJf3y59ZlR9dkAH8TMjMC2YS4IHTTWDBWnrtoeXBROLIICunVhbgCjguXZaSJzQNLnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795164067;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=3EGbLc76XrKp/CthZWQqfcemDv7vxiole5kdBmE56sw=;
	b=Oweu3JGRcQ9AukZViNJiLghreOUjnagtELe7ahrbdM/fI1KUK9j02sYMz6Iawoinz4vS
	 uI/g9mA9d3gNklWi1NPMBP5MPh+erEocGro2WAkrBMj3jsw0YZtf7+p3z8BU9ZYUuaQ5O
	 45r7WGnkLYyo++C0c4mXrKsngEiWn/hJ0QOM2yn4C7SE49Hze8ev3wpkyB7O1wgsecUp1
	 8MfxQ8072fxJK7/9dwL1v1aW/UUhqw4wLpk/ARakTehPu4UXl19bQGyU3BHOAtjqyItZ5
	 iIDC0Su7Me7r8vkiPcJ8HI8D101AjfScEdlxzP8VxNCBUFz+jhzGH51gYKKKqwQzCBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kM5EbDcV;
	arc=none smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1187A606A33C
	for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 08:41:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1187A606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kM5EbDcV
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1a2761c69fbso1411834c88.0
        for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 00:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795164065; x=1795768865; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3EGbLc76XrKp/CthZWQqfcemDv7vxiole5kdBmE56sw=;
        b=kM5EbDcVcZMLd7lIvskBnnQ3pIxZwJ5CBHjmuAiFJgxGvi83QxL4RBozep8LuN4n0z
         dwpzTYHj8xhU1tJzP3UKQC9sxKlAEhP2UI3LgBzqHUo5XPc8NWxib1c4Ip1QjkYbKGX7
         k65pQEJ9ocDn9XUN+yyqzpQ261Ss/hosesm5G/HSVzc1pjy0Ay050LozP0C2DAm5xqxp
         74CXQX3uICrJK1w1aqKehM9SYGb0/wvzDI2DCnXlfIeUtSfHWaSOa3bSeQxu2nAw3dDT
         mMi1YhHqvRs5uQglsLHmSQzNmNEKbzgCUcph2gvaZ5ldtjDjMW+ftDLxd4TB0n4swD0p
         /Eng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795164065; x=1795768865;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3EGbLc76XrKp/CthZWQqfcemDv7vxiole5kdBmE56sw=;
        b=Ia7srCixsbJ7qNi/q616iLKrD7sk8qqf0q5elMyVnjEXubXBLoIM5jisBkWhACRawG
         6uPxdMDAiUgRQ0BHGomeveKxQ8XNqrT5cJ+nLe9UH6H8/YzsUdj0HGdyEeodFPRt9fOB
         IRWmxWUenKSt8KK9W0np5YM9LDvlyxun6xvQgkzeSfNt6VbTktPzkqBI2cZxLWtvy72M
         HY2CChf2TG2Eod06IsRPPERLt5GIZOEE4YsB0g0fRkN4dJptKLS30pNOEOt8rkmVRPf/
         0m4fnmJkzSOvt/NxaAo49/9yWamUEpwDBcqX5w6m/Go2q72hnPkG2RLdNsg6Y1xit5dn
         W1+g==
X-Forwarded-Encrypted: i=1; AL+hErEEJd+lnf+1BYYhmId54zrmydgfRiFIa7+WeB2z4wj/oieQyWlvBYwx0Ll7O71JMthbqaqbMWObetqNNA==@vger.kernel.org
X-Gm-Message-State: APuU4Z9vMWjh9IAjUdOUD5uZG0oVgKaKj09jOJabb90ke3O2krxl1wZC
	I6oMwBn1W0Lwre2z0YN2BGaWfCcYDU5Dt4PQcZ2DVp5Ni0s0ZiTktf3k
X-Gm-Gg: AZFdTZfLk/x7QArBF/EHr/QVNiHQf01vrHS4I4Yi8pwWiL+4bVNmZ6fT5fQSnbfbV0v
	NPm2564esPs1pI1/y1Scmt3lMe4igGKojcjBwm78w6yIk3ujAZwLWNM233x1xIAKK4L7zfHFvMi
	p2kJEXzJO6T4oT5tIqZO9afxP7AADTJTRSUcExwV8F+jHAmNDrJTpvpJdZCTXNm+pNmkBc5yAYw
	B1gRi8GE3hiiv3Ik9wOPwkMV2Rx81xbZgrzYD4DuUF2lOeIPRtX2dtgx5xqORTnTzYEMQZXXxjQ
	xr3XHyMZINoX00o6tEV+Z4feb4QjoGDgKxSvxNiH95wV9scOV2dlXXmuYfsGb9jwe1+7zBPbWIT
	w7U4SO+wKcbbWR6grTWTUKeUgORC5pwzOXfonZxgbJVRiIJmGGLlAiM3zhWggogJY4bQxn0y+Qw
	liplacP6EESO8S3jb2wKjfzT/O71xT06ceW7w65RhEIp/To8nIBYQ9MGM4MNTadmM/ExrWrkZ5i
	Upt3dxZUkEPAu9Lh8QtTMizmKAsLWspd6KhJ1R/Lvv9Ve126t9c0IFJQwZ/J4N/eVV38xmSePoD
	7hW+8IsryfxiJjlBs6zI1Y8kZpI/h+G1N6YcjlCjjvPbgbJYl1bTgE9KbGTIg/Jl4pyeu9NAPOY
	c0yveaimzgrn3VN0nxg==
X-Received: by 2002:a05:693c:87cc:20b0:358:3426:d601 with SMTP id 5a478bee46e88-3856c0d0961mr2156455eec.2.1795164065159;
        Fri, 20 Nov 2026 00:41:05 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:ea97:e47d:2ebc:210c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385677c371esm5793181eec.23.2026.11.20.00.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 00:41:04 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 20 Nov 2026 00:40:53 -0800
Subject: [PATCH v3 05/14] HID: logitech-hidpp: do not store ERR_PTR in
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
Message-Id: <20261120-hid-logitech-hidpp-v3-5-cfe2caa1d0eb@gmail.com>
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
2.56.1.750.gf70dc682cf-goog

