Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F244C2BEC34;
	Sat,  4 Jul 2026 23:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783206472; cv=none; b=mpIaqAJJHaDOe4x2oj7/iP8jDc7hX1pkeKQlsP7jACO3PAs7gYJcj36pUH69fi582UXaJnhFR/ALQD/5o60fTHvyD0DmEaJxUJ7AydLv28Nn+i9GM/gwZaPDNcqmeGNNZ2SbkKGQtKgRlsGSI3nfyvSPdOdrQqI9Y7533EoLa8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783206472; c=relaxed/simple;
	bh=DvXJKBzHODGPnWHEtQ0x5r6ve1soOra32aFooAwCLaE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GkBQIth1eAyiev6rK8XdfsWXRZJ2EiTl90NPcw1JnJf13o4lyN6nwcAq17OhyRYlwBdzg2zTCgmRmIvLbFEn55hP2Ixd5UWWGfqaqY3XAow5/JrZrJem1Ueuksz8rulvXpEWtx2RnyoGLaGPjdo/xPoqmSCA4IxubdZF9hMTj18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C3Oq8FuX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C3Oq8FuX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB0761F000E9;
	Sat,  4 Jul 2026 23:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783206470;
	bh=HTT2Y3MljZdT4Ufh4UEqdp3nbr2eg+mR0+KOuiwJ8XQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=C3Oq8FuXpJdEWowFw+9FD0LFfDyZ7GDgpNwR0WrS6gycqDEnMuPsWn2TvsyknNEHQ
	 JL7KuI8AS1kFIyRGPN9nK72hRPs7mEHGof863U2Vn8p8oCTa4xbsBLXWw4eLmF7GOu
	 doRQKSWjis6mBN9lSLVbKU8aFL3qsXev23fCKR6c6hntJoP0ZTSlDrWKHacDHAqLRZ
	 5k16y+zfyRXlbMF+mSI8GX/5ZDqlEoBI+jR4L++aHclXOLqV1gyP/qunvGL6mRMtpF
	 bVLy6kGBIbkOCGuV9/V2lDO4FGSJnjU0bqIqv3AGFVCTQ0JkKFe+FnmO3kdH2AasU2
	 7Q9/0uJMcwS0w==
Date: Sun, 5 Jul 2026 00:07:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Sanjay Chitroda via B4
 Relay	 <devnull+sanjayembeddedse.gmail.com@kernel.org>,
 sanjayembeddedse@gmail.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko	 <andy@kernel.org>,
 Jiri Kosina <jikos@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH v2 2/6] iio: hid-sensors: align function parenthesis for
 readability
Message-ID: <20260705000743.62be6397@jic23-huawei>
In-Reply-To: <e753606a89dbed26389d8c5ee8b2e4f0dafcd2f3.camel@linux.intel.com>
References: <20260702-15-jun-hid-iio-alignment-v2-0-b87f01f5efbc@gmail.com>
	<20260702-15-jun-hid-iio-alignment-v2-2-b87f01f5efbc@gmail.com>
	<20260702182015.303db93c@jic23-huawei>
	<akewhE9wEpU6UW0u@ashevche-desk.local>
	<e753606a89dbed26389d8c5ee8b2e4f0dafcd2f3.camel@linux.intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 03 Jul 2026 18:09:39 -0700
srinivas pandruvada <srinivas.pandruvada@linux.intel.com> wrote:

> On Fri, 2026-07-03 at 15:52 +0300, Andy Shevchenko wrote:
> > On Thu, Jul 02, 2026 at 06:20:15PM +0100, Jonathan Cameron wrote: =20
> > > On Thu, 02 Jul 2026 21:47:59 +0530
> > > Sanjay Chitroda via B4 Relay
> > > <devnull+sanjayembeddedse.gmail.com@kernel.org> wrote:
> > >  =20
> > > > Adjust alignment of parentheses across HID sensor IIO drivers to
> > > > improve readability and maintain consistency with kernel coding
> > > > style.
> > > >=20
> > > > While updating the formatting, group related arguments
> > > > consistently in
> > > > multi-line function signatures where appropriate.
> > > >=20
> > > > No functional change intended. =20
> > >=20
> > > Whilst I appreciate this code isn't quite in line with standards
> > > and usually like that stuff to be fixed up, in this particular case
> > > this is a massive amount of churn.=C2=A0 That churn will make
> > > backporting
> > > fixes etc messier, so I'd like input on whether others consider
> > > this
> > > one worthwhile.=C2=A0 Jiri, Srinivas, Andy etc. What do you think? =20
> >=20
> > I am fine as long as Srinivas is. I understand pros and cons of this,
> > but from
> > time to time we have patches =C3=A0 la this one that messes up with
> > backporting but
> > were accepted as a good part of some bigger series. =20
>=20
> I am fine. I guess we will deal with backporting issues as they appear.

We'll go ahead.  So Sanjay, please send a new version rebased on
what I picked up already and with those inconsistencies tidied up.

Thanks,

Jonathan

>=20
> Thanks,
> Srinivas=20
>=20

