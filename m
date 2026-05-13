Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E930E34753F
	for <linux-input@vger.kernel.org>; Wed, 13 May 2026 16:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778689973; cv=none; b=HDaPol/Bq7RHe9F19QERIgv9nVNyZaKQAUBCVUiSVeJMpcW1rcyJfMYhwgtfrpUFrNO+4YNPvHvY08kfyYCJfv3Sw03Eg98/yrMXkSOVKJGjhmQSg5GOCf95O66HSkXa8UKH8XKAwiYAtZJesRykOXVG+p9BQZqjaW7gXN5whiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778689973; c=relaxed/simple;
	bh=tXmgmeON+x+fK6S3mbbTB1q4wvFyJX5da1PP2wjEivc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=RT0AFysfkh9Shl69STbPhOoAA019bLV6hR8eBdxa07bAr7eLkROaDVmlcKXgN4D/skaipvbIWiec79hUSmSxgaWj6c+Z6nFYDmAkbPCynmVvv/xjxn6gJ4YLzObOEAU8KQaCokXtiNtuet25jLlN2QK9+LRP6aLSiY3vcacbfXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JXYzcsWx; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JXYzcsWx"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4891d7164ddso38766185e9.3
        for <linux-input@vger.kernel.org>; Wed, 13 May 2026 09:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778689970; x=1779294770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=1MCd7TL0P6Cc2ip16FuZoJx0b2rK1VM6mlLmVjTAQq8=;
        b=JXYzcsWxBJxRoo+gIIPFn9HT94N6gr3vct+udTllxGw28FdXLfELsnGdAz1gms4Qsi
         ba/wuyZTTUNu1WSPLBTWcw24GvbGxe9z/tOvKtHGS+9DiHE/mCwGB3QMP/FzK/4hVNS8
         vsuZFLHDTG1hLz9GrTkULO17FrIoq9EoQP6PPNF/4h1EpywMHsrt0qkR1Z2SsWnck+W1
         s35HRXLHzQb7B2GQOhYfcIseL5Ti93i79CnH3bmmg70rWgN6hR04poirxTo2OJYdm2js
         cSwfDWvvTtByWPpt9+fymGBFiXvPDCfNtI6PKUmZ5glx0UiX+A7fKWUaqqk6ecOTS35m
         JceQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778689970; x=1779294770;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1MCd7TL0P6Cc2ip16FuZoJx0b2rK1VM6mlLmVjTAQq8=;
        b=Fn9WO31yKCRL57snteLSqnuKOQbzPSAK1a9KTwgfzS0uRatn10Ov79cqIfOutaKgnu
         w9zQBcdqq9HpIUl8EesHQAiM/28h03hMiiK/o+eJ7gt1NnXeuyfGJpex1YKBNpuix4TB
         lObhkCBu4TsGab7ETTW5Kpij812PwjlXgJPOR5dr3swl6CjOKoLTkch271952GWEkZrv
         9yORSI7ACk7XQDOf4rL3RmWzgM67ek1s2lhg9PAnFDOQt7kaoN6vPYStDtXFxWDQXNgE
         U+QvaJWhIwqq1owEPe2U7r81gluYOzMLOzk97PViu3aPkvcV5sNnQctHkCHMWl6j9g3+
         CV8Q==
X-Forwarded-Encrypted: i=1; AFNElJ+m41BMRnK2RANcp3BlisOKZqokUKvzjuAo1Pb5TWUqvWErbVEuAI/A8droB+EDI1ToGmTvClMg9BmreQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9GlKRzVAsvuzHGGx4PbJW4ZkXZD5T1Rwbx3dfrjvWJSb5lqEy
	cgyqGtoPjOOGWHOwfDVBq8NfCOVN/a286T7Qi9y3FfM/AnZ2LwKG6llsHoOwExP7
X-Gm-Gg: Acq92OHP9hN3uX5iAKwwZMfbHHxyuddRGKqYC2FtVqAIvussxAcz96+lhjqeUeCgVqd
	Fv+ez9kTwH0p1uF5S4/tWXX5M2bs86+rYts2THfz3n5TNIrBb0YYwUq3PgybxT7c7QSu+68GDy6
	W3P0niTzDLIalfO7tLTJD5u1WoJf1IyMA67e2pXiGY2h1HT9gjNBqpMaFstfoB71sN95tXehsCn
	YHjWnK8P5yQK2xeo9FmdLCtnFXuE60gkvvpS0JP8hXND4A948ivxLkFjGDvYQdcZg+PEDCTpAM+
	1yl658r8ypo0dv4sqzzaAbRQrWcXyCNhI1cWY1bvxHeuEEiQvDjGmNu7CP9WPhvoyjzxaBs9/ro
	Vh6Lx1l3f0+aWrgfYC1oTbAcemrgJtJ1ZBVTGt/aJS7jwtz4zkBvEhn5N4fJ35XS/Q703HFwxY1
	9yJPoagaSBgQOiWOmgZT+YGZdxr8xq158q2lpzy5JKB/v4oyoujPpF2t503c51p+zdQ77cwVVSG
	HtZV9t+Vq/UcZvX0Q==
X-Received: by 2002:a05:600c:35d6:b0:489:a4:e58a with SMTP id 5b1f17b1804b1-48fce9f38d4mr62135025e9.19.1778689970206;
        Wed, 13 May 2026 09:32:50 -0700 (PDT)
Received: from gmail.com ([91.126.139.18])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fd64a22a9sm2101225e9.8.2026.05.13.09.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 09:32:49 -0700 (PDT)
From: Paolo Pisati <p.pisati@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Subject: [PATCH 0/7] ASUS Zenbook Duo keyboard support
Date: Wed, 13 May 2026 18:32:41 +0200
Message-ID: <20260513163248.16483-1-p.pisati@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the ASUS Zenbook Duo line of usb/BT wireless convertible keyboards.

This patchset is a collective effort, gathered here:

https://github.com/NeroReflex/asusctl/issues/25

Tested by many on all Zenbook Duo SKUs: UX8406MA, UX8406CA and UX8407AA.

Joshua Leivenzon (6):
  hid-asus: Fix up Zenbook Duo report descriptors
  hid-asus: Add missing Zenbook Duo hotkeys
  hid-asus: Add report descriptor fixup offsets for UX8406MA USB
    keyboard
  hid-asus: Remove more bogus zero bytes from some report descriptors
  hid-asus: Fix input mapping on dedicated vendor HID interfaces
  hid-asus: Allow adding custom hotkey handler logic

Luke Jones (1):
  hid-asus: add prod-id, quirk for Zenbook Duo keyboard

 drivers/hid/hid-asus.c | 126 +++++++++++++++++++++++++++++++++++++----
 drivers/hid/hid-ids.h  |   6 ++
 2 files changed, 121 insertions(+), 11 deletions(-)

-- 
2.53.0

