From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/1]: input: add support for VirtualBox touchscreen
 emulation to the Lifebook driver
Date: Tue, 2 Mar 2010 14:39:47 -0800
Message-ID: <20100302223947.GC13499@core.coreip.homeip.net>
References: <1266923615.3602.85.camel@michael-laptop>
 <20100223175852.GA11301@core.coreip.homeip.net>
 <1266958533.3602.128.camel@michael-laptop>
 <20100224100206.GA5598@core.coreip.homeip.net>
 <1267011989.2831.30.camel@michael-laptop>
 <20100225101705.GF10823@core.coreip.homeip.net>
 <1267562688.2441.7.camel@michael-laptop>
 <20100302212812.GA13499@core.coreip.homeip.net>
 <1267567219.2441.12.camel@michael-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.158]:56390 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751887Ab0CBWkA (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 2 Mar 2010 17:40:00 -0500
Content-Disposition: inline
In-Reply-To: <1267567219.2441.12.camel@michael-laptop>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michael Thayer <Michael.Thayer@Sun.COM>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Mar 02, 2010 at 11:00:19PM +0100, Michael Thayer wrote:
> Le mardi 02 mars 2010 =E0 13:28 -0800, Dmitry Torokhov a =E9crit :
> > On Tue, Mar 02, 2010 at 09:44:48PM +0100, Michael Thayer wrote:
> > > it still provides a reasonable user experience until the user has=
 installed our
> > > guest drivers.
> >=20
> > It is your call but I would much rather if you worked on fixeng evd=
ev to
> > work with your virtual device rather than having to install a new X
> > driver and going through the hoops trying to detect which one shoul=
d be
> > used on a particular box. At least on Linux...
> That wouldn't really help us much here, as we are talking about distr=
ibutions
> shipping X.Org Server 1.4 and earlier, and those distributions are no=
 longer
> going to get that sort of update (in those cases in which they are st=
ill
> getting updates at all).  Legacy support if you like.
>=20

You need to distribute something... Or do these older distros already
include your guest drivers?

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
