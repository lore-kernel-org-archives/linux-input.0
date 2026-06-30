Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3333E8355
	for <linux-input@vger.kernel.org>; Tue, 30 Jun 2026 09:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782810676; cv=none; b=dfKeO7hfkbJuiPKGOmEeUjFmGzbWtAhz8J47//2XrO/MUxX2WZtMrjwV+svO2F4T5ilRYcaeHIx3OwVMYWoA1ezZCTbgjt1pmdIffVmgliz69K+/EKFxBrXNyzGDDzzQ+iIABaWzrlutZYbuVimTqfbcnwU0Y376nYRnbO9PM3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782810676; c=relaxed/simple;
	bh=193cfTaDDGjwuinG79D2GmXaCBFZGkvbuMEmFE7J2qc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mo4HfaxlZ5hyG80ACBGG8pDrj72GuyP2J34mF4EdqmWYawTPew+r1/6FU3mtGXNNdpsQy5UyidSdlhwD2UYRN6gd/JQygwTICAPyQqTXo4vMdLDUQdgENSx9sETH0Ij9tmKyu5Dt8TiAp99Lw41jSteRTA1wdScfzCe5jRPjlzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=awWv6oSH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="awWv6oSH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56C2D1F00AC4
	for <linux-input@vger.kernel.org>; Tue, 30 Jun 2026 09:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782810675;
	bh=VqcahYNpAc4yRfmHZWlxmYVVRzOStUfLdeCO82yX4+A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=awWv6oSHEhIuHyOvMHsMUW/vqC7777Qag7IInBv5u8iBK6wgDcq9eSwvVosF3W3+R
	 xa1xcN9F+6fSpgvT+BYJRlgxTTTeaitekPnn+OZxG3q466KrEmNCTpsZ4gn+bcEuaj
	 7ddb0E+tx5Cw/ZElQFHUETIeC8+fB7r4jYewt41xj6Qyus6NvWzaTtBZhICZT0gaCm
	 R6Ub6tvkA5z+AB2IEjto2mYZmEfGxi9YaHURCJi84Izs0aQpzNFaFrT4JWWxgkNtLo
	 NmxW6k5hAPgYkSSXdTR8/O475k+0mSmPj6vb6YZg4aLskL3HV+AYYEhWLoXVFRcZF4
	 BMgIYxoqWGDOw==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5aeb8c19017so2088763e87.0
        for <linux-input@vger.kernel.org>; Tue, 30 Jun 2026 02:11:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpDMHMyz+MSn6Blt5hw7DoE11ylulM1erij1z0HEAUYlLlbhWpAyaSazZ5S+RrIDqw+EHWJ01EdSfsnWQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxfHonWW7L1/b1E4Vptk7JyLFq3M1naEeRB28sb5MCc7amACVOh
	+LntHudAZc0wDwEBhvi+/IjbqLVTI3MrnYqJV7MbryOmkJzKPpJqy2nU5/DHfCvUFSrqTfvLmMb
	vVfEq3gy+e4BPgcfCYpMpYVZ6VLK757g=
X-Received: by 2002:ac2:4f10:0:b0:5ae:b0aa:8f07 with SMTP id
 2adb3069b0e04-5aebdb89dbemr674814e87.16.1782810674117; Tue, 30 Jun 2026
 02:11:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260408051907.792-1-thanhnguyxn07@gmail.com>
In-Reply-To: <20260408051907.792-1-thanhnguyxn07@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 30 Jun 2026 10:11:01 +0100
X-Gmail-Original-Message-ID: <CAD++jLknVJYLc0-StNFcN67pUDRQunUJvNn-Npz+HJ-j2WXB5g@mail.gmail.com>
X-Gm-Features: AVVi8CfrgF-EOJSRzEcw4ENQBAKh94u_urnuoK8omamkEzvrL3ObcspIrj4hDsg
Message-ID: <CAD++jLknVJYLc0-StNFcN67pUDRQunUJvNn-Npz+HJ-j2WXB5g@mail.gmail.com>
Subject: Re: [PATCH] Input: zinitix: iterate contact slots by finger count
To: Thanh Nguyen <thanhnguyxn07@gmail.com>, Nikita Travkin <nikita@trvn.ru>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linus.walleij@linaro.org, timon37@lavabit.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Thanh,

sorry for slow reply!

On Wed, Apr 8, 2026 at 6:19=E2=80=AFAM Thanh Nguyen <thanhnguyxn07@gmail.co=
m> wrote:
>
> On affected devices (for example Samsung A3 2015), the value in
> touch_event.finger_mask appears to behave as a count of reported slots
> rather than a bitmask. Using for_each_set_bit() can then skip valid
> contacts and break multitouch gestures.
>
> Keep filtering by SUB_BIT_EXIST to avoid reporting shadow contacts, but
> iterate from slot 0 up to min(finger_mask, MAX_SUPPORTED_FINGER_NUM).
> This follows the maintainer feedback to treat the field as a possible
> count while preserving the anti-shadow check.
>
> Fixes: e941dc13fd37 ("Input: zinitix - do not report shadow fingers")
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D221278
> Signed-off-by: Thanh Nguyen <thanhnguyxn07@gmail.com>
> ---
> v2:
>  - Address maintainer feedback: do not revert e941dc13fd37.
>  - Keep SUB_BIT_EXIST filtering to avoid shadow contacts.
>  - Treat finger_mask as a slot-count bound and iterate 0..min(mask, max).

I can test this if need be, but maybe Nikita want to check it
first?

Yours,
Linus Walleij
