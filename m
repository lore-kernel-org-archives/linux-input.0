Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DA627EC80
	for <linux-input@vger.kernel.org>; Wed, 11 Feb 2026 23:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770854349; cv=none; b=QMklEwwgiwxEobbMY++tip389P9C+egXM0G3HXhbr+cfPbFpNm3squOeuYvTXc737oUrhuj5IKipormnYUmQ0Rc0ZESMgri6vZAKm00BZQRpanxHOL6qmqvAX599bgeCh3P6Lvj3+8yPO5rsWetZVjxYUqmEE44zjhVhzRYm6ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770854349; c=relaxed/simple;
	bh=3tkzDN5oUQSuf5UsTnyMk6fc+kvTVOkj1JN2OA1ZUPM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O4ZRxdckHVlO8/Sndvul9Ljd2V7GN5NjMLx3gC8HVywLP9o9RGkVEHmMjH/C5RTtm2+osRlWscWo/5fCP7CTdn+1udqdEt/QwoUMCVqgiF8lTOoWbImkiruFe5CtQTqCq9lqHG8wlO3MTxfU+NFR+Rcz8F8DZ/IPsx7rSzSmtqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cg0BdQPN; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cg0BdQPN"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-65815ec51d3so9358956a12.2
        for <linux-input@vger.kernel.org>; Wed, 11 Feb 2026 15:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770854346; x=1771459146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3tkzDN5oUQSuf5UsTnyMk6fc+kvTVOkj1JN2OA1ZUPM=;
        b=Cg0BdQPN5QyAVqYnIbiXqI+DbqlRpz758pyPX5YOQItqxO1Vu/zNHx+y6VwVh6dU8O
         u8Z4Dhva/89uNmnJNGSD2Jrg3P95AnZSW/5ZcT8HWWm8g+ruBP0jXtr9GdjPUwV2LVtB
         IF25oVHtqL19270inlHwKq4+saT1CWON7XW/mabIXkbQUN/wSwSEOKmYaz1ZK7kUiiMc
         WdVIFHjb4IB+V/fyGGL22fQF9ALxlPnzEph8PVNRgI+O38yRo5keQ8keg0/0WHzId6YF
         8pgy4bwWSrI40yGqJ5UzDMMCRF+VrEtj93r5ix93NX7R2mrY+kufUCM9lwhBUjtXr1Ei
         dqIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770854346; x=1771459146;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3tkzDN5oUQSuf5UsTnyMk6fc+kvTVOkj1JN2OA1ZUPM=;
        b=L56A1HjB09TzY2b7g1rmf8EJhJY2HIxjuKA1oEqJfhLWzN2nElN38mthb8608SWs4O
         qtEdgRGU53FcKi53B57Bx0g6htwJFpJ8H+MQrt0tbQjO3ac7pys+AxAETgSbKVlOqpQq
         TNB+VbOt1WK/Q6MhM4Bo7mM2U3O4hLkaE3t00Ui2m6Lhbjw6FCtBZ07mdOFdk6pomDqe
         WNb1AeXqJpOH9sLnxLrwcmOGXbPa6SUB8wCB25VcJkiQk1qLWM1ZC9d+Cg6hr9aLUJIp
         AxM6x5xFvwhQX6s6YB2+w+zSkAhVRI9/QYusaFNXAwQAz2UL1PEL2Ci9ZkKTkKzgUI4t
         Tetg==
X-Forwarded-Encrypted: i=1; AJvYcCV8NNpcAqB0M3e0t8nvE8MRFP3P6vMnn+QCyZkFSg5Cks/IJ7gY9QFBJLDInnXi4CdIAnwdMEvd1mjUOQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0XzKkImLSypi/Gcjz9SwpBLI13+8H6oHzpxl4tLHkNtp6EgVM
	x0GpJ/e1/DAluXC6DUH5cCrD8l2DzaHtiLfNFIJE8Ava/qaOMoFbLWsM
X-Gm-Gg: AZuq6aLNXJEiFgaVOFYZKbCKu5KvPmW6Vk/MzL2Qpw9QHozaM19tKj7utQL3Gft5m96
	9CcDpMq2KV337Z6E5CzEAqWfRD4KpTJBwaxhHv8Url3yNGnn5qFPjlWJutaD+lIbX6+AhX7MJLu
	zUpnEXO5HIJwuFz9tmMhgc7V/YufB7VrqCYMTIIaI6GikqF6GMl67vn1MwLpX7IX1sTKKTlz5Je
	qN/wlEgmNMCRjGPz0u9NwM08KXlM3D4CXACMhiFs7uA9aELWz8XFscjauH4qDBQXwD/scKLNg4t
	37Pwsv+ZZvGDN6ZThjnhaqqOXa4kiRW+L1X4Nth+T9vS92xMbhFdSS0fXAiYBZvd8lyczmGpUvc
	eNElTxqw0BKzMpM6zJ39D+JI0Mf5/28NAxcCG4oj8aDhjiYEcwF99qQnkw4HYUNySbDuir0eDfA
	6melmUxV8riJcpzw==
X-Received: by 2002:a17:907:3ea9:b0:b88:7093:3ca3 with SMTP id a640c23a62f3a-b8f8f58808amr48805666b.23.1770854346231;
        Wed, 11 Feb 2026 15:59:06 -0800 (PST)
Received: from jekhomev ([46.251.53.180])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8f9561f722sm1593466b.10.2026.02.11.15.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 15:59:05 -0800 (PST)
From: Yauhen Kharuzhy <jekhor@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Hans de Goede <hansg@kernel.org>
Subject: DRV260x: Support ACPI-enumerated devices
Date: Thu, 12 Feb 2026 01:46:50 +0200
Message-ID: <20260211235902.4156624-1-jekhor@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Lenovo Yoga Book YB1-X90 and YB1-X91 tablets use haptics controllers
DRV2604L. The X91 (Windows tablet) uses ACPI to define its configuration,
such as I2C address and GPIO connections. The X90 (Android tablet)
doesn't have it in the ACPI, but the device may be defined as an
i2c_board in the x86-android-tablets driver.

To support these variants, add an ACPI matching table and add additional
I2C IDs to the I2C matching table (the driver supports DRV2604(L),
DRV2605(L) devices).

Also, add verification of the device ID on start, implement a timeout
for waiting for effect playback, and fix the non-working suspend in case
the 'vbat' regulator doesn't exist in the system.

