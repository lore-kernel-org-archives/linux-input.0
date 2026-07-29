Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B195F3F413C
	for <linux-input@vger.kernel.org>; Wed, 29 Jul 2026 07:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785311251; cv=none; b=P65RgtSXiIOIgmVBIoTCYursnie1DQKoKRkUrCx25rlfsofWe755+rCMj/bw27F+RvDt+kBK/dG/Sko+PEa9YfRUK8fs2l6wz8ynNDNrzy817xRF0l+q5fguFNQboHmywR7zNTsn+uf5y5paGM0JdruqCHqxkRyCfglJiPnsFRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785311251; c=relaxed/simple;
	bh=osMyXD9bF52+PH//j2kDJlPWHg0XSz5RwrfnJBrCoj4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BkAKyD6h5zVk9zocTMgosoqe4OO08HgH612YoOHNzbSkYGsLFq0ncRLJ7ckqGeyjXOHPE+Ygpin2emJHVQby9lQ/Tv5EpTrbjOD5QFAP9qm299g4FMkbdz3ckyP6snsPaI7js+Hp/SwP3fMM4oCCHs7+E9RnH/mzzRpJrHjmUoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E0K+wGVL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E0K+wGVL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 092DB1F00A3A
	for <linux-input@vger.kernel.org>; Wed, 29 Jul 2026 07:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785311246;
	bh=osMyXD9bF52+PH//j2kDJlPWHg0XSz5RwrfnJBrCoj4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=E0K+wGVLBFB5bcDJ5g9po9V99TbFbC/5KkgVjk//bjsdTXqP6fHH9zMES2FMHQgHq
	 Z1p7fEVj39MNnT+YROuRBo1fGfh16YQVmMrx2bopF+qWZ0m1P9K5/Fh3jtzkW/IHGc
	 4aFV4xYaToEeOfwwRdF59BYbYUpm69wZmaejq6b2aFctDUx+xno3UZ02Iq32P4vVVn
	 GSfarRvFAwMnsWx9F301mIfm3ylJy+JnX7XmcZ7oV83dSgYIuBLVhpX7gNui1B+Fl9
	 AwGXU7yhSvAI0MgVUD4JWK00kg5OfSjri2pEPZkNMvP+4npeqG6bAaadyvDu3Antop
	 zHkSrGI78gf2Q==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-39c94d4fdb9so6521881fa.1
        for <linux-input@vger.kernel.org>; Wed, 29 Jul 2026 00:47:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpZxzZM6HAlz1zM2xFDEw7PNEO+SgyebM6UKs4M2/7fDvVvbA9RdThsHdYXGO72LWJhHJcNLyaKi1onsQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwI14l2HQ7YFsU4Yx8ItWdWSgL7xqiZpt8u8MbU8g/uQFAUPChU
	2wGycXRXjtkJvYPlxs/Z031QBWiHpGv7oxSpn1eb8p25WBjq59SVV15et5c/0ZUcgDAEh3sNji9
	XsClKe9YpqvuxeoEOXnaHXIO5GXj3Gck=
X-Received: by 2002:a2e:be0d:0:b0:39a:e32c:1b1 with SMTP id
 38308e7fff4ca-39f606d63b1mr3064111fa.19.1785311244856; Wed, 29 Jul 2026
 00:47:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260724-zinitix-modes-v1-0-f6df7d86a878@disroot.org> <20260724-zinitix-modes-v1-4-f6df7d86a878@disroot.org>
In-Reply-To: <20260724-zinitix-modes-v1-4-f6df7d86a878@disroot.org>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 29 Jul 2026 09:47:11 +0200
X-Gmail-Original-Message-ID: <CAD++jLmfsbuFBfbVBV=eMcJ1r7uh5MFoLD4+R=KHc+FWeTaTzw@mail.gmail.com>
X-Gm-Features: AUfX_mxkC3SpPsYSgeGeQ9pahX3w_eSvwBQwmYhfecejjbcDeQVEdwRlJNOgKjg
Message-ID: <CAD++jLmfsbuFBfbVBV=eMcJ1r7uh5MFoLD4+R=KHc+FWeTaTzw@mail.gmail.com>
Subject: Re: [PATCH 4/5] dt-bindings: input/ts/zinitix: document mode 0
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

> Zinitix touchscreens support three modes, numbered 0 to 2. These modes
> differ based on their event report schema.
>
> The devicetree schema does not mention mode 0, thus does not consider it
> as a valid state. Add it.
>
> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
