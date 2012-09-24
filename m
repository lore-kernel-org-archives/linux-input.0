From: Thierry Reding <thierry.reding@avionic-design.de>
Subject: Re: [PATCH] input: pwm-beeper: Add devicetree probing support
Date: Mon, 24 Sep 2012 21:42:02 +0200
Message-ID: <20120924194202.GB29044@avionic-0098.mockup.avionic-design.de>
References: <1348472258-31519-1-git-send-email-s.hauer@pengutronix.de>
 <5060584A.80305@gmail.com>
 <20120924155639.GA1440@core.coreip.homeip.net>
 <506088C9.8030002@metafoo.de>
 <20120924184938.GQ1322@pengutronix.de>
 <5060AF17.7070409@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HG+GLK89HZ1zG0kk"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:64379 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757869Ab2IXTmI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 24 Sep 2012 15:42:08 -0400
Content-Disposition: inline
In-Reply-To: <5060AF17.7070409@metafoo.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robherring2@gmail.com>, linux-input@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, kernel@pengutronix.de


--HG+GLK89HZ1zG0kk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 24, 2012 at 09:05:59PM +0200, Lars-Peter Clausen wrote:
> On 09/24/2012 08:49 PM, Sascha Hauer wrote:
> > On Mon, Sep 24, 2012 at 06:22:33PM +0200, Lars-Peter Clausen wrote:
> >> On 09/24/2012 05:56 PM, Dmitry Torokhov wrote:
> >>> On Mon, Sep 24, 2012 at 07:55:38AM -0500, Rob Herring wrote:
> >>>> On 09/24/2012 02:37 AM, Sascha Hauer wrote:
> >>>>> A very simple binding, the only property is the phandle to the PWM.
> >>>>>
> >>>>> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> >>>>
> >>>> Acked-by: Rob Herring <rob.herring@calxeda.com>
> >>>>
> >>>>> ---
> >>>>>  Documentation/devicetree/bindings/input/pwm-beeper.txt |    7 ++++=
+++
> >>>>>  drivers/input/misc/pwm-beeper.c                        |   11 ++++=
++++++-
> >>>>>  2 files changed, 17 insertions(+), 1 deletion(-)
> >>>>>  create mode 100644 Documentation/devicetree/bindings/input/pwm-bee=
per.txt
> >>>>>
> >>>>> diff --git a/Documentation/devicetree/bindings/input/pwm-beeper.txt=
 b/Documentation/devicetree/bindings/input/pwm-beeper.txt
> >>>>> new file mode 100644
> >>>>> index 0000000..7388b82
> >>>>> --- /dev/null
> >>>>> +++ b/Documentation/devicetree/bindings/input/pwm-beeper.txt
> >>>>> @@ -0,0 +1,7 @@
> >>>>> +* PWM beeper device tree bindings
> >>>>> +
> >>>>> +Registers a PWM device as beeper.
> >>>>> +
> >>>>> +Required properties:
> >>>>> +- compatible: should be "pwm-beeper"
> >>>>> +- pwms: phandle to the physical pwm device
> >>>>> diff --git a/drivers/input/misc/pwm-beeper.c b/drivers/input/misc/p=
wm-beeper.c
> >>>>> index fc84c8a..a6aa48c 100644
> >>>>> --- a/drivers/input/misc/pwm-beeper.c
> >>>>> +++ b/drivers/input/misc/pwm-beeper.c
> >>>>> @@ -75,7 +75,10 @@ static int __devinit pwm_beeper_probe(struct pla=
tform_device *pdev)
> >>>>>  	if (!beeper)
> >>>>>  		return -ENOMEM;
> >>>>> =20
> >>>>> -	beeper->pwm =3D pwm_request(pwm_id, "pwm beeper");
> >>>>> +	if (pdev->dev.platform_data)
> >>>>> +		beeper->pwm =3D pwm_request(pwm_id, "pwm beeper");
> >>>>> +	else
> >>>>> +		beeper->pwm =3D pwm_get(&pdev->dev, NULL);
> >>>
> >>> Hmm, pwm_id =3D=3D 0 is a valid ID I think, but your change makes it =
go into
> >>> DT branch, potentially breaking it.
> >=20
> > My bad, I missed that platform_data is casted to an unsigned long. I
> > thought I would test for a pointer.
> > The obvious clean way would be to use a pointer for platform_data, but
> > given that this will vanish anyway soon, I think we could just test for
> > existence of dev->of_node instead of dev->platform_data.
>=20
> I think the plan is to convert the existing board file platforms to pwm_t=
able
> and then remove the old pwm_request API. So this wouldn't work too well i=
f we'd
> test for of_node. Maybe we can just run pwm_get unconditionally and fallb=
ack to
> pwm_request if it failed. That's also what the PWM backlight driver curre=
ntly does.

