Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794204676;
	b=GBZJSK46OVwLWzHGwgMvHLognKO9/wNo9kO7DmyBeXslIjlt6AC3NTNgt3kMDTAsMaVR
	 Oaas1ggUdoRU5CYKqp5mkhS8vqY60ebNE443UZDPUGRCTR4rGJ/29o5nof7EpR+iMur/S
	 m561XOaeJFvVgHwmMbP46wE6LC19DLIV7VoXOsJfMuknpZUptDjLhRFA53lvmFVq29wCr
	 Ov6SWxkmKmkbd0cI5tfHvLHHIsB4xtSTy2xUlzewkx6c16IesZJ6H3GHh0B8CBGZOQ2SM
	 8xQGoC6JvC4Tgsvwn70IZPELYySiMTl6L5SY41x0Pvr9tia3YjevitjFelMX3m4Gqvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794204676;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=gRO41KkPTWNlu6Ttf4a7LMDPUy2i6YOIbXNUx5+ygKg=;
	b=xQvtOCKxJYL6gHBnMoaq6Ken5ZNhbyV4UgbrfSIuKrmwVOOIx/1ARGNwJDSX/PAYbirr
	 44Wg9s9chvizlsBOkqeSd3lZ0tgQXxfIGswkZRXmcdmct/ymmYkROLu44ACDmceuu2fHl
	 EGIKiaPHb+/wGz73V9C/DH8CO/+wHUAJb98JVBZ45G1tXO1/SqQ0Zt481reIDQXc77KmC
	 0Nb6XnsL1OZ2QAkM7qMjOfnjdgSsslgH2oTLBsAk0hX8GaRzOjeDHJy4yGrm/Cl5TTC+6
	 +SaLFJZmY1ugbvtcbXdEfUt5tFKSC6NH7e4cEV+uysWttBg0br45GA/sEJytwLoHK4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=s78dRQHK;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508B3606D811
	for <linux-input@vger.kernel.org>; Mon,  9 Nov 2026 06:11:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 508B3606D811
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=s78dRQHK
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-36eb1cb7aabso780827eec.0
        for <linux-input@vger.kernel.org>; Sun, 08 Nov 2026 22:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794204675; x=1794809475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gRO41KkPTWNlu6Ttf4a7LMDPUy2i6YOIbXNUx5+ygKg=;
        b=s78dRQHKrmGkbkFTEGhJa1F7eP8rMbI5fU+ouoXkgaEJKTNID9Ltx7lleGGcQfz1Hr
         lNEYRrkWukUStXb6nCVOzsk4Ug7wkf7D7nWxfCZTt6H+RR3RAbVfEm3lR4yvEQ/HHpcB
         TZH5vOqyvv2OQoC7NGEEhQ5F5U3dzslZCQMK+f90XhvbOxgPdKUV2fTSJ0k1DaraO1TA
         kzI3XJCj5C6Bu9CGpxX0DklMj/L4nMLkT6IOXjedx5Zk1DhW1qSUUnuDZybmXBsQmNCB
         r/vOQF1THKWLJsC2Et2H1fcP5JqHnGRF65dAbzYrOEdn6IlwyModH9Qx3LftIY4UxtwQ
         DOsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794204675; x=1794809475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gRO41KkPTWNlu6Ttf4a7LMDPUy2i6YOIbXNUx5+ygKg=;
        b=1q5FwZkFVHqZyjh16BpDsran7PO1g/Rve/MnpYvq3MITkF/rZZjc1RSvQMJnlBp2E7
         UEFMmhFSs1qP8C2N6S6JVuTVtXPXH9RTCdb1Hty68QxSl6H8nznBzTT90zrITvpkLkHp
         EX1Jb6yRVQejitieBruSrw194+bQGRrM+voSBlHUSSILh/oytQnbLbYV+VX3i/awjC5I
         mMzNVmOv8ITszgyYiVQlPtzbKWt2+mBV81YPtSyS1SbPvWi2VIhHZqvp6mkbm/rX2mBd
         jbKwrYXchLj/jOX9+AdhZCJSTVRdfKXbw7/5g+PphR1xktLofWVU/bJtP2JReGAFeI8K
         vkSw==
