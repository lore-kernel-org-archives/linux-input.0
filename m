Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795527917;
	b=nUeo1rmKUPiL7idmrUrBZbl8vZI1gszkxjPlaXdtNyjDbPs9Xe42Lzl1XfqJ9/8UWY8d
	 Wcav9cNQ816Q3+T7kdTeEy/o4yhTVGeNe+ThAHAptb0UEJvXyyHIyf5PH49ut5J+25swL
	 OlG61NmEItZtCVSNKcboXlM+YmKsgmU8tl1vbA/O/1H6XX/92JPAiZBVC4BBHb2Exco2D
	 Z1MYVHHY2+Kf2rcCRaGgzSvNBml493jFjc918uPVEvp6m8efOGH9SnMHgcK5yeXhbWJag
	 jDJ5zE4HAp3wnO4p5ZhqPEAUPGYkbfh3vCyEO9LjvS5va6vjVgUZxULePgiqhiloS8w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795527917;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=j57TL9tgOH6N4DgQA0uqDxNRMaVYUtw4A2VwZXccKD8=;
	b=s76JgpBXVtm5zcEhdOq2BBG/0qhqA9ATahD8ZSHqiTpWqhCo58kebV3lbWGqlzI/92tT
	 Y2vCLCSmI3PIRrimASAzTQhKDWomMY5vVeSkKC4IEHZ+72n9W6l/iGn3k8t0XWijLAQQ/
	 wEUEkbVGNvllUbf1fCfKomfvdwBOPayNr7gryIcGSZ35lvNj1wYk2inR4ekp3DMrhABmS
	 CyNpkNKfYWspfwFslIKdYRycxk/Pf7rYLAW8E4pD+6oPN41ncV9RmBh8bgzd6hPmw81PJ
	 eO6G54Uan2KYCLNJ1OlK1gBD/WB6GCF5BEEzenGDNBILnSfqkGpoXtT6Q09Q4Jz2PNA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vt1INDoo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.169
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54862606A32A
	for <linux-input@vger.kernel.org>; Tue, 24 Nov 2026 13:45:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54862606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vt1INDoo
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8a052aff9e9so3287302b3a.0
        for <linux-input@vger.kernel.org>; Tue, 24 Nov 2026 05:45:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795527917; cv=none;
        d=google.com; s=arc-20260327;
        b=QSor0NVcTRzsauTytg01DWXIfghhabrO5wdhJgEIij9nvamZKfyjWERTyiBm2/YVj+
         w6F0jjCp2dhqouBfNmO62zLHpuZ3lfj3qMVvd6bUxHgVKcgZtnlaY3CgHvvTv/bY0nyu
         1SHdqNWWkjSb/RBLBJDjv4UH6BdehaHYFMxrPEUzBcYTjJsG+7c3Rx4AhcQT0Ie61ZJ8
         VCGjL+MXO+PRNFXtZ7P7ugYCiv5MehoiI01xLBxmx6IusJNLfQ8zy9xh8UdujxkE5lPo
         fMjqgvjHTXE3PDT+z1uLk9vdI5RSarZBzq46uiY3oOyOqdH2T/qdEfG1FngmNxjkcppH
         6pYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=j57TL9tgOH6N4DgQA0uqDxNRMaVYUtw4A2VwZXccKD8=;
        fh=OazeFw7n+ljsUNuDtB8ZrEYi4lkfGIocfu+OMO0HsoE=;
        b=eIibY5Uset6qSdNyCTh/g/18Je8wDdl+LXUTpebwtBQafOs6LlGMa25znRQOZrF2Dx
         e2D3QSKc36CF5FlF90dn8Qw/VJ+tF1smS4XbsH8LzUKyUdsqgjLfXkcZ50jqRZDeHrnm
         2Bb1ZlsLi9W8ksT6a/Z0OFA8VKK4yFBk8W97+R0VRLfBHJIUnfD+huVQoiR/4S71nZSX
         0WB9Jrn8Lm77Vt0BaojFfix8OQ7voOHwHF0cJsbOYwIWHUP/l3ysd96fc+WjksJ6sQ6C
         Eo1+17TGJK6kl5/KBTfOX6hT8wHsmzw8TO6eyNG12wnPuR+pjZ+lyspfdtEEn7e2HAje
         87XQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795527917; x=1796132717; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=j57TL9tgOH6N4DgQA0uqDxNRMaVYUtw4A2VwZXccKD8=;
        b=vt1INDoolzNWDmsHulKCDkGu451Gm1Lx/v/tGlO1cOdiygKjnU8wlQzyUrvvuisiDT
         vzhrEbVCigL6S5OET/RaT1ESb7CzN3C3Sa8M7QY36/JwVoufEQxU7be7R/6H8U2GER/x
         wamOcM/UUI2j3gXD+M1LHc48r8tODm464fU5pzRpXIwlULYGyTNl/v8V18oH7QhadfZd
         3PaNLkzMj94CuplAnlenQBmhvHsy1Fi56moOBbIrYUz3407FbAiRZDsmutndE2ParlNV
         zp61DV2p/ttRqeyGRDFynb/W+ldth001tcU+okb8yMlDPWZLPD0o+jy0DsIl3TunhP06
         hjuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795527917; x=1796132717;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j57TL9tgOH6N4DgQA0uqDxNRMaVYUtw4A2VwZXccKD8=;
        b=fihyICFiN6DiAwrPGn4+2a31qUUEg5M8JWn1Wz3huYOF84ZfKIpDZL1yf8NjVIRJpx
         FEkwC/jCxQoamxF6JgVYWc0TvLvoMd9oxTjCvBL8fargW66z5wMvAVFxEJDgpbeJPrpO
         3/6G3TPczEwrMzQAHwO3sU7R3K5sJys2AgMkCKUCjWTGCgj8DS/w55ybr4SkONYlA+Ga
         OuD57bRt899jGbqPRuyE2qT6ZmWdmAbf9Kz5QasxkSuHGCcyCWB/ZtoUc2tsXRfqw69u
         KOaFj5zrYY8SgTZOSOAmdImb1Ea9G4ZS1S9nGohcul+5jkkpeBVcLsdulqdtdqrj40o8
         2YzQ==
