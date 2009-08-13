From: David =?iso-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>
Subject: Re: [PATCH] Add EV_IR bit
Date: Thu, 13 Aug 2009 10:32:16 +0200 (CEST)
Message-ID: <b8f9be4c2061560d4abe638f0ce91949.squirrel@www.hardeman.nu>
References: <20090812223327.GA6827@hardeman.nu>
    <20090813072023.7BCC9526EC9@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 1-1-12-13a.han.sth.bostream.se ([82.182.30.168]:45446 "EHLO
	palpatine.hardeman.nu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752935AbZHMIcP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 13 Aug 2009 04:32:15 -0400
In-Reply-To: <20090813072023.7BCC9526EC9@mailhub.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

On Thu, August 13, 2009 08:49, Dmitry Torokhov wrote:
> On Thu, Aug 13, 2009 at 12:33:27AM +0200, David H=E4rdeman wrote:
>> This patch adds an EV_IR bit to allow input drivers to let userspace
>> know that the hardware is an infrared remote control transceiver.
>>
>> No dev->irbit is defined yet but I plan to add that later (which wou=
ld
>> be used to indicate whether the hardware supports RX, TX, etc).
>>
>> If the patch is accepted I'll send followup patches adding the
>> appropriate input_set_capability call to the relevant drivers.
>>
>
> Do you expect devices to actually _send_ EV_IR events?

Yes, and I have some patches going in that direction (loosely based on =
Jon
Smirl's in-kernel IR driver patchset).

The basic idea so far would be to add:

IR_PROTOCOL
IR_TOGGLE
IR_DEVICE
IR_SUBDEVICE
IR_COMMAND

Which should be sufficient at this point for the major IR protocols. Th=
en
input drivers can report to userspace the actual command they received
(and hacks like using MSC_SCAN / MSC_RAW / the sysfs attribute you
commented in my winbond-cir driver would not be necessary).

It also allows userspace to know that a button was pressed even where
there is no keymap for that particular remote which should help a lot i=
n
building custom keymaps.

=46urther along we might also add IR_RAW to signal to willing user-spac=
e
apps the raw IR timings for more esoteric remotes (I guess it would nee=
d
to be enabled/disabled by an ioctl).

--=20
David H=E4rdeman

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
