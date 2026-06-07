Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2B91DE8AD
	for <linux-input@vger.kernel.org>; Sun,  7 Jun 2026 20:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780865573; cv=pass; b=S7gRCKtKqFM5CdZZ7OCRR4nsp9SU593TAw9BrMfLYtMN3HsNQrNaHd7UnR/LrpQXW8x/G4E2xexCDlKWNx0Q+vVH/3KHBjpoy5s0nLd6mLULQBjPn3f7cvCbPsOcNDXa4R0ApQUBGJB+bHEJ8YBatNmSLQbPUF0ZH+MGpMhuzYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780865573; c=relaxed/simple;
	bh=vZoC2XCI/DGhd8gJS4Xd5Yi0S1yL043KiJVCF6eOp30=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EhiocbsRBLiayk9AQ7fFPssVwSWjandl/RqiskZ/28PyGhX4mAMJ14HnZUPhtCexjBLOdI7Fi2cwIWkPZ7I5Q5FZhA2Zw1BQVZ2dmNkwxPyeGQ8YHCo9n1VxIRrl78ZwVXGqW7iSqFuQQzoGnsf1zcP5QIKIagdtvMOeRxQf/OA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ov5Tv5mD; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ov5Tv5mD"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-660323f7b27so3777900d50.3
        for <linux-input@vger.kernel.org>; Sun, 07 Jun 2026 13:52:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780865571; cv=none;
        d=google.com; s=arc-20240605;
        b=S5Kt0Xm8SdQ4pvbHQiQtBlInLIRRA9mP+RVrQbGkcsVahwr1vas7jAY6fQlzNqOvje
         ywiaF7E9Samu3Gso8fyuTP5S8uJM2O/+aQmYwuZEMHE2v2LzWqG+gP7jxzSAbnC9mH14
         6ULjJUtjHQv8xuHBg/wBujpUodLR/xvXPOKXR2K+i5c6Ioy3iLDWRpBC6M9JAIBg2ZwI
         2Dk5veLZsHx1qIttpfoOeDYz5v56WJQvWSMfiic7NNIKtTarFgK8vb3wr9hwLlAklphF
         V5TbkSI0UWiL0h95syiGLhvedYPF9+aeSuFQtoI8mWwAkUx7SwSWmYRsyf7Yst2QhLh+
         V0Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/81AVja23z3xt75X8Nbqrb+cC2JxCzobXTf0PeIKB6Q=;
        fh=NIZQZ5IPQwQOW5ZcVFjhNXb5zybDxaXpjqhFNWkRJ/M=;
        b=QypUxq6BoSLY6+p5Fo8B0EFgMLEbdV1XbwwD0xl1sefM4IEaSO8LjK/n7V4UHgHijj
         1+BF3Ty8CAeNw5iJA8/xUPTw0BFRx10n7zBwRh+LTJnFq4HcOik8pY836GPLAopMDHXP
         WU8O9F84qgJ6MjUpC4r+X5AH8fv4cLXOwtZ5oi35qrmsvDZfuKaCpkLuRVKAetQTtsgj
         Tg/QXO7TKeaz2Vu5Ry7pRx9uKDyg22rwq/TnNZJg+KOdCsAK/Iav6DIW6JOkrLmnsx9A
         rpjWv/OGWANmPWr5+bJo2Fmy3bXYZyWJukkArWf1owXW/g+7NgXxST7FNRd7zhBoBbBb
         ph2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780865571; x=1781470371; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/81AVja23z3xt75X8Nbqrb+cC2JxCzobXTf0PeIKB6Q=;
        b=ov5Tv5mDltavY3g13DSbbgKSMdBeT+YW9dQlBrCBKd5yLfAnQDhqXci3IFQrP9E87X
         6Op9dvkx3Wgm1RiKM+QE2Z1ybTOMTS/gUsubszdxcFcfdxsjNKNKHRcj4YNgofdEOh5z
         yvDNcAoBnNbyGyFxTI326be3U0Qruk2PPLpalRK8OyHgV//XV+N64D/u9eYFffyG0Jqx
         1IL7d+XcLm18PG8vNlEdhMpkxdFSLSjKwmGPWlLOElN6QSsj6AY9GDV/V+y7HP9+inOd
         5EYyd4AgMxUHTpfe86YisfZPm5k++78d7a68CZSYEZMLFD4KIUSVbaETnf+yYsv6XZHQ
         mV/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780865571; x=1781470371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/81AVja23z3xt75X8Nbqrb+cC2JxCzobXTf0PeIKB6Q=;
        b=j3/QsTkuU9oL6MDR/GWK9PB918Pe2NOYawJKPsWwi1Wts7ayma2ZsUVqXXKxBaGXUn
         ZYzT74ycBfRBt9gwvRZbd79Z+5fLZsPepGqymLvLyRXWqz+VWDFaC2uPYM2xC0DC/olP
         EcozEOsBPT1j0Ty735qkTVwAOd7ofWraSias5Zk+NCw1HlNQL4D07MrG+gQhIVbfhT6h
         HxuLGsfUkqw01W01uoChC4/07PLeNmYki/quIKXoFkOW3htlj8pbUrcJYv+TRK4wtG1o
         lGd2Ga6CQbA7YVVLHmJxfzFOATGqWuKKdCYKGq3Gr5Y4p0irhKoZfxc9xUrBU2/SzGoX
         rPmw==
