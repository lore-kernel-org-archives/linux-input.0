Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8E13E3D89;
	Mon,  8 Jun 2026 18:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780944058; cv=none; b=HfyCfOyu4R1Ksrgt+e3sC48hpQyfDY3SZE6CiOkUNcVTj+we/ctLeQO2KgA9hyFbvCBMtnJWA5o+8ogLRb8T4nhPNqboDrxKIeMkcneGS+qsxfzqTfmVUaJW6VWRVcwYBUxXNndbHA+1lIJkwLqIXP2sGzrPWV10cFOkj1cI5/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780944058; c=relaxed/simple;
	bh=hww+0nzPaYQNNBwn308mXPko8sVoF6+TGzYZwHLqcZM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jB+r9xzirGiAaqnJ/VDSBBF2kTCqJjSEdarPhkvXIep/Nj9oo5ivjRGsbid3vEzGNZQzgK4EDFE5nSMFexkoOrJ+mg+lfXWHGGRO17CV6i7Qo6cS5yNmwzjHhKqAhY7rD9ATOY9qTj8+FBaPx9ZaiKEdiVe8KkuWNOvN1fUgrfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ln99pKfA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ln99pKfA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E56E1F00893;
	Mon,  8 Jun 2026 18:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780944057;
	bh=bkBT+xLfdcJa63DssQ5/pB11Zbz3hCWoviUlrnmHGKI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Ln99pKfAHI9Qu/4qFQMLmtOq4AuCzwDAkKmEkgzJ3RrI3rh9M3wW5o6cKzc96bTwN
	 3n4WaJh2SbKKmVYzlrYmi9XlDuOlGyoJLa+H+e2fw665A0Qv8n4vf2RhBh4fvZVSDo
	 a+u5MudU3Prc1BbWPGqX2ktiTZ5s30yRmS8guQC/XGW/0LUN8TZRqdCJOu71xokwzn
	 LCvqHTRavJlfrlvnxx3Q02iLZTTr35W/sc/+uiG65LyEsOP/v3RxJa6Z1JifjX8M1I
	 IdfC3IaJAjNOmhot27DHLmoLwy0jLY9d73yoxRxerSoCN/CJBQwfmev49KfvrBHbKZ
	 cmx4SKsGRGCeg==
Date: Mon, 8 Jun 2026 19:40:47 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Maxwell Doose <m32285159@gmail.com>, Sanjay Chitroda
 <sanjayembeddedse@gmail.com>, Jiri Kosina <jikos@kernel.org>, Srinivas
 Pandruvada <srinivas.pandruvada@linux.intel.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-input@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] iio: light: hid-sensor-als: use u32 instead of
 unsigned
Message-ID: <20260608194047.23791938@jic23-huawei>
In-Reply-To: <CALoEA-yiDwjkKxUE3B=qiTdBhbvinfq-UN8h1H-HysXGm0prSg@mail.gmail.com>
References: <20260606-6-june-hid-iio-correct-usage-id-v1-0-dd4a6820b674@gmail.com>
	<20260606-6-june-hid-iio-correct-usage-id-v1-3-dd4a6820b674@gmail.com>
	<CAKqfh0Efa1+VShSW76tqaV8XtAZToRfsCy0cTi5sXOUm_nwLiw@mail.gmail.com>
	<CALoEA-yiDwjkKxUE3B=qiTdBhbvinfq-UN8h1H-HysXGm0prSg@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 8 Jun 2026 08:37:38 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> On Sun, 7 Jun 2026 at 22:54, Maxwell Doose <m32285159@gmail.com> wrote:
> >
> > On Sat, Jun 6, 2026 at 7:19=E2=80=AFAM Sanjay Chitroda
> > <sanjayembeddedse@gmail.com> wrote: =20
> > >
> > > From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> > >
> > > Prefer 'u32' instead of bare 'unsigned' variable to improve code
> > > clarity and consistency with kernel style.
> > >
> > > Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> > > ---
> > >  drivers/iio/light/hid-sensor-als.c | 6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > =20
> >
> > Do we *need* u32 though? Usually these types are for places where we
> > require specific bit-widths for a reason (e.g., reading a hardware
> > register) but I'm not sure that's the case here. I could be totally
> > wrong, in that case please correct me but otherwise I unfortunately
> > don't see much value in this. That's just my personal opinion though,
> > Jonathan may think otherwise. =20
>=20
> Aside from the array of usage ids that are u32 defined here:
> https://elixir.bootlin.com/linux/v7.1-rc6/source/drivers/iio/light/hid-se=
nsor-als.c#L46
>=20
> there are additional structs used in the HID drivers that take u32 (I
> had a similar
> patch moving `unsigned` to `unsigned int`, but it was recommended to use =
the
> types that the structs use, hence u32).
>=20
Here the reason for the change is even simpler. These are callbacks assigne=
d to:

struct hid_sensor_hub_callbacks {
	struct platform_device *pdev;
	int (*suspend)(struct hid_sensor_hub_device *hsdev, void *priv);
	int (*resume)(struct hid_sensor_hub_device *hsdev, void *priv);
	int (*capture_sample)(struct hid_sensor_hub_device *hsdev,
			u32 usage_id, size_t raw_len, char *raw_data,
			void *priv);
	int (*send_event)(struct hid_sensor_hub_device *hsdev, u32 usage_id,
			 void *priv);
};

So given those signatures, these should always have been u32.

I would like that clearly stated in the patch descriptions. Consistency
is a bit too vague.
