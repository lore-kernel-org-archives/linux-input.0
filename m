Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12A22FE56E;
	Sun,  5 Jul 2026 22:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783290549; cv=none; b=NGwFGOIoYsKKoINq9lvP3JklvTBCMnxicNgiBqOdmKurW+UPe5LbIcPIK6Fte6waD+5TJfqWiA2ISVbAONSM9EqueS6+NIS11KNl+8XdK5c9qygz/+FHk4QeteI7Do802rLn78/RXCpXW1wa6CqL/H/1LJY1YRIE7e19QLA4Cjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783290549; c=relaxed/simple;
	bh=U2Hfekb+ngeDaQUJfKLTRPD0kcg4vXWlqriKGPgNSao=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hRIes3i9vtXOXNBxouVyRCCdWrjJNUjUeRVWtBEODHNH4cR6BJO0UYvUILatUUciUeXhSahFr6zktBoktc8cRDGQo6QsK5CcJ08PEZuISuoEeJfp8ZpI2LN5AyoHjCq/Tj5RI3pfOW7Rfcn7LvGq7MEhm/IYT0IuH3dKHXJNRNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jzHyKyK3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jzHyKyK3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D68D1F00A3D;
	Sun,  5 Jul 2026 22:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783290548;
	bh=yeuuQ8mwZSCiOWAF1ymmW5s+cTqVzArX8rtQrSh+V0M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jzHyKyK3ITV+GNi7CUqTuvt5w2Y3XBurpKzjKN/mRHqkaY48ZvWVj+67bajf9HxO4
	 9uIf/1b+1U9VToBp4w8xFwm0R2b7b0vJvHIPDx8V9dSsGv6AXk48N2TYarCtGUEqjI
	 IbKePx8H0FJIvaBd5Pc3Nahu6CyjVaZN66H+R7y+oUFK8i96aJOaMy+n06/ePlMH/I
	 2QyLQUvKo7VemwIDpq0SHYR9V9MWsmQmEDQjxJqoyMj8PoB+NTmz2c3475SYmTyPWO
	 UK+iVoYXtCsYkHV8PSOtUGMw0E4CazAOJ50Vd2Tqj7TvAatn4eIncO0PNXI/yTDmrx
	 BBX+62da2aoxw==
Date: Sun, 5 Jul 2026 23:29:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Sanjay Chitroda <sanjayembeddedse@gmail.com>, Sanjay Chitroda via B4
 Relay <devnull+sanjayembeddedse.gmail.com@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Jiri Kosina <jikos@kernel.org>, Srinivas
 Pandruvada <srinivas.pandruvada@linux.intel.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-input@vger.kernel.org, Maxwell Doose <m32285159@gmail.com>
Subject: Re: [PATCH v2 3/6] iio: hid-sensors: Use implicit NULL pointer
 checks
Message-ID: <20260705232903.4a58c82b@jic23-huawei>
In-Reply-To: <CALoEA-wkbbvPA02JFCTuCEQrpGKZfu3NeBScTErTT07U7zJZ_g@mail.gmail.com>
References: <20260702-15-jun-hid-iio-alignment-v2-0-b87f01f5efbc@gmail.com>
	<20260702-15-jun-hid-iio-alignment-v2-3-b87f01f5efbc@gmail.com>
	<20260702182205.388efe24@jic23-huawei>
	<BF19024B-D73A-4185-A963-516D0574E416@gmail.com>
	<CALoEA-wkbbvPA02JFCTuCEQrpGKZfu3NeBScTErTT07U7zJZ_g@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 5 Jul 2026 21:31:54 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> On Sun, 5 Jul 2026 at 20:17, Sanjay Chitroda <sanjayembeddedse@gmail.com>=
 wrote:
> >
> >
> >
> > On 2 July 2026 10:52:05=E2=80=AFpm IST, Jonathan Cameron <jic23@kernel.=
org> wrote: =20
> > >On Thu, 02 Jul 2026 21:48:00 +0530
> > >Sanjay Chitroda via B4 Relay <devnull+sanjayembeddedse.gmail.com@kerne=
l.org> wrote:
> > > =20
> > >> From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> > >>
> > >> Replace explicit NULL pointer comparisons with implicit checks across
> > >> HID sensor IIO drivers to follow the preferred kernel coding style. =
=20
> > >Is there anything in the kernel wide style guides about this?
> > >
> > >I do prefer this style in IIO but perhaps we should document it
> > >as local IIO style rather than implying general guidance (unless
> > >there is some!)
> > > =20
> > Hi Jonathan,
> >
> > I took reference of existing IIO commit message and followed the same.
> >
> > There is no kernel coding guideline for NULL pointer. If you think it w=
ould be useful, I would be happy to work on documenting the preferred conve=
ntions under "Documentation/driver-api/iio/", for example as a new "coding-=
style.rst" or similar document. =20
>=20

Probably would go in a subsystem maintainer profile.
https://docs.kernel.org/maintainer/maintainer-entry-profile.html

If you want to take a stab at just a bit on local style preferences
that would be great.  I can probably find time to throw something
together for other standard sections like timelines.


> Not sure whether any coding style kerneldoc mentions this style,
> nevertheless checkpatch prefers (!foo) over (foo =3D=3D NULL),  see the
> COMPARISON_TO_NULL section in the checkpatch kerneldoc.
>=20
Thanks for digging into this.  If it got into checkpatch it was
reviewed and is generally accepted, whether or not anyone updated
the descriptive stuff on kernel style.  Perhaps just refer to that
in the commit message to avoid confusion.

Thanks,

Jonathan


