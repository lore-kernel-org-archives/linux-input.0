Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7931A306486
	for <linux-input@vger.kernel.org>; Mon, 15 Jun 2026 06:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781504551; cv=pass; b=TQTvBTs4xnqFoNj+PRa/2Ef02ELvKkkfIc90yngdj9gsy/9P3f7D1rug6ojQ0j9f4U/0qJO04ZffeDHE0ftDNazlQiZX76EThY40oKp3atRGkiCF9Hj/nCgTudeYwfFgfyzJ7wGXy1AIzzecpkpzG32e47Bd7uHAuQ2qiVbVtLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781504551; c=relaxed/simple;
	bh=XqPNvehOEnWaZnXTerBcQEWrkudRd/l6+h30K5DXrNo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IQnyhUgyoY+FDo90PijDGJupFKpA3BiL28hqhYGgCgEDZUW0DEMVpTpNrU2ejCjDx9nxKGYM4hfJE/FY/u/wWxo/XWOW6MhvWfd1yrrNsMDxfOqvuYc0jZnKrERUG7mi4oxFckj7hLjGxHmTXZ18p52xA28/Zfeb5OspIad3jZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lt18b/C9; arc=pass smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lt18b/C9"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-13807d2f898so3190196c88.0
        for <linux-input@vger.kernel.org>; Sun, 14 Jun 2026 23:22:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781504550; cv=none;
        d=google.com; s=arc-20240605;
        b=jlnRknuwjQW8+ggAQ5k5AkHpWlKpos81xQRlKd7FAycqSefOjEpQ/NJiM+KyhWdpHJ
         mpgjpInGt3fP9YBNfTa2cc7Wbvo9QYXxeErgQ0uWQzbvUqlRBHP3mC1dAR9679uHAHP2
         dUW0iu+JIiKFsqAGy9qD2kpdFUNO3osAwdVj5xaKBjiXXq3zTKKp9712JaZcg2zLljpi
         79Q4Nz2B/QGv4QHTCiKZnhSqgQM1EzrFl3KhUSsW5vPj4cHo7nFUbY8a/b6vbII/8dkZ
         7ZWLG2GHAna2lABS5qOit7YGPFDh2CTIF231YXvK1KSsqwlbPl4NUK/VreM9yByqUM+u
         UYMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aNcg/aOawlT6U3KWhnH7Etl0bqitFbIB3mf3WqNqrV0=;
        fh=5Z3Itq3ZqIeiIu6LYG4DrX+A2dElSGDbVIPNWBZEA28=;
        b=adtN09j9VR99J0flx1p58rZZSevXknxTArxpxYEPePKN1h5Zqd/rA1g43qBfTbUgpK
         Mm+sh0kXVcpAVJJclj4ctJuARgGjmN3NxB0pg0rCAcifcxVYcUZjQ+NjykI3wj8YnOxA
         OBnnoBakzkEPgA54mFbqXU4wQdp5TdRHQi4TgEjAd8ubi06Q2BLPC3fzIGpfSYHDvHW0
         XxK3wESJr7yeG0vpGsTMAEeK5O+4lDZkBRScSUeA6hPBAKUDjeQlAuKl9BZhO5ik1Ipi
         7EYhk3SfdhoBzajFKlZeV7ehqjvv2eddHUCidR16jSFmNGgzmVY8yU1QpJHPJgKRYZkU
         hd0A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781504550; x=1782109350; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aNcg/aOawlT6U3KWhnH7Etl0bqitFbIB3mf3WqNqrV0=;
        b=Lt18b/C9Sylhcm5L/XuLyFFbipurTD2/ybMblL6P7LxWeIt8KkJdB4kVxFrz7SmZGl
         7bRyScP7YI21bux4OWJo/kSHLydpe4KVXMRs+Ot4E4T0ba0r/qvcRaW+35ytO26+1tER
         4SMvdYINuXEaC8wcSt7BAXGo+qA02pfhWyC4RkF2iA0QOz8qL5HiNC4TDk/0iPPutCuq
         R/VjZr1R7/9LHwlJqkWk7UIgO6DslBj/bpiZvkh/VVtEiChAddeMgY8FOs9BoG9pdBtA
         kZZSZh0GiYI12rMA5bmxMJzjTr9qQNjsXLVx7y/dNjxSck4v3+PpezH7dRyu4OB+3GlI
         /DcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781504550; x=1782109350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aNcg/aOawlT6U3KWhnH7Etl0bqitFbIB3mf3WqNqrV0=;
        b=pwKDCCVWdBVqllrvAY8qBOnwg6lWCFVNQtpnb2DkGMDS+bHrRlaUc4p+H75boQiYBQ
         NE4uFrQKaWP06oGm7N2pmo41U2f+dinaGpUZfrnOS8QnDrjaqJpCj3mURTHOewsaUciI
         MirMOdd0iBXqQ7vXxW7vR7bZZrODoUx/4nWtYi5ricxvxYjhG6BVJsMRaWoQMhfu4rjR
         TMEFQTHTlhpmUjEHOVnXJA3730rSXlUda6dWgrdIjw01Uacyw2QQw+9ty0PLZprTcehR
         Ju7A9t2UXteVqvKj/PQyMwKLAOt3X0gBbgu54dh7Xvs2GwYeCJPz752+2BNn5aveJRVE
         LljQ==
