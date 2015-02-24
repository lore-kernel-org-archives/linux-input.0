From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Add a quirk for the Dell XPS 13 (2015) when in PS/2 mode.
Date: Mon, 23 Feb 2015 16:51:09 -0800
Message-ID: <20150224005109.GD604@dtor-glaptop>
References: <1424310180-2512-1-git-send-email-mario_limonciello@dell.com>
 <201502202141.16017@pali>
 <54E7A567.5030501@dell.com>
 <201502221755.05587@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201502221755.05587@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Mario Limonciello <mario_limonciello@dell.com>, LKML <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Rob <robr.bensson@gmail.com>
List-Id: linux-input@vger.kernel.org

On Sun, Feb 22, 2015 at 05:55:05PM +0100, Pali Roh=E1r wrote:
> On Friday 20 February 2015 22:21:43 Mario Limonciello wrote:
> > On 02/20/2015 02:41 PM, Pali Roh=E1r wrote:
> > > On Friday 20 February 2015 20:56:23 Mario Limonciello wrote:
> > > I have BIOS version A05 on my E6440 machine. That version
> > > does not have problems with "repeating keys" and my
> > > workaround for ALPS touchpad (which is in mainline tree and
> > > -stable trees now) works fine. If I do not see other
> > > problems, I will not update BIOS (just because current
> > > version working -- with workarounds).
> > >=20
> > > But CCing Rob. He told me as first about existence of new
> > > BIOS version for E6440 and he is already testing new
> > > version of BIOS, so can share details.
> > >=20
> > > Mario, can you share some details about that new BIOS
> > > update? If it is not secret, how was problem with
> > > "repeating keys" fixed? Why linux had more problems as
> > > Windows? Cannot we implement some "workaround" in linux
> > > kernel to prevent that (or similar) problems in future?
> >=20
> > It's a bit ironic really.  The problem was introduced because
> > a timer was added to the EC last year to fix a key repeating
> > problem found on Windows.  In doing so the EC was blocking
> > "BREAK" from being sent to the OS.  Windows OS didn't mind
> > this, but Linux did. The fix doesn't block BREAK anymore.
> >=20
>=20
> Thank you for information!
>=20
> Mario, do you know if it is possible to "switch" keyboard into=20
> mode under which Fn key will send scancode (like Ctrl or Alt)=20
> when presses, so it could be possible to use any Fn+key=20
> combination for keyboard shortcuts? Because now Fn+F* send one=20
> scancode (e.g. suspend key) and other combination of Fn+something=20
> does not work...
>=20
> Dmitry, should not Linux follow this Windows input behaviour? For=20
> year we have seen people complaining about non working keyboard=20
> on Dell laptops under Linux (when user Windows it worked)...

I am not sure what exactly the issue is... We do need to have the break
code to know when the key is released. We can't go and say that we will
release old key when we detect another key press as that would mess up
key combination handling (like control, meta, etc).

What does Windows driver do?=20

Thanks.

--=20
Dmitry
