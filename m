Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.180
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794562346;
	b=Qbo5tyOnotQ5yOhB+zctVSzE71vzSl31oAyBO7iEKdd8wKwByRF6m2Ut9HmufPorAtRv
	 3u1yMjBIELf5kc/fVYtS1pupzskbAf7AvcDyJ4Vsfs1q1H9HGxiHudtwZATJGONOyaRDm
	 /F13yFsOmAsMoCvb0dPYSev5SXUC/oXq3QbJuYqU4flnQkM32vF225xG/fGtZGOPb9yQU
	 kPlJrgpolY5gyew6tbWOjY5wInhOgfBiPyhLBzQe2yYn0cwZ3Psqe/Z7d0wUKAU/Scdl2
	 09WPJ089xgFGx8KaBn1aVuTaSEknSFgvF5zQoq+lrZKwLYJXwAPnT+7hXoklJmxvnBA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794562346;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=SUNZMXe1GM6kWxO3EpXBhVnmSI9S4lEPAqUOYnawbcA=;
	b=BtaaYktIWh07mZXMGdOvrSYZcUxMgSwYr67hO4/HajCLkzK8ajZZOrvmhYvZvrYx0A9s
	 5mtylDddVx9o+uoEn6vtrHczZ5mQIj5sPy2tGrr+W5iUODQ0lsuyuLrzfWmwGocDbnBft
	 oLXkVnav5MSxVP8xSJCypYh8FAGte2tLo80lRucfIxj1L+UkyZqrJq73307OVGMum7IWh
	 zhcnjS76uW278Mh1W+nyJuYdYLoqlSdv9WqwzI6nuEfc3ZOG89B2TA4jtOpRfHCK+IREZ
	 hiO6LLUwArVeCw3My/gZcG6GRKLj5ljDh786ohfh1A8174km9Lc0+VqpAjF/7XA3P8Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Mb9wG4sY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.180
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE2F606A327
	for <linux-input@vger.kernel.org>; Fri, 13 Nov 2026 09:32:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0AE2F606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Mb9wG4sY
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-8b31fc13124so5545137b3.3
        for <linux-input@vger.kernel.org>; Fri, 13 Nov 2026 01:32:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794562345; cv=none;
        d=google.com; s=arc-20260327;
        b=lu8T3E6URxykwdsTYOq55JlMsBNaXOX96QgO6Z/L7OWrBa6ZkV4w1qVybxGj1Fufv3
         7ZFZD52xJcX3f42ABhsQFzdBg4ptJ7DRl/bU/R/LyGujkmSrtokOwsR+MFMLI2WzExED
         yDL4I5C4yetIG3shAvndIt2wWJHk7dYsC2XItm4mY/QYsmejqDpmEYaXFxjmVcNSlDYm
         Xi+aAIW/sU3j0aSSj5TBnwCG/K3VhHa290wGCKQORYASRph+J6XtQWn764DV4SWiDYeb
         Ett4qawnCuWj4tw+G9CEkjuOPJS1TY2ty5LNytXXO36ktfcin0tqVRlK/YI3uour4iTT
         uYoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SUNZMXe1GM6kWxO3EpXBhVnmSI9S4lEPAqUOYnawbcA=;
        fh=uUP58D80W27W1pW9puKurhNnxe2CK3N0r0uRlqiqqAY=;
        b=BgArQHEpFQTRL2Sy4H24+Tst6ZBgb7tTV4X1GrIDquC015RiuG9po01iq1ySaewZRR
         LA6U1rdzDFDZhyRsbUqnAIrtRhJAcfj40+oKiRtUOwD01KswFSE1PP94r9Z1D1+Uz+3f
         azvlWHRf8WDAdSNsiw28pRQ6nl1MBFrnspn8WXXpvI6lWrCAUZXeaeNB7V5YRzbHO9xv
         cqx2x5SJcROYhWmDkzJPduSH8XH+Kd8KTGZynZVdUQafe6/ARZLK/08DX6glEZjNBGlU
         /xJnmbdrutPIMEhIGidLSwVrIG2bQgMdOg2yYS4SPOFgvMQV5McBg4GtIHdDTnSvVuX8
         dQPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794562345; x=1795167145; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SUNZMXe1GM6kWxO3EpXBhVnmSI9S4lEPAqUOYnawbcA=;
        b=Mb9wG4sY0QqIjN4QD3o1anwYH6pdqp7Z5e0CCPPaPvOG+MNlZC3ozsr5hSXk182w5Z
         t1WhyFQLHf8KZJ71Fm7nxK26YTIeqnacdYw3dwcbyb4yi2zPScTfKiQ1qimXy4ukdmXU
         bkIbZypS6EPEokf71e4Mk8rIT5lU59HXM9QQK5yqGTPPkMzBOy2zN2FDFKS+YvSZgO4J
         eLnsu66OsbiThbcFyLsyXfDpLmMqDFmxHB7J0rNsAX1hpYnJD64WQ6JNzB9iBpo4yBO5
         hL01Y/GnP94/1JRyJs+nPltqXoTIMbvHio5nLVh57cKLyqfMkaMVd+ol3cpL6F7cLqo6
         GIaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794562345; x=1795167145;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SUNZMXe1GM6kWxO3EpXBhVnmSI9S4lEPAqUOYnawbcA=;
        b=1TALuyhzWT5s8iaU7ffdzYGT5XcfHPbloM6jSF5wTmHixSPajE0o0sM2tzFQkL0S5w
         GTzLHMOaDMOGMozozWoN5YN71V7Pm384SyaZIR6E1HQWv1y7nATF0rgh8leMBQH5lOa4
         j+PzKpt+guFcmUljVhjDf6EYnPZpg3PGkraeZvypOeHOELvGxJ/zHnKDsyCrvB9txhBJ
         Ib+FiM0wWbO4awKDyWca/6H6MusTLKDl8oekP7A2+jM3LvPCMbjITlJWdzvAgXlV8mDB
         LRqcgEVIxka6NOyvFemU+hm1J5AN3gYEFGhp7Gpn6wIEeokzBtWTMtughzL0XBGubyq3
         w77g==
