Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289AF41CB56;
	Mon,  3 Aug 2026 17:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785779736; cv=none; b=fYjUu0CPcvMls0K1ODWGFdOkRJLgNS73glv6zdk03n8XZ3WIQDxhSCKt3KrH3ZjbsCceyUMMB0ABm2sYU+WYFrBXqzpqlQc9dxuDFtILb7oqnXj7A9+1SF3KbCUd/AxZsOrBAvR8q70LF0KggS8xGcimt5Y3qpNYFv91sYLYWHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785779736; c=relaxed/simple;
	bh=afJHgdHYfLQJLMIEEC0SwFXZPUaSRAe49A1z446s1kw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Yf0QY7idktnZPtRj7ID1zmmuObSXepkclplKe3Z67gpjL01uTPNpv5V4fgLwoqFbpFOsozmpAHeIlK8vA0b1zRgIs9LzaTYrTIwj3MlPZ01WIgpv7+BvTIJxkvbjVUgZ3M+Nkd/CWSxLZVOlP/vW2Oq0Rzs/BBossWmLSprxmyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QvqoTc3K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QvqoTc3K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48D971F00A3A;
	Mon,  3 Aug 2026 17:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785779734;
	bh=afJHgdHYfLQJLMIEEC0SwFXZPUaSRAe49A1z446s1kw=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=QvqoTc3KiyTfzFEB6HHsqFirsVlZyETY4HP+VbHiS4BoVlPrKrxSudidIeKOL7HDn
	 EoPuof7R2yPJUwSzV2pvJcTIy6JZQ6N05Q2ZPk3d9FOJUFKZd+qirbFdh1nuExH0Xo
	 vq39jUOwS7GrqT6VEEElKJVavzgPsA7+3I0ZyPCAia8UhsTFcCsZ0z4mxFbyQNbfPE
	 +076ABGHSuAPivPbuZA2AL6fK2RNnL+SVNL1X/67sAdFTrf4vK9utgcGwhTJmIbWkk
	 yjUsPMu+mKzNeWgdwvLwywmuTTqrVyCmyb6upzTLmSBW4KebhsAecbRdq2QoElKobv
	 ecZ+W/PMAM7tw==
Date: Mon, 3 Aug 2026 19:55:32 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: =?ISO-8859-15?Q?Jose_Villase=F1or_Montfort?= <pepemontfort@gmail.com>
cc: Benjamin Tissoires <bentiss@kernel.org>, 
    Alec Hall <signshop.alec@gmail.com>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: magicmouse: do not keep a stale msc->input if no
 input is claimed
In-Reply-To: <20260729041557.1185819-1-pepemontfort@gmail.com>
Message-ID: <9qs9p51p-17p1-5984-rr1o-9pqr9pn00067@xreary.bet>
References: <20260729041557.1185819-1-pepemontfort@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 28 Jul 2026, Jose Villase=F1or Montfort wrote:

> magicmouse_input_mapping() caches the first hid_input's input_dev in
> msc->input while the report descriptor is parsed, and the rest of the
> driver treats a non-NULL msc->input as proof that an input device was
> registered.
>=20
> That does not hold on the hid-input error path. If hidinput_connect()
> fails -- for instance because input_register_device() returns an error --
> it unwinds through hidinput_disconnect(), which frees every input_dev it
> created, including the one cached in msc->input.
>=20
> The failure does not abort the probe. hid_connect() only skips the claim:
>=20
> =09if ((connect_mask & HID_CONNECT_HIDINPUT) && !hidinput_connect(hdev,
> =09=09=09=09connect_mask & HID_CONNECT_HIDINPUT_FORCE))
> =09=09hdev->claimed |=3D HID_CLAIMED_INPUT;
>=20
> and the "device has no listeners" bailout below it does not fire for this
> driver, which sets ->raw_event; on the USB Magic Mouse 2 / Magic Trackpad
> 2 paths hidraw and hiddev are claimed as well. hid_hw_start() therefore
> returns 0 and magicmouse_probe() continues with msc->input pointing at
> freed memory. Being non-NULL, it passes the "input not registered" check
> in probe and the NULL checks in ->raw_event and ->event, so the next
> input report dereferences freed memory.
>=20
> Clear msc->input when the HID core did not claim an input device, so the
> existing NULL checks cover this case as well.
>=20
> Fixes: f1a9a149abc8 ("HID: magicmouse: fix race between input_register() =
and probe()")
> Link: https://lore.kernel.org/linux-input/20260728185542.65F091F000E9@smt=
p.kernel.org/
> Cc: stable@vger.kernel.org
> Signed-off-by: Jose Villase=F1or Montfort <pepemontfort@gmail.com>

Applied, thanks.

--=20
Jiri Kosina
SUSE Labs

