From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 4/5] ARM: STi: DT: add keyscan for stih41x-b2000
Date: Mon, 10 Mar 2014 11:54:23 +0000
Message-ID: <20140310115423.GR14976@lee--X1>
References: <1393990772-9567-1-git-send-email-gabriel.fernandez@st.com>
 <1393990772-9567-5-git-send-email-gabriel.fernandez@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49]:48574 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752258AbaCJLy3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 10 Mar 2014 07:54:29 -0400
Received: by mail-wg0-f49.google.com with SMTP id a1so4108664wgh.8
        for <linux-input@vger.kernel.org>; Mon, 10 Mar 2014 04:54:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1393990772-9567-5-git-send-email-gabriel.fernandez@st.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Gabriel FERNANDEZ <gabriel.fernandez@st.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Rob Landley <rob@landley.net>, Russell King <linux@arm.linux.org.uk>, Grant Likely <grant.likely@linaro.org>, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, kernel@stlinux.com, Giuseppe Condorelli <giuseppe.condorelli@st.com>

On Wed, 05 Mar 2014, Gabriel FERNANDEZ wrote:

> Add keyscan setup for stih415/h416 b2000.
> Both have same raw/column lines number, debounce time and keymap.
>=20
> Signed-off-by: Giuseppe Condorelli <giuseppe.condorelli@st.com>
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
> ---
>  arch/arm/boot/dts/stih41x-b2000.dtsi | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/stih41x-b2000.dtsi b/arch/arm/boot/dts=
/stih41x-b2000.dtsi
> index 1e6aa92..cf06beb 100644
> --- a/arch/arm/boot/dts/stih41x-b2000.dtsi
> +++ b/arch/arm/boot/dts/stih41x-b2000.dtsi
> @@ -6,6 +6,7 @@
>   * it under the terms of the GNU General Public License version 2 as
>   * publishhed by the Free Software Foundation.
>   */
> +#include <dt-bindings/input/input.h>
>  / {
> =20
>  	memory{
> @@ -46,5 +47,16 @@
> =20
>  			status =3D "okay";
>  		};
> +
> +		keyscan: keyscan@fe4b0000 {
> +			keypad,num-rows =3D <4>;
> +			keypad,num-columns =3D <4>;
> +			st,debounce_us =3D <5000>;
> +			linux,keymap =3D < /* in0	in1	in2	in3 */

Nit: We should try to line the headers up with their associated values
(perhaps they just look misalined in the email and are actually fine
in the text file?)

> +				KEY_F13 KEY_F9  KEY_F5 KEY_F1		/* out0 */
> +				KEY_F14 KEY_F10 KEY_F6 KEY_F2		/* out1 */
> +				KEY_F15 KEY_F11 KEY_F7 KEY_F3		/* out2 */
> +				KEY_F16 KEY_F12 KEY_F8 KEY_F4 >;	/* out3 */
> +		};

Patch looks good though:
  Acked-by: Lee Jones <lee.jones@linaro.org>

>  	};
>  };

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
