From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 5/7] elantech: report position also with 3 fingers
Date: Tue, 20 Jul 2010 20:38:21 -0700
Message-ID: <20100721033821.GB9070@core.coreip.homeip.net>
References: <4C1FD2B0.1080504@tudelft.nl>
 <4C1FD48C.3040506@tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:44245 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932940Ab0GUDi0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 20 Jul 2010 23:38:26 -0400
Received: by pwi5 with SMTP id 5so2443602pwi.19
        for <linux-input@vger.kernel.org>; Tue, 20 Jul 2010 20:38:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4C1FD48C.3040506@tudelft.nl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?iso-8859-1?Q?=C9ric?= Piel <E.A.B.Piel@tudelft.nl>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Florian Ragwitz <rafl@debian.org>

Hi Eric,

On Mon, Jun 21, 2010 at 11:07:24PM +0200, =C9ric Piel wrote:
>=20
> The 6-byte protocol supports reporting the position when three finger=
s
> are pressed, exactly like when one finger is pressed. Report this.
>=20
> In addition, it is also distinguishes between 3 and 4 fingers pressed=
=2E
>=20
> Signed-off-by: =C9ric Piel <eric.piel@tremplin-utc.net>
> ---
>  drivers/input/mouse/elantech.c |   10 ++++++++++
>  1 files changed, 10 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/ela=
ntech.c
> index b09b458..633f100 100644
> --- a/drivers/input/mouse/elantech.c
> +++ b/drivers/input/mouse/elantech.c
> @@ -257,6 +257,14 @@ static void elantech_report_absolute_v2(struct p=
smouse *psmouse)
>  	input_report_key(dev, BTN_TOUCH, fingers !=3D 0);
>   	switch (fingers) {
> +	case 3:
> +		/*
> +		 * Same as one finger, except report of more than 3 fingers:
> +		 * byte 3:  n4  .   w1  w0   .   .   .   .
> +		 */
> +		if (packet[3] & 0x80)
> +			fingers =3D 4;
> +		/* pass through... */

Are we certain it is 4-finger and not equivalent of "palm detect" flag?
I could not locate the equivalent in Ubutu sources, where did you get
this data?

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
