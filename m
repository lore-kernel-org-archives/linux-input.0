Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425AA3E3C5F
	for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 23:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792366031; cv=none; b=pUBWQYIHkqsDiVUFfFJrw5DaNH53PCNUlfu0ptCqDFnMgy317EOzopWoTXrFGKFDNOnJBkBYm0BLmBHCNN90G1P0oyIGxcVx2pQDKaZ4PoVPgr/+BNvFmW6EzVWGwAyx9rH8X0qRq7OhOoZHorzxzJD1NCRsjMUKRc5FP7pdyxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792366031; c=relaxed/simple;
	bh=2KCYfLt5qJEmI2+WklOncv4iJAcjrI56HEp0rR9tV7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Og0LqozYs99d6hhX2rGQdIRB8TXDjCZPN1SxYia1m7IHyA/VJRnGR0qJ7hPopBlklvFe/JgYyWKtf8N00Ld/SuQYJHJ+hIwFwV7+T2r0/hQOIN9jGMR3HwSX6F8HpRERM3+1ACY4aX2nutrJ7iJxxBgs4gndinfsAvawyGAmYWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KgZaHz+D; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KgZaHz+D"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-35ef6b49813so2964029eec.0
        for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 16:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792366029; x=1792970829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J5TdL2Y2ZbBg8GY/uY0EyJ065wBCuX4tK3r2mB1aNq4=;
        b=KgZaHz+D08IdWnVzWH67c1oxo2wjsiCe5c+KnxaH15G1S2lzu6sHAk2GHeB/riBYUU
         ucTNFFgwCYr658NWacdCcQ9yP13+47qQ4t6maG0G4kufpH3Z0IQ3epki1945+PBqeHQP
         Dbk751bWYhw+2HMMUctj+nPuv8VcooZkf81TSQNsqHcxUYQaG5T6IikOn8On+KfDtfyZ
         fD3O80CHF6+wfrFNapUwtWr+GIQyoAqqkZeq5dcQVixBmPXG9LpKwIpdYFdEa6DbAvj/
         89BLAXDfRkN9FSUBwhiHvJx7xL8L64a8dY3oKL5eAqr9ckIiEGl6VUIsD6cV/EduHaK4
         Jh6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792366029; x=1792970829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=J5TdL2Y2ZbBg8GY/uY0EyJ065wBCuX4tK3r2mB1aNq4=;
        b=OLHdxpKG4YHXVhK3qM0bsQlsajGiMAuyxEM6VtZ8ZNfBbVuWZzeL7rVF3rffbeJtwr
         FfoeyXz85ALhmMPl3AT0dq82ru8vLX1G47BozVdR41FvIFR9cGX1+iYRNWH8bQnKQzLX
         5SQRC0pJFaN3StVPp2rzcKaEUVz84oIeQlsezIftj50X2NmAsprCjzU9+3IepJvTXaHG
         eJ4AjTLE4/E+tyt4OL2q3PJvabeCeglIJt+ulJYuIILVgjbep2I1WYLn6SzSGx9kEzFA
         4HRfp90hHydWhRLPtjv1Aq3DIontHkT9Z4XYM8Fv8UOi8hBgEhm3DDxlgPz474SzRzSM
         OZyw==
X-Forwarded-Encrypted: i=1; AKwUvByvwEhc5i/ZEl6b52BgfJdYSjhlflUy4QPGMc/yM05nBNE19KKsSJ/QYrm/uBegfKSO7+Q9WNn7Mfz5dA==@vger.kernel.org
X-Gm-Message-State: AFq9FYJ8tSYBslv3/i/Oh+Idp2yweuD4IdvFhA3bbWyCLBoB17w5GP6l
	0IgSzapRfmO3WgzqfZANUwDDXGwiCC55Y2y98Z3+LbeB+tfqaLBwlG1M
