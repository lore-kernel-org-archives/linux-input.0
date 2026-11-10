Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794320503;
	b=pH5GZix4aWXtTq3bkc+SeTfXX/pVHIazggLmZzBKVBy4W10mB3zMyt+T6B/6O0ACpSVs
	 ds0M0yVjUqXmxLyO1LTVYNwMGiM+FV/dn8/HCJkP9yfxAAJm1ArJq9tyIGZLqrWt8nhQb
	 Uwq/bYhb9w5uyyGcnxEAHOnG3QsLGdmhBjZs5e4WliEYh87NhiW0ajZV3v4mpfwtuEwiw
	 YMyY5GVP0wXwyBEr1/vxrxgj9UGlhb6DgoJTqSdDhKPOqwjmuJt9kpW0jSy0fmkPRNfgL
	 fSv+kCOmrQ96QGKzQEGCk4UrAp9Dg4GL5X7RfiC1elsMVPD3Lh+GeknnoCRQUnUzJGw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794320503;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Ejm8pe9G15DYxQ7Hb5OdNIp8qY5r8fdDKVN+ZYBfwxM=;
	b=XkPByZ6wj2SP78D6cqw26k7ubT4gSKc+uqrej/QSKA2I5PM0HOixPcXrhji6WrCkc3hY
	 Bb3thFugXRo0jye6AoIhTV22QyWz4IWVitnGk5OEGhvoTOKRr/hyjxX0yh8vFT63WBtjl
	 tgae7TN/ahH8fskJiC05oVzXBgFXnLQIGcKXK3bius3W6+asAyCaatB3Y++UJQDvm/SP7
	 CzEjIL0iSPMFzYwqVpRjzEeLfx/MiQS8dw/dYJcgbFP4WyvuHMlTK4aN4PZpKBEl6XjBp
	 gYpPip219QE2tCrPgbpA+hIeJht/LQvz6Oqc0t3HwKQj6Qf0RTVTS6G8xuonXcA86ew==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uArSYa94;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.54
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A836A60A3832
	for <linux-input@vger.kernel.org>; Tue, 10 Nov 2026 14:21:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A836A60A3832
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uArSYa94
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5be4fea434bso2001967e87.1
        for <linux-input@vger.kernel.org>; Tue, 10 Nov 2026 06:21:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794320501; cv=none;
        d=google.com; s=arc-20260327;
        b=FI/r78JWcxiTzd5z4sVz/wZ3eepvkzN5rRWXYVZ+ISfF4YqMIrBanMxxDWwdcuj/E+
         ZaqCwERHTVtYJ8PEjjLpPAaHAxd1diIqBEjXSmmS+CMS5NdfWaxtAJ4mGbE7X8dNVkJq
         Jai7uM2ooRDYi8loBmSo9DRAokOCgWdlHQNGLCjQCftnTHO5T1pnqGCuSRMe+SFMpCDo
         b3NFiVM5VWDJ1g3n0x34GMmKr0o/LnhrZ0nAfcr5g1nn+/fPrY+xkNEUo4Pgm1c+C4iD
         U2ThnqTNY2W7WkkpNrMVt4fpgsqI9L6EEEgZkH/F8+FA5bqqI0oa+Ew0dNJuJIlzhd+c
         ju7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ejm8pe9G15DYxQ7Hb5OdNIp8qY5r8fdDKVN+ZYBfwxM=;
        fh=Tji2QYWscx07b6+dz4AJs8wNFvMTuv8d7j6TzBXwPv8=;
        b=s42jIImP/NDwn7BnNFTTUq2Usy0sXqXjTwNHDeVtECKjeD9rCE2w+HLgjevViQriLR
         KggIJzBb0wRjAgVpwYl5yBOa3rET2cM9mBtSX39x2jKbP/EvpyvumHSnlZ78LF9H/IAv
         GNqCNfldQ9Vqnv+f/LCQYb9ub68GoTxqCBQ0akKK8aEIYqOSjur5twZVHbvkMRC929/K
         AvTupmtKOW8k20Sp2Z/H8axoy4eMRA2PgTrnI/HsMXqcY5EdMM+qSyTTpd6fGsaOApO5
         PazJoQXRuckLUfnB5efGsNWteDqzbvJoCRzxdFS4SwqnyAFk8QNlcGbat9aI9jc456r1
         Zs8Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794320501; x=1794925301; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ejm8pe9G15DYxQ7Hb5OdNIp8qY5r8fdDKVN+ZYBfwxM=;
        b=uArSYa94ATnFMRAypTPoIZopEiWjn7Q5TSFwOXUFzIXVd3gI2H/IZPRINtu6zbzQEm
         pzUccU7eoX0n2I3adAPcdkf5jZ9Hsi4QFTmUHFbgJYiTTbjBmID6AkvnWbg4NOJjd5T8
         Dqm42cOmZI4RPyjuQkR2/mN0ZfR/aSE8uHmmI//8W2Zvq7cgII+cNDJoVB+7s50E58rd
         0RCD6uBKE015IERTcPJqUkP3latdSh5W/Gx+gcFc9sSQfx0sKWWmNmpKUOcxWqiD+OOH
         Y5ObIIgUTlDOcqBZnY6TxngSwu6z90aQzL9512gnSsayMyEa8pzZG+Wie37BxTf4h4Yj
         lkgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794320501; x=1794925301;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ejm8pe9G15DYxQ7Hb5OdNIp8qY5r8fdDKVN+ZYBfwxM=;
        b=0yHd5//OLj1v99C/nIl0stqUxgVP3o6Dk3kdIpHm96M2p3YP1wyhlyHQ0BB2q/H5i2
         7ZIKIMjG0bBUiCrIrLFHjtUC/FwdVXbCP/m1blnWSwlAYfHRQtErP8rIe/+G2ZBb/n14
         Ct9LqfOSZVCMU6mAsH4fnmKgwVIKDU2YFMoRTZ2yMgLjDLl7AzmoIov9sei1KOlO0TIa
         0pMxWhxhTPYTc7AxEPBFnKA8NMEebGXeSfHiv2yJ528vQuoX0O8JihjhL72r/c9lL9DO
         kws1aZSxevqZZ+HNWGIQKKfwfhsCVyiC7q20y8+/vpWeEiChuNGLPEvXsUb2oyIBWH7S
         7Wxg==
