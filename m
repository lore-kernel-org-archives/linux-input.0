Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889EC3FA5C4;
	Fri, 24 Apr 2026 19:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777057736; cv=none; b=hFVAALxI/C3786Ok4HWJclknxJpFWQiY8LHch7snGQcqCemxsQkQxwnkU28aS2/getfXHofTNxdX9SQQBunNbdvc1Yj3QP6SZXFAGKAGjQrbZoUf8ks+3uX6Kccl2daPWbYs64JNS7EW9/PNBPPCEeZBJUS9xoxdnoJYdOengug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777057736; c=relaxed/simple;
	bh=EPiWMrYmdqDCobNnm9lcEI6gknSkhvgKegXUnqchTm8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d2hzc56MLbfZ415EBzeXzjkc0EjqhYiuwkmiOOBCl5+m5cwxW4bPsh7bSXoGvHstxgkMVkIVzNANfuZuG1e6woz+YyV4uQ8FZZNancY6W+CHz66qe3cMYa/CSLjVRHG68ZVqNnk37CevXY3IOoYe0z29jI313FpLAUsmi3FiACs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F3zHYjhH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F3zHYjhH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0313AC2BCB0;
	Fri, 24 Apr 2026 19:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777057736;
	bh=EPiWMrYmdqDCobNnm9lcEI6gknSkhvgKegXUnqchTm8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=F3zHYjhHEjBfXGbnTuWb0GcRWjBch2F2s2CdtZwHd0d7qbSmz00eoPNLY2DExtHsE
	 Es7725/noKaBy5+nE3+iysVY92j8JBLUsWa0Kz8PESvJTjFGkNO4FxOY3oVppSjA3L
	 b+O3lJp3k9IgemRg5EliSTApqRDM27wvT2NnmQYmOwZaS/+4Mj4x66tSNkI+j3VzH8
	 b1l/VdRneriuts357GMtG8/GeCnMwYXDSIrfB7ebqJduonMCek9P0V0HeywnFfXCWO
	 hYu2Uq9GVy5hf1vkHbdBVmsv0oh8aDlZwMZY0dsubsuLRGG+hepZSrpeWuBe4dVsrs
	 Ism++ckq7JnKQ==
Date: Fri, 24 Apr 2026 20:08:47 +0100
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
Message-ID: <20260424200847.78494f27@jic23-huawei>
In-Reply-To: <aeiPuxj2TRLNRbv1@ashevche-desk.local>
References: <20260421222210.16016-1-natalia.andre@ime.usp.br>
	<20260421222210.16016-3-natalia.andre@ime.usp.br>
	<aeiPuxj2TRLNRbv1@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 22 Apr 2026 12:07:07 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Tue, Apr 21, 2026 at 07:20:34PM -0300, Nat=C3=A1lia Salvino Andr=C3=A9=
 wrote:
> > Replace method accel_3d_adjust_channel_bit_mask()
> > with helper method hid_sensor_adjust_channel_bit_mask(). =20
>=20
> ...
>=20
> > -		accel_3d_adjust_channel_bit_mask(channels,
> > -				CHANNEL_SCAN_INDEX_X + i,
> > -				st->accel[CHANNEL_SCAN_INDEX_X + i].size);
> > +		hid_sensor_adjust_channel_bit_mask(channels,
> > +			CHANNEL_SCAN_INDEX_X + i,
> > +			st->accel[CHANNEL_SCAN_INDEX_X + i].size); =20
>=20
> Indentation is broken. Taking into account that the last line is too long=
 when
> properly indented, perhaps
>=20
> 		hid_sensor_adjust_channel_bit_mask(channels,
> 				CHANNEL_SCAN_INDEX_X + i,
> 				st->accel[CHANNEL_SCAN_INDEX_X + i].size);
>=20
> Which makes it most right and under 80 limit.
Hi Andy,

Why the double tab? Maybe just go long on this one and align after the (

