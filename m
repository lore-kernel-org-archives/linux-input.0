From: Paul Donohue <linux-kernel@PaulSD.com>
Subject: Re: [PATCH v4 2/3] Input: ALPS - Clean up TrackStick handling for
 SS5 hardware
Date: Thu, 10 Nov 2016 09:27:39 -0500
Message-ID: <20161110142739.GT2927@TopQuark.net>
References: <20161024210122.GA2919@TopQuark.net>
 <20161108151430.GN2927@TopQuark.net>
 <20161108151621.GO2927@TopQuark.net>
 <20161109121443.GC19557@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
Received: from Lepton.TopQuark.net ([168.235.66.66]:60874 "EHLO
        Mail2.TopQuark.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932845AbcKJO1l (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 10 Nov 2016 09:27:41 -0500
Content-Disposition: inline
In-Reply-To: <20161109121443.GC19557@pali>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: linux-input@vger.kernel.org, Ben Gamari <ben@smart-cactus.org>, Michal Hocko <mhocko@suse.com>

On Wed, Nov 09, 2016 at 01:14:43PM +0100, Pali Roh=E1r wrote:
> On Tuesday 08 November 2016 10:16:21 Paul Donohue wrote:
> > --- a/drivers/input/mouse/alps.c
> > +++ b/drivers/input/mouse/alps.c
> > @@ -1267,18 +1267,11 @@ static int alps_decode_ss4_v2(struct alps_fie=
lds *f,
> >  	case SS4_PACKET_ID_STICK:
> > +		f->st.x =3D (s8)(((p[0] & 1) << 7) | (p[1] & 0x7f));
> > +		f->st.y =3D -(s8)(((p[3] & 1) << 7) | (p[2] & 0x7f));
> > +		f->pressure =3D (s8)(p[4] & 0x7f);
>=20
> This is not correct. Those fields values are used for single touch
> events from touchpad -- not from trackstick.
>=20
> Btw, you have access to packet also in process functions, so you can
> extract x, y and pressure in process function too.

I was trying to keep all of the decoding logic in alps_decode_ss4_v2().
And since there aren't any fields specifically for the trackstick in
alps_fields, I figured the single touch fields would be an appropriate
place to stash those coordinates.

But if you would prefer to move some of the trackstick decoding logic to
alps_process_packet_ss4_v2(), I can do that.
