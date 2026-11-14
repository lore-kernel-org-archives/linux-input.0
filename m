Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794681311;
	b=O/ThwGflH6NhrVkPPRiagZEr06ZDDDEuHvrc14QQpsAKbOxFQs6PBCdX5nJWrZunDupT
	 R4TO4YCoig7kmm5moOTT+msVHVvtzP9LgCI1jjkkKYuyqnS+4+hBn2pRPzBwZjPWUi68I
	 /2KPf5tP5lU/BFB+r2kc3gzemKGr5eSgO/rfHpX+Vzl6CdJK9hwhrM2OrBkTVWqzrP7kM
	 3KJN6ayMz+4abs/AK3DopnrEzzh6l8MtlBA7MoaqF2HUpIUXubUiWNdUEzJnOjGKvn7Ki
	 rUvIargcHEwK+2sIupuVaaXxPm8CAylHuSYYDyxNstz44ah7dmLTicw8nCRBSGKmWgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794681311;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=TvSKSRkg9AFrTcntLh7QJ1VF0aRsTmwl0gLaj0FgbTg=;
	b=d8vzj9dSklRskP8qyfDn6zeE+bU5MDPIHGv1ZV4Q5bDZCVMcCNdMggFNtR2UXN/mfTaN
	 onhf4pmRnWsnl/a3uwGG+OUay7xcDrhkJ/pX+Ks4qQvpJFvY7oBv7dSgxb64mnQQo1HAC
	 GbjIuJo2gWQLT8wNDDPsj3RdUbFNod1fkjXqPvOr5ArgTmaSzLreGzsAYeoC0FacCJd2h
	 Eql1lNwdPgYEVQYOLNSuDS4xyeIEvq3u2cVn4sX4T9BLJTXZJlnNHqUJQ8rpCS9ZeQb7s
	 igMmnHndDw4raK7aixJuzXRheSgWLKOUYrOnTxw7YKJCUqpvDpyfAQsUcoFWFQ4lT8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WkrWyKA0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD9A606A323;
	Sat, 14 Nov 2026 18:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WkrWyKA0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AA741F000C4;
	Sat, 14 Nov 2026 18:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794681311;
	bh=TvSKSRkg9AFrTcntLh7QJ1VF0aRsTmwl0gLaj0FgbTg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=WkrWyKA0yhj2F7gLBdmu0ep02BeBs/qlh6XcoAvZc0PYKQLjrtJEm9Ie9H3qJGCXQ
	 bBdij8IjcqjGt8Z4S6ix+u5Za/iczJo8mvxr6c6gZhWNJZu8nnfYLIjLI8j3LuZFoy
	 MK/fMV/BcM4ZaMJGjThZ9wng4q/WDh2i/xaYMv6dx0r4ivkcjw8nzooPv2b/L4C1uK
	 rGR15aqmdWyHApyC2AiuQnn0fQRvoOopOe71APw7YU7k5E89U6/5fqYCj+8NuddsDq
	 BXOUtWhw1V6u0dqa4MkdfFN09km3ep7W73HmcsSuFLwUwNzT/4sQTKyezFz04JXBWv
	 nuzTVQNW3NbFA==
Date: Sat, 14 Nov 2026 18:34:59 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Christopher Hoover <ch@murgatroid.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Lixu Zhang
 <lixu.zhang@intel.com>, Joshua Crofts <joshua.crofts1@gmail.com>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] iio: hid-sensors: fix shared callbacks in
 temperature and humidity
Message-ID: <20261114183459.78fc3e31@jic23-hlaptop>
In-Reply-To: <CACw0PsZ43YAQUcPuP7ec6gjd03Srn5QYUWp74SMZ0gzPLUp71A@mail.gmail.com>
References: <20261019023420.83976-1-ch@murgatroid.com>
	<20261102215606.5e36a2a2@jic23-hlaptop>
	<20261111025336.051fbbcb@jic23-hlaptop>
	<CACw0PsZ43YAQUcPuP7ec6gjd03Srn5QYUWp74SMZ0gzPLUp71A@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 10 Nov 2026 19:11:31 -0800
Christopher Hoover <ch@murgatroid.com> wrote:

> >> Dropped patch 1, that should go via the hid tre =20
>=20
> Do i need to do that ?    Sorry for the possibly dumb question -- I'm
> well out of practice with the process.
Ideally Jiri will notice this thread and pick it up.

If that is looking unlikely by say rc5 then send a new version
with just that patch so that it stands out a little better

Thanks,

Jonathan

>=20
> -ch
>=20
> On Tue, Nov 10, 2026 at 6:53=E2=80=AFPM Jonathan Cameron <jic23@kernel.or=
g> wrote:
> >
> > On Mon, 2 Nov 2026 21:56:06 +0000
> > Jonathan Cameron <jic23@kernel.org> wrote:
> > =20
> > > On Sun, 18 Oct 2026 19:34:17 -0700
> > > Christopher Hoover <ch@murgatroid.com> wrote:
> > > =20
> > > > hid-sensor-temperature and hid-sensor-humidity share one static
> > > > struct hid_sensor_hub_callbacks across instances and overwrite its =
pdev
> > > > on every probe. With two temperature sensors, reports for one go to
> > > > the other's pdev; once that device is removed,
> > > > temperature_capture_sample() dereferences NULL. I hit this on 7.0
> > > > with two uhid-created sensors.
> > > >
> > > > Patches 2-3 make the callbacks per instance, as the other HID sensor
> > > > drivers do. Patch 1 makes sensor_hub_remove_callback() take
> > > > pdata->lock, as sensor_hub_raw_event() does, so a report racing an
> > > > unbind cannot call through the freed callbacks. =20
> > > Applied to the fixes-togreg branch of iio.git with the ordering tweak=
s Andy suggested. =20
> >
> > One day I'll remember some bits of this driver are in hid.
> >
> > Dropped patch 1, that should go via the hid tree.
> >
> > Sorry Jiri / Christopher.
> >
> > I only seem to notice I've done this whilst writing pull requests :(
> >
> > Jonathan
> >
> >
> > =20
> > >
> > > Thanks,
> > >
> > > Jonathan =20
> > > >
> > > > Changes in v3:
> > > > - Patches 2-3: set the callbacks with one compound literal (Jonatha=
n).
> > > > - Kept Joshua's Reviewed-by on all three; patches 2-3 changed only =
in
> > > >   style.
> > > > - Rebased onto v7.3.
> > > > - Sent as a new thread, not a reply to v2.
> > > >
> > > > Changes in v2:
> > > > - New patch 1, for the use-after-free on unbind found by the Sashiko
> > > >   review of v1.
> > > >
> > > > v2: https://lore.kernel.org/all/20261007184423.622445-1-ch@murgatro=
id.com/
> > > >
> > > > Christopher Hoover (3):
> > > >   HID: hid-sensor-hub: Synchronize callback removal with raw events
> > > >   iio: temperature: hid-sensor-temperature: Use per-instance callba=
cks
> > > >   iio: humidity: hid-sensor-humidity: Use per-instance callbacks
> > > >
> > > >  drivers/hid/hid-sensor-hub.c                     | 12 ++++++++++--
> > > >  drivers/iio/humidity/hid-sensor-humidity.c       | 14 +++++++-----=
--
> > > >  drivers/iio/temperature/hid-sensor-temperature.c | 14 +++++++-----=
--
> > > >  3 files changed, 24 insertions(+), 16 deletions(-)
> > > >
> > > >
> > > > base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222 =20
> > >
> > > =20
> > =20

