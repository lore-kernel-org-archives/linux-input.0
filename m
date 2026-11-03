Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793681239;
	b=MJtsnEeCGLgI58eTkOegCERcYmuaZBx8BbK35wgY06qOo7Q514f3IlqENFSHTFX2Rlr3
	 KPwHGzg1yjTDs9zzcspvjYNWWzTgkkomZLSRhg49zLj1kI5m/MScUi/+jxbWYclP5pyaC
	 jvYQEs4mpHU09ecu/303XwyzzpKEllqJOFUMp9/OgdbSuk+8/lJviTLuO6beGB9LvEF2i
	 mL+Yf5RB9fdi68RBADRLAkzeQ2MxGPV5XKSw0eFH9rHQAW4PqwM9/bssRKCevNSSQexd6
	 G/aVuAAcQ7Mh5UcFB4xQkOrOJo+VAMXxxMUbraJC2pi33ig9OmMueRze6JVZsXAiM8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793681239;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=wLXXZycCt3p1k/CBuHJtwLDAq2dYHgMI6sCWUancyIk=;
	b=YkyJFaHoY7TBajtsjn7jNDJo76tmTMLU0XLR1r0DovikCbbbOFjeJeFTINWZ0rIIzNRn
	 SV2hLsE4qerprpSBr7U9GhdhzC0uimzP7vi3/MKgbTXVVnZs99dQ55nX//dWxH2GxBfiB
	 ps5Om0H+UIpSPVMzWFJ2HEccmS/+qupn2hHlCr9t43sQ1/SF4AuFW75jGEp1Fc677VzpX
	 0pNPanXTPNQAKsOPshUHXi9JZ6hjoGpi0HdnadE0ijRHVKOuB7skQIHK74/j9bV1OazR5
	 aXprUw3IqzPQa8kKT2wJ9lTgRgMseUH8EJ2CLofCPJQiJkXJr8Io7Nn3PqyvdNLMteA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZOWGSWfA;
	arc=none smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA38606A334
	for <linux-input@vger.kernel.org>; Tue,  3 Nov 2026 04:47:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1CA38606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZOWGSWfA
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-15943c9c005so2315857c88.1
        for <linux-input@vger.kernel.org>; Mon, 02 Nov 2026 20:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793681238; x=1794286038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wLXXZycCt3p1k/CBuHJtwLDAq2dYHgMI6sCWUancyIk=;
        b=ZOWGSWfAclSa8zINRI3U3lDJk40HHbzkmar0Yp9slLEkySRr4M9aMpRJ2dLP6J/hsD
         aEBozoTX+O7/9+y+XVzMqa8xBIxom0bQ5yN7T22FMD42i/zSWbzG9ZDQ9QWuE1DK0NQ1
         x3hllPuB+GFNHP9M2UJtuyW2jYLkr24GvUcrfIEWhaiEoFjhRE417rFkVp7RnCsy54fA
         cg64q6nW9K7AqiOewOjrRFAr4VKU6NcAxGndrcrRGcvaUpqBxTZwg1DjxcgyUFisZ9zC
         l8QtuzWQV9zdqdxo/jEkHAGs5ukBATHZ309rT7Y8+xHa7IwukyedOhH4+ngx61scAWi2
         6GCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793681238; x=1794286038;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wLXXZycCt3p1k/CBuHJtwLDAq2dYHgMI6sCWUancyIk=;
        b=Chau1nGJ03J3XuwZ74rbbjZNDV8QvrUnIi6PQy4erBjU8CUkw6cp1EASmD/hCclbZv
         UZAu7MHndxLhxh7pFiE1VBsAfPvvTZuvqCxnzCNkIFPAnZ7RiFBQG5Co+8v5Y1A3H5C8
         BIdFjhQ9EFeRhcVG/rzOw4LovCecbKGrVJi0F28X47nsdWLhGogfoN7pTNUQJtkoU/zP
         hGs4LnoOaePBl/kWv/m3dJ6B8aIrSx3VtLMNXRolJyQUdVvNj0ZfAlAybmgtFoomaU6H
         sdgYdLBl2ED7nG6gNBD7sf1+a21XQKdrxYyc8RVNTqvzvfur1La9xCJZTwcOlMhZjqIg
         hLhQ==
X-Forwarded-Encrypted: i=1; AKwUvBweYualTRX20lZap9NVeLfrQilAhyUQggzl6QGgRJwqVoAHFqTfqEdN7wvJl5if5I4WCiWk5TuRKn7b3A==@vger.kernel.org
X-Gm-Message-State: AFq9FYKpjU98XCOx+ppG0qpv5xPi8N2PIa8Lqya23Raxr7+o6Wa4PKtZ
	Wr1Noj4I2XC4U+4ReopbS5ztt5EYai1vcn/UNTGmA5Scos6XY371aPo4
