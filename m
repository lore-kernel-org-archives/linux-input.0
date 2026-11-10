Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794342880;
	b=KWxW8FwQM514hZzRqzVbkYhmjEHst9TTBGBdluz3btiDP8P9TP0hC5w7UuBFOdCtFbJi
	 1FFRxRieSU0qhD6KgmilpL16L4Y1Y3mWEQfrbOdU3NgFMbr+l9agb9N/xNOof4HCWhJma
	 x9sPoi8IZl/+vrrjAFqPvF058Prdl2Rxm8sNe4ocnHSD6NQnWmpojPYrQnJaXT0PEKaax
	 J2UwZ26yGbGiuBMtgSp/S8zToX3XQbPNFPApnZIMBp8B97HmUm7ckDZG7rOOinEbmYM71
	 dL8iyZBO+IXdTpAVnAcsb1t8UnH0YZROLt93bgEBjbcTx2j8vQDZcFB9ckEAIUct2lA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794342880;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=XhB/wmAO2gEI5agOW6oIrhyDza+W+waWoRcKr91K/YI=;
	b=XIws+lrw8yVqvDq+2BKvV+4MKViEM1lrKfGJSsHKrhLMG9WGeSxwuoqsxHj0oWI0b/sn
	 M0cbEfMd1NkeQHww55aeba572QzuJdyyjuoOfQDQQ74GZ0EUBHVm5eG3Mlm8puSSUpmAy
	 OQtZdAeqgXC3bwec9E39Hfo2UA2AwDiX+BWXB+SJAQkTPB/x1c994hYLKCxxAgUfx7/U8
	 /B4Fs7Ea/7nsxwVmhni0HO2LFG2L7WjumkkcfdZmGk+CWTVdoGGxJP+l1SqEi0TZ5I1kn
	 1OcekGJEiv8jpobgu/sUVuy7rROID8m9GU78bVnz7qEbNSeKVXMYipqG4hiSt7TUBaQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JJHWSdqs;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.47
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07718606A325
	for <linux-input@vger.kernel.org>; Tue, 10 Nov 2026 20:34:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07718606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JJHWSdqs
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1a8cc11ac42so2445344c88.0
        for <linux-input@vger.kernel.org>; Tue, 10 Nov 2026 12:34:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794342879; cv=none;
        d=google.com; s=arc-20260327;
        b=LvLU/WmpslQ7Bz670uoO8YJ2zFjE95wQK6wPEqVwZ5gMfeYPSVtT6ukltMU6dZsk0L
         1WeA0pFXomswyOJ8YTXx0rkoMJCavAcapy9bVB2E3Vn37VBJBSEWLR4xp2q0ukJ+J2RA
         fie9xjCFjYt8MREuF/zJKgdlmn2XuosxpQGfQl46vyxe/8gc+lq+xMc7E3BVMxrcudxH
         U1R4/LYz9ZaTJMBCyy/EaB4L4hKgF8dXYNAxV3dEQZxULTFIemjwaIDr0UeBZgXlNdT1
         ZPOvxibhGCcr4w860PtimetCEcBcSZwD3NBPjLqUXBmzvBe+Irshm6fdYGqYzTZw0xpm
         s/Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XhB/wmAO2gEI5agOW6oIrhyDza+W+waWoRcKr91K/YI=;
        fh=BDD34ij6QFXf9y+l+uC2E3m6UVTAejDoF1wQ5I4A8ZA=;
        b=mXyc8i1VhJaB+ME4h903ZaUfAiCxmbwO92nWn38doS+vTR70/plpoGa3D6ku3092sN
         YVN1WcP+hlydRUZzxS1JABCib9zMJu6G5uFiccyXNveEnnXaKcm6AfCW9Q3TPIgmsmyG
         2wvniS55Q+yaYbYzKm2NEhbk3LAw6ml6HAvdKuSy+ReTd1yVqXkVntmJECo1EwseKftU
         686kMb0oNoq4xBzwK8xjdkCOfdRi3WFmxGkX31IIIjloVE+99h7huwYsZV4wX1x6+igV
         7eNoVMDnrE/KvuPcm+ZlDkMhQAD3LzLy0PUnNYvCAtXdQK+5iWGH+q6q52Jh04otVZJV
         L9vg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794342879; x=1794947679; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XhB/wmAO2gEI5agOW6oIrhyDza+W+waWoRcKr91K/YI=;
        b=JJHWSdqsEtM4bBU+5grCo2bl0FUiJb1cGjtLviO+HJ316nr8t93eAwbQrKRMSTg54v
         S1eD3X6ENXcfeP1135+eyE78fqh6YlByhVfnIxLyFG7Fnme7gn9oHVld+Wq+x8XHcCgU
         ruru19j4apZJUaalygL0J9pPog4yG/vMVTq376YY4QDiEFFSF48V4166IoB/ePVwxqgu
         /D+dc8LeBN8iMMdGC15ltgljl1n3cr/733lqr6mNBbguaeSVcedgduo2I4tL96AGpr4Y
         F5Cjwk7kDEsYWWPiIqIdzSPMbFSV4xONseh6BU8GmO+jDJSOZkGOTcyfvOQoysJ/zb2v
         QPmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794342879; x=1794947679;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XhB/wmAO2gEI5agOW6oIrhyDza+W+waWoRcKr91K/YI=;
        b=Jnbh1gbjCWkZdRFWTuq83Mvgg8KpRnFiFlfeMuINe8epVL4gq3UfLaZemwLzN02kjE
         Vwn/ZpSytJc1W7QcHEzHl3AZHuNjLLzdL1m2bsKvWJUxxjxtDnIK9nFN7IVwR67+Ja2d
         CY0WujeHvbDpeJhofjgT+cFr8GpkBzb8VmAWU+EY0s9SvyicUEBfkxmFjr5rUvGiWJbj
         x3p61Nrs9XKFUu34cs9EZVotC6H9m6jsfIyScc+gHqm7HuamXrwd0N5pvpFGJmPi4VME
         njIankW33ki9x+QaVt89YlwbSm7Am/68L8OBSCw1YO9PsbBAyyF0k/UtLx0TvVNrx98Z
         Tgug==
