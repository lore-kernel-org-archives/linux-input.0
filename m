From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [2/2] input: wacom - Pass touch resolution to clients through
 input_absinfo
Date: Mon, 24 Jan 2011 10:36:56 -0800
Message-ID: <20110124183656.GC17855@core.coreip.homeip.net>
References: <1295825201-12567-1-git-send-email-pinglinux@gmail.com>
 <20110124144017.GA4367@polaris.bitmath.org>
 <AANLkTim39y5ZNdzvZ2=sO+sccpUMao3pqxyiv5VW9Ckv@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:38910 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753492Ab1AXShE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 24 Jan 2011 13:37:04 -0500
Received: by vws16 with SMTP id 16so1952436vws.19
        for <linux-input@vger.kernel.org>; Mon, 24 Jan 2011 10:37:03 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTim39y5ZNdzvZ2=sO+sccpUMao3pqxyiv5VW9Ckv@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org, Ping Cheng <pingc@wacom.com>

On Mon, Jan 24, 2011 at 10:18:54AM -0800, Ping Cheng wrote:
> On Mon, Jan 24, 2011 at 6:40 AM, Henrik Rydberg <rydberg@euromail.se>=
 wrote:
> > Hi Ping,
> >
> >> @@ -1228,8 +1228,13 @@ void wacom_setup_input_capabilities(struct =
input_dev *input_dev,
> >> =A0 =A0 =A0 case TABLETPC:
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (features->device_type =3D=3D BTN_T=
OOL_DOUBLETAP ||
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->device_type =3D=3D B=
TN_TOOL_TRIPLETAP) {
> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_set_abs_params(inp=
ut_dev, ABS_RX, 0, features->x_phy, 0, 0);
> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_set_abs_params(inp=
ut_dev, ABS_RY, 0, features->y_phy, 0, 0);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* set touch resolution =
in points/mm */
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 res =3D features->x_phy/=
100;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_abs_set_res(input_=
dev, ABS_X,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 features->x_max/res);
> >
> > It seems to me the construction above looses precision twice for no
> > apparent reason.
>=20
> Well, there was a reason (logically instead of mathematically though)=
:
> features->x_phy/100 gives us the physical size of the touch area in
> mm.
>=20
> > How about instead use "100 * features->x_max /
> > features->x_phy"?
>=20
> Sure.
>=20
> > Besides, it is a bit unfortunate that "res" is short
> > for both result and resolution.
>=20
> Resolution is defined as __s32 in input_absinfo. How about we use __s=
32 then?

input_abs_set_res() takes and int argument so keep it int  (or just
embed the expression into the call and forgo 'res').

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
