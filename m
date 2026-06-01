Received: from out203-205-221-205.mail.qq.com (out203-205-221-205.mail.qq.com [203.205.221.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCF03DD87C;
	Mon,  1 Jun 2026 17:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780335544; cv=none; b=CrJKyzmR3W6S5Ue5+t/S0xHJH55K/4xZhQOcHzYkFfq8SYVaYGmN1MmXAQQRAiXRRqSSOuIcJ0Cldlz9ifIxLWt/fXLIq6buI/vLsnPlge999gIh4UV94uxobTwZo6qntyt/Y95UxLMGf1OZZzWZdS4qR9zzLaQbetcfeHfIbYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780335544; c=relaxed/simple;
	bh=abLEDTb4tE6T0Z0mvc5rMSDfRJtyLQ5Qsq949gGGBDg=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dSJcIs3wKaAHOjdDlB5t0VHujKKk2c2bgTxMn2XZKOYne+8pdp2ouR1pQUr0xRgXYTzc+z7bsURTIcHC5Z5quMDR6TeM5kjjwPWu91DCQ0TVIN4NoGfa/YXhxg5JpzVcUjg3S7m7fQMaqc6BsZvlj8J9SrHr0t5ew5wvZgLbMig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Red54.com; spf=pass smtp.mailfrom=red54.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=Fo1y5aJn; arc=none smtp.client-ip=203.205.221.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Red54.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=red54.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Fo1y5aJn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1780335533; bh=r/ZhwKoUDeoCorPW37W7uwLpzlHdcqp+ONOjAr6952g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Fo1y5aJn7/nroMAOOyGcjH/1ydtGwnIbElk4hmtcNGx2uGWwttCFY1conAdb5xknj
	 XXGtpuRzvKSLoFhaIdiwoJcEx4115M0MtGHlBe3qZUK9CPfBA8Gd3bpJuZwm+xQgA8
	 Vp/Vy14mXpVEKXjCOn/ygf+av/xgsGUR7rQ3zfYE=
Received: from mail.red54.com ([103.253.24.18])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id 979A8A6F; Tue, 02 Jun 2026 01:37:57 +0800
X-QQ-mid: xmsmtpt1780335477ta7asshnl
Message-ID: <tencent_40D6B4E7C99AF62FE879AB3DE2073E509B05@qq.com>
X-QQ-XMAILINFO: NxKoLLhE22aTZOsOTIKTvGqxerhn2NpguXX3m97i9nVVHNm+Uoptnzq+omD54f
	 1CCiZX6zya6+kEck2B9K/gMBS+EAIwjse77wKEe7GF5WdDuKV1Ir+Y6Dz/aKv+7R0hyGILw6YpYB
	 aKTkVfO4mnXfhpDsdX/oO2fS4lehsz+GPLhids2Mhdv+CpwbtuGuIsMx+tEiLocLaL63JwjaqiOl
	 9Y2kEnv8HPgK7icLBndZDTpnVJ4xkDPlr961ylXyaS/T9zqGNXb5kc5iH00wF0ErK6oBj2teV5Bb
	 LARMS+WZcMtOOuGhn4rbSLbT3rhu2CRE3OMlKNny9pYxuv2cQ/8dLwqrTnbPsX1r1m2XOCBZDPWf
	 51fiiTq8XTfyKNk97oCEzw2RNx1yE+M+5xwHOHdbdxowjdnp+53UI1mvDnVFSkBRvzbM+GgObxhT
	 khKDkldUh9CDHObYv9nxsc2i8zRlXSOpgRUtbi+XRlOMCLd7eem0ukohZNkYpmGvvugE0htWReAY
	 28qcIU1jjplDF/Y6hckzbsaEv5tNYpczqLNhxqOMWpE6BUWFCywc6jlUH2e7UJxSSEreFytyU16j
	 DCn597yUSpSJwyMiC0u2bT2GSmramfqHbUPEfCsm4R9LWYHfNk7IuYdCfGEkN/JlPCRo+5JDTaP5
	 J/+5FZx9xAJKPm4JvJ0N4qa3jzRBxnoU4FWC1jfKm21mm64U5Qw7QTEshcj9Tfj7un916tLkHQks
	 aYshATzSYEfQzbRN6U+6ZMiJUkll6SlZjIHo1rIeY9b6gJX24UiKh+A2FhBdEcwhC6oBdQVwl+g3
	 KKWlTB7JSxOJUVazAzkTQ1KhkLMR3lw79B3MtuswPgxPN20E4onEpf2DfhwZuYy91i3oP/dbMXb2
	 1Wk1Tf6b2+LVVbpQlzNckhzFbfL8KiS1WlDNw+w9kbA23U7vzkcB9Q2ibQrMtVNAuRC19iNleoSi
	 ERzPtWDSJQ+/ibsq0a33uJW2MG3d5cMO8AOWRJBqOUH4jYwuhVen9QqlMjSBUfqYxepvoQMDhsh1
	 LnsY0YwTmJk9uUSf5u7uRADCMF48lNXni3iAkbo0hGpf58eapCyTBF7AHccva0rH5X3xBSfAaflG
	 GDQX0PNnN3orrCVSK4b8eCc8P1zZvrIeGjpWH4IsJzsoAFBvtkJb9t4fCHNbs97kJnWq8W
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
Sender: yeking@red54.com
From: =?UTF-8?q?=E8=B0=A2=E8=87=B4=E9=82=A6=20=28XIE=20Zhibang=29?= <Yeking@Red54.com>
To: linux-input@vger.kernel.org,
	hansg@kernel.org,
	dmitry.torokhov@gmail.com
Cc: Yeking@red54.com,
	bentiss@kernel.org,
	dianders@chromium.org,
	jikos@kernel.org,
	linux-kernel@vger.kernel.org,
	superm1@kernel.org,
	=?UTF-8?q?=E8=B0=A2=E8=87=B4=E9=82=A6=20=28XIE=20Zhibang=29?= <Yeking@Red54.com>,
	Pin-yen Lin <treapking@chromium.org>,
	Xu Rao <raoxu@uniontech.com>,
	Kwok Kin Ming <kenkinming2002@gmail.com>,
	Dan Carpenter <error27@gmail.com>
Subject: [PATCH 0/3] HID: i2c-hid: Fix some PRP0001 touchpads probe after OF/ACPI split
Date: Mon,  1 Jun 2026 17:37:19 +0000
X-OQ-MSGID: <20260601173722.38151-1-Yeking@Red54.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ahnqMMhD8jn51ch7@google.com>
References: <ahnqMMhD8jn51ch7@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Before commit b33752c30023 ("HID: i2c-hid: Reorganize so ACPI and OF are
separate modules"), the unified i2c-hid driver handled both PNP0C50 ACPI
devices and hid-over-i2c OF devices. After the split, devices with _HID
"PRP0001" and _DSD compatible "hid-over-i2c" are only probed by
i2c_hid_of, which requires "hid-descr-addr" in the _DSD. Some devices,
for example the Lenovo KaiTian N60d and Inspur CP300L3, provide the HID
descriptor address only through the _DSM method and thus fail to probe.

Patch 1 moves the blacklist check so the function can return early
without wasting an allocation.

Patch 2 moves the _DSM call that gets the HID descriptor address from
i2c-hid-acpi.c to a shared helper in i2c-hid-core.c so both
i2c-hid-acpi.c and i2c-hid-of.c can use it.

Patch 3 calls the common helper as a fallback when "hid-descr-addr" is
missing, and sets safe post-power-on and post-reset-deassert delays.

谢致邦 (XIE Zhibang) (3):
  HID: i2c-hid-acpi: Move blacklist check to probe() before
    devm_kzalloc()
  HID: i2c-hid: Move common ACPI _DSM helper into core
  HID: i2c-hid-of: Fall back to ACPI _DSM when hid-descr-addr is missing

 drivers/hid/i2c-hid/i2c-hid-acpi.c | 42 +++++++-----------------------
 drivers/hid/i2c-hid/i2c-hid-core.c | 35 +++++++++++++++++++++++++
 drivers/hid/i2c-hid/i2c-hid-of.c   | 30 +++++++++++++++++++++
 drivers/hid/i2c-hid/i2c-hid.h      | 11 ++++++++
 4 files changed, 86 insertions(+), 32 deletions(-)

-- 
2.54.0