X-Gm-Gg: AYBFou1StfBJaP4jfaXSoOHoWxG2ZybrCrI8pXvctDXftdAp8p5hYxp0rSQIthMEKHF
	A/9eRkIFxT2DC7QUjhqtzi6bevWIti47p5eECcyc7QsExjwGvTkoRsxeTqHexBT3Z7Riv4naiKM
	PittW9GgbxArd8x0gRrN+lMdKOOujtsHTgI/WHRJCXw8wFOdLyt8vbBRH3CKKzCZGXSuxgmNPHr
	bmU8twijSPPZdFg72ZJnfaCRBesSJLpDTCmVHBXsgr9CtBmf1XjbWdTo5FSExteZob27VCkDsB2
	AQC82kCZrabQF0aWsnjlUbR/tMjKXkMG/2PwHw2TYnmKfwVutoFkvVOqbDWrT67mgOp6wTUL8nk
	GTdcyc5JqUJpNPcuz+p7v8g/SeAogEUyMPv5ey2DrHOW2Xdt3/7LIrS59P45z4LxSOt3+qpAaD4
	MqWB/ZXxso/LY35hhMJA8mXH86n6crHEX/rmjwIOosdXyj2mFsrCWlcY18TMHt7JwSzxC45MNLH
	uguPCCM4JLzfgrNnvcfGRjTOJ1iMa8J2jnlO0Loc0Z2XKAw+gfQKyZx5KwHUINHmzluSVCeecgJ
	iuk0kyNEnp3nY1fR86USdl3OHTJ9wFWMnH9JpXnGAFTT7XEiL0wrE71+BjjugO5NBVF1FTBkhGu
	3cWAhRp7WVG8oMYvR
X-Received: by 2002:a05:701b:4208:10b0:1a3:116:848a with SMTP id a92af1059eb24-1ac5de5424dmr17866007c88.35.1793681237912;
        Mon, 02 Nov 2026 20:47:17 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:98f:6bcd:858b:7a64])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42902649sm48385807eec.11.2026.11.02.20.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 20:47:17 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Hans de Goede <hansg@kernel.org>,
	David Heidelberg <david@ixit.cz>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Val Packett <val@packett.cool>,
	Hendrik Noack <hendrik-noack@gmx.de>,
	Ferass El Hafidi <funderscore@postmarketos.org>,
	Sasha Finkelstein <fnkl.kernel@gmail.com>,
	Jeff LaBundy <jeff@labundy.com>,
	linux-input@vger.kernel.org,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] Input: goodix-berlin - set default resolution before parsing properties
Date: Mon,  2 Nov 2026 20:47:06 -0800
Message-ID: <20261103044708.2461481-4-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
In-Reply-To: <20261103044708.2461481-1-dmitry.torokhov@gmail.com>
References: <20261103044708.2461481-1-dmitry.torokhov@gmail.com>
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

goodix_berlin_input_dev_config() currently configures the default
10 units/mm resolution on ABS_MT_POSITION_X and ABS_MT_POSITION_Y after
calling touchscreen_parse_properties(). This unconditionally overwrites
any axis resolution calculated by touchscreen_parse_properties() from
touchscreen-x-mm and touchscreen-y-mm device properties.

Set the default resolution before calling touchscreen_parse_properties()
so the default resolution remains in place when physical dimensions are
not specified, while allowing touchscreen-x-mm and touchscreen-y-mm to
override it when present.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/goodix_berlin_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/goodix_berlin_core.c b/drivers/input/touchscreen/goodix_berlin_core.c
index b0938a4f3fec..5cf453427eeb 100644
--- a/drivers/input/touchscreen/goodix_berlin_core.c
+++ b/drivers/input/touchscreen/goodix_berlin_core.c
@@ -626,8 +626,6 @@ static int goodix_berlin_input_dev_config(struct goodix_berlin_core *cd,
 			     0, SZ_64K - 1, 0, 0);
 	input_set_abs_params(cd->input_dev, ABS_MT_TOUCH_MAJOR, 0, 255, 0, 0);
 
-	touchscreen_parse_properties(cd->input_dev, true, &cd->props);
-
 	/*
 	 * The resolution of these touchscreens is about 10 units/mm, the actual
 	 * resolution does not matter much since we set INPUT_PROP_DIRECT.
@@ -636,6 +634,8 @@ static int goodix_berlin_input_dev_config(struct goodix_berlin_core *cd,
 	input_abs_set_res(cd->input_dev, ABS_MT_POSITION_X, 10);
 	input_abs_set_res(cd->input_dev, ABS_MT_POSITION_Y, 10);
 
+	touchscreen_parse_properties(cd->input_dev, true, &cd->props);
+
 	error = input_mt_init_slots(cd->input_dev, GOODIX_BERLIN_MAX_TOUCH,
 				    INPUT_MT_DIRECT | INPUT_MT_DROP_UNUSED);
 	if (error)
-- 
2.56.0.385.gac671c819a-goog

