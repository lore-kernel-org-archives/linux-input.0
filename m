Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481663E3D9E;
	Mon,  8 Jun 2026 18:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780943667; cv=none; b=B24B5FKE96NR9GW6lyD+dDMmxhNczDx+qEx0sRXy4MAB2FX24gYj0HZMjqdPaB6w/GbXlJfkapfxHFSdCQY2QkkHnav0Zm5kAaT9bkK75D9K/r+RcfRSaaOjb/FVP29I6m+wkWxLDkxLoZum2W7myIVs4BpqgcG0aVdrFe8dhas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780943667; c=relaxed/simple;
	bh=oZ9nz/kbJTvmS3F873oeSc0x+XA7NbT1dob8Ufl7E1o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GpKdGtyXw3R6bLU0VRE5pJZ2j+WN1dsjIPuxITSJzKyFiAE9/nmsQMlkMIi1Zmq5PqPJ93MFd62haMlKGaJyihX2bAfHpAgNWP3vhA9/Wff62J2IqX7vu2rhgbbIjdcgJP/qkFl3d75xC6KyBaEdsDKAmF5JP+6BaL433zMAKWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o3fsAMnP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o3fsAMnP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AECF1F00893;
	Mon,  8 Jun 2026 18:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780943665;
	bh=Kmv6VwjrCZAcitM+RYlmfFYyiiWj20vXOfo9JT/i8eo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=o3fsAMnP95Dz9qqZSdz7j3Typ4dTFgt7UHCI3utv7eEFi7Lw5qNDU8ffCwS0rnXGA
	 n2AWBixD1iZ0MF3Jnu0s/5MsGrM24JVU47cmGMbLsJAxkDVW9BcT4lVZJfnxAYUJ3d
	 hPUfjZqWxD/H6hxJuyasiSdI3dfsgZm/jRdXnYXJP2p/8en6u2psjnXt1IbTBWyLZS
	 RhwdSh6E+2RCz2oQzycdfxiGKkl2MWPaVz11hJtQwOkwiNkFtUSXomIuKvRqIf7Kwz
	 iqWHuny2zEusPYmJOyE6yuGQ1IlkTuGUP8u0UieqotwycY94aGfVjjhX4H0hti5dVu
	 c1jdBTpBo0bvw==
Date: Mon, 8 Jun 2026 19:34:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Sanjay Chitroda <sanjayembeddedse@gmail.com>, Jiri Kosina
 <jikos@kernel.org>, Srinivas Pandruvada
 <srinivas.pandruvada@linux.intel.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-input@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] iio: light: hid-sensor-als: use u32 instead of
 unsigned
Message-ID: <20260608193353.30e1d235@jic23-huawei>
In-Reply-To: <CALoEA-yasQhXE9o-iYL5h8w0wPMrP4f-iva-YOJ2KZV9UuGe3g@mail.gmail.com>
References: <20260606-6-june-hid-iio-correct-usage-id-v1-0-dd4a6820b674@gmail.com>
	<20260606-6-june-hid-iio-correct-usage-id-v1-3-dd4a6820b674@gmail.com>
	<CALoEA-yasQhXE9o-iYL5h8w0wPMrP4f-iva-YOJ2KZV9UuGe3g@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 8 Jun 2026 08:41:07 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> On Sat, 6 Jun 2026 at 14:19, Sanjay Chitroda <sanjayembeddedse@gmail.com> wrote:
> >
> > From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> >
> > Prefer 'u32' instead of bare 'unsigned' variable to improve code
> > clarity and consistency with kernel style.
> >
> > Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> > ---
> >  drivers/iio/light/hid-sensor-als.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
> > index d72e260b8266..ae2fda8dc500 100644
> > --- a/drivers/iio/light/hid-sensor-als.c
> > +++ b/drivers/iio/light/hid-sensor-als.c
> > @@ -241,7 +241,7 @@ static const struct iio_info als_info = {
> >
> >  /* Callback handler to send event after all samples are received and captured */
> >  static int als_proc_event(struct hid_sensor_hub_device *hsdev,
> > -                               unsigned usage_id,
> > +                               u32 usage_id,
> >                                 void *priv)  
> 
> Code-wise fine, however looking at this function, usage_id is never
> actually used,
> though not sure whether removing it would break the ABI... up to you
> to check it.
> 
It is a callback so signature needs to match.
