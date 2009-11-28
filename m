From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [RFC] What are the goals for the architecture of an in-kernel IR
	system?
Date: Sat, 28 Nov 2009 12:37:40 -0500
Message-ID: <9e4733910911280937k37551b38g90f4a60b73665853@mail.gmail.com>
References: <m3r5riy7py.fsf@intrepid.localdomain> <BDkdITRHqgB@lirc>
	 <9e4733910911280906if1191a1jd3d055e8b781e45c@mail.gmail.com>
	 <m3aay6y2m1.fsf@intrepid.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.26]:45524 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752878AbZK1Rhi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 28 Nov 2009 12:37:38 -0500
In-Reply-To: <m3aay6y2m1.fsf@intrepid.localdomain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: Christoph Bartelmus <lirc@bartelmus.de>, awalls@radix.net, dmitry.torokhov@gmail.com, j@jannau.net, jarod@redhat.com, jarod@wilsonet.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, maximlevitsky@gmail.com, mchehab@redhat.com, stefanr@s5r6.in-berlin.de, superm1@ubuntu.com

On Sat, Nov 28, 2009 at 12:35 PM, Krzysztof Halasa <khc@pm.waw.pl> wrot=
e:
> Jon Smirl <jonsmirl@gmail.com> writes:
>
>> There are two very basic things that we need to reach consensus on f=
irst.
>>
>> 1) Unification with mouse/keyboard in evdev - put IR on equal footin=
g.
>> 2) Specific tools (xmodmap, setkeycodes, etc or the LIRC ones) or
>> generic tools (ls, mkdir, echo) for configuration
>
> I think we can do this gradually:
> 1. Merging the lirc drivers. The only stable thing needed is lirc
> =A0 interface.

Doing that locks in a user space API that needs to be supported
forever. We need to think this API through before locking it in.

> 2. Changing IR input layer interface ("media" drivers and adding to l=
irc
> =A0 drivers).
> --
> Krzysztof Halasa
>



--=20
Jon Smirl
jonsmirl@gmail.com
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
