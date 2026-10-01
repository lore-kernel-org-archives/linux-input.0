Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA981483BF1
	for <linux-input@vger.kernel.org>; Thu,  1 Oct 2026 11:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790853862; cv=pass; b=FVlhq7HZw/xiqoA+SbdsAmjNm1G9QVckPCpmcZ9akpppWyhwy5Hlj2NkfWuyfjagR4aq0nySuvs1q1fVt6kevi8C9a4kLVdEqoVXRYn5Cu1zHyxL5iloksmnDzUNe5mYlEsOHosY1zufdGZuA/wh3w8RtBNgJkuwKg+UXgw+dCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790853862; c=relaxed/simple;
	bh=MjakQU0TJ7fnlpf+s4YZ/yOnBdEhv1DXExJ6Ugw6CEI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=aFe8LZhsISMB0L8w5BW7AQEJ4qnceb6zao5VJBVH7zGKPWRYRl4F45a0EkWIjzyrQy5q0kSGXF4WKklamoDsQQPdWka5MOkRfza7WeAKsJ0PQNaC/1RX8rza0REPyj33SNXZJR1COvmxe5E/KsSgBrbLPYEafctUdEvvjfMgznU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sd6bAuKm; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sd6bAuKm"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6acb9c018ffso880133a12.1
        for <linux-input@vger.kernel.org>; Thu, 01 Oct 2026 04:24:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790853859; cv=none;
        d=google.com; s=arc-20260327;
        b=FIgEfX8uD7HcopE09iF9cCalH8pTlmRMgAdkxOaeUBlFtNEVEyu9UfOwG4HV99OzIE
         PgJhaN/OzVgYSABwcp2GcZgfKKlTvlHIQwoWueFW0dXyy0F/HvFIqfdaubUnhJF8OHD8
         ht/csnJXh1+lCfXVEXfyn74FIWa0FNqQHj9XrCKf0+FeOn1CLxAcLr1E476KuV1TX1R5
         Ulwr/a7wF2P2mnoDoAmuO9tUi99yAjk2uFeBwNGsjNJs26Hb7HYZH49GLdnPY3q3bv2X
         Q6CdvSmDOzi5s3nG4l2cfXtX/WaxySIh3IlEijKqkcxiBLHY0swaJO/QiZ2uSoZ3D5Jt
         UsnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=zU+Cj6MAZUAjJAd7DyWi5yjqQ6RKzbmURqdto4PSCZ8=;
        fh=5AYZXPjzKY78uu6UY+idlrKrRwayhAU1vb8FiZuLBv4=;
        b=UAMPU2UliYv9fFfbbJf/uaeBmQ7SO65hWV7hhZEIWZKJtuB7KhHRgcy/6nZRGcPguO
         De8Iq4b1+3wy29duablCVrGp1DgV+DXOtKVB2GpPoEbGnfaebLcRNaenrp8CUhGUxSM1
         LLvoKcaLxT7pjIrJc2vMgI6+uM5BZnFIo0cS08CTgeI3vrZayLaRXn2PFqbGC51vYzzT
         RP7+6d1Me55zE1VVvxQ3HntLC5Ex2Swb5gD6VyLqI/2NQrgqwsMvcvVf/LWE0TyoTv61
         2XOUVI3D1i25LloUOKZvHO9iQLxE0TZFRo/BRkAAGwe22CWRTrquPYvU7Y47x11i8kKX
         neOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790853859; x=1791458659; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zU+Cj6MAZUAjJAd7DyWi5yjqQ6RKzbmURqdto4PSCZ8=;
        b=sd6bAuKmKTt8TADJLteKx/cpZjp1gUSFnf/QjdoTll1tofLGe70ox8i6QLiLCvXmFh
         ScONl4zF9Kq0O5Hdlhrxy6pgL1yt7CMEsG77B4NjCWknag4U/rWN+8l46Zj54oYDKEya
         jp6WLnT0PxCN0u0mL0od2DCeNPMk+VJkOutnWowjHSKYhn2XvD7SzZBjlAkZnNJ/zQ0N
         zFm8ysXupXCLTEWSFJDXSPVbr0hS1+f30Mo4f9xQKcZpCAEJ8rEptvrRUs1Bnr+vf6fT
         oJJu0QSNLeAfcLQgwbtmB+LHoD9ORmXOhFkpEWdmtlgX6cPkVWDd4YXa4yRRvS5ofgZU
         BEoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790853859; x=1791458659;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=zU+Cj6MAZUAjJAd7DyWi5yjqQ6RKzbmURqdto4PSCZ8=;
        b=kbw4kh9leKf4Wz4+5Oq2O645ebcwnwPBSt4EzsTFbCWaI9C23Sm9ZmzKmiYaFBggFz
         guV1eVIBn+sNYcX4LEQsNoC2ct9frF9yQ+N+KDCWMiSY7Uw8SRQrh0/eqLbrAVlzN81O
         Xzh10rTm8ONMG3vSHHdakd78TSa2oQERUyCzbtKtYKyBtEGr9EM731GKDYUIG5Myl0WI
         ga30WVR4oi2mlmKywWtplMFpZD2U+2GWcpqB8QNJKha5J2SW7fYG96Id5jn0KK6nvW5z
         IJy4jhEJ/2FveKxmuat72hqVVumlRniuCa+VU7vGAyJnKyrp9+wMOWbkXGi85vDSISfm
         x7ZA==
