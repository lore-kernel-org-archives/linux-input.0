Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125A748594F
	for <linux-input@vger.kernel.org>; Fri, 11 Sep 2026 13:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789134836; cv=pass; b=lwKOIe1F8VcDxk+ggAEhSSbDqmggV9KxNcrgxUfuW6az6a6b6GmXbIFLmXlSuAEcpi5rfg30VI6i2weOyEX89h0MolIT/lV6ZuX0cty46kFHxagI8QRdWWmXene8NWOOPmJDrZsiQ4XWne/mkuonZLtPEW2YEmzlWQ+pruw/MWE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789134836; c=relaxed/simple;
	bh=lC+SLgB1AHFRxizEBCGTdbwr3jxvVqS6t6ieXv54AIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c0yIqpRQouK9jE9aZMERz6QM8KGTY4jWUzlCLaFwPtw7xhAH+MrEL0p+r2CgVBsVA/5P5XcsWuaIO/KV0mtDx8b0JG9ViA3dhxpeAINgefPYuZsowJup++4MH2RGAX8+q3s+/Dp3mQTC5ItigOli95poo9BSnp1RMovkQkLAtC0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eCbXn8lC; arc=pass smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eCbXn8lC"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5b4a9994c20so1160009e87.0
        for <linux-input@vger.kernel.org>; Fri, 11 Sep 2026 06:53:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789134833; cv=none;
        d=google.com; s=arc-20260327;
        b=XQVB+GVoDypYRdEfPLJHC2TGDFWsNHWQgJlk/pJOXW6R5GHZUsd1lcZkqbnLPGK+In
         UPfj42zHTX409fisyv1E8WqEhX1U2YfKyDNhHqeMEaWeX3XPx0wm+cVQQ4L5ybsNj75I
         50ynMfLUZ+Xde7DfFYq6xFiudDNLm5mEdsAUE3/fToUwkCA8P8/H11vdyyljtpgtamnJ
         38ZKit1YLO4kxyd81Pkkmpx8KGrwb86+d7D/srV5eUaUV/CcmyWJ+rAPT+7QFjBciv+t
         OFYXczbdVg+9ZX9xw7hK4QXcaw/ItmE0p6oi5r6Y93ImJP6rgR4YCAEj5VNftgMQgBhk
         beqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lC+SLgB1AHFRxizEBCGTdbwr3jxvVqS6t6ieXv54AIA=;
        fh=VtXJV0gCNVZr5jW3UNh4UeS/h3j0sQSIZVGLrQuGSb4=;
        b=TF/JuHZnIwGHzEVILdtlQr51lkdSOtt//YzWIQnC/nGN08aFq6G/i3tpvkWD1b3i36
         gcga6JqQ+lCzW0iJ9NezQTe3BAobt8UYnwI/BTvK2pSkHYmkAn0eJZ0H0HSlbFhf+H9u
         +MzxlM5qh0itQSKTpjhzqcsqD0VFltOq4l2bBEsS6nQfQxzKmEKocdHXqEKiVckgA7FA
         HZ9paocq/1zn18qYWsXiED/AjLfQicBNF6hRrQ0dDQlMM5iXkrOUsr38yM60vnZycZY7
         HXVPbhaxvO1wm/utjFPoE4S/Ezz0kDSAkc/rGy5/9NJqufpwuBIm4zReHNhbQpz5qo/r
         pDTA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789134833; x=1789739633; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lC+SLgB1AHFRxizEBCGTdbwr3jxvVqS6t6ieXv54AIA=;
        b=eCbXn8lC5L49z1j4vFHuUB+Ko7cRoxGSw1ocLylMHUz47Zj02oEyip86eZbW0/nQCt
         t7vxebvyhZqjY3dGmd5DTGmB/5IqjPCsmKQFkjjxrQeNdyzNQ9/X8zBPjc/xkBEeDoRJ
         PmzBS/3Uf5jGJ13y/cJMSrk4NxR0kZ4tzHtuAm8Bz4W+OQBzqfgSk/JzFUJuuA9JmApo
         MRvQeD+HWLyRnp+7cfR06UMVM9Mka3MiQvC60PiZO0Eog0vz46bVU4FK+JxgPo33BVvG
         TAuJBwGoUr3SJ+hpZLyToQ97MzHJkBtX4H68DbDZdiZ1vG1MWLmWVDEplD9tC7Hyew2U
         2/MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789134833; x=1789739633;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lC+SLgB1AHFRxizEBCGTdbwr3jxvVqS6t6ieXv54AIA=;
        b=OUKwW+ZTQjwJV1AUSDvsmcPi08Sx5s4AVfmfNKrFyY+mdcU6YBo6GU+ZJIZ7yIy6U9
         cWe27/pQeXf35RNGhu8VQGtMzd0ynUPkK0htBsU5Y5F7YjIkjfIem5sONlE9eCmTqGaQ
         eFANdWD123rzRjnKGLsVEZgK0onwe+/67dDkjg3Q3MitfS9onFTxher0gFJUNJAB0wrx
         DZ7ZyVWHKfiLJaXXgOZJL7SOzHYxAGW00LO6wn0jgMBD9EBaRTso7mr/WGR3qQ6hC0OS
         laC+WOX7ZjBEQwF5PS9lmHVrXZtBzwVYHTudaA7r/AQYYcsVL14LmTNFEfemBJhFo2wX
         Pv+A==
