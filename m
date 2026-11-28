Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795863978;
	b=VGOEVrYhmnBn5e8mTZR/4lWu1UBvd0CARxkdMnEUi/xqz4l3I/OumQFvL6ky/zTY7Jty
	 hqWmI9Oa/UMV0a/Zizno6kuVPlGy1vbcB+tOzRSRsHU2tBh1koMWwaNc7rNyyv0+R1+Tj
	 xVf3fIgWFsZtWlViLoAx85WZe1bnX3RVLUJqVyPNHyczRee+CMN2O9WtDc1Gh2vMojjOH
	 Enrcyq6X1habgUOL5dKknBTdG6u5kjCNY+xAp61MJzp0Qdjr0SN9InW4fKlz2XJgtecJ6
	 gfMmx9kgeZtZt5NSB+TVjkWW4pwvszunEmodh6TcpF/IsykfykdnHV5aTruV4Viy1yA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795863978;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ezN6dpWTDZkj1sKNDSS+kFdA4nYR7uGcxRXk/sDauFw=;
	b=MBy6IZg/O5QT9EZBjaBjoSNte/0K35cE/5twjsRGxVyxvSFJYrKmaXP3hUtGRokN2bHz
	 w+OcvbOEJWGVy4GKnsC6IBtUvbR8K+V4Q2tw/7Xp4Ax1QUI7TONnXMafR8D41N9TEWxyk
	 touv9QBx8iyKv0NbV/+3KWmbfE6qq7JnAhAkqPRoa+8LAK2ePscNSSZA/1SdobR2aiAm9
	 bRWFN/5OE8IQOi15UO3Orq7szgFgNy5w8BUAHwXNwBhHBnTaBbM++csWUOeRNscEH/zzQ
	 Mm9tQTzogr6ILuEAcn/j9qqCEIXQfTdjBtgr77L6OJPDRHeYbR2yCr0PIRsEOKBrgmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FTrr4t9G;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577E5606A31F
	for <linux-input@vger.kernel.org>; Sat, 28 Nov 2026 11:06:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 577E5606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FTrr4t9G
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-38644aedba1so14150420eec.0
        for <linux-input@vger.kernel.org>; Sat, 28 Nov 2026 03:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795863977; x=1796468777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ezN6dpWTDZkj1sKNDSS+kFdA4nYR7uGcxRXk/sDauFw=;
        b=FTrr4t9GodIYYjtqXL7b/1FJ7dHbYkxLKi+TNs9QxX3oQWcFVKODI14v71gf6DSvZ3
         LAz4eZs1vWYLLf41OAEJVFOtsPzdH7zELwNWMUcs9gZJzIHZZ0i5tgSeq8JeSrdgsxKw
         PGS/9t0JHQESKMtdH8YF1V5MuXa5j8AZFBX2CVjNLqd0Dadajhm6EGrVzslpWmEldevT
         dzELwYQ7kgDfvpJhNCRTZ9xXJIAushtjsl6W0n8hqljS5h9ZFPgySG+trXRdVkLSMro8
         B2psgd7ZZeGeuD3eklh5pKSZKtiINIU/BPckiODRLKQJJ7ERbrIlWMF/APQ7wuF+j8eF
         X+Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795863977; x=1796468777;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ezN6dpWTDZkj1sKNDSS+kFdA4nYR7uGcxRXk/sDauFw=;
        b=xUzTeqALA1wUmmQVIjODYiffcFGaaiSayf1G5aCQ4u5F18NDeYfgxAJeyM2fiP424y
         v3jTH/UQkwBmSE1Or21eVvW9NMkjvk66pTzNIrb8ad7tHbvVsf624LQRWKgP6ybTzgwt
         J1zaod/SYm8U5uEe6+Rw3D1Wm/3s3W5C5alethnM4U9sAQ7unNP6jwcnComI4zuoeE+r
         f1M7+1GqvUWztdTIEmC2fEfZqoiHaVo6b9FEAK+SavWkGbJ1qXf7dPjjRh7zNQtuBq+j
         +XAL2sF9l4+oBEaCNwKjKf5o46KytkmKhyiw9qOFwFWr6QN2LZEtQky4z6OTAdPfLWlU
         mHyg==
X-Forwarded-Encrypted: i=1; AL+hErEi8MvgB8j0rtZK9uekxLBUzdzmCZJ3/vsa4u9e/FkdEEWR1+fcq11FOVLfpfU9T32E+7rh2GlXo5dimA==@vger.kernel.org
X-Gm-Message-State: APuU4Z9T2ogNfyuhiTqW2jwsjMe0JAJdnYbMvAbmIft15yIliODOhzyS
	5Oh4PPZDPno0ys6sAo9zYAdQSAz7ezE4D28Zk50rH+5zru5qaAZo0P9G
