From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: [PATCH 6/7] IR: extend ir_raw_event and do refactoring
Date: Fri, 03 Sep 2010 00:20:54 +0300
Message-ID: <1283462454.3306.15.camel@maxim-laptop>
References: <1283158348-7429-1-git-send-email-maximlevitsky@gmail.com>
	 <1283158348-7429-7-git-send-email-maximlevitsky@gmail.com>
	 <20100902205607.GB3886@hardeman.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:33036 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754458Ab0IBVVD (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 2 Sep 2010 17:21:03 -0400
In-Reply-To: <20100902205607.GB3886@hardeman.nu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David =?ISO-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>
Cc: lirc-list@lists.sourceforge.net, Jarod Wilson <jarod@wilsonet.com>, linux-input@vger.kernel.org, linux-media@vger.kernel.org, Mauro Carvalho Chehab <mchehab@redhat.com>, Christoph Bartelmus <lirc@bartelmus.de>

On Thu, 2010-09-02 at 22:56 +0200, David H=C3=A4rdeman wrote:=20
> On Mon, Aug 30, 2010 at 11:52:26AM +0300, Maxim Levitsky wrote:
> > Add new event types for timeout & carrier report
> > Move timeout handling from ir_raw_event_store_with_filter to
> > ir-lirc-codec, where it is really needed.
>=20
> Yes, but it still might make more sense to keep the timeout handling =
in=20
> ir_raw_event_store_with_filter so that all decoders get the same data=
=20
> from rc-core?
I don't want any timeouts in rc-core. There is just an IR packet that
starts optionally with a reset and ends with a timeout bit.
I have also nothing against renaming reset/timeout to start/stop.

rc-core really shouldn't care about consistent pulse/space ordering.
Its lirc that needs it.

Also in the future I think I should make the
ir_raw_event_store_with_filter the default submit function for all
drivers, and then I could drop that silly '_with_filter" thing
(Couldn't think for a better name for this function...)

>=20
> > Now lirc bridge ensures proper gap handling.
> > Extend lirc bridge for carrier & timeout reports
> >=20
> > Note: all new ir_raw_event variables now should be initialized
> > like that:
> > struct ir_raw_event ev =3D ir_new_event;
>=20
> Wouldn't DEFINE_RAW_EVENT(ev); be more in line with the kernel coding=
=20
> style? (cf. DEFINE_MUTEX, DEFINE_SPINLOCK, etc).
Of course, nothing against that.


Best regards,
Maxim Levitsky

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
