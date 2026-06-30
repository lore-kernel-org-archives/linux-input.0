Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44650282F1F
	for <linux-input@vger.kernel.org>; Tue, 30 Jun 2026 04:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782795144; cv=pass; b=rGni3oGPTArTDtI+hG/+dLudnwB7YEGRVHIQliMmhpdHNsKarqb/ZJ7jxmGc2oGA9n+7EDm4GM+Xmh0xOwYt536YsJvvEWfsCZ/PGKAb3Hkew2pavZyqRNlF0sQ19F+orAKiedP+jgQRI/khLMFgkkEh8ICkNgYptnVjzwt+Q0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782795144; c=relaxed/simple;
	bh=5Tyzaisr5mGbfjEU5rXfoq0BZD3jnlSX9RSNvWmwSSs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=lDdzyUbVap5nCuVamRtdpteycmNDoYvuslXiOxF0Dc0ETb5OATI+mpfM9Hu5IZ56hdDvDOKACmH/rFMvQfTg18hzhLnBalnNOeq1KUVxEb91j0PPvpG5UEFGaFrMYKn4QsgdzOqL2t+2MQsEF1rR1u4w8WSoWibjWyzZMH4xqDg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hV/KgXS7; arc=pass smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hV/KgXS7"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-3996c9eeebeso32623241fa.1
        for <linux-input@vger.kernel.org>; Mon, 29 Jun 2026 21:52:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782795141; cv=none;
        d=google.com; s=arc-20260327;
        b=lAQ+GaCGa4sJ5xBBJuUkwMGnRJEKcaV1aYCo3vdvCYtrnEREl7bBf6kSc5dTlrT+On
         jfetsl9rzcSjS7dh4KZx3Wk/8Hl1Uuyq3N/M99ScQXv+ITHPT8+wYsgyK0qnZOBjE3F/
         3xAMb4a2X9I9w3RP+Ygu/hTlfU7y+CynDq/nUFnC899WKi8tkMetJDmRqFupAHYp4qom
         sgzIP3EgGASfonT6/RCYHo8wIvRg5rWWlHgM+bw1nCnJgMANiy0dZHYO31oOywpifxYD
         NTPttIm45zRVgwKfSWnd4Ua12QEJ8RXKwwPyIU7ExC8xZV8xEDn+YQSYUIv9NhhWpa8Z
         bXmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=ihd90CtfnqycEvSiqZr6Hb8+VpZm2glxj7azajIlDCQ=;
        fh=mzvZY1UwmIPZtPCGdFbTBUFqGQA2L0Gzhh+M0jHzl2Q=;
        b=jxmAncr7M2jE23Z/iQTxerlxlSZrbnp3EIvddH5hNgWG99+otjjJarvHgmtKcjcZKK
         QQXMuYBTLOmpqrHGLuX7kfUtHvSGyVOBCKmCami4oMKehJOthhfcRhuJEP+5XGfCU7Vi
         GFuB571UrMQyjNFF6DcN19UDKWy/cUPtFhLGIxBAz2v0K9ohwlqO3a0EvOUl8klzlTAO
         1ldU+RRUIxXDF4QNyZFvFjnSa4aICcIkl2uQdyNNTvHMWa2W4Vd6qfSl3CvrpC6N4qAv
         d/qyc9SUwCC2C+xSbCfzDduneCtUcPj+2SKbJFih1wAnmQ5//KczKPWV2PyLqvXVJF0O
         PV7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782795141; x=1783399941; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ihd90CtfnqycEvSiqZr6Hb8+VpZm2glxj7azajIlDCQ=;
        b=hV/KgXS72gA7Tnuw+FXMwBOPe3NF8bZ86OPEVjaTIVOathpJZbNRc9xp5lgHfnfOi6
         SLwaqLwcCGrkA4dGDhKbSmvNSbMcXEVCB1vMgQP6BrrEhBXIV4JrtVxKGclJ/Lnte2UD
         mLuEG1OOuKYgafu4a8y30USZg0KR8B5iO8gJgJZXNFnJf0+j81RXnTKrVmHhPOsvqWtE
         dOoTmc6L963N7SOME+VlE92JmHGIqXEjGYOI1b890bs3vnp3bD5kWB3ojnvuC+BXl7rW
         qV8CV/KLMXv7pcPSDg5578xaWdLp5BaIxMBDrB2M3Hj7wza3ApnVCf9IcJA5cUs8sPsd
         YylQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782795141; x=1783399941;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ihd90CtfnqycEvSiqZr6Hb8+VpZm2glxj7azajIlDCQ=;
        b=PhI8lNnSIv/YGjeCAwv0X+k6kdsEhoOwmtmAI1+0uE2P0GIb+BaP+pds5xoprKjyU4
         HhdUjBdJ+tyBIihsPyMN5ngjnqcuSMPyvBNSN+Yvc7jWgMR+DXTyDJUdl3QatM/11H/z
         C8gju3V+e5F70LzXXaCY6vCPLGrJ6m2xuf+B75Va2fSUSnoe7so9Py6GJh/yRQooUHTD
         rl71WkpW1NEXgJfkVfNJ1wwqjjdNGgoC1ZEwWV8OwpkTlaA56ycBvAClb124AL84+p8M
         Y0QM2eeKewTnHvhN+JJC/Zjt66EZL5jf7chVy5nD1koGKkzwPjULBc1xtQHNNMVojroS
         8nxQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqx60I0t/CaZPWi5WDUsu3OkttIpbNT/2VnCuYeJiV7val3Sh5/lLM+0ogpZTsBZVB4Y+jWQTm3AYz7ZQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxdWyj+xXKbgu6wrlOlnHwuaI6HehPZVgTGtx2aDYECBa5tyCpT
	vge/HDqNXR2zKAIKmha8H9KoW5f1C+1GfXyROY8jnj74iQrMHWMOqLW/hjw3UeyiYP8OFRKluD6
	vBEAklH9JieI/MkSqcrf3i7B4+cBaj1/8D6DQ8WL1b38gbhU=
