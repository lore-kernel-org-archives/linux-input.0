Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F6F3976B8
	for <linux-input@vger.kernel.org>; Fri, 13 Mar 2026 17:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773424641; cv=none; b=i1E7IGCGvedPNxhcuKEVMcr0ztIz+3D8cGrpFqHoiLWBz9dwDmn3BCoTnUs9mZDr34ufejkVU8P+PUHNlVx0789wj86fL6Ag+gd7ALN6lesIgicw9EtSYZJ9+eDMdewhWzv5C8gSo77j8JyWIZOl9lBosOoKD9fsXRDh68Ire/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773424641; c=relaxed/simple;
	bh=G/DWP7lS6Mqlc8ayUdcrbKdkSDyLoqt/nu/Tmw5FD4M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tJdNeVZ4nV0LyqjTVf8y2B+zZXHimszqwaaaqS37mb83J9txMDtNzb9Wjj/3VH8VKVKo2dnVUQorZXn4JYw/S7hd2Hu1lox1zaNcoHB9mhWBo5MFFrAqrgG6Xa6X04A2yFkoD3owcl+qNFOLARZ/+DMv7srKuECqgZmtTjMskho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=frame.work; spf=pass smtp.mailfrom=frame.work; dkim=pass (2048-bit key) header.d=frame.work header.i=@frame.work header.b=jbaoI4K0; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=frame.work
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=frame.work
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=frame.work header.i=@frame.work header.b="jbaoI4K0"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-829759ca646so1493317b3a.2
        for <linux-input@vger.kernel.org>; Fri, 13 Mar 2026 10:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=frame.work; s=google; t=1773424639; x=1774029439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=syrUne42gSSaKW4UIiAh0I7Vm51GofLNprwIsH6UNgE=;
        b=jbaoI4K0VByCOYEAXsYwsOKpv14Edid3txJsmoAsyHTlELb0tAPJQBWIkho8OPPrUi
         LPHMpKS/xIdVRDiQsNrliSMc+s4Ivh+Hs7R+n+eCupbolRg9owSrpAOeb1cJwdlKHdRh
         xTJXej+2UDxn2O8oJBWROr98KJ7S8wmHloDeCqFjM27sBQGTemee4soayyDqk/qMHN0X
         FwsIv6NI+F+ySlpiRwe3eyKIwSwLmQRS2Bbk6BgsAKtVYqpD07sSpHXyeCUMY6/0VX8J
         KXly6ZolWX3jqU4e0Tx5wUxWNC5fRyezqVKLAuNCjkLpUKgutVvYucOteXLAUKsKoPfV
         Iehg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773424639; x=1774029439;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=syrUne42gSSaKW4UIiAh0I7Vm51GofLNprwIsH6UNgE=;
        b=sF5s87C4rOjLx0mrVWVk46Q3M1b1lWzlE4n/sSfUhl3f/yuIe05+JEGpuso4WH4FFG
         8H3M6pKhSscyqOBgSJuVfBp61wMFtodj9ZhjjyQifIBKbJ4XepG2CkpyXAiEQkUw+R+M
         UgwcO7ASZR3bpfa/Uc8xGH2hRS/ePJMQHpPlkfxDFqcPM4xpLxzXa61qHdogUwcL7AtM
         tBK98C7RJ/XsofEgcP5ALmccU1dikqD4lKMtvUo5m8MTpka+B9TASRBkJtFMz7k4kg5B
         tyOomdUAsP11rvlrOtilM1EkVyOCmx0sI4h6CorlXK2RBoro/g/fnV8GiIAcisBDxdr/
         U+2w==
X-Gm-Message-State: AOJu0Yz1xdqwja4VJ9YBxJdR/O5m4DODob1XgRJy3GM6/9IGmDcbbbgy
	p9dQMSJ+19EZ/vksJQflFofHrWTgipnf9M1DD0KC30c65u40HF+6VvuyfBOp/UrPRtv0LHixU/R
	ej5yo
