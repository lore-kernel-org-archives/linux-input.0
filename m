From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2 v3] elantech: Report multitouch with proper ABS_MT
 messages
Date: Mon, 10 May 2010 17:11:21 -0700
Message-ID: <20100511001121.GB21081@core.coreip.homeip.net>
References: <4BE593AA.6040408@tudelft.nl>
 <4BE86886.2080909@tudelft.nl>
 <4BE8725D.1060703@euromail.se>
 <4BE8886D.4040302@tudelft.nl>
 <4BE89DB3.1050206@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:38852 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932327Ab0EKAL1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 10 May 2010 20:11:27 -0400
Received: by pwi5 with SMTP id 5so1928390pwi.19
        for <linux-input@vger.kernel.org>; Mon, 10 May 2010 17:11:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4BE89DB3.1050206@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: =?iso-8859-1?Q?=C9ric?= Piel <E.A.B.Piel@tudelft.nl>, Florian Ragwitz <rafl@debian.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Tue, May 11, 2010 at 01:58:43AM +0200, Henrik Rydberg wrote:
> =C9ric Piel wrote:
> > Op 10-05-10 22:53, Henrik Rydberg schreef:
> >> Hi again =C9ric,
> >>
> >> thanks for your changes, the first patch looks better now. However=
, both patches
> >> still have style problems. Also, the second patch now makes unrela=
ted changes to
> >> the ABS_X etc, so it is difficult to even know what was tested, an=
d whether the
> >> first patch really works as claimed.
> > What are the style problems of the first patch? I tried to fix all =
of them.
>=20
> WARNING: line over 80 characters
> #212: FILE: drivers/input/mouse/elantech.c:483:
> +		input_set_abs_params(dev, ABS_TOOL_WIDTH, ETP_WMIN_V2, ETP_WMAX_V2=
, 0, 0);
>=20
> WARNING: line over 80 characters
> #119: FILE: drivers/input/mouse/elantech.c:498:
> +		input_set_abs_params(dev, ABS_MT_POSITION_X, ETP_XMIN_V2, ETP_XMAX=
_V2, 0, 0);
>=20
> WARNING: line over 80 characters
> #120: FILE: drivers/input/mouse/elantech.c:499:
> +		input_set_abs_params(dev, ABS_MT_POSITION_Y, ETP_YMIN_V2, ETP_YMAX=
_V2, 0, 0);
>=20

Do not worry about the 80 char limit that much, especially if it
produces less readable code due to wierd line splits. The code above
could be broken cleanly, but it's not a big deal.

The rest of the checkpatch warnirngs (if any) I prefer to have
addressed though.

> >=20
> > Concerning the second patch, it's necessary to change the lines wit=
h
> > ABS_X, because otherwise the computation would be duplicated for th=
e MT
> > part and it would make everything look more complicated. Honestly, =
I
> > think this change is still very limited and can easily be reviewed =
for
> > not changing the semantic.
>=20
> Yes, you are right about x1 and y1. The patch patch touches the width=
 variable
> for no apparent reason, and I stopped reading there.
>=20
> If this process seems trivial and tedious to you, consider how it mus=
t appear to
> those who deal with patches every day. Most people will not even look=
 at a patch
> with style problems, so the real review _starts_ when those issues ar=
e fixed.
>=20
> Henrik

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
