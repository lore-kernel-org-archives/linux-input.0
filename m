From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [PATCH 1/1] Input - alps: Fix button reporting on the V2 Alps
 protocol
Date: Thu, 30 Jul 2015 09:52:24 +0200
Message-ID: <20150730075224.GA26714@pali>
References: <CANuv8QwPQ1aLvZkC522vmm+_kv7r+f3rwvc=SmjVOvx5XbQUzw@mail.gmail.com>
 <1438202726-5100-1-git-send-email-cpaul@redhat.com>
 <1438202726-5100-2-git-send-email-cpaul@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:33136 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750762AbbG3Hw3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 30 Jul 2015 03:52:29 -0400
Received: by wicmv11 with SMTP id mv11so10095934wic.0
        for <linux-input@vger.kernel.org>; Thu, 30 Jul 2015 00:52:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1438202726-5100-2-git-send-email-cpaul@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: cpaul@redhat.com
Cc: Douglas Christman <douglaschristman@gmail.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, linux-input <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hans de Goede <hdegoede@redhat.com>

On Wednesday 29 July 2015 16:45:26 cpaul@redhat.com wrote:
> From: Stephen Chandler Paul <cpaul@redhat.com>
>=20
> The data concerning which buttons on the touchpad are held down or no=
t
> are in the fourth packet we receive from the mouse, not the first.
>=20
> Signed-off-by: Stephen Chandler Paul <cpaul@redhat.com>
> ---
>  drivers/input/mouse/alps.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
> index 113d6f1..e2f9b25 100644
> --- a/drivers/input/mouse/alps.c
> +++ b/drivers/input/mouse/alps.c
> @@ -254,9 +254,9 @@ static void alps_process_packet_v1_v2(struct psmo=
use *psmouse)
>  	/* Non interleaved V2 dualpoint has separate stick button bits */
>  	if (priv->proto_version =3D=3D ALPS_PROTO_V2 &&
>  	    priv->flags =3D=3D (ALPS_PASS | ALPS_DUALPOINT)) {
> -		left |=3D packet[0] & 1;
> -		right |=3D packet[0] & 2;
> -		middle |=3D packet[0] & 4;
> +		left |=3D packet[3] & 1;
> +		right |=3D packet[3] & 2;
> +		middle |=3D packet[3] & 4;
>  	}
> =20
>  	alps_report_buttons(dev, dev2, left, right, middle);

This patch will break other ALPS devices...
So we cannot accept it :-(

Looks like some proto v2 devices report button clicks in packet[0] and
some in packet[3].

Any idea how to fix it correctly? Do you have other laptops with proto
V2 ALPS devices, to do more tests and dumps and distinguish buttons?

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
