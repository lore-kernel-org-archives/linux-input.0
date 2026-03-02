Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3E039150F;
	Mon,  2 Mar 2026 20:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772484858; cv=none; b=LsPFqa/8Ul229L0NU1nyN+wFDk2lcUsw7Br7ciCdMylrKLIjbJkNDzNvn1ySFMnznDFmRntWCS1xRUWpB+94e7dEMfM53mhm4w5kUxgyaUhcuiT/A3rJoaifEQe8H7zSp74bX+VbDiE555XwtivGdBXbpewvmdW0GBPHrFoc2Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772484858; c=relaxed/simple;
	bh=7UW8X1Q0pg599+j7FABIUxaXRxY9SuGHQOy5y2QW8z0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=atFy84s18zMKSFawqIShxEHjGCSFNoc2aQdKexQKyj5D+QCRTl13opbr90+YydLul+4yNvHoKDbs6EK0Ntj1x8XbfbRPDcTqL7FKy4B5drVxwb/z2azbAbdfcIVlCNHfYaaDz6dnocSegd+DJDvS6BBV4U9wDf3kWQ08/ud3ccA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YNU7FyAJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YNU7FyAJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C50E4C19423;
	Mon,  2 Mar 2026 20:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772484858;
	bh=7UW8X1Q0pg599+j7FABIUxaXRxY9SuGHQOy5y2QW8z0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YNU7FyAJDMxqULhnnonk/9wQUijTxtVh2dRGOQXeNbSuJExURmhIPQLZgIqvLPDsi
	 4F+CoSlnNlWUAQ4xW1PxY+1art+wSRnfwJwAKUR7FLryrRDbB5I4uDYQtv+6yfibWM
	 J1ve3oHiSxZ3CmzjFOPrBPSZUW7kOJBu9AYZF633sJ3dxi5Ab1nkfhWenTgwiHpcyb
	 j4PfrtMRaQmO7M5V70cwmAUll1y+g/b6idYXz8aDFZkHlf7zwmEHAV+qITrqZs8cQE
	 AYYsP3KTWRzpDqzmr4NgCGhfg5QBsFnbMnMzqjnek3bbcJAZQ8+K8WuJJgqcAAkbwq
	 fkVchkvIGQHVg==
Date: Mon, 2 Mar 2026 20:54:08 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>, Andy Shevchenko
 <andriy.shevchenko@intel.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Jiri Kosina <jikos@kernel.org>, Srinivas
 Pandruvada <srinivas.pandruvada@linux.intel.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, linux-input@vger.kernel.org, Lixu Zhang
 <lixu.zhang@intel.com>
Subject: Re: [PATCH v2 0/2] iio: orientation: hid-sensor-rotation: fix
 quaternion alignment
Message-ID: <20260302205408.5159efa4@jic23-huawei>
In-Reply-To: <d22e03b2-2093-4d33-8ec5-484f64f2e8cd@baylibre.com>
References: <20260228-iio-fix-repeat-alignment-v2-0-d58bfaa2920d@baylibre.com>
	<aaVRIOejIgnOdAfY@ashevche-desk.local>
	<6158f495b13f2a8cdc09f37e296166ccf0393c78.camel@gmail.com>
	<d22e03b2-2093-4d33-8ec5-484f64f2e8cd@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 2 Mar 2026 09:52:58 -0600
David Lechner <dlechner@baylibre.com> wrote:

> On 3/2/26 6:32 AM, Nuno S=C3=A1 wrote:
> > On Mon, 2026-03-02 at 10:58 +0200, Andy Shevchenko wrote: =20
> >> On Sat, Feb 28, 2026 at 02:02:21PM -0600, David Lechner wrote: =20
> >>> The main point of this series is to fix a regression reported in
> >>> hid-sensor-rotation where the alignment of the quaternion field in the
> >>> data was inadvertently changed from 16 bytes to 8 bytes. This is an
> >>> unusually case (one of only 2 in the kernel) where the .repeat field =
of
> >>> struct iio_scan_type is used and we have such a requirement. (The oth=
er
> >>> case uses u16 instead of u32, so it wasn't affected.)
> >>>
> >>> To make the reason for the alignment more explicit to future readers,
> >>> we introduce a new macro, IIO_DECLARE_QUATERNION(), to declare the
> >>> array with proper alignment. This is meant to follow the pattern of
> >>> the similar IIO_DECLARE_BUFFER_WITH_TS() macro. =20
> >>
> >> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> >>
> >> But this is in conflict with the other hack-patch in another series.
> >> I'm a bit lost what patch 2 fixes here and that hack-patch fixes
> >> in the same driver. Shouldn't survive only one? =20
> >=20
> > +1.
> >=20
> > I see this is older so should we only look at the other series?
> >=20
> > - Nuno S=C3=A1 =20
>=20
> They are fixing two separate bugs.
>=20
> This bug (which is a recent regression) is that the size of the struct is
> wrong. It is supposed to be 32 bytes, but a recent change make it only 24.
> This causes iio_push_to_buffers_with_ts() to write over data past the end
> of the struct.
>=20
> The other bug (which has been a bug for 6 years) is that the the timestamp
> is in the wrong place. That patch also has an effect of making the struct
> the right size, but that is only a side-effect.
>=20
> So yes, I should have mentioned that in the cover letter that this series
> should probably be applied first since it is the worse bug. And it looks
> like I'll be doing a v2 of the other series anyway, so I can properly reb=
ase
> it and declare the dependency.
>=20
>=20
I've applied these two to the fixes-togreg branch with them marked for stab=
le
inclusion.  For the first one I added a comment to the tags block to say
it's stable as a precusor for the second.

Thanks,

Jonathan
