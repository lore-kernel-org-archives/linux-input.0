Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794441864;
	b=wuoerr5F4fIQeoWcJ2OlrmzrUyZS7VO8Se7EUtln4VmaQrJ8UaxcZMdhWcx8GcwSi+gN
	 SFaRqbaljUc5ANwKaFFbddl3TTjy4rljI9gWSEb+xcL5ujImfgzNKVSyaWhgyBvNXWlRK
	 fzGHD1KtxsmRABa63g0dgI8iFuml9790aw4GTcscAykJtrIUYVIYGGsQftjJ0m2kDb915
	 0quZGqqSdnaqIuIiV4g8Az9qNniBwP2O+9sHxACAFF57d2+JY0rYs41DTHKHrtDQzu4+G
	 +lyDNhc9xcRTHn0Z5nRFM/CJpNocIhctJ/cZE5baaqpwPoW0uIMqyrRsVHN7vDHlgXA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794441864;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Zoho-Virus-Status:X-Zoho-AV-Stamp:
	 X-ZohoMailClient;
	bh=nAHXTkUeJszFD3bMe/ZXPxoCJDorXuNQxO0quJ6FIgI=;
	b=DU9gzOfrnHsMVTnEyOwE98LcUaqto/ekEIwtsEYc9oMGrKyR6Wg3ITZqvMY4JuJuyiOV
	 my/RI3hLbRBAvNBeCjQ9gn7eBy9qar3PMiUFxv+mXsnUm26KiXsx8/6yIHs0pfmnfy0D/
	 MtXf0dB4+H47RiOr0viUxv7rmX2PqKG4O6CfO0jpsOHmiU74kCwr8j/djCodKbSqiyDJq
	 C48bsQpbivyRAKqGGIqgeWDj/LLWzcwhblLb3wlWC9Juj49GqzFPBM0HQwHtJ8WvVmNlr
	 8bGAQPeEYuDih5O+qHhxX0cQzFOBKzD9a3y3MbsLSrgxn3bTJlK0b4nbN0mThrBxwvw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b="QD/0BeVb";
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.11
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com [165.173.180.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63910606A31C;
	Thu, 12 Nov 2026 00:04:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63910606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=QD/0BeVb
ARC-Seal: i=1; a=rsa-sha256; t=1794441845; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=aa5pKgBgtF3YvKaxURcjakErlRZffT1r6rh5Yy2HmRX0tVrxBZ+U85ZNDHcwrM++uk0PvGsoroZUbg3ZahPPF0WQbUGPwXX7GrJ9sjdXQKxKpkVHozWARQ/KreGDxT3CVf4L5mLWnWuH/fVNJpDYOSuZH8t4ZhhC7G3ucDsbWOM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794441845; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=nAHXTkUeJszFD3bMe/ZXPxoCJDorXuNQxO0quJ6FIgI=; 
	b=ieJY4RQTY+q2jP5F3rDnkz4qyrZsJN5l7u6vKC0BNqGPUGzBIiAOhONWBnQAOMFgHcEPa1tcTl9ycZJCYJcNoTDL1I/+Jwr9/cXfBd1SmQUmqHcG7VoJL0RmDy3K4/meSMGy9RF7DCxRLQAXPQqsBGTjOTu1eNN0gNpWqeUNWqY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: a=rsa-sha256; b=QD/0BeVbLdH1S9K/p2x1AdIMiiPAoEjgcUQtGsAAkGMjoHPTpJyLt0fn/qdwoqKnf1T+exeloUdIfJ9QIBHJvqCZwFDDHbwCvKwdn0N4Rlk1e/SAEaqVkPFOU0eZVNMu/XdGLPKvRMEkBmxkhHxjYi0QxpXEr3eRvhbkCGzLFzk=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=nAHXTkUeJszFD3bMe/ZXPxoCJDorXuNQxO0quJ6FIgI=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794441843642472.6185322036207;
	Wed, 11 Nov 2026 16:04:03 -0800 (PST)
Received: by venus (Postfix, from userid 1000)
	id 0C86D180BC0; Thu, 12 Nov 2026 01:03:59 +0100 (CET)
Date: Thu, 12 Nov 2026 01:03:59 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Jakob Unterwurzacher <jakobunt@gmail.com>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Joseph Chen <chenjh@rock-chips.com>, Lee Jones <lee@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, mfd@lists.linux.dev, devicetree@vger.kernel.org, 
	Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>
Subject: Re: [PATCH 0/4] Suspend-to-RAM fixes for RK3588 + SPI-connected
 RK806 PMIC, enable PMIC sleep on RK3588 Tiger
Message-ID: <avT_xrrgeThffbpc@venus>
References: <20261029-dev-tiger-v7-4-pre-20261028-tiger-suspend-b4-v1-0-cb12621c1fb4@cherry.de>
 <a220ebd0-a28d-44cc-9a80-62382018348c@cherry.de>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xvrq2tdjbjck7db4"
Content-Disposition: inline
In-Reply-To: <a220ebd0-a28d-44cc-9a80-62382018348c@cherry.de>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/294.427.16
X-ZohoMailClient: External


--xvrq2tdjbjck7db4
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 0/4] Suspend-to-RAM fixes for RK3588 + SPI-connected
 RK806 PMIC, enable PMIC sleep on RK3588 Tiger
