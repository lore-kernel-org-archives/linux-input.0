From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/5] drivers: input: keyboard: st-keyscan: add keyscan
 driver
Date: Mon, 10 Mar 2014 15:38:15 +0000
Message-ID: <20140310153815.GE13661@lee--X1>
References: <1393990772-9567-1-git-send-email-gabriel.fernandez@st.com>
 <1393990772-9567-2-git-send-email-gabriel.fernandez@st.com>
 <20140310114819.GO14976@lee--X1>
 <20140310152859.GA29054@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140310152859.GA29054@core.coreip.homeip.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Gabriel FERNANDEZ <gabriel.fernandez@st.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Rob Landley <rob@landley.net>, Russell King <linux@arm.linux.org.uk>, Grant Likely <grant.likely@linaro.org>, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, kernel@stlinux.com, Giuseppe Condorelli <giuseppe.condorelli@st.com>
List-Id: linux-input@vger.kernel.org

> > > This patch adds ST Keyscan driver to use the keypad hw a subset
> > > of ST boards provide. Specific board setup will be put in the
> > > given dt.
> > >=20
> > > Signed-off-by: Giuseppe Condorelli <giuseppe.condorelli@st.com>
> > > Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
> >=20
> > Are you sure these are in the correct order?
> >=20
> > What is the history of this commit?
> >=20
> > > ---
> > >  .../devicetree/bindings/input/st-keypad.txt        |  50 ++++
> >=20
> > This should be submitted as a seperate patch.
>=20
> Why do we have such requirement? To me it would make more sense to ad=
d
> binding documentation in the same commit as the code that uses these
> bindings.

I'm inclined to agree with you and that's actually how we used to do
it, but a decision was made by the DT guys at one of the Kernel
Summits to submit Documentation as a separate patch.

> [...]
>=20
> > > +
> > > +	error =3D matrix_keypad_parse_of_params(dev, &pdata->num_out_pa=
ds,
> > > +			&pdata->num_in_pads);
> > > +	if (error) {
> > > +		dev_err(dev, "failed to parse keypad params\n");
> > > +		return error;
> >=20
> > Nit: It's pretty unusual to use this for a standard error handling
> > variable. Consider 'ret' or 'err' as a replacement.
>=20
> I like "error", in fact there are a lot of these in input. I use "err=
or" for
> data that is only returned from error path and "retval" when the same
> variable is returned in both success and error paths.

If that's your preference then I'm cool with it too. Scrap my comment.

[...]

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
