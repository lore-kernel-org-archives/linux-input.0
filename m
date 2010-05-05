From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] elantech: Report multitouch with proper ABS_MT
 messages
Date: Wed, 5 May 2010 10:15:40 -0700
Message-ID: <20100505171540.GF7337@core.coreip.homeip.net>
References: <4BE1629E.50901@tudelft.nl>
 <20100505163832.GA7337@core.coreip.homeip.net>
 <4BE1A591.3020201@tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f46.google.com ([74.125.82.46]:54442 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750980Ab0EERPu (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 5 May 2010 13:15:50 -0400
Received: by wwb34 with SMTP id 34so22754wwb.19
        for <linux-input@vger.kernel.org>; Wed, 05 May 2010 10:15:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4BE1A591.3020201@tudelft.nl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?iso-8859-1?Q?=C9ric?= Piel <E.A.B.Piel@tudelft.nl>
Cc: Florian Ragwitz <rafl@debian.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Henrik Rydberg <rydberg@euromail.se>

On Wed, May 05, 2010 at 07:06:25PM +0200, =C9ric Piel wrote:
> Op 05-05-10 18:38, Dmitry Torokhov schreef:
> > Hi Eric,
> >=20
> > On Wed, May 05, 2010 at 02:20:46PM +0200, =C9ric Piel wrote:
> >>
> :
> >> =20
> >>  	/* byte 0: n1  n0   .   .   .   .   R   L */
> >>  	fingers =3D (packet[0] & 0xc0) >> 6;
> >> -	input_report_key(dev, BTN_TOUCH, fingers !=3D 0);
> >=20
> > Mousedev works a tad better if BTN_TOUCH is reported first. Otherwi=
se
> > looks good.
> I moved it there because somehow I had understood in the
> multi-touch-protocol that all the old events had to be reported after
> the last SYNC_MT. That said, I don't recall any influence on the
> synaptics nor multitouch X drivers. Maybe it matters just for the ABS=
_*
> events?

I was talking about mousedev - the in-kernel mouse emulation.

I do not believe the order of events shoudl matter for userspace, which
should collect all data until it receives EV_SYN/SYN_REPORT and then ac=
t
upon the collected data.

>=20
> >=20
> > Henrik, should we report "tool width" as ABS_MT_WIDTH_MAJOR?
> >=20
> > Eric, we don't have the "width" for the 2nd point of contact, do we=
?
> I looked a bit at the values generated when there are two touches, an=
d
> couldn't any changing when I was varying the pressure.
>=20
> > Where is the proprietary driver BTW? Do we even care? I'd probably =
get
> > rid of HAT abuse if our standard tools provide good user experience=
=2E
> Actually I had never heard of a proprietary driver before reading the
> code ;-) Maybe Florian knows?
>=20
> Eric
>=20

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
