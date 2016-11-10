From: Paul Donohue <linux-kernel@PaulSD.com>
Subject: Re: [PATCH v4 1/3] Input: ALPS - Fix TrackStick support for SS5
 hardware
Date: Thu, 10 Nov 2016 09:17:21 -0500
Message-ID: <20161110141721.GS2927@TopQuark.net>
References: <20161024210122.GA2919@TopQuark.net>
 <20161108151430.GN2927@TopQuark.net>
 <20161109121231.GB19557@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
Received: from Lepton.TopQuark.net ([168.235.66.66]:51966 "EHLO
        Mail2.TopQuark.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932845AbcKJORY (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 10 Nov 2016 09:17:24 -0500
Content-Disposition: inline
In-Reply-To: <20161109121231.GB19557@pali>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: linux-input@vger.kernel.org, Ben Gamari <ben@smart-cactus.org>, Michal Hocko <mhocko@suse.com>

On Wed, Nov 09, 2016 at 01:12:31PM +0100, Pali Roh=E1r wrote:
> On Tuesday 08 November 2016 10:14:30 Paul Donohue wrote:
> > --- a/drivers/input/mouse/alps.c
> > +++ b/drivers/input/mouse/alps.c
> > @@ -1346,6 +1346,18 @@ static void alps_process_packet_ss4_v2(struct =
psmouse *psmouse)
> > =20
> >  	priv->multi_packet =3D 0;
> > =20
> > +	/* Report trackstick */
> > +	if (alps_get_pkt_id_ss4_v2(packet) =3D=3D SS4_PACKET_ID_STICK) {
>=20
> I would propose to show warning when trackstick packet is received on
> device marked as non-trackstick. It would help to debug possible
> problems in future...
>=20
> if (!(priv->flags & ALPS_DUALPOINT))
>         psmouse_warn(psmouse, "Rejected trackstick packet from non Dual=
Point device");
For patch 1/3, the original alps_decode_ss4_v2() prints this warning,
so I don't think alps_process_packet_ss4_v2() needs to print it again.
Since this patch is a bug fix, I was trying to avoid any unnecessary
changes, and change just enough to fix the actual bug, so it is clear to
future readers what the bug was and how it was fixed.

In patch 2/3, I moved the warning from alps_decode_ss4_v2() to
alps_process_packet_ss4_v2(), since I agree it probably makes more sense
to print the warning in alps_process_packet_ss4_v2().  I also
removed the if statement from alps_decode_ss4_v2() entirely because
alps_decode_ss4_v2() decodes the trackstick buttons even in cases where
the trackstick packet is going to be rejected, and I thought it was a
bit confusing that alps_decode_ss4_v2() does not also decode the
trackstick movements even in cases where the trackstick packet is going
to be rejected (either they should both be decoded, or neither should be
decoded, and decoding both rather than skipping both requires less
logic).
