From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 0/6] elantech extend version support and add semi-mt
Date: Mon, 16 May 2011 22:44:32 -0700
Message-ID: <20110517054432.GA20428@core.coreip.homeip.net>
References: <4DCE24BE.70908@tudelft.nl>
 <20110516111552.GA10453@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:42000 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751736Ab1EQFoj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 17 May 2011 01:44:39 -0400
Received: by pwi15 with SMTP id 15so128725pwi.19
        for <linux-input@vger.kernel.org>; Mon, 16 May 2011 22:44:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110516111552.GA10453@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: =?iso-8859-1?Q?=C9ric?= Piel <E.A.B.Piel@tudelft.nl>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Chris Bagwell <chris@cnpbagwell.com>, Florian Ragwitz <rafl@debian.org>

On Mon, May 16, 2011 at 01:15:52PM +0200, Henrik Rydberg wrote:
> Hi =C9ric,
>=20
> > Here is an update of patches which I had sent quite a few monthes
> > ago. At this time they were a bit controversial because the hardwar=
e
> > reports only the minimum/maximum positions when two fingers are
> > pressed. With the "semi-mt" property from Henrik that should now be
> > well handled.
> >=20
> > The first few patches of this set should also add support for a few
> > more hardware versions. I could not test all the hardware versions
> > but it's based on the old Dell/Ubuntu driver and if it goes into
> > Linus's tree during the merge window I'm confident we can catch and
> > easily fix regressions :-)
>=20
> Excellent work, thank you so much. A couple of tiny tiny details:
>=20
> [patch 1]
>=20
> +In the wild, there appear to be more versions, such as 04.03.01, 04.=
04.11. There
> +appear to be almost no difference excepted the EF113 which do not re=
port
>=20
> no difference, except
>=20
> [patch 3]
>=20
> @@ -100,14 +100,22 @@ struct elantech_data {
>         unsigned char reg_26;
>         unsigned char debug;
>         unsigned char capabilities;
> -       bool paritycheck;
> +       unsigned char paritycheck;
>         bool jumpy_cursor;
> +       unsigned char reports_pres :1;
>         unsigned char hw_version;
>         unsigned int fw_version;
>         unsigned int single_finger_reports;
>         unsigned char parity[256];
>  };
>=20
> Any particular reason to use unsigned char instead of bool here, and =
to
> restrict report_pres to a single bit? Bool for both seems apt.
>=20
> Other than the above, which do not really need a resend, feel free to=
 add
>=20
>     Reviewed-by: Henrik Rydberg <rydberg@euromail.se>
>=20
> on all six patches. Thank you, =C9ric.
>=20

Eric,

Thank you for working on this. I applied patches 1 and 4-6; 3rd require=
d
some changes but since they were minor I retained Henrik's reviewed-by.

I am not happy with the protocol checks from Dell, I am not sure they
make much sense; so I dropped patch 3 for now and because of that patch
2 did not make much sense either. Actually patch 2 did not make sense o=
n
its own in any case as it should have been partially rolled into 3 and
partially into 4.

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
