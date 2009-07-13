From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Subject: Re: Input driver for Twinhan USB 6253:0100 remote control
Date: Mon, 13 Jul 2009 11:31:57 +0200
Message-ID: <20090713113157.701ba027@neptune.home>
References: <20090408072935.GA27920@dtor-d630.eng.vmware.com>
	<200904131931.24009.dmitry.torokhov@gmail.com>
	<49E4B678.9030508@rtr.ca>
	<200904140945.14652.dmitry.torokhov@gmail.com>
	<49E4C9CF.5060504@rtr.ca>
	<alpine.LNX.2.00.0904151022170.13028@wotan.suse.de>
	<49E5EAD7.7000309@rtr.ca>
	<alpine.LNX.2.00.0904161123180.13028@wotan.suse.de>
	<20090712182026.7a09c736@neptune.home>
	<alpine.LNX.2.00.0907131048110.10476@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ppp-145-35.adsl.restena.lu ([158.64.145.35]:49427 "EHLO
	bonbons.gotdns.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754853AbZGMJjV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Jul 2009 05:39:21 -0400
In-Reply-To: <alpine.LNX.2.00.0907131048110.10476@wotan.suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Mark Lord <lkml@rtr.ca>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Mon, 13 July 2009 Jiri Kosina <jkosina@suse.cz> wrote:
> On Sun, 12 Jul 2009, Bruno Pr=C3=A9mont wrote:
>=20
> > I wrote the below patch to adjust it's key mappings, though I'm not
> > sure if/how I should deal with the number keys (0..9) with regard t=
o
> > keyboard layout and/or numlock key.
> >=20
> > I tried with KEY_0..KEY_9 (default) as well as KEY_KP0..KEY_KP9 but
> > neither produces optimal results on my machine (laptop with numlock
> > disabled and belgian keyboard layout, e.g. KEY_1 =3D> '&' unless sh=
ift
> > is down)
> >=20
> > KEY_NUMERIC_0..KEY_NUMERIC_9 are not recognized by Linux console
> > (don't know if/how userspace understands them)
>=20
> Are they incorporated in the keymap you have loaded?

Probably not though I have not checked (using be-latin1 from
sys-apps/kbd-1.13-r1, Gentoo) Possibly this kbd version is too old to
know about those keys.

> > +	// set_bit(EV_REP, hi->input->evbit);
>=20
> Why is this commented out?

That was a remaining line from basing on hid-gyration.c
Don't know what it does, looks like related to key repeating but I've
not read enough of HID/Input code to find out. (all my tests were run
with it commented out, so I will drop it unless there is a good reason
to uncomment it)

> Otherwise the patch looks good, so if you send it with proper=20
> Signed-off-by line, I am OK with merging it.

Will do, using KEY_NUMERIC_*.

> Do you have any idea whether lirc folks have plans to integrate
> support for this device to lirc eventually?

I don't know


With my patch it seems the mappings don't show up for EVIOCGKEYCODE:

int codes[2];
for (codes[0] =3D 0; codes[0] < 1024; codes[0]++)
  if (ioctl(evdev, EVIOCGKEYCODE, codes) >=3D 0) {
    // display
  } else
    break;

Code block above only displays for codes[0] =3D=3D 0:
 codes =3D { 0, 388 /* KEY_TEXT */ }

=46or all other values of codes[0] ioctl returns EINVAL.

Is this expected or should complete mapping table be returned
as it is for generic PS2 PC keyboard (if so, what changes does the
patch need for it)?

Bruno
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
