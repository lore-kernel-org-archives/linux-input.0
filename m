From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Add EV_IR bit
Date: Thu, 13 Aug 2009 08:57:45 -0700
Message-ID: <20090813162830.674A4526EC9@mailhub.coreip.homeip.net>
References: <20090812223327.GA6827@hardeman.nu> <20090813072023.7BCC9526EC9@mailhub.coreip.homeip.net> <b8f9be4c2061560d4abe638f0ce91949.squirrel@www.hardeman.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.233]:28611 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754158AbZHMP5t (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 13 Aug 2009 11:57:49 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1509683rvb.5
        for <linux-input@vger.kernel.org>; Thu, 13 Aug 2009 08:57:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <b8f9be4c2061560d4abe638f0ce91949.squirrel@www.hardeman.nu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David =?iso-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>
Cc: linux-input@vger.kernel.org

On Thu, Aug 13, 2009 at 10:32:16AM +0200, David H=E4rdeman wrote:
> On Thu, August 13, 2009 08:49, Dmitry Torokhov wrote:
> > On Thu, Aug 13, 2009 at 12:33:27AM +0200, David H=E4rdeman wrote:
> >> This patch adds an EV_IR bit to allow input drivers to let userspa=
ce
> >> know that the hardware is an infrared remote control transceiver.
> >>
> >> No dev->irbit is defined yet but I plan to add that later (which w=
ould
> >> be used to indicate whether the hardware supports RX, TX, etc).
> >>
> >> If the patch is accepted I'll send followup patches adding the
> >> appropriate input_set_capability call to the relevant drivers.
> >>
> >
> > Do you expect devices to actually _send_ EV_IR events?
>=20
> Yes, and I have some patches going in that direction (loosely based o=
n Jon
> Smirl's in-kernel IR driver patchset).
>=20
> The basic idea so far would be to add:
>=20
> IR_PROTOCOL
> IR_TOGGLE
> IR_DEVICE
> IR_SUBDEVICE
> IR_COMMAND
>=20
> Which should be sufficient at this point for the major IR protocols. =
Then
> input drivers can report to userspace the actual command they receive=
d
> (and hacks like using MSC_SCAN / MSC_RAW / the sysfs attribute you
> commented in my winbond-cir driver would not be necessary).
>=20
> It also allows userspace to know that a button was pressed even where
> there is no keymap for that particular remote which should help a lot=
 in
> building custom keymaps.
>=20
> Further along we might also add IR_RAW to signal to willing user-spac=
e
> apps the raw IR timings for more esoteric remotes (I guess it would n=
eed
> to be enabled/disabled by an ioctl).
>

Would you mind posting the complete patchset?

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
