From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: HID: picoLCD: optimize for inactive debugfs
Date: Mon, 1 Oct 2012 10:25:53 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1210011025490.27440@pobox.suse.cz>
References: <20120930220419.01408e0e@neptune.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120930220419.01408e0e@neptune.home>
Sender: linux-kernel-owner@vger.kernel.org
To: =?ISO-8859-15?Q?Bruno_Pr=E9mont?= <bonbons@linux-vserver.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sun, 30 Sep 2012, Bruno Pr=C3=A9mont wrote:

> Matthieu CASTET adjusted picolcd_debug_out_report() to only operate w=
hen
> there is an active listener on debugfs for events.
>=20
> His change got lost while splitting hid_picolcd.c, restore it.
>=20
> Signed-off-by: Bruno Pr=C3=A9mont <bonbons@linux-vserver.org>
> ---
>=20
>=20
> diff --git a/drivers/hid/hid-picolcd_debugfs.c b/drivers/hid/hid-pico=
lcd_debugfs.c
> index 6ef03be..4809aa1 100644
> --- a/drivers/hid/hid-picolcd_debugfs.c
> +++ b/drivers/hid/hid-picolcd_debugfs.c
> @@ -402,7 +402,7 @@ void picolcd_debug_out_report(struct picolcd_data=
 *data,
>  #define BUFF_SZ 256
> =20
>  	/* Avoid unnecessary overhead if debugfs is disabled */
> -	if (!hdev->debug_events)
> +	if (list_empty(&hdev->debug_list))
>  		return;
> =20
>  	buff =3D kmalloc(BUFF_SZ, GFP_ATOMIC);

Applied, thanks.

--=20
Jiri Kosina
SUSE Labs
