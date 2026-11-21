Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795293638;
	b=5AU17JvIa5Gb7S6K7d/cchFlYh5asAAFk3tU0uovhDIYLagFxXs1HzVfrmA3TQywHJWX
	 kKzXYOiLIJaE4F7hTB62lIvUgolJxgvHuozQgSO6BPz6zlfNMEIFoN0TRyCINjLnZpCkr
	 Al4U/9xIoW2cH6Krt3r6gnQWUUVg9zQnevtF0YD4HnBU0mL8alWz0WlamfIwYCNfkOR2+
	 KIDToJ3Jy4cLcNUW9ZJYEqaMga+0cl5ADgT+aq5PuSXyvvmDzhqghdWSnL2rk4F9ROP2q
	 L7Zpt8fRtdTj6dr6iN9G7yQpJuOUj5EBCDD+xuk3Shb2xA3bBayHZojItSv6iMjSU7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795293638;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=1+9xKelv6Vo2SNmmJS1JrMhxkgUkTeNOsnaq1Dfc3yQ=;
	b=5AjzW1RTauyIA93UetbuJVaYrjtCeIR0bnLfV74eGqjToR0ML7W4ffdwtvN/RAy9aSvQ
	 bqJuXrVQBf/+cme0cCwMat3AjCFJOTlgEFqFGn+LKoE5CK2bojtmhG/NhuzrNMgMVF5Xt
	 gNuFLtabkI6OpJIwjk3RsSg2xoFpaHte594wswg7VXyqelQX+M4p6L51II6+T2Im6TCKd
	 Q2tQl3mA1uvl6PpgZ5ro3HB4rvK4jO5kS4/D10lqCFuP2Sqfqgt1li3usQepUjhI4g1rK
	 Jw+1xeqrSDCA5Jub103y/4IS0Xgdejz4UMVEL9pHihyyWUeC7I6Jk0z2TJzobEos5AQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HB0BCE7P;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7929606A330
	for <linux-input@vger.kernel.org>; Sat, 21 Nov 2026 20:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HB0BCE7P
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4223E1F000D1
	for <linux-input@vger.kernel.org>; Sat, 21 Nov 2026 20:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795293638;
	bh=1+9xKelv6Vo2SNmmJS1JrMhxkgUkTeNOsnaq1Dfc3yQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=HB0BCE7PL7DXjymH0OIW3hYSO36wEfw0nxPwTtX1C7fwWeDCXTXpJ4mjHgm3qP9Mf
	 h7OACroCL9nkJWX4mg/VFrB4pH/GDWsPgHbCl/KeqLT5uXXCOPG7a7nXoNWCw0WJyr
	 WHj0SUmTvySYGKMNwKCLYAcI1HYZpGPn/EkpyXMOzXYt05PQHHaN+UIRlAQT4On8c4
	 QIobyw+ttdEiXz/eYrbAN22UcLERf366GMEJ8MMcWAL2wLX0sB4TaYUG6/8a2dAi28
	 Uog623UuE+HmERallEkMDZy+uoz1jYWJw5C/T1vMPYsD5Bg8W11uLhgwn1U9aV+cyi
	 XhXBdR+LxACKw==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5be416e603cso1547396e87.2
        for <linux-input@vger.kernel.org>; Sat, 21 Nov 2026 12:40:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGB6gl0ZJXoItEfi9Ks2r/jnT5w1/4MJIKPSwefCq7gazUKRwNhlNGsvW0teFcfeX9CTkbiQLKDQEn/CQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z8GKFGaiwgVOOi1yFqVyqf1+HXLUOHkZwqCXu+elHT91jkDUVB6
	ZL22S7mpb5ykP9VTQQFgsCQekcv3YPMggbchF85MStrpmvNLxAJl+vAsKyw6E7FOvdZhYNnD86q
	DSFhn+lIjNFKVsh/0hWM5wSzBd6t+0Eo=
X-Received: by 2002:a05:6512:3d0c:b0:5c1:4dba:f748 with SMTP id
 2adb3069b0e04-5c1bc7bcccemr2269512e87.10.1795293637058; Sat, 21 Nov 2026
 12:40:37 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112064957.1796975-1-dmitry.torokhov@gmail.com> <20261112064957.1796975-3-dmitry.torokhov@gmail.com>
In-Reply-To: <20261112064957.1796975-3-dmitry.torokhov@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Sat, 21 Nov 2026 21:40:25 +0100
X-Gmail-Original-Message-ID: <CAD++jLkheoxgDVW3ZRZMnSe2LMdEDa7Qiny0FUjPxLzSwixAhw@mail.gmail.com>
X-Gm-Features: Aa3M54rpJtp0p4xkcjqFPMBHZAX15U25ZAI_rqHYM6Rkzu0O33avkFiWANRi8Bo
Message-ID: <CAD++jLkheoxgDVW3ZRZMnSe2LMdEDa7Qiny0FUjPxLzSwixAhw@mail.gmail.com>
Subject: Re: [PATCH 2/5] Input: ads7846 - simplify sample filtering
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

> The filter and filter_data members of struct ads7846, along with the
> generic signature of ads7846_debounce_filter(), are leftovers from
> custom filter callbacks that were removed in commit 937f5d5ec642
> ("Input: ads7846 - remove custom filter handling functions from pdata").
>
> Drop the filter and filter_data function pointers, remove the unused
> ads7846_no_filter() stub, simplify ads7846_debounce_filter() to take
> struct ads7846 and the sample value directly, and call it without
> pointer indirection.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
