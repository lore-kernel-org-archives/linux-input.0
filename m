Received: from m65s28.vlinux.de (m65s28.vlinux.de [83.151.22.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E9A1A38F9
	for <linux-input@vger.kernel.org>; Fri, 12 Jun 2026 04:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.151.22.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781239170; cv=none; b=XsQhVQ/IPpW4Jj32KIAOVQebUfWeVOulhzjq1Z3CGSl9XqBtCKA/gQkgRQp/AsHcdsbSeLPsva81yWf4GVLU8hVa1prJ5iQWrwzHUnrzNWmtUFtyWtEqOsDWsF+SRU6ANFnG1+mZNRRUTTtMj0Qznecmg+W0oYCECCFMvz2TxqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781239170; c=relaxed/simple;
	bh=OwRdZxCi1KZKYm7DymIqYk8ogqgor6QGxGNcTIjgSOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J6s+oTr2vSt+aFGPy+PWJUkrWCkXhPOTipAVZ/OL1dIn6idVtBJNNRIsXyowqa+2AmFhKJVpbVI4cKS0GvX5rWghHuM6OmTfuo+TkRiDCfL8dlCXC33vIx7Tu3l36At+20FMcMSdnvu3hK/sJmDdC8jbaXpd6QaRMFHvYWmkxvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chaoticmind.net; spf=pass smtp.mailfrom=chaoticmind.net; dkim=pass (2048-bit key) header.d=chaoticmind.net header.i=@chaoticmind.net header.b=SIiwIEH+; arc=none smtp.client-ip=83.151.22.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chaoticmind.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chaoticmind.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=chaoticmind.net header.i=@chaoticmind.net header.b="SIiwIEH+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=chaoticmind.net; s=default; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=X5UCUWkGw+s9NoDXK8eTR5ono/31h4LJNP6xX4U69MU=; b=SIiwIEH++Ngw9Y3SkvvWXAJ7Go
	UbF2jcl2k4NJk35IF6HKeavn660PYEcciY6CVqRm0zSNb1n4mn3LuKmLSn4UCx5YAEZlkqi+Gks98
	fOIxpCFy/CZqNK2WHlDswrwl+zOLryLcNuvCvmNnsVCW+dH7o6PsgRBqOyA5CuWA4TBPMb/tNaf8g
	DWghx+UJgUzYxCWc3izw1M3KS331HGyNaSbJGAlcoYFxXirTeycOJLd/0dlzDo5e5LZjYEkp8Urwm
	wO//3wzZQLQNkoRpqJYj5k9qLsaRllkGFeuThgptoAxn9Fz23aefZ34Us2bO3R3wDXe1r+fhwhQCO
	bSIgD1rQ==;
Received: from p4fd2bb26.dip0.t-ipconnect.de ([79.210.187.38] helo=lothlorien.localnet)
	by m65s28.vlinux.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <hcb@chaoticmind.net>)
	id 1wXtPJ-0001UJ-0p; Fri, 12 Jun 2026 06:22:13 +0200
From: Helge Bahmann <hcb@chaoticmind.net>
To: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org,
 Basavaraj Natikar <bnatikar@amd.com>
Cc: Basavaraj Natikar <Basavaraj.Natikar@amd.com>, bentiss@kernel.org
Subject: Re: [PATCH] amd-sfh-hid: tablet mode switch and asus quirk
Date: Fri, 12 Jun 2026 06:22:10 +0200
Message-ID: <48733359.fMDQidcC6G@lothlorien>
In-Reply-To: <ecadaac8-e222-420a-ac5b-4d529fb3317e@amd.com>
References:
 <6879487.lOV4Wx5bFT@lothlorien> <2632507.ElGaqSPkdT@lothlorien>
 <ecadaac8-e222-420a-ac5b-4d529fb3317e@amd.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Mittwoch, 10. Juni 2026, 19:12:37 Mitteleurop=C3=A4ische Sommerzeit schr=
ieb Basavaraj Natikar:
>=20
> On 5/14/2026 1:29 PM, Helge Bahmann wrote:
>=20
> > [You don't often get email from hcb@chaoticmind.net. Learn why this is =
important at https://aka.ms/LearnAboutSenderIdentification ]
> >
> > On Tue, 12 May 2026, Jiri Kosina wrote:
> >> On Mon, 27 Apr 2026, Helge Bahmann wrote:
> >>
> >>> Add an input driver that interprets the "operation mode" sensor offer=
ed
> >>> by the amd sfh on some laptop models.
> >>>
> >>> Add a quirk to make the driver work again with the Asus VivoBook
> >>> VivoBook (turn off the "disable interrupts" flag).
> >>>
> >>> Expose the intr_disable flag as a module parameter in case it turns o=
ut
> >>> to be needed on further laptop models.
> >>>
> >>> Signed-off-by: Helge Bahmann <hcb@chaoticmind.net>
> >> Basavaraj, can you please review this one?
> > Some additional context, maybe helpful for review:
> >
> > 1. The numbers and behavior were extracted from the ACPI tables
> > (WMI driver of sorts) of the notebook; I don't have access to any
> > official AMD / ASUS docs or similar.
> >
> > 2. I have an alternate version of this change that is more indirect:
> > - create a HID driver providing an "abstract table mode" message
> > - have an input driver attaching to this newly defined HID driver
> >
> > While that is keeping "more in line" with the current driver
> > architecture, I am not sure this indirection really helps. Particularly,
> > there is no "canonical" HID tablet mode switch message defined,
> > so it all remains completely bespoke. I am happy to change it if
> > you prefer, but would need your input.
> >
> > 3. Since this is based on Asus VivoBook and its ACPI tables,
> > there is a possibility that this "op sensor / tablet mode" behavior
> > is not as universal as I surmise. A point could be made to make this
> > entire behavior model-dependent (with a mod param to override
> > / activate for other models). Happy to take input / advice.
>=20
> Thanks Helge.
>=20
> I'd like to go with the dedicated input-driver approach (your option with
> a standalone input driver) rather than the HID-message indirection -- it
> keeps clean subsystem boundaries.

Hello Basavaraj!

Thanks for your architecture input, that sounds good. Let me briefly
clean up the patches and I will send you what I have. I will also
include the input-tabletmode driver that I have, but you will likely
want to change it (use correct protocol message as I am unsure
what would be "correct" here). You can then proceed as you like
(take the driver, rewrite it, ...) -- I will leave ownership decision
entirely up to you, I care more that you are happy with the
overall structure than that.

Thank you
Helge

>=20
> For splitting the work, either of these works for me -- whichever you
> prefer:
>    Option 1: I create the new input driver
>    drivers/input/misc/amd_sfh_tabletmode.c and once done we will review y=
our ASUS VivoBook
>    quirk + intr_disable module-param patches on top of it.
>   =20
>    Option 2: If you'd rather keep ownership of it, you write
>    drivers/input/misc/amd_sfh_tabletmode.c consuming the mode exposed by
>    amd-sfh, and I'll review and help.
>   =20
>=20
> Let me know which option you'd like and I'll proceed.
>=20
> Thanks,
> --
> Basavaraj
>=20
>=20
>=20