X-Gm-Gg: ATEYQzzlYtjG5fykoVYslqNzibAJAW7JcGJirJDlY5yRJFBNrtu0FWdGBICBBgYnuh1
	NxEJPVCzPppZilHZjRMy5KTH1Z+y/4+ED97SLiDTHBzYvOjUI/oUgtnkf067JQrN2WZT5iIfDwl
	7MP11+zm3Ah8ogsza/LgH+oU57vGQeGfbR0m/YqbMNgZnCxuE7S+uH2bwV7ojnr0d0slVo+K5BK
	XcVGA47/nhMRVoyrXCxNOode5vGLJdgzS4UXn6ItCoaorx2a+YRKm3kZT+XEA0LFnxqIHq2Kh1x
	Lr+EaX+AIQq3oItvrcWIIG79L5QB5t1Lb+i+nG2AwsV+fvZrZSyGkX7MUkA9ejTjlqtgUUVgQG4
	ISLEJH8+6yBelGyWNpI4duXUgY0wVYzD6l30E0zzw/792iMsmSGNUbW3EeriNB5Yyowm6gtmoH2
	JK+w3/D3Q4pUquEm5t88UBPQ6EE/D48/RhCLPdOR/WzwG7j7+Twn7/agTGMYtHYv8AeSlZJQyFP
	DR9cApTZFb0ALuMncjqtHckXFdPyDf8S/ulKzhbpBipcxmyOAs+KEjzKXfaa3U7CzFDZSam8kbr
X-Received: by 2002:a05:6a00:21ca:b0:81a:74e5:a4cf with SMTP id d2e1a72fcca58-82a196d2c07mr3759562b3a.11.1773424639206;
        Fri, 13 Mar 2026 10:57:19 -0700 (PDT)
Received: from nixos.home (2001-b011-0001-3a55-372a-4d8b-a513-4837.dynamic-ip6.hinet.net. [2001:b011:1:3a55:372a:4d8b:a513:4837])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a0724407csm6265488b3a.8.2026.03.13.10.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 10:57:18 -0700 (PDT)
From: Daniel Schaefer <dhs@frame.work>
To: linux-input@vger.kernel.org
Cc: Daniel Schaefer <dhs@frame.work>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux@frame.work,
	Mario Limonciello <mario.limonciello@amd.com>,
	Maximilian Luz <luzmaximilian@gmail.com>,
	Richard Hughes <richard@hughsie.com>,
	Charles Wang <charles.goodix@gmail.com>
Subject: [PATCH 0/4] HID: Use wVersionID for device version
Date: Sat, 14 Mar 2026 01:56:55 +0800
Message-ID: <20260313175659.268094-1-dhs@frame.work>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The motivation for this patch series is that the touchpads on Framework
Laptops expose their firmware version in the I2C HID device descriptor.
So the vendor's windows tool uses that to check the firmware version,
but Linux does not expose it to userspace at all.
We have added vendor specific HID reports to newer firmware for reading
the firmware version -that means however, the old firmware still cannot
reports its version to Linux at all.

I found that Mario has been planning to add a way for the kernel to
report HID firmware versions to userspace and added support to fwupd.
There's a kernel patch in flight that also exports this:
https://lwn.net/ml/all/20260220070533.4083667-1-derekjohn.clark@gmail.com/

While adding this for I2C HID devices, I noticed that the goodix-spi and
surface drivers also expose the HID protocol version, which is not very
useful. I do not have hardware to test those

The i2c-hid and core changes were tested on Framework Laptop 16.
I also added support to hidapi for reading the new uevent, if not
provided by USB already: https://github.com/libusb/hidapi/pull/777

Cc: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org
Cc: linux@frame.work
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Maximilian Luz <luzmaximilian@gmail.com>
Cc: Richard Hughes <richard@hughsie.com>
Cc: Charles Wang <charles.goodix@gmail.com>

Daniel Schaefer (4):
  HID: i2c-hid: Use wVersionID for device version
  HID: goodix-spi: Use version_id for device version
  HID: surface: Use device version instead of HID spec version
  HID: core: Export device version via HID_FIRMWARE_VERSION uevent

 drivers/hid/hid-core.c                     | 3 +++
 drivers/hid/hid-goodix-spi.c               | 2 +-
 drivers/hid/i2c-hid/i2c-hid-core.c         | 2 +-
 drivers/hid/surface-hid/surface_hid_core.c | 2 +-
 4 files changed, 6 insertions(+), 3 deletions(-)

-- 
2.52.0