X-Forwarded-Encrypted: i=1; AL+hErFQpUe5qUQl/C9L+vz8BdW/4OS0uSJHrpTI5w7RV2qEOSuW6JoJ02e/0r7sr96qHK/n5kXr0CasmU9xog==@vger.kernel.org
X-Gm-Message-State: APuU4Z/hfOOL0RrEe4kWZwuG+TIxs2iURkXuKWK24F61Qe+RPcMBmXLj
	Qd9Q7pUY8yrXcWjJao2C5ApDy4o74UShD6NWVzlq7rIitbrKrz3uRqjn
X-Gm-Gg: AYBFou2Yq+TD63G1+e4cFxgwJPWOgJTrglhUb0idpIbW9hnlkG8tBsd6F2eSQcgmO2F
	C3nii31lyGLA7biGaNWn8p3RBrPB4hD5gg3ALcU+yEPortMG4kaO7+aKd5EVQfjiluFT6KoPSrD
	uWOcR6EkVns5NG3wki2hs0hgDGhVEpHnYi1kp172OCinBzeh+AkaIis0NYqbTR50VXzVgSHonTi
	j3mEpA/1LbMt+s7ux3tKWJaeaUz9gC0r5IQE3dH/CAGNUTmsHMBvgp5J53ZBIxeA8V7lyWIZ1+0
	+bMwW0+LcsgDdLwp7BAcjRrVW9BGMDgxGoIYij6rLNLbtECqn9U9atZ1NsSdhiLZAzyIp1baZUX
	LmVmBSSrq52WvQfppiQwR+V5/BbMX/lZhVCrzCI9K65wcwF64L9dkHeYBn/xmzcWqTjrGSri6D5
	Xkw8H2uaX5uIdt+1TpptXtXNZRtprbQBLyc2txMtB33dbGvM6YaXtO7XpSkVjQX7Jz9rKF8+hKX
	x3i9ISL5k6c08eUqA9versXb71aFETRz72X10rCLPanhmnsKi82KtYu16upiSgYkS3/i85T6omG
	l08lrKJmdxg6t8NW81mY9+n3EEtBUgRJQWh+5FlXxQp7YH8l2yg3nzHrdyVOj1AWvB+ZH6kvPoT
	o1PpkDc9zgeW3OxuH
X-Received: by 2002:a05:693c:42dc:b0:36f:4981:da16 with SMTP id 5a478bee46e88-37255a514c7mr6461633eec.25.1794204675440;
        Sun, 08 Nov 2026 22:11:15 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:3588:b56:78bf:db5e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-372661ede11sm12201192eec.21.2026.11.08.22.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 22:11:14 -0800 (PST)
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
Subject: [PATCH 05/18] HID: logitech-hidpp: do not store ERR_PTR in battery->ps
Date: Sun,  8 Nov 2026 22:10:49 -0800
Message-ID: <20261109061103.2887636-6-dmitry.torokhov@gmail.com>
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

When power supply registration fails, storing the error pointer directly
in the battery supply field leaves it non-NULL. Callers such as the
connect handler and battery event handlers only check for non-NULL
before notifying the power supply core, causing an error-pointer
dereference oops and blocking retries on subsequent reconnect events.

Capture the registered power supply pointer in a local variable and
publish it to device state only after registration and sysfs linking
succeed.

Fixes: a52ec107fa81 ("HID: logitech-hidpp: create the battery for all types of HID++ devices")
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 4e0758cdae64..9f3ae8724dd2 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -4327,6 +4327,7 @@ static int hidpp_initialize_battery(struct hidpp_device *hidpp)
 	struct power_supply_desc *desc = &hidpp->battery.desc;
 	enum power_supply_property *battery_props;
 	struct hidpp_battery *battery;
+	struct power_supply *ps;
 	unsigned int num_battery_props;
 	unsigned long n;
 	int ret;
@@ -4407,15 +4408,16 @@ static int hidpp_initialize_battery(struct hidpp_device *hidpp)
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
2.56.0.506.g506a7eabc5-goog