X-Forwarded-Encrypted: i=1; AFNElJ9ahebdfgDawJ5+uIo2ZQBSLUQtDnZq9b/t4/PMS9xSdXtFwS81xF5KLDO3OjHNeX33TXPm4jMBOyjPxw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwUnN//dJpV61tqv/C/xzs3+vIYAWZwQRBOAde3vKRdXNFuQjm8
	LuaKRk4WBqt3hhpsDnL4NtAnqQf0po1l0j8cg4SszvWSL12GtJ2R98o2FMMhxUzwPzuLTfrhdin
	pvGg3UM5abnUEmZi3W/MlOxGF+syV85c=
X-Gm-Gg: Acq92OG1wHeHlE9U8Fa1UyN0BIeGqMtZBBpCr6m4Rvroy5kZv/4uNwEZbiPxjPJIi1h
	5UgCJKAZ+4pORZiAByeqlisbJn8hWb5L2Eg2cwu+pbrM95i9e0QnNOkQ4+ClXC1GPmloK7MC6QQ
	D2es66NLCFP2krtlsySFuaLTwJyGLO+U9Wbg8SwfM4os5WrJUN9O44bfVwY+gmbUQ55fp/OEDcr
	cUsDWcRKGFd+YJlgkrAeKtqpZuqMjq1Zx6FTyY4tX2kF/kjw2sJLzrGsKaIB2OkM051JilzCSg5
	bRiTmyD7
X-Received: by 2002:a05:7022:f111:b0:137:8bc2:f501 with SMTP id
 a92af1059eb24-1384baef050mr4646305c88.7.1781504549538; Sun, 14 Jun 2026
 23:22:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528053203.9339-1-clamor95@gmail.com> <20260528053203.9339-4-clamor95@gmail.com>
In-Reply-To: <20260528053203.9339-4-clamor95@gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Mon, 15 Jun 2026 09:22:17 +0300
X-Gm-Features: AVVi8Cc0Nlsxbb5zkVkx0TdFg33anyYPsTjQbMqYQfW4SlpkYRj23DSVmIPKM94
Message-ID: <CAPVz0n0g3iHniWH2inESPf+xNv52QW4bc0h-Fh3KtVRpiwZGfg@mail.gmail.com>
Subject: Re: [PATCH v8 3/7] input: serio: Add driver for ASUS Transformer dock
 keyboard and touchpad
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Sebastian Reichel <sre@kernel.org>, Ion Agorria <ion@agorria.com>, 
	=?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, 
	Svyatoslav Ryhel <clamor95@gmail.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-leds@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=87=D1=82, 28 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 08:3=
2 Svyatoslav Ryhel <clamor95@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> From: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
>
> Add input driver for ASUS Transformer dock keyboard and touchpad.
>
> Some keys in ASUS Dock report keycodes that don't make sense according to
> their position, this patch modifies the incoming data that is sent to
> serio to send proper scancodes.
>
> Co-developed-by: Ion Agorria <ion@agorria.com>
> Signed-off-by: Ion Agorria <ion@agorria.com>
> Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  drivers/input/serio/Kconfig                   |  15 ++
>  drivers/input/serio/Makefile                  |   1 +
>  drivers/input/serio/asus-transformer-ec-kbc.c | 158 ++++++++++++++++++
>  3 files changed, 174 insertions(+)
>  create mode 100644 drivers/input/serio/asus-transformer-ec-kbc.c

Hello Dmitry! May you please take a look and Ack it if you are fine
this this driver or tell what I should adjust? That would be very
helpful. Thank you.
