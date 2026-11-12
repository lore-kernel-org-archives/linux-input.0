Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794466265;
	b=ZFVpA1fe4nmAYKtUK5xNBZq2ORL46+K+R/UlQTMcxRSN3Ht6u6o7HKcbhQDgENUVMA3t
	 e57AoMfL2Q+dokMgOinl4prdDlFWTHBFUeo6Oe79rGYupJtvO0IUTBcewqL+ILvHsb2Ms
	 KpGkKK1T0lreqfPgB9xIMRmGpmx8/Gv11KQYpGNu/2zZsImJoluoZI3mn/3BBK2LpI0v1
	 2QGE+j4qlwqUc8Sryt/ZA7OXh4/ZwFlg11PlFvc/RjovVw4Z78YT/5MxbQFfkygMjttUF
	 i/WLSeSKqvIBr9bVNOaj8QqT1mPWZAZPBhVDECsfTArKCTmqMyP0XdUZIUBQP2ijQFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794466265;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=6lvU2zDGpTn+1S6znFlJVbEIM8CJDet7iYqjJ+8Ec+w=;
	b=4/CQT6MhEwHGO2oIs6UAGL2qutNdZlzS8RT5MOlmDHEAFbCMeHr1sECEYSELv14F6jwS
	 PTMkgjxLXJ5jqql+02e+JdsxJP7kdaCxqKHj9qROIel7j+d1F4Y+ynnSaqF3xTNwg/Qae
	 tJABzbfUOp8Twgd2IJlYfT+sHMzrw1WNbO7gx5lxjap9RTwVh4vvR+5yewEcvKWPZvIqt
	 ESUd0kXYgwSGip4bPtvqxm+fIvptow8LyXVrOFFUEiFzCqM7/R8s6VBCuD4N8C1pbEYeC
	 ZlU9+uAESOSMDXl+LMjtL0Yrohx1jImiVajC9/DIJjOz6oFWcFy2gg+11OPNk+9APdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ity1023+;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BCF606E91B
	for <linux-input@vger.kernel.org>; Thu, 12 Nov 2026 06:51:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03BCF606E91B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ity1023+
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-36eb1cb7aabso5943894eec.0
        for <linux-input@vger.kernel.org>; Wed, 11 Nov 2026 22:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794466264; x=1795071064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6lvU2zDGpTn+1S6znFlJVbEIM8CJDet7iYqjJ+8Ec+w=;
        b=Ity1023+42ZnCkMfnjvjKZ56iaq6kJJAgdbwJkOMrVTtsxctKdhXNfmZPWebSMZzwN
         72k7zoC23K9Ah/W8P3TDW0/JuI3nYGObHM3HDvwbJ2bDcQj87H1qsM6Tb/ar4HQF/Y5p
         SLCtpi/o7Y3jShW4qDZclAgAwDrpMz+sYlenPn4w+kyoIzOavI2lGsLWKNt3QtrWHusS
         KanIW6ehlVspInU1/G+MXAwOzlUNXWhxYKItnt4Qf8GKTu6V6mczpbb51yBKHivjFU4Q
         lI0s1sRkKCf7MxAscMEbIosT0OIlYW3MMlIb67kVinltLmoIRfDzHTMZsOqNZeW1KfLT
         bHmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794466264; x=1795071064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6lvU2zDGpTn+1S6znFlJVbEIM8CJDet7iYqjJ+8Ec+w=;
        b=dC+EQLDCiWXttsmGxVEXmFjnwKpfWuH6A3ovHZxz3wgB5eYDuciu3hChEF81zw+IG0
         VueSUBiVQkNNz+L3AVxfGWVkquet9LOKzlHhufbLR2WAThtLboHLmeKzDl8jJf8p4JAh
         slfrRUD4D9PPFw6aGlcXlTbtWymX4FOIa/KgCRwB5H3Cvvstj6WQ60GHgExQ/yUjPapD
         WVQNjcosR8NxY7qtvz0cEkMXjTcaYhnyirZgDTK3kXcWB8/oh1OKlQJZ1F2JQFRYyQul
         VV83LcF6XeStrHp1gHJwrMCRfrsT2yFGRuJKWw7oQux8xr/2YsHiDMsUe/SsGucpcsdW
         3SZQ==
