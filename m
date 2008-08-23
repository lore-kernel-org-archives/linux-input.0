From: Thomas Reitmayr <treitmayr@devbase.at>
Subject: Re: Usage of new KEY_NUMERIC_* codes in an existing driver
	(yealink)
Date: Sat, 23 Aug 2008 14:39:16 +0200
Message-ID: <1219495156.6680.4.camel@localhost>
References: <1219424488.6684.20.camel@localhost>
	 <20080822155829.ZZRA012@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtpgw01.world4you.com ([80.243.163.21]:57924 "EHLO
	smtpgw01.world4you.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751057AbYHWMj2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 23 Aug 2008 08:39:28 -0400
In-Reply-To: <20080822155829.ZZRA012@mailhub.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux-Input <linux-input@vger.kernel.org>

=EF=BB=BFThanks =EF=BB=BFDmitry,
I will take a look at the cm109 driver to see how setkeycode/getkeycode
support is implemented and how this fits into the yealink code.
As soon as I have done that (and cleaned up a few things) I will post
the code as a patch.
Best regards,
-Thomas


Am Freitag, den 22.08.2008, 16:02 -0400 schrieb Dmitry Torokhov:
> Hi Thomas,
>=20
> On Fri, Aug 22, 2008 at 07:01:28PM +0200, Thomas Reitmayr wrote:
> > Hi,
> > I am in the process of extending the existing yealink driver, partl=
y to
> > support various other models. The existing driver as included in th=
e
> > current kernel uses the shift key to report the keys "*" and "#", b=
ut I
> > am hesitating to do the same bad "trick" for the other models.
> >=20
> > As I would like to eventually submit the extended driver upstream, =
what
> > is the recommended strategy in my situation regarding usage of the =
new
> > KEY_NUMERIC_* codes? Use them only for the new models (which would
> > result in an ugly mix), or also update the codes for the existing
> > USB-P1K model (which would break userspace programs but finally fix
> > things for some foreign keyboard layouts),=20
>=20
> Do you think that we need to add more keymaps to the kernel? What I
> woudl like to see is adding setkeycode/getkeycode support to yealink
> so proper keymap can be loaded from userspace (udev, hal, whatever)
> when a device is plugged into a box. USB-P1K coudl also get the new
> keymap loaded from userspace while keeping the current legacy keymap
> for existing users.
>=20
> >or for the existing USB-P1K
> > model report the old and the new codes (which might look like two k=
ey
> > presses)?
>=20
> No, that is not a good idea.
>=20
> > Thanks for your advice,
> > -Thomas
> >=20
> > PS: The updated driver is available at
> > http://www.devbase.at/svn/view.cgi/yealink-module/trunk/?root=3Dvoi=
p
> > (still including #if's reg. kernel versions, some comments to be
> > corrected, etc.)
> >=20
>=20
> Would you mind posting it as a patch - it is much easier to comment o=
n
> it in e-mail... Thanks!
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
