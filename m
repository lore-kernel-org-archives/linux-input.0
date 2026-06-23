Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2A1208D0;
	Tue, 23 Jun 2026 19:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782241587; cv=none; b=ojWX/26lHlkoYlqzXhGKWrn1hKbGTKcMGDvNPtURIxy6PxXXnN5QiIyuINHPxWOY/nlEmBP64WS1iZZ78TmMkr+rVocX34f6WAzNLkNteiCHzjF8hbJe78qkJ1QiX1Pu+Jmm2UC4iVUnnJUVdzPs91A3ERLWZwMXrywdCJ41oBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782241587; c=relaxed/simple;
	bh=bFAeqjwDRncyY4+aMml6lairjw6B+Ht98PtR8FUkVx4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fLlG3a2e3PHCWjWKWErunTEz2zvAcHNp69U9EogHEh1z0JU8/mfXZ6OTXJgg0Xd2IaKXgdNw/Bv1Rj0VYRMPZmU4dzJZ2zHXEh+MiCbCdnqKFd4gOslRgH9JcCGNjSppmaxRpEQbxLVW8bmStY0tFFFALR98LMlVk/9iQb4+Yk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PLVdRJo4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PLVdRJo4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D942E1F000E9;
	Tue, 23 Jun 2026 19:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782241586;
	bh=vhYJJdfT1xYYpLiKDLBnOy59tDghjOFZJplHgTc2mI0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=PLVdRJo4i1sTfVbc25cfaUBHNN2E+kqnZhRax+JlCndirVUcSu8QIIbCyxAHE49lZ
	 rzBKvCQ8YAImLpqoqWNm9ZncdpZBNK++6/UqppwoXALYwsWBZ863A7MudUif1NgcFH
	 RbwSuucax0d7TQJyOWkddaQCyO9GA6x6m4xlqe6TXX8rLTrDHrmBnldctSafTv+v2F
	 1RK7lEjOCY736AW9kperS7IKcZB/96cMDfckTI11de96XUUlKJE1Jhe+fYuwrJ7M5O
	 5vT4+Lb/7Ss2Xpjm1nZqJaBTniqxOsn8ZwQHL2GBdPIrJej5KTgFAGS4tOknsTix1j
	 dB2pN0Az1a3Hw==
Date: Tue, 23 Jun 2026 20:06:16 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Maxwell Doose <m32285159@gmail.com>, Sanjay Chitroda
 <sanjayembeddedse@gmail.com>, jikos@kernel.org, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, hongyan.song@intel.com,
 linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] iio: temperature: hid-sensor-temperature: switch to
 non-devm iio_device_register()
Message-ID: <20260623200616.56a44b3e@jic23-huawei>
In-Reply-To: <0e198f80c6f28e448611e02e1fe20af632931dd3.camel@linux.intel.com>
References: <20260622052135.1804135-1-sanjayembedded@gmail.com>
	<767892206bf6a10de4122f5e1faa8481541170ca.camel@linux.intel.com>
	<CAKqfh0Hk12rA7wkU9wbse=n9qbOgbmxK0vhP6Enj-R2yKCohuQ@mail.gmail.com>
	<0e198f80c6f28e448611e02e1fe20af632931dd3.camel@linux.intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 22 Jun 2026 13:50:22 -0700
srinivas pandruvada <srinivas.pandruvada@linux.intel.com> wrote:

> On Mon, 2026-06-22 at 10:27 -0500, Maxwell Doose wrote:
> > On Mon, Jun 22, 2026 at 10:26=E2=80=AFAM srinivas pandruvada
> > <srinivas.pandruvada@linux.intel.com> wrote: =20
> > >=20
> > > On Mon, 2026-06-22 at 10:51 +0530, Sanjay Chitroda wrote: =20
> > > > From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> > > >=20
> > > > Avoid using devm_iio_device_register(), as this driver requires
> > > > explicit
> > > > error handling and teardown ordering.
> > > >=20
> > > > Mixing devm_* APIs with goto-based error unwinding breaks the
> > > > expected
> > > > LIFO resource release model and can introduce race windows during
> > > > device
> > > > removal. In particular, the IIO device may remain visible to
> > > > userspace
> > > > while dependent resources are already being freed, potentially
> > > > leading
> > > > to use-after-free issues. =20
> > >=20
> > > Please explain this use after free case here.
> > >=20
> > > Thanks,
> > > Srinivas =20
> >=20
> > My guess is that because the device would still be registered but
> > would actually be removed, sysfs still has "wild" pointers to
> > read_raw() and write_raw() (which don't exist anymore), causing the
> > UAF. If I'm wrong feel free to correct me though. =20
>=20
> iio_device_unregister() will be last one to be called after device
> removal from devm action handler. This will cleanup attributes. So,
> read_raw() or write_raw() can be called. The problem can be handlers
> for read_raw() and write_raw() if anything there which are dependent on
> clean done by hid_temperature_remove(). Here callbacks are cleaned up,
> so nothing to respond to read  sensor_hub_input_attr_get_raw_value(),
> so it has to wait for 5 seconds to timeout, which is not great. So
> nothing against change done here.
>=20
> But still not sure any use after free case, unless I am missing
> something.
>=20
Agreed that to call UAF you need an explained path (and preferably
testing that it happens).  The timeout issue Srinivas calls out is
sufficient for us to merge this as a fix, but the patch description
should then talk about that.

Thanks,

Jonathan
> Thanks,
> Srinivas
>=20
>=20

