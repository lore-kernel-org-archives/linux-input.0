Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E91A36D4E1;
	Wed, 20 May 2026 17:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779296563; cv=none; b=pU8V66vPbcpjKcRi4dTzZynpzB0cVD8ShtpHcgn5edBECSk81Tt5eujfTbgdwazPgoldfdBd1/zhRTbydaP6V9juzjmprwrNMSSiDH3JLtokIUuLqJy2ln4GdFQjhz5jN3WICx8k0f2pXOnyFxQCu7Od5kxdl8FrPMOaiUZcelY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779296563; c=relaxed/simple;
	bh=LCDAXkMbNaG8B7EheY4tDBaVfRqstJsAZ37zXt19GZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W0aZYUleQjQ/AXEVALAIKxOpR9Kxk7slefjPSkH9HCqWDtiuPthle6K6EO14tiHdcVhnPeNGfNLf+KzOXBOYvkDDSJ6b9v7sTfauIpCjGJIi7Ankc1I5twzkG2c2MFVGvcbtNOsJeKPkCYx31K3adjQ1OXynSZ2JJGfSiQhzKQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B0eAJxCD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B0eAJxCD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B70951F00894;
	Wed, 20 May 2026 17:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779296559;
	bh=/8WAs1IeVf3f+sTX/DIzwS+Cf4pzP3FAVizUFgdp/dE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=B0eAJxCDZFzwxH4dhnncK7P6eY6TUWS2OknwWC4gTI6m2R2eEoLD/DArK4d8BAo4c
	 V2tD1shgtQM2jq7v5Enjn7xfbltzlkaj6x7hLocSvCbE56eKTujpbITHyo/jHYsuCg
	 TMId4fcKQ6vAUbn0CcBJgRgywmcKAifI68T+v9OoNojlqMa/HKZ85t5sFjWlutEhcZ
	 UFITYN/FtbX+THMG6cwkTxb6MzddGGz4Qc3EAtWJrRsvaG+3TPMImsOmy0mNpKUNup
	 yPF2H00jCE50AmysXhztDHrsa2JnEjCOXatJgfYpwaGl9zxXunn492FgdynajCOqYG
	 ymGBE/K3tBiaQ==
Date: Wed, 20 May 2026 18:02:34 +0100
From: Lee Jones <lee@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Pavel Machek <pavel@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Tony Lindgren <tony@atomide.com>, linux-input@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org
Subject: Re: [PATCH v5 5/6] mfd: motorola-cpcap: diverge configuration
 per-board
Message-ID: <20260520170234.GN2767592@google.com>
References: <20260510110804.33045-1-clamor95@gmail.com>
 <20260510110804.33045-6-clamor95@gmail.com>
 <20260520150758.GG2767592@google.com>
 <CAPVz0n0t4PXfmgWYQ1vSTFwfg=+g4oGU+-dwgnBVKxUoUwHGqw@mail.gmail.com>
 <20260520160548.GK2767592@google.com>
 <CAPVz0n2s32uYP76R9VNtWYnHrDQJKK+qC1uRRdkaX1ekF15Pww@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPVz0n2s32uYP76R9VNtWYnHrDQJKK+qC1uRRdkaX1ekF15Pww@mail.gmail.com>

On Wed, 20 May 2026, Svyatoslav Ryhel wrote:

