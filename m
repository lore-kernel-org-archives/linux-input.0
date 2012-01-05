From: simon@mungewell.org
Subject: Re: How to physically rotate the joystick wheel through the
 code/terminal.
Date: Thu, 5 Jan 2012 10:07:37 -0500
Message-ID: <c66035e82efa0d09c54a1cec3f06cfae.squirrel@mungewell.org>
References: <CAM1yFZ9kHjJBhWH3NFTTaOJ3NdBYMH599U0=FXZ_AQVsYoJkUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:38773 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754399Ab2AEPHi (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 5 Jan 2012 10:07:38 -0500
In-Reply-To: <CAM1yFZ9kHjJBhWH3NFTTaOJ3NdBYMH599U0=FXZ_AQVsYoJkUQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Anisha Kaul <born.rebel.83@gmail.com>
Cc: linux-input@vger.kernel.org

> I wish to physically rotate the joystick wheel through the code/termi=
nal.
> I mean if I run a command, the wheel should rotate to the left/right.
>
> I looked in
> here:=A0http://www.mjmwired.net/kernel/Documentation/input/ff.txt
>
> Is ioctl() system call as shown in the above link appropriate for the=
 task
> or I am barking at the wrong tree?
>
> Any hints on how to achieve this from userspace?

Hi Anisha,
You don't mention which distro you are on, but some/most have a test
application 'ffcfstress' which cycles the position of a wheel/joystick.

There is a 'spring force' which has an adjustable center, but most whee=
ls
don't support this. 'ffcfstress' uses a 'constant force' (to the left o=
r
right) and monitors the position of the wheel.

Thus using a control loop it modulates the amount of force, lowering it=
 as
the wheel approaches it's target.

If you don't want to use the icotl interface, then you could look at a
userspace lib such as SDL1.3 which (mostly) supports ForceFeedback.

Cheers,
Simon

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
