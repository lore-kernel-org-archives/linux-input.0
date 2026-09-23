Received: from prime.voidband.net (prime.voidband.net [199.247.17.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72CA34D389;
	Wed, 23 Sep 2026 06:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.247.17.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790145603; cv=none; b=dCWC4kTMB/DLEYxZ9RRl6KjIptcJ28N7NlFKpi90ikb3JfOaF+CynWlGhjjrsQhmdxREoTdB++Zy7Mqmj5MlhCISDNr/WO61frfQLqxNELXdSZm8RQ+DhqKm1kKNNedTUuM7DUT4DAeTEbR459a1xh/KjKf7wVT6jOHIlBYp6uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790145603; c=relaxed/simple;
	bh=qKIkfmIuXmZhqqu/Z2cOnid7Kzh8rFq2IcqkKdAj8Oc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PotEEbEuYX4FYrTU+XRXNVZ7QZjLwVgJpvKgz5WfI2CrDjv1JTd2QyJWzYSYOYTh6Vbjhv1KonAM24mZnotlHbgnhiMWA9yqBBaIY7LlU9eaqN/+wA2Y6RKzbqDb2y2SX3Dmb6GM2M4QqYRCCVytftyyZ1EiSGVimF6bLruCS+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name; spf=pass smtp.mailfrom=natalenko.name; dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b=O/BIf1bi; arc=none smtp.client-ip=199.247.17.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=natalenko.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="O/BIf1bi"
Received: from spock.localnet (unknown [212.20.115.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by prime.voidband.net (Postfix) with ESMTPSA id 25CCA635B041;
	Wed, 23 Sep 2026 08:39:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
	s=dkim-20170712; t=1790145593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N5ZmYRTlIZUnoxxjz35J0K7JGq7bxA5iiBrSpQc2pUM=;
	b=O/BIf1bikHroLyp9x/5BQrD8EFERN470pqnn8hXbH7PKuE09qro3LXsfIZZbFJxCvylc5D
	p94XhbSRahpt4Oxu70caOgKhcl2XECFnpSnKF7OK55PXtJkGNDGwF3o536JR2dZfkwtCeS
	3ewNkZgx2BtpG7MxdQ+BeIhWDOpyJvM=
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: Erik =?UTF-8?B?SMOla2Fuc3Nvbg==?= <erikhakan@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 Filipe =?UTF-8?B?TGHDrW5z?= <lains@riseup.net>,
 Bastien Nocera <hadess@hadess.net>, Rafael Passos <rafael@rcpassos.me>,
 =?UTF-8?B?R3LDqWdvaXJl?= Stein <greyxor@protonmail.com>,
 Alexey Zagorodnikov <xglooom@gmail.com>,
 Roman Stingler <roman.stingler@gmail.com>,
 Lovekesh Solanki <lovekeshsolanki00@gmail.com>,
 =?UTF-8?B?S2F0ZcWZaW5hIE1lZHbEm2RvdsOh?= <k8ie@mcld.eu>,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] HID: logitech-hidpp: fix Bolt hi-res wheel handling
Date: Wed, 23 Sep 2026 08:39:34 +0200
Message-ID: <8P3_vvAUQ0qq3g6Cks8PBg@natalenko.name>
In-Reply-To: <20260922-feature-bolt-fix-v1-0-63b0fa8da0d3@gmail.com>
References: <20260922-feature-bolt-fix-v1-0-63b0fa8da0d3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPartd2wzYXrITaCXMDi0MefA1w";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
x-ms-reactions: disallow

--nextPartd2wzYXrITaCXMDi0MefA1w
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: Erik =?UTF-8?B?SMOla2Fuc3Nvbg==?= <erikhakan@gmail.com>
Subject: Re: [PATCH 0/2] HID: logitech-hidpp: fix Bolt hi-res wheel handling
Date: Wed, 23 Sep 2026 08:39:34 +0200
Message-ID: <8P3_vvAUQ0qq3g6Cks8PBg@natalenko.name>
In-Reply-To: <20260922-feature-bolt-fix-v1-0-63b0fa8da0d3@gmail.com>
References: <20260922-feature-bolt-fix-v1-0-63b0fa8da0d3@gmail.com>
MIME-Version: 1.0

Hello.

On =C3=BAter=C3=BD 22. z=C3=A1=C5=99=C3=AD 2026 19:40:26, st=C5=99edoevrops=
k=C3=BD letn=C3=AD =C4=8Das Erik H=C3=A5kansson wrote:
> This series aims to fix high-resolution wheel handling for Logitech devic=
es
> connected through Bolt receivers as well as respect user settings for
> scroll behaviour.
>=20
> Patch 1 is Rafael Passos=E2=80=99s original implementation:
>=20
> https://lore.kernel.org/linux-input/20260904034843.1340846-1-rafael@rcpas=
sos.me/
>=20
> His patch routes Bolt wheel movement through the HID++ child, where the
> device=E2=80=99s HiRes Wheel multiplier can be applied. Patch 2 builds on
> Rafael=E2=80=99s work by 1. supporting both high-resolution and low-resol=
ution
> scroll events, and 2. preserving user-selected high-resolution and
> inversion settings.
>=20
> The follow-up patch was developed with reference to the patches and
> reported behavior in Magnetar-OS=E2=80=99s `logitech-bolt-hidpp-dkms` rep=
ository:
>=20
> https://github.com/Magnetar-OS/logitech-bolt-hidpp-dkms/tree/main/patches
>=20
> So my assumption right now is that the reason for the divergent results
> people have had with the two different fix approaches (i.e. either passing
> interface 0 and 1 as DJ interfaces, or Rafael's approach), where it works
> for some, and only sometimes, etc. is that with user settings coming from
> Solaar, we may end up in weird states.
> For example, in the original patch, high-resolution events would go throu=
gh
> the generic HID which would treat each tick as a full wheel event, thus=20
> scaling the scroll way too far. That was solved with Rafael's patch but
> that would instead fail to handle low-resolution events if high resolution
> was turned off in Solaar while use_hidpp remained enabled, so a low-resol=
ution
> delta would be treated as high-resolution, which would result instead in =
a=20
> too slow scroll. Possibly, when Oleksandr switched devices, Solaar reappl=
ied
> some saved user settings, which conflicted with the driver logic.
>=20
> With this patch, user settings from Solaar (or elsewhere) for high-resolu=
tion
> mode and scroll inversion will be respected,=20
> and scrolling should work both in high-resolution and low-resolution mode.
> However, if user-space turns off the use_hidpp setting while high_resolut=
ion
> remains on, this will route high-resolution scroll events to generic HID.
> Thus, when high_resolution is on for a Bolt device, the driver will
> force use_hidpp to be on during initialisation or reinitialisation, becau=
se
> otherwise the scaling issue will return.
> Solaar may still, after driver initialisation, reapply a saved use_hidpp
> setting of off while high_resolution remains on, or the user may change it
> to off, which will cause the issue even with this patch.
>=20
> In theory, it should be possible to look at incoming setWheelMode respons=
es
> or notifications and, just like on initialisation, enforce use_hidpp as l=
ong
> as high_resolution is set on a Bolt device. However, I don't know how Sol=
aar
> will behave then. There's a risk it will trigger a back-and-forth if Sola=
ar
> reapplies its saved setting after the kernel corrects it. Also, even if t=
hat
> doesn't happen, we should respect user choice even for use_hidpp. Perhaps
> the Solaar team can be informed about the problem so they can add a warni=
ng
> text.
>=20
> Note that I don't have a Bolt mouse to test this with, and my theory is=20
> mostly inferred, so I would appreciate very much if people with various
> Bolt mice could test it out. Also great if you try different settings in=
=20
> Solaar, but note that use_hidpp must be on if high_resolution is on, so=20
> either set it to on in Solaar, or to ignore.
>=20
> Link: https://lore.kernel.org/linux-input/20260712003051.338194-2-erikhak=
an@gmail.com/
> Link: https://lore.kernel.org/linux-input/20260901-bolt-scroll-fix-v1-1-5=
8bca7ae487f@protonmail.com/
> Link: https://lore.kernel.org/linux-input/LYMlyJcyQt29e1KlLnEoLw@natalenk=
o.name/
> Link: https://lore.kernel.org/linux-input/20260920094508.39682-1-roman.st=
ingler@gmail.com/
> Signed-off-by: Erik H=C3=A5kansson <erikhakan@gmail.com>
> ---
> Erik H=C3=A5kansson (1):
>       HID: logitech-hidpp: fix Bolt wheel mode handling
>=20
> Rafael Passos (1):
>       HID: logitech-hidpp: fix hi-res scroll for Bolt-connected MX Master
>=20
>  drivers/hid/hid-logitech-hidpp.c | 147 ++++++++++++++++++++++++++++++++-=
=2D-----
>  1 file changed, 123 insertions(+), 24 deletions(-)
> ---
> base-commit: 022eb347ff3a48281e7e69c3addcb11bf24afa53
> change-id: 20260921-feature-bolt-fix-5f1f642496df
>=20
> Best regards,

Not sure if I'm testing this right, but with v7.3-rc4 and these two patches=
 scrolling works OK as long as I keep "Scroll Wheel Resolution" in Solaar o=
ff. Unlike with unpatched kernel, scrolling doesn't go crazy if I switch be=
tween devices. But if I switch "Scroll Wheel Resolution" on, scrolling jump=
s crazy again.

=2D-=20
Oleksandr Natalenko, MSE
--nextPartd2wzYXrITaCXMDi0MefA1w
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEZUOOw5ESFLHZZtOKil/iNcg8M0sFAmqzdCYACgkQil/iNcg8
M0uL+A//ey9/hy/W/hFv0kpfgXD1EgYi4hVzX/HfjXSIrMcYYocm7YP0CFdQkSwJ
vUbe1HFOkVfnhkMRfz2S4PWjQ1tCscEJWTmZryz7TrQAsoOQKfOA8KLUP1uGmADQ
YhHrd3souEzBXGCScAec3FS4ePPQ2zMfN54JgwCEHOGBbMrTu67+UEDxqpYHrD1E
aB5WIe/rMxK7Jdt+YmPGnyaSgdY6c20yOQkSV0GonH6QEPoGbsLWGu+Q7mjpEYAQ
XvFeR1VTJwuE39MSVKsJKE0L8YI0FuO05U+C5g5hmRii1tq2VxosTRLDEUb4PuH9
3NhsMCXnA3k8SJNohFca1gplvvhrACYq6FYexp5IbtUBBZ3b9dUTGIVdFSFqO0YA
WYdkUzDDJ7aN2GK0ZTbw+ApRYIAY7BraNJ/TXGrPFgyXbiK8KMk5IC4V8Jnme2cL
4ISQAy2FIz1licDY4tvlWuPhWU8GGvoHD/N5Osu2Cd+aB4lotdORsi8pfawel1go
ePyZ3SXJOCCvvsIyD1bWamdpgo6UlgJ26XtRXU9of0GZRbkN0fOXrBDDb5oPwiQU
79DCnDLOABfYhbJ995mFMZaBiF1ualD3t2j6uim44k6odABzi87iPd/mcmF1Ytpr
juLHolFQWyLJ1eHgOn9aaP6XRaV2/mnzzCxEipe8iohNuRov2Yg=
=pN0K
-----END PGP SIGNATURE-----

--nextPartd2wzYXrITaCXMDi0MefA1w--



