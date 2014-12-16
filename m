From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/7] input: alps: Set correct name of psmouse device in
 alps_init()
Date: Mon, 15 Dec 2014 21:02:34 -0800
Message-ID: <20141216050234.GA35408@dtor-ws>
References: <1415993906-13307-1-git-send-email-pali.rohar@gmail.com>
 <1415993906-13307-2-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1415993906-13307-2-git-send-email-pali.rohar@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Yunkang Tang <yunkang.tang@cn.alps.com>, Vadim Klishko <vadim@cirque.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Pali,

On Fri, Nov 14, 2014 at 08:38:20PM +0100, Pali Roh=E1r wrote:
> On some laptops after starting them from off state (not after reboot)=
, function
> alps_probe_trackstick_v3() (called from function alps_identify()) doe=
s not
> detect trackstick. To fix this problem we need to reset device. But f=
unction
> alps_identify() is called also from alps_detect() and we do not want =
to reset
> device in detect function because it will slow down initialization of=
 all other
> non alps devices.
>=20
> This patch moves code for setting correct device name & protocol from=
 function
> alps_detect() to alps_init() which already doing full device reset.
>=20
> So this patch removes need to do trackstick detection in alps_detect(=
) function.
>=20
> Signed-off-by: Pali Roh=E1r <pali.rohar@gmail.com>
> ---
>  drivers/input/mouse/alps.c |   17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
> index 8d85c79..9ffa98d 100644
> --- a/drivers/input/mouse/alps.c
> +++ b/drivers/input/mouse/alps.c
> @@ -2392,6 +2392,10 @@ int alps_init(struct psmouse *psmouse)
>  	if (input_register_device(priv->dev2))
>  		goto init_fail;
> =20
> +	if (!(priv->flags & ALPS_DUALPOINT))
> +		psmouse->name =3D "GlidePoint TouchPad";
> +	psmouse->model =3D priv->proto_version;
> +
>  	psmouse->protocol_handler =3D alps_process_byte;
>  	psmouse->poll =3D alps_poll;
>  	psmouse->disconnect =3D alps_disconnect;
> @@ -2422,11 +2426,18 @@ int alps_detect(struct psmouse *psmouse, bool=
 set_properties)
>  		return -1;
> =20
>  	if (set_properties) {
> +		/*
> +		 * NOTE: To detect model and trackstick presence we need to do
> +		 *       full device reset. To speed up detection and prevent
> +		 *       calling duplicate initialization sequence (both in
> +		 *       alps_detect() and alps_init()) we set model/protocol
> +		 *       version and correct name in alps_init() (which will
> +		 *       do full device reset). For now set name to DualPoint.
> +		 */
>  		psmouse->vendor =3D "ALPS";
> -		psmouse->name =3D dummy.flags & ALPS_DUALPOINT ?
> -				"DualPoint TouchPad" : "GlidePoint";
> -		psmouse->model =3D dummy.proto_version << 8;
> +		psmouse->name =3D "DualPoint TouchPad";
>  	}
> +

I do not quite like the way we change the device description back and
forth. Do you think we could allocate the "real" priv structure in
alps_detect() and have alps_init() expect to find it (and free it if
set_properties is false). This way we'd go through initialization once
in detect, it will be authoritative, and we would set the name of the
device properly from the beginning.

Thanks.

--=20
Dmitry