X-Forwarded-Encrypted: i=1; AL+hErHVUtXb2YtVrfIVtNo6WbQa11X8RoSLwXDHHWwM48Ko/U36ABylWXzHbqktTcBVU2+SCaFe3fpk4MnOcQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z/lkzmnQGPxX1LrcVo8rqCcUS/oz84vMd1W1W9dgM9Dq65a3fvk
	PbFXw+IsSChJy0oz1Jet5pJRFNl4vOuX2r746VbsEuNcjmIPqWE3n0Oz
X-Gm-Gg: AYBFou332LLA6r7iK6uNt/5DilinGEBd7g4DgeHY/XlDY929hhf5n80XKLA3v5zTDqS
	LSdShtghlzrBoDx+lyCKdKqe2w0MeR9rYLM25wys2X1X0XACVylMM0QDomr4aj8JDjNtA+CxvHQ
	+TgVw/ACnD3hQ6iawbmumZt037kVp46NUXAD0z5fI3HBnnoK8ve+HCv/jlQTSEooI3ayfSaRxaX
	Vgv5MU//SItakedpnd12nD76joovqWRMfpCB//mcHaIcvfoc3PGZIwNJpwYo894ZVdohO1arngd
	LEB53RflSoEXAdpryqYyTN90AVNg3WeXhZr84zY/1cIyFaCI/xYs1Wxv/QCL5wG2r3kUnqZczq4
	vxy7NPO1nwuIHiyJanzoYR4/H4nSeyu2XnhCF8YZfewR0hCFl2kbf+i8UztGoTp78/itnVF3PDx
	psqECW3AUCCvkFVXm6I06rndRARn134RxTpjrAv7+xGK4mVAGDZLjZwgibmsUC4j6v3oRg39psl
	x5m9q1cG0FXuXpL16LTMYsVZ8fmILthvCdwl62MP5ePIFWQKxNWvbsSs6iTPwWIqs3SE79owTL9
	Wux2rIvh6beSdAivOzwzfFkcIUIlJ+2Oh94F+DJwuHJPTrQtnd7jt+yK45H2yw1Om2UtGeYQqNn
	lSTQjI43aBP+b5Iqq
X-Received: by 2002:a05:693c:42db:b0:368:4acb:f8a with SMTP id 5a478bee46e88-37686074abcmr5459037eec.17.1794466264023;
        Wed, 11 Nov 2026 22:51:04 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:182d:659:ffce:39a4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3751fe306casm20788624eec.9.2026.11.11.22.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 22:51:03 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Kim Kyuwon <q1.kim@samsung.com>,
	Evgeniy Dushistov <dushistov@mail.ru>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] Input: max7359_keypad - drop platform data support
Date: Wed, 11 Nov 2026 22:50:57 -0800
Message-ID: <20261112065059.1802480-2-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
In-Reply-To: <20261112065059.1802480-1-dmitry.torokhov@gmail.com>
References: <20261112065059.1802480-1-dmitry.torokhov@gmail.com>
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

There are no in-tree board files or drivers instantiating max7359 via
platform data. Remove platform data support and pass NULL to
matrix_keypad_build_keymap() to rely entirely on device properties.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/keyboard/max7359_keypad.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/input/keyboard/max7359_keypad.c b/drivers/input/keyboard/max7359_keypad.c
index d2b8adcfc9e5..686832fe2931 100644
--- a/drivers/input/keyboard/max7359_keypad.c
+++ b/drivers/input/keyboard/max7359_keypad.c
@@ -157,8 +157,6 @@ static void max7359_initialize(struct i2c_client *client)
 
 static int max7359_probe(struct i2c_client *client)
 {
-	const struct matrix_keymap_data *keymap_data =
-			dev_get_platdata(&client->dev);
 	struct max7359_keypad *keypad;
 	struct input_dev *input_dev;
 	int ret;
@@ -206,7 +204,7 @@ static int max7359_probe(struct i2c_client *client)
 	input_set_capability(input_dev, EV_MSC, MSC_SCAN);
 	input_set_drvdata(input_dev, keypad);
 
-	error = matrix_keypad_build_keymap(keymap_data, NULL,
+	error = matrix_keypad_build_keymap(NULL, NULL,
 					   MAX7359_MAX_KEY_ROWS,
 					   MAX7359_MAX_KEY_COLS,
 					   keypad->keycodes,
-- 
2.56.0.567.gdb80ae8cd5-goog

