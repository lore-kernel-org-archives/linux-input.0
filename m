From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH] HID: appleir: add support for Apple ir devices
Date: Wed, 10 Apr 2013 13:25:53 +0200
Message-ID: <1365593153.30420.1.camel@novo>
References: <1365438651-32623-1-git-send-email-benjamin.tissoires@redhat.com>
	 <alpine.LNX.2.00.1304092155330.17280@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:46294 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762484Ab3DJLZ6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 10 Apr 2013 07:25:58 -0400
In-Reply-To: <alpine.LNX.2.00.1304092155330.17280@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Fabien <fabien.andre@gmail.com>, Jarod Wilson <jarod@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 2013-04-09 at 22:10 +0200, Jiri Kosina wrote:
> On Mon, 8 Apr 2013, Benjamin Tissoires wrote:
>=20
> > This driver was originally written by James McKenzie, updated by
> > Greg Kroah-Hartman, further updated by Bastien Nocera, with suspend
> > support added.
> > I ported it to the HID subsystem, in order to simplify it a litle
> > and allow lirc to use it through hiddev.
> >=20
> > More recent versions of the IR receiver are also supported through
> > a patch by Alex Karpenko. The patch also adds support for the 2nd
> > and 5th generation of the controller, and the menu key on newer
> > brushed metal remotes.
> >=20
> > Tested-by: Fabien Andr=E9 <fabien.andre@gmail.com>
> > Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > ---
> > Hi guys,
> >=20
> > this is the re-spin of Bastien's patch submitted last november.
> > I ported it to use the hid subsystem, reducing the size of the driv=
er
> > to 355 lines instead of 527.
>=20
> Thanks. Generally, I like the idea of appleir being on the hid bus.
>=20
> Bastien, could you please provide your Ack (and most importantly also=
=20
> Tested-by?).

At a glance, the patch looks good to me, but I don't have access to
hardware to test this (unsurprisingly given that my original patch is a=
t
least 2 years old).

Cheers


--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
