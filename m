Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEA2391E4C
	for <linux-input@vger.kernel.org>; Sat, 22 Aug 2026 21:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787434856; cv=none; b=Lzdc1jNFccWWi2I4x9WVO51yNhhLUzV5wH07YcMYTW6bCWno/105XJ/58kG4Fscj/w/6cVw1P9fcdov6LfM1J/pnLOM5PimFrN2nnrGgKn7FA3ZsCXdjB+xpzz+QFAuS7UXGXWjCfbfZSSznBMItzVJfk+u59pSxul0qzV/fhLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787434856; c=relaxed/simple;
	bh=nUNbmShuRQtFklLJUC7OALhPN/3USFry3dwtYtcWKow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TA8Jv7HZLtv4cMtaTdO2Iun3pv+XR7lXOBRMiE7dp/Ld/j/pQTTAL6Blh/3rzP1ScFa9MBQ5KGliTabx7fnlKoBXSBAd83qYg536fW+fdMTr7S0p6Ny59U/waO7HEybJSzYsNeP02vRbdlcYEcxs3SVIieIzH2DqADH9AD24pJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kBWjGRVQ; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kBWjGRVQ"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c197e7e4e94so394807766b.2
        for <linux-input@vger.kernel.org>; Sat, 22 Aug 2026 14:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787434846; x=1788039646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JMqBfKwQvAfQXaOYyEjha8jlIKlrCWyN6q7aDWdtxQg=;
        b=kBWjGRVQ5Tsqfej/Q/PXV0Qkvw43nVbNz2LERrDYIddPeRUnUwsv04llgVcbZWUqwP
         pjmMz2vR160XZ+WiWza1RyxZ4znOblNF6KZw0sPU3zoog8Tx3iJkw9x/GAdp0bFDSsKH
         pSaRx9jjghROZ5YguUPn4hfrj8aymIOYGTqyHz9kYyrVomSrHPJIEmmbN3yYhYCHNIxp
         IUEnSbQOuJF4+IK6DO+BwFP8MaI8IEYYri+GxJfwMfIDqw7cb1nZmmz9ehXnnIzwLDXn
         aZ+J1+70mXCfzIG4u9eRfxyY3eXJAr9s/nvgbhcEG/AwHaCXNsf6elrcDhG0RN669zH4
         +Byw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787434846; x=1788039646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JMqBfKwQvAfQXaOYyEjha8jlIKlrCWyN6q7aDWdtxQg=;
        b=Q99UJrouCFzkRIEjPX4Ii6l8DFz4GjeE6VWWbG4Vlzzt3oMUaFWLO+7PwzSxWxU8BZ
         nDPj/6IPXfiXlc2Q0BeVAqa4keL7R5gwOc1E32wcb/uKZjwEXcdJCeASbdC4QqLiufTD
         FdMSrpO6WId/GF8bsKYnImqY1V61WSjis3gZJs4AQv73vYUE0FTR/Yu7wKFN6QzRPteB
         +iKbnK2B81Ouh7uacQw0y9lnfKH4AgKTrF25kGiz5x1UOGSkJn3ZzLIuzPYJ8r8GbYKT
         7FIwZMj/dg3FSevhcvoeuy6XwPE/PDOZvB57+BFrIioJe+2aTrple0+ZRZ3ZiCZYhxOv
         YGpQ==
X-Forwarded-Encrypted: i=1; AHgh+RpohRpgQatNkCyD8fhVzpinABv77OCxcJukqUn9PLlYVL3skrU/zIeP7pmQu5NbgZLrtLtOxpsl7LbKOA==@vger.kernel.org
X-Gm-Message-State: AFuF++lAxYqQwzJTVbX0QD1as6bg//r2OvGChiEY2zH/1RgQwDm5T4Uh
	UejSjITWEUvhVkUfbvQSURUbSt3kZENohkwFlLLdkTnghVf+rAFS9+vi
X-Gm-Gg: AR+sD13I0fFXb4EohFGlZWZH45GTXV4u6iYqom5hgWhKMjCjJfvmXNTdySe1JvTIfC/
	TL86xh88TMpMzgcQMHjnz30befb9LYQlxEAv2wqW9oKoe0W1Hk8hYc9n8Sn1HHN+2DxA0zWNWtL
	fGZLwYlwnk3x+bzWcdVv9A80rYP4O4vYYq+6Q6v2ichL0DSQP95tDzzahuinmAvxENe1YAdV7am
	ZTRhjIYmTTcd61tXYUNEFf0bJTeifR5JOayMSHo0nyp+UqNaUzjyYN4+IYvglWhxHYb/plvJnq2
	pO+P1ybTD75GIsN2raNvpjWwany6Kj5EzsYZFVa34mj+4Uq2i1jAZL8xhVra4on3EnE+E+Bzzxx
	VPliLZbaoqobXbFANx41ss7tRKBgfOfFI4jQ18Dd4ScgMV6VtVNwqJBzobcaHF6ysLrj0VL/5z5
	ZBCwB+h7wsFfx52yewj9MhUpAgjaH2ANATNQby49uCsy6nr1FFeTeYxIGpdEw=
