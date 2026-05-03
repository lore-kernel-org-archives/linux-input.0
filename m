Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B933002A9
	for <linux-input@vger.kernel.org>; Sun,  3 May 2026 07:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777793215; cv=none; b=jyh4AOZK1dUa8ofeqaBK3XPxdWvp1bH/XJXFxQ2sHybn1DWUzZU7mIs2X9g7R2ieRwr0efGUG6ssrEBU9GelC2tpzEX2IClVUB1GhX6QWTa8aInISECTqjmg2I/vTWUabv0t9PYNk7hjCtimIyxW5kOblR9vb8DAvszjQOGiKVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777793215; c=relaxed/simple;
	bh=UpoJXL13k7fWNX5kvg8RKcGJAk6mYEmoxDqLy7+7nKs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IQVeIoZGTey0H4fp0s089L1FIoKNQeiwxnXMjorVpV2++k3cJrxk93NLmMhe+anS2k2VrGOrVHfwthQo+K/G0UVOIi1u6zcSTE8PT587C8eBdQ6OFlaZcd0Xb26mCy0PWPfqNTjkP33uzpXSR4rBbXycCmrB+1aHVOs63VxWbBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QOvl7mDy; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QOvl7mDy"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-364d72f2986so2000748a91.3
        for <linux-input@vger.kernel.org>; Sun, 03 May 2026 00:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777793213; x=1778398013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/YtxFZp0eNrtQnNfc9ZwPYsuCM0PoH8dZHMhxhkiOR4=;
        b=QOvl7mDy2P3IKQKvaQrbYBWZB+qljo4Q/PMTUbkJbpQtoLOQUHCCmS+yuWItS0SjtH
         50j4wb6386TfWwAiHEfLq1J99PkW+Pfw1tF65o93EzFibHYoS/KOCy6UlJplJymhZI/G
         C3mfGVSrmzl5t3f+KZCPsHxcUs72UZN6CnshWUkQXKErUknHuCQkqN/Re1ALzFYCOba7
         SF8bP2KvEt1pO659F1InnASGXQ6fswquzaeinStBW9jsMmdMhR70xCR6J2eVamoEZ5bs
         Opl9ltgeMeVzq7laG04d/JWwKhlNen9WnbthjUyuelegLVwIEgMjaObouD9xnMnNlqPI
         En4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777793213; x=1778398013;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/YtxFZp0eNrtQnNfc9ZwPYsuCM0PoH8dZHMhxhkiOR4=;
        b=H0+IzulQ5Xc+nZ/uJCQ+vxEl7K5PAcoEjjypJqTQiao7DbEagHbUbLGYZMtkjBaOHG
         +7argIfgyOfITS4EGN9xmzr2URl4fFRUC/m6ibzap0hc8MB1KUcpCXsjU3FnRUjn8TfB
         Ud1BH5j3qFcsLyuwMrLr+Lq5f0XtcdYVkkIaMB8ljQKbcgK7qrexvPiYVezsEfHcB9GS
         D5ero9XxcRGqDROcJrxBr/ZE4AYiroS5FCN2E5EDEyJQKqRtVa+OO6bDR1DkdBUP1WGH
         9iZgyKuAWMfgOzNuYXZWhMX9LoqNuEC6qat9t4Xb5qeNWWkRs9ESFeIDhZMnbgRZBuQW
         jw+w==
X-Gm-Message-State: AOJu0Yz4OnBUAiS2htPwaePW0xTH0U66pUtkggNpY92xhdrW2I07UNlp
	Djrl7Pv+Xv2C21Ez6z6KNL3QUFf0yx6/GetzBhBqw1Iu88KKM6K2stdF
X-Gm-Gg: AeBDieuY96v+KTXr32sqdet1uVQWQW96JGb8KAF+nbeOnUqYtm/cH9ChZizKe5xkddx
	/yhMMK5Y5rcM99FH0duhQLGkMM1d+m1spEkvCGIHGTihToaG12uNsSe85tdlCy+dstIGJNhEHZs
	MhpOizYmdQpynAKySPBKUZ9LNjdCiSnedD7rKd5WSIEWu66pHxHLmPa20fMPU5lk9ZwKh5Z6r/A
	ja/l3/wMEkEv/EynEa5WF18T8kG3wZ9exq1GNKnSMDqJ1a9Aexo0g2FllMNSZd1/stCGbV9A12t
	19ombz8A/ubyEN3eh/QClBMdlPNJ5CdBaaTdC5wViCoajacQGAchH1tcLomTEyHRFy4v9hDwrvR
	xSJHe7nkIXO2hHkdmiwcgnIItVMdAulpZtWAI+hKp9Ikp65sXY02brxDe4b8cTM5l/i0o1DS6d9
	gU8+k3Zo/f28W3oGKrdyosvUF44D87i5/mxqz+VxszbRezB0B2wFspxt0nlB/yfthAQnyAxNp5D
	YRmV14v
X-Received: by 2002:a17:903:1d1:b0:2b9:fb9a:1103 with SMTP id d9443c01a7336-2b9fb9a1206mr40015365ad.38.1777793213276;
        Sun, 03 May 2026 00:26:53 -0700 (PDT)
Received: from tranquility.wa.lan (60-241-74-71.static.tpgi.com.au. [60.241.74.71])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9cae16a9esm64942945ad.50.2026.05.03.00.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 00:26:52 -0700 (PDT)
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
Subject: [PATCH 0/6] HID: asus: add support for T3304 keyboard
Date: Sun,  3 May 2026 17:26:37 +1000
Message-ID: <20260503072643.2774762-1-jye836@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds support for the ASUS Vivobook Slate 13 OLED (T3304)
detachable keyboard. The keyboard is a USB device presenting two
interfaces: keyboard and touchpad. Basic functionality already works
with hid-generic and hid-multitouch, but Fn key chords including media
keys and LEDs do not work.

To add support, bind the keyboard interface to hid-asus. However, the
ASUS-specific report descriptors are on the touchpad interface, so fixup
the descriptor so that hid-asus knows about them. Media keys are also
sent via the touchpad interface, so add MT_CLS_ASUS to this device in
hid-multitouch.

Also included is a fix for a use-after-free in hid-input.c discovered
during development, but technically unrelated to the device.
("HID: input: delete hid_battery on disconnect")

James Ye (6):
  HID: input: delete hid_battery on disconnect
  HID: asus: check feature reports when determining is_vendor
  HID: asus: add support for T3304 detachable keyboard
  HID: multitouch: add support for ASUS T3304 media keys
  HID: asus: add microphone mute LED support for T3304
  leds: led-class: mark classdev as unregistering early

 drivers/hid/hid-asus.c       | 117 ++++++++++++++++++++++++++++++++---
 drivers/hid/hid-ids.h        |   1 +
 drivers/hid/hid-input.c      |   5 ++
 drivers/hid/hid-multitouch.c |  10 +++
 drivers/leds/led-class.c     |   4 +-
 5 files changed, 126 insertions(+), 11 deletions(-)

--
2.54.0
