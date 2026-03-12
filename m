Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1824D373C15;
	Thu, 12 Mar 2026 12:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773320215; cv=none; b=cC9MrNG4z1oF3VrlAwA6HehvpsMj4Q9v6fxosjdH8MP1QE2TY0bM3nvmDq5h0XkEzPGzxMROw/pqZd0lUcSRgamspq2ZAZtSNxSZuyni61M5AJIsSUyJRGP0NFz5qTAXazhXFkM0lcM9LuARsUWP1fVyRNP+JKZZ1+Gi4rLuuFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773320215; c=relaxed/simple;
	bh=gBZltAF936KTfUzOOgSXawf/jzpmRMXlISQQRiJGysQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=JyU5iynkjWD6Qg940ygGlhiwYLFBxWKv6o95OvtGP/aCLNEt/+KMwijxlCEpf/kwSkw+TUcprwO4GAfZKjY4+oygxvyuRK0TR8+c3TeWZBQ6OzwRAL0NHVeDFiMrumhw9CEX8BqqOx7zjbmdvDIjMt4wWijwEINd93ApQ2dOt1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ChUg1QEr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ChUg1QEr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EE0BC19424;
	Thu, 12 Mar 2026 12:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773320214;
	bh=gBZltAF936KTfUzOOgSXawf/jzpmRMXlISQQRiJGysQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=ChUg1QErSG7JQH34va4eiKe40JFIt803SahulevsKsRgBUaOWGUHnw/YaBtzSsuN6
	 jDXgnk1a+FESB7otZS2OQHBgEYUQzuvpRZRkUXlnkMiFzNMvFJn5cmwbBWfXAN+Vm6
	 UwRQ2yXrAD1a5rtZFtN1+A111L2zZwoAhTqr1QWDTJG7guaslJa0LGIVY6yUHVAyQY
	 8cl3LyA1h4nss5HiOak0JhOt7Mxr4eZZx4aAl6f9qw42y6H7I56w/Am164DOcB4al8
	 ZDlYJ2TuoXyrLDBvGnnpGp2Xg0wiNs6ZJSX+zOyjwnjzJ+VVj6ExxN3T/nbrRaf9FR
	 fH/7TWtNjEU9g==
Date: Thu, 12 Mar 2026 13:56:51 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: =?ISO-8859-15?Q?Ren=E9_Rebe?= <rene@exactco.de>
cc: Lukas Bulwahn <lbulwahn@redhat.com>, 
    Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
    kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, 
    Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: Re: [PATCH] HID: quirks: really enable the intended work around for
 appledisplay
In-Reply-To: <9pos2s83-p7q0-oq36-oqo3-s555o07p31n9@xreary.bet>
Message-ID: <96qn3q37-6r2r-6101-63ps-4p53s0s18rs2@xreary.bet>
References: <20260205081131.426899-1-lukas.bulwahn@redhat.com> <944F8139-6528-442E-BFC2-9609A7DACA2D@exactco.de> <9pos2s83-p7q0-oq36-oqo3-s555o07p31n9@xreary.bet>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sat, 21 Feb 2026, Jiri Kosina wrote:

> > > Commit c7fabe4ad921 ("HID: quirks: work around VID/PID conflict for
> > > appledisplay") intends to add a quirk for kernels built with Apple Ci=
nema
> > > Display support, but it refers to the non-existing config option
> > > CONFIG_APPLEDISPLAY, whereas the config option for Apple Cinema Displ=
ay
> > > support is named CONFIG_USB_APPLEDISPLAY.
> > >=20
> > > Refer to the intended config option CONFIG_USB_APPLEDISPLAY in the if=
def
> > > directive.
> > >=20
> > > Fixes: c7fabe4ad921 ("HID: quirks: work around VID/PID conflict for a=
ppledisplay")
> > > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> > > ---
> > >=20
> > > Note this fix suggests that the patch of commit c7fabe4ad921 in this =
form
> > > was never effectively tested, checking the effect that the commit mes=
sage
> > > claims it would have.
> >=20
> > Thanks for spotting this. It was tested when I did this years ago. Thou=
gh, maybe I
> > tested before adding the #if IS_ENABLED, anciently hit some key in Vim,=
 o
> > something was renamed since then.
> >=20
> > Either way, I=E2=80=99ll get the display out of the basement and re-tes=
t it the coming days.
>=20
> Is there any results of this testing, please?

Friendly ping on this one :)

--=20
Jiri Kosina
SUSE Labs

