Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3AC435DA78;
	Tue, 16 Jun 2026 19:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781637032; cv=pass; b=fM3IpJbof6tK2pGUNacCEjcy0jrINMZy4IisgmNvZGXgB3OApRurwC9LaqLBedtD/GfSD4mwcAwwPySQBgQTJMSVpIl2oukoNapXneDkC+vYH/76E6nCUK63o7r2yFpWCivurmKbat6bLm4wjesDnsLaqcJVbBsyfG86qVHMtJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781637032; c=relaxed/simple;
	bh=+be6xwWfsfW2iri43M+vtgZaeeKerRICx8D64esyGSw=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=HPq1d7wblKuDIw0eFrzGGETV11YvmN+tzCR7EuHRhEiUxyBd8eTEz9VLaHe5w0R28hdjdm9QJnzr/xwhFR+iTtq+1a/IAQg4yvBh7JKKOvn8MFFdzTRvToDw7HJO7rl8QIMq7WoRxYbpvj7hI6KyiQari3iyRzpWjq+9V6XXCA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b=CpbsEIGJ; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b="CpbsEIGJ"
ARC-Seal: i=1; a=rsa-sha256; t=1781637020; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=MAt2d1LreRzuzo2fTle8SvyCCUklSVgDqt2b2F57xdOkv2XRTsnu7OrcrUpMgzww4+vqwQ8L80rp+gOZPQxBZWtVBeXOD4E9/89cyeldHONigMT6pUUnWMcEJofvZrPULxbCVaCAq7b0X469wo3BMbxo4iL++5Ia+HoyQXSHgOs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1781637020; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=xwx6R6yJacaS7yityX5EzwO2OsoxdFJpU4yOuqIw+dY=; 
	b=k+osoqLfY2kG8p2fJYhnCU1Cak49LkyF3wV6rGx2okPbzpFviZdB4Ep7plut6Xc3CI5Wlh8RMkMOGnVnF2vgtTTtlizuFCwkOE9J/UOkK7+tpy6aR5R1/V8w+fSpD1QnlwnAQmabo9JPToVmM27+XHPe0dInnlSI3y9mqPywBzo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1781637020;
	s=zmail2048; d=rong.moe; i=i@rong.moe;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date:Date:MIME-Version:Message-Id:Reply-To;
	bh=xwx6R6yJacaS7yityX5EzwO2OsoxdFJpU4yOuqIw+dY=;
	b=CpbsEIGJXYYWMKyOz/xybgBKwO8gIvePY6QWPaHd8s9BisyYBnoL07dtUBibYkn4
	Nd9DX5qDL6hoHfpICJ0wVGU0it5LPLl/SdVJ2nIXsbFhKb7V4yfYUPkNiHpbJSfZA7P
	oqS7wOeayISRKEiKCn+d+GajrE3JFjD4SfOqZdNLKh+TzoORXJgQJEwd7QVItSLVzG6
	VjUJIPg4Qj4QB6mB0WRblxcj9QzQ69wi7t43g01LYN2rpNIWNJsg2f/JLihUJ3DjEAh
	Mks3NGkgrJt7LmMWDsXoEIr0/kykCvUpIwomyd/HetV9Kvb47EGnsfCeFNQnq+FgVBj
	BvOJNmu5UA==
Received: by mx.zohomail.com with SMTPS id 1781637017474234.05856656163724;
	Tue, 16 Jun 2026 12:10:17 -0700 (PDT)
Message-ID: <a89599d5b2ba541d99b6c335a59b811b7f0779fc.camel@rong.moe>
Subject: Re: [RFC] Adding device-initiated haptic feedback knobs for
 pressurepads
From: Rong Zhang <i@rong.moe>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires
 <bentiss@kernel.org>,  Peter Hutterer <peter.hutterer@who-t.net>,
 linux-input <linux-input@vger.kernel.org>, LKML	
 <linux-kernel@vger.kernel.org>
