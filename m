From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] input: stmpe-ts: Add DT support for stmpe touchscreen
Date: Fri, 23 Nov 2012 10:46:20 +0000
Message-ID: <20121123104620.GQ17471@gmail.com>
References: <f56ddb18f4e9c92f6a94c6d3ae3f5fe30e0bd892.1353652106.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <f56ddb18f4e9c92f6a94c6d3ae3f5fe30e0bd892.1353652106.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, spear-devel@list.st.com, Vipul Kumar Samar <vipulkumar.samar@st.com>
List-Id: linux-input@vger.kernel.org

> +++ b/Documentation/devicetree/bindings/input/touchscreen/stmpe.txt
> @@ -0,0 +1,43 @@
> +STMPE Touchscreen
> +----------------
> +
> +Required properties:
> + - compatible: "st,stmpe-ts"

You shouldn't be specifying a compatible string in the DT.

> +Example:
> +
> +	stmpe_touchscreen {
> +		compatible =3D "st,stmpe-ts";

This needs to be removed.

> +		st,sample-time =3D <4>;
> +		st,mod-12b =3D <1>;
> +		st,ref-sel =3D <0>;
> +		st,adc-freq =3D <1>;
> +		st,ave-ctrl =3D <1>;
> +		st,touch-det-delay =3D <2>;
> +		st,settling =3D <2>;
> +		st,fraction-z =3D <7>;
> +		st,i-drive =3D <1>;
> +	};

--=20
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
