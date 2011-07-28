From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] [PATCH v3 1/2] Input: enable i8042-level wakeup
 control
Date: Thu, 28 Jul 2011 11:45:21 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1107281136360.1990-100000@iolanthe.rowland.org>
References: <CAGq3pz6J2pma1TxcqUreQ-qi37Tk4VU15uAvH1=dwyAAvxAPLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:52002 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754694Ab1G1PpW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 28 Jul 2011 11:45:22 -0400
In-Reply-To: <CAGq3pz6J2pma1TxcqUreQ-qi37Tk4VU15uAvH1=dwyAAvxAPLg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: dtor@mail.ru, dmitry.torokhov@gmail.com, linux-pm@lists.linux-foundation.org, dilinger@queued.net, linux-input@vger.kernel.org

On Thu, 28 Jul 2011, Daniel Drake wrote:

> On 28 July 2011 16:08, Alan Stern <stern@rowland.harvard.edu> wrote:
> > Aren't there? =A0I have no idea. =A0But if input devices are never
> > wakeup-capable, why do you name your function "input_may_wakeup()"?
>=20
> I guess i8042_may_wakeup() would be a better name for it. In this
> case, the only device in the hierarchy (i8042 -> serio -> input) that
> is marked wakeup capable is the i8042 device (and only via my
> patches). I'd welcome a better design.

My experience in this area is _extremely_ limited.  Take a look at
commits b14e033e17d0ea0ba (PNPACPI: Add support for remote wakeup) and=20
3e6e15a862a0bc201 (Input: enable remote wakeup for PNP i8042 keyboard=20
ports).

> > I'm using a normal PC with PS/2 mouse and keyboard. =A0It is set up=
 with
> > the keyboard as a wakeup source but not the mouse. =A0Of course, th=
is
> > uses ACPI, which I assume isn't present on OLPC.
>=20
> It does depend on how the system is designed, yes. I suspect that the
> device that is actually marked as wakeup capable on your setup is not
> an input device, but rather another part of the /sys tree (perhaps
> part of the ACPI tree?).

It is the PNP keyboard device (whichever that is!), enabled by the
second commit above.

> Also, I suspect that if your system is woken
> up by the keyboard, it loses the keypress which was used to wake it
> up.

Could be; I don't recall ever having tested this.

> I'm definitely open to better ways of doing this. The key considerati=
ons are:
> 1. We only have control over wakeups at the i8042 level; i.e. we
> cannot ask for keyboard wakeups but not mouse.
> 2. Our keyboard and mouse hardware is guaranteed to be powered
> throughout suspend
> 3. The key press or mouse movement or click that woke the system must
> not be lost during resume. This means that all 3 layers (i8042, serio=
,
> input) must not reset or really do anything with the device during
> suspend/resume.

At this point I have reached my level of incompetence... so I'll shut=20
up now.  :-)

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
