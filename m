From: =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Subject: Re: [PATCH] Fix for problems with eGalax/DWAV multi-touch-screen
Date: Mon, 20 Sep 2010 19:03:17 +0200
Message-ID: <DAB0AEF8-B5D1-4D21-83E2-6535B8AA0A4B@enac.fr>
References: <1284476919.3732.10.camel@PhEeeTab>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 89-230.252-81.static-ip.oleane.fr ([81.252.230.89]:46336 "EHLO
	smtp.lii-enac.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755984Ab0ITRDY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 20 Sep 2010 13:03:24 -0400
In-Reply-To: <1284476919.3732.10.camel@PhEeeTab>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Philipp Merkel <mail@philmerk.de>
Cc: linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>


Le 14 sept. 10 =E0 17:08, Philipp Merkel a =E9crit :


> 3) Only multi-touch pressure events are sent, single touch =20
> emulation is
>    missing pressure information. This patch adds single-touch
>    ABS_PRESSURE events.
>
Oops, thx for the fix.

>
> 1) While there is a dedicated multitouch driver for the screen
>    (hid-egalax.c), the MULTI_INPUT quirk is also applied, preventing
>    the hid-egalax driver from working. This patch removes the quirk
>    so the hid-egalax driver can handle the device correctly.

No opinion here, I'm not comfortable with MULTI_INPUT and multitouch =20
(too much variability from one device to another).

> 2) The x and y coordinates sent by the screen in multi-touch mode are
>    shifted by three bits from the events sent in single-touch mode, =20
> thus
>    the coordinates are out of range, leading to the pointer being =20
> stuck
>    in the bottom-right corner if no additional calibration is applied
>    (e.g. in the X evdev driver). This patch shifts the coordinates =20
> back.
>    This does not decrease accuracy as the last three bits of the =20
> "wrong"
>    coordinates are always 0.

Mmm. This would be a bug in the firmware? I'll notify the eGalax =20
folks. Anyway, if there's a bug we must fix it. But the driver was =20
(probably too quickly) registered for another eGalax product with a =20
different protocol: 0x0eef:0x720c (the one in the Joojoo). Can =20
someone check if the fix applies to this product as well? Otherwise =20
we'll have to devise a solution.

St.



--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
