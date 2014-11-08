From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3 2/4] input: alps: Allow 2 invalid packets without
 resetting device
Date: Sat, 8 Nov 2014 13:00:34 -0800
Message-ID: <20141108210034.GC40319@dtor-ws>
References: <1412329392-5580-1-git-send-email-pali.rohar@gmail.com>
 <1414884310-19842-1-git-send-email-pali.rohar@gmail.com>
 <1414884310-19842-3-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:50291 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751231AbaKHVAj (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 8 Nov 2014 16:00:39 -0500
Content-Disposition: inline
In-Reply-To: <1414884310-19842-3-git-send-email-pali.rohar@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Yunkang Tang <yunkang.tang@cn.alps.com>, Tommy Will <tommywill2011@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, Nov 02, 2014 at 12:25:08AM +0100, Pali Roh=E1r wrote:
> On some Dell Latitude laptops ALPS device or Dell EC send one invalid=
 byte in
> 6 bytes ALPS packet. In this case psmouse driver enter out of sync st=
ate. It
> looks like that all other bytes in packets are valid and also device =
working
> properly. So there is no need to do full device reset, just need to w=
ait
> for byte which match condition for first byte (start of packet). Beca=
use ALPS
> packets are bigger (6 or 8 bytes) default limit is small.
>=20
> This patch increase number of invalid bytes to size of 2 ALPS packets=
 which
> psmouse driver can drop before do full reset.
>=20
> Resetting ALPS devices take some time and when doing reset on some De=
ll laptops
> touchpad, trackstick and also keyboard do not respond. So it is bette=
r to do it
> only if really necessary.
>=20
> Signed-off-by: Pali Roh=E1r <pali.rohar@gmail.com>
> Tested-by: Pali Roh=E1r <pali.rohar@gmail.com>
> Cc: stable@vger.kernel.org

Applied, thank you.

> ---
>  drivers/input/mouse/alps.c |    3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
> index a772745..7c47e97 100644
> --- a/drivers/input/mouse/alps.c
> +++ b/drivers/input/mouse/alps.c
> @@ -2391,6 +2391,9 @@ int alps_init(struct psmouse *psmouse)
>  	/* We are having trouble resyncing ALPS touchpads so disable it for=
 now */
>  	psmouse->resync_time =3D 0;
> =20
> +	/* Allow 2 invalid packets without resetting device */
> +	psmouse->resetafter =3D psmouse->pktsize * 2;
> +
>  	return 0;
> =20
>  init_fail:
> --=20
> 1.7.9.5
>=20

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
