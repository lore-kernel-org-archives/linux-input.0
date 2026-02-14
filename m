Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F71714F70
	for <linux-input@vger.kernel.org>; Sat, 14 Feb 2026 20:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771101507; cv=none; b=A2ayC36n5E8bijVvo8ihzqkMwiCSdwgvmvViOzaKgkU9q4ClQsRWKvuBWmXqxmYDfanRhk2JMM1laVy56fdznsbq6Ux+2NBtDuUJxpe2IHCp4Sq9CicH1qrZZPXe/hgB/YfQssPTVlu/5o+n1RPe9LB51zWZT7pRlVhT/C9ZFiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771101507; c=relaxed/simple;
	bh=ISPg1m/xtoHmadv+9qD4PF4qeTVVdwlXnG/d134LzZg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DPy7auFNEpr5tQv1VJ8Yhf5DpVlx2g5jFYJK6re5ckArawZtvdw9fqQoi0A0YD8vmzV2vWJCKzZMXppSpdoAevAevWDmK0HYjl6sYHINECQnR8WQFARSAZ6eC3TrhtOBeyaw9EEgb/bFTwB2QxCIlc6mdmXXpd4MhxO9kJrkfOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ACLn45RS; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ACLn45RS"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-48371119eacso18538255e9.2
        for <linux-input@vger.kernel.org>; Sat, 14 Feb 2026 12:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771101505; x=1771706305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Tyvs4xFeOgUlL1nJWOsM4wXcI5MSjDts4OzcTAQg/Sk=;
        b=ACLn45RStFfq0f8xCGaIAblhJAIF6KAdrIhPrOE5h1D+Il2j3ZOve3icxYUEb9qw37
         6WqzJkkL4JxOyu1numuLK5UEC69q8ZHaVXuGTg7YZ7Tsv0Y+sD0a/kvpiy6V+W/lHEsT
         580VSixZjnb45PvaPLJepV7DWDyQeDGH7q3Geqdj3V8XqZqtbQ4gbb38FfeX/fi3LO62
         4glTYGoOCODF/l5DWvTiocBeYQcBCyOEzW9fp98nSyrflBUoxPL70SbmrBpnydx1c2tw
         aaCZ6mjlvXDzWYh4cJk3YdRTtChzuJTmOQ926zihD+g7CqzmoO8kWxe4oX3HnyURIvPh
         4l1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771101505; x=1771706305;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tyvs4xFeOgUlL1nJWOsM4wXcI5MSjDts4OzcTAQg/Sk=;
        b=pmN3kgW3XXiyJd3PiMabOntKX5NtRfsqfMfCvNOkeM7eYMu6QlFXJGLTafAh5qnjK0
         0ZJtwMZPS8kqI4iuZ63o9xqsbtrNvWOQKF/6+pgeL6oIaJqaH7H+93ua9iNTGsknq45d
         OA7BX9pi2jSvB4hm9et7dn1XVKaoGHb6F5ZvWXcsnOZv8rWpZfUrx2nY3o7GaWA97h0j
         exzZ+EdQsJPo8pI79Uany9VEXW6Uo8WJ9KP2UiuRz9hb5nNg33c8o6pgkueIFIeqbUnW
         GTHNQpNUHTS0utfjM/0JtZF1FBisLJVNL+k6+FMdmT8kE4757oQdPmFDwvq6+AfqtND/
         SFwg==
X-Gm-Message-State: AOJu0YysEY/kU0m0MH1BBVJoofDtFTxy/dPwIy+BWF98HBPqJ2imbXhz
	txNiZKEnVO6V4Jkn29+bDmETNsSXV3cz3pddH5IhkDMnSFfFknI7/uNh
X-Gm-Gg: AZuq6aIay1bPZFj5omi/pMi8JaSfXzhHT8j45wcR0SZO9oLQh3QcDBnEDinydk55NfK
	ZH6sVq7sCjH7q6thhYsNRGvq6CJM09cmP9IQBaAIsLGIv0nKouJ0hLPWae8yRHEXaFFBvLq+vGX
	BQmrU8Omtbl6fAEZtf0XOCMMEx0cdCM/NWagQl2mrqPA9Ry0+3xCvGYIxyvoDcPRT91MOh1RoEy
	yEgNUEcT/AhCxavIEzhoa9KGTpTnqNyIQCOOhJGY4Tq8RM051LVDGN1yxVWBqYkuLuuztzcBuBI
	t20Wi1R+JoLcAm3rsC5cSlOLmlb/13Vgv2cuPZtnmJADcwjsat9GTDufL7jcedYYAHlgsdU+jqh
	kwOpOxTQ1GbJeLwXpT9WUMIE02kC9bQ7Qe8lhWjksuyQGVsDoMNPdpmbC+PAphNNZ5BQp37x6zi
	oEJrhBzaqhSqR2ZQ9IAMlTJLCUAA==
X-Received: by 2002:a05:6000:2c0c:b0:437:6b73:ffa9 with SMTP id ffacd0b85a97d-437978c7625mr11670815f8f.5.1771101504666;
        Sat, 14 Feb 2026 12:38:24 -0800 (PST)
Received: from Max.. ([46.210.227.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-437969fd36dsm15771151f8f.0.2026.02.14.12.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Feb 2026 12:38:23 -0800 (PST)
From: Max Brener <linmaxi@gmail.com>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Max Brener <linmaxi@gmail.com>
Subject: [PATCH] Input: libps2 - embed WARN_ON(1) macros into their enclosing if statements
Date: Sat, 14 Feb 2026 22:37:24 +0200
Message-ID: <20260214203725.6463-1-linmaxi@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make WARN_ON(1) statements embedded inside their respective 'if' expressions,
to improve code clarity.

Signed-off-by: Max Brener <linmaxi@gmail.com>
---
 drivers/input/serio/libps2.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/input/serio/libps2.c b/drivers/input/serio/libps2.c
index 269df83a167d..05b64277aecd 100644
--- a/drivers/input/serio/libps2.c
+++ b/drivers/input/serio/libps2.c
@@ -154,10 +154,8 @@ EXPORT_SYMBOL(ps2_end_command);
  */
 void ps2_drain(struct ps2dev *ps2dev, size_t maxbytes, unsigned int timeout)
 {
-	if (maxbytes > sizeof(ps2dev->cmdbuf)) {
-		WARN_ON(1);
+	if (WARN_ON(maxbytes > sizeof(ps2dev->cmdbuf)))
 		maxbytes = sizeof(ps2dev->cmdbuf);
-	}
 
 	ps2_begin_command(ps2dev);
 
@@ -270,15 +268,11 @@ int __ps2_command(struct ps2dev *ps2dev, u8 *param, unsigned int command)
 	int i;
 	u8 send_param[16];
 
-	if (receive > sizeof(ps2dev->cmdbuf)) {
-		WARN_ON(1);
+	if (WARN_ON(receive > sizeof(ps2dev->cmdbuf)))
 		return -EINVAL;
-	}
 
-	if (send && !param) {
-		WARN_ON(1);
+	if (WARN_ON(send && !param))
 		return -EINVAL;
-	}
 
 	memcpy(send_param, param, send);
 
-- 
2.43.0

