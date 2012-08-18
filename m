From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 0/7] HID: picoLCD updates
Date: Sat, 18 Aug 2012 09:19:12 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1208180913440.17394-100000@netrider.rowland.org>
References: <20120818144039.0356cc7c@neptune.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:52227 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754868Ab2HRNTN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 18 Aug 2012 09:19:13 -0400
In-Reply-To: <20120818144039.0356cc7c@neptune.home>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org

On Sat, 18 Aug 2012, Bruno Pr=C3=A9mont wrote:

> Hi Jiri,
>=20
> [CCing Alan Stern]
>=20
> On Thu, 16 August 2012 Jiri Kosina <jkosina@suse.cz> wrote:
> > On Thu, 16 Aug 2012, Bruno Pr=C3=A9mont wrote:
> >=20
> > > > I don't really understand this explanation. Once usb_kill_urb()=
 returns,=20
> > > > the URB should be available for future use (and therefore all q=
ueues=20
> > > > completely drained).
> > >=20
> > > I won't have time today to check, though my guess is that on each
> > > echo $usb-id > bind; echo $usb-id > unbind
> > > under /sys/bus/hid/drivers/hid-picolcd/ the USB urb queue fills a=
 bit does
> > > not get cleared.
> > >=20
> > > Is usb_kill_urb() called when unbinding just the specific hid dri=
ver?=20
> >=20
> > Yup, through hid_hw_stop() -> usbhid_stop().
> >=20
> > > If so my short timing between bind/unbind must be triggering some=
thing=20
> > > else...
> > >=20
> > > Otherwise I'm missing something as at first time I got no "output=
 queue full"
> > > messages, but as I repeated the bind/unbind sequences the prints =
per bind/unbind
> > > iteration increased in number.
> > >=20
> > > Anyhow, on Friday evening/week-end I will continue digging and re=
port back with my
> > > findings.
>=20
> Huh, after changing some of the hid-picolcd data in order to have les=
s racy
> coupling between hid and framebuffer I'm now dying way too often in _=
mmx_memcpy
> and most of the time I don't get a (complete) trace...

There was a similar problem reported recently.  It turned out to be=20
caused by a __devinitconst annotation attached to a usb_device_id=20
table.

If there are any __devinit* annotations in the hid-picolcd driver, you=20
should see if removing them helps.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
