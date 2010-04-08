From: David =?iso-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>
Subject: Re: [RFC2] Teach drivers/media/IR/ir-raw-event.c to use durations
Date: Thu, 8 Apr 2010 17:53:17 +0200
Message-ID: <20100408155317.GA21848@hardeman.nu>
References: <20100407201835.GA8438@hardeman.nu>
 <4BBD6550.6030000@infradead.org>
 <r2l9e4733911004080541s58fd4e70o215800426290a09a@mail.gmail.com>
 <4BBDD4ED.5040007@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 1-1-12-13a.han.sth.bostream.se ([82.182.30.168]:59271 "EHLO
	palpatine.hardeman.nu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932798Ab0DHPxV (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 8 Apr 2010 11:53:21 -0400
Content-Disposition: inline
In-Reply-To: <4BBDD4ED.5040007@infradead.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mauro Carvalho Chehab <mchehab@infradead.org>
Cc: Jon Smirl <jonsmirl@gmail.com>, linux-input@vger.kernel.org, linux-media@vger.kernel.org

On Thu, Apr 08, 2010 at 10:06:53AM -0300, Mauro Carvalho Chehab wrote:
> Jon Smirl wrote:
> > On Thu, Apr 8, 2010 at 1:10 AM, Mauro Carvalho Chehab
> > <mchehab@infradead.org> wrote:
> >> On the previous code, it is drivers responsibility to call the=20
> >> function that
> >> de-queue. On saa7134, I've scheduled it to wake after 15 ms. So, i=
nstead of
> >> 32 wakeups, just one is done, and the additional delay introduced =
by it is not
> >> enough to disturb the user.
> >=20
> > The wakeup is variable when the default thread is used. My quad cor=
e
> > desktop wakes up on every pulse. My embedded system wakes up about
> > every 15 pulses. The embedded system called schedule_work() fifteen
> > times from the IRQ, but the kernel collapsed them into a single
> > wakeup. I'd stick with the default thread and let the kernel get
> > around to processing IR whenever it has some time.
>=20
> Makes sense.

Given Jon's experience, it would perhaps make sense to remove=20
ir_raw_event_handle() and call schedule_work() from every call to=20
ir_raw_event_store()?

One thing less for IR drivers to care about...

--=20
David H=E4rdeman
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
