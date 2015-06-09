From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: Re: [PATCH 0/3] Switch input leds over to standard LED class devices
Date: Tue, 9 Jun 2015 16:05:06 +0200
Message-ID: <20150609140506.GD3045@type>
References: <1433799790-31873-4-git-send-email-dmitry.torokhov@gmail.com>
 <1433799790-31873-3-git-send-email-dmitry.torokhov@gmail.com>
 <1433799790-31873-1-git-send-email-dmitry.torokhov@gmail.com>
 <20150609134241.GB3045@type>
 <20150609135018.GG31071@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150609135018.GG31071@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, rpurdie@rpsys.net, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-input@vger.kernel.org

Pali Roh=E1r, le Tue 09 Jun 2015 15:50:18 +0200, a =E9crit :
> On Tuesday 09 June 2015 15:42:41 Samuel Thibault wrote:
> > Dmitry Torokhov, le Mon 08 Jun 2015 14:43:07 -0700, a =E9crit :
> > > If user wants all keyboards to light up CapsLock LED when VT stat=
e locks
> > > CtrlL modifier they need to write a udev rule or similar to set u=
p
> > > "kbd-ctrlllock" trigger for all appearing "input%::capslock" LED =
class
> > > devices.
> >=20
> > I guess console-setup's maintainer will not be happy about it.  I'd
> > say it'd be good to at least give examples how to do it in the
> > documentation.
>=20
> What about CC relevant people who maintains those userspace packages?

I'll write him, yes.  Just give me time to do it :)

Samuel