X-Gm-Gg: AZFdTZfP36RFg4IDNIO3bqiXy8YJiVuQZOlRvup0Ks75kuFWTVUD5zehnSNm0sAAHeQ
	+YMfyDhpBKOgaiNeAARMB8awN2MvT832EqImoRiUtCk7Tqlox6mkdYgLg1bX2qC+9Dc3Td+R84U
	AfL8LDzDgjr8XNWgXwmyf8Ycz516NYpzsmOd/vSdyT0wTSFPhqHT7fNDk10WnZfSV105AzO6zlQ
	lIsqrxtGCuoJfGY/MyTStY0dS0aCcKlZ+w8akY19cJ52fzB5x5b7s67MlpvBHR9JKTflQGobv9W
	17azSzTUa4jTwmyRCMw96T/445pl54neBbJEDP9NQcRpxFf+GJ+pGm1pkfqjzpWUJIay4R5a1Lj
	0WDbNEFwUyb0kFFSKQP0ju+arkjEqkGV9f9F4FrQcwMF3bQjCnCaRyNbvNNjF1tSOYkP5PUMMjz
	0rXXOLxBiwS7lZPHRHQ6Z9JMdu/1dfGdpJJuA1KA42PiGxxT5SUpoqiV41NxXjDhB29jn9w3y3H
	D25Gy48UiC0CDHTqClsO9z1ActXtKr4Ps8rtEuuNkFxukWbfF0Yh7txn+Zzy/PI+0gX8p/mq2A7
	SXKcxmq0/AQ1BUGU/LQ1MeNuELdH9X5wVsrBt5ikCtKbLMdsIMXxB97LkGd/940RNsl/pkXizmx
	xu8uwkmr3pmBpjAZWRbN331mtr1JNh8f9qlLUyPGXRWrIitJE5lzWzU9FH4MqU1BWjgBzyV/LH5
	6X1Bax7ZR41D++yzjd1IMMv+yMfDXfLfK6Rvl/9EpEBGrPNQ==
X-Received: by 2002:a05:7300:51f6:b0:384:7b4c:8564 with SMTP id 5a478bee46e88-3857131a749mr30457862eec.41.1795863977351;
        Sat, 28 Nov 2026 03:06:17 -0800 (PST)
Received: from spark-da2e.tail8e743c.ts.net ([211.105.22.106])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386c7c62a91sm40958970eec.17.2026.11.28.03.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2026 03:06:16 -0800 (PST)
From: Jinmo Yang <jinmo44.yang@gmail.com>
To: Ping Cheng <ping.cheng@wacom.com>,
	Jason Gerecke <jason.gerecke@wacom.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Jinmo Yang <jinmo44.yang@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: HID: wacom: LED callbacks race with led.groups teardown
Date: Sat, 28 Nov 2026 11:04:05 +0000
Message-ID: <20261128110415.772810-3-jinmo44.yang@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Found by coverage-guided fuzzing of the HID subsystem through /dev/uhid.
No patch is attached; I am reporting the lifetime issue first and can test
candidate fixes against the existing KASAN setup.

Kernel: mainline 7.2.0-g66498c75b4f8 (arm64, KASAN)
File:   drivers/hid/wacom_sys.c
Impact: NULL pointer dereference; denial of service
Repro:  syzkaller; independently reproduced with linux-next Wacom sources

## Report

  Unable to handle kernel paging request at virtual address dfff800000000000
  KASAN: null-ptr-deref in range [0x0-0x7]
  Workqueue: leds set_brightness_delayed
   wacom_led_control
   wacom_led_brightness_set
   __led_set_brightness_blocking
   set_brightness_delayed_set_brightness
   set_brightness_delayed

The same fault reproduced after replacing the Wacom sources with the
linux-next versions; only line numbers changed.

## Analysis

wacom_led_control() checks the shared pointer and uses it later:

  if (!wacom->led.groups)
          return -ENOTSUPP;
  ...
  int led = wacom->led.groups[0].select | 0x4;

The devres teardown action can clear it between those operations:

  static void wacom_led_groups_release(void *data)
  {
          struct wacom *wacom = data;

          wacom->led.groups = NULL;
          wacom->led.count = 0;
  }

The reader is an LED-core work item and teardown does not take the lock used
by several LED callbacks.  Consequently neither the initial NULL check nor
the callback-side mutex keeps the array alive.  Other callbacks also access
the same state, including __wacom_led_brightness_get() and the sysfs show
and store methods, some without a NULL check.

This is the same lifetime pattern as the Wacom battery race, but it involves
a separate resource, teardown action, and callback family.  Rechecking or
reordering a pointer assignment does not close the load/use race; teardown
must be serialized with all LED callbacks that use the array.

## Upstream status

Rechecked against mainline, linux-next, HID maintainer branches, and lore
through 2026-11-28.  The defect remains unpatched and I found no matching
submission.
