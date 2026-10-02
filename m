Received: from mail-ed2-f32.google.com (mail-ed2-f32.google.com [74.125.228.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D092AEEB
	for <linux-input@vger.kernel.org>; Fri,  2 Oct 2026 10:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790935777; cv=none; b=l0X6R0GLyCoJHIQAcuOSj1QPRS9JqQIkxGATfP2If+DhpvwqYQKRglM/t05KIxQdr1gkZ9GjJgmV1Wfo2fF4Q9Nc79NQSZtOfxjx/K4w/jAyfY7Z3ylqcCik/lLZXcq0wOEOP53iDE0GLur3Y99CpVUg1KoJO5QHMvbxSbqYHF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790935777; c=relaxed/simple;
	bh=Rpcyir0pucMYwxwpWT3J9PaLulRi5dtQNJE0Rr4sZxM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GiR2LeZAZOgi2VTdu7Z/tp3v9kb5Vva/RL/KlQqm9JtQKwhuNkcssz6ZNdODkkrxbYXqGbhhhwRLNJi5EpSUbzbCdXm0Py6amN5/eFI9WH+EnNLd3rOJ83oF/ZBANgaTwLgIVzBh8jaOX17qFZ3+XGXI61yBIz3A4qvbONdaYhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EBKryzqF; arc=none smtp.client-ip=74.125.228.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EBKryzqF"
Received: by mail-ed2-f32.google.com with SMTP id 4fb4d7f45d1cf-6ad186afdf4so5737579a12.0
        for <linux-input@vger.kernel.org>; Fri, 02 Oct 2026 03:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790935773; x=1791540573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OaHZhhfoGTOQXtD+qa+qVp4d/gsPVtdPnGCiXPLugxM=;
        b=EBKryzqFqcfR5/P4sFDZ2d4sqtg89IR9iUAd+eCHQc+GQdaRaLm0h3CvomdR8Ui+KK
         qtdwnOhp9vgaspoisjuY4rJr4wSyMgDX6TjC8kLz7XAsUPWXAI4B7sXsajJR1x9ayU0b
         TwvBGyZfTSrXPWO9X6yLctO1yWBhY7yHhWd6JHdmIFxdzA4qW8WImgLfqLCS7YKinL/i
         bZSu/rHGLRJxx+/UN9rNWflb6D0w1JfpYekadgoz20WChKzmpsk5+u2O06CDMwIpX8UK
         AM0iFXg53SeI2tdHxJc6ta0F5+YnitnNzUYsL6QXcCBnefRpRqI1v+DfmHWNk/dWeZFI
         zJow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790935773; x=1791540573;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OaHZhhfoGTOQXtD+qa+qVp4d/gsPVtdPnGCiXPLugxM=;
        b=huqTBcgstSstAVV2A8MEDcLJuvriGGUJuwdWXMJJxyRa8fj3ae9Ixk1GEe9ZoBA/1k
         4J2zDCgVVwW5GPgpo9YdpQGBEE1Qk4oMZoJQKk3+bWyuPJAfIfZ+cs8NWLcc5PrRB7NN
         3EZJzJReQiOg/fp8WIeMiE6JribD0X0qYHqkdvF3f30b0fPI+kQLInZpbsmYOeiPWJml
         2myugnyvYOIYMiM/ZJ1iemviHH2JQnoMnxQOmh++MQ+2+qy/JpDGKDzKQUj9d/Ispbw7
         H/p/iKRlTe8YS+15ZC1SmcnbMqZ/3Ky1M0i9+rQfTNaOl3a9tawyZ/XrV6V00CH3P0t4
         o7GQ==
X-Gm-Message-State: AFq9FYKxbOQV73ZvD4pJ3G3VXzNxKcDa8F7rBWRU6lYpofDeM2tBrV8Y
	6StrysG1fpkvURzXhXSEU0sZcKYTVzG8cthHpx9gF5sUjsGC1c7wwEduXOaD6yiy
X-Gm-Gg: AYBFou2bCq82VR7vCbABZlKYuKjV4WWL+7c4LLFomZs6KbWy4JBQYe5oVQmrJWcZNeR
	wQsf4meL6qPSQWFsDzeKX6/qO1V82mLyQj+6NkXIqzT7LQPTaPGfQHTwn50+2rgof876eit8sfc
	pKHvRBo5iZ688lopKHUjjqC/mJ1ibeHNAnRAsd/RvUiIfxUO7s0iCoz0QxyixZB2cEp7fw6tspc
	EIu4vrgipFhNKiI5vkXmBoFCRsEKl54skqJWpR1ZD7a2/EimDepS3A0ARhP2CEQ0Ph+oNYjKxp7
	DeOeg8Ff2r713/UjIQw3bsEMDosRkLxmvtK82pGrTCxRLUTP6LT803+2Nxc4HL5pZ4vgv+1a4kr
	wZ8ghVXUhnFvyFXTkuMMYeg68pZyc+yCPx43IlWJ4kLm47gkVUYT7LxINe+Es3G9s+Ig5mDoXmp
	AyuWbxUYq2WCdCz2qF4kGpWfjTkiwRUlZslA9KXViyMfYFjSdYulb75rGUcSsHZ2LytOeCVQ==
X-Received: by 2002:a05:6402:5113:b0:6aa:985c:7bae with SMTP id 4fb4d7f45d1cf-6af9e2e13d3mr1400063a12.20.1790935772569;
        Fri, 02 Oct 2026 03:09:32 -0700 (PDT)
Received: from Ubuntu-24.04 ([62.171.228.246])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6af9d889452sm753687a12.14.2026.10.02.03.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 03:09:32 -0700 (PDT)
From: Alexander Kochetkov <al.kochet@gmail.com>
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Siarhei Volkau <lis8215@gmail.com>,
	Paul Cercueil <paul@crapouillou.net>,
	Alexander Kochetkov <al.kochet@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] Revert "Input: matrix_keypad - force switch rows to input mode"
Date: Fri,  2 Oct 2026 13:09:35 +0300
Message-ID: <20261002100935.449473-1-al.kochet@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 01c84b03d80aab9f04c4e3e1f9085f4202ff7c29.

The commit makes every scan call gpiod_direction_input() on the row
GPIOs. On pin controllers where GPIO input and interrupt are separate
pinmux functions this switches the row pins out of interrupt mode, and
enable_row_irqs() does not switch them back: it only unmasks the
interrupts. Row interrupts then never arrive and the keypad stops
working. Seen with a matrix keypad on an Allwinner A64 board (PINE
A64-LTS); it works again with the commit reverted.

The workaround is not needed on Ingenic either: the author of the
reverted commit re-tested all available JZ47xx SoCs and they all report
the live pin state in interrupt mode, see the thread in Link.

Fixes: 01c84b03d80a ("Input: matrix_keypad - force switch rows to input mode")
Link: https://lore.kernel.org/all/4130C026-2A83-408B-836A-ECA044491C47@gmail.com/
Cc: stable@vger.kernel.org
Signed-off-by: Alexander Kochetkov <al.kochet@gmail.com>
---
The same three-line removal has been in use on Allwinner A64 hardware on
top of v6.12.33; this version is rebased onto v7.3-rc5 and build-tested
(arm64, CONFIG_KEYBOARD_MATRIX=m).

Siarhei, Paul: you both agreed to the revert in the thread above, please
reply with your Acked-by/Tested-by if you would like it recorded.

 drivers/input/keyboard/matrix_keypad.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/input/keyboard/matrix_keypad.c b/drivers/input/keyboard/matrix_keypad.c
index 8863b741d1a3..cda2888b2e56 100644
--- a/drivers/input/keyboard/matrix_keypad.c
+++ b/drivers/input/keyboard/matrix_keypad.c
@@ -134,9 +134,6 @@ static void matrix_keypad_scan(struct work_struct *work)
 
 	memset(new_state, 0, sizeof(new_state));
 
-	for (row = 0; row < keypad->num_row_gpios; row++)
-		gpiod_direction_input(keypad->row_gpios[row]);
-
 	/* assert each column and read the row status out */
 	for (col = 0; col < keypad->num_col_gpios; col++) {
 

base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e
-- 
2.43.0

