From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH V2] input synaptics-rmi4: Reorder declarations in
 rmi_bus.c
Date: Mon, 9 Dec 2013 22:46:25 -0800
Message-ID: <20131210064624.GE12524@core.coreip.homeip.net>
References: <1386289756-12429-1-git-send-email-cheiny@synaptics.com>
 <52A624A2.5000405@redhat.com>
 <20131210063914.GD12524@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:53098 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750748Ab3LJGqb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 10 Dec 2013 01:46:31 -0500
Received: by mail-pd0-f170.google.com with SMTP id g10so6746798pdj.29
        for <linux-input@vger.kernel.org>; Mon, 09 Dec 2013 22:46:30 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20131210063914.GD12524@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Christopher Heiny <cheiny@synaptics.com>, Linux Input <linux-input@vger.kernel.org>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Jean Delvare <khali@linux-fr.org>, Joerie de Gram <j.de.gram@gmail.com>, Linus Walleij <linus.walleij@stericsson.com>

On Mon, Dec 09, 2013 at 10:39:14PM -0800, Dmitry Torokhov wrote:
> On Mon, Dec 09, 2013 at 03:14:26PM -0500, Benjamin Tissoires wrote:
> > Hi Chris,
> >=20
> > On 05/12/13 19:29, Christopher Heiny wrote:
> > > This patch implements changes to the synaptics-rmi4 branch of
> > > Dmitry's input tree.  The base for the patch is commit
> > > 8ca01dc61a42b6f7bcba052a8c084000f7057a34.
> > >=20
> > > This patch primarily reorders the various declarations in rmi_bus=
=2Ec in order to
> > > group related elements together, along with some typo fixes.  The=
 code is still
> > > horribly broken, but this change should make the following fixes =
easier to
> > >  review.
> > >=20
> > > Signed-off-by: Christopher Heiny <cheiny@synaptics.com>
> > > Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > Cc: Jean Delvare <khali@linux-fr.org>
> > > Cc: Linus Walleij <linus.walleij@stericsson.com>
> > > Cc: Joerie de Gram <j.de.gram@gmail.com>
> > > Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > >=20
> > > ---
> >=20
> > FWIW, I made a review of the patch.
> > The patches does not only reorder the functions, but also fix some =
few
> > things I will detail later (plus fixes of whitespace/comments issue=
s).
> > It also changes the exported functions as GPL.
> >=20
> > Dmitry, given the current state of the driver (which does not work =
at
> > all if I understood correctly), maybe you can pick this one in its
> > current state.
>=20
> Applied, thank you.

Well, I had to pull up rmi_debugfs_root declaration to avoid:

  CC [M]  drivers/input/rmi4/rmi_driver.o
drivers/input/rmi4/rmi_bus.c: In function =E2=80=98rmi_physical_setup_d=
ebugfs=E2=80=99:
drivers/input/rmi4/rmi_bus.c:51:10: error: =E2=80=98rmi_debugfs_root=E2=
=80=99 undeclared
(first use in this function)
          rmi_debugfs_root);

Guys, a bit better compile coverage would be appreciated.

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