> ср, 20 трав. 2026 р. о 19:05 Lee Jones <lee@kernel.org> пише:
> >
> > On Wed, 20 May 2026, Svyatoslav Ryhel wrote:
> >
> > > ср, 20 трав. 2026 р. о 18:08 Lee Jones <lee@kernel.org> пише:
> > > >
> > > > On Sun, 10 May 2026, Svyatoslav Ryhel wrote:
> > > >
> > > > > MFD have rigid subdevice structure which does not allow flexible dynamic
> > > > > subdevice linking. Address this by diverging CPCAP subdevice composition
> > > > > to take into account board specific configuration.
> > > > >
> > > > > Create a common default subdevice composition, rename existing subdevice
> > > > > composition into cpcap_mapphone_mfd_devices since it targets mainly
> > > > > Mapphone board.
> > > > >
> > > > > Removed st,6556002 as it is no longer applicable to all cases and
> > > > > duplicates motorola,cpcap, which is used as the default composition.
> > > > >
> > > > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > > > ---
> > > > >  drivers/mfd/motorola-cpcap.c       | 142 ++++++++++++++++-------------
> > > > >  include/linux/mfd/motorola-cpcap.h |   6 ++
> > > > >  2 files changed, 87 insertions(+), 61 deletions(-)
> > > >
> > > > Looking much better, thanks.
> > > >
> > > > Nit: A patch-level changelog really is much more helpful to reviewers.
> > > >
> > >
> > > Noted, but I will not guarantee that I will do patch-level changelogs, sorry.
> >
> > That's fine.  All I can do is ask.
> >
> > Note that, helping out reviewers usually ends up helping you too.
> >
> > [...]
> >
> > > > > +static const struct mfd_cell cpcap_default_mfd_devices[] = {
> > > > > +     MFD_CELL_OF("cpcap_adc", NULL, NULL, 0, 0, "motorola,cpcap-adc"),
> > > > > +     MFD_CELL_OF("cpcap_battery", NULL, NULL, 0, 0,
> > > > > +                 "motorola,cpcap-battery"),
> > > > > +     MFD_CELL_OF("cpcap-regulator", NULL, NULL, 0, 0,
> > > > > +                 "motorola,cpcap-regulator"),
> > > > > +     MFD_CELL_OF("cpcap-rtc", NULL, NULL, 0, 0, "motorola,cpcap-rtc"),
> > > > > +     MFD_CELL_OF("cpcap-pwrbutton", NULL, NULL, 0, 0,
> > > > > +                 "motorola,cpcap-pwrbutton"),
> > > > > +     MFD_CELL_OF("cpcap-usb-phy", NULL, NULL, 0, 0,
> > > > > +                 "motorola,cpcap-usb-phy"),
> > > > > +     MFD_CELL_OF("cpcap-led", NULL, NULL, 0, 0, "motorola,cpcap-led-red"),
> > > > > +     MFD_CELL_OF("cpcap-led", NULL, NULL, 0, 1, "motorola,cpcap-led-green"),
> > > > > +     MFD_CELL_OF("cpcap-led", NULL, NULL, 0, 2, "motorola,cpcap-led-blue"),
> > > > > +     MFD_CELL_OF("cpcap-led", NULL, NULL, 0, 3, "motorola,cpcap-led-adl"),
> > > > > +     MFD_CELL_OF("cpcap-led", NULL, NULL, 0, 4, "motorola,cpcap-led-cp"),
> > > > > +     MFD_CELL_NAME("cpcap-codec"),
> > > > > +};
> > > >
> > > > Nit: I wouldn't complain if you wanted to have all of these on a single
> > > > line for neatness.
> > > >
> > >
> > > Noted
> > >
> > > > > +static const struct mfd_cell cpcap_mapphone_mfd_devices[] = {
> > > > > +     MFD_CELL_OF("cpcap_adc", NULL, NULL, 0, 0,
> > > > > +                 "motorola,mapphone-cpcap-adc"),
> > > > > +     MFD_CELL_OF("cpcap_battery", NULL, NULL, 0, 0,
> > > > > +                 "motorola,cpcap-battery"),
> > > > > +     MFD_CELL_OF("cpcap-charger", NULL, NULL, 0, 0,
> > > > > +                 "motorola,mapphone-cpcap-charger"),
> > > > > +     MFD_CELL_OF("cpcap-regulator", NULL, NULL, 0, 0,
> > > > > +                 "motorola,mapphone-cpcap-regulator"),
> > > > > +     MFD_CELL_OF("cpcap-rtc", NULL, NULL, 0, 0, "motorola,cpcap-rtc"),
> > > > > +     MFD_CELL_OF("cpcap-pwrbutton", NULL, NULL, 0, 0,
> > > > > +                 "motorola,cpcap-pwrbutton"),
> > > > > +     MFD_CELL_OF("cpcap-usb-phy", NULL, NULL, 0, 0,
> > > > > +                 "motorola,mapphone-cpcap-usb-phy"),
> > > > > +     MFD_CELL_OF("cpcap-led", NULL, NULL, 0, 0, "motorola,cpcap-led-red"),
> > > > > +     MFD_CELL_OF("cpcap-led", NULL, NULL, 0, 1, "motorola,cpcap-led-green"),
> > > > > +     MFD_CELL_OF("cpcap-led", NULL, NULL, 0, 2, "motorola,cpcap-led-blue"),
> > > > > +     MFD_CELL_OF("cpcap-led", NULL, NULL, 0, 3, "motorola,cpcap-led-adl"),
> > > > > +     MFD_CELL_OF("cpcap-led", NULL, NULL, 0, 4, "motorola,cpcap-led-cp"),
> > > > > +     MFD_CELL_NAME("cpcap-codec"),
> > > > >  };
> > > >
> > > > A lot of these are duplicated, right?
> > > >
> > > > I would have a comment set, then the differences in separate containers.
> > >
> > > It may be impossible to predict a generic setup since some devices may
> > > require unique compatibles, other may not have LEDs, third may be
> > > partially incompatible with existing cells. In other mfd cases
> > > creating a generic bundle might be good, but in this case I would
> > > suggest better to keep these separate entirely per-device. They will
> > > not take much space, nor add confusion with these macros.
> >
> > I'm not sure we're understanding each other.  Let me give you an example:
> >
> > static const struct mfd_cell cpcap_common_devices[] = {
> >      MFD_CELL_OF("cpcap_battery", NULL, NULL, 0, 0, "motorola,cpcap-battery"),
> >      MFD_CELL_OF("cpcap-rtc", NULL, NULL, 0, 0, "motorola,cpcap-rtc"),
> >      MFD_CELL_OF("cpcap-pwrbutton", NULL, NULL, 0, 0, "motorola,cpcap-pwrbutton"),
> >      MFD_CELL_OF("cpcap-led", NULL, NULL, 0, 0, "motorola,cpcap-led-red"),
> >      MFD_CELL_OF("cpcap-led", NULL, NULL, 0, 1, "motorola,cpcap-led-green"),
> >      MFD_CELL_OF("cpcap-led", NULL, NULL, 0, 2, "motorola,cpcap-led-blue"),
> >      MFD_CELL_OF("cpcap-led", NULL, NULL, 0, 3, "motorola,cpcap-led-adl"),
> >      MFD_CELL_OF("cpcap-led", NULL, NULL, 0, 4, "motorola,cpcap-led-cp"),
> >      MFD_CELL_NAME("cpcap-codec"),
> > };
> >
> > static const struct mfd_cell cpcap_default_devices[] = {
> >      MFD_CELL_OF("cpcap_adc", NULL, NULL, 0, 0, "motorola,cpcap-adc"),
> >      MFD_CELL_OF("cpcap-regulator", NULL, NULL, 0, 0, "motorola,cpcap-regulator"),
> >      MFD_CELL_OF("cpcap-usb-phy", NULL, NULL, 0, 0, "motorola,cpcap-usb-phy"),
> > };
> >
> > static const struct mfd_cell cpcap_mapphone_devices[] = {
> >      MFD_CELL_OF("cpcap_adc", NULL, NULL, 0, 0, "motorola,mapphone-cpcap-adc"),
> >      MFD_CELL_OF("cpcap-charger", NULL, NULL, 0, 0, "motorola,mapphone-cpcap-charger"),
> >      MFD_CELL_OF("cpcap-regulator", NULL, NULL, 0, 0, "motorola,mapphone-cpcap-regulator"),
> >      MFD_CELL_OF("cpcap-usb-phy", NULL, NULL, 0, 0, "motorola,mapphone-cpcap-usb-phy"),
> > };
> >
> > This way, it's super easy to read / maintain the common and unique devices.
> >
> > The only potential drawback would be 2 calls to mfd_add_devices() but
> > that's common practice.
> >
> > Also notice that I droped the "_mfd" parts, which you should too.
> >
> 
> What if next added device does not have cpcap-battery, cpcap-led-adl,
> cpcap-pwrbutton, uses external codec and would require cpcap-watchdog
> which is not yet present. This will cause issues. Even Mot introduces
> in the last patch of this patchset has slightly different composition.

We usually just code-up what we have _today_.

If new devices come in with different requirements, it takes 5 mins to rejig.

-- 
Lee Jones
