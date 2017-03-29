From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 05/11] Documentation: DT: bindings:
 input: touschcreen: remove sun4i documentation
Date: Wed, 29 Mar 2017 08:58:26 +0100
Message-ID: <20170329075826.4curjodxgi34tgco@dell>
References: <20170321153611.16228-1-quentin.schulz@free-electrons.com>
 <20170321153611.16228-6-quentin.schulz@free-electrons.com>
Reply-To: lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBDA7X7F2WUEBBJOS5XDAKGQEI7AL37I-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <20170321153611.16228-6-quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, knaack.h-Mmb7MZpHnFY@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org, thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, icenowy-ymACFijhrKM@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Tue, 21 Mar 2017, Quentin Schulz wrote:

> This patch removes the sun4i touchscreen controller binding
> documentation since it has been merged with the sun4i GPADC binding
> documentation.
>=20
> Signed-off-by: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> ---
>=20
> added in v2
>=20
>  .../bindings/input/touchscreen/sun4i.txt           | 38 ----------------=
------

Just an Input Ack missing here.

>  1 file changed, 38 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/input/touchscreen/s=
un4i.txt
>=20
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/sun4i.tx=
t b/Documentation/devicetree/bindings/input/touchscreen/sun4i.txt
> deleted file mode 100644
> index 89abecd..0000000
> --- a/Documentation/devicetree/bindings/input/touchscreen/sun4i.txt
> +++ /dev/null
> @@ -1,38 +0,0 @@
> -sun4i resistive touchscreen controller
> ---------------------------------------
> -
> -Required properties:
> - - compatible: "allwinner,sun4i-a10-ts", "allwinner,sun5i-a13-ts" or
> -   "allwinner,sun6i-a31-ts"
> - - reg: mmio address range of the chip
> - - interrupts: interrupt to which the chip is connected
> - - #thermal-sensor-cells: shall be 0
> -
> -Optional properties:
> - - allwinner,ts-attached	 : boolean indicating that an actual touchscree=
n
> -				   is attached to the controller
> - - allwinner,tp-sensitive-adjust : integer (4 bits)
> -				   adjust sensitivity of pen down detection
> -				   between 0 (least sensitive) and 15
> -				   (defaults to 15)
> - - allwinner,filter-type	 : integer (2 bits)
> -				   select median and averaging filter
> -				   samples used for median / averaging filter
> -				   0: 4/2
> -				   1: 5/3
> -				   2: 8/4
> -				   3: 16/8
> -				   (defaults to 1)
> -
> -Example:
> -
> -	rtp: rtp@01c25000 {
> -		compatible =3D "allwinner,sun4i-a10-ts";
> -		reg =3D <0x01c25000 0x100>;
> -		interrupts =3D <29>;
> -		allwinner,ts-attached;
> -		#thermal-sensor-cells =3D <0>;
> -		/* sensitive/noisy touch panel */
> -		allwinner,tp-sensitive-adjust =3D <0>;
> -		allwinner,filter-type =3D <3>;
> -	};

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