X-Gm-Gg: AYBFou2ViAXle/rmX9e2Vfdygban9al0R9fLhlLb81ZbdjQnc8tmaNUVkgOYxkida6g
	hNTbkvd2K3pxJrx+Daai1MaANkCh0t7/wHLI/hBQIDQjXfmeAu5jbgmswar+VBuNYVOEce6OI0B
	6JZisnPOMPLoT6IxLPP8ZIFIDgO4OLyEJJyA3J12iiDmOhuOa75BOcFlZVaGXnzGek4upFhvuSH
	8Ap5MZ6jjKy7BfLck4VBpZGoGRYzjY64TEgiN2mBtlvLyCbGgxoRfVJQNs0h+v5WYtFtIprYqLH
	q6fdsSNIlLY9cqdbzFHiPFNBrmo6RoINBjyVYa9kpiuvThb0AZI1Xg8D/I5UGVmy+4iHdMRfUQP
	EWXi7Ds4kn16JJTs5v1PJX0j89nu2h2HY6PVCsQTUmNk+menaGQfQLf4GTDUIiUwL0FB5+ui/PC
	Hm2YB2MXPNvxw0OAC4sG1C9C+qiJqN22NDFp0BoxmaMumPrCJbhEoXa1qV1JpHWD0h+M4cZWxVx
	qa7l/oEPkb+hBYM7h1tQ/2exTEItlPMuUEfjPeqXNA=
X-Received: by 2002:a05:693c:884f:b0:35f:2858:aa4b with SMTP id 5a478bee46e88-361a2c36e5fmr8217730eec.30.1792366029272;
        Sun, 18 Oct 2026 16:27:09 -0700 (PDT)
Received: from siegeengine2 (c-73-158-156-210.hsd1.ca.comcast.net. [73.158.156.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-360813b6ca5sm25571908eec.9.2026.10.18.16.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 16:27:08 -0700 (PDT)
From: Mark Pariente <markpariente@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: =?UTF-8?q?Filipe=20La=C3=ADns?= <lains@riseup.net>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Mark Pariente <markpariente@gmail.com>
Subject: [PATCH v2 0/2] HID: logitech-dj: Restore device configuration after reset-resume
Date: Sun, 18 Oct 2026 16:26:52 -0700
Message-ID: <20261018232654.70571-1-markpariente@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261018224627.60328-1-markpariente@gmail.com>
References: <20261018224627.60328-1-markpariente@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a Unifying receiver is reset on resume, for example because a USB
KVM switch moved it to another host while the system was suspended,
devices that reconnected in the meantime lose their configuration. The
most visible case is HID++ hi-res scrolling, which leaves the wheel
about 15x slower. Patch 2 has the receiver re-announce its connected
devices on reset-resume so that hidpp reconfigures them.

Sashiko pointed out that on Unifying receivers the re-announce can also
hit slots without a known device, and that HID++ connect notifications
then add those devices with an incomplete report descriptor. That can
already happen today, e.g. when Solaar sends the same request on
startup, so patch 1 fixes it separately: on Unifying receivers, unknown
slots are enumerated through DJ notifications instead.

Changes in v2:
- New patch 1/2: don't add devices from HID++ connect notifications on
  Unifying receivers (reported by Sashiko).
- Patch 2/2: code unchanged; the commit message notes the dependency
  on 1/2.
- v1: https://lore.kernel.org/linux-input/20261018224627.60328-1-markpariente@gmail.com/

Testing:
- Both patches applied to the v7.2 driver and loaded as an out-of-tree
  module on Fedora's 7.2.11 kernel, with an MX Master 3 on a Unifying
  receiver (046d:c52b) behind a USB KVM switch. Devices enumerate
  normally, and hi-res scrolling is restored after the reset-resume
  reproducer described in patch 2.
- The unknown-slot case fixed by patch 1 could not be reproduced here,
  because this KVM switch fully disconnects the receiver, so it was
  verified by code inspection only.
- Lightspeed, Nano and 27 MHz receivers were not tested; patch 1 does
  not change their behaviour, and patch 2 sends them the request
  logi_dj_recv_query_paired_devices() already uses for them.
- The investigation, patches and changelogs were drafted with an LLM
  coding assistant, then reviewed and tested by me.

Mark Pariente (2):
  HID: logitech-dj: Don't add Unifying devices from HID++ notifications
  HID: logitech-dj: Re-announce connected devices on reset-resume

 drivers/hid/hid-logitech-dj.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)


base-commit: ae6927c533a4454570950125ca8ba909c45f20f9
-- 
2.56.0

