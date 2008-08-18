From: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: PROBLEM: USB keyboards works only 4 per PC host port
Date: Mon, 18 Aug 2008 08:14:32 -0700
Message-ID: <20080818081432.782d9632.rdunlap@xenotime.net>
References: <200808080702.24969.aivils@latnet.lv>
	<200808100408.37473.aivils@latnet.lv>
	<20080814184948.093d2cad.rdunlap@xenotime.net>
	<200808181642.49489.aivils@latnet.lv>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:57628 "HELO xenotime.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750907AbYHRPOC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 18 Aug 2008 11:14:02 -0400
Received: from chimera.site ([72.90.117.230]) by xenotime.net for <linux-input@vger.kernel.org>; Mon, 18 Aug 2008 08:13:56 -0700
In-Reply-To: <200808181642.49489.aivils@latnet.lv>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Aivils Stoss <aivils@latnet.lv>
Cc: lud <linux-usb@vger.kernel.org>, Samuel Thibault <samuel.thibault@ens-lyon.org>, linux-input@vger.kernel.org, jkosina@suse.cz, linux-kernel@vger.kernel.org, linuxconsole-dev@lists.sourceforge.net

On Mon, 18 Aug 2008 16:42:49 +0530 Aivils Stoss wrote:

> On Friday 15 August 2008 7:19:48 am Randy Dunlap wrote:
> > On Sun, 10 Aug 2008 04:08:37 +0100 Aivils Stoss wrote:
> > > On Saturday 09 August 2008 11:42:26 am Samuel Thibault wrote:
> > > > Aivils Stoss, le Fri 08 Aug 2008 07:02:24 +0100, a =E9crit :
> > > > > I suppose this is Linux kernel bug because i test keyboards u=
nder
> > > > > Windows, which support any schema of cascading of usb hubs.
> > > >
> > > > On the very same machine and hubs?
> > >
> > > Yes, on same machine. Under Windows i don't have evdev interface,
> > > checked only how keypress go to console.
> > > Of course to repeat a try You must have at least 5 keyboards and
> > > 1 7-port or 2 4-port hubs and kernel 2.6.22 and above. I allways
> > > got result - 5th, 6th, 7th keyboard does not send events to conso=
le
> > > or evdev.
> >
> > [adding linux-usb mailing list]
> >
> > Hi,
> >
> > I finally got 5 USB keyboards together along with 2 hubs.
> > I daisy-chained the hubs and connected 1 keyboard to the hub that i=
s
> > on the notebook computer USB port, then I connected 4 keyboards to =
the
> > second hub.  They all worked for me, meaning that I can type on all=
 of
> > them and have their characters show up on my console.
> >
> > I'm testing with 2.6.7-rc2.
> > 'usbtree' output of the USB subsystem is attached.
>=20
> Yeah! 2.6.7 is a bit obsolete. At my end 2.6.15 support more than 4
> keyboards per PC port , but mess up input when is plugged more than
> 9 keyboards. 10th is capable to send keypress events, but last presse=
d
> key will be repeated until ctrl-c . 10th keyboard disturb an auto rep=
eat of=20
> all keyboards.

Sorry, my keyboard made a typo.  I'm testing with 2.6.27-rc2.

So the problem is now different from your original report, right?


What speed is the host port that the keyboards are connected to?
Could it be a USB bus bandwidth limitation?  (not that any code
checks for that)

I barely found 5 USB keyboards, so I surely can't test 10 or more.  ;)
I suppose that it will take some USB debug messages to attempt to see
what is going on...


---
~Randy
Linux Plumbers Conference, 17-19 September 2008, Portland, Oregon USA
http://linuxplumbersconf.org/
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
