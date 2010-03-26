From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH v3 1/6] hid: new driver for PicoLCD device
Date: Fri, 26 Mar 2010 21:59:19 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1003262156280.24576@pobox.suse.cz>
References: <20100324233707.7243b04d@neptune.home> <20100324234022.0361bd80@neptune.home> <20100326065656.GC26602@core.coreip.homeip.net> <20100326102951.3b9ecda1@neptune.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:34558 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753378Ab0CZU7W (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 26 Mar 2010 16:59:22 -0400
In-Reply-To: <20100326102951.3b9ecda1@neptune.home>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-15?Q?Bruno_Pr=E9mont?= <bonbons@linux-vserver.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, "Rick L. Vinyard Jr." <rvinyard@cs.nmsu.edu>, Nicu Pavel <npavel@ituner.com>, Oliver Neukum <oliver@neukum.org>, Jaya Kumar <jayakumar.lkml@gmail.com>

On Fri, 26 Mar 2010, Bruno Pr=E9mont wrote:

> > > +	for (i =3D 0; i < PICOLCD_KEYS; i++) {
> > > +		int key =3D ((int *)idev->keycode)[i];
> >=20
> > Keycodes are now short, not int. Also, just do:
> >=20
> > 		input_set_capability(idev, EV_KEY, data->keycode[i]);
> >=20
> > > +		if (key < KEY_MAX && key >=3D 0)
> > > +			input_set_capability(idev, EV_KEY, key);
>=20
> Oops, I was not careful enough when switching over...

Dmitry, thanks a lot for rapid review the driver.

Bruno, could you please fix this and submit a followup 1/6 patch, so th=
at=20
I could queue the driver in my tree?

I have almost finished going over the driver and haven't encountered an=
y=20
other issues that would require immediate fixing.

Still, it would be nice to have the framebuffer/LCD/backlight bits=20
reviewed by respective subsystem maintainers. But I'll probably queue t=
he=20
driver nevertheless and add potential ACKs later.

Thanks,

--=20
Jiri Kosina
SUSE Labs, Novell Inc.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