I agree. Calling pwm_get() will automatically switch to using the
entries from a PWM table if the board adds it.

> >> Yes, this a bit tricky, but we only have a single in-tree user of the
> >> pwm-beeper which uses a id !=3D 0. And now that all the PWM providers =
have
> >> been converted to the new generic PWM framework the old legacy API wil=
l go
> >> away soon anyway. So this if () else branch should hopefully only be
> >> necessary for a transitional period of 1-2 releases. So I think this c=
hange
> >> should be OK.
> >>
> >> But I think the patch is missing a change to the Kconfig entry to allo=
w the
> >> driver to be selected if the generic PWM framework is available.
> >>
> >> --- a/drivers/input/misc/Kconfig
> >> +++ b/drivers/input/misc/Kconfig
> >> @@ -444,7 +444,7 @@ config INPUT_PCF8574
> >>
> >>  config INPUT_PWM_BEEPER
> >>  	tristate "PWM beeper support"
> >> -	depends on HAVE_PWM
> >> +	depends on HAVE_PWM || PWM
> >=20
> > Is this the preferred way to do this? Instead of doing the above I added
> > a 'select HAVE_PWM' to the pwm framework instead. I found a patch for t=
hat,
> > but there were comments to it that this is not good
> >=20
>=20
> Thierry said that this is his preferred solution. Given that HAVE_PWM wil=
l be
> extinct soon anyway I think it is fine.

The reason is that some platforms, actually the majority, do not define
HAVE_PWM property. We ran into that problem when the PWM tree was first
added to linux-next because builds would break on PowerPC, which is one
of the architectures that doesn't define HAVE_PWM.

Conceptually what we're saying here is that either the legacy PWM API
(HAVE_PWM) or the new PWM framework (PWM) can satisfy the dependency.
Note that if you make the change above, it is no longer enough to depend
on HAVE_PWM because that doesn't provide the pwm_get() function.

Also we should be able to remove HAVE_PWM for 3.7 already as all legacy
implementations have been moved. The plan is to get rid of pwm_request()
and pwm_free() for 3.8. All that's required is converting all the board
files to use PWM lookup tables.

Thierry

--HG+GLK89HZ1zG0kk
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQYLeKAAoJEN0jrNd/PrOhHeIP/iDHbfXMxxQ8awG93XIzxZge
aEuEmwi77JAvoullPFIPBNBPZYBh29h5VIwStLrVwPr/xDU/LwoMC0a0nsjcYA+I
Fxtjpv/a/0qIM5XslsgfovK5apU0l0mVaoapYZbXvlUri6B8eYsou6xCu0jA+CPy
Y800bk3hWxg9y6xm3RrNWRrT73qX+tCwjamLBQ0uz9Nd/PX76GTt4Hti8LJXKukc
2TixGRO80pDeZv9Qk2ia4JKNa0UJjbb3/XPl1EKSRVwRqylXFjoDc11F3g1b6QLG
VhCfPXv0SKUJ6ziMoIfYO870PbSM1QwIyTg+UxxWEyUyo5APOyUzyT5gr5x6xO55
OJ7y4tTiWJATOmWHE7V86QSrPLea2uy+Z7xSeH4UK/9Z2yrNtRcIGfCuJ3dPImyn
qybwWyiqD26tnhDGijh+iKgz224vzw9j12dUqICtLQbdPCTAdBopCo8Zrr8IUJcj
+nEO8Dfibjo3yUr4kWJWC9TAx+LKwOJo3Z3xPoEge0VbfVhqoFkx1leMVhpwj5iR
fwdLtEwxvYQapnOd7N9R9Neo+bZ8vXlvEzdEH6l6dLBnid02UJDl/5N/854Augc9
Ot29VeO4PDirpPXK6tNcZ4hNYi3aFat0yV2aZ7sh8tEyQDSJ40myxf7ibBowt3FS
DEYaaSXLcD9ovxq+etkI
=OxCw
-----END PGP SIGNATURE-----

--HG+GLK89HZ1zG0kk--
