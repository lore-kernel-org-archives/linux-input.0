From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [PATCH] hid-magicmouse: Correct parsing of large X and Y motions.
Date: Tue, 6 Jul 2010 03:54:43 +0800
Message-ID: <AANLkTim9R0ur7r2Y3r3bOMIRSM7JYVcZdGZ0QMaYvK4X@mail.gmail.com>
References: <878w5qaspq.fsf@troilus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:56077 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751695Ab0GETyp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 5 Jul 2010 15:54:45 -0400
Received: by pvc7 with SMTP id 7so2259083pvc.19
        for <linux-input@vger.kernel.org>; Mon, 05 Jul 2010 12:54:43 -0700 (PDT)
In-Reply-To: <878w5qaspq.fsf@troilus.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michael Poole <mdpoole@troilus.org>
Cc: Jiri Kosina <jkosina@suse.cz>, Chase Douglas <chase.douglas@canonical.com>, linux-input@vger.kernel.org

On Mon, Jul 5, 2010 at 10:50 PM, Michael Poole <mdpoole@troilus.org> wr=
ote:
> The X and Y values have two more significant bits in the same byte
> that contains click status. =A0Include these in the reported value.
> Thanks to Iain Hibbert of NetBSD for pointing this out.
>
> Signed-off-by: Michael Poole <mdpoole@troilus.org>
> ---
> =A0drivers/hid/hid-magicmouse.c | =A0 =A04 ++--
> =A01 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmous=
e.c
> index 0b89c1c..7cdda23 100644
> --- a/drivers/hid/hid-magicmouse.c
> +++ b/drivers/hid/hid-magicmouse.c
> @@ -267,8 +267,8 @@ static int magicmouse_raw_event(struct hid_device=
 *hdev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * to have the current touch informati=
on before
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * generating a click event.
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 x =3D (signed char)data[1];
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 y =3D (signed char)data[2];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 x =3D (int)(((data[3] & 0x0c) << 28) | =
(data[1] << 22)) >> 22;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 y =3D (int)(((data[3] & 0x30) << 26) | =
(data[2] << 22)) >> 22;

Will the following give us the same result?

 +               x =3D (int)(((data[3] & 0x0c) << 6) | data[1]);
 +               y =3D (int)(((data[3] & 0x30) << 4) | data[2]);

Ping

> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0clicks =3D data[3];
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0case 0x20: /* Theoretically battery status (0-100), bu=
t I have
> --
> 1.7.1
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
