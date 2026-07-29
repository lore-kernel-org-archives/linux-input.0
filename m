Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D695A400995
	for <linux-input@vger.kernel.org>; Wed, 29 Jul 2026 07:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785311118; cv=none; b=u+RjJr78soR2v9LK9Ju30NCcv++QuO8lCU6WyXDUTDsxrYndbya/BUeN1cZJrXa9CHqzfrN1uPAQAl7G2N7/habv6fAizPH0/5xbly0L6nQQou+C7IiSH43iZ7jOIfKHVElGnvVdOawTj4bSVi78dD9twvcOSswPgDIlmXZ2IQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785311118; c=relaxed/simple;
	bh=njDMlwwUjrHXZJhnlxUW9cltbD62DWGi6t9OJ+YlVIk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H1wOhSJNRFtK96z9N7qHzPCvg1SloMpRf/a66mAK9CFQhPgHfVKi7B3AawsVsly1K6hFnmOC1qo/c+1d9DKotj65uQJMCOWlr/r1kgx3twK99to/S4MqAzVfKyCQ430AA/4KrdCF5s5/NWAGNkFDmNtqwH2wxSuzJGBa8wtIXOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hvJbwWEk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hvJbwWEk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83F211F00AC4
	for <linux-input@vger.kernel.org>; Wed, 29 Jul 2026 07:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785311114;
	bh=njDMlwwUjrHXZJhnlxUW9cltbD62DWGi6t9OJ+YlVIk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=hvJbwWEk1wDJE7TCgcNdKpdwDRIu1W6PoTdSnh/RV+9zK/l5333jglBvwZqAhBLth
	 5ft4NXICyK5+5IOxAD15zNN2jp0ZSZE5qqrv5BJ0TzcOALo1M5wJWVrnfLTIbG97EW
	 x1pigRMhyySvq8qCu1mLfOziedjFqgp/aky5bia1NM6tZ/YXx8Krjtav79gRWMHHsF
	 D3YsgHuItwfQKADUz+DyvPUAQt78+sAn8YsCZosaN6wEqZcQt56SAJZUgzdHh0kMBM
	 Nuop3BaKf5rGk2PRnBdFd8xyzWJ7Tryq8nahuHIvcQZVF9rLsIO5lrZ7Vo7RJZsXaO
	 e2G670YdDUyMw==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-39c908d6cb6so5434591fa.1
        for <linux-input@vger.kernel.org>; Wed, 29 Jul 2026 00:45:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rq3si8jzIgySVN0+Bng+BxWG3j3RmUsI4DTboEQqq+kyPi/jRtNe4xMFUuuqRO9WUyswnn4FwUXrfBM4g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxlfY1U/SzHG8zDqXBcjIFNPM3dW4wliXfSy9B0UUZ/4aKYbSCl
	ZbxDKXQ9wKo8HsHRyRohEMrOCX8BBej6QPbIyyVhWNsZBufVwSii1j7hFUIqtNJCa08mPzpiupj
	YJusqS93ZnFvfXJ95gfCNc0nlpgxioE4=
X-Received: by 2002:a2e:bc82:0:b0:39a:ec7b:6ccc with SMTP id
 38308e7fff4ca-39f51e7e76emr9843921fa.27.1785311113316; Wed, 29 Jul 2026
 00:45:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260724-zinitix-modes-v1-0-f6df7d86a878@disroot.org> <20260724-zinitix-modes-v1-1-f6df7d86a878@disroot.org>
In-Reply-To: <20260724-zinitix-modes-v1-1-f6df7d86a878@disroot.org>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 29 Jul 2026 09:44:59 +0200
X-Gmail-Original-Message-ID: <CAD++jL=QfXJ78pfKy1hV6wGfSYzERUi=-nmqjPfMiXr9xk5+aw@mail.gmail.com>
X-Gm-Features: AUfX_mybtqZ1t6TZw4bPWVPdjZ4BP7r6xZ4c1gUK05ScOPIPKt8w7HC1bwxjbdw
Message-ID: <CAD++jL=QfXJ78pfKy1hV6wGfSYzERUi=-nmqjPfMiXr9xk5+aw@mail.gmail.com>
Subject: Re: [PATCH 1/5] Input: zinitix - check all available fingers for
 every touch event
To: Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Michael Srba <Michael.Srba@seznam.cz>, Peter Griffin <peter.griffin@linaro.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 9:24=E2=80=AFPM Kaustabh Chakraborty
<kauschluss@disroot.org> wrote:

> When this initial driver was first added to tree, that is, in commit
> 26822652c85e ("Input: add zinitix touchscreen driver"), the touch_event
> struct had a field called finger_cnt. It was supposed to report how many
> fingers are touching the screen.
>
> But then, in commit e941dc13fd37 ("Input: zinitix - do not report shadow
> fingers"), some touchscreens reportedly exposed a bit mask for the
> fingers, instead of the count. So the code was changed to bitwise
> iteration.
>
> With my testing on the ZT7548 touchscreen of the Galaxy J6, I find the
> former to be true. This shows that there's two valid methods depending
> on what hardware the driver is made to work on.
>
> One solution is to implement both methods, and use some flag to select
> between the two. However, this introduces more implementation overhead,
> and a possibility of regression on devices the driver is expected to work=
.
>
> Instead, unconditionally check all fingers. The finger_mask field is now
> left unused, thus serving as padding bytes in the struct. For each
> finger, zinitix_report_finger() is called if the status reports the
> SUB_BIT_EXIST bit, so phantom fingers are not going to be a thing.
>
> Moreover, the android driver [1] does exactly that, so it's a tried
> method of implementation.
>
> Link: https://android.googlesource.com/kernel/bcm/+/23d376ef33aa4c500a5ea=
24a290f029d5f8e2de3/drivers/input/touchscreen/zinitix_touch.c#1942 [1]
> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