MIME-Version: 1.0

Hi,

On Thu, Oct 29, 2026 at 08:31:34PM +0100, Quentin Schulz wrote:
> Hi Jakob,
>=20
> On 10/29/26 11:06 AM, Jakob Unterwurzacher wrote:
> > This series, together with a few out-of-tree patches (see below), makes
> > suspend-to-RAM on RK3588-Tiger work, down to a power consumption of
> > about 0.4 W. Patches 1-3 apply to all boards with an RK806 PMIC
> > connected via SPI, which includes most RK3588 boards.
> >=20
> > Patch 1 ("Input: rk805-pwrkey - enable the wakeup interrupt during syst=
em suspend")
> > arms the power key interrupt as a wakeup source, so that the
> > power key can wake up the system. This is done in the regular suspend
> > phase, because the SPI bus to the PMIC can no longer be used in the
> > noirq phase.
> >=20
> > Patch 2 ("mfd: rk8xx-core: keep the PMIC interrupt disabled during syst=
em suspend")
> > keeps the PMIC interrupt disabled across system suspend, so that its
> > handler does not run before the bus to the PMIC has resumed.
> >=20
> > Patch 3 ("mfd: rk8xx-spi: add system sleep PM ops")
> > hooks up the existing rk8xx suspend/resume callbacks for the SPI
> > variant, which so far lacked them.
> >=20
> > Patch 4 ("arm64: dts: rockchip: put the PMIC into sleep mode in suspend=
 on RK3588 Tiger")
> > configures the RK806 PWRCTRL1 pin on RK3588 Tiger for its sleep
> > function, so that the regulator suspend states take effect. This lowers
> > the module's power consumption in suspend-to-RAM from 1.09 W to 0.43 W.
> >=20
> > The patches do not depend on each other and can be applied through
> > their respective trees.
> >=20
>=20
> Then have them in separate series. Series should be as small as possible,
> down to a single commit if possible.

I suggest to send patch 2+3 as one series considering patch 3 does
not make much sense without patch 2.

> > Testing
> > -------
> >=20
> > Tested on RK3588-Tiger on the Haikou baseboard, on top of the v7.4 merge
> > window (a8530b69fc4dd): 30 consecutive suspend-to-RAM cycles, each woken
> > up by the PMIC power key, all resumed without errors in the kernel log.
> > USB devices (a SuperSpeed hub with an Ethernet adapter, and its
> > High-Speed part) stayed connected across suspend.
> >=20
> > Out-of-tree patches
> > -------------------
> >=20
> > To test this series, out-of-tree patches were needed and used:
> >=20
> > 1) Upstream TF-A does not complete suspend-to-RAM on this board yet, so=
 the
> > tests used Rockchip's BL31 (rkbin v1.47), configured through a small
> > out-of-tree driver. The plan is to get suspend working in TF-A instead.
> >=20
>=20
> I'm guessing you(r LLM) meant upstream TF-A here? Or what is it that you
> mean?
>=20
> > 2) The inno-usb2 PHY has to be resumed when its 480 MHz clock is enable=
d,
> > otherwise EHCI/OHCI resume hangs. This is addressed by Sebastian
> > Reichel's inno-usb2 series [1].
>=20
> Having access to your downstream branch, you have a patch generated by yo=
ur
> LLM and not Sebastian's patch series. Either use what Sebastian posted, or
> be more careful in your choice of words as I read the above as implying y=
ou
> used his series.
>
> > [1] https://lore.kernel.org/linux-phy/20261001-phy-rockchip-inno-usb2-c=
lock-fix-v2-4-e01bf509359e@collabora.com/

Getting a Tested-by on v5, which finally tamed Sashiko would be
nice:

https://lore.kernel.org/linux-phy/20261110-phy-rockchip-inno-usb2-clock-fix=
-v5-0-d2e24582ab22@collabora.com/

> > 3) The GPU and NPU domain supplies were kept always-on. genpd powers
> > these domains on in the noirq resume phase, when their regulators (on
> > I2C/SPI) cannot be reached yet. I'm not sure what to do here, yet.
>
> > Known issues
> > ------------
> >=20
> > PCIe devices do not survive resume; this depends on system PM
> > support in pcie-dw-rockchip [2].
> >=20
> > [2] https://lore.kernel.org/r/20260316-rockchip-pcie-system-suspend-v5-=
0-5bb5ad37d643@collabora.com
> >=20
>=20
> There already is a v6 from almost two months ago. Did you actually test w=
ith
> the v5 or are you just hinting at what could be helping resume PCIe devic=
es?
>=20
> I'm sure Sebastian would be happy to receive a nice Tested-by tag if you =
did
> indeed test that. Link to v6: https://lore.kernel.org/all/20260908-rockch=
ip-pcie-system-suspend-v6-0-fbabcca9921b@collabora.com/