X-Gm-Message-State: AFq9FYKnol968nGUMQAebnHtjzRVvZnms6Er8lR0IK68vIseE0STQRZE
	5N0d6vkAXTG5NJG43m8j29H79ixOFsWXr84UumhfywQwJrgbtUQ81zdUcBUnfquN7/REB14MpiV
	HRUoXad1HhgJ9RO9AXy16A0AY0f9iQsDiz91w
X-Gm-Gg: AYBFou214Rz7QGudYOq2ePNzNZTWVrAnkH23Yc1LJM1Ggt4z1axnpfoWvqdiyu+xiUS
	3jxX01AV4dss1cNHGwXY8RebAeB8RxryG8fYMFsWU0YzrJNYnn48T2uWf48gxlPYlnNf2TndTht
	EZc9HTiVDXYv/yn3mVwHhy+MB6VAUh2F2HWuzm4hSC94Cvk+6104iAJZoj0G5fUCdPoyfx9VjeJ
	cAzV8upLA2pFIdlyz3/opIdaaGncaClHAUlNWTqDTf+iTRAhcB404UwUJwvtqhLJ1ffzrs1m2G8
	sjCx/ZmRhyRK5nRHQfWrbShYGBV9K88DRaunCw5etDOGD85mqFa7A3Q+oCanKp/Zj5CrXaMxe5G
	igbXzGt2QZqo=
X-Received: by 2002:a05:6402:5165:b0:6a9:8863:ada4 with SMTP id
 4fb4d7f45d1cf-6ae307e5667mr1521584a12.3.1790853858765; Thu, 01 Oct 2026
 04:24:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Maurizio De Santis <desantis.maurizio@gmail.com>
Date: Thu, 1 Oct 2026 13:24:06 +0200
X-Gm-Features: AclHuK_-C81vMJeUlWVixPxv7I4f8jei6XYt9NRQ5nky4WspLVzbifEEz8SRozk
Message-ID: <CA+_M_JdzQe-zW84nqc0R=oYC_WtLz6zOt43Uk0ZAYE4-6Fmhwg@mail.gmail.com>
Subject: Re: [PATCH] Input: atkbd - skip deactivate for Lenovo IdeaPad Slim 3 14IWC11
To: hdegoede@redhat.com, iustinivan2002@gmail.com
Cc: linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I am reporting a regression regarding the recent atkbd_deactivate_fixup
quirk.

- BIOS U2CN19WW: The quirk (and atkbd.skip_deactivate=1) worked perfectly.
  Keyboard functional, CapsLock LED working.

- BIOS U2CN24WW (latest vendor update): The quirk no longer works.
  The internal keyboard freezes completely at boot (except for some
function keys).

Tested combinations via GRUB on U2CN24WW:
- atkbd.skip_deactivate=1 (fails)
- atkbd.skip_deactivate=1 i8042.nopnp=1 i8042.reset=1 (fails)
- atkbd.skip_deactivate=1 i8042.direct=1 i8042.dumbkbd=0 (fails)
- i8042.nopnp=1 pci=nocrs atkbd.skip_deactivate=1 (fails, causes boot crash)
- i8042.nopnp=1 atkbd.skip_deactivate=1 button.lid_init_state=open (fails)

The only way to get the keyboard working on U2CN24WW is falling back to
'i8042.dumbkbd=1 atkbd.softrepeat=1', which disables the CapsLock LED again.

Regards,
Maurizio