X-Forwarded-Encrypted: i=1; AFNElJ9JQq+9+TQM4nSDlrdRdqkMvWlc9g7jWovI/GvSzLhcuful/eSC2xw6hDPhPPNlav7hRoJpJpapVt93Fw==@vger.kernel.org
X-Gm-Message-State: AOJu0YylrXPG1FB9UYrjL7sN62C0j4KMIpMWnx6d1Zaw4/qa1sy4tP0m
	1ClC9QaOzhNak2dyHNAgQRK3U1DTl6jA935TYgD2L4/3kFigIxv3mOd9UACgmo6Xa/YKTYTf9MY
	jSKTLqUzzyFyvMdhD7S3M3Hk5XymMGRg=
X-Gm-Gg: Acq92OE2rkTKDIR+CVyVgh/SG0LWjRRm18KfgLZcyDcxL5A+wxm9k2EkF3D2iPCMjZy
	u34dZ4FEnK8Jat9bVUMg4zSDnyLPoI1h3grVZUDfDD9+/crac3ZOszg25E4v5n7zpr4zFhSNcGZ
	uG3dMHQ+hfowEFuqpzCECMxjpXTseEpSbRnmKZB9B3MFVAj4J4G4reWcT3wNgkN79YwgXdLTlP5
	ZK1N0zJqSkUXq5I8wGOwyBQjgWq7wehMzsSvhH+smrwhvTrCdJi6lLagZcTtJFY6Hf82QjW5sZy
	KiUBTLrd+wafZidYz6yrktZJzw==
X-Received: by 2002:a05:690e:134b:b0:660:ec14:ef87 with SMTP id
 956f58d0204a3-66106f153cemr11077968d50.34.1780865571452; Sun, 07 Jun 2026
 13:52:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260606-6-june-hid-iio-correct-usage-id-v1-0-dd4a6820b674@gmail.com>
 <20260606-6-june-hid-iio-correct-usage-id-v1-3-dd4a6820b674@gmail.com>
In-Reply-To: <20260606-6-june-hid-iio-correct-usage-id-v1-3-dd4a6820b674@gmail.com>
From: Maxwell Doose <m32285159@gmail.com>
Date: Sun, 7 Jun 2026 15:50:50 -0500
X-Gm-Features: AVVi8CdYUyEsJBZuEZpF4d9hRqPKQN9LrFimrV9NNTgG4FyAsXCSjpDMM7bbtuc
Message-ID: <CAKqfh0Efa1+VShSW76tqaV8XtAZToRfsCy0cTi5sXOUm_nwLiw@mail.gmail.com>
Subject: Re: [PATCH 3/7] iio: light: hid-sensor-als: use u32 instead of unsigned
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-input@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 6, 2026 at 7:19=E2=80=AFAM Sanjay Chitroda
<sanjayembeddedse@gmail.com> wrote:
>
> From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
>
> Prefer 'u32' instead of bare 'unsigned' variable to improve code
> clarity and consistency with kernel style.
>
> Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> ---
>  drivers/iio/light/hid-sensor-als.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>

Do we *need* u32 though? Usually these types are for places where we
require specific bit-widths for a reason (e.g., reading a hardware
register) but I'm not sure that's the case here. I could be totally
wrong, in that case please correct me but otherwise I unfortunately
don't see much value in this. That's just my personal opinion though,
Jonathan may think otherwise.

--=20
best regards,
max
