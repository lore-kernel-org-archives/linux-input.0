From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: Regression since commit 92bac83
Date: Tue, 20 Oct 2015 09:22:23 +0200
Message-ID: <20151020072223.GC22600@pali>
References: <5624327B.7080906@lwfinger.net>
 <5624A503.7090609@redhat.com>
 <56251268.2060203@lwfinger.net>
 <20151019165128.GB7006@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:38794 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752245AbbJTHW0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 20 Oct 2015 03:22:26 -0400
Content-Disposition: inline
In-Reply-To: <20151019165128.GB7006@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Larry Finger <Larry.Finger@lwfinger.net>, Hans de Goede <hdegoede@redhat.com>, Masaki Ota <masaki.ota@jp.alps.com>, linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On Monday 19 October 2015 09:51:28 Dmitry Torokhov wrote:
> On Mon, Oct 19, 2015 at 10:55:20AM -0500, Larry Finger wrote:
> > On 10/19/2015 03:08 AM, Hans de Goede wrote:
> > >Hi,
> > >
> > >On 19-10-15 01:59, Larry Finger wrote:
> > >>Hi,
> > >>
> > >>I recently upgraded the kernel in a Dell Latitude D600 and found =
that the
> > >>touchpad clicks failed. The problem was bisected to commit
> > >>92bac83dd79e60e65c475222e41a992a70434beb ("Input: alps - non inte=
rleaved V2
> > >>dualpoint has separate stick button bits"). The laptop has a comb=
ination
> > >>touchpad and control stick. For this device, the following values=
 are found:
> > >>
> > >>priv->protoversion is 0x200 (ALPS_PROTO_V2)
> > >>priv->flags is 0x6 (ALPS_DUALPOINT | ALPS_PASS)
> > >>
> > >>As a result, the new code added in this patch is executed, and le=
ft, right,
> > >>and middle are updated. Once this code is introduced, a left clic=
k causes some
> > >>event as it will wake a sleeping screen, but not select any windo=
ws or do
> > >>anything useful.
> > >>
> > >>Please advise on what information would be needed to help debug t=
his problem.
> > >
> > >Can you build a recent upstream kernel from source, and when build=
ing it
> > >comment out these lines in drivers/input/mouse/alps.c, around line=
s 2555 - 2556
> > >
> > >         if (dmi_name_in_vendors("Dell"))
> > >                 priv->flags |=3D ALPS_DELL;
> > >
> > >That should fix things, if that fixes things we need to rename the=
 flag
> > >and move to a list of dmi-matched models (rather then vendor) wher=
e the new
> > >behavior
> > >introduced by the patch causing you problems is actually necessary=
=2E
> > >
> > >Step 1 is confirming that not setting the flag fixes things for yo=
u,
> > >if you can get back to us confirming that, then I'll whip up a pat=
ch
> > >to switch to model matching (which is not ideal, but seems to be
> > >necessary).
> >=20
> > Thanks for the quick response. Removing the two lines mentioned
> > above restored correct touchpad operation with kernel 4.2.0. It
> > seems that the Latitude D600 is different than other Dell models.
>=20
> I wonder if we should not revert all these patches splitting what onc=
e
> was one relative input device into separate trackstick/external mouse=
=2E
> They seem to cause a lot of troubles for little benefit. Pali?
>=20
> Thanks.
>=20

Hi Dmitry! I think that this bug is not related to my separation
patches, but rather to approach which is trying to fix some obscure bug
on some Dell machines...

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
