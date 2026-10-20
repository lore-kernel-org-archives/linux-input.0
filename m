Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792519040;
	b=FogTSuEcfYkMl3fZd+xwUyXg+ngzDxGVvWLh9RZpVmAoCWQrQQvoR6G7hPXkcrc5f3hJ
	 JqZJzAko6+mwZWmpvzoROLHdA3vKpxFFfEO9xK/p+XD65+0rKDa2B4vUp9/FiI3dcWHGM
	 UIhS7ZcvUCXACMLSrug8OpvXioW/UMYpAtLxba1IBa2lXekpfodJ9BGeOXDZ5/ItyBqbz
	 JHB5350kka7s/zDoDo4EuK1z/JdtjDn1CjIAURyFMvDGLPLwfEnjXYkmbrh0dS0rybp0U
	 R5YSnWJvs/ABUEo7VxbHkwf/++KbbNN8WrIIpTQVo5t+hLVYSxMj2rUooECFOV+/2yg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792519040;
	h=Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=qqjC+9vmR2qBmvg53MTaGTLKHl+DN6yRypiyKqm8GmQ=;
	b=ngqiqLjZbEd0hucJ2plArf1xMozRN3GO7n8Ri5hVaXBmESUwbJvLK/a/YpYwmrCC/DbL
	 h5KMkgpkaCPOyeGHdtty0BaeQ+1eawYzAjscYnhTcIYaWBIuzAOcTYAMflUhGvXQShIea
	 aOo4/HN8Iz/x6rRl6wpG8qqtbgLLM5G5pvAzNsDjXNjI+A+0ZdkdDZ/wflNixfz4uH3GR
	 LGDN9B8Y0DMC7d/1BKRxU8X2JRK/XIpT7BCCWqMqPyGuNgnOgYgseErci06M+tg4yTTu0
	 AfnWdBZw1BMbYSMzSMbKXjGuqVkhpKxt7iWOm5LB/DtucthfuG3omtXg5m6jnq1Vxug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9103606A319;
	Tue, 20 Oct 2026 17:57:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC1A81F000CA;
	Tue, 20 Oct 2026 17:57:14 +0000 (UTC)
Date: Tue, 20 Oct 2026 18:57:12 +0100
From: Conor Dooley <conor@kernel.org>
To: Jingyuan Liang <jingyliang@chromium.org>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Mark Brown <broonie@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-input@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, hbarnor@chromium.org,
	tfiga@chromium.org, fqwqf@fqwqf.xyz, daleyo@gmail.com,
	Dmitry Antipov <dmanti@microsoft.com>,
	Jarrett Schultz <jaschultz@microsoft.com>
Subject: Re: [PATCH v6 08/11] dt-bindings: input: Document hid-over-spi DT
 schema
Message-ID: <20261020-breach-aim-4a497c0089e6@spud>
References: <20261019-send-upstream-v6-0-cb9ba4b3d6fa@chromium.org>
 <20261019-send-upstream-v6-8-cb9ba4b3d6fa@chromium.org>
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
	protocol="application/pgp-signature"; boundary="jkzaY7ASZ64whAJj"
Content-Disposition: inline
In-Reply-To: <20261019-send-upstream-v6-8-cb9ba4b3d6fa@chromium.org>

--jkzaY7ASZ64whAJj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026 at 07:01:20PM +0000, Jingyuan Liang wrote:
> Documentation describes the required and optional properties for
> implementing Device Tree for a Microsoft G6 Touch Digitizer that
> supports HID over SPI Protocol 1.0 specification.
>=20
> The properties are common to HID over SPI.
>=20
> Signed-off-by: Dmitry Antipov <dmanti@microsoft.com>
> Signed-off-by: Jarrett Schultz <jaschultz@microsoft.com>
> Signed-off-by: Jingyuan Liang <jingyliang@chromium.org>

Signoff chain is not right, since the nominal patch author is the last
signoff.

> ---
>  .../devicetree/bindings/input/hid-over-spi.yaml    | 130 +++++++++++++++=
++++++
>  1 file changed, 130 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/input/hid-over-spi.yaml b/=
Documentation/devicetree/bindings/input/hid-over-spi.yaml
> new file mode 100644
> index 000000000000..2a5fa0868a09
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/hid-over-spi.yaml
> @@ -0,0 +1,130 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/input/hid-over-spi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: HID over SPI Devices
> +
> +maintainers:
> +  - Benjamin Tissoires <benjamin.tissoires@redhat.com>
> +  - Jiri Kosina <jkosina@suse.cz>
> +  - Jingyuan Liang <jingyliang@chromium.org>
> +
> +description: |+
> +  HID over SPI provides support for various Human Interface Devices over=
 the
