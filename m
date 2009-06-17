From: =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Subject: Re: [PATCH] Restoring usages used by the pen.
Date: Wed, 17 Jun 2009 11:23:24 +0200
Message-ID: <93BE517D-F863-4F80-8060-CC36562E02CC@enac.fr>
References: <4A385751.8000904@seas.upenn.edu>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 89-230.252-81.static-ip.oleane.fr ([81.252.230.89]:59692 "EHLO
	smtp.lii-enac.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764377AbZFQJX2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 17 Jun 2009 05:23:28 -0400
In-Reply-To: <4A385751.8000904@seas.upenn.edu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rafi Rubin <rafi@seas.upenn.edu>
Cc: linux-input@vger.kernel.org, Peter Hutterer <peter.hutterer@who-t.net>, brysgo@gmail.com, Mohamed Ikbel Boulabiar <boulabiar@gmail.com>, Sebastien Hamdani <sebastien.hamdani@gmail.com>, Henrik Rydberg <rydberg@euromail.se>


Le 17 juin 09 =E0 04:39, Rafi Rubin a =E9crit :

> Restoring usages used by the pen.
>
> +
> +		/* these are actually used by the pen */
> +		case HID_DG_INVERT: /* high when the eraser button is pressed */
> +		case HID_DG_ERASER: /* high when the tip and eraser are both =20
> pressed */
> +		case HID_DG_BARRELSWITCH:  /* doubtful */
> +			return 0;

I just tested this on my multitouch-enabled Touchsmart tx2 (that is, =20
one on which the Windows 7 driver published by NTrig in March 2009 =20
was installed, which triggered a firmware install).

This is tricky:
  - as one can expect, the multitouch events are still emitted =20
properly. Fine.
  - but the Wacom Xorg driver patched by Rafi is not interested in =20
the device anymore. I had managed to emit touchscreen-like events for =20
the first finger detected on the screen, so as to feed Xorg with =20
pointer events. This does not work anymore. This probably has to do =20
with the complex rules that have been designed over time to decide =20
what type of device should be handled by what driver. I remember =20
having to dig deep in the code of hid, input *and* the Wacom driver =20
last month to fit in these rules.

TBH, this is not a big loss to me personally, because:
  - so far I had not been able to give the appropriate Xmax and Ymax =20
parameters to the Wacom Xorg driver, so the pointer was badly warped =20
and this was pretty useless anyway.
  -  at some point we'll probably want the NTrig digitizer to be =20
managed by another Xorg driver than the Wacom driver. Peter? Bryan? =20
What do you think?

I guess the whole issue is to try and understand what will be the =20
most popular uses of this device:
  - with which version of the firmware? the one with stylus and =20
single touch? the one with multitouch but no stylus?
  - as a touch screen? as a pen computer?

Leaving aside the pain of having incompatible versions of the =20
firmware around, it looks this type of dual device (stylus + finger) =20
challenges the way linux-hid, linux-input and Xorg regard touch =20
devices: yes, something that looks like a touchscreen can be a =20
digitizer too... Maybe we should create two Linux devices, one for =20
the stylus and one for fingers?


--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
