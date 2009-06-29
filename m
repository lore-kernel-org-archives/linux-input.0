From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] PCAP touchscreen driver (for 2.6.32)
Date: Sun, 28 Jun 2009 23:19:55 -0700
Message-ID: <20090629061955.GE12821@dtor-d630.eng.vmware.com>
References: <1246122138.3727.12.camel@brutus> <5d5443650906280015x4bddefa5v9dd36f888c5f2e92@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f190.google.com ([209.85.216.190]:44527 "EHLO
	mail-px0-f190.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750725AbZF2GT5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 29 Jun 2009 02:19:57 -0400
Content-Disposition: inline
In-Reply-To: <5d5443650906280015x4bddefa5v9dd36f888c5f2e92@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Trilok Soni <soni.trilok@gmail.com>
Cc: Daniel Ribeiro <drwyrm@gmail.com>, linux-input@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, openezx-devel <openezx-devel@lists.openezx.org>, Harald Welte <laforge@gnumonks.org>, Samuel Ortiz <sameo@linux.intel.com>

On Sun, Jun 28, 2009 at 12:45:17PM +0530, Trilok Soni wrote:
> Hi Daniel,
>=20
> 2009/6/27 Daniel Ribeiro <drwyrm@gmail.com>:
> > +
> > + =A0 =A0 =A0 err =3D request_irq(pcap_to_irq(pcap_ts->pcap, PCAP_I=
RQ_TS),
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pcap_ts_event_touch, =
0, "Touch Screen", pcap_ts);
> > + =A0 =A0 =A0 if (err)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail;
> > +
> > + =A0 =A0 =A0 err =3D input_register_device(pcap_ts->input);
> > + =A0 =A0 =A0 if (err)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail_touch;
>=20
> Please move request_irq after input_register_device, as IRQ can get
> fired before input device gets available, right?
>=20

Actually it is OK to have IRQs fired before the device is registered.
Input core guarantees that input device allocated with
input_allocate_device() will survive if events are sent through it. The
events will not be delivered anywhere, for obvious reason, but
everything else should be fine. In fact, if device has an event()
handler then it has to be fully operational (that includes IRQ reserved
and ready, unless the driver implements open/close methods) before
calling input_register_device - the handlers that will attach to the
device have every right to start sending events back to the device righ=
t
away and expect them to be handled properly.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
