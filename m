Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4A7391E78
	for <linux-input@vger.kernel.org>; Fri, 12 Jun 2026 07:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781248998; cv=none; b=RRDU/XQuXwG8pY7xEhzzFFz/bOq7NfTwgcwvrWQpY+if7pRJ5A0eWmJEMLTWtUBlcV3WdFXouAdv0MzcTekCBPqPxQPI/newTDLxfwlg8pQo5Ut5DU8i79MicNbSczIu+1lAYmy8MHHEv7cAFmFpfo/EPMDjhPCWphY5QBpdiPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781248998; c=relaxed/simple;
	bh=wOknFjzqkqh7OBwN7sW7WuNjrpgW55bXIaFMaLsAyO0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eGqX0KXxVA2rciQM8oLwjQBgYIdLSoVEdXj0X8a0H0Dp9P24KDzNB7214+/aBN51ms7nsltuxx9OiDLYI7nRQk/hltxWP0UGqz/evkiqkchzZn5EqpfQr9OqHIAx7laY0FytbeY0UNI/GfVXuD/vBGb6TbDkCb/G6d6Nzm/GUPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JlfolYJQ; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JlfolYJQ"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-490acbb0f89so3793465e9.0
        for <linux-input@vger.kernel.org>; Fri, 12 Jun 2026 00:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781248995; x=1781853795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0JRjzoUDlOq3zaFX4yGpbHVKKzexuP+Q4SOjOyUGKOU=;
        b=JlfolYJQhMxux3KOLewK31uEtZ8xF9B6NsscntI+GiW2eKICIUTT6uMsKa5YhfioPe
         CyxpzaZkdRAih2/+j6GVf1PIXzulO/UyNx7PdPsVh6pqWrMedmxyq2bXkaaSK13Bsx9o
         gIVGQbNYk+s9lOzjpztVrgGy+hlk6HqS7GR7907fCAR5dg2TEVjiN0An7W3sU/u1o3eD
         UCR7FPz9W36REESJ7a/ORFM8T188DZ0b2obw3Nz/FAqjVMe78hJGQbNA98cmkog1uHvc
         7VShW7ZSf8rR7qYDxRrlbeY9N8E1DlZuT/e61Jw4B9ostDbW5ObbUDRQdYqv+5QG2M8Q
         IOvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781248995; x=1781853795;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0JRjzoUDlOq3zaFX4yGpbHVKKzexuP+Q4SOjOyUGKOU=;
        b=cI8AUeLlr7nWoqm5w8iNC1ESyaFTWHaZZqHGB74mFqOMJV+zddT8nyWoZXO15P5nzG
         fyvukbHXCnusMWau2J1l82zG2Tw0KxxxEwuBY2P8U8ga8pP21NmRWzpOcEfU6JfS8Bwe
         l6yheFMdKkeLsUpCqluLV9gvMqK0up5VbDRF2MyBsfbHtjKsSocE0/WzB3saim9stu4M
         l2XJq32QjHYLvdsdm4+0+WpmOcpTYL8jeP4QHGZkryq+N26BuNcmP9sDw8o1GhX9+zga
         sZkJlBj0iRZCMmIBAn88DAHatPgqLx6j4i9uQzWOSCSNaGWUwZbOVfCtoEW5StmtyAnX
         gHQg==
X-Forwarded-Encrypted: i=1; AFNElJ/uKQ96CugBVWDp1pDxc30+LggpJqqwkK9f0STtMSTVi++CuwFBB+t/KFGtmav1plZzIz5Zz16MTryjXg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb5rKi6+Ou68i768YrQeQfjMnSTULSoWttU6Jy1negjinxJPjv
	OThFWFc3qvB5Wkuyx2KVtXjvu2NSmI8GI7Y5QYvL7EEzY/i9G21rKWYY4VnXHqTYQ/M=
X-Gm-Gg: Acq92OFnJH+Z8elP/UrNJYyuHcFyaFulnxcjInoLc11zA1dD2aZQQ6S07b0Fdid/vvk
	4QhmiNf937Spr/wN46Ehbh1SazxvzI4gUQLSpgSMvQEbHckhN400wLndWahYSgoj44j0rJt2l9I
	53i0Ychmka2K60Je4Oe3pDOfF7RSAIr4gcDNRHHZaCZGZQITUQS1ql7sRKEZZvvkT+herihf95Z
	q/FanZ2A4KRvXM9qaEHxzCb1Lph1IWsbBIhp5JeeqNV1pCUd26qFa6JYeJbxWz6+U6OneGXH8k7
	1NJMBzjtUXpXUPgK7mLZXDUV65JoEL9Pyfg+1BUiriFvLHFTUEX1q2f4Zgc1HhoYdUVLhTA1f22
	JkHAG7ZiFV8URBqznOJ0xHfU0ZlWv7okCyDhvfEJstRF9+nmwrqWRujrrxhSG0etgB6trv/uRga
	a3LidlsMItF9RapkzZBKVRvxd4Yn2L/CtJbghQHMc=
X-Received: by 2002:a05:600c:46c4:b0:490:e60b:5fd6 with SMTP id 5b1f17b1804b1-490ec4e7b61mr18919565e9.29.1781248994806;
        Fri, 12 Jun 2026 00:23:14 -0700 (PDT)
Received: from arch.localdomain ([2409:8a28:a54:e741:3a5a:3245:d3dc:4b5d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490ea963cf8sm28715245e9.2.2026.06.12.00.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 00:23:14 -0700 (PDT)
From: Jun Yan <jerrysteve1101@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Jun Yan <jerrysteve1101@gmail.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/9] Input: cap11xx - Add support for CAP1114
Date: Fri, 12 Jun 2026 15:22:06 +0800
Message-ID: <20260612072237.1177304-1-jerrysteve1101@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CAP1114 is a 14-channel capacitive touch sensor with 11 LED outputs
and hardware reset support.

Patches 1-4 perform driver cleanup and DT binding tweaks.
Patches 5-6 add reset-gpios support for CAP11xx.
Patches 7-9 add support for CAP1114.

Changes in v2:
- Drop LED property tweaks, keep only reg changes and node regex
  update in DT bindings.
- Split microchip,cap1126 LED reg constraints into a separate patch.
- Replace usleep_range() with msleep() for 500 ms delay during
  reset pin handling.
- Add missing <linux/delay.h> for usleep_range() and msleep().
- Add CAP1114 to unsupported enum for microchip,signal-guard and
  microchip,calib-sensitivity
- Add constraint for linux,keycodes to support CAP1114.
- When reading CAP1114 button status, mask STATUS1 to bits 0-5
  and OR with STATUS2.
- Adjust code style.
- Link to v1:
  https://lore.kernel.org/all/20260606150458.250606-1-jerrysteve1101@gmail.com

Jun Yan (9):
  Input: cap11xx - clean up duplicate log and add probe error logs
  Input: cap11xx - remove unused register macros
  dt-bindings: input: microchip,cap11xx: Update datasheet URL and LED
    reg range
  dt-bindings: input: microchip,cap11xx: Add microchip,cap1126 LED reg
    constraints
  dt-bindings: input: microchip,cap11xx: Add reset-gpios property
  Input: cap11xx - add reset gpio support
  Input: cap11xx - refactor code for better CAP1114 support.
  dt-bindings: input: microchip,cap11xx: Add CAP1114 support
  Input: cap11xx - add support for CAP1114

 .../bindings/input/microchip,cap11xx.yaml     |  85 ++++++-
 drivers/input/keyboard/cap11xx.c              | 230 +++++++++++-------
 2 files changed, 224 insertions(+), 91 deletions(-)

-- 
2.54.0
