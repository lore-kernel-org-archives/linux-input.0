Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794388009;
	b=WDDOLfRRwepGXhcZ1rp8TOSDDLxiaGsuvyI8GiaIz65bPz2AGSQxFKry3vin6T2Ivc7v
	 FlRZML2zYY+MpxkuIrLLfsSQzyhA0fyyiNes1+cvrYYt2kKFp8dz63QD+f5KD1snywyui
	 wp5s29QJrwsFvxv1grtMVS6CcjBGd8o056Fh9hzp88YPBP2adxhBoLGsfoYQTMIbMgH3K
	 UZOWONo2Dy1B7Gyh0l6U1WI94Po6iIMApsxqkrJkBEvDMDoVquC+sWZzcNYKF7gybDAui
	 A3t2OvIUI2EvWBHlK/lGl+GcwsCI+rs+FXPVQFiK1gF3MrngtZoUe6IQylBSEb24SFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794388009;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=nhwGqwmooKYRCyZi8rJPHsoqLigIHGkOKeuu8D9HzCA=;
	b=tZp7m2wy4+Iww4XznyXK5iSufcnPNHP4wq0u/syEETU81hVwhhS3Niy0Gg7KhJM9A6Uw
	 NkAhB60qL/cS4WVreqruR/J+r5ezIHSP7JeKy/AGBbPv0Subnaoc8DeeEcor/3aSRu18a
	 gkqv2GQgiWXIBoQVYVGD43KAWo2bGmxuJ3yPYZTzWfjjlReyd8DnwNc7uyoTPgu2cvPTe
	 /JWAM9EFhfC8r+ka7z9Pl0nx/gU/U5mWvHg4zF6p65VKSAr2Lk52igYwt26WtEVnDQcOA
	 trwVSB4Vr0MOu6UxgF3+peCyC1ccMrDotQ5ZbMCTsyUom6v9z1urdcUPlZ6+dz+undA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DTnVhWIU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040E4606A321
	for <linux-input@vger.kernel.org>; Wed, 11 Nov 2026 09:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DTnVhWIU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 546EE1F00A05;
	Wed, 11 Nov 2026 09:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794388008;
	bh=nhwGqwmooKYRCyZi8rJPHsoqLigIHGkOKeuu8D9HzCA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DTnVhWIUQ27Tv2DQLrJ2VBvApqarFeoAkug1m4Voe1f9Gj/PZpOo+OEBiK6qvl6pH
	 1YE7V7k01Qae1EH8mDwipKNEjN+0OGwlHfJHNzWz+LbFHMeLeMd2YHN3w+Uw8JkVH1
	 8eLNdI68ItfLCCdsQZiS5ULe1k1JrRhirZS6jq/ohVbcGEkzMsZebTO5U39Yr4Wt04
	 18swiNfkOUCxI4vokFSE+WanYa31uyJYFM1mHNfhBCqwmHqwa3Jc5qXhbeX+3kto92
	 Dy/S69taqXqVaQxWjYmAw1wpTGAwutDo3HJ2h7NR6S7KcQEM4pO1aY6+bf0ksMTaPl
	 gIhSr5AfQcuwg==
Message-ID: <sashiko-outbox-208662@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: libps2 - annotate lockless command wait
 conditions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhu Jun" <zhujun2@cmss.chinamobile.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261111084142.80954-1-zhujun2@cmss.chinamobile.com>
References: <20261111084142.80954-1-zhujun2@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 09:06:47 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] Input: libps2 - unannotated lockless wait condition in
  ps2_drain()
--

commit 9801ff26658df02a74329e6bb2b403d12fd15880
Author: Zhu Jun <zhujun2@cmss.chinamobile.com>

Input: libps2 - annotate lockless command wait conditions

This commit introduces ps2_is_waiting() to annotate lockless wait conditions
on ps2dev->flags and ps2dev->cmdcnt with data_race(READ_ONCE(...)).

> diff --git a/drivers/input/serio/libps2.c b/drivers/input/serio/libps2.c
> index 05b64277aecd9..a60912224bfac 100644
> --- a/drivers/input/serio/libps2.c
> +++ b/drivers/input/serio/libps2.c
> @@ -41,6 +41,12 @@
>  #define PS2_FLAG_NAK		BIT(4)	/* Last transmission was NAKed */
>  #define PS2_FLAG_PASS_NOACK	BIT(5)	/* Pass non-ACK byte to receive handl=
er */
> =20
> +static bool ps2_is_waiting(struct ps2dev *ps2dev, unsigned long flag)
> +{
> +	/* Waiters sample flags while the receive interrupt updates them. */
> +	return data_race(READ_ONCE(ps2dev->flags)) & flag;
> +}
> +
>  static int ps2_do_sendbyte(struct ps2dev *ps2dev, u8 byte,
>  			   unsigned int timeout, unsigned int max_attempts)
>  	__releases(&ps2dev->serio->lock) __acquires(&ps2dev->serio->lock)
> @@ -62,7 +68,7 @@ static int ps2_do_sendbyte(struct ps2dev *ps2dev, u8 by=
te,
>  				"failed to write %#02x: %d\n", byte, error);
>  		else
>  			wait_event_timeout(ps2dev->wait,
> -					   !(ps2dev->flags & PS2_FLAG_ACK),
> +					   !ps2_is_waiting(ps2dev, PS2_FLAG_ACK),
>  					   msecs_to_jiffies(timeout));
> =20
>  		serio_pause_rx(ps2dev->serio);

[Severity: Low]
Should ps2_drain() also use !ps2_is_waiting(ps2dev, PS2_FLAG_CMD) for its
wait_event_timeout() condition?

drivers/input/serio/libps2.c:ps2_drain() {
	...
	scoped_guard(serio_pause_rx, ps2dev->serio) {
		ps2dev->flags =3D PS2_FLAG_CMD;
		ps2dev->cmdcnt =3D maxbytes;
	}

	wait_event_timeout(ps2dev->wait,
			   !(ps2dev->flags & PS2_FLAG_CMD),
			   msecs_to_jiffies(timeout));
}

Like ps2_do_sendbyte() and __ps2_command(), ps2_drain() drops
ps2dev->serio->lock before waiting for the receive interrupt handler to
clear PS2_FLAG_CMD, leaving an unannotated data race on ps2dev->flags.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111084142.8095=
4-1-zhujun2@cmss.chinamobile.com?part=3D1