In-Reply-To: <ajGbFNj73yxaEj0y@google.com>
References: <bbee6e61a243a0ae4db6ea155909607326a80dac.camel@rong.moe>
	 <ajGbFNj73yxaEj0y@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jun 2026 03:05:11 +0800
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2-9 
X-ZohoMailClient: External

Hi Dmitry,

On Tue, 2026-06-16 at 11:56 -0700, Dmitry Torokhov wrote:
> Hi Rong,
>=20
> On Tue, Jun 16, 2026 at 11:34:45PM +0800, Rong Zhang wrote:
> > Hi all,
> >=20
> > A pressurepad is a MT touchpad that simulates haptic feedback. The
> > haptic feedback may be either device-initiated or host-initiated. While
> > drivers/hid/hid-haptic.c [1] provides comprehensive support for host-
> > initiated ones, device-initiated ones are currently not configurable at
> > all.
> >=20
> > According to Microsoft's Input Device Haptics Implementation Guide [2],
> > pressurepads with device-initiated haptic feedback can support
> > SET_FEATURE reports to allow users to customize the intensity of the
> > haptic feedback (usage page 0x0e Haptics, usage 0x23 Intensity) and/or
> > the force required to trigger a button press (usage page 0x0d
> > Digitizers, usage 0xb0 Button Press Threshold). Each knob should occupy
> > a dedicated report ID.
> >=20
> > The first knob maps to "ClickForceSensitivity" in Windows registry and
> > "Touchpad feedback" =3D> "Intensity" in Windows Settings [3]. The secon=
d
> > knob maps to "ClickForceSensitivity" in Windows registry.=20
> >=20
> > The pressurepad on my laptop supports the first knob:
> >=20
> >    # 0x05, 0x0e,                    //  Usage Page (Haptic)            =
    595
> >    # 0x09, 0x01,                    //  Usage (Simple Haptic Controller=
)   597
> >    # 0xa1, 0x02,                    //  Collection (Logical)           =
    599
> >    # 0x09, 0x23,                    //   Usage (Intensity)             =
    601
> >    # 0x85, 0x09,                    //   Report ID (9)                 =
    603
> >    # 0x15, 0x00,                    //   Logical Minimum (0)           =
    605
> >    # 0x25, 0x64,                    //   Logical Maximum (100)         =
    607
> >    # 0x75, 0x08,                    //   Report Size (8)               =
    609
> >    # 0x95, 0x01,                    //   Report Count (1)              =
    611
> >    # 0xb1, 0x02,                    //   Feature (Data,Var,Abs)        =
    613
> >    # 0xc0,                          //  End Collection                 =
    615
> >=20
> > I hardly use Windows but the last time I booted it I did see "Touchpad
> > feedback" =3D> "Intensity" in Windows Settings.
> >=20
> > On Linux, I can tune the knob by setting the corresponding feature
> > report via HIDRAW. The pressurepad remembers=C2=A0the knob value until =
it
> > loses power. However, getting the feature report returns garbage data
> > (probably from the last input report in the buffer), which makes some
> > sense as the implementation guide only requires SET_FEATURE support.
> >=20
> > I'd like to add device-initiated haptic feedback configurations for
> > Linux. For now, I only focus on the first knob, i.e., Haptics Intensity=
,
> > since it's supported on my device. If I somehow get a device with the
> > second knob I may work on it too.
>=20
> The question is why would we want to support device-initiated feedback
> instead of enhancing userspace to fully control it. For the record on
> ChromeOS we tried implementing support for device-initiated feedback but
> it made the kernel code very cumbersome and left a lot of gaps/rough
> edges when combining device- and host-initiated haptic effects.=20

Sorry, I didn't explain it clearly enough.

Most Windows laptops shipping with a pressurepad don't support host-
initiated feedback at all. That's also the case of my device.

>=20
> I'd prefer it all being driven from userspace.

... so The only force feedback stuff we can control on these
pressurepads are the said one or two knobs, really :-(

Hopefully one day we will live in a host-initiated haptic world...

Thanks,
Rong

>=20
> Thanks.
