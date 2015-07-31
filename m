From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Initialization of TPPS/2 IBM TrackPoint in too slow
Date: Fri, 31 Jul 2015 10:30:34 -0700
Message-ID: <20150731173034.GH5613@dtor-ws>
References: <201507311859.22045@pali>
 <20150731170849.GG5613@dtor-ws>
 <201507311917.02131@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:34506 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752110AbbGaRaj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 31 Jul 2015 13:30:39 -0400
Content-Disposition: inline
In-Reply-To: <201507311917.02131@pali>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Jul 31, 2015 at 07:17:02PM +0200, Pali Roh=E1r wrote:
> On Friday 31 July 2015 19:08:49 Dmitry Torokhov wrote:
> > On Fri, Jul 31, 2015 at 06:59:21PM +0200, Pali Roh=E1r wrote:
> > > Hello,
> > >=20
> > > here is output from dmesg for psmouse.ko
> > >=20
> > > [  266.378751] psmouse: calling psmouse_init()
> > > [  267.167150] psmouse serio1: synaptics: queried max coordinates=
:
> > > x [..5676], y [..4758] [  267.198416] psmouse serio1: synaptics:
> > > queried min coordinates: x [1266..], y [1096..] [  267.260402]
> > > psmouse serio1: synaptics: Touchpad model: 1, fw: 8.1, id:
> > > 0x1e2b1, caps: 0xf002a3/0x943300/0x12e800, board id: 3072, fw id:
> > > 2560
> > > [  267.260418] psmouse serio1: synaptics: serio: Synaptics
> > > pass-through port at isa0060/serio1/input0 [  267.299629] input:
> > > SynPS/2 Synaptics TouchPad as
> > > /devices/platform/i8042/serio1/input/input39 [  268.697333]
> > > psmouse serio4: cypress_ps2: send extension cmd 0x00, [0 0 0 0] [=
=20
> > > 269.259351] psmouse serio4: cypress_ps2: Command 0x00 response
> > > data (0x): 00 00 14 [  269.562762] psmouse serio4: alps: E6
> > > report: 00 00 64
> > > [  269.825915] psmouse serio4: alps: E7 report: 10 00 64
> > > [  270.086671] psmouse serio4: alps: EC report: 10 00 64
> > > [  270.125866] psmouse serio4: alps: Likely not an ALPS touchpad:
> > > E7=3D10 00 64, EC=3D10 00 64 [  270.388147] psmouse serio4: elant=
ech:
> > > unexpected magic knock result 0x00, 0x02, 0x64. [  271.390241]
> > > psmouse serio4: trackpoint: IBM TrackPoint firmware: 0x0e,
> > > buttons: 3/3 [  271.586156] input: TPPS/2 IBM TrackPoint as
> > > /devices/platform/i8042/serio1/serio4/input/input40
> > >=20
> > > As you can see it takes about 5 seconds to initialize TrackPoint
> > > input device. And about 3 seconds from stage after synaptics
> > > export serio device. I think this is just because of trying to
> > > detect device type. Is there any way how to speed it up? Maybe fo=
r
> > > synaptics serio devices try to probe for TPPS/2 at first?
> >=20
> > Did you abandon your trusty Dell with ALPS? ;)
> >=20
>=20
> No, I'm not going to do that :-)=20
>=20
> > Yes, I think we should limit the number of protocols that we probe =
on
> > pass-through port to standard PS/2 flavors + TPPS/2 since I have
> > never seen anything else there.
> >=20
> > Thanks.
>=20
> And If not limiting, at least changing order and preferring TPPS/2.

Umm, that is not something I'll do lightly as it may lead to
regressions: some devices are confused by other's probes and assing eve=
n
more psmouse_reset() calls will slow down boot even more.

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
