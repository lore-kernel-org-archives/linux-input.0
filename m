Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457E42ED860;
	Mon, 11 May 2026 16:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778517719; cv=none; b=oNhKt0Q3VdWFCQtkej+FZx+VMNDCg2U8b+NHB4gWxFRp/yMOifmoIl4BorSFy3hfPG4JBAOwBl202kOT4t4uIaTBTcXdBaQfoioas/I1FnfeuteX1mkepVBR2ChrFmh4b870KzuLj1TijB6gIq8LoF9Drg0z7hQCqD1cT7IyvO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778517719; c=relaxed/simple;
	bh=CxVp0plSHEIQhkQveZ6NYMKan6gU1ZXBE0U7Sguh0oQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tlCyqKm9HaGEAT80Phz+SPyL7IVtRvb/ciWHz8rdBU9gDKRdbpCLQQzi80UL+NKBVSt3OoRCMJhVOQ/skkcO8vyQUY72GxOJWjHA7cYny9VbtgaxM1I8Q5DTMcUDRQgTn864ogK0B51c8gcpJ5E0raEzPVVqYW4ys1X3TZSXSWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p4vkgSNp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p4vkgSNp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CF85C2BCB0;
	Mon, 11 May 2026 16:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778517718;
	bh=CxVp0plSHEIQhkQveZ6NYMKan6gU1ZXBE0U7Sguh0oQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=p4vkgSNp3q3SucHxljXAtT/daJvNrjkDyeTr2YbJ05CAxRN8ykRTqSxzaohl2GqJ+
	 ll3VCajnkgV+3/95oPLGfGXyaWlPgrTce3HbvqaOSNmNPu9MpiBidy4azk2LJAPP4/
	 YBLptyrMDT129XckVmyUIU2xPcW9GhpR5YDuTDhwwzgO6D3By3pCaM1n8pPyMdn5Ui
	 5tUw5tEZc84FI6CSdGV7j/eS/0d+pUhSO48PbT7a8RBJ8QG4k26EvRJG5Kx/TOeLu7
	 FIwcp5aHOK2HR+4IEaqwra2KsBQ7cgyWWpVzualvn4FHbPt0Ox5eKNhNIFT55PvrBR
	 3SeTateAZKUeg==
Date: Mon, 11 May 2026 17:41:49 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Sanjay Chitroda <sanjayembeddedse@gmail.com>, jikos@kernel.org,
 srinivas.pandruvada@linux.intel.com, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, sakari.ailus@linux.intel.com,
 linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 7/9] iio: humidity: hid-sensor-humidity: use common
 device for devres
Message-ID: <20260511174149.37f5eacb@jic23-huawei>
In-Reply-To: <agAo6fXUaoTwl326@ashevche-desk.local>
References: <20260509101040.791404-1-sanjayembedded@gmail.com>
	<20260509101040.791404-8-sanjayembedded@gmail.com>
	<agAo6fXUaoTwl326@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 10 May 2026 09:42:49 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Sat, May 09, 2026 at 03:40:38PM +0530, Sanjay Chitroda wrote:
>=20
> > kmemdup() is used for memory that is logically tied to the HID
> > platform device, even though the driver binds into the IIO framework.
> >=20
> > Using &indio_dev->dev for devres allocations works functionally, but it
> > results in two separate devres ownership trees=E2=80=94one for the HID
> > platform device (pdev) and another for the IIO device (indio_dev).
> >=20
> > The devres framework is intended to have a single, well-defined parent
> > device. Since the memory originates from HID sensor probing and is not
> > IIO-specific, &pdev->dev is the correct and logical owner.
> >=20
> > Switch to using the platform device for devm_kmemdup() so that all
> > resources are released deterministically and consistently. =20
>=20
> This patch sounds like a required fix and has to be placed in the beginni=
ng of
> the series along with the Fixes tag.

Hmm. I always find these hard to prove...=20
Ultimately for a device for which no driver is ever bound I believe
the call to devres_release_all() in device_release() catches these.

That should I think happen when the last reference to the iio_dev->dev
is dropped (for the device we care about in the 'buggy' code).
Now that may well be at a different time to when it would happen on
the underlying bus device unbind.  However here we are talking about
an allocation so as long as we release it at somepoint and that's late
enough (which it will be either way) then it's not a bug - it just makes
the code harder to reason about.

Jonathan

p.s. I remember testing the releases on some other drivers years ago
     to figure out if they had an actual bug based on the pattern we have
     here. It 'works' but yuk.



