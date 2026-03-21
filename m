Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F162BEFFE
	for <linux-input@vger.kernel.org>; Sat, 21 Mar 2026 20:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774124774; cv=none; b=qrUtBwIbZAzywS30JTprA2N3bbtw/+O/9X3okRbeRJ3r+ZtowgKLdLjgH+DciUlUqvve5i5yYcIf4bvZbuIIVbrYdgYe9OkMjgaUG6RF+u2CuDF3DxN5179M0/Zdzngix96U9ZettInSck1x5/IAygaS0kn909ZGLsawBysz6WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774124774; c=relaxed/simple;
	bh=t4iTwfSbP9CDr6QHSr/r6bwsNo7DCFcSSmYQhYBQhGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ryQZeiUQlDvgVWAG+vdHf573hxwnbGiQOpBh9ixB03EBwWHZpIwS1QVeqRFgfiYugRlnLFJZjdgWjV2MtMebxRNt0WpaQIL0TqcCIEidWfPZ9IXARUGLKJNHPt2iE2+jh/15XLNz6ukwN0UqUklYNzdkyIzZjzPtqcBbi7fjwaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d7a27cpE; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d7a27cpE"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-56a857578a8so607972e0c.3
        for <linux-input@vger.kernel.org>; Sat, 21 Mar 2026 13:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774124772; x=1774729572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2D90xvcAA0cYxqSav09Tazhs8VainBkG84YypcNOQbY=;
        b=d7a27cpEbBwVLjnfingo/ki9ASUHTKVswX07ny6OgcXEi/wyyYaWWQXalr+kHuGlch
         CIKH6zJHXCEbXxnOXhJEBEzZiCGTEyUYtvZDxQH2CuPs12A/cWxZMzchXtTj9zFjXfGq
         ydxKtLXm+ekO3BhiJAYtQL+hGq0E1vKL99DhieRqUtj1HykRHTa9umLUsTkzNL5q3uvD
         Shh66MalIJBGn5crmMzR4RJO56YgsSKr3vlQLwratnm4SKXZ/1ykGA01RNRh+aGFhQW4
         P/5fDYgf1+ENRuMVF6IyxdGfSD3zBmHr5+O4eZrJX03OEnZpsLQEay1E92jgKFVVMJnr
         7C7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774124772; x=1774729572;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2D90xvcAA0cYxqSav09Tazhs8VainBkG84YypcNOQbY=;
        b=nTwQM5OnHd57gT93u59N8dXKpEgESOuJWprKA4b06xG8AJm1bfffE6gWkZQ2w4DeEh
         jh8MyptdsyCjZ1Cv6u6Doq1YqqrL5MSkbu7R3E/eleQLqhmmyb1Yrh2qkA1FY48HheKz
         O8IbyAFa/aeGFwNkTuvIkPhbSIzGi7dym6gsaPl0THXhbhwGJHsFfzoPgbPF8yFP3s/n
         M4iTt3RsObaIBLR2ehGheJdPf/pwva2cmf6R/5PJKioyBjvVRg5NZmnxh0kZkBrYovGB
         o+6jKax841Nhm0BFFTiorAnIqGFyUlIg3YrO+EIapQRfFwwHjHSatTVLn5on6RSWoEWm
         sXeA==
X-Forwarded-Encrypted: i=1; AJvYcCXDmqAqNaghuH7uqFLd3TTHNNiTnWmJK5g6PCFVqEhBJ86vJy/LTmCmDTKskYmnVKx5Ws2HoDheuzg7mQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyCpGmLpPeLE0xcpqHY7T402vNu6ipTYBRQX6+oZMBJ/h0Vwwiq
	zHymqRQxGoOLRamjvc1dlsZI3iKyUnQ85Wgbagk3VQnFJ8dmVWPINDs3
