Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE11C41C31D;
	Tue, 28 Apr 2026 16:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777392743; cv=none; b=Ccx4Yl9nZJ7QT89ByNDj9dyLwjabYQ0V26aHR2uglFZ77kNXlzBALEq4u6+uZiRN+c3yuu3egVH3Bm+jk/pkFN0DPgRY9pxS0xJBSX4PXxlpwHpQFv4NaPKX3dAVWeJXKNP6UJzlC6WrBxrkQcE+lNsEuJDFDNlscbXAzBIkf5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777392743; c=relaxed/simple;
	bh=5FDfHX8S+VuJCzPsi3hrFwQ/0/Xp7to23L2CXesso8o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gbtj/jADSe5ADcc5u2+qFN5cr0a2tba4lL/q8aMxSUR8CYHMpFwRMwwE7h11cR4XFNfUJ4DEYPC7UZk6GLtq9GOxn7F59OyrhK3y6Q3eDiJ3q7HxwOBkOsvDGtwW/UIhOoQOP6bWZsgqtKhUuZETYHmdfN2sGwkj34UMOvn7KZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FnvEgczH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FnvEgczH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E1C4C2BCAF;
	Tue, 28 Apr 2026 16:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777392743;
	bh=5FDfHX8S+VuJCzPsi3hrFwQ/0/Xp7to23L2CXesso8o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FnvEgczH5SfsbCi44hgrg2LYMBxZTIrwUW23w+bFYEwWmL0JCBwDhl28kyTQ/TdNa
	 lLQKLfDOt7KuxDgygdOGtssc0qKq9BQLKxRrNdJtikDGihNPeYgVXwXCFy4xAdgYnB
	 +QHs33MImDpRXTQqi2oBchaO/xYVrm+9TB2Gsis3SkTCw0H528+XmTKK315FoshPeK
	 fvcIoXJQRV2ozSVbzuTLOstZEyr1/v4JDPfVo+8F6w8x5cCE5zKi1Qqb3PO04VLB1I
	 Cs/am+c5IrMbzObdrijVK9QKF/N9JyEh8gND0jsPACXEhRdBg5s+ufXWaJHRetx9cP
	 1OdXVwExSxu0Q==
Date: Tue, 28 Apr 2026 17:12:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, jikos@kernel.org,
 srinivas.pandruvada@linux.intel.com, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, sakari.ailus@linux.intel.com,
 linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/10] iio: orientation: adapt to
 hid_sensor_remove_trigger() API change
Message-ID: <20260428170121.7fc54ea1@jic23-huawei>
In-Reply-To: <39108D2A-3C3F-40B5-9A9B-5B3572A63922@gmail.com>
References: <20260428071613.1134053-1-sanjayembedded@gmail.com>
	<20260428071613.1134053-3-sanjayembedded@gmail.com>
	<afBuWAElmx7t7FcB@ashevche-desk.local>
	<39108D2A-3C3F-40B5-9A9B-5B3572A63922@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 28 Apr 2026 16:32:02 +0530
Sanjay Chitroda <sanjayembeddedse@gmail.com> wrote:

> On 28 April 2026 1:52:48=E2=80=AFpm IST, Andy Shevchenko <andriy.shevchen=
ko@intel.com> wrote:
> >On Tue, Apr 28, 2026 at 12:46:05PM +0530, Sanjay Chitroda wrote:
> > =20
> >> Update the driver to match the updated hid_sensor_remove_trigger()
> >> prototype, which no longer requires struct iio_dev. =20
> >
> >You haven't compiled the previous patch, right?
> >This is not the way how all this should be done.
> >
> >Also NAK to the patch 1 as even unused parameter is there for the sake of
> >consistency. The prototype to allocate and other in the similar group all
> >have it.
> > =20
> Hi Andy,
>=20
> Thank for the review comment.
> I agree your point for consistency.
>=20
> However primary object of this pre-series is to prepare the drivers for d=
evm_ conversation.
>=20
> I would prepare devm_ wrapper for the hid_sensor_setup_trigger() and resp=
ective resource release hid_sensor_remove_trigger().
>=20
> ...  devm_hid_sensor_setup_trigger( ... )=20
> {
>        ...
>        .. hid_sensor_setup_trigger();
>        ....
>        devm_add_action_or_release(dev, hid_sensor_remove_trigger, attrb)
>        ......
> }
>=20
> I observed that many HID IIO drivers are not covered fully with managed A=
PI.
>=20
> This devm_* sensor setup trigger would use across multiple HID IIO sensor=
s and will go step forward for managed API support.
>=20


Show us what that looks like with this series squashed into a single patch
as a percursor. It might be worth doing as part of that larger work - on its
own it's not justified.

A series must be applicable 1 patch at a time without breaking anything.

Jonathan