> +  SPI bus. These devices can be for example touchpads, keyboards, touch =
screens
> +  or sensors.
> +
> +  The specification has been written by Microsoft and is currently avail=
able
> +  here: https://www.microsoft.com/en-us/download/details.aspx?id=3D103325
> +
> +  The HID over SPI specification does not define fixed values for the
> +  read/write opcodes and the input/output report addresses. The host
> +  retrieves them from platform firmware (ACPI _DSM), and they differ
> +  between devices. These properties provide the same values on Device
> +  Tree systems, so devices that fully comply with the specification work
> +  with the "hid-over-spi" fallback compatible.
> +
> +allOf:
> +  - $ref: /schemas/input/touchscreen/touchscreen.yaml#
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - microsoft,g6-touch-digitizer
> +      - const: hid-over-spi
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  reset-gpios:
> +    maxItems: 1
> +    description:
> +      GPIO specifier for the device's reset line. The HID over SPI
> +      specification requires a dedicated, host-driven, active-low reset
> +      line. The line must be flagged with GPIO_ACTIVE_LOW.
> +
> +  vdd-supply:
> +    description:
> +      Regulator for the VDD supply voltage.
> +
> +  input-report-header-address:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0
> +    maximum: 0xffffff
> +    description:
> +      A value to be included in the Read Approval packet, listing an add=
ress of
> +      the input report header to be put on the SPI bus. This address has=
 24
> +      bits.
> +
> +  input-report-body-address:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0
> +    maximum: 0xffffff
> +    description:
> +      A value to be included in the Read Approval packet, listing an add=
ress of
> +      the input report body to be put on the SPI bus. This address has 2=
4 bits.
> +
> +  output-report-address:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0
> +    maximum: 0xffffff
> +    description:
> +      A value to be included in the Output Report sent by the host, list=
ing an
> +      address where the output report on the SPI bus is to be written to=
=2E This
> +      address has 24 bits.
> +
> +  read-opcode:
> +    $ref: /schemas/types.yaml#/definitions/uint8
> +    description:
> +      Value to be used in Read Approval packets. 1 byte.
> +
> +  write-opcode:
> +    $ref: /schemas/types.yaml#/definitions/uint8
> +    description:
> +      Value to be used in Output Report packets. 1 byte.

I still dunno why any of these properties exist, especially when there's
a patch in my queue for another microsoft touch device on top of
this series that does not use any of them.

The commit message really needs to explain why these exist and why
compatibles cannot be used to determine these things - as is done for
the microsoft,romulus13-touchpad. If the very next device that appears
seems to require a specific compatible and cannot use these properties
to get across what's needed to the kernel it calls into question why
the binding is designed like this.

pw-bot: changes-requested

Thanks,
Conor.

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - reset-gpios
> +  - vdd-supply
> +  - input-report-header-address
> +  - input-report-body-address
> +  - output-report-address
> +  - read-opcode
> +  - write-opcode
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    spi {
> +      #address-cells =3D <1>;
> +      #size-cells =3D <0>;
> +
> +      hid@0 {
> +        compatible =3D "microsoft,g6-touch-digitizer", "hid-over-spi";
> +        reg =3D <0x0>;
> +        interrupts-extended =3D <&gpio 42 IRQ_TYPE_EDGE_FALLING>;
> +        reset-gpios =3D <&gpio 27 GPIO_ACTIVE_LOW>;
> +        vdd-supply =3D <&pm8350c_l3>;
> +        pinctrl-names =3D "default";
> +        pinctrl-0 =3D <&ts_d6_int_bias>;
> +        input-report-header-address =3D <0x1000>;
> +        input-report-body-address =3D <0x1004>;
> +        output-report-address =3D <0x2000>;
> +        read-opcode =3D /bits/ 8 <0x0b>;
> +        write-opcode =3D /bits/ 8 <0x02>;
> +      };
> +    };
>=20
> --=20
> 2.56.0.212.g129ede20d9-goog
>=20

--jkzaY7ASZ64whAJj
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCatereAAKCRB4tDGHoIJi
0kWEAP9dgTuujf71BJq09846TgyNaj2epPE0o1kSGsd+fzTndAEA9nnH5FZ9TH7F
cn2fMuPCManlEJTNSGD9qNKV2OnJMQs=
=RKkd
-----END PGP SIGNATURE-----

--jkzaY7ASZ64whAJj--
