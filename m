Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73472DECBA
	for <linux-input@vger.kernel.org>; Sun, 20 Sep 2026 19:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789931244; cv=pass; b=eJqwxY4zLUbQU31MXORd5X7ckzpjpiI+c1IgWdcFR8enyymPhgDHhi76aZc1ch9rMBaLm2811E29mc8LDfmHIAQuwEjr43xF1c99hjn598Xh0VjoIkHB5cieRCUrT9eq3zVToAj9VA1I7aTFTc8pYz1VqpfKmWnoHAROzqFuXcY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789931244; c=relaxed/simple;
	bh=6NpzjuVQ4D9LPj7X1Q2ui6kDsHKujCMAK8cy5su06Uk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=ShmPCcSMRB1tlraTNFL4Ba0pRUxC3205wzi/05LHbhQiwX7ZmJqqo5FZBfRrhySggVFFvvC1N0hO1Yy/WM+v9mPUlwVq4YnluoYzQtrjFK0grOOpkIzm1ynMJgmG6Br+yy/tEV9S5peiyk9N3xdXCfqZUVPuMLob3t8d37/QWRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mk7m5nFY; arc=pass smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mk7m5nFY"
Received: by mail-yx2-f12.google.com with SMTP id 00721157ae682-85d4eb63f16so6692157b3.0
        for <linux-input@vger.kernel.org>; Sun, 20 Sep 2026 12:07:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789931242; cv=none;
        d=google.com; s=arc-20260327;
        b=Yr9tYP7RADabC6fdXzXe8J9S2KGRbDM2K/vMhvzSW65ijbucm0kz57SeHfSCzjbJKN
         T9MCfLWLt0UY/EQVv34/zKE9qc5Darj67cfPu43Ms/vCakPVq24D3TU6Q/tOnQbZO7EC
         R17TPFE4UcPPeEJAKnRUCraf7xQxBc4BMeWldJ5nGKfRY+iMrl/Yn0oG5rrfepg6L6qi
         y+/lljP0he25u8wSINCcMHuR+LqAhpKU3uGzAzu7WDQoO1t+wSoYxO7riKg+7Rk4kA+4
         pZOUF4OyNGvBH+VM82gZI7Bbj1OrjdBOYIIJQ9WSkmn14B8eDaloeyJhgC7S9O+qcMP9
         NFGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=6NpzjuVQ4D9LPj7X1Q2ui6kDsHKujCMAK8cy5su06Uk=;
        fh=QBRj4p4k3geAuvF2WSiVLGKXZmHqCuQAf/1wieg5t1c=;
        b=qT66dS7T24C6wzrtx00JkCad2QjgcnguxAUFPSebK417EDoQlu8a6UAvH9zSZBmQ1p
         zhR+rQ1Endc2PMxA9gNG2e3yT6aPmUDHWZGQ+ko/p8V++X/604XpQrGBPJatV16okWM0
         AfLMK48mMq+PDMCuIxUhdtWguF9ei5fOMGPIsRTSP8s/8PQKVaWkBh3zNvUu2xjla6zH
         vjyn4V0SRr6XbLt/PIMRJyeProT5eFAawx1V8t+abOrAST/ZtDV9lS+ATjILxg3rY3fI
         OuVNG12S/YH70EqGisQjpQyCIvIJwGshrihEZVU7K8bOjCK+D2IxKJf2D5DYTlvZ9Gtf
         iE0A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789931242; x=1790536042; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=6NpzjuVQ4D9LPj7X1Q2ui6kDsHKujCMAK8cy5su06Uk=;
        b=Mk7m5nFYTDd15PP6EUMMDXptS1rDUfPQaNIkKaqN8w64ef8jlRklsP/+8+NiCDHmPT
         zvNWxIHLVLK0i7kg244NtBpt5MJT1j6TdA/4P8qeYKZUNioveu/He11Fm8mkWyznN505
         ++hjfcKDKGcJlbgrzrWHKHvr7NgtPpOSsn7n6vK+pBJwH40lADZ7nURvi9OH1TvwOG3W
         ARvR7YidofKG5Nq5eUFBReBu/LnkZu5JAmzybDHPmOPC3gMDMMH7nBFBzH+WVL/A1eKv
         QcSUMz+yVjl5rBQ93lBAvbDfhg7cDJxvIYYdQtnlLNW4+gRcqyUYkHvvC8w4XzAbo/cm
         6Iow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789931242; x=1790536042;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6NpzjuVQ4D9LPj7X1Q2ui6kDsHKujCMAK8cy5su06Uk=;
        b=H6V9//sLyp2h7iNwNOeLpunYLPiTVjWV4TAatEvyeYjiUbZF/jPzi+KPTYOpcjagLH
         T6lkJhMsLfzWxWzn0vm/dOv6UzmILfHG/rdzOw3Ccxfqw3oU92CBlN6eUFTvMlykZOmh
         93WryHZP6d110IstHeMv40twPNVhwLHJLa9fR4/jsM44iZeY2nKHk6LGplhJ+t3mqs0k
         Ved4mIaqwfdd/5A4Khw617W5rMKWp6NrdhWKKHIYihPp/L6fzZkTRKBlHpbii2ttkJ9w
         SVlFVmOJFBcdZpwvkDvTDkBFxiO6S8G4qWVYdGlkumOjvsBaQ4PWWb/sIR/rm9LdZQEU
         pcuQ==
