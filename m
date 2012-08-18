From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Subject: Re: [PATCH 0/7] HID: picoLCD updates
Date: Sat, 18 Aug 2012 15:48:28 +0200
Message-ID: <20120818154828.0e992bfe@neptune.home>
References: <20120818144039.0356cc7c@neptune.home>
	<Pine.LNX.4.44L0.1208180913440.17394-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay.restena.lu ([158.64.1.62]:48703 "EHLO
	smtprelay.restena.lu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754924Ab2HRNtO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 18 Aug 2012 09:49:14 -0400
In-Reply-To: <Pine.LNX.4.44L0.1208180913440.17394-100000@netrider.rowland.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org

On Sat, 18 August 2012 Alan Stern <stern@rowland.harvard.edu> wrote:
> On Sat, 18 Aug 2012, Bruno Pr=C3=A9mont wrote:
> > On Thu, 16 August 2012 Jiri Kosina <jkosina@suse.cz> wrote:
> > > On Thu, 16 Aug 2012, Bruno Pr=C3=A9mont wrote:
> > >=20
> > > > > I don't really understand this explanation. Once usb_kill_urb=
() returns,=20
> > > > > the URB should be available for future use (and therefore all=
 queues=20
> > > > > completely drained).
> > > >=20
> > > > I won't have time today to check, though my guess is that on ea=
ch
> > > > echo $usb-id > bind; echo $usb-id > unbind
> > > > under /sys/bus/hid/drivers/hid-picolcd/ the USB urb queue fills=
 a bit does
> > > > not get cleared.
> > > >=20
> > > > Is usb_kill_urb() called when unbinding just the specific hid d=
river?=20
> > >=20
> > > Yup, through hid_hw_stop() -> usbhid_stop().
> > >=20
> > > > If so my short timing between bind/unbind must be triggering so=
mething=20
> > > > else...
> > > >=20
> > > > Otherwise I'm missing something as at first time I got no "outp=
ut queue full"
> > > > messages, but as I repeated the bind/unbind sequences the print=
s per bind/unbind
> > > > iteration increased in number.
> > > >=20
> > > > Anyhow, on Friday evening/week-end I will continue digging and =
report back with my
> > > > findings.
> >=20
> > Huh, after changing some of the hid-picolcd data in order to have l=
ess racy
> > coupling between hid and framebuffer I'm now dying way too often in=
 _mmx_memcpy
> > and most of the time I don't get a (complete) trace...
>=20
> There was a similar problem reported recently.  It turned out to be=20
> caused by a __devinitconst annotation attached to a usb_device_id=20
> table.
>=20
> If there are any __devinit* annotations in the hid-picolcd driver, yo=
u=20
> should see if removing them helps.

There is no such annotation around in hid-picolcd.


One thing I just though about, how does usbhid handle the calls to
usbhid_submit_report() when hid_hw_stop()/hid_hw_close() have already
been called?
I will attempt to see if it makes a difference to shortcut my
usbhid_submit_report() calls from the point on I have called hid_hw_clo=
se()...

Bruno
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