X-Gm-Gg: ATEYQzz53JW4Pc3EMZzyJLklhek8XDVoS8cztNAxVEFF7IIja0GfPqRFRiHx5Ayp4WT
	JbiwnGVQ8gzf2DsABIJHIu4HahBCsSn+CYY0AWj3b+dflPj0CiURL06O91H2BdfzXh98qIifRPx
	i/YEppJ6/pOhPRXre7u6HivI+dYBfvUpyuaDDPZUR1z+1LVhG1hdw9HZrkFVtQutnO8Cc73GOfi
	gZn9rOJ+gT2mhhI3ofwmF1CQ1GX7UgUDsGqKLro8UI6Q6UZCZjKudlqzUlTUHP9h7SswABhMJBC
	0lH+paPFfqTa9SjVu8LCxub/C/gobxxcd1kTPluG27k1BDnk6h1BsbGhHfSQLiI0kThNGNuRbxy
	D1NoKehUqKpgHwA+i9s4vaFgadeU3lUFyQD8gMLvnojUaVzd4emLaoFk3uqXntGVs/2hnjb+BuK
	So37OsPWIBcgCswllI57fdlAcR9ZutscBpDw==
X-Received: by 2002:a05:6102:8099:b0:5ff:c794:96b1 with SMTP id ada2fe7eead31-602ae78f43fmr3443168137.0.1774124771975;
        Sat, 21 Mar 2026 13:26:11 -0700 (PDT)
Received: from charlesdias.. ([191.22.16.211])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-95136de53d9sm4144378241.8.2026.03.21.13.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 13:26:11 -0700 (PDT)
From: charles.embedded@gmail.com
To: Anshul Dalal <anshulusr@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>,
	Brigham Campbell <me@brighamcampbell.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Charles Dias <charlesdias.cd@outlook.com>
Subject: [PATCH 1/3] Input: adafruit-seesaw - switch to using dev_err_probe()
Date: Sat, 21 Mar 2026 17:24:44 -0300
Message-ID: <20260321202446.724277-2-charles.embedded@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260321202446.724277-1-charles.embedded@gmail.com>
References: <20260321202446.724277-1-charles.embedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Charles Dias <charlesdias.cd@outlook.com>

Use dev_err_probe() instead of dev_err() in seesaw_probe function
to improve error handling.

Signed-off-by: Charles Dias <charlesdias.cd@outlook.com>
---
 drivers/input/joystick/adafruit-seesaw.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/input/joystick/adafruit-seesaw.c b/drivers/input/joystick/adafruit-seesaw.c
index c248c15b849d..177b42446e9b 100644
--- a/drivers/input/joystick/adafruit-seesaw.c
+++ b/drivers/input/joystick/adafruit-seesaw.c
@@ -277,17 +277,12 @@ static int seesaw_probe(struct i2c_client *client)
 			     SEESAW_JOYSTICK_FUZZ, SEESAW_JOYSTICK_FLAT);
 
 	err = sparse_keymap_setup(seesaw->input_dev, seesaw_buttons_new, NULL);
-	if (err) {
-		dev_err(&client->dev,
-			"failed to set up input device keymap: %d\n", err);
-		return err;
-	}
+	if (err)
+		return dev_err_probe(&client->dev, err, "failed to set up input device keymap\n");
 
 	err = input_setup_polling(seesaw->input_dev, seesaw_poll);
-	if (err) {
-		dev_err(&client->dev, "failed to set up polling: %d\n", err);
-		return err;
-	}
+	if (err)
+		return dev_err_probe(&client->dev, err, "failed to set up polling\n");
 
 	input_set_poll_interval(seesaw->input_dev,
 				SEESAW_GAMEPAD_POLL_INTERVAL_MS);
@@ -295,10 +290,8 @@ static int seesaw_probe(struct i2c_client *client)
 	input_set_min_poll_interval(seesaw->input_dev, SEESAW_GAMEPAD_POLL_MIN);
 
 	err = input_register_device(seesaw->input_dev);
-	if (err) {
-		dev_err(&client->dev, "failed to register joystick: %d\n", err);
-		return err;
-	}
+	if (err)
+		return dev_err_probe(&client->dev, err, "failed to register joystick\n");
 
 	return 0;
 }
