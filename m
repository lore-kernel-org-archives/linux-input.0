Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="KzPaBXZu"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE190C0;
	Mon,  4 Dec 2023 04:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1701694420; x=1733230420;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HdUGpKAxSFIn+PH7iL9D+/kVSuOVunnGsl9L0zIDHME=;
  b=KzPaBXZup421uE6KJWQvRSMlF6OK/hdNAWQ0H5R4i6DGnmotjJV4+Pv0
   C+i916dIF7rUvaD0nASZQ4EuC4/eYaq2q4NWOYubYDuuyEFcRp97kS0d9
   6PPIFXLtMIXsrJdd7kItzpoAO048n3sX89V5q8dCEc6Ao8XMhN6ZFcm0J
   aJ1eA8pSnntEgJ0Ycircv3ID5EJ1fkjyPOorVBfcplXMJBMLC99n5S6+9
   iQz8bmbU4bm/FibPBxX8Dld2F8rlBrsWJ2Pq4QhzlLBjrpJOSUnUq3kH6
   FJUkxnJVrBAdRPxVgf9fduSv5XAP94tfX2DFjqeABqwggu6q/rTiQcJPe
   Q==;
X-CSE-ConnectionGUID: hl/R1P4LRW6u9LnPnoG1PQ==
X-CSE-MsgGUID: m9nCz6fVTi69cFHzmcHKpg==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600"; 
   d="asc'?scan'208";a="12652088"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Dec 2023 05:53:38 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Dec 2023 05:53:30 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex02.mchp-main.com (10.10.85.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Mon, 4 Dec 2023 05:53:27 -0700
Date: Mon, 4 Dec 2023 12:52:57 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: Markuss Broks <markuss.broks@gmail.com>
CC: Conor Dooley <conor@kernel.org>, Karel Balej
	<karelb@gimli.ms.mff.cuni.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Henrik Rydberg <rydberg@bitmath.org>, <linux-input@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Duje
 =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
	<~postmarketos/upstreaming@lists.sr.ht>, <phone-devel@vger.kernel.org>, Karel
 Balej <balejk@matfyz.cz>
Subject: Re: [PATCH v3 2/5] dt-bindings: input/touchscreen: Add compatible
 for IST3038B
Message-ID: <20231204-stooge-impotent-fe8d2d9177e4@wendy>
References: <20231202125948.10345-1-karelb@gimli.ms.mff.cuni.cz>
 <20231202125948.10345-3-karelb@gimli.ms.mff.cuni.cz>
 <20231203-outskirts-reformat-e0a833903841@spud>
 <0a035c62-9d35-4f85-b1f3-bcb7dea17d52@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BFu57CgKFWeoAbz6"
Content-Disposition: inline
In-Reply-To: <0a035c62-9d35-4f85-b1f3-bcb7dea17d52@gmail.com>

--BFu57CgKFWeoAbz6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 04, 2023 at 02:40:44PM +0200, Markuss Broks wrote:
> On 12/3/23 13:20, Conor Dooley wrote:
> > On Sat, Dec 02, 2023 at 01:48:33PM +0100, Karel Balej wrote:
> > > From: Markuss Broks <markuss.broks@gmail.com>
> > >=20
> > > Imagis IST3038B is a variant (firmware?) of Imagis IST3038 IC,
> > > add the compatible for it to the IST3038C bindings.
> > This one is better, but would be well served by mentioning what
> > specifically is different (register addresses or firmware commands?)
>=20
> I don't think anyone knows this other than Imagis itself. I would guess i=
t's
> different hardware, since register addresses are indeed different, but on
> the other hand, there is a possibility that firmware on the MCU could be
> responding to those commands. I suppose "... IST3038B is a hardware varia=
nt
> of ... IST3038" would be more correct.

Only Imagis might know the specifics, but you (plural) have made driver
changes so you know what is different in terms of the programming model.
I'm just asking for you to mention how the programming model varies in
the commit message. Otherwise I can't know whether you should have added
a fallback compatible, without going and reading your driver change. The
commit message for the bindings should stand on its own merit in that
regard.
"Variant" alone does not suffice, as many variants of devices have a
compatible programming model, be that for a subset of features or
complete compatibility.

> The reason why I think it could be firmware-defined is because we have a =
lot
> of variants (30xxA, 30xxB, 30xxC, plain 30xx), and the numbers usually me=
an
> feature level/completeness, e.g. some don't support the touch pressure or
> touchkeys, and we don't know what A/B/C/none means.

Ultimately whether it is due to firmware or the hardware isn't
particular important, just mention what is incompatibly different.

Cheers,
Conor.


> > > Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
> > > Signed-off-by: Karel Balej <balejk@matfyz.cz>
> > > ---
> > >   .../devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml   | =
1 +
> > >   1 file changed, 1 insertion(+)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/input/touchscreen/imag=
is,ist3038c.yaml b/Documentation/devicetree/bindings/input/touchscreen/imag=
is,ist3038c.yaml
> > > index 0d6b033fd5fb..b5372c4eae56 100644
> > > --- a/Documentation/devicetree/bindings/input/touchscreen/imagis,ist3=
038c.yaml
> > > +++ b/Documentation/devicetree/bindings/input/touchscreen/imagis,ist3=
038c.yaml
> > > @@ -18,6 +18,7 @@ properties:
> > >     compatible:
> > >       enum:
> > > +      - imagis,ist3038b
> > >         - imagis,ist3038c
> > >     reg:
> > > --=20
> > > 2.43.0
> > >=20
> - Markuss

--BFu57CgKFWeoAbz6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZW3LqQAKCRB4tDGHoIJi
0rCWAP4gThPAB9EJ6NjESl6ryX3gO0BfCj8UNHASwMJcmRL3GgD/bFa4X++Poy3R
YiCIDUDAw8pGfZvpoOGoQot7N2vpLw8=
=O6OL
-----END PGP SIGNATURE-----

--BFu57CgKFWeoAbz6--
