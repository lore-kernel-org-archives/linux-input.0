From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: [PATCH] input: Add support for the Bamboo Touch trackpad
Date: Tue, 31 Aug 2010 15:44:37 +1000
Message-ID: <20100831054437.GA14760@barra.redhat.com>
References: <1282486241-8855-1-git-send-email-rydberg@euromail.se>
 <AANLkTikvQdxzRm_rWHHz=m4=fpRSTZbMJhVUji2KVmKA@mail.gmail.com>
 <4C7B7595.6060904@euromail.se>
 <AANLkTikh6r+-aeiqT7nq3Z4jL+WZK22G4zVeUwQFLfr1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from leo.clearchain.com ([199.73.29.74]:14630 "EHLO
	mail.clearchain.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751919Ab0HaFn7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 31 Aug 2010 01:43:59 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTikh6r+-aeiqT7nq3Z4jL+WZK22G4zVeUwQFLfr1@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chris Bagwell <chris@cnpbagwell.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ping Cheng <pingc@wacom.com>, linux-input@vger.kernel.org

On Mon, Aug 30, 2010 at 11:19:49AM -0500, Chris Bagwell wrote:
> Hi Henrik,
>=20
> On Mon, Aug 30, 2010 at 4:10 AM, Henrik Rydberg <rydberg@euromail.se>=
 wrote:
> > Hi Chris,
> >
> >>> 1) It uses the MT slot protocol
> >>> 2) It creates two input devices, but only one is useful
> >>
> >> No biggy to userspace. =A0I'm assuming for unused input device tha=
t
> >> hardware is still reporting a HID_USAGE_STYLUS and probably you co=
uld
> >> catch that and not register that input device.
> >
> >
> > The initial idea was to only use the trackpad usb endnode, but the =
device does
> > not work at all after boot unless the silent endnode is somehow tak=
en into
> > account. I am not sure what your statement refers to.
> >
> >>> 3) It works well with the synaptics and multitouch X drivers
> >>> 4) It does not work well with the wacom X driver (!)
> >>
> >> Once we finalize input events sent, I'm sure we could get
> >> xf86-input-wacom to play nice with this synaptic-style input event=
s.
> >> The harder part is to develop userspace rules to assign this "waco=
m"
> >> input device to something other than xf86-input-wacom; especially =
in
> >> case were tablet has pen and touch input devices.
> >
> >
> > Using udev rules, the pen device is picked up by the wacom X driver=
 and the
> > touch device is picked up by the synaptics X driver. It does not se=
em anything
> > extra is needed here.
>=20
> You mean your wacom touch device are being directed to synaptics X
> driver without modifications to udev or similar rules?  On my
> unmodified Fedora box, they both go to wacom X driver.
>=20
> Not that it would be a difficult modification... I'd just need to mak=
e
> those and work with distributions to also align.

50-wacom.conf sorts after 50-synaptics.conf and since we apply the waco=
m
driver to anything with Wacom in the product name, it overrides the
synaptics setting. not a big deal at all, just renaming it to 40-wacom.=
conf
should already do the job.

Cheers,
  Peter
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