X-Gm-Message-State: AFuF++lk35uzAd6Ls08+yshQeQOy6LGrP9XlkDJmrhiN2LohaJ1KHfBT
	uYrqMSzaCKfFLr9p9dmbkRI34ugzKmwxfWh5Bn8H9TOCfv2tRw1FUXS7xJ2SUsBiYj9Nv6A2jUm
	XUBg7pu1J3j127fi4uKTEE/y9Epc9d4FECMnAN7I=
X-Gm-Gg: AYBFou25CW+lBjswC5lKvYQjE4fFK/lV/5X6cTWS7epGi8plirpqyrMyhw1sEq9w0WW
	G6lXQdV+umVtfD3a6Y4FT/rIUT2qW9gCcBt+iDCcqkuR+GwNIycnr18pk9RBpHvgSu1/r2rgq+v
	pazvQObKsx0q0DIFJuN+UuPg4tQYgPviabX/KqFYxDdPvLNYguk1RH9PpIjroB+b73IqlMVcm0v
	RisTeRy5V2HA+7q/i3rRg5fxMi5zKJjnDSQzp55FkQBjqdO6JUqqf57KDWNlfhyRGbsq43Qpo/b
	0agpxWOcq2d89ziclsaJvCCSEajSmR7gxvJa5NtsKfhScWb6aCh/qLVSxdJRLEoLTfN3NSXzBjy
	X6dxQ87CNSwevlINKr4EkIyw=
X-Received: by 2002:a05:690c:660c:b0:80e:dc2:873b with SMTP id
 00721157ae682-897331419e0mr25993047b3.16.1789931241950; Sun, 20 Sep 2026
 12:07:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: John Rosencutter <rosencutter@gmail.com>
Date: Sun, 20 Sep 2026 14:06:46 -0500
X-Gm-Features: AcwNN1XQ2E-KmJ_3np2pN4w7mDyJKgdxq-3BdN5ym6_6WZNf9gnne98anOlbJH4
Message-ID: <CAOGuaRh025eKcBf9P8UrvtXNp68vQ0HVF2EbNMp-kpdaC1HNpA@mail.gmail.com>
Subject: Input: synaptics - LEN205b (ThinkPad T490) works with synaptics_intertouch=1
To: linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

Per the kernel message, reporting that the touchpad below works
correctly over SMBus/RMI4 with psmouse.synaptics_intertouch=1.

Machine: Lenovo ThinkPad T490
PNP ID: LEN205b PNP0f13
Distro: Fedora 44
Kernel: 7.2.5-200.fc44.x86_64

dmesg before the change:
psmouse serio1: synaptics: Your touchpad (PNP: LEN205b PNP0f13) says
it can support a different bus. If i2c-hid and hid-rmi are not used,
you might want to try setting psmouse.synaptics_intertouch to 1 and
report this to linux-input@vger.kernel.org.
psmouse serio1: synaptics: Touchpad model: 1, fw: 10.32, id: 0x1e2a1,
caps: 0xf014a3/0x940300/0x12e800/0x500000, board id: 3471, fw id:
3972349

Results with intertouch enabled:
- Touchpad and TrackPoint both work
- Multi-finger gestures are much more reliable than under PS/2
- Both devices still work after suspend/resume

Please consider adding LEN205b to smbus_pnp_ids in
drivers/input/mouse/synaptics.c.

Thanks,
John
