Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795293686;
	b=M64VKBWjVHNNdpO1ONxJ4OQpijH9YL5j051xB76HryBg8sQIzvf9aZ34WHyU6pGq7X4I
	 GMWY6S+2quUIL1Y3ilHjwnbgsdXUqbiyZ9WtIvl5DD6ncDMeytRlS1gEfq0KlrD+MjqI2
	 Jqn/oSWk+6AV2Sq9iSUrzFe9qlSESSQ8h5Lx26C7I/AXh9f/c7+Fg2UYz4z8R8RzNGInE
	 Pu4Jcy00vPFuBeFC8RC4MUtvqMgJad/I7D6slm/EqsC2lc0lW3lhsBJptnImN1CrnE/2i
	 2NY+BjqgnsnUPnKzs8duGJFC1YqSULPI1zl+zlsZEJvEpD0mN3bRhDCoX7GrQIBoZcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795293686;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=b4WlBIeYfXjkCDL5Y8Z597JBZPP1KdP6QejXLz1yHIk=;
	b=bO7tQzO6LHN3T7+uoYS9B+z4mtW8/y3/pjNRIHBglwoPxegPMI92L0EtDF77w9+/9n3+
	 5+yr3cbf+tOY7ylGBsTVJHB0GcraipwYZeuKgVARH/EOb6FNFsU3zN3f2aaUE+RlgSf24
	 R26XfUSrYX8+QDZ75pECJM/XoSqpbffQZ+rjIVHQXMzYxqTRy/Qhq6qejVa3Nfe3hZjvy
	 +HgKOgBjLl+6WPQ1YrQwTGFQSizNzHHS7/ExOSH5czRUC84hNHsdQBY7xF1OOzD6pXQ+E
	 lMBV2aihXOry8L9l07wlHWz7JfavES09Kmd2DmYJysfY5Psd7NUj6msFX+IqfJ+cbaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nsSWF1bB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F35606A332
	for <linux-input@vger.kernel.org>; Sat, 21 Nov 2026 20:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nsSWF1bB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A19D51F000D2
	for <linux-input@vger.kernel.org>; Sat, 21 Nov 2026 20:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795293685;
	bh=b4WlBIeYfXjkCDL5Y8Z597JBZPP1KdP6QejXLz1yHIk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=nsSWF1bBxDCZWEEGdtVr4N7h5O6aivS2ENs9b5TFOKkjggjAm0nFTYcNnAiY4q/yX
	 4HB08kakqiYHrDG8OSSHT63Bp5iWZ8FR7jrmEaWKHtWPBUkEL2ODkcm9alazU0ptPw
	 DnXeZLLqfh4MnXTiGZzKLerlBI1PoN+Iy5E/1bI26H7H5gxa1XZkCkbltw3xI/eZpm
	 fBffjBrqqHJUXQfcVP95sXFv1Tmrhp933yEGCZf4GxwXRphygMDXbSny5K+NEXFvLL
	 4mwd+1jyYif0toej0j2AyUpb+lKCeLrwpx4gxmt66kO3N2ggttGJ5xskzwmg2KVk78
	 J5K0dAFVvRrgA==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5bccecba199so1931972e87.1
        for <linux-input@vger.kernel.org>; Sat, 21 Nov 2026 12:41:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGf/uI1PPbKKfPS4STej/2wBnaElpo79h6v+/OZ+VitAvWUQ6Gxp9/9tSNmOotfD2NwM2lNnbgh9vQI6g==@vger.kernel.org
X-Gm-Message-State: APuU4Z9vgkf/zIGSw1+Vt/g8XGJ3TcYQmXeV6Vb072oJLN4cYXzMTQrQ
	8FZ5DBmLdtXtu1o/zgUdsstomMCZ5LL/zxcNFSnWryGAbm1MbBc7cDj/jV/a++E0ug+Jvl38xEX
	NcMd56ECT48jt29PlvOjFbUJX5BiHvmE=
X-Received: by 2002:a05:6512:39d1:b0:5bf:b22f:19af with SMTP id
 2adb3069b0e04-5c1bc7c4514mr2703568e87.18.1795293684444; Sat, 21 Nov 2026
 12:41:24 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112064957.1796975-1-dmitry.torokhov@gmail.com> <20261112064957.1796975-4-dmitry.torokhov@gmail.com>
In-Reply-To: <20261112064957.1796975-4-dmitry.torokhov@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Sat, 21 Nov 2026 21:41:10 +0100
X-Gmail-Original-Message-ID: <CAD++jLn90_bz3=oE+8rV906pOaLykKFqx4Cp1snLufUu0N2X3g@mail.gmail.com>
X-Gm-Features: Aa3M54pJMyi7VeDQdtQwI-ABSXBp_5jI9c4EBusiNB2hkGon3qtq7U4AzS-lEdw
Message-ID: <CAD++jLn90_bz3=oE+8rV906pOaLykKFqx4Cp1snLufUu0N2X3g@mail.gmail.com>
Subject: Re: [PATCH 3/5] Input: ads7846 - remove unneeded memory barriers
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Daniel Mack <daniel@zonque.org>, 
	Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, 
	Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>, 
	"H . Nikolaus Schaller" <hns@goldelico.com>, Kris Bahnsen <kris@embeddedts.com>, 
	Mark Featherston <mark@embeddedts.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, linux-input@vger.kernel.org, 
	linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2026 at 7:50=E2=80=AFAM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

> The driver invokes mb() after setting the stopped flag in ads7846_stop()
> and ads7846_restart(). These mandatory barriers lack pairing barriers on
> the reader side and are unnecessary.
>
> The wait queue operations wake_up() and wait_event_timeout(), along
> with disable_irq() and enable_irq(), already provide the required
> synchronization and memory ordering when stopping and restarting the
> device polling. Remove the redundant barriers.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Weird, probably cargo-cult code.
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