X-Received: by 2002:a17:906:9c93:b0:c24:6687:bf6a with SMTP id a640c23a62f3a-c2492663ee3mr836396066b.21.1787434845967;
        Sat, 22 Aug 2026 14:40:45 -0700 (PDT)
Received: from m2.. ([37.142.151.124])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-c24966f99basm466778466b.37.2026.08.22.14.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 14:40:45 -0700 (PDT)
From: Michael Zaidman <michael.zaidman@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Germain Hebert <germain.hebert@ca.abb.com>,
	Rio Liu <rio@r26.me>,
	Bruno Giacomazzi <brunoceg1@gmail.com>,
	Christina Quast <contact@christina-quast.de>,
	linux-input@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Zaidman <michael.zaidman@gmail.com>
Subject: [PATCH 10/13] HID: ft260: uart: fix active-low RTS/CTS/DTR/DSR polarity
Date: Sun, 23 Aug 2026 00:39:38 +0300
Message-ID: <20260822213941.98882-11-michael.zaidman@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260822213941.98882-1-michael.zaidman@gmail.com>
References: <20260822213941.98882-1-michael.zaidman@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rio Liu <rio@r26.me>

The FT260 modem control GPIOs for RTS, CTS, DTR, and DSR are active-low.
Invert the TIOCMGET sense and the TIOCMSET drive levels for those pins
so userspace ioctl state matches the electrical lines. Leave DCD and RI
unchanged.

Signed-off-by: Rio Liu <rio@r26.me>
Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>
---
 drivers/hid/hid-ft260.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index 0a1875a1a7ec..a2f4b6e5a16b 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -1985,10 +1985,10 @@ static int ft260_uart_tiocmget(struct tty_struct *tty)
 
 	gpios = ft260_gpio_get_all(port->gc, FT260_GPIO_VALUE);
 
-	return (((gpios & FT260_GPIO_B) ? TIOCM_RTS : 0) |
-		((gpios & FT260_GPIO_E) ? TIOCM_CTS : 0) |
-		((gpios & FT260_GPIO_F) ? TIOCM_DTR : 0) |
-		((gpios & FT260_GPIO_H) ? TIOCM_DSR : 0) |
+	return ((!(gpios & FT260_GPIO_B) ? TIOCM_RTS : 0) |
+		(!(gpios & FT260_GPIO_E) ? TIOCM_CTS : 0) |
+		(!(gpios & FT260_GPIO_F) ? TIOCM_DTR : 0) |
+		(!(gpios & FT260_GPIO_H) ? TIOCM_DSR : 0) |
 		((gpios & FT260_GPIO_4) ? TIOCM_CAR : 0) |
 		((gpios & FT260_GPIO_5) ? TIOCM_RNG : 0));
 }
@@ -2013,13 +2013,13 @@ static int ft260_uart_tiocmset(struct tty_struct *tty,
 	mutex_lock(&port->lock);
 
 	if (set & TIOCM_RTS)
-		ft260_gpio_output_cfg(&rep.gpio, FT260_GPIO_UART_RTS, 1);
+		ft260_gpio_output_cfg(&rep.gpio, FT260_GPIO_UART_RTS, 0);
 	if (set & TIOCM_DTR)
-		ft260_gpio_output_cfg(&rep.gpio, FT260_GPIO_UART_DTR, 1);
+		ft260_gpio_output_cfg(&rep.gpio, FT260_GPIO_UART_DTR, 0);
 	if (clear & TIOCM_RTS)
-		ft260_gpio_output_cfg(&rep.gpio, FT260_GPIO_UART_RTS, 0);
+		ft260_gpio_output_cfg(&rep.gpio, FT260_GPIO_UART_RTS, 1);
 	if (clear & TIOCM_DTR)
-		ft260_gpio_output_cfg(&rep.gpio, FT260_GPIO_UART_DTR, 0);
+		ft260_gpio_output_cfg(&rep.gpio, FT260_GPIO_UART_DTR, 1);
 
 	ft260_dbg("dirs %#02x vals %#02x ex_dirs %#02x ex_vals %#02x\n",
 		  rep.gpio.dirs, rep.gpio.vals,
-- 
2.43.0