X-Forwarded-Encrypted: i=1; AL+hErHuLd6OTtJWR12WZ0ii7/DkkBZ59bMBAfsOM9yy5PLvdTHlpviwMV4i7bK+nMxaEL7n8GKYe/bBVemZ9Q==@vger.kernel.org
X-Gm-Message-State: APuU4Z+zzjL8MuHBD1TAScg8wnYSsnwphm2I29UrN93uAhwbYmPvI5Wl
	kJlaeJy6R2iEEtLB+r4PLvBKfejHNXYdrApIsBIJxvXYrF8UwzpE/DHCDTLAZkLwvB2vlOjN43R
	TTC+G+kS0CHevjF0S6MTyR0Q/fOqo4DU=
X-Gm-Gg: AYBFou2YCry0DUa/8FTA//4aiglnQMlH6yhvjKjF3OQY6/9m6gHmtf0V8+1ga1QIdp1
	R/M+PJULABr7f0vepK0jBcK/JCW1W7nmF3v379dmy4F+5zAw3taMU2Rgwe+ZDO8V430cCNQk0oW
	S78gGeIX7lyom8p/LaAZ8YGoPrSxm1QXN/66fypQGliHU+LZ8vjOWutdgNpt2mwfYghhQeSM9uY
	uNZ8n15BkDhQh/7AzohbJwYduHT9SiJ5IHsSiX1j/EuY4sxYk7qoarAfg4Q7g3bXt4Js48UHhYM
	RN+yZ6fNhzwBO/VcM1tsTeOhVd6EQKgyzSUdI3a9H0VZAhsrioh3FDN+B19d7zNx/eE7MDNWBIs
	Nrj1SXt74/PQIzeQHocaUdDy3E3pK96jr+zeLY/3b++O+jWqfb/iLg1FwP3cFVx4ZGQSazGbi5c
	0DiaeGoe8W7AGWR5lcpiu1LJgT3BXIkDtNp7uBEXaDgAFzipo2MwuRtEjf76i1nchjHRhoKIVSi
	m433q2IkXYQwrONxOKlXinHVrkezIkYEKabqWDZFi20w4hBFaD7Uf/Yb7yUDvY=
X-Received: by 2002:a05:690c:1b:b0:8b3:7782:6759 with SMTP id
 00721157ae682-8b4aa323715mr19625897b3.38.1794562345098; Fri, 13 Nov 2026
 01:32:25 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112065037.1800467-1-dmitry.torokhov@gmail.com> <20261112065037.1800467-3-dmitry.torokhov@gmail.com>
In-Reply-To: <20261112065037.1800467-3-dmitry.torokhov@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 13 Nov 2026 11:31:49 +0200
X-Gm-Features: AclHuK-aYVuDT1vvMCtJLPucjNeheRM7g7YQo6HW2E7XrTdn0Ql1diwa05ev5tk
Message-ID: <CAHp75Vfn68p5G6i8khQyo3COt9Aq06JeYJjHBqaOGXbmtmRNdw@mail.gmail.com>
Subject: Re: [PATCH 2/5] Input: tsc2007 - remove unneeded memory barriers
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, "H . Nikolaus Schaller" <hns@goldelico.com>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, Andreas Kemnade <andreas@kemnade.info>, 
	Johannes Kirchmair <johannes.kirchmair@skidata.com>, Yuki Horii <yuuki198708@gmail.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-input@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2026 at 8:50=E2=80=AFAM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> The driver invokes mb() after setting the stopped flag in tsc2007_stop()
> and tsc2007_open(). These mandatory barriers lack pairing barriers on
> the reader side and are unnecessary.

...and they lack the comment why.

> The wait queue operations wake_up() and wait_event_timeout(), along
> with disable_irq() and enable_irq(), already provide the required
> synchronization and memory ordering when stopping and starting the
> touchscreen worker thread. Remove the redundant barriers.

Reviewed-by: Andy Shevhcneko <andy@kernel.org>

--=20
With Best Regards,
Andy Shevchenko