X-Forwarded-Encrypted: i=1; AL+hErHLbRSZKt6fHrn1QlvKabg3fLX+yt9FKRxbDEwYVPpGb0147hMaR0KAaVI40+rBfHD1weQQLdfNJZNjcA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+4l7QjN4jSigorVTeMJX3PszSVc30gty2bonPeCh0gpdaoDcWJ
	dGKnjPHjM8kqifrhcuWKs4tEQ55BQJr/3l/V3nK0NHiARl5VhgSH0ghOZoKN/aT4V6w6sivsQ9s
	sRI4c9g4hgdFaxwCuemnVYhO8AjBifVw=
X-Gm-Gg: AYBFou1+gaOgsa5JY/4ZtueuPFqMunyA7CWYcsfOz/j6VOZZ6dRO6JyNx+VQOgTdD6Y
	aAvYIO7af2e57Q33C0b4iwv+p8j/qspz3ZMh0zUrCjJwWxkMfHBJRjCajfwvR4/ig+fVmQ6hPUa
	AD4bqosbFNo4tqka+YsMuA/DDUiGXMUVHegNGQcP4D94PSnwuykKdTzSjg7NKH7YWZanYYpEgVZ
	XNvc5aERi+y1oAopMZ3ETp0+7DHRVSNbrJjGw3BcCXCxJAdk69si6qv/sjVwb63OGeDsKIajD5C
	llMT8r3aalHHedLI22K987dBpopruMJ8Rm1EvyzWF62tXsE11M9o1K4tbhFbEzqX0ITGbsVysva
	mxW9TjSmtgfS0+oxD6ihJNsUgaMH2vozWs4kumS1h06h9MQ0w+ganPbG4n+5rMKxLGZd6kFQ5Ii
	W4JMiTOJhvwmB9ZCRwcBdwDo+NlA==
X-Received: by 2002:a05:6512:15a8:b0:5c1:4bb3:afbc with SMTP id
 2adb3069b0e04-5c156de82b9mr828897e87.26.1794320500715; Tue, 10 Nov 2026
 06:21:40 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261018022400.599028-1-festevam@gmail.com> <20261104105829.GI792264@google.com>
In-Reply-To: <20261104105829.GI792264@google.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 10 Nov 2026 11:21:25 -0300
X-Gm-Features: AclHuK-TGMXiiM572Q7C7MqR_s9Ybhyu13xf-9p15OjOQAwSBPcq2XTBncA1S4E
Message-ID: <CAOMZO5AjeeNdeysBuoUoejg0yECiNWjX6o=Q+_iPUfF4=uiVOQ@mail.gmail.com>
Subject: Re: [PATCH] mfd: mxs-lradc: Pass mapped IRQs to child devices
To: Lee Jones <lee@kernel.org>
Cc: dmitry.torokhov@gmail.com, jic23@kernel.org, linux-input@vger.kernel.org, 
	mfd@lists.linux.dev, linux-iio@vger.kernel.org, stable@vger.kernel.org, 
	Marc Zyngier <maz@kernel.org>, Andy Shevchenko <andriy.shevchenko@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lee,

On Wed, Nov 4, 2026 at 7:58=E2=80=AFAM Lee Jones <lee@kernel.org> wrote:

> If this all seems like too much, let me know and I'll spin-up an RFC for
> you to test.

Thanks for your help. I sent a v2 with your suggestions.
