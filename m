Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948413DE43A
	for <linux-input@vger.kernel.org>; Thu,  9 Apr 2026 15:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775749425; cv=none; b=h2Qa4ns5V4nX5BqUH4a62RvqzK95DyKoUrjIAMjnljoAgxw73fRpoz3Z/lmiU26kbX0q+vx6qQ9St6rPqRBAUG8SA986f1ekMMobdTiIWGbnOEoliMVmVA20/t7eSRBeDBbnnf8fwBMpZ1ajDDCmT0YeqTg9vebjz/sPjnOQUfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775749425; c=relaxed/simple;
	bh=UaN1gyj75H5bk/unBTKoBzbFX8FR16et5rK8j+ala0E=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=dY05MxsMOIoL8ajuSaM07o+tHbrPNe3rAlTvOZ5J2+2caXL1NnFpMmZQUsk79rqgzexOgqqqnQiICrMxbFTU9YGbwYOFgxSAA6HHtbMJjQUq7AV6kJmFJKL3Ff6CYD1yLwilKig6zXHSkZ1Rb+0ru/FH80ZpF6UCzwMfUHUofW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XE4D5+io; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XE4D5+io"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 990F3C4CEF7;
	Thu,  9 Apr 2026 15:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775749425;
	bh=UaN1gyj75H5bk/unBTKoBzbFX8FR16et5rK8j+ala0E=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=XE4D5+ioJ8myi3XQlz6HuHth4qxD+olTvTQyP7TY41YRHLlnsYSLQr98qjs69bIWA
	 O/jEYAql/D19x6Z5d4wvIbVoEz2WU1pxDxQN61nymM4di5pV+tNnyjUIlJ1jrh6JqG
	 6U1aVb5K2gCAth46Y5N2mJPlnT2xSkt9qCoW5bEZMJiH6U6a3+d/Dn67TmnIwiCTqG
	 paAJdc8LNPYvrHUWdj9pB3HWhM1M7767FFXkMLsPN5t1E4yxXGlYA+SXfL4ODPdXd6
	 Mb4geRn2XFW5VwDb0lQ12b3molRIlqqn6+4ueF2avmDHT5+CFDGW12Xkm/Guxy+dUJ
	 AvEARsU+zJNcw==
Date: Thu, 9 Apr 2026 17:43:42 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: =?ISO-8859-15?Q?Ren=E9_Onier?= <rene.onier@gmail.com>
cc: linux-input@vger.kernel.org, bentiss@kernel.org, ivan.gorinov@gmail.com
Subject: Re: [PATCH] HID: winwing: add support for URSA MINOR combat
 joysticks
In-Reply-To: <20260404172641.195619-1-rene.onier@gmail.com>
Message-ID: <29p33srq-315n-npps-2588-o2298nrp5pnp@xreary.bet>
References: <20260404172641.195619-1-rene.onier@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sat, 4 Apr 2026, Ren=E9 Onier wrote:

> Add device IDs for the Winwing URSA MINOR Combat Joystick L (0xbc29)
> and R (0xbc2a). These joysticks declare 128 buttons in their HID
> report descriptor, causing the generic HID driver to reject buttons
> above KEY_MAX (767) with "Invalid code" errors.
>=20
> The URSA MINOR joysticks use buttons in the 33-64 range for grip
> controls including the index trigger, so map_more_buttons is set
> to 1 to enable the extended KEY_MACRO mapping.
>=20
> Tested with both left and right URSA MINOR joysticks on kernel 6.19.
>=20
> Signed-off-by: Ren=E9 Onier <rene.onier@gmail.com>
> ---
>  hid-winwing.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/hid-winwing.c b/hid-winwing.c
> index ab65dc1..f3e6ea0 100644
> --- a/hid-winwing.c
> +++ b/hid-winwing.c

Thanks for the patch!

You seem to have generated it however without a full path, so it can't be=
=20
applied using standard patch -p1 way ... could you please fix that up and=
=20
resend?

Thanks,

--=20
Jiri Kosina
SUSE Labs

