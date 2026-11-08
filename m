Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794097093;
	b=Ruf4LDLh8GKcwCpphxVzhY1WiqlSrHO0024aW7s2SJJVwawlnDu6N6eulazXDAb3acrB
	 rFykC8FF/H5J93CBs3RunQeKJP6xb/VWGf6EqyjA6gS00jFeDzLvew6lSedyRYYufEQLZ
	 c2rkzCvmI4aG0brz0Ib8BGpN6qsppwCwZl6C4OxwsPgsZhIXvv3/Ckn4qDwW/BAu8HRNI
	 P5Sp+35yo9CUHVlTPhmQFHAQ1zzKlpCzaoL1iBNHDrE3TpvkDbsQ1RaSMobaFHJlE5ciE
	 B8lymXCZaGD/kZ5Aa5zkfvCqLTpBbHnJwWgKFz1qXQUh6chanlNM9jRvXyGJaYJBP7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794097093;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=zNHfCipOyRwY2K35hcqXGR7spCQErWk+z6+FLk3G5d0=;
	b=M/mBQTShTY8vPgmyem7JJbKDZDxvzQ6ZvmUMKZ7XUmxj+zbh+59xXSavvGRZ+Domqk6V
	 GvEatnXGfoAjRkOhdPP9W6hY8bwssQ3WRKsrU0/6k5EhEX3OFb5+/AQ7Y+MPdOUnoDLQU
	 VSe4/YPw95XMF9lcYMhoeQzUjlmDga1NCCaXKB2NVZ5Wb0HA7/iMEiX7llUSa3rB1l+0X
	 3NAk8N0iERvXpyGBBmlWIDToUsveSTsu760rNJVHe3Xt/9Vk8kj4DLmmSYJcgz6Z/yaz+
	 fmMNyG/9UZosBGfw59Oj3/ujAZgzdeaKZ5Tk/Y2+Gmsu7K7l6DP72z2efTHLjGlvzOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oAtZBEtd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B629606A326
	for <linux-input@vger.kernel.org>; Sun,  8 Nov 2026 00:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oAtZBEtd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D17171F0089F;
	Sun,  8 Nov 2026 00:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794097093;
	bh=zNHfCipOyRwY2K35hcqXGR7spCQErWk+z6+FLk3G5d0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oAtZBEtdR7DM2rDKB3Zlb7i//4lKvY54GhjwOUpbhXyexrKjBaawq616+jAoOhUb+
	 bCPLU/F157GUuXzeIaVxsm9E8GdFK7uuF0aUupTgIB+cC9vV1Rl2sB3pG8PYqX/vMs
	 JaAKA+l9aQVJw8BgmaznGYboxw2bCdGs4MZIEP8r7BpofrpFi6NtgVlhJHXdhUQA6F
	 ORz3fG/edm153voVbUCWAhWkLSx0VMXdThOOPRzvclwZQnICsEKF07ZnQTKpvuyd05
	 3YcOloCe5+NspIEZB2T+811vMmapmq6nh6SbCX6IBtKGkI/0+djwBp+/65456IBcD0
	 Xsm+EbWRvWZ+g==
Message-ID: <sashiko-outbox-203410@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: sony: fix sleeping in atomic context in RB3 Pro
 raw event handler
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sanjay Govind" <sanjay.govind9@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261108001057.29776-2-sanjay.govind9@gmail.com>
References: <20261108001057.29776-2-sanjay.govind9@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 00:18:12 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Medium] HID: sony: incorrect jiffies initialization in sony_probe()
  [1]
--

commit b4e6f33044b15e23503ab50df025ce6ffced3a7d
Author: Sanjay Govind <sanjay.govind9@gmail.com>

HID: sony: fix sleeping in atomic context in RB3 Pro raw event handler

This commit defers rb3_pro_instrument_enable_full_report() from the raw
event handler to the sony state worker so that the GFP_KERNEL allocation
and synchronous HID feature report request run in process context.

> diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
> index 50f5ad6bbeb4c..9ee175f9e58d2 100644
> --- a/drivers/hid/hid-sony.c
> +++ b/drivers/hid/hid-sony.c
[ ... ]
> @@ -1098,10 +1098,10 @@ static int rb3_pro_instrument_raw_event(struct so=
ny_sc *sc, u8 *rd, int size)
>  	if (size < 25 || rd[24] !=3D 0x02)
>  		return 0;
> =20
> -	/* Only attempt to enable full report every 8 seconds */
> +	/* Only attempt to enable full report every 8 seconds, from the worker =
*/
>  	if (time_after(jiffies, sc->rb3_pro_poke_jiffies)) {
>  		sc->rb3_pro_poke_jiffies =3D jiffies + secs_to_jiffies(8);
> -		rb3_pro_instrument_enable_full_report(sc);
> +		sony_schedule_work(sc);
>  	}

[Severity: Medium]
This problem wasn't introduced by this patch, but can time_after(jiffies,
sc->rb3_pro_poke_jiffies) [1] stay false for the first 5 minutes
after boot?

sony_probe() leaves sc->rb3_pro_poke_jiffies at 0, while jiffies starts at
INITIAL_JIFFIES (-300 * HZ).  Until jiffies wraps past 0, time_after(jiffie=
s,
0) evaluates to false and full reporting mode is never enabled on the
instrument.

[1] https://sashiko.dev/#/bug/linux-bbf93673-dc17-4826-b162-980cf3f12da0

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108001057.2977=
6-2-sanjay.govind9@gmail.com?part=3D1
