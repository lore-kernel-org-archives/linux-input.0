From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/5] qt602240_ts: move clearing of pending interrupt
 closer to request_threaded_irq
Date: Thu, 18 Nov 2010 14:54:12 -0800
Message-ID: <20101118225412.GA732@core.coreip.homeip.net>
References: <20101116203914.28796.23141.stgit@localhost6.localdomain6>
 <20101116204155.28796.6682.stgit@localhost6.localdomain6>
 <4CE521B9.9070509@samsung.com>
 <20101118192902.GE1273@cleech-lnx.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:44053 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760363Ab0KRWyT (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 18 Nov 2010 17:54:19 -0500
Received: by gyh4 with SMTP id 4so2288546gyh.19
        for <linux-input@vger.kernel.org>; Thu, 18 Nov 2010 14:54:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101118192902.GE1273@cleech-lnx.jf.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chris Leech <christopher.leech@linux.intel.com>
Cc: Joonyoung Shim <jy0922.shim@samsung.com>, linux-input@vger.kernel.org

On Thu, Nov 18, 2010 at 11:29:02AM -0800, Chris Leech wrote:
> On Thu, Nov 18, 2010 at 09:53:13PM +0900, Joonyoung Shim wrote:
> > Hi, Chris.
> >
> > On 2010-11-17 =EC=98=A4=EC=A0=84 5:41, Chris Leech wrote:
> >> I've seen interrupts asserted on the CHG pin between the call to m=
ake_highcgh()
> >> during initialization and registering the interrupt handler, leavi=
ng CHG low
> >> and no events get passed up.
> >>
> >
> > The CHG pin can be affected by control of gpios connected to touch
> > chip. Could you check it? I think it doesn't matter where
> > make_highchg() exists actually.
>=20
> My understanding is that CHG is to be used to trigger interrupts, and
> the attached gpio should be set as an input.  I'm not sure trying to =
set
> the value from the gpio side is going to work.
>=20
> The problem I was seeing was the attached gpio configured as a
> falling-edge-triggered interrupt stuck in the low state, and
> qt602240_interrupt is never called.  What that says to me is that CHG
> transitioned low before the interrupt handler was registered.  From w=
hat
> I can see, the only way to reset CHG is to clear the queue of pending
> messages, which is what make_highchg does.
>=20

I wonder if it should actually go into qt602240_start().

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
