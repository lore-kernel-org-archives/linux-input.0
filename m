Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6683932DC;
	Fri, 10 Apr 2026 17:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775842507; cv=none; b=pb+jCFW/Q24RbBnwvKOSa8dlXm5zHieUplaqqF1FzieeWG3SkOb5Uhfq7pEpvqqX2KDwCXldkANho4mKRWZ5vSjdhh5dlH3txbOurTJZq2rtXPACq/dv4vxCFH0Oo0mQ/OloDwpAOjVrxqsIDvTpN7ngoqdmfgd6bq9HIVFAldk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775842507; c=relaxed/simple;
	bh=h1W+nyCu3AOJVaJuJJ/UvEnAIZZjEkoSXon0451Q0vk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IzmpkuAaH/y1FaJjKSx/TwuRMODYAk5JPBgnyzeRZb2POphmq0EAkmDoeM86pRnKC/Mi1kTpQmUQhJmmYa0nCFvPjOL9pmruMlFE9zSMfTNTXq2SJ5+BhvVSPA3jLKJ2Cg1dP1sj+jt+n5sHcSnOU7d6QEKJCleW/j+3MFIaOXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O1mT/k3H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O1mT/k3H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52B12C19421;
	Fri, 10 Apr 2026 17:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775842507;
	bh=h1W+nyCu3AOJVaJuJJ/UvEnAIZZjEkoSXon0451Q0vk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O1mT/k3HhTHNYK81OxaH3vAGpsRsnuAV1awUyf8HE7TVdol8gDe6cz8YN44ypy5iV
	 vZELjyydPtVCl+2LrVweRR5qe+pBzJzt5p9862QVldQF9wrtRBtG6bemEVgPwhFtVs
	 pK3faRODfqyul8Q7/mz/Qzte2uXgcRJhyM9HbV3nfz9OZdAW3gAPzjhcQ9l9jIeQ6n
	 5epLNxpS7vRjxJDiGuHoGI7nyx5DJ1ujPvmYqL8UDERWEJU3K2y7StZj4okRKuG+25
	 EIiALU8mP4PsNuVGfUdUzHsgWrbuv5VC+TzzaqgEnmKgPfE68hpNFYpDLiLDUIDgF+
	 wCw9Udl7NTiBA==
Date: Fri, 10 Apr 2026 18:35:00 +0100
From: Conor Dooley <conor@kernel.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jingyuan Liang <jingyliang@chromium.org>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Mark Brown <broonie@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-input@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, hbarnor@chromium.org,
	tfiga@chromium.org, Dmitry Antipov <dmanti@microsoft.com>,
	Jarrett Schultz <jaschultz@microsoft.com>
Subject: Re: [PATCH v3 09/11] dt-bindings: input: Document hid-over-spi DT
 schema
Message-ID: <20260410-sake-dollop-9f253ddb0749@spud>
References: <20260402-send-upstream-v3-0-6091c458d357@chromium.org>
 <20260402-send-upstream-v3-9-6091c458d357@chromium.org>
 <20260409-defuse-thank-4b038128fac5@spud>
 <adfdkwq_bF9dirAq@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Y/RXBM/umoYzjiEA"
Content-Disposition: inline
In-Reply-To: <adfdkwq_bF9dirAq@google.com>


