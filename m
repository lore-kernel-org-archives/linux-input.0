Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5790F47279E;
	Tue, 28 Apr 2026 18:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777399978; cv=none; b=om/vzJOxxOtZqSAhDnWJv7iFJBeZeBqrlSNL11TzvJG0xVKx5Rg5oAcVjBEOxSzVW+Ea72c9/YR0ga9hvOdUSxls52qQtM+MePmD36SJV+v4QcFL/zEE5xmJeS2U5GduAy4sDGU1EOITRjEKqLb1lS/EvYhzPGSmzO1BvxgTd+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777399978; c=relaxed/simple;
	bh=z/B96qf1K/NvZuga2ktlNvxm+UAaKNFzwLpC03Lk3GA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KeJDyVDQ5ZZTFnl6+3KTZH3QUd6Z2cKEPT0BTTWtFsCRLZx73A3Zmq2VFX7O0cQJeuEMqiJXFmgpFgV7yB4sTw7mibQmJRb2iWU2i4/A7YbitVmKu2FlsLqeQT8rExrfje9Ibw29/4CRoStw4SykiymH9Es4RIymVOyk6ocKMlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b82WKQGn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b82WKQGn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47F39C2BCAF;
	Tue, 28 Apr 2026 18:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777399977;
	bh=z/B96qf1K/NvZuga2ktlNvxm+UAaKNFzwLpC03Lk3GA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=b82WKQGnuKCXEIxGEf/9Rxee78c5poBTMy1UAdfzMauUkQwsQDRf/gQ6dg9eZ8SxT
	 v3shUgMMj28ir9ROfaQkDQODSWxPGuamHGgHbUMWj0VkaVitcQrc1kdAZEZbHcb0Uh
	 0LZUbq7O9R3cNcUzPavIxoiKwwnVr7Xq+HwzZn0MygeBvFcowTOdoh2ECCtzl879KH
	 c5RS2+8a9b1+Miq/LPV4ZByilQapekRCfHjRUWHS1pemh5X/8ncIQYNRGQ3cZgLLHY
	 ABvTVoyhUf8pFPmE5epqAcAXTRBnq9JCMvJ6b/7AD442VDNMUisWbtXB7qvOgfCCXs
	 k51+VHhjfXRnQ==
Date: Tue, 28 Apr 2026 19:12:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: =?UTF-8?B?TmF0w6FsaWE=?= Salvino =?UTF-8?B?QW5kcsOp?=
 <natalia.andre@ime.usp.br>, andy@kernel.org, bentiss@kernel.org,
 dlechner@baylibre.com, jikos@kernel.org, nuno.sa@analog.com,
 srinivas.pandruvada@linux.intel.com, Pietro Di Consolo Gregorio
 <pietro.gregorio@usp.br>, linux-iio@vger.kernel.org,
 linux-input@vger.kernel.org
Subject: Re: [PATCH v2 2/7] iio: accel: HID: Replace method
 accel_3d_adjust_channel_bit_mask()
Message-ID: <20260428191246.152c2972@jic23-huawei>
In-Reply-To: <ae8upGN9ILmtCzeA@ashevche-desk.local>
References: <20260421222210.16016-1-natalia.andre@ime.usp.br>
	<20260421222210.16016-3-natalia.andre@ime.usp.br>
	<aeiPuxj2TRLNRbv1@ashevche-desk.local>
	<20260424200847.78494f27@jic23-huawei>
	<ae8upGN9ILmtCzeA@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 27 Apr 2026 12:38:44 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Fri, Apr 24, 2026 at 08:08:47PM +0100, Jonathan Cameron wrote:
> > On Wed, 22 Apr 2026 12:07:07 +0300
> > Andy Shevchenko <andriy.shevchenko@intel.com> wrote: =20
> > > On Tue, Apr 21, 2026 at 07:20:34PM -0300, Nat=C3=A1lia Salvino Andr=
=C3=A9 wrote: =20
>=20
> ...
>=20
> > > > -		accel_3d_adjust_channel_bit_mask(channels,
> > > > -				CHANNEL_SCAN_INDEX_X + i,
> > > > -				st->accel[CHANNEL_SCAN_INDEX_X + i].size);
> > > > +		hid_sensor_adjust_channel_bit_mask(channels,
> > > > +			CHANNEL_SCAN_INDEX_X + i,
> > > > +			st->accel[CHANNEL_SCAN_INDEX_X + i].size);   =20
> > >=20
> > > Indentation is broken. Taking into account that the last line is too =
long when
> > > properly indented, perhaps
> > >=20
> > > 		hid_sensor_adjust_channel_bit_mask(channels,
> > > 				CHANNEL_SCAN_INDEX_X + i,
> > > 				st->accel[CHANNEL_SCAN_INDEX_X + i].size);
> > >=20
> > > Which makes it most right and under 80 limit. =20
>=20
> > Why the double tab? Maybe just go long on this one and align after the =
( =20
>=20
> I never know when you are strict about 80 limit :-)
>=20
I was meaning vs single tab really.

You are slowly wearing me down on the 80 limit by pointing out lots of
cases where going beyond it really helps! ;)


