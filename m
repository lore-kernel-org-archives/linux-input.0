From: Alexey Charkov <alchark@gmail.com>
Subject: Re: [PATCH 3/6] input: Add support for VIA VT8500 and compatibles in i8042
Date: Thu, 21 Oct 2010 01:24:56 +0400
Message-ID: <AANLkTi=mCjbovNcF7-c-BQ-QDxZ+=y3r+7XCDGiJLKyW@mail.gmail.com>
References: <1287608139-21354-1-git-send-email-alchark@gmail.com>
	<1287608139-21354-3-git-send-email-alchark@gmail.com>
	<201010201415.09535.dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:61131 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751779Ab0JTVY6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 20 Oct 2010 17:24:58 -0400
In-Reply-To: <201010201415.09535.dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: vt8500-wm8505-linux-kernel@googlegroups.com, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

2010/10/21 Dmitry Torokhov <dmitry.torokhov@gmail.com>
>
> On Wednesday, October 20, 2010 01:55:35 pm Alexey Charkov wrote:
> > VIA and WonderMedia Systems-on-Chip feature a standard i8042-compat=
ible
> > keyboard and mouse controller. This adds necessary glue to enable u=
se
> > of the standard driver with these systems.
> >
> > Signed-off-by: Alexey Charkov <alchark@gmail.com>
> > ---
> >
> > Please review and state whether this could be acceptable for a merg=
e
> > to mainline in the coming 2.6.37 window. If possible, I would deepl=
y
> > appreciate a merge to a relevant git tree for integration prior to
> > asking Linus to pull the changes. I could rebase the code if needed=
,
> > currently this is against Linus' master branch.
> >
> > This patch relies on the basic architecture support for VT8500/WM85=
05
> > to be in place, as introduced by PATCH 1/6 in this series.
>
> What tree this code will be coming through through?
>

Should be Russel King's ARM tree, probably. The whole series is CC'd
to linux-arm-kernel and to the relevant subsystems maintainers, as I
was instructed to do at a previous submission attempt.

> > +
> > +static inline int i8042_platform_init(void)
> > +{
> > + =C2=A0 =C2=A0 i8042_reset =3D 1;
>
> =3D true; - it's a boolean.
>

Got it, thanks.

> > + =C2=A0 =C2=A0 regbase =3D ioremap(VT8500_PS2_BASE, SZ_1K);
>
> Error handling?
>

Ok, I've missed this. Will be fixed.

> Thanks.
>
> --
> Dmitry

Thanks for your review, Dmitry! Are there any other issues with this
or is it otherwise good enough to receive your Ack?
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