--Y/RXBM/umoYzjiEA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 09, 2026 at 10:16:46AM -0700, Dmitry Torokhov wrote:
> On Thu, Apr 09, 2026 at 05:02:11PM +0100, Conor Dooley wrote:
> > On Thu, Apr 02, 2026 at 01:59:46AM +0000, Jingyuan Liang wrote:
> > > Documentation describes the required and optional properties for
> > > implementing Device Tree for a Microsoft G6 Touch Digitizer that
> > > supports HID over SPI Protocol 1.0 specification.
> > >=20
> > > The properties are common to HID over SPI.
> > >=20
> > > Signed-off-by: Dmitry Antipov <dmanti@microsoft.com>
> > > Signed-off-by: Jarrett Schultz <jaschultz@microsoft.com>
> > > Signed-off-by: Jingyuan Liang <jingyliang@chromium.org>
> > > ---
> > >  .../devicetree/bindings/input/hid-over-spi.yaml    | 126 +++++++++++=
++++++++++
> > >  1 file changed, 126 insertions(+)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/input/hid-over-spi.yam=
l b/Documentation/devicetree/bindings/input/hid-over-spi.yaml
> > > new file mode 100644
> > > index 000000000000..d1b0a2e26c32
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/input/hid-over-spi.yaml
> > > @@ -0,0 +1,126 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/input/hid-over-spi.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: HID over SPI Devices
> > > +
> > > +maintainers:
> > > +  - Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > > +  - Jiri Kosina <jkosina@suse.cz>
> >=20
> > Why them and not you, the developers of the series?
> >=20
> > > +
> > > +description: |+
> > > +  HID over SPI provides support for various Human Interface Devices =
over the
> > > +  SPI bus. These devices can be for example touchpads, keyboards, to=
uch screens
> > > +  or sensors.
> > > +
> > > +  The specification has been written by Microsoft and is currently a=
vailable
> > > +  here: https://www.microsoft.com/en-us/download/details.aspx?id=3D1=
03325
> > > +
> > > +  If this binding is used, the kernel module spi-hid will handle the
> > > +  communication with the device and the generic hid core layer will =
handle the
> > > +  protocol.
> >=20
> > This is not relevant to the binding, please remove it.
> >=20
> > > +
> > > +allOf:
> > > +  - $ref: /schemas/input/touchscreen/touchscreen.yaml#
> > > +
> > > +properties:
> > > +  compatible:
> > > +    oneOf:
> > > +      - items:
> > > +          - enum:
> > > +              - microsoft,g6-touch-digitizer
> > > +          - const: hid-over-spi
> > > +      - description: Just "hid-over-spi" alone is allowed, but not r=
ecommended.
> > > +        const: hid-over-spi
> >=20
> > Why is it allowed but not recommended? Seems to me like we should
> > require device-specific compatibles.
>=20
> Why would we want to change the driver code to add a new compatible each
> time a vendor decides to create a chip that is fully hid-spi-protocol
> compliant? Or is the plan to still allow "hid-over-spi" fallback but
> require device-specific compatible that will be ignored unless there is
> device-specific quirk needed?

This has nothing to do with the driver, just the oddity of having a
comment saying that not having a device specific compatible was
permitted by not recommended in a binding. Requiring device-specific
compatibles is the norm after all and a comment like this makes draws
more attention to the fact that this is abnormal. Regardless of what the
driver does, device-specific compatibles should be required.

> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  interrupts:
> > > +    maxItems: 1
> > > +
> > > +  reset-gpios:
> > > +    maxItems: 1
> > > +    description:
> > > +      GPIO specifier for the digitizer's reset pin (active low). The=
 line must
> > > +      be flagged with GPIO_ACTIVE_LOW.
> > > +
> > > +  vdd-supply:
> > > +    description:
> > > +      Regulator for the VDD supply voltage.
> > > +
> > > +  input-report-header-address:
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +    minimum: 0
> > > +    maximum: 0xffffff
> > > +    description:
> > > +      A value to be included in the Read Approval packet, listing an=
 address of
> > > +      the input report header to be put on the SPI bus. This address=
 has 24
> > > +      bits.
> > > +
> > > +  input-report-body-address:
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +    minimum: 0
> > > +    maximum: 0xffffff
> > > +    description:
> > > +      A value to be included in the Read Approval packet, listing an=
 address of
> > > +      the input report body to be put on the SPI bus. This address h=
as 24 bits.
> > > +
> > > +  output-report-address:
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +    minimum: 0
> > > +    maximum: 0xffffff
> > > +    description:
> > > +      A value to be included in the Output Report sent by the host, =
listing an
> > > +      address where the output report on the SPI bus is to be writte=
n to. This
> > > +      address has 24 bits.
> > > +
> > > +  read-opcode:
> > > +    $ref: /schemas/types.yaml#/definitions/uint8
> > > +    description:
> > > +      Value to be used in Read Approval packets. 1 byte.
> > > +
> > > +  write-opcode:
> > > +    $ref: /schemas/types.yaml#/definitions/uint8
> > > +    description:
> > > +      Value to be used in Write Approval packets. 1 byte.
> >=20
> > Why can none of these things be determined from the device's compatible?
> > On the surface, they like the kinds of things that could/should be.
>=20
> Why would we want to keep tables of these values in the kernel and again
> have to update the driver for each new chip?

That's pretty normal though innit? It's what match data does.
If someone wants to have properties that communicate data that
can be determined from the compatible, they need to provide
justification why it is being done.

> It also probably firmware-dependent.


--Y/RXBM/umoYzjiEA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCadk0wQAKCRB4tDGHoIJi
0oXEAQDSWNAocQ7MVn24Zy2B1nO6Pq/WY3ecja9nGfaWTvDSXQEApF/WEBk8cXP0
lP16gSN1Sk/PgPbZlHSiBOGQckqj/Qo=
=fNLv
-----END PGP SIGNATURE-----

--Y/RXBM/umoYzjiEA--
