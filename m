From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 3/4] input: wacom - Add support for Bamboo Pen
Date: Thu, 9 Sep 2010 14:46:30 -0700
Message-ID: <20100909214630.GA29485@core.coreip.homeip.net>
References: <1284004952-12701-1-git-send-email-chris@cnpbagwell.com>
 <1284004952-12701-4-git-send-email-chris@cnpbagwell.com>
 <20100909041422.GA11747@core.coreip.homeip.net>
 <AANLkTikSPnNvUehFi4g=WN6QNnJZ2Y0Rz_fdq=jgCxeh@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:62159 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753792Ab0IIVqj (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 9 Sep 2010 17:46:39 -0400
Received: by pvg2 with SMTP id 2so690702pvg.19
        for <linux-input@vger.kernel.org>; Thu, 09 Sep 2010 14:46:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTikSPnNvUehFi4g=WN6QNnJZ2Y0Rz_fdq=jgCxeh@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chris Bagwell <chris@cnpbagwell.com>
Cc: linux-input@vger.kernel.org, pingc@wacom.com

On Thu, Sep 09, 2010 at 04:34:35PM -0500, Chris Bagwell wrote:
> On Wed, Sep 8, 2010 at 11:14 PM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > On Wed, Sep 08, 2010 at 11:02:31PM -0500, chris@cnpbagwell.com wrot=
e:
> >> From: Chris Bagwell <chris@cnpbagwell.com>
> >>
> >> This adds support for Pen on Bamboo Pen and Bamboo Pen&Touch
> >> devices. =A0Touchpad is handled by previous Bamboo Touch
> >> logic.
> >>
> >> Signed-off-by: Chris Bagwell <chris@cnpbagwell.com>
> >> ---
> >> =A0drivers/input/tablet/wacom_wac.c | =A0 75 +++++++++++++++++++++=
+++++++++++++++++
> >> =A01 files changed, 75 insertions(+), 0 deletions(-)
> >>
> >> diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tabl=
et/wacom_wac.c
> >> index 2f7ed9a..9cc0cf0 100644
> >> --- a/drivers/input/tablet/wacom_wac.c
> >> +++ b/drivers/input/tablet/wacom_wac.c
> >> @@ -904,10 +904,71 @@ static int wacom_bpt_touch(struct wacom_wac =
*wacom)
> >> =A0 =A0 =A0 return 0;
> >> =A0}
> >>
> >> +static int wacom_bpt_pen(struct wacom_wac *wacom)
> >> +{
> >> + =A0 =A0 struct input_dev *input =3D wacom->input;
> >> + =A0 =A0 unsigned char *data =3D wacom->data;
> >> + =A0 =A0 int prox =3D 0, x =3D 0, y =3D 0, p =3D 0, d =3D 0, pen =
=3D 0, btn1 =3D 0, btn2 =3D 0;
> >> +
> >> + =A0 =A0 prox =3D (data[1] & 0x10) && (data[1] & 0x20);
> >
> > =A0 =A0 =A0 =A0prox =3D (data[1] & 0x30) =3D=3D 0x30;
> >
> > ?
> >
> > --
> > Dmitry
> >
>=20
>=20
> Agree thats faster to understand.  I'll update patch and resend soon.
>=20

I am just curious - why is it that _both_ bits should be set for the to=
ols
to be considered "in proximity"?..

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
