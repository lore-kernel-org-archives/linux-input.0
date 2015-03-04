From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: Bug in i2c-core?
Date: Wed, 4 Mar 2015 09:22:37 +0100
Message-ID: <20150304082237.GA2955@katana>
References: <54F0507F.6030804@armadeus.com>
 <20150227165944.GA6679@dtor-ws>
 <3574616.qzNqihiGp7@avalon>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:39600 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934935AbbCDIW3 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 4 Mar 2015 03:22:29 -0500
Content-Disposition: inline
In-Reply-To: <3574616.qzNqihiGp7@avalon>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, =?utf-8?Q?S=C3=A9bastien?= SZYMANSKI <sebastien.szymanski@armadeus.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-i2c@vger.kernel.org, Rob Herring <robh@kernel.org>


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > > I am writing an I2C touchscreen driver for an i.MX6 based board. I
> > > compiled it as a module and when I unload it, I get the following war=
ning:
> > >=20
> > > # modprobe sx8654
> > > [   46.261494] input: SX8654 I2C Touchscreen as
> > > /devices/soc0/soc/2100000.aips-bus/21a0000.i2c/i2c-0/0-0048/input/inp=
ut1
> > > # rmmod sx8654
> > > [   76.435223] ------------[ cut here ]------------
> > > [   76.439909] WARNING: CPU: 0 PID: 134 at fs/proc/generic.c:552
> > > remove_proc_entry+0x148/0x164()
> > > [   76.448582] remove_proc_entry: removing non-empty directory
> > > 'irq/208', leaking at least 'sx8654'
> >=20
> > ...
> >=20
> > > When I revert commit e4df3a0 (i2c: core: Dispose OF IRQ mapping at
> > > client removal time) I don't get the warning.
> > >=20
> > > Is this a bug in the i2c-core or am I doing something wrong in my dri=
ver?
> >=20
> > Yes, this commit breaks all drivers using devm* for IRQ management on
> > OF-based systemsi because devm* cleanup happens in device code, after
> > bus's remove() method returns. I'd recommend reverting and finding a
> > better way (making cleanup a custom devm action as well?).
>=20
> Ouch, my bad.
>=20
> Wolfram, any opinion ? The original patch fixes a real bug, so we shouldn=
't=20
> just revert it.

Looking at it some more: What bug does it fix? Anything you experienced?

I wonder if we really need e4df3a0 because I can't see where
platform_get_irq, the major user of of_irq_get, disposes the mapping.
irq_create_of_mapping() will return an already assigned mapping if
called twice. I don't know yet, though, if mappings are static or if a
mapping can be routed to another irq controller over some time because
theoretically they can be dynamically added/removed.

Adding Rob to CC as he wrote of_irq_get and put it into
platform_get_irq. Rob, we use of_irq_get() in the I2C core and the
question is now if we need to dispose the mapping and if so what would
be a good place for it so managed devices will not have their mappings
removed before the managed irq is removed.

Thanks,

   Wolfram


--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU9sDMAAoJEBQN5MwUoCm2mvoQAJ4RIHt9XH+cVgTdeoVcsoyF
1VkHyRcQIca2VOFbu/QA1BB4hEGrYLq4yFiRJfEcukbKZ0ccBvxSQEnmZi8rrxae
cntbwIRyFfQMmbIPQoqDQLyvbLTjdJAsGsqvnrLTFPDmVtUvH7W7Xztvbrd/tewv
1QS3XkVlVyqkeEZT+lzRnNC60vD8zJ3I5ogyf4XwIsVwFzEQp1mYmFmZVfOVftkc
dMfEzqe3VQyvhVIoU4k4b859bmHLuSBiFTh8/1CgEe4BtZju7TJMXJkcjQ/3B0R2
jK8Op5gzub6qxqEp/UlIBt9/YzXioY96d8c+/Ma2MNQ0wFxQsbvxosVWIGZQ0UKI
JDnyJBnn5Vuz9cQ6+THLvaYKyAcnV9CJmWMHQcZ1P1SlhnusXPz0rh9qb3cydLLp
CW6A82i7H7eztKAqk3j+HyaRgR6AiZg6C1ca1oPhEOeKt2+1H4tgMNNACPFc4dsQ
7LC2LpHfh44IW7O/4dFyFmJBccRBNM73V1hjRu4RZCsIR57ad9mZcx5j8C8Gu62B
ev9HryEYEiDZlP3TxIecYuFL6hSIfvDJ3ntACQULbn5IqDCAioYPNmovV4vVXuSJ
nYLySdhVYCf3fi1QIiaL7b0xAOwu5po4Vmmg0mcx2UdX+Q8sLcWUwhb2FHoIxRf/
++cso/uUkQ5TjnFWLWue
=1Fwv
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--
