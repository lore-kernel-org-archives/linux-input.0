From: Frank Praznik <frank.praznik@gmail.com>
Subject: Re: [PATCH 4/7] HID: sony: make the check for BUZZ_CONTROLLER more readable
Date: Mon, 1 Feb 2016 09:41:01 -0500
Message-ID: <E1835BCB-CF3E-47D8-B782-A971D64685C5@gmail.com>
References: <1454001827-26732-1-git-send-email-ao2@ao2.it> <1454001827-26732-5-git-send-email-ao2@ao2.it>
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qg0-f68.google.com ([209.85.192.68]:34434 "EHLO
	mail-qg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932715AbcBAOlE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 1 Feb 2016 09:41:04 -0500
Received: by mail-qg0-f68.google.com with SMTP id 94so10084736qgt.1
        for <linux-input@vger.kernel.org>; Mon, 01 Feb 2016 06:41:04 -0800 (PST)
In-Reply-To: <1454001827-26732-5-git-send-email-ao2@ao2.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Antonio Ospite <ao2@ao2.it>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jikos@kernel.org>


> On Jan 28, 2016, at 12:23, Antonio Ospite <ao2@ao2.it> wrote:
>=20
> Use a positive test for BUZZ_CONTROLLER which is the particular case,
> and leave the 'else' branch for the general case.
>=20
> Signed-off-by: Antonio Ospite <ao2@ao2.it>
> ---
> drivers/hid/hid-sony.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
> index 8dcea69..3877101 100644
> --- a/drivers/hid/hid-sony.c
> +++ b/drivers/hid/hid-sony.c
> @@ -1547,10 +1547,10 @@ static void buzz_set_leds(struct sony_sc *sc)
>=20
> static void sony_set_leds(struct sony_sc *sc)
> {
> -	if (!(sc->quirks & BUZZ_CONTROLLER))
> -		schedule_work(&sc->state_worker);
> -	else
> +	if (sc->quirks & BUZZ_CONTROLLER)
> 		buzz_set_leds(sc);
> +	else
> +		schedule_work(&sc->state_worker);
> }
>=20
> static void sony_led_set_brightness(struct led_classdev *led,
> --=20
> 2.7.0
>=20

My nitpick here is that moving the common case to the =E2=80=98else=E2=80=
=99 branch can mean more branch mispredictions.
This isn=E2=80=99t a particularly hot piece of code, but I still prefer=
 common-case first.

Ultimately I=E2=80=99d really like to get rid of the special-case buzze=
r code and just use a state worker like all of the
other devices, but I don=E2=80=99t have any buzzer controllers to test =
with and don=E2=80=99t know anyone who does.--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