FWIW v9 got merged:

https://lore.kernel.org/linux-pci/179407115382.87267.12160393716568806842.b=
4-ty@b4/

> > Tool use
> > --------
> >=20
> > These patches were developed with an LLM-based coding assistant (Claude
> > Code). It ran the suspend/resume tests on the hardware, analysed the
> > kernel logs to find the causes of the failures, and drafted the code
> > changes and commit messages. I reviewed all changes and tested them as
> > described above.
> >=20
>=20
> All your patches are missing the Signed-off-by, required to signify DCO[1=
].
> LLMs are forbidden to add it, so I guess you missed that when reviewing t=
he
> patches before sending. Please triple check that you agree to all criteria
> listed in the documentation before adding the SoB to patches generated by
> LLMs[2].

I had a look at the patches and they all look sensible to me, but
not much worth without the SoB.

Greetings,

-- Sebastian

> [1] https://www.kernel.org/doc/html/latest/process/submitting-patches.htm=
l#sign-your-work-the-developer-s-certificate-of-origin
> [2] https://docs.kernel.org/process/coding-assistants.html#signed-off-by-=
and-developer-certificate-of-origin
>=20
> Cheers,
> Quentin

--xvrq2tdjbjck7db4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmr1AmsACgkQ2O7X88g7
+prPMQ//e8rSq/n61dw8XPE9I9S3MpHkhlKNw1vgdWy1Dfay3e0vBVXK4Ym8rpsB
HBQ8Ecj+e5jHnMjCDSvOU+xfHvXT5ZeBTdZ/cQuVcH+HiW/n2MD9X/JpKaQMPyDS
C7YLuOemqZ8NvgyBbpRvxt7NXo3mgFQ8GXSpCm2bTevDrk2Rhc4v3yXIzL2u1RWY
+JSiVXyIJ4ouZlyTFSX+pbwgMZGu923UVsplQMhuwhK/M+KhGYy5sjeHGkX44eTt
OEyBl5qPZbMQDAMgrpvaRKIe1gHdLYZhveMdq4zBdklXCptjOXQmEnRUtsh+Fovq
4s8hy+zA7KwQKZUY8gRNzcgzVF8XQUvCwPmBbwNs3BCthJ0AxucWDF/dlOYrpWu4
jupe+R4AcAV70pss5jGNIu6UyZ7inHkgYer/BlYu0RCW9jBuhc3FeNqFlM8UERbn
2asOcckSqu/014t6/TvVhtLUlTkqZ3axbHiURuBOdPhOy86BP1KCR8uWAtj2DXCT
g1VVhlcHyUJUtyKzJEiWwycCcVb8dFjjDQMLU3Dj4+mE5puoP3W7hzEUbAgNdYJ+
a3IvENnIJS4+ZEiR8m32LUZjo08DdkW81ONSz7FuEUxQ8KmY6f8Y/l5oHsiVHssy
PCfz05ee3JARTPzu9ghAK8tyzaldlg3ofobMZhYtrscwEqHaYrg=
=loQp
-----END PGP SIGNATURE-----

--xvrq2tdjbjck7db4--
