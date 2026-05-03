Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2961B36E473
	for <linux-input@vger.kernel.org>; Sun,  3 May 2026 07:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777793243; cv=none; b=ahN5JdHS/dQXiv89rcswJfkzoItjKp6nxzqZXQsLzMSbiaV6ts5FpeqIyCTb6NdAXGfcp6y8lVniKRveQXUXX159vIl24WEhS5IYcZPmFMhqsUHgNrcLDFs7s4+B8BMLJn4tEuuhg7JLDmDunKsWoEu9PxEw6wwEEKGXNrSjb8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777793243; c=relaxed/simple;
	bh=BmEGzsHJ8K+3+vN7Jro/PlahKcA+d5OK7rUba+0zggo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lIkGDzQwp3NE5iE7zqQhPP2IhTceZNIhPABThGgHG6Th4S3OD8R1ukGPULUOlM9XUTJDzoeoB7I9CthDBY9RRnnNZ2n+calBCGQOabhUO9eGfzBk9N/utprOiCNsV5/cCA2kl0KRv51Eyb1QzmUa109gx7nB2O4wnu2rrZMspc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CRDzQElm; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CRDzQElm"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2b4583f0a1aso18348845ad.3
        for <linux-input@vger.kernel.org>; Sun, 03 May 2026 00:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777793241; x=1778398041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OHEBdikQ6bf/NgnoLrg9r5ETcVwJT7U135E6QfMQij0=;
        b=CRDzQElmSnOLZ20jG9/rdGe/kRwaBZPJGYouCXNUEkPI9SE0Uka0IIivsKi92U6QmK
         J9AOgM169KZ/U3Qk2vFOpmQZ3OjKqZIKz6pKkFwvbK1MPI3ivdLd6H6mZT45rsIuVKn5
         FimPOKoY8fv+9RMN9JVFYWV1whFX1KWdmuJjJgQFkl1VatdePS9psMRHHIDDlubujLUl
         oUTl78/ww1ktq5r2/y+gI+V6gL9xqaGATYL9nIDLf4URlrurQ2PNVmNZVjK9Dv7Z9Gdi
         BkxtynNIjP3CQv/t0VLauSd4Fm/ZprEloVzd+iQFR8eUDI1jbxCpeikLK+Z4+60G+kgM
         mN0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777793241; x=1778398041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OHEBdikQ6bf/NgnoLrg9r5ETcVwJT7U135E6QfMQij0=;
        b=IZc8dgh0ZPBCg/sGRZMkWwbVAxCafFYADthSJfHSQvWCvzkrWj0pDWB34SyOMnfxdC
         B61YrzpfBTdjCEMk7900mokLXxwZT0g5DqxeXeD50BpoIVyEPvx5F781p6+Rqdcu9rve
         324jjAw14tjWtx2VzCRjObekkqz9aHGQsQ5dki0RUcGR60RDXsvGfwVX+0XIdQBuuWDK
         p212muCqZmgKeWPjSpOueqbpATkQRcmWzF+JQRUKOyWZAbe4KKbYU7V2Kpm58I81ovwJ
         Uld7+7PsKtOeZcWZ8JMe/FGX/QjmNz/EzeS398LO4V2qCXRqZ/LU3k1Rrtz3kB62ieIl
         pFsQ==
X-Gm-Message-State: AOJu0Yzv7U4cExnFdfSniB+dtt/0/PPejyvZEo6IKaqLalyRpKGTukbI
	ZO0PDw92d8eA8kjVvVNcfS5ho/sSpriuf1uRod98CbjL5EIwUk0LJFkU
X-Gm-Gg: AeBDievM+ymrSPh+Mw9McFSzhfU7bXk/oSm50IzwZR0KcjJUwuB4DAKH6y6MQXoc/HQ
	FqVPoRzYbHoNlN/ydbKJHhi0nh9QGIbawUVSstntd21dShnoY2t84D42pTPcgSF7zQQlI8s8jwh
	E1TTySLB4J0lMp/uJhcRcXayD6TpeZql2aVVRWlg9j+TwHjH0qeh7AUns3TqADIe4fXpEd4P5K0
	6mHFsoUNd736eIIdoChDmjx0zc3yvhTZqwn3MhlKBSbPmzb/KeoZuPMdh2tmta7QTa4WqQCuebh
	+F25si2pb8zHiabhbSeai6dWttbXjJS52wmiypS3SrROmJoOrs7HZxKcXbKJd1TM/3LWzLBi+fg
	ud0bcXQMrlDwsEnmDrOLkYd3P2gADMcGvCV35ooEjAKHY3iaSWxWOr4GIwDcQrVMuDZ0205HG4J
	foapfDykk5fqIzfabRk+pmX7GhBPfJkV/da9C1r0eYWc1US2oDasMBaBUal5nfZngUxxB55A==
X-Received: by 2002:a17:902:cecd:b0:2b0:ba14:fc55 with SMTP id d9443c01a7336-2b9f2837cdfmr53882545ad.29.1777793241487;
        Sun, 03 May 2026 00:27:21 -0700 (PDT)
Received: from tranquility.wa.lan (60-241-74-71.static.tpgi.com.au. [60.241.74.71])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9cae16a9esm64942945ad.50.2026.05.03.00.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 00:27:21 -0700 (PDT)
From: James Ye <jye836@gmail.com>
To: jikos@kernel.org,
	bentiss@kernel.org,
	lee@kernel.org,
	pavel@kernel.org
Cc: linux-input@vger.kernel.org,
	linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	denis.benato@linux.dev,
	James Ye <jye836@gmail.com>
Subject: [PATCH 6/6] leds: led-class: mark classdev as unregistering early
Date: Sun,  3 May 2026 17:26:43 +1000
Message-ID: <20260503072643.2774762-7-jye836@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260503072643.2774762-1-jye836@gmail.com>
References: <20260503072643.2774762-1-jye836@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The classdev was marked as unregistering after disabling the trigger.
Disabling the trigger attempts to turn the LED off, and the device may
already be inaccessible. This generates a "Setting an LED's brightness
failed" log, which is avoided by changing this order.

Signed-off-by: James Ye <jye836@gmail.com>
---
 drivers/leds/led-class.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/leds/led-class.c b/drivers/leds/led-class.c
index 9e14ae588f78..a00986ffd9f6 100644
--- a/drivers/leds/led-class.c
+++ b/drivers/leds/led-class.c
@@ -601,6 +601,8 @@ void led_classdev_unregister(struct led_classdev *led_cdev)
 	if (IS_ERR_OR_NULL(led_cdev->dev))
 		return;
 
+	led_cdev->flags |= LED_UNREGISTERING;
+
 #ifdef CONFIG_LEDS_TRIGGERS
 	down_write(&led_cdev->trigger_lock);
 	if (led_cdev->trigger)
@@ -608,8 +610,6 @@ void led_classdev_unregister(struct led_classdev *led_cdev)
 	up_write(&led_cdev->trigger_lock);
 #endif
 
-	led_cdev->flags |= LED_UNREGISTERING;
-
 	/* Stop blinking */
 	led_stop_software_blink(led_cdev);
 
-- 
2.54.0