X-Forwarded-Encrypted: i=1; AL+hErHzLojp2LX/MYop1pC86jUggvvtIPvoiPZFmecszGLDUPS/nm0AYkavxlFUKfvt4qu3P7ufP1tVcZ5lzg==@vger.kernel.org
X-Gm-Message-State: APuU4Z+Q9SKJG/EtWc693isGWZ/DFoOEeAUIGvMBMG2rm7PX7R/BZZNB
	eKKTP/7EU+HTQQASpngmOQHj7Jxwg49wEBcDiLbZz6tyjU0uXsaMo5N0+zNmYXooseL09icntbO
	B2ZPuOkdg7nDgpA4FGk9wZ63xN092sfo=
X-Gm-Gg: AYBFou3VKL3/+I71Phe9tbyziicFatOGXEp2pntQrq+UTbQdlz/nYBIcpcfLDgSbQ90
	qngcwiDJjxmJXcUjY3zUUhDQKg5CftPKnkKsJ0c+YM8FVrrcCjcDCF2hegLQ1VlyZOMFj/Lil+A
	8XCsACz3TTHBpIy0vNIGIsyXCcA5e6npf1W/SmYCMbLRRWMwSuMKwRk2xWShA5MfcS6+xYUFENZ
	ujDoEE+lIUP3t6MmmFZqamJfBfE8Gw7HgZgQFzRAwy37RJPWXQelLAjMcsAEMqDwodaNlSGi9VX
	aPSwHSskKfPYhDcOzrDWVCI4z00PUw2xLAXzrsti2eEpRbZUIkBPkllegAcfDR+J2vZtEZDmsoI
	4994In610LGk/v1cqb+tm0smzV1czrpjTcoVa
X-Received: by 2002:a05:7022:f210:b0:1a9:cad6:5b58 with SMTP id
 a92af1059eb24-1b3b619527emr6112214c88.39.1794342879053; Tue, 10 Nov 2026
 12:34:39 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261109-legion-lighting-rfc-v1-0-a87e1db8c5e3@gmail.com>
 <20261109-legion-lighting-rfc-v1-2-a87e1db8c5e3@gmail.com> <0ff29b9d-bfd5-4d89-0e78-05497312e390@linux.intel.com>
In-Reply-To: <0ff29b9d-bfd5-4d89-0e78-05497312e390@linux.intel.com>
From: Ciro Pedrini <ciro.pedrini@gmail.com>
Date: Tue, 10 Nov 2026 17:34:27 -0300
X-Gm-Features: AclHuK8u07v-lJ61Vl1Al48vF06fYxLioDMP6HLdGSnp9INLtz5V4nXHU_TVAE4
Message-ID: <CAPKD0HfAWsMDntCAmjKSOsc3zOeLVMUn9=uBK45OaFo2ovy-XA@mail.gmail.com>
Subject: Re: [PATCH RFC 2/2] HID: lenovo-legion: Add keyboard lighting driver
 for Legion Gen 10
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Mark Pearson <mpearson-lenovo@squebb.ca>, "Derek J. Clark" <derekjohn.clark@gmail.com>, 
	Rong Zhang <i@rong.moe>, Ike Panhc <ikepanhc@gmail.com>, Hans de Goede <hansg@kernel.org>, 
	Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	Werner Sembach <wse@tuxedocomputers.com>, Aaron Erhardt <aer@tuxedocomputers.com>, 
	platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ilpo,

On Tue, 10 Nov 2026, Ilpo J=C3=A4rvinen wrote:
> Thanks for the patch.

Thanks a lot for the thorough review, and sorry for all the noise in v1.

I sent v2:
https://lore.kernel.org/r/20261110-legion-lighting-rfc-v2-0-845726afb71c@gm=
ail.com

Rong asked to keep only the keyboard controller, so all the LampArray
code is gone, including the pair lock and the byte arrays for those
reports. The rest of your comments are done (struct with __le16,
guard(), devm_mutex_init(), no magic numbers, includes). Some answers
below.

> Please don't include how things were prepared into changelog, but you can
> use the area below the first --- so it won't end up into the final commit
> message if you patch is applied (our tools will automatically cut the
> part below ---).

Fixed, it's below the --- now. Sorry for the rookie mistake.

> > + spinlock_t event_lock; /* protects ready */
>
> Why does bool need a spinlock? That sounds like overkill if it's all it
> protects.

[...]

> The racing reader side might have already reading ready and unlocked. So
> what does this lock actually protect for real?

You're right, nothing. I checked hid-core: it holds driver_input_lock
during probe() and takes it before remove(), and raw_event is only
called when that lock can be taken. So raw_event can't run before
probe() is done or after remove() starts, and ready was always true. I
removed both.

> Can't the work be managed with devm_ ?

I removed this too. It was only there to call
led_classdev_notify_brightness_hw_changed() outside raw_event, but
that's fine to call from raw_event (hid-lg-g15 does it).

I kept the LED itself without devm on purpose though: devm would
unregister it after remove(), so after hid_hw_stop(), and in between
someone could still write to brightness.

Thanks,
Ciro
