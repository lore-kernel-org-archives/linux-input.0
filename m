Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794217480;
	b=zViFtPwhFktHehwTBOD9ZRv6X6STKLKK49n929cNxvLGqdKGF/UrPIdn5sKWQSydoUZ0
	 AMcBUH523kOJBOIlRJgZ9iZQ1SALnTb29iGl3qhne2ua+Md34Kf9vVjDZkXJNk+PYFZM/
	 DlFC/+Q1BUj0lHmzVZ7Cxwc5+uX2wz8HDSoycBHpF2/eo5xJwUyxKMb2g+7IWM7PJvBj0
	 h+CC1ml7wreKpEsTLrw6gGb48DnXoxTWRknmLRFTHPvllErpyP5Kh/QPkOQQOixLo1mqk
	 mdHZuXmi1OH1P3x3gPMkDBLainQPDabinBGjyPWnleWtuvJzqyMjjWC06NWsHI1SzGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794217480;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Sender:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=oj3EKNGG17sqpOqktYRe++Wt7Nxr9RGMT3w7eUeplg8=;
	b=hdNHOVJH8wPMhoHB2vZISYzpef5IQrtgcM4rOS8lRZEwiiaGSRJGPwCr8VtLQTHkhe/Z
	 yu7um/46iTrlmXLYMZqB04qdiJ8kh79OHIwKy/DRR54jk4JJoklt9gIuj7Wap4Pys/tu1
	 p8bUOPj7iIO+6FCm6n9JuRxOM5+ZbEM1jH11sBva/06b9kZRHkj4+KUt2oaak97DDep51
	 5xSEub3yio54CJxQtip2cAr6i9cXtem9id3eV95ipNv2fqR98bSYk4gaBax9RC+3E9yvM
	 BMXWj78Zx8Pf2kefunDrlch5aQ7yRb69M43f7utSp4+jL1LGss1IRs9jCuKCf+hUa7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QxEawyRe;
	arc=none smtp.remote-ip=209.85.218.52
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B221606A321
	for <linux-input@vger.kernel.org>; Mon,  9 Nov 2026 09:44:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B221606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QxEawyRe
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c450ab1483cso101592566b.3
        for <linux-input@vger.kernel.org>; Mon, 09 Nov 2026 01:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794217478; x=1794822278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oj3EKNGG17sqpOqktYRe++Wt7Nxr9RGMT3w7eUeplg8=;
        b=QxEawyRePq1HxiXwiY9Gxec4QQmFKhN3WPgDg1Tb57J24N0FNdOJ0f70p1Q+VINtki
         UiJIhugZ0ITyGaBXN3tfcymhEQNwJ5h3UE76spHbI6Yece0a0Dwm/2SoMLh8vG2ItRaA
         2YXHeWZatEdJsKv+/mdxxIvqZcL0OJlc6J/dsr6tQXk+Z50mCMbVaYAhkEMcoxdd9BpP
         Q+mrFj4PUkmLV1/Ci0MITaGqYfGZ15yba274xjsJ3kUfzohGiGraWdt1hOAPgidRZ5o6
         OQmBa96obqWpiuMGB7iRbVPwOhaHydBite5W6pxh3ycxhQ4pvLlhN9zuT9YgX4C7flVl
         ic2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794217478; x=1794822278;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oj3EKNGG17sqpOqktYRe++Wt7Nxr9RGMT3w7eUeplg8=;
        b=QEHReWVrihg4pnsXHtTUMufC4SClZAXuH858DOtZPWnqRWkyDxpcy4/1DDNHPcZ/tA
         S6OeNRCXXWyPmB6nQqZ0pVwiwF2ZnGZvOvXlh3WrDdLf5UdEJVh8zZQfGj9vdfHyb9FK
         ZpkkECMAPxG5sInMHosgc6Gu2uxhM87XGvPCUth677KHcjTNRxtfNpabIKt8DTCQufF8
         2L3bFrN/y+/6j5M0GI4bRhNV3UdNsjIFvDP4T+VFgyNcrwMnPAxeOpTlqOcDI5WNZE/B
         qtzFgO9IRf3YaceU56XbGh8paWg3wE6ELURlvOAZFmyl7QjbeXeujqMQMimBs1VXqR30
         PKaw==
X-Forwarded-Encrypted: i=1; AL+hErEmdSmLyQULHSU2c0MojD9Ah1a3iFcEHNPb8+jK2Vd673yaTBbtcg2D5TWt44viFeUWnoM+js2Trvkckw==@vger.kernel.org
X-Gm-Message-State: APuU4Z9Gu6DJCb3Yo421tJzSmz/82IH3JVPdgZzj8Cxp62DT7p1fHQox
	q/YyudHAqyJ45TB775O04JVYncTbT7TWqiDpCQttR5YHEtV/L54R5LZR
