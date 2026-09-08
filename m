Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EE752BE50
	for <linux-input@vger.kernel.org>; Tue,  8 Sep 2026 11:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788866313; cv=none; b=a4qeJ/E5tpsfEzmidPMKU/rp9pZDKqd4OnBCwI61U0PQQccXIsYCSeAlhEsryVAVYueUZZur5v0byF1T/FdvwABrs+8qdOCbYgNb4mS15ycHJ/aSjTlTzQ/jLEY7HMBMeT4Yw8aBSILRTCMlahiCv3zlLJGdp4GwG5XEhyMRxus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788866313; c=relaxed/simple;
	bh=N1EE5/HFwj8La12KmNKwWRt7P1AzcTsE7MK4yiQ22m8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZmpJKktUPhOGXwHIBQjJbEiEKGAhzHeEer5q7U8QAvHwSke49YS6hWrXa0io4eYJREedQPTcdj7+qZMDv+ijchVM9eWVSsxPCDRwhv6EQQytSvpO0TxTNjZFDQ1sB/Y82rq3M6O2btmVfPSjYZaGSbCDjeuOsR7AIo56z2xi4Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ptaZ7mAr; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ptaZ7mAr"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48441a2ba1bso3240024f8f.1
        for <linux-input@vger.kernel.org>; Tue, 08 Sep 2026 04:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788866304; x=1789471104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EqgF/+AOII+vyLq+5hcCiZzNgkbEl0skMpyhY7dZ7CU=;
        b=ptaZ7mArpclQUFeRCVomDmrTTYbbsnTZzKZr+xrG9B5mTeNqoXq2Yv6tYWxy0eZYki
         TuJqRZrfOjgu+w32AKHWP9sfQmBQwr5FAo0XffM25PzutmZtJ5Q47avfMkQKeOieghAf
         wamygwLYQZz5asq9lxw6/dQ6orfvmtcfiS1h/vTv3XtqR7h8TwU+29Iyybbt86f5qqjh
         TUP/7k7fKTlMLK2+ZFi89v+/g+RvCVIXBpaTJpiF1RKDz4gfHSjEjNETB0v5lyUoJb8C
         7wEYz3jcZ5Wq1mqYQPj2LkiOCgtsKSfKebbYPUYFuE3J80U9bikN8iwnTBhWgdzodVuw
         Y6SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788866304; x=1789471104;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EqgF/+AOII+vyLq+5hcCiZzNgkbEl0skMpyhY7dZ7CU=;
        b=YOLd+UohtJpFoSlGE+eD7iebm4rz86H7/TfIfvz0xOEyeIOWFiXDSg4zC06cbd+1Wc
         iB4xwPT01+09tbuOvBv+W836TwUBIZLgzPSJaCn8/WbTfo6/K7YdwBpBAIBD7TC3b9hD
         SPhM2dZ97SYpFQTOti7XEzjliQ1rw7QOt88Iskz8S2kM+o3QQ+0+zx3j1twV7aOP11DI
         QzM6B5KTk08JuVpCoYyNWpSdFRxB7ZLGmhLH6zyqBQshDkJCsCRLp2XOiFspE9f8VXr9
         li7Kq/FCxqAohU53fW0bTNga4QhPc7T5bm+fIIuYzilFO1t3OG/2sb/Ss2G93kdgqPyH
         WEkA==
X-Gm-Message-State: AFuF++m31V4a/V6bk0B3sT60zp1B5cg1qAgsrNWGCkhqIzOySSr1HlDG
	5REiQzfAL7Ha+mlGFscHUgtcxB/K2jtCCz9f8x32kT4vMv0dKIDGmwnQ
X-Gm-Gg: AYBFou1KjDw5mSyA5gWJb/iSzKfOeohngMz/6M+AXB0Kv/dTtDngxeWrnaJC76qK7vS
	8qv3tkDjqGpfyNCoMAQzTUj4c5IJDzfiUBpNIUSHpMAc014lqX8CVsIRTxhe9yagVibj2nARt7P
	YidJP1UygD8de/rVvVyR8VAIxLR7Mpwk6EzoRoVQmlS/C+hR0HEkEFDCGqzUqzhfHxoi/p9J8EI
	98oxr56AsChgzBXD0US7JF6SA5033cswdbz7x+0Kg9YxrIMbbbogFqRUc0qAckx3BqDY5jt8oMo
	T7fZldnTNUKAv3ApbDHqPNSKChzZo6D7GX08FwnZewvW8mtAez8vZ6mmm6E0yLnqi0eX/hDWSXY
	E7hXIfJoJW1LmAUaBT1oFBINfvVzvKUuiffz9Vj+nbf4Br2kAI02H4jebCEIZZkMKNBj6ccijdc
	QQH2aS3evrvd5HDpnjVJUQMRUfN6z08rVUhLOqw1g2St7eHy4h9Nuvyz1zMoqNDQnQbRV0FTpIY
	g+iaYyng/djWTY7fvOBpcupaA0UkKhKOqw=
X-Received: by 2002:a05:6000:605:b0:485:8c16:a360 with SMTP id ffacd0b85a97d-4858c16a6abmr25770017f8f.56.1788866304271;
        Tue, 08 Sep 2026 04:18:24 -0700 (PDT)
Received: from localhost.localdomain (mob-31-26-103-238.net.vodafone.it. [31.26.103.238])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-4858d2693e8sm34422099f8f.3.2026.09.08.04.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 04:18:23 -0700 (PDT)
From: Oleg Keri <okerixx@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] HID: Lenovo Yoga Slim 7x Gen 11 keyboard fixes
Date: Tue,  8 Sep 2026 13:18:10 +0200
Message-ID: <20260908111812.43837-1-okerixx@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two fixes for the ITE keyboard controller (048d:83db) on the Lenovo Yoga
Slim 7x Gen 11, a Qualcomm Snapdragon X2 Elite (glymur) laptop.

Patch 1 silences a one second timeout on every probe and every resume:
the controller performs its reset but never raises the interrupt that
acknowledges it. Patch 2 suppresses a phantom KEY_RFKILL input device
created from a Wireless Radio Controls collection that never reports
anything.

Changes in v2:
 - Posted as a single series. In v1 these went out as two independent
   patches, which was a mistake: patch 1 adds
   I2C_DEVICE_ID_ITE_LENOVO_YOGA_SLIM_7X_G11_KEYBOARD to hid-ids.h and
   patch 2 uses it, so the hid-lenovo patch did not build on its own.
   Ordered here so each patch builds standalone; verified by compiling
   drivers/hid/hid-lenovo.o and drivers/hid/i2c-hid/i2c-hid-core.o at
   each step.
 - No functional change.
 - v1 patch 1: https://lore.kernel.org/all/20260908091926.5773-1-okerixx@gmail.com/
 - v1 patch 2: https://lore.kernel.org/all/20260908091907.5653-1-okerixx@gmail.com/

Oleg Keri (2):
  HID: i2c-hid: add reset quirk for Lenovo Yoga Slim 7x Gen 11 keyboard
  HID: lenovo: suppress phantom radio control input on Yoga Slim 7x Gen 11



-- 
2.55.0

base-commit: 5e036ce12de91c6fd674dad33b169c6150be2a7a
