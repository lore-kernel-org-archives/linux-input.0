Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794755587;
	b=yMN1xo6nYrgqngbm+/t/rOEaDDNHSW6P+si+Swjq+fzTEFdfur8h7JlksJwO9yjS6YEg
	 OgMAnidjtM+RrbjjDN59DpaLCKG+OWLXrp2skV6WWFin6VoENxTsFsV3Tw0ihzlgxcNKi
	 rALiLSS+TYpjKmvYC+EiOs0QsTJQ0OeKheaFsOSTBfZfMr2nbzGDVgId+MAqTtDYOEHT9
	 SPFQ5nHJRQZJnOLjYyvrU33GPRpLftxk8i8lFiKq0KKlmSM5p+m2ttQ9D13wpW1iGKFU9
	 xgNiTjng+1EyqEOD8NDRNpf9UZ8KNxZFqe42fPGu78latnlGszflLHNrRCPdAsq7C2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794755587;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=zb6M21tik/Uybubx8lCWSAbnZMH+mqVYIGHAUrVbrB4=;
	b=hxzdgUPOfLkwSPoIuj2nPpoVY9KZnxmKBjlsTIUp2BVrnwDQ3N5FBYa4UF4Q+vsLDXvC
	 nEnXo2PUIUEEA/0VON2FnACIVMVA1PS1SaltwNe2IlHRHMjmb6qbVaH6SUJlFVEB8CxyC
	 IR4AI3+NUv3QCej2/eI++9LGW7J9afJLHoHifPqXgZ9LiAl2IxEWoj61FFLxVzT3YTjfV
	 EquFMy8ppy+dU7VcTvMbDm6yexaLb7vimRidilY2ocTGnvN5jXQUJM1gMourckprb5DPA
	 taMU2Nklw49QWKxfk/Q0VMLgutFRt9evarYLBSxMcfhjLFFJKMQ4oKmDMlOSqjTmIaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e47mmARq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F4F606A31E
	for <linux-input@vger.kernel.org>; Sun, 15 Nov 2026 15:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e47mmARq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7812C1F000C7
	for <linux-input@vger.kernel.org>; Sun, 15 Nov 2026 15:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794755586;
	bh=zb6M21tik/Uybubx8lCWSAbnZMH+mqVYIGHAUrVbrB4=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc;
	b=e47mmARqVe9ussV021ZMFPkxOupAXEa/bfQ5+TsP8Sf3W1eWnr/Wc9gnpYez6QnEu
	 SijgS+SpbmF79ldejZBfr0Rg3q53esexRQpDkoxzEi6o2B5Y+lCPGIPtbWivuI0ris
	 4lrrwws3y1KK36NaII3BQgT7BGGlf+XN/bYDFnhDUovHVi0A5W1AbqY5emguBIgJBb
	 R2z6nSlgIu/m+CadMY+5KaezpuglT4UwynwBf190g8cN7ZfCYv9ZDNn1AOONntiSwF
	 BQenXd9lKU/gkO6WW4VZ1w2spytsXnmtgHEcUzZ6RpoqyH0zTZwcNtyHXxc2/J/NGA
	 C66RpLYLBHBMg==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3acc7a0b558so25126371fa.3
        for <linux-input@vger.kernel.org>; Sun, 15 Nov 2026 07:13:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErEdNpUTaeeXnyYPqs81KYD6avJZ3qlkdZLTfTCvpfOKWbdNwTzf7H0kyCP2RFVOAc9zWrW5oWb9ZmrBbg==@vger.kernel.org
X-Gm-Message-State: APuU4Z9KcIMAutITQsVZXBAxUIXCD7q+bmiagOGouYveAGLQQmsN36iJ
	oA7pCq8sXwxrZmNuNCx6UAiC0tUj8wPa+26phhuaatnPgxprbs/YZwvY+tduMHStFUoWMwfO5xr
	8J+6LcogBkyf3Zu1U0wUE2oZSaUMW9rY=
X-Received: by 2002:a05:651c:1b0e:b0:3aa:fcfc:aa9b with SMTP id
 38308e7fff4ca-3ae2b536dafmr24545351fa.27.1794755584925; Sun, 15 Nov 2026
 07:13:04 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261115150903.16855-1-jernej.skrabec@gmail.com>
In-Reply-To: <20261115150903.16855-1-jernej.skrabec@gmail.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Sun, 15 Nov 2026 23:12:50 +0800
X-Gmail-Original-Message-ID: <CAGb2v67N8ZgHUoEWje4vSNa_VBdKsyyPfeHHiOSP-P6RPHDjUA@mail.gmail.com>
X-Gm-Features: AclHuK_KstftpDWV4de9QJqrjHW7hPs6mQ5cgjl6PxrEvBCv-LJZNjkPDDACJic
Message-ID: <CAGb2v67N8ZgHUoEWje4vSNa_VBdKsyyPfeHHiOSP-P6RPHDjUA@mail.gmail.com>
Subject: Re: [PATCH] Input: axp20x-pek - support the AXP313A power key
To: Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 15, 2026 at 11:09=E2=80=AFPM Jernej Skrabec
<jernej.skrabec@gmail.com> wrote:
>
> The AXP313A MFD cell is registered as "axp313a-pek", which this driver
> doesn't match, so the power key doesn't work on boards with this PMIC.
>
> Match it as well. The AXP313A has no AXP20X_PEK_KEY register, so hide
> the startup and shutdown attributes on PMICs without timing tables.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Acked-by: Chen-Yu Tsai <wens@kernel.org>