X-Forwarded-Encrypted: i=1; AL+hErH6Bv1Lvw53gpTUmuHadoCM5hHbnjzwxqGmiVfde3GDmPaQejbwtGWnz4h11+HBzCagFFKteEscaaDCWQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z/RTuJ1yy/A+5MFIdwq/eFB/qi11dxDJM4tiPp0JEuORKFS0QAI
	xlaXBJWpsvIKnPD9N0QXUqKsrMIQDHCwMKYlZ0hstDvKIM3VU4DQbADSSpbRHItFv1Ojv5qpTHS
	zA4DRTHktcCAHDCgBFBL8QLcOU7Uk56c=
X-Gm-Gg: AZFdTZfIbfsFag0gE1YOkqV9Qouhe8gAEAyOpo/WIBq1GuF+AKFgdA9RITuamCtgmJG
	3Aksoe+gqezMllKVc0+RAwWxcBU2CturGN0td3mnI2SNTyna2ZrzMVTZnScNcSh581SGaqlJCUU
	o1/Ud9J2Y7pubR6lJnTStu+6v4xW9yb8zBoflfvxkcKJlA7NSDg/DrJOxtQMx32U4kaRH2LiM8D
	k4VCerZq4mnci9YY3G6kdcmf0hJ8xm2HvjwGyx8mxz/ps6OgGY5yt21DOPSFrUZ5FXtZXHIVyLo
	hnN7oKuf0EIookqhKlaY7AyvZ5rR63MSguPp56wZ0B2ZT71vwhuzbP402RGog/iWfDEX4qoXIjn
	CJitb1pWwcEtPR7cQCVKD+SplDp5F8hBbC6fiZ/W9jns2Mi0LPZBVudb1
X-Received: by 2002:a05:6a00:14cd:b0:876:194e:b8fe with SMTP id
 d2e1a72fcca58-8c87c388506mr11654939b3a.26.1795527916456; Tue, 24 Nov 2026
 05:45:16 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261123141542.8128-1-mapengyu@gmail.com> <20261123141542.8128-3-mapengyu@gmail.com>
 <fEKBTBrZSg2lsEJtHNGWdw@koesling.info>
In-Reply-To: <fEKBTBrZSg2lsEJtHNGWdw@koesling.info>
From: Pengyu Ma <mapengyu@gmail.com>
Date: Tue, 24 Nov 2026 21:45:04 +0800
X-Gm-Features: Aa3M54qCC_XE-jVpl2uq2HQbzcd8yWMor3oIzGYbRnAPFEB4lSZVeQmgi5La-Oo
Message-ID: <CALSz7m0kJf+ZuQArpwQ68wcDNxcrHMODSbNwwSAiDYz=GEHA=A@mail.gmail.com>
Subject: Re: [PATCH 3/3] HID: pulsar: add support for Akko Gaming Mouse
To: Nikolas Koesling <nikolas@koesling.info>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Nov 24, 2026 at 3:53=E2=80=AFAM Nikolas Koesling <nikolas@koesling.=
info> wrote:
>
> Hi Aaron,
>
> thanks for adding the Akko mouse. A few small things for v2:
>
> > + *   - Akko
> > + *           - Gaming Mouse
> > + *           - 8K Receiver
>
> Please drop the "8K Receiver" line from the header comment. The list
> names mice, not connection modes; the Pulsar dongles aren't listed either=
.
>
> Please add the Akko mouse to the HID_PULSAR help text in
> drivers/hid/Kconfig.
>

Will update both in v2.

> Did you test both the wired mode and the 8K receiver? It would be
> good to know whether the battery gets registered in both modes and
> whether battery readings and power events work.
>

Yes, I tested both wired mode and the 8K receiver. In both modes the
battery is registered and battery level, voltage, and charging status
are read properly. Power events are reported on power-on and charging
state changes, though waking from idle RF standby on motion does not
send a power event.

Thanks,
Aaron

> Thanks,
> Nikolas
>
>
>