X-Gm-Gg: AYBFou2JGeZReD3IPo44lI63NrO2THASoCxMrbZ1WJjqfWOeh1dCM8ewCrWTP3UZtW7
	bnyBQSntGOgjHa8TiHqiCs3NSLs0qpQ5SD8vyGPl7kCGOw60P+wbKc3XqvtQhn+i8YDeYK/yL8H
	j4GN4Qt+KcGLUoBewIcOj8tK4tzCEh6fhENm8VArX9Rl/hP/00Ut/ytfU6JwXiOT2UBP4ONJ+BJ
	AVc9pUF99M0/wQ/TFgHNQtkGob1NzzAw///E77OrGmBEEa0RQ44fGN4VywoXCyEZgSSP/3TpoAE
	GL2wlgbLQ/ByF3TkDg91W9crC8B+FvY3SMxo8FamGe8qQCnvvGdSHDbunkCRYKFPdeKbWWMYS+2
	l8BQxArEeZ6zTKOLWc+ihpZ7u6iikV+EX/Tuo/3T6dUdJLFseILsISbXTFaX2UHdKh52J2pMZCI
	7eHnUXUlmNDtDF6wEmYgUji/3MtVAxVS5Gf3pGknJpPtZDF36xw1+HI0rdGK4YaiIMlIv6Lm8kH
	nnQHv93/5oEsvHG2ZNYpJL0ZsBZjJlnnHfrbk9O9LZSpknFX9pKNmfAHhHtm5EQallX3m6f7P97
	K36ADhPWuVcinae2+el/Sx7nKGs13Bs0kUdTsy+DNcHuQlC4M4JDy77b
X-Received: by 2002:a17:907:3da4:b0:c49:cd37:177e with SMTP id a640c23a62f3a-c4d6db58574mr238659066b.48.1794217477322;
        Mon, 09 Nov 2026 01:44:37 -0800 (PST)
Received: from torstein-desktop.internal ([2a01:799:3a1:9700:6e3a:d704:53e2:f00e])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-c4d6a4753aasm137786866b.45.2026.11.09.01.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 01:44:36 -0800 (PST)
Sender: Torstein Eide <torsteine@gmail.com>
From: Torstein Eide <torsteine+linux@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>,
	Maoyi Xie <maoyixie.tju@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] HID: lg-g15: G15 v2 LCD and game-mode support
Date: Mon,  9 Nov 2026 10:44:22 +0100
Message-ID: <20261109094426.1432465-1-torsteine+linux@gmail.com>
X-Mailer: git-send-email 2.53.0
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

This series adds support for more of the Logitech G15 v2 hardware to
hid-lg-g15, plus a fix for the remove path.

Patch 1 exposes the GamePanel LCD contrast as a g15::lcd_contrast LED.

Patch 2 adds an optional fbdev framebuffer (HID_LOGITECH_G15_FB) for
the 160x43 monochrome LCD, updated through deferred I/O, so userspace
can draw on the LCD or bind fbcon to it without libg15/g15daemon.

Patch 3 binds the G15 v2's second interface (046D:C226), which is
currently handled by hid-generic, and exposes the Super-key-lock
("Game Mode") state as a read-only g15::game_mode LED. Normal key
input on that interface is left to hid-input.

Patch 4 fixes a use-after-free on remove: the LED work can be
rescheduled by a key press between cancel_work_sync() and
hid_hw_stop(). The bug predates this series, but the patch is
written against the remove path as changed by patches 1-3, so
it does not apply to the current tree on its own.

The LCD wire format and contrast commands follow libg15, hence the
Based-on-work-by tags for its authors.

All patches were tested on a Logitech G15 v2.

Torstein Eide (4):
  HID: lg-g15: add LCD contrast LED
  HID: lg-g15: add LCD pixel-content framebuffer
  HID: lg-g15: report Super-key-lock state on G15 v2's keyboard
    interface
  HID: lg-g15: cancel LED work only after stopping the hardware

 drivers/hid/Kconfig      |  13 +
 drivers/hid/hid-ids.h    |   1 +
 drivers/hid/hid-lg-g15.c | 599 ++++++++++++++++++++++++++++++++++++++-
 3 files changed, 606 insertions(+), 7 deletions(-)

-- 
2.53.0

