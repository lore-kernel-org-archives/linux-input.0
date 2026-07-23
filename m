Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5DF3515FF
	for <linux-input@vger.kernel.org>; Thu, 23 Jul 2026 02:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784773794; cv=none; b=YrQHSSVXNAfWu7saGsdOKERd1aFK5SqmGZblonZecuooVDwOw29jAXf01UrNzI/+KD1uyV3+dnudY6uGujT6wuVo0nW+YnfzRHbXxCg9vNdCOkz2gJlY8xkYIMdSiawlfwDUIGtegLJL/6Q46GeA3u2D2N+TCNhCXTlMQLRIG48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784773794; c=relaxed/simple;
	bh=NEg8NOM/txKpAiZI/WqqPFojv7JAFOLUG5hsaOzejZs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hKBRWvf2BGJ6pgo8GotKqhn0QbN52Wf/5LnmkzjQhFWCW4X4D9yTQ0enWpL0saSyjX0R//rO36+n6F4VFFscnPtq0BrCv+5xNoKs7jPwkDwaDJ6ppp+30nwZEeXPurZZy1SXzp/+BgTU8RpOC2SjyS3e9lxNtPVN75qqWV8tXws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ENha5fJ6; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ENha5fJ6"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ced3386430so1785365ad.1
        for <linux-input@vger.kernel.org>; Wed, 22 Jul 2026 19:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784773792; x=1785378592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QinkvqfI7+Jiy6Z4UIF5B3VN+ppmenjr+Bmdci/f1Dk=;
        b=ENha5fJ6LOw5OzuJEm/50of8KEHGyUUvOyp2KMTsHZ41DWaUtrabffkQPhxZP+8GyL
         gVqlq1tGFuPXCdZ47QiUJGbLt8OQxkBTwiJ4EdO4qefZMJnhW8XMEQFQgTMf6xPixNfM
         h5VQNCDjJSsc/Vw3iClQncjKz2jV8INKlMzx3dQVSu8k6kp8iszyjoprh9BP4IjLeUYe
         KXFmd3A5IUjiaHIaV7TaCI6vexw5sFo0mKMsRRKlD95NhU/A9nMNs1dtXzxOTWzbSZ09
         JmFp0yCxCTHFNjBkqJoL6gfO+ulIavfkdgOokEnNidB0JUo9Or4mr03o1rAM/zYl2SAY
         tTaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784773792; x=1785378592;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QinkvqfI7+Jiy6Z4UIF5B3VN+ppmenjr+Bmdci/f1Dk=;
        b=VabiSgJjTKK8/79eeIUhSMlcXZMlGxrZAhKbfP6CF4KgE4S0YcKPhOI7qQ6p4ZRBLG
         8fRThDquvHS0YNQTJWeCj/KZRa7oCdYw7i6jUhf4hJBOjRp7fgIYc/XyREFbIu5rRMqo
         /WNN/PegeMEv5gsgNzH9nWrMjHt6xamSBpWpy6O+QCofA2vAF/7dio6LSkrddU70KNO+
         cfV/PIDD2YbB0mysMPdZp/7oEfSkrbAldfcLYAAPnBf+9yN1nUikdoXP24BypXDDhPCy
         nRy0UEXC/qZ4eIhJT7sO+E9D7BouKvFzIkDwy72GJWG3EG0J9SRP1MnFXpSSJae3S+C6
         IuTg==
X-Forwarded-Encrypted: i=1; AHgh+Rpfz+Mm6lNISfUezJ6q2FOyBB27Xlqcmx/n6HhCIrun5yUgEaSWmMt5NBICVS8FugyGLLZhWnYlYdDYQw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyQkUPe9GqYPh0ZBw7z9g6Z5mqCJlvcnZR9IVkLjks3JHrPSz7t
	Pc4d/NjVxVeecSDzmBiFb5pto38Cr0JMSeDYS44iLmqEQMl23XLoyVw=
X-Gm-Gg: AR+sD10vTiNDkvKB+2mvxyd3tvElHknZ2KH6cbquPuqw0UKvkZkOrnW8qcZBWndXjIP
	whrr7L97M/z8KoALWP4RqfUEBtpLJuWuA2MXqAg72xXq6icT9WpGC6Hqv5yFJP/G9VurK/n3ebg
	sTPNJ7pZMBWHyQ/dRuj1448Apv4gAgVSZ+fFGFkZDAamTHJFqdLIRMaWmh2UCB/8vPyJp88eUh+
	1EwARM/xlQ/cgjs/47RDQddaoPyHbtzKzI0ZNSO+8UmF7qWFEZrolEOyiVdjpSTtmyOF8fiKuCI
	QLZHpZokhDJ68mlff1tvejBajKZbaTsV6Ur2TwWrjpKxaWD6CxWoTchl/+ct0nr87R0vG3iFcKA
	sK65XkQTp3AF43GQCDb9gymq1eO+K9Rax+rdWQz+gZYg1VMgCaELKps/pRG5raUJId8oCH52AVv
	u1HwwhiUmGL+7O7KZyy6quyFZ6
X-Received: by 2002:a05:6a21:9090:b0:3c3:859b:9178 with SMTP id adf61e73a8af0-3c44b059c7emr1224805637.34.1784773791971;
        Wed, 22 Jul 2026 19:29:51 -0700 (PDT)
Received: from t-rex ([2401:4900:addc:f847:290:7ec:f519:db36])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147e1c9289sm14127773eec.29.2026.07.22.19.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 19:29:51 -0700 (PDT)
From: kr494167@gmail.com
To: hvilleneuve@dimonoff.com,
	dmitry.torokhov@gmail.com
Cc: andriy.shevchenko@intel.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Surendra Singh Chouhan <kr494167@gmail.com>
Subject: [PATCH] Input: charlieplex_keypad - check gpiod_direction_output() return value
Date: Thu, 23 Jul 2026 07:59:43 +0530
Message-ID: <20260723022943.9337-1-kr494167@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Surendra Singh Chouhan <kr494167@gmail.com>

charlieplex_keypad_scan_line() currently ignores the return value of
gpiod_direction_output() when setting the active output line for scanning.

If setting the GPIO direction fails (e.g. on I2C/SPI GPIO expanders or
hardware errors), the function continues to sleep and read input values
from an improperly configured GPIO line.

Fix this by capturing the return value of gpiod_direction_output() and
returning the error code immediately if it fails.

Fixes: 2ca45e57ea02 ("Input: charlieplex_keypad - add GPIO charlieplex keypad")
Signed-off-by: Surendra Singh Chouhan <kr494167@gmail.com>
---
 drivers/input/keyboard/charlieplex_keypad.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/charlieplex_keypad.c b/drivers/input/keyboard/charlieplex_keypad.c
index d222b622c820..d46a2298e6da 100644
--- a/drivers/input/keyboard/charlieplex_keypad.c
+++ b/drivers/input/keyboard/charlieplex_keypad.c
@@ -77,7 +77,9 @@ static int charlieplex_keypad_scan_line(struct charlieplex_keypad *keypad,
 	int err;
 
 	/* Activate only one line as output at a time. */
-	gpiod_direction_output(line_gpios->desc[oline], 1);
+	err = gpiod_direction_output(line_gpios->desc[oline], 1);
+	if (err)
+		return err;
 
 	if (keypad->settling_time_us)
 		fsleep(keypad->settling_time_us);
-- 
2.55.0

