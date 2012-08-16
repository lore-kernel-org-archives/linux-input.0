From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Subject: Re: [PATCH 0/7] HID: picoLCD updates
Date: Thu, 16 Aug 2012 18:30:21 +0200
Message-ID: <20120816183021.68c37f37@neptune.home>
References: <20120730213656.0a9f6d30@neptune.home>
	<alpine.LNX.2.00.1208151016221.7026@pobox.suse.cz>
	<20120815114236.0f7db40e@neptune.home>
	<alpine.LNX.2.00.1208151409500.7026@pobox.suse.cz>
	<20120815171635.2564a4a8@neptune.home>
	<alpine.LNX.2.00.1208152329580.7026@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay.restena.lu ([158.64.1.62]:43674 "EHLO
	smtprelay.restena.lu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932942Ab2HPQbH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 16 Aug 2012 12:31:07 -0400
In-Reply-To: <alpine.LNX.2.00.1208152329580.7026@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org

On Wed, 15 August 2012 Jiri Kosina <jkosina@suse.cz> wrote:
> On Wed, 15 Aug 2012, Bruno Pr=C3=A9mont wrote:
> > > I see. Alan Stern has fixed a huge pile of things in this area in=
 3.6-rc1.=20
> > > I have expected all of those to actually be on theoretical proble=
ms not=20
> > > ever having happened in the wild, but it might be that you are ac=
tually=20
> > > chasing on of those.
> > >
> > > Could you please retest with latest Linus' tree (or at least eb05=
5fd0560b)=20
> > > to see whether this hasn't actually been fixed already by Alan's =
series?
> >=20
> > I've started trying that out, it seems Alan's work improved things.
> >=20
> > For the first few attempts I have not seen SLAB corruptions, though=
 after
> > a few rounds I hit accumulation of the following messages:
> > [  297.174828] hid-picolcd 0003:04D8:C002.0003: output queue full
> > [  297.181098] hid-picolcd 0003:04D8:C002.0003: output queue full
> > [  297.187820] hid-picolcd 0003:04D8:C002.0003: output queue full
> > [  297.194087] hid-picolcd 0003:04D8:C002.0003: output queue full
> >=20
> > with sporadically in between:
> > [  292.668019] hid-picolcd 0003:04D8:C002.0003: usb_submit_urb(out)=
 failed: -1
> >=20
> > At first glance I think the queue filling up and never draining is =
caused
> > by hid_hw_stop() stalling the queue and the time between both being=
 just too
> > short.
>=20
> I don't really understand this explanation. Once usb_kill_urb() retur=
ns,=20
> the URB should be available for future use (and therefore all queues=20
> completely drained).

I won't have time today to check, though my guess is that on each
echo $usb-id > bind; echo $usb-id > unbind
under /sys/bus/hid/drivers/hid-picolcd/ the USB urb queue fills a bit d=
oes
not get cleared.

Is usb_kill_urb() called when unbinding just the specific hid driver? I=
f so
my short timing between bind/unbind must be triggering something else..=
=2E

Otherwise I'm missing something as at first time I got no "output queue=
 full"
messages, but as I repeated the bind/unbind sequences the prints per bi=
nd/unbind
iteration increased in number.

Anyhow, on Friday evening/week-end I will continue digging and report b=
ack with my
findings.

Thanks,
Bruno
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