X-Forwarded-Encrypted: i=1; AKwUvBxDyMm0nn6Iu08SFxt0z7eAKMjvcS+ZP3QjxBpFn18gEDQd1HAinWNn1Bo4eOGlMpBKgk8fASPxnBuzyg==@vger.kernel.org
X-Gm-Message-State: AFuF++lzL/66EqAcURuZDnz9v9cJIcvt1CYUDlkZYoZGpkZrdR3FniN9
	25votka6t0La7W0e80CkvqIbx2wpEIHd/+KmddN0S5PugvIjlfxhpiFr+ELLerU2BfZstQ8D1Gk
	kv9wcJ/+udl7U5Np0CdIAR9ZxAhwxG0PNhbXV
X-Gm-Gg: AYBFou1d7cSiFwxSGMHgrZ91P55l/OmEbOhlYgIwAtDm4TBPxwysN3z3Oeh1y3nQD3z
	+wTcgX8IwCHFF8smd8sOs/9OKiFhwW4QvoELHvOOMrryrKG0enE9UJ1J7S7v1B8YcCAXWbJMw+n
	BFhxf6TBl+R83NFqYjRU90PszJCmqQgfCQI/OKCrvh25tG4tY5pJuAdA55acdBZ7mn2OXU9uPT3
	arMu3Hq7Qj0RNbCphalR0zC1+K/g85dcA93c+5014HetPctF0BnzsUCOgQITirwbhqNXgc9OUHf
	y7jtTLF00NEGEgWG0wYEp3z6P2QxxS4reLDur/xACBCGuAqiEcO4XcoVdc7xoQwrhdX94WH85xc
	X5h8zm+J2lEWBOw==
X-Received: by 2002:a05:6512:1329:b0:5b6:1a7c:59e7 with SMTP id
 2adb3069b0e04-5b8a03182a5mr956226e87.65.1789134832601; Fri, 11 Sep 2026
 06:53:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260911115346.17133-1-meven@kde.org> <20260911120208.21698-1-meven@kde.org>
 <20260911121058.3B7DE1F000FF@smtp.kernel.org>
In-Reply-To: <20260911121058.3B7DE1F000FF@smtp.kernel.org>
From: =?UTF-8?B?TcOpdmVu?= <meven29@gmail.com>
Date: Fri, 11 Sep 2026 15:53:40 +0200
X-Gm-Features: AcwNN1V4lcleQzKLHYvViyVGqvNHJTcWxO6dU8SGMBM654mbATGAY0hn6jvi84o
Message-ID: <CAOvFf8P_grCiKhqdgbJccKiyuQsv6nK6_NftA=7mcbMszVrpCA@mail.gmail.com>
Subject: Re: [PATCH v2] HID: logitech-headset: add a battery driver for the
 PRO X 2
To: sashiko-reviews@lists.linux.dev
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> The HID subsystem guidelines specify that hid_hw_stop must be called befo=
re
> cancelling asynchronous workers.

Stopping first is the unsafe order here. logi_headset_poll() ends in
hid_hw_output_report(), so a work item still running would send on a
transport hid_hw_stop() has already torn down.

drivers/hid mostly cancels first: steelseries, steam, kysona, asus,
nvidia-shield. corsair-void stops first, but its battery_work only calls
power_supply_unregister() and power_supply_changed() and never touches the
device.

cancel_work_sync() handles a work that re-arms itself. The only
schedule_delayed_work() calls here are in probe() and at the end of the wor=
k,
raw_event() never schedules.

Which guideline do you mean? I find nothing on this anywhere in
Documentation/, and the kerneldoc of hid_hw_stop() does not mention workers=
.

--=20
M=C3=A9ven
