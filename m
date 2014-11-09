From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3 4/4] input: alps: Fix trackstick detection
Date: Sun, 9 Nov 2014 00:05:04 -0800
Message-ID: <20141109080504.GB34700@dtor-ws>
References: <1412329392-5580-1-git-send-email-pali.rohar@gmail.com>
 <1414884310-19842-1-git-send-email-pali.rohar@gmail.com>
 <1414884310-19842-5-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1414884310-19842-5-git-send-email-pali.rohar@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Yunkang Tang <yunkang.tang@cn.alps.com>, Tommy Will <tommywill2011@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Pali,

On Sun, Nov 02, 2014 at 12:25:10AM +0100, Pali Roh=E1r wrote:
>  int alps_detect(struct psmouse *psmouse, bool set_properties)
>  {
> -	struct alps_data dummy;
> +	unsigned char e6[4];
> =20
> -	if (alps_identify(psmouse, &dummy) < 0)
> -		return -1;
> +	/*
> +	 * Try "E6 report".
> +	 * ALPS should return 0,0,10 or 0,0,100 if no buttons are pressed.
> +	 * The bits 0-2 of the first byte will be 1s if some buttons are
> +	 * pressed.
> +	 */
> +	if (alps_rpt_cmd(psmouse, PSMOUSE_CMD_SETRES,
> +			 PSMOUSE_CMD_SETSCALE11, e6))
> +		return -EIO;
> +
> +	if ((e6[0] & 0xf8) !=3D 0 || e6[1] !=3D 0 || (e6[2] !=3D 10 && e6[2=
] !=3D 100))
> +		return -EINVAL;
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
>  	return 0;

We can't do this; going by e6 only will give us false positives and
alps_detect is supposed to be authoritative.

Thanks.

--=20
Dmitry
