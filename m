From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v2 0/6] Input: soc_button_array fixes and support of the
 Surface 3
Date: Fri, 20 May 2016 09:53:48 +0200
Message-ID: <20160520075348.GI23234@mail.corp.redhat.com>
References: <1463155554-11747-1-git-send-email-benjamin.tissoires@redhat.com>
 <1463507131.3440.7.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49782 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755615AbcETHxy (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 20 May 2016 03:53:54 -0400
Content-Disposition: inline
In-Reply-To: <1463507131.3440.7.camel@hadess.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Lejun Zhu <lejun.zhu@linux.intel.com>, Fabio Estevam <festevam@gmail.com>

On May 17 2016 or thereabouts, Bastien Nocera wrote:
> On Fri, 2016-05-13 at 18:05 +0200, Benjamin Tissoires wrote:
> > Hi,
> >=20
> > This is the v2 of the series with 3 extra patches to add support of
> > the buttons
> > found on the Surface 3.
> >=20
> > Cheers,
> > Benjamin
> >=20
> >=20
> > Benjamin Tissoires (6):
> > =C2=A0 Input - soc_button_array: use gpio_is_valid()
> > =C2=A0 Input - soc_button_array: bail out earlier if gpiod_count is=
 null
> > =C2=A0 Input - soc_button_array: make sure one GPIO is not assigned=
 twice
> > =C2=A0 Input - soc_button_array: allow to specify active_low
> > =C2=A0 Input - soc_button_array: export part of the internals
> > =C2=A0 Input - surface3_button_array: Introduce button support for =
the
> > =C2=A0=C2=A0=C2=A0=C2=A0Surface 3
>=20
> Works on my Surface 3, the volume buttons, and the Windows button wor=
k
> as expected. Note that the power button does not send out any events =
on
> my machine, but that might be due to firmware differences.
>=20
> My BIOS is listed as version 1.51116.78 released 03/09/2015.
>=20
> As there's no errors generated, it would be fine to look at it as a b=
ug
> fix later on (or for me to updated my system).
>=20
> Tested-by: Bastien Nocera <hadess@hadess.net>

Bastien told me in a different thread that the power button is not
working only after a reboot from Windows. After a cold start, it works
fine. There might be something that needs to be set at the I2C level,
but I think while we don't know much about the I2C protocol there, it
should be safe to still get this upstream.

Cheers,
Benjamin

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
