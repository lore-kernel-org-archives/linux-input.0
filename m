Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7469154BE2;
	Thu, 26 Feb 2026 14:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772117200; cv=none; b=iJsVoMP7HvgFIUcfRCqj9bTfoHYGG5l9doQ2TmTabx53x0a7MT5udO3UZS7aVoZ/6xRpF9juWCIWIeP0sVhTiH9IGQa5lXV/Kbci2cL9NPDAJZrGQWgjuiMjGPaRU+C3OY9luL1EC9O5N4QOJm3rPq1X+UA22NlCTGD1YYx2gz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772117200; c=relaxed/simple;
	bh=Kc60CLFiOQpwTI/Ei6PnHAVN42V3YEzXfYti8k/3g5Q=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=gt6xasDSMQMJAyxntyfQMcAsuhM4itHeqzkmv6wOhwEe7NCUYjmhkRFO42nxSFdCmRCQKgtA/Ka2jzHtcPnmGyU3Fla9IyhurkzDGk/Ea9vBd03xMQA+AWRC03yPwdfyw+LuB9WtSLiCy+2Bx+BvdR9nergfbey1IAc6x2FOUIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tHzUWgIY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tHzUWgIY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 267A0C19422;
	Thu, 26 Feb 2026 14:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772117199;
	bh=Kc60CLFiOQpwTI/Ei6PnHAVN42V3YEzXfYti8k/3g5Q=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=tHzUWgIYKSY179VKlOADw+rmfZwHHNIPs0G2jRHAZ900zm77fV3zY6yfaDUUNdY/f
	 rkZMZTQ5/XhTugTPlvYf6UEA3kQR9cU4buFsnOoIXRBpd303Zu3hN4DrRsUgn0o942
	 aymjD3n21X8r4nfLXN8kQBtSpnlf9eKXojRDitKSh4g8I0RRrg/EqYsXNzXPW0xvQ1
	 71gxOYgs4N6tUvwAarIvdHTlwb1i6GB7jGiU7fFtZXvbF6j0JhrG8TcXbExFXfFGlR
	 buBwKSzmxM29FHhCJGecrTo5e6lTvR9aLGXTQE7LsqVNA9U67kRhYyUHUSXxBOR7as
	 zmz2BaTRVsPcA==
Date: Thu, 26 Feb 2026 15:46:36 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: =?ISO-8859-2?Q?Tomasz_Paku=B3a?= <tomasz.pakula.oficjalny@gmail.com>
cc: bentiss@kernel.org, oleg@makarenk.ooo, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] hid-pidff set_condition compatibility fixes
In-Reply-To: <20260203174531.2866644-1-tomasz.pakula.oficjalny@gmail.com>
Message-ID: <5ps9r442-5054-0034-6non-7o78n9nqsoqr@xreary.bet>
References: <20260203174531.2866644-1-tomasz.pakula.oficjalny@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 3 Feb 2026, Tomasz Paku=B3a wrote:

> This patch series adds a few more quirks to the hid-pidff driver to allow=
 for
> greater compatibility with HID PID devices in the wild. Some omit selecte=
d
> fields based on the permissiveness of the Windows driver/DirectInput.
>=20
> All the combined quirks allow for Conditional effects playback on affecte=
d
> devices simply by following DirectInput and skipping missing fields. This=
 brings
> force feedback feeling in line with other platforms for affected devices.
>=20
> Last patch updates MAINTAINERS to officially take ownership of hid-pidff =
driver.
>=20
> Tomasz Paku=B3a (5):
>   HID: pidff: Refactor field quirks detection
>   HID: pidff: Add MISSING_NEG_COEFFICIENT quirk
>   HID: pidff: Add MISSING_NEG_SATURATION quirk
>   HID: pidff: Add MISSING_DEADBAND quirk
>   HID: Update MAINTAINERS for USB HID PID
>=20
>  MAINTAINERS                    | 17 +++++-----
>  drivers/hid/usbhid/hid-pidff.c | 57 ++++++++++++++++++++++------------
>  drivers/hid/usbhid/hid-pidff.h |  9 ++++++
>  3 files changed, 56 insertions(+), 27 deletions(-)

Now in hid.git#for-7.1/pidff. Thanks,

--=20
Jiri Kosina
SUSE Labs

