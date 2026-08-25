Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D173A3DD873
	for <linux-input@vger.kernel.org>; Tue, 25 Aug 2026 08:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787646078; cv=none; b=o8JR0DpTqRSYWc7ssrtpQQz4cy5aXK6gn8AKnANETvSur1m/6n3EwVXh7LM4GMOXxbSeKuX04hcE7NgUYLffL8A/eLUw8JhawFnXSRYh4nT8Wun24H5iBzEfpETgdlRQXYdl4FsFGSX3JYDs6qHgTsm6dbVDx57Vj8On2j2aLQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787646078; c=relaxed/simple;
	bh=KZVhKkVVKcmTQDfECx+/ZRx5Rve6h4EDOfziMVPfhDU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C6dq7ucwOBczAgOScCqgeilDiKRyPSmiRMavYarmLSnxqIshO2Cm5QIuVYYZGn0cHGqnGEnpYu/Lb0VySXdxMVQUm5ETkmNsU3Lr46+FgnvQGJT4JNEQOA8hlxi3O16niftCMYytxZl04wHXBDgIpM3GFCczYXm5UU5QeltwOLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hv/BX6Rx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hv/BX6Rx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B62461F00ADF
	for <linux-input@vger.kernel.org>; Tue, 25 Aug 2026 08:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787646077;
	bh=VFx8THNvlhHzwpY2vX+09J5Y6Tpu/ep/cb3q7o9OOSg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=hv/BX6RxPUtmoO4uSwmQwUAGHYKRNp1gf/IeoIzj5wwp2gYVFlJH6DSga+s4vPYEi
	 i+bBWi4dTWIlo+8WymBD3Q4FV4Or3xNM+m3peS6j0U9mIToCnBggvPLD1ssuRr1IfF
	 CG9c2FloBeKlNZzEMqu9qirj7TvZqDYKLJava0ZweZWYLvgu7NvitQ5oPTiiAL0NT6
	 3pRxtGAjomYGSDs0epK/aZoH457ni60EiPYnDQi4b2sKBLqDziUKA65FxYGUidY4M4
	 joJMfYTbxj4nf2ciFEyUnW39F/+lKFX/vpok7TqTYt9UyjchGKCte7BRoCn8PW/OGE
	 Q+8ZG4uV32CPQ==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5b013aa02b2so727511e87.0
        for <linux-input@vger.kernel.org>; Tue, 25 Aug 2026 01:21:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrhvF0C8Pe3klp6lGBVXa9Ta3jgqzBOmxFh6MbBFGdveY2NRODPe1J6PEjL3zIbEu2wpmLzR2pv8BtSxg==@vger.kernel.org
X-Gm-Message-State: AFuF++kVtDq3BMI8O07LOChR2whcTy66dlhclrPOTZO98mJQCjgEBwLJ
	68XY03NwOgG0ONQqeA+uS7jSt+PXlkqd0lmuwcc+E/85HVMWMjCegJCtdoZOCIjfdwDhqwrBnH3
	waHnmur2exWSVLdspaYB5EhLp/iqUKCM=
X-Received: by 2002:a05:651c:30c9:b0:3a1:11ff:c30e with SMTP id
 38308e7fff4ca-3a1edaa6e4fmr7592731fa.4.1787646076423; Tue, 25 Aug 2026
 01:21:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260822213941.98882-1-michael.zaidman@gmail.com>
In-Reply-To: <20260822213941.98882-1-michael.zaidman@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 25 Aug 2026 10:21:04 +0200
X-Gmail-Original-Message-ID: <CAD++jL=DZnKeSUu7TrC1uFn83eUu=WAFh5FGiVkO=oT3DZ6yzQ@mail.gmail.com>
X-Gm-Features: AcwNN1WKdtYtXkBVQOuaDmm-ttGthjANLsasNjc1oVdvUlamxb0eiZJc_VAtFds
Message-ID: <CAD++jL=DZnKeSUu7TrC1uFn83eUu=WAFh5FGiVkO=oT3DZ6yzQ@mail.gmail.com>
Subject: Re: [PATCH 00/13] HID: ft260: add UART and GPIO support, plus I2C fixes
To: Michael Zaidman <michael.zaidman@gmail.com>, Lee Jones <lee@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Germain Hebert <germain.hebert@ca.abb.com>, Rio Liu <rio@r26.me>, 
	Bruno Giacomazzi <brunoceg1@gmail.com>, Christina Quast <contact@christina-quast.de>, 
	linux-input@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Michael,

thanks for your patch!

On Sat, Aug 22, 2026 at 11:40=E2=80=AFPM Michael Zaidman
<michael.zaidman@gmail.com> wrote:

> Mainline supports only the FT260's I2C bridge. This series adds the
> UART/TTY interface and GPIO on top of it, and carries the I2C fixes made
> alongside them - two years of out-of-tree work [1], now replayed upstream=
.
(...)
>   HID: ft260: add serial driver
(...)
>   HID: ft260: add GPIO support on top of UART

This comment isn't pertaining to this one device in particular.

I'm not a HID maintainer but this trend to make HID devices spawn
serial and GPIO devices sort of turns HID into the new MFD, but
I suppose Jiri and Lee has discussed this phenomenon in the past?

Yours,
Linus Walleij
