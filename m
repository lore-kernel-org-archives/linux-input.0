Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793874082;
	b=s/UoWdyHlOFapdPFtpawjDGAB/jEk49BYHFING1Mx6U0MnocBSSyodQ+vxjrxUY+/pxL
	 ks1+aAW8W7MlKsayy5Mkm11TK7Wc1kAgDc+S7ePQMwGcH/KtDDbzeE9rogb8L7K7+uxyi
	 +GpzvvJAkcZWIN1OR5KcvszI53tTRFZ1IBVcQl5kTfb8bnqmb63wA2eRyY/BSmFs+2sGk
	 WoWuNLUJC9XLASbQCNqr6pUdGBY9Eqmn1K0LfgP2iy5BNaCNHJHOPN/Hu31MNZSuNQQtS
	 Lu0yClvzisLipVkO3vwiL6EXvyUAGFqKeC04/2MU4D74P/Dyae9rU3glFLjaSt76Geg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793874082;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=f8+V0rnxAQZoytXwU6raAwftOuX/dJxIAc4luNdjw80=;
	b=oDGWsd6Deiqhy/lhYw9S3+NTdt6GUvt4SlDwyjUtJUS6v3gHXGdaJdBetCwkSoWYbUVq
	 UAWGAbaNjFUvb9e2GzB7B8k4BJX4eU9yLFYxzoTqG3sdt2FW9B14Ce63l+HYK7iZ4cWNh
	 7+tPvnwpd9R/KV1CtR0TBsC77+zAmkUqF6sPEVaQICz+RdbDKdcQsK8AZKeSfPIHtSlnj
	 oLJ3/HkC101N4idlmc+MH4GqF/Q1udOImwAC17/6at8dfukejov4Of5Ohd07ZQaH/CHsy
	 Kax52EJLjmsk3Ak+OHsCfwe1YeGyHSLFqNcde9GFtoCEsLRnjVc6s97xJ7bcs07yd7g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ia5OX5I0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CCB606A31B;
	Thu,  5 Nov 2026 10:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ia5OX5I0
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=90.182.112.124
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793874081;
	b=TNPKxmmtg184qPEeT/j08C5gV5MZhkhDU8wXPv/pn+JQyqjx/fMlgMOsGoMNtQcNYoQ1
	 mDQw46PqyH79yKMnLzsC2B+k0u2hKXlfHlMfOhH/zboCRdQHBLRexfF5JprbQFsTxwdZG
	 5oxYs7r3Bg1eI4ivHkJmyUnto/+wPCVENuGCAKK8KIPZvLk/wxXFGpUgzZIhLTqVLR7qE
	 PPPRIgF0Mha+mLJUwimzrmm73YTN8uk7uiIAGvi7kprDqUerJ5u+ZIx/zL/PLYzyxLHbX
	 3F79jbtI+hHMrX9OZbupZlWqHaY9FG+uIc/RI5Gf6vw39RdjwCMBeICnDSm3fRM0rjw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793874081;
	h=DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=f8+V0rnxAQZoytXwU6raAwftOuX/dJxIAc4luNdjw80=;
	b=AGcN7LW3AQ96xFGyu3OyqbV7rEno5h8kEqwo9O0ZDMV/FrVNH5UZazIwH7qfVUtTDe80
	 6bTmUpZDeR3d0rWpYv0PACLPUAh49BaUYRtnRa3/iKx6J2dEfdvfU99oNBtoBgvoaL1u4
	 kSbQqCrnLd6ewBlzW1/4YEyA0hJd4hWhdhxKImxfTvvKeEOJhQhr5Gn0/1UJCcYXg/u4h
	 K8Mn7v+ha7Sm+QJbf1LVzi/lh7Kw5YZMLeH9/XL3SM3nA1ppGUlVAXzfR65SBZed4pFJu
	 ZF33FviIMZ6axncdNC2gh9HaUHz+cErEVNKkwludYqkMioK2Jaadqny9CstWmd+4k3Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=90.182.112.124
Received: from localhost (90-182-112-124.rcp.o2.cz [90.182.112.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPSA id 3E53E1F000C1;
	Thu,  5 Nov 2026 10:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793874081;
	bh=f8+V0rnxAQZoytXwU6raAwftOuX/dJxIAc4luNdjw80=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ia5OX5I0hASq9892LbGZEIVCIT9f+ubYtcPKQpY8hHVu1pjxp5QmYPs8Axa3Ro9tj
	 5WdoX7YaZVl59bA+2aeo6MAxHoFN0hVl+lvc1NajxJjMObzHpExrqshP7ZjRhy2OpU
	 AzkKznOXicrPkQntBd8xF7gvc3QXn1d2vKfna2rBXAWhIZwNB38rJVmP6O2dIPrfgk
	 jUglhEEojV/Q15jJzuXolHLtocewrZCIBWJ+FWquRBRaYI/hOGaiMkjGIZYNdrcvIX
	 E/e46HsPBlYSB5AOCcEMf/JFlwOxEIajwJXWRlTtEuEhbPI62SdEIX018YU2X6c+BI
	 V52TgMcUG660Q==
Date: Thu, 5 Nov 2026 11:21:12 +0100
From: Joshua Crofts <crofts@kernel.org>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: jikos@kernel.org, jic23@kernel.org, bentiss@kernel.org,
 linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, simeon@maryasin.name, lixu.zhang@intel.com
Subject: Re: [PATCH v2 3/7] HID: sensor: custom: Disable sensor before hub
 close on removal
Message-ID: <20261105112112.00003ba5@kernel.org>
In-Reply-To: <20261104201403.2039921-4-srinivas.pandruvada@linux.intel.com>
References: <20261104201403.2039921-1-srinivas.pandruvada@linux.intel.com>
	<20261104201403.2039921-4-srinivas.pandruvada@linux.intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed,  4 Nov 2026 12:13:59 -0800
Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> wrote:

> When removing an enabled sensor, set its power and reporting states to
> off before closing the hub. Keep the field descriptors alive until the
> state update has completed, and release the hub's open reference.
>=20
> Fixes: 4a7de0519df5 ("HID: sensor: Custom and Generic sensor support")
> Reported-by: =D0=A1=D0=B5=D0=BC=D1=91=D0=BD =D0=9C=D0=B0=D1=80=D1=8C=D1=
=8F=D1=81=D0=B8=D0=BD <simeon@maryasin.name>
> Closes: https://lore.kernel.org/all/CAM2dg7ewfVJSP4rFyhkCB1Rmd1+X56sAg=3D=
eUdbPthG2xrLqwQQ@mail.gmail.com/
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---

Reviewed-by: Joshua Crofts <crofts@kernel.org>

--=20
Kind regards,
Joshua Crofts
