From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2]input - wacom_w8001: Add one finger touch support
Date: Thu, 9 Dec 2010 11:50:35 -0800
Message-ID: <20101209195035.GD23781@core.coreip.homeip.net>
References: <1291857829-13804-1-git-send-email-pinglinux@gmail.com>
 <AANLkTikatcsta_EQ26CzouHj+WMfQptJF_ZkMfCwUmnN@mail.gmail.com>
 <AANLkTi=w3uOQKFN3WBgzib9M0Cb143vChPPaYm6fWypi@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:49001 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753920Ab0LITup (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 9 Dec 2010 14:50:45 -0500
Received: by qyj19 with SMTP id 19so137341qyj.19
        for <linux-input@vger.kernel.org>; Thu, 09 Dec 2010 11:50:44 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTi=w3uOQKFN3WBgzib9M0Cb143vChPPaYm6fWypi@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: Chris Bagwell <chris@cnpbagwell.com>, linux-input@vger.kernel.org

On Thu, Dec 09, 2010 at 11:36:19AM -0800, Ping Cheng wrote:
> On Thu, Dec 9, 2010 at 7:06 AM, Chris Bagwell <chris@cnpbagwell.com> =
wrote:
> > On Wed, Dec 8, 2010 at 7:23 PM, Ping Cheng <pinglinux@gmail.com> wr=
ote:
> >> @@ -228,9 +277,17 @@ static irqreturn_t w8001_interrupt(struct ser=
io *serio,
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (tmp =3D=3D W8001_TOUCH_BYTE)
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> >>
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (w8001->has_touch) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* send touch data o=
ut */
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 w8001->has_touch =3D=
 0;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(dev=
, BTN_TOUCH, 0);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(dev=
, BTN_TOOL_FINGER, 0);
> >
> > Probably its better to set ABS_X/ABS_Y to zero and do a sync here? =
=A0So
> > duplicate x/y values don't get dropped and aligns with wacom_wac.c.
> > This is related to comment about forcing ABS_X/Y to zero above. =A0=
Its
> > so pen has known starting point when coming in proximity. =A0I woul=
dn't
> > do one without the other.
>=20
> I'll do both to make you happy (just kidding, to make it safe ;).
>=20

Actually do not see how (0,0) is any safer than let's say (123,78)
sincve i believe (0,0) is a valid coordinate. Userspace should still
hang on to the last reported coordinate and use it if it did not get
a new one.

Also, if you add input_sync() here won't it cause (in certain
situtations) false click or tap events - BTN_TOUCH goes from 1 to 0 and
then again to 1 if pen is already in proximity...

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