X-Gm-Gg: AfdE7cmouxnAB2CsPd7jjvvaQSetaiAtuC9dLuZd69/2QBoNmYqKjRMPhduCTtA8zum
	QN1RMBCfsjZivDaGU3OdZvmGAHN4uxkuXuK+1cWxJGZZ+bT0G2Ggo8mKTmWmpyaI1VnNFK0dGJ7
	X4EJczkIZgHGslPaB2fcvaXUFPgJc5ncEJCGxDo2wgKGq0pBVPYT/zONVYZv9giNSKv8G2jv/WR
	2Psn/v4lEWzKVLVPdnYGYyehomrxrCogtmIWRt78VGxeaduV4eAgmL+0lV6q8M0Wu7827G82Q2U
	H8xOZvYoxQdcoJjb1WEY0e1Mc6eqqpeqE8B9DoSEVln1YLlVWG6c1JOb
X-Received: by 2002:a05:6512:251:b0:5aa:6aba:76f8 with SMTP id
 2adb3069b0e04-5aebdbbd837mr309085e87.30.1782795141202; Mon, 29 Jun 2026
 21:52:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Steve Yang <steveyang137@gmail.com>
Date: Tue, 30 Jun 2026 12:52:09 +0800
X-Gm-Features: AVVi8CeFkNsB9g3cMVwEg23dz9vvGrf-budlrJHsQ94Si_PmDWSoCTlOm4cXgNk
Message-ID: <CAMNbjovbZED1G_fuWjpTYRGnUrHddpYVV24P_S+QzyFHh_zVoA@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 7.0-6.12] HID: i2c-hid: add reset quirk for
 BLTP7853 touchpad
To: stable@vger.kernel.org, linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

I can confirm that the BLTP7853 i2c-hid reset quirk fixes the internal
touchpad on my laptop.

Tested-by: Steve Yang <steveyang137@gmail.com>

Hardware:

  MECHREVO XINGYAO Series / XINGYAO Series-P916F-PTL
  BIOS: 1.00, 03/14/2026
  Touchpad: BLTP7853:00 347D:7853 Touchpad
  ACPI device: i2c-BLTP7853:00
  Driver stack: i2c_hid_acpi + hid-multitouch

Broken kernel:

  Linux 7.0.14-arch1-1

Symptoms before the fix:

  The touchpad enumerated successfully and the HID report descriptor
was readable.
  The input device was created and udev tagged it as ID_INPUT_TOUCHPAD=1.
  However, the touchpad produced no input events in evtest.

Fixed kernel:

  A kernel containing upstream commit a991aa5e89365ba1959fae6847fd288125b209e5
  (HID: i2c-hid: add reset quirk for BLTP7853 touchpad)

After booting the fixed kernel, the internal touchpad works normally.

Thanks,
Steve
