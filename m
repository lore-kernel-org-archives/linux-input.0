Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E85D38D419;
	Thu,  2 Jul 2026 19:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783021003; cv=none; b=GtmAocR9E3i4mM6XzpHhjCDmjcphYHcfni9dLAfxEtwDWPrUlCPu9afQnxkOcgfqFxF57P4GFpf+uRU4FaasXYAP7Ae1FKEG+K48gFXnAvUpnMlU/zuObrvdfHoRZneq+a7xVe0f209gLU6JrkVzywjwLSRBZXlfl88cXPZM5eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783021003; c=relaxed/simple;
	bh=ABeWWj2xnmZZj+Mg9cQxltKZf0MRHyck2ayr4+LjYaw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FmWXGyvM5DeI8CwfEfrrvysufAkGowMaKmIXGDxKsVrHx193eP5MOTIZUp6wvkc5ZemBGs7ImwnVTFsAMKq/A8+urfxCjLtd+0qpY67h1JTCmLRzzYzFyKtOWL2po9WLps4XubnBHwr8D1jM66Mnzg4bTLZ2qCzUMpVgYr3GW4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mmIKQcT+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mmIKQcT+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BDCA1F000E9;
	Thu,  2 Jul 2026 19:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783021001;
	bh=o8llP65FC/hxew5gdmOjT8/8KOwsLN5OKheW7ai4V6g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=mmIKQcT+Ui+3WwFO8Uh4JHI0pgftcl38irAMJHqx8hFpH4wwKC/V5XgiBsDSzd1Bw
	 R16VX6kp4bkP/yuGuEfw3SBesC2oBXIBRZgcsXHhhkizCLR7boe1Qg8HcCXeGe58MA
	 36wlzCnTWtm78QS6Cre7Fq9gANTJCzsTPDmW+oJFpjQFdja9uozPQUZpF7r897vMMU
	 7RnN2qhzkcdN0YdrxGAL9W0rDKixxou5nCTa39aoeQYHhvttIlwP7k/CA3o133efDo
	 nYBqy+zgLhjnRCicrySIL+SKpGxgdJVaLNimmyEYZrAzu/qWKOy/hq3V8fhfrD1u2r
	 plww3rmspv3MA==
Date: Thu, 2 Jul 2026 20:36:37 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Sanjay Chitroda <sanjayembeddedse@gmail.com>, Jiri Kosina
 <jikos@kernel.org>, Srinivas Pandruvada
 <srinivas.pandruvada@linux.intel.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Archana Patni
 <archana.patni@linux.intel.com>, Song Hongyan <hongyan.song@intel.com>,
 linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, srinivas pandruvada
 <srinivas.pandruvada@intel.com>
Subject: Re: [PATCH v2 0/8] HID: iio: Avoid race between callback setup and
 device exposure
Message-ID: <20260702203637.47adaae4@jic23-huawei>
In-Reply-To: <aju8-caYYYR7_47N@ashevche-desk.local>
References: <20260622-5-june-hid-iio-race-fixes-v2-0-1cfabcd1881e@gmail.com>
	<ajpgQ8vCHacv_klG@ashevche-desk.local>
	<7288DEE7-91CD-4823-959B-229AEF1CAD97@gmail.com>
	<aju8-caYYYR7_47N@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 24 Jun 2026 14:18:17 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Wed, Jun 24, 2026 at 07:13:12AM +0530, Sanjay Chitroda wrote:
> > On 23 June 2026 4:00:27=E2=80=AFpm IST, Andy Shevchenko <andriy.shevche=
nko@intel.com> wrote: =20
> > >On Mon, Jun 22, 2026 at 10:59:56AM +0530, Sanjay Chitroda wrote: =20
> > >>=20
> > >> This series avoid a race condition in HID IIO drivers related to the
> > >> ordering between callback registration and device exposure.
> > >>=20
> > >> Currently, several HID IIO drivers register the IIO device (making it
> > >> visible to userspace and other kernel consumers) before all required
> > >> callbacks and resources are fully initialized, or rely on devm-based
> > >> cleanup in a way that does not guarantee correct teardown ordering.
> > >> This creates a window where the device can be accessed while it is =
=20
> > >
> > >There is a difference between "this creates" and "this might create".
> > >I believe Srinivas and others were asking for the proof. So, what path
> > >in the code makes this happen or possible to happen?
> > > =20
> > iio_device_register() exposes the IIO device to user space, while
> > sensor_hub_register_callback() registers callbacks for buffered IIO(str=
eaming
> > mode).
> >=20
> > This might create window where from userspace buffer mode is enabled and
> > callbacks are not registered which would result into loss of samples un=
til
> > callback registration completes, although no explicit failure. In teard=
own
> > path which can resulting in stale/no data.
> >=20
> > This was discussed in the v1 thread and v2 was posted based on discussi=
on and
> > agreement:
> >  https://lore.kernel.org/all/3FED088A-651B-4E8B-840B-1B92CB4DF6F4@gmail=
.com/
> >  =20
> > >> not fully initialized or is being torn down, potentially leading to
> > >> sample drop or stale/no data.
> > >>=20
> > >> To handle this, the series ensures that:
> > >>   - All required callbacks and resources are set up before the device
> > >>     is registered with the IIO core
> > >>   - Resource cleanup is performed explicitly where ordering matters
> > >>=20
> > >> PS: This is prepratory series to convert all HID IIO driver to devm.
> > >>=20
> > >> Testing:
> > >>   - Compiled with W=3D1 for each patch in series
> > >>=20
> > >> ---
> > >> Changes in v2:
> > >> - Drop fixes tag and rectify commit message with reference to that =
=20
> > >
> > >You also dropped my tag. Why?
> > > =20
> > Thank you for the review and tag on v1.
> >=20
> > While code changes are intact in v2, the rational and commit message we=
re
> > updated substantially. Since commit message is as important as change w=
hich
> > will be permanent in history for future reference, I chose to drop the =
tag to
> > request a fresh review. =20
>=20
> Now it's clear, thanks.
> This version with changed commit messages seems good to me.
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Applied. Thanks,

>=20
> > I shall highlight the same in change log. I'll make sure to note in fut=
ure revision. =20
>=20
> Yes, please.
>=20
> >  =20
> > >> - Link to v1: https://patch.msgid.link/20260606-5-june-hid-iio-race-=
fixes-v1-0-27a848c5758f@gmail.com =20
>=20

