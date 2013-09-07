From: Bastien Nocera <hadess@hadess.net>
Subject: Re: Game Controllers
Date: Sat, 07 Sep 2013 14:01:07 -0300
Message-ID: <1378573267.1499.3.camel@sirocco>
References: <2483279.JlnWrOX8Uv@dtor-d630.eng.vmware.com>
	 <CAFmpkyiS+L6OsGmobjHqqJ8AFNNiDk4DYYFo_1GQx2kV_dam1Q@mail.gmail.com>
	 <20130502083547.279d08a3cbd7a115489de4b7@studenti.unina.it>
	 <CAFmpkygZ+xvpwp9KQr6O4emk2f1Bn0EBS0WeN1ji0qVUJz2rwA@mail.gmail.com>
	 <20130502170103.GC28625@core.coreip.homeip.net>
	 <CAFmpkygr5c-munK9ix=exq4KRgDEUbP+OP_AABuuTR1P_2V1-g@mail.gmail.com>
	 <CANq1E4RRFNPZ-z86yny89hViMWREpG1f1in5O3kT8usHO57YAQ@mail.gmail.com>
	 <CAFmpkygadXbwtyD0Pcc_K4EPqsqRq0EudX=ge6KFoaykR4CHVA@mail.gmail.com>
	 <20130502204503.GF28625@core.coreip.homeip.net>
	 <CAFmpkyhhCyFU=MsjD+=7fPmmWNinGZ9GzfHUfn0fJqivWWPV4A@mail.gmail.com>
	 <20130503155000.GA5567@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from slow1-d.mail.gandi.net ([217.70.178.86]:53934 "EHLO
	slow1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750802Ab3IGRCc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 7 Sep 2013 13:02:32 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	by slow1-d.mail.gandi.net (Postfix) with ESMTP id E3A2A47A081
	for <linux-input@vger.kernel.org>; Sat,  7 Sep 2013 19:01:37 +0200 (CEST)
In-Reply-To: <20130503155000.GA5567@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Todd Showalter <todd@electronjump.com>, David Herrmann <dh.herrmann@gmail.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>

Em Fri, 2013-05-03 =C3=A0s 08:50 -0700, Dmitry Torokhov escreveu:
> On Thu, May 02, 2013 at 05:10:42PM -0400, Todd Showalter wrote:
> > On Thu, May 2, 2013 at 4:45 PM, Dmitry Torokhov
> > <dmitry.torokhov@gmail.com> wrote:
> >=20
> > > Again, the kernel will try to do the right thing and produce the =
correct
> > > events for new input devices, but we are not going to introduce a=
 copy
> > > of evdev protocol that limits the events to "standard gamepad" on=
es.
> >=20
> >     Ok.  I can see there's no point arguing this.  What can I do to=
 at
> > least make sure future devices behave?  Is there anything that can =
be
> > done about current devices other than translate in userspace?
>=20
> Please post the patches for discussion and keep en eye on changes goi=
ng
> into drivers/input/joystick and drivers/hid as you have a vested
> interest of everyone getting it right.
>=20
> I am not sure about status of PS3 controller, I think Bastien was
> working on supporting it from userspace?

Antonio Ospite has patches against bluez5 to make it work[1], though
some more work is definitely needed. Benjamin Tissoires has a test
device now, so between them, they should be able to get it running
again.

Cheers

[1]: http://pkgs.fedoraproject.org/cgit/bluez.git/tree/playstation-peri=
pheral-pugin-v5.x.patch

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
