Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675053AF677
	for <linux-input@vger.kernel.org>; Mon,  8 Jun 2026 08:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780908604; cv=none; b=MKS0apFO64Bdxz3A0O0Qrx6D1aj5wI0CL1okIv+irtusLkdMd6bIUb49LB695a2PY2b0S+ET9pz2vkL5WMeto/lRQFzIECvp8HLhv3NFmjOPSFXPH6nf3S4L4cBHVeyj83XCJwYjSyua4HLcgICEGxWhKwLF9VIERxSewxSrLAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780908604; c=relaxed/simple;
	bh=owPp2WTGol85f4Xo6sbmSK2j2EOjrf4lzpS/gogNVkA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MWYyg9drVrIpX4s/mZcKPkHLyjrAuhu/5FawQTnWNw5J/SX0yWKD+/n1umfqMIfxsKDwUckw4rTPh9YuavHTzOtSICPRAGEEcCIKq5J9k/vLE6Ku6bWEqZthaT0BufKwqpm7iIDez5ofSvNMkqAxp3YNOIFanLlre8fRXlsniwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SIS5Kc3I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SIS5Kc3I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 140771F0089F
	for <linux-input@vger.kernel.org>; Mon,  8 Jun 2026 08:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780908603;
	bh=owPp2WTGol85f4Xo6sbmSK2j2EOjrf4lzpS/gogNVkA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=SIS5Kc3IYXhIUfGMmiqxWA37iMFrW+SwkXaNwQ1Iw87hV+MIOO0MctDudcevSgbdN
	 QY/Y/y2v1YzHLmsSypDxBw87Nc650CEIGXvsowx884hbNiPKgI1wQYgS7SNIPSisub
	 JMR1ACC9bIemHY8aIwumQqLIJ6fYZuw0NWotH4qQflGeAIxtJWts6ypoWJIieP/Wjw
	 ukjSa0Nljr7DzifdGe2eXeLm9na6kJf1WyfdULMHkF0BmKxE7LsgN9KU0uP76EX7zB
	 RGrLmAvSmQ8OYBq2aRQUQm9fbAMimSKY8/xJ5OMHmv7d6lXIPTHYIAa0hexOSLnrWm
	 9hOlOZWPpOOug==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3967725a77fso40699061fa.1
        for <linux-input@vger.kernel.org>; Mon, 08 Jun 2026 01:50:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9z2Asr4NzeyjkcUhVR69s2w94e3vvsjdd0y4g1BoQZzKvMwJS55dV7qiDy3YF25eJGU/vImKJM3R9Ktg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwP+3QgOeP3xmPsdU0XoAWFOZ3ZtEIkDmS9LR9KiBUG9KqJc7XA
	OvVqj+JNUFAZSb6+xVCho1eoSPg5vhpodCvaJbyCN84RFWoBESJvEVGH6bWOlROh4sgJV3/af15
	/EB3nloZLzV8OsKhsaoQ8wSGDdn4xM3U=
X-Received: by 2002:a05:651c:2128:b0:396:73ed:695d with SMTP id
 38308e7fff4ca-396d0836ea3mr43576871fa.11.1780908601609; Mon, 08 Jun 2026
 01:50:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260510052107.555825-1-enelsonmoore@gmail.com>
In-Reply-To: <20260510052107.555825-1-enelsonmoore@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 8 Jun 2026 10:49:49 +0200
X-Gmail-Original-Message-ID: <CAD++jLmUW4KjxEjwv7_an_dEMTSOtvG=q2MjhqKvnuGrWaaCsQ@mail.gmail.com>
X-Gm-Features: AVVi8Cey8G22PfktZkGwHwtR7mCZO1YUzasXgiZ-WMqXRZAcQy-0NUYhP4onn0k
Message-ID: <CAD++jLmUW4KjxEjwv7_an_dEMTSOtvG=q2MjhqKvnuGrWaaCsQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: footbridge: convert to sparse IRQs
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
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

On Sun, May 10, 2026 at 7:21=E2=80=AFAM Ethan Nelson-Moore
<enelsonmoore@gmail.com> wrote:

> To improve future maintainability, change the interrupt handling for
> mach-footbridge to use sparse IRQs.
>
> Since the number of possible interrupts is already fixed and relatively
> small, just make it use all legacy interrupts preallocated using the
> .nr_irqs field in the machine descriptor, rather than actually
> allocating domains on the fly.
>
> Many files had to be adjusted to include <mach/irqs.h>
> explicitly because it is no longer implicitly included with sparse
> IRQs.
>
> Description adapted from commit c78a41fc04f0 ("ARM: s3c24xx: convert
> to sparse-irq").
>
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>

Have you tested this on real hardware?
The commit doesn't really say.

I might have to dig out my NetWinder to test this.

Yours,
Linus Walleij
