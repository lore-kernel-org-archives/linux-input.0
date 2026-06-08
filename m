Received: from mail-vs1-f66.google.com (mail-vs1-f66.google.com [209.85.217.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B61B3CFF65
	for <linux-input@vger.kernel.org>; Mon,  8 Jun 2026 16:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780936853; cv=pass; b=aH5YW6CddVMTBRPJDCIujPxSL9D/btQ5dzvSR+kIjhhpnsTvIkH5Bl6VfG06RRGjZqBDV/E+o03b/dqMUfVXEgitqKObfdheGBybEE8aNk3cFrLhf5kCuaOM1X1CpqahowYU8fdrAYUZnGmVRT/Gx7CqHEYT/hY+F1B+waEfgeM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780936853; c=relaxed/simple;
	bh=rx5DadAO67UpdbFbKqO4wfxzyxKs/HiVe57B5TgYgWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FxbkbzgmHtdRC/j2pqcdYKeJuokkc/ZwO64Btua6G0js+UtQAlWUk53tCBhS6zD444tQuzXg9hhwPaUrXeY2DOiug3X0yo5XSisEQFJDOTGEtQTf7K2ojHggolcFTOR9iNIDjghe/C6+l2WnAJtt1LTrYpRtb/Y3R3XmJovh8BE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RbTyU0BS; arc=pass smtp.client-ip=209.85.217.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RbTyU0BS"
Received: by mail-vs1-f66.google.com with SMTP id ada2fe7eead31-6cfdce656bfso1550894137.3
        for <linux-input@vger.kernel.org>; Mon, 08 Jun 2026 09:40:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780936851; cv=none;
        d=google.com; s=arc-20240605;
        b=VqytNryNYn+b7ojqD+002K2PYCgpn62FYfTxQEH5lfXLvDH9EuyoaHGOagk8swBunL
         1dgMGjfPkhwaaoyJGY7hwmW2PH3b7ujoB7/Qg5bZ69ZyorEe5ngk8zCse6ywr+um6L50
         PqqgUn2CHeX/G4cafm3mNcfa39NBJtoPcjsbdWvFAfbhpVmt96wE3ck3ql3TAWCvq1s4
         a77NRCSZwj96uQsgJXVB0q+tcdz1487It+ZTRTIf5BeO9R5DfANTN8xtoFbVq9xh4tu+
         4VyQHuoVHaZa4b3Uu0QhJwh+zmRCJXyPWVuNw5Sti8NsvAROAX1XycLQkTQTgz+dgPsh
         RmHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rx5DadAO67UpdbFbKqO4wfxzyxKs/HiVe57B5TgYgWY=;
        fh=fJ3rMqfuGBYr+xp1pIXCyrR0hXF5wqyohg9uRAGlVxw=;
        b=ijPpHXmxu9pd1o/GACRqXnkpYPLvNY8jgov/B6+6RsfmwCNSohri2tC658q81wOSVq
         h2Wyex5hVRR85cVCQ14yxRF6cLWF17gJNLm/s4AsE0N7VfunMBbNGJDaNd+Km9/E/Z0m
         hbb1qONFPrHGhr1Obgu1kbwOBXboyNVYpE6f8D0uFl5aPCHePsVQoFoK/+VrP8CdgZ8r
         cPaQDgiEjEWe1Mf5tB82KZONCCLtTH39ZFdIDFJ/YTVKkNZ5Ye4Lo+DAZX+thUweb4J5
         9tR3ycoJb2+NZigo5ZcT7Oh5g/grw0GedU2JeVLQgZFnOMQe6T1xGPD510eksdSKj693
         ZYzg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780936851; x=1781541651; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rx5DadAO67UpdbFbKqO4wfxzyxKs/HiVe57B5TgYgWY=;
        b=RbTyU0BShHTU+KT9tAqrgsehEw9vlCIxxcgWC5lkKPNJ2WNaq14odqI2b7owWKiPOR
         +/JMAOf+1OtcPmdXlaz278QwJpw99E5rOpMcOTLvZSGM/s8+Fm1KDrKX0obxFCG2KQnP
         VXtQgvCTzwF9RcgmH1fgpieZAXRpCpKVlS9jZldxkeI97A9NN5Hral6c01CHexdxiLgo
         s0puiRH4V4pzolW76cAgmV1CwWZUicqS5PUn9SdolFLV3CqOT6fJBw8DehGBWwOspmRf
         2UKOfl+Y7oQAwjPR2UaDpy4+9NS2+eaVL6u1prVogVlqiBUnZZ29B1eZLuExxobztndC
         miew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780936851; x=1781541651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rx5DadAO67UpdbFbKqO4wfxzyxKs/HiVe57B5TgYgWY=;
        b=JYCOmRNQgW0Hgd0N0PmPcUMAKCSfDV2JrnEMkoZSZqlxXBpNn3hQwxbxPrVhqpjCea
         uYGun0dC3qc3pUUHKGXkblxt7Wj/aHG8VD7QWqIpEr2qBFT0qHwkdlis4vECJaHy0Mp5
         BoJvYBtv+EEjhGf9BXgY3jsgxbbTHUKYCm+7By4Gy470ofcSeF1ob/niRgWQqLitRjvY
         xYQ3w4pyWoLOSxE03nIOrHeidffH2wVh+gC/krqr+l1g6Nnypm0inlDUjBVf1Ap8oJBy
         HTqwfs+xq538Hj4VYuHZP6e7MsYfDRkwt87EZDM4DUgH0vKDYn3yuGLtk8EgYsQ1KPVg
         UShg==
X-Forwarded-Encrypted: i=1; AFNElJ9pjVIC9hrYyq/8JQH8CV+/XEVaTaW3jqJXytauXCLlDvbBlaMpmzfN41eNPFOi0uzAsyKm7DCb9A8fHQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxZjesMT7ijNN/hUhCOQu+RvMVFI7HZE30Dx4b8ew8ggD5DxoWo
	RIcucxmemqDJyZz1OGOEaUuQO0BSYGCt1IJex4nsqYnasm06YFMCyqD+kS8k39CT3oWQsMdwp6C
	OsOqkED5nvAM/7s6PBhbIwsycJw83tQA=
X-Gm-Gg: Acq92OGqLD6T7jY3zK//fYO5SZfj2+p07xwO9OGnU9mIDTTudWgvZYFwr2vZsTqzEya
	hNHKBEXKJa8AyeqB7ZYf8HK0dWojuEdzGn1AoE5UNA0nbpJ8vFSN641wBDTw5cygunI7HMJqnKj
	vWzeG2joffdPLyAo468SGN1f8lP7lBgicpznn2KADjvZK/6geDdxZYy2BuVGhrNAGqkvWs3W6VU
	2jNYCZ3tMnt+IHjhyZIKJ17llTlWSSNxUYHjf2hby1V1WbZS8Vyhr/bldnzoB+0K2CZbWxeoSaP
	Zpfvc8byWXC/xnFjjHGbzDw5i6aLY6CxLlAUJI0d4jieyqD9poIxTgaQKLt5X0wKuG91WM3xi95
	Za8k=
X-Received: by 2002:a05:6102:5490:b0:607:4fde:1921 with SMTP id
 ada2fe7eead31-6fefddf2777mr7527961137.24.1780936851466; Mon, 08 Jun 2026
 09:40:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260510052107.555825-1-enelsonmoore@gmail.com> <CAD++jLmUW4KjxEjwv7_an_dEMTSOtvG=q2MjhqKvnuGrWaaCsQ@mail.gmail.com>
In-Reply-To: <CAD++jLmUW4KjxEjwv7_an_dEMTSOtvG=q2MjhqKvnuGrWaaCsQ@mail.gmail.com>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Mon, 8 Jun 2026 09:40:39 -0700
X-Gm-Features: AVVi8CckAHRTjPznUi9TSdmF40ARXCb9sYaYjHsEIjd_pzo-q6SLDDWWJhkDXvc
Message-ID: <CADkSEUirvwVzdmGh0bS++cy8coOiMyuHNYQrC599eyVmWMh_Hw@mail.gmail.com>
Subject: Re: [PATCH] ARM: footbridge: convert to sparse IRQs
To: Linus Walleij <linusw@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, 
	linux-serial@vger.kernel.org, Russell King <linux@armlinux.org.uk>, 
	Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Slaby <jirislaby@kernel.org>, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, Kees Cook <kees@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Steven Rostedt <rostedt@goodmis.org>, Thomas Weissschuh <thomas.weissschuh@linutronix.de>, 
	Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Linus,

On Mon, Jun 8, 2026 at 1:50=E2=80=AFAM Linus Walleij <linusw@kernel.org> wr=
ote:
> Have you tested this on real hardware?
> The commit doesn't really say.

No, I haven't. I can try to test it in GXemul, but I'm not sure if it
can boot Linux. The developer only lists it as capable of booting
NetBSD.

Ethan
