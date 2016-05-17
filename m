From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH v2 0/6] Input: soc_button_array fixes and support of the
 Surface 3
Date: Tue, 17 May 2016 19:45:31 +0200
Message-ID: <1463507131.3440.7.camel@hadess.net>
References: <1463155554-11747-1-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from slow1-d.mail.gandi.net ([217.70.178.86]:38356 "EHLO
	slow1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750800AbcEQRvs (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 17 May 2016 13:51:48 -0400
In-Reply-To: <1463155554-11747-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Lejun Zhu <lejun.zhu@linux.intel.com>, Fabio Estevam <festevam@gmail.com>

On Fri, 2016-05-13 at 18:05 +0200, Benjamin Tissoires wrote:
> Hi,
>=20
> This is the v2 of the series with 3 extra patches to add support of
> the buttons
> found on the Surface 3.
>=20
> Cheers,
> Benjamin
>=20
>=20
> Benjamin Tissoires (6):
> =C2=A0 Input - soc_button_array: use gpio_is_valid()
> =C2=A0 Input - soc_button_array: bail out earlier if gpiod_count is n=
ull
> =C2=A0 Input - soc_button_array: make sure one GPIO is not assigned t=
wice
> =C2=A0 Input - soc_button_array: allow to specify active_low
> =C2=A0 Input - soc_button_array: export part of the internals
> =C2=A0 Input - surface3_button_array: Introduce button support for th=
e
> =C2=A0=C2=A0=C2=A0=C2=A0Surface 3

Works on my Surface 3, the volume buttons, and the Windows button work
as expected. Note that the power button does not send out any events on
my machine, but that might be due to firmware differences.

My BIOS is listed as version 1.51116.78 released 03/09/2015.

As there's no errors generated, it would be fine to look at it as a bug
fix later on (or for me to updated my system).

Tested-by: Bastien Nocera <hadess@hadess.net>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
